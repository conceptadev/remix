# Navigation Components

Constructor details for Remix tabs, accordions, and disclosures. Fortal widgets mentioned here live in the separate `remix_fortal` package; see [Fortal](fortal.md).

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

Anatomy — one panel, two parts. `container` owns the shared frame (fill,
border, radius, clipping); `trigger` owns the header row's internal layout;
`content` owns the expanded body's padding and its interior divider. Because
the container supplies the rounding, an expanded trigger meets its content
with no notch. `containerEffects` paints layered fills, strokes, and backdrop
blur with the container.

The top-level Box shorthand (`.color()`, `.padding()`, `.borderRadius()`, ...)
forwards to `trigger`, not `container` — reach `.container(...)` explicitly for
the outer frame.

Widget-state variants (`onHovered`, `onPressed`, `onFocused`,
`onFocusVisible`, `onDisabled`) describe interaction with the **trigger** but
resolve once for the whole item, so they may style `container` too. The
expanded content is not a separate hover/press target.

Each item is its own bordered panel, so space adjacent items
(`Column(spacing: 8, ...)`) instead of expecting a shared divider.

Fortal preset: `FortalAccordion<T>` — `variant` (`surface|soft`), `size`
(`size1–size3`).

### RemixDisclosure

Standalone trigger and one inline panel. Use this when items do not need
`RemixAccordionGroup` coordination.

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `trigger` | `Widget` | — | yes |
| `content` | `Widget` | — | yes |
| `triggerBuilder` | `ValueWidgetBuilder<NakedDisclosureState>?` | `null` | no |
| `expanded` | `bool?` | `null` | no |
| `defaultExpanded` | `bool` | `false` | no |
| `onExpandedChanged` | `ValueChanged<bool>?` | `null` | no |
| `enabled` | `bool` | `true` | no |
| `semanticLabel` / `semanticHint` | `String?` | `null` | no |
| `animationStyle` | `AnimationStyle` | 200ms ease | no |
| `transitionBuilder` | `NakedDisclosureTransitionBuilder` | fade + size | no |

Omit `expanded` for uncontrolled state. Top-level Box shorthand forwards to
`trigger`; style the frame with `.container(...)`.

Fortal preset: `FortalDisclosure` — `variant` (`surface|soft`), `size`
(`size1–size3`).
