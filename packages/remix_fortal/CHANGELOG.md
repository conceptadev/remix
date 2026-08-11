## 0.1.0-beta.1

- **FEAT**: Add Fortal-themed line, bar, and pie chart recipes and generated
  widgets backed by `mix_chart`.
- **FIX**: Match the pinned Radix Themes dialog and popover layout defaults.
  `FortalDialog` now defaults to centered placement, exposes `start` and
  `center` alignment options, fills up to 600 pixels, and preserves safe
  viewport insets;
  `FortalPopover` has a 480-pixel maximum width.
- Initial release. Fortal — the Radix Themes-inspired preset theme for
  [Remix](https://pub.dev/packages/remix) — now ships as its own package.
  `FortalScope`, `FortalTokens`, the `Fortal*` widgets, and the `fortal*Style()`
  recipes were extracted from `remix` so that `remix` stays theme-free.
