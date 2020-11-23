"""
MIT License

Copyright (c) 2020 Alejandro Daniel Noel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

"""
Current limitations
    - If two headers have the same text in the same file, their latex labels will be the same
    - Parentheses around citations in markdown are not removed
    - Multi-line equations cannot have multiple labels
    - No side-by side figures
    - Tables are currently commented
    - Tables in markdown need to have | over the left side to be detected by the parser
"""

import re

IMAGE_COMMAND = 'latex figure:'
EQUATION_COMMAND = 'eq:'


def is_citation_key(string):
    return bool(re.search(r'(18|19|20)\d{2}', string))


def is_ref_to_label(string):
    return ' ' not in string and ':' in string


def is_image_command(string):
    return IMAGE_COMMAND in string.lower() and '####' in string


def is_equation_command(string):
    return EQUATION_COMMAND in string.lower() and '####' in string and string.strip().count(' ') < 2


def make_header_label(string, doc_name=''):
    return 'sec:' + re.sub(r'[-:\s]', '_', string.strip()) + (f'__{doc_name}' if doc_name != '' else '')


def parse_image_command(string: str):
    if is_image_command(string):
        s = string.split(':')[1]
    else:
        s = string
    tokens = s.strip().split(' ')
    if len(tokens) == 0:
        print(f'ERROR: bad image command > {string}')
    file_name = tokens[0].strip()
    width = None

    if len(tokens) > 1: # Process additional tokens
        for token in tokens[1:]:
            if 'w=' in token[0:2]:
                width = token.replace('w=', '').strip()

    return {"file_name": file_name, "width": width}


class Image:
    def __init__(self, image_file_in_latex='', label='', caption='', img_dir='', width=None):
        self.image_file_in_latex = image_file_in_latex
        self.label = label
        self.caption = caption
        self.img_dir = img_dir
        self.width = width or '0.5'

    def get_text(self):
        return '\\begin{figure}[H]\n' +\
                    '\t\centering\n' +\
                    '\t\includegraphics[width=%s\linewidth]{%s}\n' % (self.width, (self.img_dir + self.image_file_in_latex)) +\
                    '\t\caption{%s}\n' % self.caption +\
                    '\t\label{%s}\n' % self.label +\
                '\end{figure}\n\n'


def parse(text, latex_images_dir, headers=(), latex_filename=''):
    if issubclass(str, type(text)):
        text = text.splitlines()
    text.append('\n') # Add an empty line at the end, fixes bugs where environments don't close because they are at the end

    lines_to_delete = []
    labels_to_define = []
    in_equation = False
    in_meta = False
    meta_processed = False
    in_blockquote = False
    in_image = False
    current_image = None
    images = {}
    footnotes = {}
    equation_labels = []
    current_equation_label = None

    # FIRST PASS (scan and inplace replacements)
    for i, line in enumerate(text):
        # PROCESS meta (remove from Latex)
        if line.strip() == '---' and in_meta:
            meta_processed = True
            in_meta = False

        if in_meta:
            lines_to_delete.append(i)

        # PROCESS separators --- (remove from Latex)
        if line.strip() == '---':
            lines_to_delete.append(i)

        # PROCESS HEADERS
        if line[0:2] == '# ':
            line = line.replace('# ', '').strip()
            line = r'\chapter{' + line + '}\n\\label{' + make_header_label(line, latex_filename) + '}\n'
            in_meta = not meta_processed
        elif line[0:3] == '## ':
            line = line.replace('## ', '').strip()
            line = r'\section{' + line + '}\n\\label{' + make_header_label(line, latex_filename) + '}\n'
        elif line[0:4] == '### ':
            line = line.replace('### ', '').strip()
            line = r'\subsection{' + line + '}\n\\label{' + make_header_label(line, latex_filename) + '}\n'
        elif line[0:5] == '#### ':
            if is_image_command(line):
                in_image = True
                img_args = parse_image_command(line)
                current_image = Image(image_file_in_latex=latex_images_dir + img_args['file_name'], width=img_args['width'])
            elif is_equation_command(line):
                current_equation_label = line.replace('#### ', '').strip()
            lines_to_delete.append(i)
            continue

        # PROCESS references in `·`
        for match in re.findall(r'`(.*?)`', line):
            if is_ref_to_label(match) and in_image and line.find(match) == 1:
                continue    # This is an image label, not a reference

            if is_citation_key(match):
                line = line.replace(f'`{match}`', r'\cite{' + match + '}')
            elif is_ref_to_label(match):
                labels_to_define.append(match)
                line = line.replace(f'`{match}`', r'\autoref{' + match + '}')
            else:
                line = line.replace(f'`{match}`', r'\hl{' + match + '}')

        # PROCESS references in [[·]]
        if len(re.findall(r'!\[{2}(.*?)]{2}', line)) == 1:
            lines_to_delete.append(i) # Remove line because it has an image in markdown
            continue

        for match in re.findall(r'\[{2}(.*?)]{2}', line):
            if is_citation_key(match):
                line = line.replace(f'[[{match}]]', r'\cite{' + match + '}')
            elif match.split('#')[-1].strip() in headers.keys():
                line = line.replace(f'[[{match}]]', r'\autoref{' + headers[match.split('#')[-1].strip()] + '}')
            else:
                line = line.replace(f'[[{match}]]', r'\hl{' + match + '}')

        # PROCESS bold
        for match in re.findall(r'\*{2}(.*?)\*{2}', line):
            if len(match.strip()) > 0:
                line = line.replace(f'**{match}**', r'\textbf{' + match + '}')

        # PROCESS italics
        for match in re.findall(r'\*([^*]*?)\*', line):
            if len(match.strip()) > 0:
                line = line.replace(f'*{match}*', r'\textit{' + match + '}')

        # PROCESS highlights
        for match in re.findall(r'={2}(.*?)={2}', line):
            if len(match.strip()) > 0:
                line = line.replace(f'=={match}==', r'\hl{' + match + '}')

        # PROCESS equations
        if line.strip() == '$$':
            if not in_equation:
                line = r'\begin{equation}' + ('\n\\label{'+current_equation_label+r'}' if current_equation_label else '') + '\n'
                equation_labels.append(current_equation_label)
                in_equation = True
            else:
                line = '\\end{equation}\n'
                in_equation = False
                current_equation_label = None

        if in_equation and line.strip().find(r'\label{') == 0:   # collect labels
            equation_labels.append(line.replace(r'\label{', '').replace('}', '').strip())
            lines_to_delete.append(i)

        # PROCESS quotes
        if line[0] == '>':
            in_blockquote = True
            line = '\\begin{displayquote}\n' + line[1:]

        if line.strip() == '' and in_blockquote:
            in_blockquote = False
            line = '\\end{displayquote}\n\n'

        # PROCESS tables (comment them out in Latex)
        if line[0] == '|':
            line = '% ' + line

        # PROCESS remaining illegal characters in latex (highlight them in Latex)
        if not in_equation:
            tmp = line.split('$')
            for j, block in enumerate(tmp):
                in_inline_math = bool(j % 2)
                if not in_inline_math:
                    block = block.replace('[^', '§§§').replace('^', r'\hl{\^}').replace('§§§', '[^') # ignore footnote marks [^
                    block = block.replace('#', r'\#')
                tmp[j] = block
            line = '$'.join(tmp)

        # COLLECT footnotes (to replace in a second pass)
        match = re.findall(r'^\[\^(.*?)]', line)
        if len(match) > 0:
            footnotes[match[0]] = line.replace(f'[^{match[0]}]:', '')
            lines_to_delete.append(i)

        # COLLECT images (to replace in a second pass)
        if in_image:
            if line.strip() == '':
                line = '#IMAGE: ' + current_image.label
                images[current_image.label] = current_image
                in_image = False
                current_image = None
            else:
                tmp = re.findall(r'^`(.*?)`', line)
                if len(tmp) != 1:
                    print(f'\tPARSE ERROR: caption of image {current_image.image_file_in_latex} in line {i}')
                else:
                    current_image.label = tmp[0]
                    current_image.caption = line.replace(f'`{tmp[0]}`: ', '')
                lines_to_delete.append(i)

        text[i] = line

    # CLEAN LINES MARKED FOR DELETION
    text = [line for i, line in enumerate(text) if i not in lines_to_delete]

    # SECOND PASS (block replacements)
    for i, line in enumerate(text):
        # REPLACE footnotes
        for match in re.findall(r'\[\^(.*?)]', line):
            line = line.replace(f'[^{match}]', r'\footnote{' + footnotes[match] + r'}')

        # REPLACE images
        if line.find('#IMAGE: ') == 0:
            line = images[line.replace('#IMAGE: ', '')].get_text()

        # JOIN consecutive citations
        citation_groups = re.findall(r'(?:\\cite{\w*?}[,\s]{,2}){2,}', line) # Find consecutive citations
        for citation_group in citation_groups:
            reformatted = re.sub(r'[,\s]{,2}', '', citation_group) # remove separations (commas and spaces)
            reformatted = reformatted.replace('}\cite{', ', ')
            line = line.replace(citation_group, reformatted)

        text[i] = line

    undefined_labels = (set(labels_to_define) - set(images.keys())) - set(equation_labels)
    if len(undefined_labels) > 0:
        print('\tThe following labels need to be defined:')
        for label in undefined_labels:
            print(f'\t\t{label}')

    return text


def scan_headers(text, latex_filename='', markdown_filename=''):
    if issubclass(str, type(text)):
        text = text.splitlines()

    headers = {}
    for i, line in enumerate(text):
        # PROCESS HEADERS
        if line[0:2] == '# ':
            line = line.replace('# ', '').strip()
            headers[line] = make_header_label(line, latex_filename)
            if markdown_filename != '':
                headers[markdown_filename] = make_header_label(line, latex_filename) # So that references to files in obsidian also work
        elif line[0:3] == '## ':
            line = line.replace('## ', '').strip()
            headers[line] = make_header_label(line, latex_filename)
        elif line[0:4] == '### ':
            line = line.replace('### ', '').strip()
            headers[line] = make_header_label(line, latex_filename)

    return headers
