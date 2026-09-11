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
    previews = json.loads((docs / "component-previews.json").read_text())
    component_pages = {path.stem for path in (docs / "components").glob("*.mdx")}
    if set(previews) != component_pages:
        raise ValueError("Every component page must map to its catalog examples")
    # Both paths are fixed generated outputs, never the root docs directory.
    for output in [content, assets]:
        if output.exists():
            shutil.rmtree(output)
        output.mkdir(parents=True)
    with zipfile.ZipFile(docs / "assets/remix-cli-tutorial/sample-projects.zip") as archive:
        for path in docs.rglob("*.mdx"):
            target = content / path.relative_to(docs)
            target.parent.mkdir(parents=True, exist_ok=True)
            text = expand_sources(path.read_text(), archive)
            if path.parent == docs / "components":
                example = previews[path.stem]
                if not example["cases"]:
                    raise ValueError(f"No catalog cases for {path.stem}")
                code = (root / f"apps/demo/lib/components/{path.stem}.dart").read_text().rstrip("\n")
                title = re.search(r"^title: (.+)$", text, re.MULTILINE)[1]
                panel = (f'\n<Tabs items={{["Preview", "Source"]}}>\n<Tab value="Preview" keepMounted>\n'
                         f'<FlutterPreview title={json.dumps(title)} cases={{{json.dumps(example["cases"])}}} />\n'
                         f'</Tab>\n<Tab value="Source">\n\n'
                         f'```dart title="apps/demo/lib/components/{path.stem}.dart"\n{code}\n```\n\n'
                         f'</Tab>\n</Tabs>\n')
                # Insert after frontmatter; authored docs stay unchanged.
                end = text.index("\n---", 3) + 4
                text = text[:end] + "\n" + panel + text[end:]
            target.write_text(text)
    # Fumadocs supports root page paths and separators in a meta file.
    navigation = json.loads((root / "docs.json").read_text())
    pages = []
    for group in navigation["sidebar"]:
        links = [f"[{page['title']}]({page['href']})" for page in group["pages"]]
        if group.get("collapsible"):
            folder = "nav-" + re.sub(r"[^a-z0-9]+", "-", group["group"].lower())
            target = content / folder
            target.mkdir()
            (target / "meta.json").write_text(json.dumps({
                "title": group["group"], "pages": links, "defaultOpen": False,
            }, indent=2) + "\n")
            pages.append(folder)
        else:
            pages.append(f"---{group['group']}---")
            pages.extend(links)
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
