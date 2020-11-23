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
from parser import parse, scan_headers
import os.path, os
import sys

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

headers = {}
content = {}
translations = {}
for i, job in enumerate(config['jobs']):  # Scan all documents for headers first
    assert job['input'].endswith('.md')
    with open(job['input'], 'r') as f:
        markdown_text = f.readlines()
    content[job['input']] = markdown_text
    headers = {**headers, **scan_headers(markdown_text,
                                         latex_filename=os.path.basename(job['output']).replace('.tex', ''),
                                         markdown_filename=os.path.basename(job['input']).replace('.md', ''))}
    print(f'Loaded headers from : {job["input"]}')

print('-----------------------')
for i, job in enumerate(config['jobs']):
    assert job['output'].endswith('.tex')

    print(f'Translating from : {job["input"]}')
    translations[job['output']] = parse(content[job['input']],
                                        latex_images_dir=config['settings']['latex_local_images_dir'],
                                        headers=headers, latex_filename=os.path.basename(job['output']).replace('.tex', ''))

print('-----------------------')
for file, latex in translations.items():
    with open(file, 'w') as f:
        f.writelines(latex)

    print(f'Written to : {file}')

