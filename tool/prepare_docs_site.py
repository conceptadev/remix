"""Stage canonical MDX, archive-backed examples, navigation, and assets for Next.

Only generated directories under apps/docs are replaced. No authoring source
is copied back. Run this through the docs app's dev/build/typecheck commands.
"""

import json
from pathlib import Path
import re
import shutil
import zipfile

SOURCE_TAG = re.compile(r'<TutorialSource preset="(default|fortal)" file="(lib/main\.dart|test/workflow_test\.dart)"\s*/>')


def expand_sources(text, archive):
    def replace(match):
        path = f"{match[1]}_demo/{match[2]}"
        code = archive.read(path).decode().rstrip("\n")
        return f"```dart title=\"{match[2]}\"\n{code}\n```"
    result = SOURCE_TAG.sub(replace, text)
    if "<TutorialSource" in result:
        raise ValueError("Unsupported tutorial source include")
    return result


def prepare(root):
    docs = root / "docs"
    app = root / "apps/docs"
    content = app / ".generated/content"
    assets = app / "public/assets"
    # Both paths are fixed generated outputs, never the root docs directory.
    for output in [content, assets]:
        if output.exists():
            shutil.rmtree(output)
        output.mkdir(parents=True)
    with zipfile.ZipFile(docs / "assets/remix-cli-tutorial/sample-projects.zip") as archive:
        for path in docs.rglob("*.mdx"):
            target = content / path.relative_to(docs)
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text(expand_sources(path.read_text(), archive))
    # Fumadocs supports root page paths and separators in a meta file.
    navigation = json.loads((root / "docs.json").read_text())
    pages = []
    for group in navigation["sidebar"]:
        pages.append(f"---{group['group']}---")
        pages.extend(f"[{page['title']}]({page['href']})" for page in group["pages"])
    (content / "meta.json").write_text(json.dumps({"pages": pages}, indent=2) + "\n")
    shutil.copytree(docs / "assets", assets, dirs_exist_ok=True)
    print("Staged canonical Remix docs, archive-backed examples, navigation, and assets.")


if __name__ == "__main__":
    from check_tutorial_assets import check_assets, check_content
    root = Path(__file__).resolve().parents[1]
    failures = check_assets(root) + check_content(root)
    if failures:
        raise SystemExit("Documentation source validation failed:\n" + "\n".join(failures))
    prepare(root)
