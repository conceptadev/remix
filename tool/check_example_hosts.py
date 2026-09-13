"""Enforce WidgetsApp hosts and the current theme scope API in shipped source."""
from pathlib import Path
import re
import os
import zipfile

# Known public examples plus names discovered from theme declarations/configuration.
DEFAULT_SCOPES = {'FortalScope', 'AcmeScope', 'AcmeThemeScope',
                  'GeneratedScope', 'GeneratedThemeScope'}
IDENTIFIER = re.compile(r'[A-Za-z_$][\w$]*')
REMOVED = {'data': 'theme', 'brightness': 'mode', 'lightTheme': 'theme'}


def tokens(text):
    """Yield Dart lexical tokens with offsets; delimiters in trivia never count."""
    i = 0
    while i < len(text):
        if text[i].isspace():
            i += 1
            continue
        if text.startswith('//', i):
            end = text.find('\n', i)
            i = len(text) if end < 0 else end
            continue
        if text.startswith('/*', i):
            depth = 1
            i += 2
            while i < len(text) and depth:
                if text.startswith('/*', i):
                    depth += 1
                    i += 2
                elif text.startswith('*/', i):
                    depth -= 1
                    i += 2
                else:
                    i += 1
            continue
        start = i
        raw = text[i] == 'r' and i + 1 < len(text) and text[i + 1] in "\"'"
        if raw:
            i += 1
        if text[i] in "\"'":
            quote = text[i] * (3 if text.startswith(text[i] * 3, i) else 1)
            i += len(quote)
            while i < len(text) and not text.startswith(quote, i):
                i += 2 if text[i] == '\\' and not raw else 1
            i += len(quote)
            yield ('<string>', start)
            continue
        match = IDENTIFIER.match(text, i)
        if match:
            i += len(match[0])
        else:
            i += 1
        yield (text[start:i], start)


def violations(name, text, scopes=None):
    scopes = DEFAULT_SCOPES | set(scopes or ())
    # Preserve line numbers when normalizing template names and dartdoc examples.
    source = re.sub(r'\{\{\w+\}\}', lambda m: 'Generated', text)
    # Scan fenced documentation as code, without interpreting apostrophes in prose.
    if name.endswith(('.md', '.mdx')) and '```' in source:
        inside = False
        lines = []
        for line in source.splitlines(keepends=True):
            if line.lstrip().startswith('```'):
                inside = not inside
                lines.append('\n' if line.endswith('\n') else '')
            else:
                lines.append(line if inside else ('\n' if line.endswith('\n') else ''))
        source = ''.join(lines)
    doc_code = False
    lines = []
    for line in source.splitlines(keepends=True):
        match = re.match(r'(\s*)///(.*)', line)
        if not match:
            lines.append(line)
        elif '```' in match[2]:
            doc_code = not doc_code
            lines.append('\n')
        elif doc_code or re.search(r'\b(?:MaterialApp|\w*Scope)(?:\.\w+)?\s*\(', match[2]):
            lines.append(match[1] + '   ' + match[2] + ('\n' if line.endswith('\n') else ''))
        else:
            lines.append('\n' if line.endswith('\n') else '')
    source = ''.join(lines)
    stream = list(tokens(source))
    values = [t[0] for t in stream]
    # A theme data declaration establishes its generated scope prefix.
    for value in values:
        if value.endswith('ThemeData'):
            prefix = value[:-9]
            scopes.update({prefix + 'Scope', prefix + 'ThemeScope'})
    failures = []
    config_receivers = {'config', 'theme'}
    config_ranges = []
    for index, value in enumerate(values):
        if value.endswith(('ThemeConfig', 'ThemeData')):
            cursor = index + 1
            if cursor < len(values) and values[cursor] == '?':
                cursor += 1
            if cursor < len(values) and re.fullmatch(r'[A-Za-z_$][\w$]*', values[cursor]):
                config_receivers.add(values[cursor])
            if index >= 2 and values[index-1] == '=':
                config_receivers.add(values[index-2])
            if index and values[index-1] == 'class':
                while cursor < len(values) and values[cursor] != '{':
                    cursor += 1
                start, depth = cursor, 1
                cursor += 1
                while cursor < len(values) and depth:
                    depth += (values[cursor] == '{') - (values[cursor] == '}')
                    cursor += 1
                config_ranges.append((start, cursor))

    def report(index, message):
        line = source.count('\n', 0, stream[index][1]) + 1
        failures.append(f'{name}:{line}: {message}')

    for i, value in enumerate(values):
        j = i + 1
        if j + 2 < len(values) and values[j] == '.':
            j += 2  # named constructor
        if j >= len(values) or values[j] != '(':
            continue
        if value == 'MaterialApp':
            report(i, 'app host: use WidgetsApp')
        if value == 'createScope':
            # Theme config methods/calls; do not reserve this name for other APIs.
            nearby = values[max(0, i-3):i]
            config_source = any(start < i < end for start, end in config_ranges)
            receiver = values[i-2] if i >= 2 and values[i-1] == '.' else ''
            if receiver == ')':
                cursor, depth = i - 2, 1
                while cursor > 0 and depth:
                    cursor -= 1
                    depth += (values[cursor] == ')') - (values[cursor] == '(')
                constructor = values[max(0, cursor-3):cursor]
                config_source |= any(v.endswith(('ThemeData', 'ThemeConfig')) for v in constructor)
            if config_source or receiver in config_receivers or any(v in scopes for v in nearby):
                report(i, 'removed config createScope: construct a theme scope with theme instead')
        if value not in scopes:
            continue
        stack = []
        k = j + 1
        while k < len(values):
            token = values[k]
            if token == ')' and not stack:
                break
            # Arguments live at depth zero; named declaration fields inside {}.
            if token in REMOVED and (not stack or stack == ['{']):
                following = values[k+1] if k+1 < len(values) else ''
                previous = values[k-1] if k else ''
                if following == ':' or (stack == ['{'] and following in {',', '=', '}'}) or previous == '.' and k >= 2 and values[k-2] == 'this':
                    report(k, f'removed scope {token}: use {REMOVED[token]}')
            if token in {'(', '[', '{'}:
                stack.append(token)
            elif stack and {')': '(', ']': '[', '}': '{'}.get(token) == stack[-1]:
                stack.pop()
            k += 1
    return failures


def check_hosts(root):
    failures = []
    scopes = set(DEFAULT_SCOPES)
    sources = []
    for directory in ['docs', 'skills', 'apps', 'packages', 'open_code']:
        for parent, directories, files in os.walk(root / directory):
            directories[:] = [part for part in directories
                              if not part.startswith('.') and part not in
                              ({'node_modules', 'build', 'out'} |
                               (set() if directory == 'open_code' else {'test', 'integration_test'}))]
            if 'remix.yaml' in files:
                config = (Path(parent) / 'remix.yaml').read_text()
                match = re.search(r'(?m)^\s*prefix:\s*[\"\']?(\w+)', config)
                if match:
                    scopes.update({match[1] + 'Scope', match[1] + 'ThemeScope'})
            for filename in files:
                path = Path(parent) / filename
                if path.suffix not in {'.dart', '.md', '.mdx', '.tmpl'}:
                    continue
                content = path.read_text()
                sources.append((str(path.relative_to(root)), content))
                for prefix in re.findall(r'\bclass\s+(\w+)ThemeData\b', content):
                    scopes.update({prefix + 'Scope', prefix + 'ThemeScope'})
    archive = root / 'docs/assets/remix-cli-tutorial/sample-projects.zip'
    with zipfile.ZipFile(archive) as source:
        for name in source.namelist():
            if name.endswith('.dart'):
                sources.append((f'{archive.relative_to(root)}!{name}', source.read(name).decode()))
    for name, content in sources:
        failures.extend(violations(name, content, scopes))
    return failures


if __name__ == '__main__':
    failures = check_hosts(Path(__file__).resolve().parents[1])
    if failures:
        raise SystemExit('\n'.join(failures))
    print('Documentation, generator templates, examples, and tutorial downloads use WidgetsApp hosts and the current theme API.')
