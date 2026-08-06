# Material → Remix mapping table

Tiered by confidence. **Always confirm the Remix class/widget still exists and its
constructor args** against the resolved source (see
`../shared/find-remix-source.md`) before converting — names change between versions.

## Tier 1 — confident 1:1 (auto-convert + translate style)

| Material widget | Remix widget | Notes |
|---|---|---|
| `ElevatedButton`, `TextButton`, `OutlinedButton`, `FilledButton` | `RemixButton` | Map `onPressed`, `child`→`label`. Translate `style: ButtonStyle`. |
| `IconButton` | `RemixIconButton` | |
| `Checkbox` | `RemixCheckbox` | |
| `Switch` | `RemixSwitch` | |
| `Radio` | `RemixRadio` | |
| `Card` | `RemixCard` | |
| `TextField`, `TextFormField` | `RemixTextField` | Form validation semantics differ — verify. |
| `Tooltip` | `RemixTooltip` | |
| `Divider`, `VerticalDivider` | `RemixDivider` | |
| `CircularProgressIndicator` | `RemixSpinner` | Indeterminate spinner. |
| `LinearProgressIndicator` | `RemixProgress` | Determinate/bar progress. |
| `CircleAvatar` | `RemixAvatar` | |
| `AlertDialog`, `Dialog`, `showDialog` | `RemixDialog` | Confirm the show/builder API. |

## Tier 2 — near-match (do NOT auto-convert; emit a flagged TODO)

These change semantics or API shape. Leave the Material code in place and add a
`// TODO(remix-migration):` comment with the suggested target and the concrete
differences the dev must resolve.

| Material widget | Suggested Remix | Why manual |
|---|---|---|
| `DropdownButton`, `DropdownMenu` | `RemixSelect` (+ trigger/menu-item stylers) | Item/trigger model differs substantially. |
| `ExpansionTile`, `ExpansionPanelList` | `RemixAccordion` | Expansion state model differs. |
| `PopupMenuButton` | `RemixMenu` | Trigger + item composition differs. |
| `ToggleButtons` | `RemixToggle` | Single toggle vs button group. |
| `Chip`, `Badge` | `RemixBadge` | Interaction/affordance differs. |
| `TabBar` + `TabBarView` | `RemixTabs` / `RemixTabBar` / `RemixTabView` | Controller wiring differs. |
| `SnackBar`, `MaterialBanner` | `RemixCallout` | Inline vs transient overlay — not equivalent. |

## Tier 3 — no Remix equivalent (leave untouched, never convert)

Remix is a component library, not a layout/navigation framework. Do NOT touch:
`Scaffold`, `AppBar`, `Drawer`, `BottomNavigationBar`, `NavigationRail`,
`ListView`, `GridView`, `Column`, `Row`, `Stack`, `Padding`, `Container`,
`SizedBox`, `Expanded`, `Flexible`, navigation/routing, `SnackBar` *scheduling*,
gesture/scroll widgets, and any Material widget not listed in Tier 1/2.
