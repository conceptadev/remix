# Maintaining Remix documentation

The content in `docs/` is owned by this repository. `docs.json` defines its
navigation. `apps/docs` renders it with the shared Concepta Fumadocs theme.
See [the app README](../apps/docs/README.md) for run commands and the temporary
GitHub-access requirement while the theme is unpublished.

## Content organization

- `index.mdx`: what Remix supplies, workflow choices, and host requirements.
- `getting-started.mdx`: checkout installation and a complete first component.
- `guides/styling-components.mdx`: states, animation, and style reuse.
- `open-code.mdx`: CLI command and configuration reference.
- `tutorials/settings-screen.mdx`: guided default/Fortal application walkthrough.
- `components/` and `fortal/`: the existing component and preset references.

The introduction/setup/styling revision draws on the explanations in
`conceptadev/website` at `fb1c11e928144ff8a6e4ad9df22bc55a268d064f`, under
`src/content/documentation/remix/index.mdx`. Its content was adapted, not
mirrored: obsolete convenience methods, the `{latest_version}` placeholder,
and package-owned Fortal installation assumptions were not imported. The local
package source and analyzer remain authoritative for examples.

## Tutorial source and evidence

`tutorials/settings-screen.mdx` is the tutorial. Full application and test
panels use build-time `TutorialSource` includes from the checked sample ZIP.
There is no second HTML tutorial or separate source listing to keep in sync.

Each authored fenced block carries a hidden `tutorial-source` marker matched
against `assets/remix-cli-tutorial/code-evidence.json`. The hashes preserve the
reviewed commands and first-render example from commit `3c63fe44f`; they are
not another editable copy of the code. Review any intentional change before
updating that evidence. The old HTML presentations are recoverable in Git.

Keep screenshots, sample projects, capture pins, and licenses under
`assets/remix-cli-tutorial/`. Do not relabel old captures as new validation.
See that directory's README for editing and evidence rules. New prose still
needs review; matching excerpts cannot prove every instruction is accurate.

## Validation

Use the pinned Flutter SDK and Python 3.9 or newer:

```bash
fvm dart run melos run docs:check
```

This validates navigation, known retired APIs, analyzable Dart snippets,
generated catalog consistency, tutorial asset/source hashes, recorded snippet
parity, complete source-panel inclusion, and local links in the introduction/setup/styling/tutorial
pages. Regression tests deliberately corrupt fixtures in temporary directories.

The tutorial's application-relative `ui/ui.dart` example is checked against
recorded evidence, not compiled against the workspace package. Replay the
downloaded Flutter samples when application code or CLI behavior changes.
Run `pnpm typecheck` and `pnpm build` inside `apps/docs` to validate the site.
