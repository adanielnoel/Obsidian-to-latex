"""
BLOCKS
- Sections
- Paragraph (incl. inline math)
- Equations
- Figures
- Lists
- Quotes
- Footnotes
- Tables?

FORMATTING
- Italics
- Bold
- Highlights
- Code
- Illegal characters (~, %, #, etc)

LINKING
- Referencing
- Citations

META
- Commands

"""
from parser_utils import to_blocks, format_text
import re


class Block:
    def __init__(self, content):
        self.content = content
        self.parent = None  # Only Section and Project objects can be parents

    def formatted_text(self):
        # Do basic formatting
        text_lines = format_text(self.content)

        # Replace links
        for i in range(len(text_lines)):
            links = re.findall(r'\[\[(.+?)]]', text_lines[i])
            for link in links:
                link_components = link.lstrip('#').split('#')
                if label := (self.find_link(link_components) if isinstance(self, Section) else self.parent.find_link(link_components)):
                    text_lines[i] = text_lines[i].replace(f'[[{link}]]', f'\\autoref{{{label}}}', 1)
                else:
                    text_lines[i] = text_lines[i].replace(f'[[^{link}]]', f'\\hl{{{link}}}', 1)

        # Replace footnotes
        for i in range(len(text_lines)):
            footnote_marks = re.findall(r'\[\^(.+?)]', text_lines[i])
            for footnote_mark in footnote_marks:
                if footnote_content := (self.find_footnote(footnote_mark) if isinstance(self, Section) else self.parent.find_footnote(footnote_mark)):
                    text_lines[i] = text_lines[i].replace(f'[^{footnote_mark}]', f'\\footnote{{{footnote_content[0]}}}', 1)

        return text_lines


class Section(Block):
    section_levels = {1: 'chapter', 2: 'section', 3: 'subsection'}

    def __init__(self, h_level, title, content):
        super().__init__(content)
        self.h_level = h_level
        self.title = title
        self.children = to_blocks(content, parent=self)
        self._md_file_name = None
        self._tex_file_name = None

    def set_file_names(self, md_file_name=None, tex_file_name=None):
        self._md_file_name = md_file_name or self._md_file_name
        self._tex_file_name = tex_file_name or self._tex_file_name

    @property
    def label(self):
        reformatted_title = re.sub(r'\W', '_', self.title)
        reformatted_file = re.sub(r'\W', '_', self.tex_file_name)
        return f"sec:{reformatted_title}__{reformatted_file}"

    @property
    def md_file_name(self):
        if self._md_file_name:
            return self._md_file_name
        elif self.parent:
            return self.parent.md_file_name
        else:
            return ''

    @property
    def tex_file_name(self):
        if self._tex_file_name:
            return self._tex_file_name
        elif self.parent:
            return self.parent.tex_file_name
        else:
            return ''

    def find_footnote(self, footnote_mark):
        # try in children footnotes
        for child in self.children:
            if isinstance(child, Footnote) and child.footnote_mark == footnote_mark:
                return child.formatted_text()
        # TODO: allow search for footnotes in parent and child sections?
        return ''

    def find_link(self, link_components, top_down_search=False):
        if self.title == link_components[0] or self.md_file_name == link_components[0]:
            if len(link_components) == 1:
                return self.label  # Recursion break condition

            # else one of the children must be the section which is next in the link components
            for child in self.children:
                if isinstance(child, Section) and child.title == link_components[1]:
                    return child.find_link(link_components[1:], top_down_search=True)
        # Continue to search bottom up
        elif not top_down_search:
            return self.parent.find_link(link_components)
        # Search top down
        elif top_down_search:
            for child in self.children:
                if isinstance(child, Section):
                    if label := child.find_link(link_components, top_down_search=True):
                        return label
        else:
            return None

    def formatted_text(self):
        text_lines = [f'\\{Section.section_levels[self.h_level]}{{{self.title}}}\\label{{{self.label}}}']
        for child in self.children:
            if isinstance(child, Footnote):
                continue
            text_lines += ['\n']
            text_lines += child.formatted_text()
        return text_lines


class Paragraph(Block):
    def __init__(self, content):
        super().__init__(content)
        content = format_text(content)


class Equation(Block):
    def __init__(self, content, label=''):
        super().__init__(content)
        self.label = label

    def formatted_text(self):
        text_lines = ['\\begin{equation}\n']
        if self.label != '':
            text_lines += [f'\t\\label{{{self.label}}}\n']
        text_lines += ['\t' + line for line in self.content]
        text_lines += ['\\end{equation}\n']
        return text_lines


class List(Block):
    def __init__(self, content):
        super().__init__(content)

    def formatted_text(self):
        text_lines = ['\\begin{itemize}\n']
        text_lines += ['\t\\item ' + line.strip().lstrip('-').lstrip() + '\n' for line in super(List, self).formatted_text()]
        text_lines += ['\\end{itemize}\n']
        return text_lines


class Quote(Block):
    def __init__(self, content):
        super().__init__(content)

    def formatted_text(self):
        text_lines = ['\\begin{displayquote}\n']
        text_lines += ['\t' + line for line in super(Quote, self).formatted_text()]
        text_lines += ['\\end{displayquote}\n']
        return text_lines


class Figure(Block):
    def __init__(self, settings, label, caption):
        if isinstance(caption, str):
            caption = [caption]
        super().__init__(caption)
        self.settings = settings
        self.label = label

    @property
    def file_name(self):
        return self.settings[0]

    @property
    def width(self):
        if len(self.settings) > 1:
            for setting in self.settings[1:]:
                if setting[:2] == 'w=':
                    return setting[2:]
        return 0.5

    def formatted_text(self):
        text_lines = ['\\begin{figure}[H]\n']
        text_lines += ['\t\\centering\n']
        text_lines += [f'\t\\includegraphics[width={self.width}\linewidth]{{Graphics/{self.file_name}}}\n']
        text_lines += ['\t\\caption{'] + super(Figure, self).formatted_text() + ['}\n']
        text_lines += [f'\t\\label{{{self.label}}}\n']
        text_lines += ['\\end{figure}\n']
        return text_lines


class Footnote(Block):
    def __init__(self, content, footnote_mark):
        super().__init__(content)
        self.footnote_mark = footnote_mark


class Project:
    def __init__(self):
        self.children = []

    def add_child(self, child: Section):
        self.children.append(child)
        child.parent = self

    def parse_md_file_contents(self, contents, md_file_name, tex_file_name):
        for block in to_blocks(contents, parent=self):
            if isinstance(block, Section):
                block.set_file_names(md_file_name=md_file_name, tex_file_name=tex_file_name)
                self.children.append(block)
            else:
                print('ERROR: non-section block in top level ignored')
                print(['\t' + line for line in block.content])

    def find_link(self, link_components, top_down_search=False):
        for child in self.children:
            if label := child.find_link(link_components, top_down_search=True):
                return label
