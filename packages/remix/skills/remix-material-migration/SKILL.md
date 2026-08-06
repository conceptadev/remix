---
name: remix-material-migration
description: Convert existing Flutter Material widgets in an app to their Remix component-library equivalents — swap the widget AND translate its Material styling (ButtonStyle, decoration, theme) into the equivalent Remix styler chain, auto-converting only confident 1:1 matches and flagging near-matches as TODOs. Use ONLY when the developer explicitly asks to migrate/convert/replace Material widgets with Remix (e.g. "migrate this screen to Remix", "replace ElevatedButton with RemixButton", "convert Material to Remix"). Requires existing Material code to rewrite. For app-wide theming use remix-theming; to style an already-Remix component use remix-component-styling.
---

# Material → Remix migration

Rewrites existing **Material** widgets into **Remix** components. Precondition:
there is real Material code to convert. This skill both swaps the widget and
translates its visual style.

## Before anything: read the real API

Read [../shared/find-remix-source.md](../shared/find-remix-source.md) and confirm
every target Remix class/widget name and its constructor args from the resolved
version before rewriting. Confirm styler names too — they are inconsistent.

## Workflow

1. **Scope the migration.** Identify the file(s)/widget(s) the dev named. Never
   migrate beyond what was asked.

2. **Classify each Material widget** using
   [MAPPING.md](MAPPING.md):
   - **Tier 1 (confident 1:1)** → auto-convert (steps 3–4).
   - **Tier 2 (near-match)** → do NOT rewrite. Insert a
     `// TODO(remix-migration): -> <RemixTarget>; <what differs>` comment and
     leave the Material code intact.
   - **Tier 3 (no equivalent — layout/navigation)** → leave untouched.

3. **Swap the widget** (Tier 1). Map constructor args (`onPressed`, `child`→
   `label`, etc. per MAPPING.md), preserving behavior. Add the Remix import.

4. **Translate the styling** (Tier 1). This is required — an unstyled migration
   looks broken. Read the Material `style: ButtonStyle`/`ThemeData`, wrapping
   `Container`/`Padding` decoration, colors and radii, and produce the equivalent
   Remix styler chain. Delegate the chain-building to the same approach as the
   `remix-component-styling` skill (confirm methods from source; reference theme
   tokens if a theme scope exists). Where a Material style property has no faithful
   Remix equivalent, drop a `// TODO(remix-migration):` rather than guessing.

5. **Report.** Summarize: converted (Tier 1), flagged for manual review (Tier 2,
   with reasons), and left as-is (Tier 3). Silent semantic changes are forbidden.

6. **Verify (REQUIRED — non-negotiable).** Migration rewrites code that already
   compiled, so it must still compile:
   ```bash
   dart analyze <changed files>
   ```
   Fix every error before declaring done. Iterate until clean. A failure usually
   means a hallucinated name — reconfirm against source. If a conversion cannot be
   made to compile faithfully, revert it to the original Material widget and flag
   it as Tier 2 instead.
