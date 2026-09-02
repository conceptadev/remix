## 0.1.0

- Initial project-local CLI for installing editable Remix UI source.
- Bundles theme plus a registry item for every styled component surface in
  `remix` 1.0.0-beta.7: accordion, avatar, badge, button, callout, card,
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
