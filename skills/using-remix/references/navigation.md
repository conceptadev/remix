# Navigation Components

Constructor details for Remix tabs and accordions. Fortal widgets mentioned here live in the separate `remix_fortal` package; see [Fortal](fortal.md).

## Components

### RemixTabs

Behavioral root — no `style`/`styleSpec`. There is no `FortalTabs`; use
`RemixTabs` directly.

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `child` | `Widget` | — | yes |
| `selectedTabId` | `String?` | `null` | \* |
| `controller` | `NakedTabController?` | `null` | \* |
| `onChanged` | `ValueChanged<String>?` | `null` | no |
| `orientation` | `Axis` | `Axis.horizontal` | no |
| `enabled` | `bool` | `true` | no |
| `onEscapePressed` | `VoidCallback?` | `null` | no |

\* Either `controller` or `selectedTabId` must be provided.

### RemixTabBar

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `child` | `Widget` | — | yes |

Fortal preset: `FortalTabBar` — no variant/size.

### RemixTab

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `tabId` | `String` | — | yes |
| `label` | `String?` | `null` | \* |
| `icon` | `IconData?` | `null` | no |
| `child` | `Widget?` | `null` | \* |
| `builder` | `ValueWidgetBuilder<NakedTabState>?` | `null` | \* |
| `enabled` | `bool` | `true` | no |
| `autofocus` | `bool` | `false` | no |
| `mouseCursor` | `MouseCursor` | `SystemMouseCursors.click` | no |
| `enableFeedback` | `bool` | `true` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `onFocusChange` / `onHoverChange` / `onPressChange` | callbacks | `null` | no |
| `semanticLabel` | `String?` | `null` | no |

\* At least one of `child`, `builder`, or `label` must be provided.

Fortal preset: `FortalTab` — size (`size1–size2`), no variant.

### RemixTabView

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `tabId` | `String` | — | yes |
| `child` | `Widget` | — | yes |

Fortal preset: `FortalTabView` — no variant/size.

### RemixAccordionGroup\<T\>

Purely behavioral — no `style`/`styleSpec`. `controller` is **required**
(unlike Tabs/Menu, no auto-created default):
`RemixAccordionController<String>(min: 0, max: 1)`.
(`RemixAccordionController<T>` is a typedef for `NakedAccordionController<T>`.)

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `controller` | `RemixAccordionController<T>` | — | yes |
| `child` | `Widget` | — | yes |
| `initialExpandedValues` | `List<T>` | `[]` | no |

### RemixAccordion\<T\>

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `value` | `T` | — | yes |
| `child` | `Widget` | — | yes (panel content) |
| `title` | `String?` | `null` | \* |
| `builder` | `NakedAccordionTriggerBuilder<T>?` | `null` | \* |
| `leadingIcon` / `trailingIcon` | `IconData?` | `null` | no |
| `enabled` | `bool` | `true` | no |
| `mouseCursor` | `MouseCursor` | `SystemMouseCursors.click` | no |
| `enableFeedback` | `bool` | `true` | no |
| `autofocus` | `bool` | `false` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `onFocusChange` / `onHoverChange` / `onPressChange` | callbacks | `null` | no |
| `semanticLabel` | `String?` | `null` | no |
| `transitionBuilder` | `Widget Function(Widget, Animation<double>)` | fade + size | no |

\* Either `title` or `builder` must be provided.

Fortal preset: `FortalAccordion<T>` — `variant` (`surface|soft`), `size`
(`size1–size3`).
