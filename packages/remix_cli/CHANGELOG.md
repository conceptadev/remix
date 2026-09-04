## 0.1.0

- Require Remix `^1.0.0-beta.8` for the generated Fortal adapters. CI checks
  both presets with checkout Remix. Publication requires the hosted check.

- Adds the `fortal` preset as application-owned source derived from the
  repository's analyzed Radix Themes 3.3.0 implementation. It installs a
  prefixed 277-token theme and full component catalog without a
  `remix_fortal`, direct `mix`, or direct `naked_ui` dependency.
- Adds a preset axis to `remix init`. New configurations use schema 2 and
  record `preset: default`; schema 1 configurations remain compatible and
  read as the default preset.
- Initial project-local CLI for installing editable Remix UI source.
- Uses the Flutter SDK and its Dart executable on Windows. CI verifies installation with the real SDK.
- Supports explicit, glob, and nested workspace members through Pub's resolved package configuration.
- Rejects reserved runtime prefixes before writing source and prints command help once.
- Preserves spaces and special characters in generation filters. Each filter selects one generated file.
- Bundles theme plus a registry item for every styled component surface in
  `remix`: accordion, avatar, badge, button, callout, card,
  checkbox, data_list,
  data_table, dialog, disclosure, divider, icon_button, link, menu, popover,
  progress, radio, segmented_control, select, skeleton, slider, spinner,
  switch, tabs, textfield, toggle, toggle_group, and tooltip.
- Adds an opt-in `icons` seam backed by `remix_ui_icons` for application-owned
  glyph aliases.
- Adds an optional `chart` item backed directly by `mix_chart`. One editable
  recipe generates line, bar, and pie adapters without depending on Fortal.
- Keeps already-installed registry adapters in a focused generation run so a
  new dependency cannot invalidate build_runner's graph and remove them.
- Every item depends on `theme`. `data_table` also depends on `checkbox`,
  `icon_button`, and `select`, because its selection column, pager, and
  page-size control are those components; `add data_table` installs all four.
- `add` reports when the resolved `remix` is newer than the version this
  registry snapshot was authored against. The install still completes;
  `--dry-run` and `--diff` never print it, because they stop before
  `flutter pub get`.
