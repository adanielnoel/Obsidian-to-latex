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

