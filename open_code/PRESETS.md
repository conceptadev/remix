# Presets: Fortal as application-owned source

**Status:** Implemented
**Base branch:** `feat/open-code`

## The problem

`remix_cli` installs one registry: a 15-token `theme` item and one authored
recipe per component. Fortal is a second, complete design language on Remix,
with 277 tokens, Radix color data, 35 recipes, and a parity contract against
Radix Themes 3.3.0. Today an application can adopt Fortal only as a hosted
package. It cannot own the source the way it owns the default recipes.

This document designs the change that lets an application run
`remix init --preset fortal` and then `remix add button`, and receive editable
Fortal source under its own prefix. It is organized as a stack of pull
requests against `feat/open-code`. Each pull request is green on its own.

## Decisions

These were reached in review before this document. Each one is stated once,
with the reason, so a reviewer does not reopen it by accident.

1. **A preset is a registry tree, chosen once at `init`.** A Fortal button
   resolves Fortal tokens and a default button resolves default tokens, so the
   two cannot mix in one application. The choice is recorded in `remix.yaml`,
   next to the prefix, and follows the same rule as the prefix: it cannot
   change after `init`. This is also how shadcn treats `style` in
   `components.json`.
2. **One recipe tree per preset.** shadcn v4 shares one component source across
   styles because every style uses one variant vocabulary. Fortal's vocabulary
   (`classic`, `solid`, `soft`, `surface`, `outline`, `ghost`) is not the
   default's (`primary`, `secondary`, `outline`, `ghost`, `destructive`), so
   a shared recipe with swappable data is not possible between these two.
3. **Fortal is authored once, as Dart, in `packages/remix_fortal`.** The
   `remix_cli` templates are derived from that source and committed. A check
   fails when they drift. The alternative, hand-authored `.tmpl` files, means
   editing 36 files without an analyzer, and running the 50 test files and
   the parity checker through a temporary-app render on every change. shadcn
   moved from hand-authored per-style trees to authored source plus a build
   for the same reason.
4. **The Radix color table installs as source.** It is one generated file
   pinned to Radix Themes 3.3.0 that regenerates only on a reviewed pin move.
   A package for data that never changes buys nothing, and the pub.dev name
   `radix_colors` is already taken. Installing it lets an application add a
   custom 12-step scale, which the closed accent enum forbids today.
5. **Nothing installed is named Fortal.** The word appears in the registry
   directory name and in `remix.yaml`. The application gets `AcmeScope`,
   `AcmeTokens`, `AcmeButton`, and token ids such as `acme.accent.9`.
6. **`mix_chart` stays a hosted dependency of the `chart` item.** It is the
   chart engine the recipe styles, as `remix` is the button engine. The
   default `chart` item already declares it.
7. **`remix_fortal` leaves pub.dev once the preset works; the directory
   stays.** Hosted Fortal has no consumer base to protect: 0 likes and 438
   downloads at `1.0.0-beta.7`. pub.dev cannot delete a package, so the
   package is marked discontinued with `remix init --preset fortal` named as
   the replacement, after PR 4 proves that path. The directory
   `packages/remix_fortal` is not deleted. It is the authored source the
   templates derive from, the target of 50 test files and the parity
   checker, and a dependency of `apps/dashboard`, `apps/demo`, and
   `apps/playground`. Drift between it and the derived templates is not a
   risk: `--check` fails CI on any byte of difference, the same way
   `docs/fortal/catalog.mdx` and the playground dogfood are checked today.

## What the application gets

```shell
dart run remix_cli:remix init --prefix Acme --preset fortal
dart run remix_cli:remix add button
```

```text
lib/ui/
  ui.dart
  theme/
    theme.dart             barrel of the files below, minus radix_colors; exported from ui.dart
    radix_colors.dart      generated Radix 3.3.0 scales; not exported from ui.dart
    computed.dart          role math, shadows, token resolution
    control_styles.dart    shared focus and inset-surface helpers
    tokens.dart            AcmeTokens
    theme_data.dart        AcmeThemeConfig, AcmeThemeData, the token map
    theme_scope.dart       AcmeScope, AcmeTheme
    surface_frame.dart
  components/
    base_button.dart       shared Button and IconButton metrics and states
    button.dart            authored; edit this
    button.g.dart          generated; AcmeButton, AcmeButton.solid, ...
```

Hosted dependencies after install: `remix` and `mix_annotations`, with
`build_runner` and `mix_generator` for generation. `remix_ui_icons` arrives
only with `icons`. `mix_chart` arrives only with `chart`. No Fortal package.

The application then edits the same three places the default preset offers:
theme values in `theme_data.dart`, a recipe in `components/`, and a per-widget
`style` argument that merges last.

## The registry after this stack

```text
packages/remix_cli/lib/src/registry/
  default/
    registry.yaml                 moved, unchanged
    templates/<item>/...          moved, unchanged
  fortal/
    registry.yaml                 derived
    templates/theme/*.dart.tmpl   derived
    templates/<item>/<item>.dart.tmpl
```

`remix.yaml` gains one key at schema 2:

```yaml
schema: 2
prefix: Acme
preset: fortal
paths:
  ui: lib/ui
```

A schema 1 file has no `preset` key and reads as `preset: default`, so
`apps/playground/remix.yaml` and every existing consumer keep working.

## The Fortal source after this stack

The package layout mirrors the installed layout. This is a hard requirement,
not a nicety: derivation replaces every `Fortal` and `fortal` in a file, so a
relative import such as `'../fortal/fortal.dart'` would break. After the move,
no path segment under `lib/src` contains the word.

| Today | After |
|---|---|
| `src/fortal/fortal_theme.dart` (2217 lines) | `src/theme/tokens.dart`, `src/theme/theme_data.dart`, `src/theme/theme_scope.dart`, `src/theme/control_styles.dart` |
| `src/fortal/computed.dart` | `src/theme/computed.dart` |
| `src/fortal/surface_frame.dart` | `src/theme/surface_frame.dart` |
| `src/radix/colors/colors.dart` + `colors_generated.dart` | `src/theme/radix_colors.dart`, one file, written by `scripts/generate_radix_colors.dart` |
| `src/fortal/base_button_recipe.dart` + `base_button_state_styles.dart` | `src/components/base_button.dart` |
| `src/recipes/typography_shared.dart` | `src/components/typography.dart` |
| `src/recipes/<name>.dart` | `src/components/<name>.dart` |
| `src/radix/icons.dart` | `src/icons.dart` |
| `src/fortal/fortal.dart` (internal barrel) | `src/theme/theme.dart`; exports every theme file except `radix_colors.dart` |

The internal barrel survives on purpose. All 36 files under `recipes/`
import it today, so the move is one path change per file instead of a
36-file audit of which theme file each one uses. No recipe references a Radix color type, so the barrel
does not export `radix_colors.dart`; `computed.dart` and `theme_data.dart`
import that file directly.

The public barrel `lib/remix_fortal.dart` keeps every export, so the public
API does not change. `test/public_api_test.dart` proves it. Remix's own public
barrel also re-exports the six Naked constructor/state types referenced by
generated adapters, keeping installed recipes on the `package:remix/remix.dart`
boundary.

## Derivation

`tool/build_fortal_preset.dart` at the workspace root, next to
`check_open_code.dart`, does the following.

**Input.** Every `.dart` file under `packages/remix_fortal/lib/src` except
`*.g.dart`. The application generates its own parts.

**Refusals, checked first.** Any path segment containing `fortal`. Any file
containing `{{`, because the renderer treats that as a template token. Any
`package:remix_fortal`, `package:mix`, or `package:naked_ui` import, because
installed source must import the public `remix` surface. Each refusal names
the file.

**Substitution.** Plain `replaceAll` of `Fortal` with `{{typePrefix}}` and
`fortal` with `{{valuePrefix}}`. This is the exact inverse of
`TemplateRenderer.render`, so rendering with `Fortal` and `fortal` reproduces
the source byte for byte. That round trip is the drift test. Token id strings
follow the same rule and become `acme.accent.9` in the application. `Radix*`
identifiers do not contain the word and pass through.

**Placement.** `theme/*.dart` goes to `templates/theme/`. `components/x.dart`
goes to `templates/x/x.dart.tmpl`. `icons.dart` is skipped: no Fortal recipe
references an icon, and an icon alias set is not part of a design language,
so the Fortal `icons` item is a copy of the default `icons` template. Both
presets install the same file.

**Registry.** The tool also writes `registry/fortal/registry.yaml`, so the
item graph is correct by construction:

- `registryDependencies` come from relative imports. Any `'../theme/...'`
  import means `theme`, so the theme item is one node no matter which theme
  file a recipe names. A sibling import such as `'checkbox.dart'` means
  `checkbox`. Today those sibling imports are exactly: `data_table` to
  `checkbox`, `icon_button`, and `select` (and transitively `base_button`
  through `icon_button`); `sidebar` to `text` and `toggle`;
  `text`, `code`, `heading`, `kbd`, and `link` to `typography`; `button` and
  `icon_button` to `base_button`.
- `generated` is present when the file has a `part 'x.g.dart';` line.
- `dependencies` and `devDependencies` follow three rules, with every
  constraint read from the default registry so the version floors live in
  one place. `theme` declares `remix`. An item with a generated part declares
  `mix_annotations`, `build_runner`, and `mix_generator`, as the default
  `button` does. An item that imports `package:mix_chart` or
  `package:remix_ui_icons` declares that package too. `base_button` and
  `typography` have no part and no `@MixWidget`, so they declare nothing.
- `exports` lists `theme/theme.dart` for the theme item and the recipe file
  for every other item. `theme/radix_colors.dart` is never exported: it
  declares bare top-level names such as `gray` and `red` that must not enter
  `ui.dart`. `theme/computed.dart` is exported through the barrel; its names
  are prefixed, and `chart.dart` calls `resolveFortalTokens` from it.

**Modes.** No flag writes. `--check` derives in memory, compares with the
committed files, and fails on any difference. `melos run open-code:fortal:check`
runs it in CI, the way `docs:check` runs `generate_fortal_catalog.dart`.

## The stack

Five pull requests. The first two touch only `remix_fortal`. The third
touches only `remix_cli` and the repository tools, and can be reviewed in
parallel with the first two. The fourth depends on all three. The fifth is a
product step with an external side effect, so it stays separate and last.

Two earlier drafts were folded in. The fresh-app proof is part of the PR
that ships the Fortal preset, because a preset without its proof is not
done. Docs land with the PR they describe, because `validate_docs.dart`
already checks them and a flag without docs is not done either.

### PR 1: `refactor(remix_fortal)`: lay the source out like an installed preset

A pure move. Git sees renames, reviewers see paths, and no behavior changes.
This goes first so every later content diff lands on the final paths.

- Apply the file table above. Split `fortal_theme.dart` into three files:
  the `FortalTokens` class; the token-map builder with `FortalThemeConfig`
  and `FortalThemeData`; and `FortalScope` with `FortalTheme`. The
  declarations are not contiguous today, `FortalScope` sits between the
  builder and the data classes, so this is an extraction by declaration, not
  a slice by line range. Dart does not care about declaration order.
- Merge the color pair into `theme/radix_colors.dart`. Point
  `scripts/generate_radix_colors.dart` at the new path. Keep the file header
  and the integrity hash.
- Rename the internal barrel to `theme/theme.dart` and repoint every one of
  the 36 files under `recipes/` that import it. Drop `radix_colors.dart` from
  its exports.
- `tool/generate_fortal_catalog.dart` hardcodes `lib/src/recipes/<name>.dart`
  in `_recipePath` and opens those files to render `docs/fortal/catalog.mdx`.
  Point it at `components/`. This tool feeds `docs:check`, which the `ci`
  aggregate runs, so leaving it breaks CI on the move.
- The component docs link to recipe source on GitHub by path, for example
  `docs/components/tooltip.mdx:126`. Twenty-five doc files carry such a
  link. Rewrite every `lib/src/recipes/` link
  to `lib/src/components/`. `validate_docs.dart` does not check these links,
  so grep for the old path before merging.
- Update the paths in `scripts/README.md`.
- Proof: `test/public_api_test.dart` and `public_api_compatibility_test.dart`
  unchanged and green; `melos run fortal:parity:check` green; `melos run
  docs:check` green; the color fixture test still reads every scale; no
  file in the repository outside `.context/` contains `src/recipes/` or
  `src/fortal/`.

### PR 2: `feat(remix_fortal)`: instance style override, and only `remix` imports

Content edits on the final paths. Every default component template takes a
styler parameter merged last. No Fortal recipe does.

- Add `<Target>Styler style = const <Target>Styler.create()` as the last
  parameter of each of the 35 recipes, and `.merge(style)` as the last call.
  Mirror `packages/remix_cli/lib/src/registry/templates/button/button.dart.tmpl`.
- Twelve recipes already declare a local named `style`: `button`, `chart`,
  `code`, `divider`, `heading`, `icon_button`, `kbd`, `link`, `select`,
  `text`, `textfield`, `toggle`. Rename those locals first.
- Remove the four unused `naked_ui` imports (`accordion`, `disclosure`,
  `slider`, `tabs`; verified unused with the analyzer) and the four direct
  `mix` imports (`chart`, `base_button`, `computed`, and the theme files).
  `remix` re-exports `mix` in full. This is a precondition for PR 4, whose
  tool refuses those imports.
- Regenerate the `.g.dart` parts. The generator adds `style` to every named
  constructor.
- Test: for Button, Checkbox, and TextField, a `style` that sets one idle
  property wins over the recipe, and a hover fragment in `style` wins over
  the recipe's hover fragment. Extend `fortal_control_matrix_test.dart` or add
  a sibling.
- Proof: `fortal:parity:check` and the package test suite.

### PR 3: `feat(remix_cli)`: preset axis

The CLI learns that more than one registry exists. Only `default` ships in
this PR, so behavior for every existing project is unchanged. This is
independent of PR 1 and PR 2.

- Move `lib/src/registry/registry.yaml` and `templates/` to
  `lib/src/registry/default/`.
- `registry.dart`: a `bundledPresets` constant listing `default`;
  `loadBundled({required String preset})` resolves
  `package:remix_cli/src/registry/<preset>/registry.yaml`; an unknown preset
  fails before any file read with a message that lists the bundled presets;
  `RegistryCatalog.preset` for messages; the unknown-item error names the
  preset.
- `project_config.dart`: `preset` field; schema 2 requires the key; schema 1
  reads as `default`; `encode()` writes schema 2; preset must match
  `^[a-z][a-z0-9_]*$` and be in `bundledPresets`.
- `cli.dart`: `init --preset <name>`, default `default`.
- `installer.dart`: `RegistryLoader` becomes
  `Future<RegistryCatalog> Function(String preset)`; `add` passes
  `config.preset`; the `init` mismatch error covers prefix, preset, and UI
  path.
- Repository tools that hardcode the old path: `tool/check_open_code.dart`,
  `tool/check_open_code_dogfood.dart`, `tool/sync_registry_remix.dart`,
  `tool/check_version_alignment.dart`, `tool/validate_docs.dart`, and
  `test/tool/check_open_code_test.dart`. Point them at `registry/default/`.
  `validate_docs.dart` matters most: it feeds `docs:check`, which the `ci`
  aggregate runs, so missing it breaks CI on the move.
- Tests: schema 1 parses as default; schema 2 without `preset` fails; bad
  preset name fails; `init --preset default` writes schema 2; `init` with a
  different preset on an existing project fails; `loadBundled` with an
  unknown preset fails with the list; the installer passes the configured
  preset to the loader; `--diff` still compares against the default tree.
- Docs: the configuration section of `docs/open-code.mdx` shows the schema 2
  file and the `--preset` flag, and drops the words "no presets".
  `packages/remix_cli/CHANGELOG.md`.

### PR 4: `feat(remix_cli)`: the Fortal preset, with its proof

Depends on PR 1, 2, and 3. The diff is mostly derived content; review the
tool, the registry rules, and the check.

- `tool/build_fortal_preset.dart` as specified above, and
  `test/tool/build_fortal_preset_test.dart` covering the refusals, the round
  trip, the dependency inference, and `--check` on a planted drift.
- The committed output: `registry/fortal/registry.yaml` and every template.
- `bundledPresets` gains `fortal`. The `remix_cli` unit tests load the
  Fortal catalog, resolve `button` to `theme`, `base_button`, `button`,
  resolve `data_table` to its four dependencies, and rely on
  `_validateGraphAndTargets` for cycles and double-owned targets.
- Melos scripts `open-code:fortal:build` and `open-code:fortal:check`, named
  like the existing `open-code:check`. The check joins the `ci` aggregate
  next to `docs:check`. `.github/workflows/version.yml` runs
  `sync_registry_remix.dart` as a shell step after `melos version`; add the
  build right after it, because the Fortal registry copies its floors from
  the default registry.
- `tool/check_open_code.dart --preset fortal`: install every Fortal item
  into a guarded temporary Flutter app with prefix `Acme`, generate without a
  consumer `build.yaml`, analyze clean, and run a smoke test from
  `open_code/fortal_fixture/` that pumps every generated widget under
  `AcmeScope` and asserts a few resolved token values against known Radix
  3.3.0 hex values. No committed expected `.g.dart`: the package already
  commits the same adapter under the `Fortal` prefix. No equivalence test
  against `FortalButton`: the byte round trip already proves the recipe is
  the same code, the same generator produces both adapters, and a temporary
  app cannot path-depend on a `resolution: workspace` package cleanly.
- Docs: a Fortal preset section in `docs/open-code.mdx` with the install and
  the ownership boundary; `open_code/README.md`; a dated "Since" note in
  `open_code/CLEAN_SHEET.md` under "What remains outside this MVP" linking
  here; `packages/remix_cli/CHANGELOG.md`.

### PR 5: `chore(remix_fortal)`: stop publishing

- `publish_to: none` in the pubspec. Remove the pub.dev publish notes from
  the pubspec comments and the package from any release automation that
  versions it.
- Delete the hosted-pin check in `tool/fortal_parity/check.dart` and drop
  `naked_ui` from the pubspec, which that check was the last reason to keep.
- `docs/fortal/*` install section shows `remix init --preset fortal` and
  drops `flutter pub add remix_fortal`.
- After merge: mark `remix_fortal` discontinued on pub.dev with the preset
  named as the replacement.

## Risks and how each PR bounds them

- **A `style` local collides with the new parameter.** Twelve recipes. PR 2
  renames them; the analyzer catches any miss.
- **A file or path still contains `fortal` after PR 1.** The derivation tool
  refuses, and PR 4's test plants one to prove the refusal.
- **Formatter drift.** The installer formats rendered output, and wrapping
  depends on prefix length, as `check_open_code_dogfood.dart` documents. The
  drift check therefore compares the template to the source, never a rendered
  file to a template.
- **Version floors diverge between presets.** The Fortal registry copies its
  constraints from the default registry at build time, and `--check` fails
  when they differ.
- **`remix.yaml` schema 2 reaches a consumer with an older CLI.** That CLI
  rejects it with its existing "unsupported schema" error. The project-local
  dev dependency pins the CLI, which is why the docs recommend it.

## Out of this stack

- `init --preset <x> --reinstall`, a batched `add --overwrite` for switching
  presets in place. shadcn does this. It is a later feature.
- Preset knobs at `init`, such as `--accent indigo --radius medium` written
  into the installed theme.
- Authoring the default preset as Dart with the same derivation. The default
  has no parity contract, so the pressure is lower. Reconsider after PR 4
  shows the tool's cost.
- Deleting `packages/remix_fortal` from the repository. That would make the
  `.tmpl` files the only form of Fortal, move the parity suite behind a
  temporary-app render, and force `apps/dashboard`, `apps/demo`,
  `apps/playground`, and 39 doc pages to migrate to installed source.
  Reconsider only if the apps migrate to the preset on their own.
