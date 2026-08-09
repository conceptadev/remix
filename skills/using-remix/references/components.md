# Remix Component Reference

Use the category that contains the component being built:

| Category | Reference | Components |
| --- | --- | --- |
| Actions | [actions.md](actions.md) | Button, IconButton, Toggle, ToggleGroup |
| Forms | [forms.md](forms.md) | Checkbox, CheckboxGroup, Radio, Switch, Slider, TextField, TextArea, Select, SegmentedControl |
| Data display | [data-display.md](data-display.md) | Avatar, Badge, Card, Callout, DataList, DataTable, Progress, Skeleton, Spinner, Divider |
| Overlays | [overlays.md](overlays.md) | Popover, Dialog, Tooltip, Menu |
| Navigation | [navigation.md](navigation.md) | Tabs, Accordion |

Every styled leaf `Remix*` widget accepts `style` (a `*Styler`) and
`styleSpec` (an optional resolved `Remix*Spec`). Behavioral roots and groups
such as `RemixTabs`, `RemixRadioGroup`, `RemixCheckboxGroup`, and
`RemixAccordionGroup` do not have a styler.

Fortal cross-references name APIs from the separate `remix_fortal` package.
Read [fortal.md](fortal.md) for setup, presets, variants, sizes, and tokens.
