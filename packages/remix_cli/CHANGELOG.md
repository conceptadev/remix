## 0.1.0

- Initial project-local CLI for installing editable Remix UI source.
- Bundles a registry item for every component in `remix` 1.0.0-beta.7: theme
  plus accordion, avatar, badge, button, callout, card, checkbox, data_list,
  data_table, dialog, disclosure, divider, icon_button, link, menu, popover,
  progress, radio, segmented_control, select, skeleton, slider, spinner,
  switch, tabs, textfield, toggle, toggle_group, and tooltip.
- Every item depends on `theme`. `data_table` also depends on `checkbox`,
  `icon_button`, and `select`, because its selection column, pager, and
  page-size control are those components; `add data_table` installs all four.
