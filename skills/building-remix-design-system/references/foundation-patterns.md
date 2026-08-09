# Foundation runtime patterns

The foundation layer turns generated tokens into a runtime API. The patterns
below are system-agnostic; the code sketches use a placeholder system named
"Acme" — substitute the target system's name and concepts.

## Table of Contents

- [Theme and token maps](#theme-enum--token-map-builder-sys_themedart)
- [Scope](#scope-sys_scopedart)
- [Contextual scopes](#contextualindexed-scopes-layers-elevation-levels-)
- [Size and density](#sizedensity-scope-sys_layout_scopedart)
- [Responsive type](#responsivefluid-type-sys_typedart)
- [Motion](#motion-sys_motiondart)
- [Mix API cheatsheet](#mix-api-cheatsheet-verified-against-mix-21)

## Theme enum + token map builder (`<sys>_theme.dart`)

```dart
enum AcmeTheme {
  light, dark, highContrast;
  Brightness get brightness => ...;   // map each theme to light/dark
}
```

Build the `MixScope` token map from the generated finals, **cached per theme**:

```dart
final Map<AcmeTheme, Map<MixToken, Object>> _baseTokenMaps = {};

Map<MixToken, Object> _baseTokenMapFor(AcmeTheme theme) {
  return _baseTokenMaps.putIfAbsent(theme, () => Map.unmodifiable({
    ...switch (theme) { /* per-theme role + component color finals */ },
    ...acmeSpacingValues,      // theme-independent finals
    ...acmeTextStyleTokens,
    ...acmeDurationValues,
    ...acmeFontWeightValues,
  }));
}

Map<MixToken, Object> buildAcmeTokenMap(AcmeTheme theme,
    {AcmeThemeOverrides overrides = const AcmeThemeOverrides()}) {
  final base = _baseTokenMapFor(theme);
  if (/* overrides empty */) return base;      // identical instance!
  return {...base, /* fontFamily-rewritten text styles */, ...overrides.colors};
}
```

Why it matters: the scope is a `StatelessWidget`; any ancestor rebuild re-runs
`build()`. Returning the identical cached instance lets `MixScope`'s
dependents short-circuit on `identical()` instead of deep-comparing hundreds
of entries per frame.

**Overrides objects need value equality.** `updateShouldNotify` compares them;
without `==`/`hashCode` (use `mapEquals` for the color map) every rebuild
notifies every dependent.

## Scope (`<sys>_scope.dart`)

An `InheritedWidget` above a `MixScope`:

```dart
class AcmeScope extends StatelessWidget {
  // theme, overrides, orderOfModifiers, child
  static AcmeTheme? maybeThemeOf(BuildContext context) => ...;
  static AcmeTheme themeOf(BuildContext context) => ...;       // asserts
  static AcmeThemeOverrides overridesOf(BuildContext context) => ...;
}
```

**Everything configurable on the scope must be readable back via a static
accessor.** A classic review finding: a `fontFamily` override that reached
fixed text tokens but not fluid type or component labels — because nothing
could read the override from context. `overridesOf` closes that class of bug:
any helper that builds `TextStyle`s reads the scope's setting as its default.

## Contextual/indexed scopes (layers, elevation levels, …)

If the system defines leveled tokens (e.g. layered surface colors 1–3):

- The scope **increments** its parent level by default; the "no scope" state
  is the page itself, i.e. **level 1** — so the *first* scope in a tree
  resolves to level 2. Off-by-one here makes a single scope a silent no-op
  (`?? 1`, not `?? 0`, for the missing-parent default).
- Alias → indexed-token resolution is a `static const
  Map<AliasEnum, List<Token>>`, one line per alias, indexed by
  `level.clamp(1, n).toInt() - 1`. No per-call list allocation.
- The alias enum must be **tested against the generated grouping**
  (the `<sys>IndexedRoleFamilies` map emitted by the generator) so a source
  addition fails a test instead of silently becoming unreachable.

## Size/density scope (`<sys>_layout_scope.dart`)

```dart
enum AcmeSize { xs, sm, md, lg, xl, x2l;
  double get height => acmeControlSizePx[_key]!;   // generated map
  AcmeSize clampTo(AcmeSize min, AcmeSize max) =>
      AcmeSize.values[index.clamp(min.index, max.index).toInt()];
}
```

- Provide **both `of` (defaulted) and `maybeOf` (nullable)**. A component
  whose own default differs from the scope default (e.g. Button defaults `lg`
  while the layout scope defaults `md`) needs `maybeOf` to tell "no scope"
  from "scope default":

  ```dart
  final size = widget.size ?? AcmeLayoutScope.maybeOf(context)?.size ?? AcmeSize.lg;
  ```

- Any enum→generated-map string bridge gets a test iterating every enum value
  (a source key rename must fail in tests, not at first widget build).

## Responsive/fluid type (`<sys>_type.dart`)

- Fixed styles are plain Mix `TextStyleToken`s — nothing to build here.
- Fluid styles resolve against viewport width with **cumulative** breakpoint
  overrides, using a single merge rule (one `<Sys>TextStyleData.merge`) —
  never two copies of the field-coalescing logic.
- Name-keyed lookups **throw `ArgumentError` in all build modes**. An
  `assert` + silent fallback ships typos as plausible-looking wrong text.
- The context-taking helper reads the scope's font family as its default:

  ```dart
  final family = fontFamily ?? AcmeScope.overridesOf(context).fontFamily;
  ```

## Motion (`<sys>_motion.dart`)

- Emit curves as generated `Cubic` constants; expose an intent/mode accessor.
- Provide reduced-motion helpers and route recipes through them:

  ```dart
  static bool reducedMotionOf(BuildContext c) =>
      MediaQuery.maybeOf(c)?.disableAnimations ?? false;
  static Duration duration(BuildContext c, Duration v) =>
      reducedMotionOf(c) ? Duration.zero : v;
  ```

- If no component consumes motion yet, say so in the worksheet's
  approximations — don't let docs imply animated transitions exist.

## Mix API cheatsheet (verified against mix 2.1)

| Need | API |
| --- | --- |
| token value inside a styler chain | `AcmeTokens.spacing05()` (i.e. `token.call()`) |
| token → concrete value in a widget | `AcmeTokens.background.resolve(context)` |
| text-style token into a TextStyler | `TextStyler().style(AcmeTokens.bodyCompact01.mix())` |
| provide tokens to a subtree | `MixScope(tokens: Map<MixToken, Object>, child: …)` |
| tokens as map keys | runtime maps only — Mix tokens override `==`, so **const maps are a compile error** |
