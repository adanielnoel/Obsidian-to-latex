import re
import copy

IGNORE_START_COMMAND = 'latex ignore start'
IGNORE_END_COMMAND = 'latex ignore end'
FIGURE_COMMAND = 'latex figure:'
EQUATION_COMMAND = 'eq:'
LATEX_SPECIAL_CHARS = r'$%_}&#{'


def detect_header(line, level=None):
    if level:
        match = re.match(f'^(#{{{level}}})\s(.*)', line)
    else:
        match = re.match(r'^(#{1,3})\s(.*)', line)

    if match:
        return {'h_level': len(match.group(1)), 'title': match.group(2)}
    else:
        return False


def detect_footnote(line):
    if match := re.match(r'^\[\^(.+?)]:(.*)', line):
        return match.group(1), match.group(2).strip()
    return False


def detect_command(line):
    if match := re.match(r'^#{4}\s(.*)', line):
        return match.group(1)
    else:
        return False


def detect_figure_command(line):
    if command := detect_command(line):
        if command.strip().lower()[:len(FIGURE_COMMAND)] == FIGURE_COMMAND:
            return command[len(FIGURE_COMMAND):].strip().split(' ')
    else:
        return False


def detect_equation_command(line):
    if command := detect_command(line):
        if command.strip().lower()[:len(EQUATION_COMMAND)] == EQUATION_COMMAND:
            return command.strip()
    else:
        return False


def is_comment(line):
    return detect_command(line) and not detect_figure_command(line) and not is_command(line, IGNORE_START_COMMAND) and not is_command(line, IGNORE_END_COMMAND) and not detect_equation_command(line)


def is_command(line, command):
    if cmd := detect_command(line):
        if cmd.strip().lower() == command:
            return True
    return False


def is_end_paragraph(line):
    return is_ignore_line(line) or is_equation_dollars(line) or is_list_item(line) or is_quote(line) or detect_command(line) or detect_header(line)


def is_equation_dollars(line):
    return line.strip()[:2] == '$$'


def is_list_item(line):
    return False if len(line.strip()) == 0 else line.strip()[0] == '-'


def is_quote(line):
    return False if len(line.strip()) == 0 else line.strip()[0] == '>'


def is_markdown_image(line):
    return bool(re.match('^!\[\[.+?\.(png|jpg).*?]]$', line.strip()))


def is_ignore_line(line):
    return len(line.strip()) == 0 or line.strip() == '---' or is_comment(line) or is_markdown_image(line)


def find_next_index(lst, expr, start=0):
    for i in range(start, len(lst)):
        if expr(lst[i]):
            return i
    return len(lst)


"""
- [x] Sections
- [x] Paragraph (incl. inline math)
- [x] Equations
- [x] Figures
- [x] Lists (unordered)
- [x] Quotes
- [x] Footnotes
- [ ] Tables
"""


def to_blocks(text_lines, parent=None):
    from blocks import Section, Paragraph, Equation, List, Quote, Figure, Footnote
    if issubclass(str, type(text_lines)):
        text_lines = text_lines.splitlines()

    content_blocks = []
    is_ignoring = False
    i = 0
    while i < len(text_lines):
        block = None
        line = text_lines[i]
        # PROCESS IGNORE BLOCK COMMAND
        if is_command(text_lines[i], IGNORE_START_COMMAND):
            is_ignoring = True
            i += 1
        elif is_command(text_lines[i], IGNORE_END_COMMAND):
            if not is_ignoring:
                print(f'WARNING: found command <{IGNORE_END_COMMAND}> without a matching <{IGNORE_START_COMMAND}>')
            is_ignoring = False
            i += 1
        # PROCESS EMPTY LINES, HORIZONTAL LINES, COMMENTS
        elif is_ignore_line(text_lines[i]):
            i += 1
        # PROCESS SECTION BLOCK
        elif header := detect_header(text_lines[i]):
            h_level = header['h_level']
            title = header['title']
            end_section_i = find_next_index(text_lines, lambda l: detect_header(l, h_level), i + 1)
            block = Section(h_level=h_level, title=title, content=text_lines[i + 1: end_section_i])
            i = end_section_i
        # PROCESS EQUATION BLOCK (unlabeled)
        elif is_equation_dollars(text_lines[i]):
            end_equation_i = find_next_index(text_lines, lambda l: is_equation_dollars(l), i + 1)
            block = Equation(content=text_lines[i + 1: end_equation_i])
            i = end_equation_i + 1  # line with $$ must be skipped # PROCESS EQUATION BLOCK (unlabeled)
        # PROCESS EQUATION BLOCK (labeled)
        elif label := detect_equation_command(text_lines[i]):
            assert is_equation_dollars(text_lines[i + 1]), 'Equation dollars must be alone in a line'
            i += 1  # skip next line because it just contains the double dollar
            end_equation_i = find_next_index(text_lines, lambda l: is_equation_dollars(l), i + 1)
            block = Equation(content=text_lines[i + 1: end_equation_i], label=label)
            i = end_equation_i + 1  # line with $$ must be skipped
        # PROCESS LIST BLOCK
        elif is_list_item(text_lines[i]):
            end_list_i = find_next_index(text_lines, lambda l: not is_list_item(l), i + 1)
            block = List(content=text_lines[i: end_list_i])
            i = end_list_i
        # PROCESS QUOTE BLOCK
        elif is_quote(text_lines[i]):
            end_quote_i = find_next_index(text_lines, lambda l: not is_quote(l), i + 1)
            block = Quote(content=[line.lstrip('> ') for line in text_lines[i: end_quote_i]])
            i = end_quote_i
        # PROCESS FIGURE BLOCK
        elif settings := detect_figure_command(text_lines[i]):
            alt_data = re.match(r'^`(.*?)`:(.*)', text_lines[i+1])
            assert alt_data, f'Caption of figure <{settings[0]}> badly formed'
            label = alt_data.group(1).strip()
            caption = alt_data.group(2).strip()
            block = Figure(settings=settings, label=label, caption=caption)
            i = i + 2  # figures are just one line for the command and another for the label and caption
        # PROCESS FOOTNOTE BLOCK
        elif footnote_match := detect_footnote(text_lines[i]):
            block = Footnote(footnote_mark=footnote_match[0], content=[footnote_match[1]])
            i = i + 1  # Markdown footnotes are just one line
        # PROCESS PARAGRAPH BLOCK
        else:
            end_paragraph_i = find_next_index(text_lines, lambda l: is_end_paragraph(l), i + 1)
            block = Paragraph(content=text_lines[i: end_paragraph_i])
            i = end_paragraph_i

        if block is not None:
            block.parent = parent
            if not is_ignoring:
                content_blocks.append(block)

    if is_ignoring:
        print(f'WARNING: did not find a matching <{IGNORE_END_COMMAND}> command')
    return content_blocks


def format_text(text_lines_origin):
    text_lines = copy.deepcopy(text_lines_origin)
    for i in range(len(text_lines)):
        # ===== SPECIAL CHARACTERS =====
        # Extract and replace by placeholders equations and links before making formatting
        equations = re.findall(r'\$.*?\$', text_lines[i])
        links = re.findall(r'\[\[.*?]]', text_lines[i])
        codes = re.findall(r'`.*?`', text_lines[i])
        text_lines[i] = re.sub(r'\$.*?\$', '<EQ-PLACEHOLDER>', text_lines[i])
        text_lines[i] = re.sub(r'\[\[.*?]]', '<LINK-PLACEHOLDER>', text_lines[i])
        text_lines[i] = re.sub(r'`.*?`', '<CODE-PLACEHOLDER>', text_lines[i])
        # Format special chars that need to be escaped
        for special_char in LATEX_SPECIAL_CHARS:
            text_lines[i] = text_lines[i].replace(special_char, f"\\{special_char}")
        # put back equations and links
        for link in links:
            text_lines[i] = text_lines[i].replace(r'<LINK-PLACEHOLDER>', link, 1)
        for equation in equations:
            text_lines[i] = text_lines[i].replace(r'<EQ-PLACEHOLDER>', equation, 1)
        for code in codes:
            text_lines[i] = text_lines[i].replace(r'<CODE-PLACEHOLDER>', code, 1)

        # ===== CITATIONS AND REFERENCES =====
        # Replace Markdown code key citations by Markdown note key citations
        text_lines[i] = re.sub(r'`(\w+[18|19|20]\d{2}\w*)`', r'[[\1]]', text_lines[i])
        # Join consecutive citations (turns [[key1]], [[key2]] into [[key1,key2]])
        joining = True
        while joining:
            length_before = len(text_lines[i])
            text_lines[i] = re.sub(r'(\w+[18|19|20]\d{2}\w*?)\]\][,|\s]{0,2}\[\[(\w+[18|19|20]\d{2}\w*?)', r'\1,\2', text_lines[i])
            joining = len(text_lines[i]) != length_before
        # Replace Markdown note key citations by Latex citations, handles consecutive citations too
        text_lines[i] = re.sub(r'\[\[(\w+[18|19|20]\d{2}\S*?)\]\]', r'\\citep{\1}', text_lines[i])
        # Replace Markdown figure references by Latex references
        text_lines[i] = re.sub(r'`(fig:\S*?)`', r'\\autoref{\1}', text_lines[i])
        # Replace Markdown equation references by Latex references
        text_lines[i] = re.sub(r'`(eq:\S*?)`', r'\\autoref{\1}', text_lines[i])

        # ===== TEXT FORMATTING =====
        # Replace Markdown monospace by latex monospace (note: do after other code blocks like refs and citations)
        text_lines[i] = re.sub(r'`(.*?)`', r'\\texttt{\1}', text_lines[i])
        # Replace Markdown italics by Latex italics
        text_lines[i] = re.sub(r'(?<!\*)\*([^\*].*?)\*(?!\*)', r'\\textit{\1}', text_lines[i])
        # Replace Markdown bold by Latex bold
        text_lines[i] = re.sub(r'\*\*([^\*].*?)\*\*', r'\\textbf{\1}', text_lines[i])
        # Replace Markdown highlight by Latex highlight
        text_lines[i] = re.sub(r'==([^=].*?)==', r'\\hl{\1}', text_lines[i])

    return text_lines
