# Remix Component Reference

Use the category that contains the component being built:

| Category | Reference | Components |
| --- | --- | --- |
| Actions | [actions.md](actions.md) | Button, IconButton, Toggle, ToggleGroup |
| Forms | [forms.md](forms.md) | Checkbox, CheckboxGroup, Radio, Switch, Slider, TextField, TextArea, Select, SegmentedControl |
| Data display | [data-display.md](data-display.md) | Avatar, Badge, Card, Callout, DataList, DataTable, Progress, Skeleton, Spinner, Divider |
| Overlays | [overlays.md](overlays.md) | Popover, Dialog, Tooltip, Menu |
| Navigation | [navigation.md](navigation.md) | Tabs, Accordion, Disclosure |
| Typography | [fortal.md](fortal.md#typography) | Text, Heading, Code, Kbd, Link — Fortal only |

Every styled leaf `Remix*` widget accepts `style` (a `*Styler`) and
`styleSpec` (an optional resolved `Remix*Spec`). Behavioral roots and groups
such as `RemixTabs`, `RemixRadioGroup`, `RemixCheckboxGroup`, and
`RemixAccordionGroup` do not have a styler.

Fortal cross-references name APIs from the application-owned Fortal preset.
Read [fortal.md](fortal.md) for setup, variants, sizes, and tokens.
