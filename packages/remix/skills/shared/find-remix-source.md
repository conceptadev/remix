# Finding & reading Remix source (shared reference)

All three Remix skills (`remix-theming`, `remix-component-styling`,
`remix-material-migration`) share this file. It is the single source of truth for
**how to locate the installed Remix package and read its real API** so we never
hallucinate class or method names.

> **Golden rule:** Remix's public names are *not* uniform and change between
> releases. NEVER trust names from memory, the README, or another skill's
> examples. Confirm every class and method against the source in the consuming
> repo's resolved version before emitting code.

## 1. Locate the installed package

The consuming app depends on `remix` via pub. Resolve the exact version and path:

```bash
# The resolved version the app actually uses:
grep -A3 '^  remix:' pubspec.lock

# Path to the source in the pub cache (hosted dep):
ls "$HOME/.pub-cache/hosted/pub.dev/" | grep '^remix-'
# -> e.g. remix-4.2.0  =>  $HOME/.pub-cache/hosted/pub.dev/remix-4.2.0/lib
```

For a git or path dependency, read the `packages:` / `packageConfig` entry:

```bash
cat .dart_tool/package_config.json | grep -A2 '"name": "remix"'
```

Use the `rootUri` from `package_config.json` as the authoritative source location —
it is correct for hosted, git, and path dependencies. `<remix-root>/lib` below
means that resolved directory.

## 2. Source layout (stable structure)

```
<remix-root>/lib/
  remix.dart                       # public exports — the API allowlist
  src/
    components/<name>/             # one dir per component
      <name>.dart                  # library file (part-of hub)
      <name>_widget.dart           # the RemixX widget + its constructor args
      <name>_style.dart            # hand-written chainable style helpers
      <name>.g.dart                # generated styler class + .animate() etc.
    theme/remix_theme.dart         # brightness / theme resolution
    fortal/                        # Fortal design-system preset (Radix-based)
      fortal.dart                  # entrypoint export
      fortal_theme.dart            # FortalTokens + scope builder
    radix/colors/                  # Radix color swatches
```

`remix.dart` re-exports `package:mix/mix.dart` and part of `naked_ui`, so Mix
styling primitives (`EdgeInsetsGeometryMix`, `AnimationConfig`, `Prop`, …) are
available through `package:remix/remix.dart`.

## 3. Confirming the class name for a component

Styler class names are **inconsistent** — do not assume `RemixXStyle`:

```bash
# List every real styler class name:
grep -rhoE 'class Remix[A-Za-z]+(Styler|Style)\b' \
  <remix-root>/lib/src/components/*/*.g.dart \
  <remix-root>/lib/src/components/*/*_style.dart | sed 's/class //' | sort -u
```

Known inconsistencies at time of writing (verify against the resolved version):
`RemixButtonStyler` (the `-Styler` suffix), but `RemixCardStyle`,
`RemixCheckboxStyle`, … (the `-Style` suffix); `select` splits into
`RemixSelectStyle`, `RemixSelectTriggerStyle`, `RemixSelectMenuItemStyle`.

## 4. Confirming available chainable methods

The style API is spread across `<name>_style.dart` (hand-written) and
`<name>.g.dart` (generated). To list what a component actually supports:

```bash
grep -rhoE 'Remix[A-Za-z]+Styler? [a-zA-Z]+\(' \
  <remix-root>/lib/src/components/<name>/*.dart | sort -u
```

Durable API shapes (still confirm per version):
- Layout/paint: `.color(Color)`, `.paddingX/Y/All(double)`, `.borderRadiusAll(Radius)`.
- Animation: `.animate(AnimationConfig)` (e.g. `AnimationConfig.spring(300.ms)`).
- **State variants take another styler instance**, not a callback:
  `.onHovered(RemixButtonStyler().color(...))`, plus `.onPressed`, `.onFocused`,
  `.onDisabled`. Confirm which states a given component exposes.
- Construct an empty styler with the class's default constructor
  (`RemixButtonStyler()`); some expose `.create(...)` and a `styleFrom` static.

## 5. Confirming widget constructor args

```bash
grep -nE 'const Remix[A-Za-z]+\(|required this|this\.[a-z]' \
  <remix-root>/lib/src/components/<name>/<name>_widget.dart
```

The widget takes the style via a `style:` parameter typed as its styler class.

## 6. Version check

Compare this skill bundle's version against the app's resolved `remix` version
(`pubspec.lock`, step 1). If they differ, rely entirely on the steps above —
do not trust any concrete name written in the skill bodies.
