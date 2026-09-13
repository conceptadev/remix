"""Keep shipped documentation and examples free of MaterialApp constructors."""
from pathlib import Path
import re
import zipfile

CONSTRUCTOR = re.compile(r'\bMaterialApp(?:\s*\.\s*\w+)?\s*\(')


def violations(name, text):
    return [f'{name}:{text.count(chr(10), 0, match.start()) + 1}: use WidgetsApp, not a Material app host'
            for match in CONSTRUCTOR.finditer(text)]


def check_hosts(root):
    failures = []
    for directory in ['docs', 'skills', 'apps', 'packages', 'open_code']:
        for path in (root / directory).rglob('*'):
            relative = path.relative_to(root)
            if any(part.startswith('.') or part in {'node_modules', 'build', 'out', 'test', 'integration_test'}
                   for part in relative.parts):
                continue
            if path.suffix not in {'.dart', '.md', '.mdx', '.tmpl'}:
                continue
            failures.extend(violations(str(relative), path.read_text()))
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
    print('Documentation, generator templates, examples, and tutorial downloads use neutral app hosts.')
