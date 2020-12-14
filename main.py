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

import json
import os
import sys
from blocks import Project


if len(sys.argv) == 1:
    print('NO CONFIG FILE PROVIDED')
    exit()

config_file = sys.argv[1]
if not os.path.exists(config_file):
    print(f'ERROR: file <{config_file}> not found')
    exit()

# Change directory to the config file's so that relative paths work
os.chdir(os.path.dirname(os.path.realpath(config_file)))
config_file = os.path.basename(config_file)

with open(config_file, 'r') as f:
    config = json.load(f)

print(f'\nLoaded configuration from <{config_file}>')
print('======================')
print('LOADING INPUT FILES...')
project = Project()
for i, job in enumerate(config['jobs']):
    assert job['input'].endswith('.md')
    assert job['output'].endswith('.tex')
    with open(job['input'], 'r') as f:
        markdown_text = f.readlines()
    md_file_name = os.path.basename(job['input']).split('.')[0]
    tex_file_name = os.path.basename(job['output']).split('.')[0]
    project.parse_md_file_contents(markdown_text, md_file_name=md_file_name, tex_file_name=tex_file_name)
    print(f"\t{job['input']}")

print('TRANSLATING...')
translated_file_contents = {}
for child, job in zip(project.children, config['jobs']):
    translated_file_contents[job['output']] = child.formatted_text()
    print(f"\t{os.path.basename(job['input'])} > {os.path.basename(job['output'])}")

print('WRITING TO OUTPUT FILES...')
for tex_file_name, content in translated_file_contents.items():
    with open(tex_file_name, 'w') as f:
        f.writelines(content)
    print(f"\t{tex_file_name}")
