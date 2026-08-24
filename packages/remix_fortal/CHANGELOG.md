## 1.0.0-beta.6

 - **FIX**: correct dashboard showcase and checkbox indicator regressions (#162).

## 1.0.0-beta.5

> Note: This release has breaking changes.

 - **REFACTOR**(fortal): consolidate base button state styling.
 - **FIX**(ci): make the version workflow able to complete (#149).
 - **FEAT**(remix): add styler field metadata, raise Mix floor to 2.2.0-beta.5 (#158).
 - **FEAT**(fortal): add opt-in icon index and document soft AA (#155).
 - **DOCS**(fortal): reference catalog, generated from the parity manifest (#154).
 - **BREAKING** **REFACTOR**(remix): make interactive components visual-only over naked_ui (#157).
 - **BREAKING** **REFACTOR**(fortal): default unsized typography from tokens, not ambient text (#153).
 - **BREAKING** **REFACTOR**(remix): generate callable component stylers (#152).
 - **BREAKING** **FEAT**(remix): add RemixLink and rebuild FortalLink on it (#151).

## 0.1.0-beta.3

- **FEAT**: Regenerate the Fortal Select wrappers for the new trigger indicator
  icons and `mouseCursor`, so `FortalSelect` exposes `collapsedIcon`,
  `expandedIcon`, and a cursor alongside the base component.
- Raise the `remix` floor to `^1.0.0-beta.4`.

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
