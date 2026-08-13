## 0.1.0-beta.2

- **FEAT**: Add Fortal-themed line, bar, and pie chart recipes and generated
  widgets backed by `mix_chart`.
- **FIX**: Match the pinned Radix Themes dialog and popover layout defaults.
  `FortalDialog` now defaults to centered placement, exposes `start` and
  `center` alignment options, fills up to 600 pixels, and preserves safe
  viewport insets;
  `FortalPopover` has a 480-pixel maximum width.
- **FEAT**: Complete the five typography families — `FortalText`,
  `FortalHeading`, `FortalCode`, `FortalKbd`, and `FortalLink` — sharing one
  nine-step `FortalTextSize` scale and one `FortalTextWeight` enum.
- **FEAT**: `FortalScope` establishes the Radix theme root's default text run
  (`text3` at `gray-12`, regular weight), so an unsized `FortalText`,
  `FortalCode`, `FortalKbd`, or `FortalLink` resolves `1em` the way upstream
  does. Only the outermost scope does this; a nested scope re-scopes tokens and
  inherits the closest text style. Under `MaterialApp` or `CupertinoApp` the
  scope belongs in `builder:`.
- **FEAT**: Add `FortalCheckboxGroupItem` and share the focus ring.
- **FEAT**: Add Fortal typography recipes.
- **FIX**: Restore dialog and popover layout defaults.
- Raise the `remix` floor to `^1.0.0-beta.3`.

## 0.1.0-beta.1

- Initial release. Fortal — the Radix Themes-inspired preset theme for
  [Remix](https://pub.dev/packages/remix) — now ships as its own package.
  `FortalScope`, `FortalTokens`, the `Fortal*` widgets, and the `fortal*Style()`
  recipes were extracted from `remix` so that `remix` stays theme-free.
