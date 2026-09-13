"""Enforce WidgetsApp hosts and the current theme scope API in shipped source."""
from pathlib import Path
import re
import os
import zipfile

CONSTRUCTOR = re.compile(r'\bMaterialApp(?:\s*\.\s*\w+)?\s*\(')


def violations(name, text):
    failures = [f'{name}:{text.count(chr(10), 0, match.start()) + 1}: use WidgetsApp, not a Material app host'
                for match in CONSTRUCTOR.finditer(text)]
    # Normalize generator placeholders before checking constructor arguments.
    source = re.sub(r'\{\{\w+\}\}', 'Generated', text)
    for declaration in re.finditer(r'\b\w*Scope\s*(?:\.\w+)?\s*\(\s*\{([^}]*)\}', source):
        if re.search(r'\b(?:data|brightness|lightTheme)\s*(?:[,=]|$)', declaration[1]):
            failures.append(f'{name}: scope constructor declares a removed parameter')
    for match in re.finditer(r'\b\w*Scope\s*(?:\.\w+)?\s*\(', source):
        depth = 0
        start = match.end()
        for index in range(start, len(source)):
            char = source[index]
            if char in '([{':
                depth += 1
            elif char in ')]}':
                if char == ')' and depth == 0:
                    argument = source[start:index].strip()
                    if re.match(r'(?:data|brightness|lightTheme)\s*:', argument):
                        failures.append(f'{name}: removed scope argument: {argument.split(":")[0]}')
                    break
                depth -= 1
            if char == ',' and depth == 0:
                argument = source[start:index].strip()
                if re.match(r'(?:data|brightness|lightTheme)\s*:', argument) or re.match(r'this\.(?:data|brightness|lightTheme)\b', argument):
                    failures.append(f'{name}: removed scope argument: {argument.split(":")[0]}')
                start = index + 1
    if re.search(r'(?:\.|\bWidget\s+)createScope\s*\(', source):
        failures.append(f'{name}: config createScope is removed; use a theme scope')
    return failures


def check_hosts(root):
    failures = []
    for directory in ['docs', 'skills', 'apps', 'packages', 'open_code']:
        for parent, directories, files in os.walk(root / directory):
            directories[:] = [part for part in directories
                              if not part.startswith('.') and part not in
                              {'node_modules', 'build', 'out', 'test', 'integration_test'}]
            for filename in files:
                path = Path(parent) / filename
                if path.suffix not in {'.dart', '.md', '.mdx', '.tmpl'}:
                    continue
                failures.extend(violations(str(path.relative_to(root)), path.read_text()))
    archive = root / 'docs/assets/remix-cli-tutorial/sample-projects.zip'
    with zipfile.ZipFile(archive) as source:
        for name in source.namelist():
            if name.endswith('.dart') and '/test/' not in name:
                failures.extend(violations(f'{archive.relative_to(root)}!{name}', source.read(name).decode()))
    return failures


if __name__ == '__main__':
    failures = check_hosts(Path(__file__).resolve().parents[1])
    if failures:
        raise SystemExit('\n'.join(failures))
    print('Documentation, generator templates, examples, and tutorial downloads use WidgetsApp hosts and the current theme API.')
