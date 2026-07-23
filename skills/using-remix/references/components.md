# Remix Component API Reference

This reference summarizes the current component-defining constructor contracts
under `packages/remix/lib/src/components/`. Dartdoc and the constructor source
remain authoritative for Flutter text-input pass-through fields and low-level
overlay callbacks.

Styled `Remix*` leaves accept a `Remix*Styler style` and optional raw
`Remix*Spec styleSpec`. The raw spec bypasses fluent style resolution. Most
leaves also expose `static final styleFrom = Remix*Styler.new`.

Fortal presets with variants expose named constructors. Prefer them when the
variant is known statically; retain the unnamed constructor with `variant:`
for runtime-selected variants. See `fortal-reference.md` for every variant,
size, default, and supported theme override.

## Actions

### Button

`RemixButton` accepts the established `label`, leading/trailing icon, and
builder fields or an arbitrary `Widget child`. Its behavior fields include
`onPressed`, `onLongPress`, `loading`, `loadingBuilder`, `enabled`, focus,
feedback, cursor, and semantic options. It is interactive only when
`enabled && !loading && (onPressed != null || onLongPress != null)`. Loading
preserves the child's layout and paints the spinner over hidden content.

```dart
RemixButton(
  onPressed: save,
  child: const Row(
    mainAxisSize: MainAxisSize.min,
    children: [Icon(Icons.save), Text('Save')],
  ),
)
```

`FortalButton` adds `variant`, `size`, `color`, `radius`, and `highContrast`.

### IconButton

`RemixIconButton.icon` accepts the established `IconData` form or an arbitrary
icon widget; `iconBuilder` remains available for icon data. `semanticLabel` is
optional, though a localized label should be supplied for accessibility. It
otherwise mirrors Button's loading, enabled, long-press, focus, feedback,
cursor, and semantic surface. `FortalIconButton` adds the same Fortal style
props as Button.

### Toggle

`RemixToggle` is a controlled pressable selection with required `selected`,
nullable `onChanged`, and at least one of `String? label` or `IconData? icon`.
`onChanged: null` disables it. `FortalToggle` is a Fortal extension with
`ghost` and `outline` variants.

### ToggleGroup

`RemixToggleGroup<T>` requires `items` and `selectedValue`. Each
`RemixToggleGroupItem<T>` has a unique non-null `value`, label and/or icon,
optional semantic label, enabled/focus fields, and a per-item styler. The group
supports horizontal or vertical layout, looping arrow navigation, and a group
semantic label. A null `onChanged` disables the whole group.
`FortalToggleGroup<T>` is a Fortal extension.

## Forms

### Checkbox

`RemixCheckbox` requires nullable `selected`, supports `tristate`, and calls
`ValueChanged<bool?>? onChanged`. It also accepts custom checked, unchecked,
and indeterminate icon data plus enabled/focus/semantic fields.
`FortalCheckbox` adds `classic`, `surface`, and `soft` recipes.

### Radio

`RemixRadioGroup<T>` owns `groupValue`, nullable `onChanged`, and `child`.
`RemixRadio<T>` requires `value` below that group and supports `enabled`,
`toggleable`, cursor, and focus fields. `FortalRadioGroup<T>` exposes the same
scope as `value`, `onChanged`, and `child`; `FortalRadio<T>` adds Fortal visual
props.

### Switch

`RemixSwitch` is controlled by required `selected` and nullable `onChanged`.
It also exposes enabled, feedback, focus, cursor, and semantic fields.
`FortalSwitch` adds `classic`, `surface`, and `soft` recipes.

### Slider

`RemixSlider` and `FortalSlider` retain the scalar `value`, `onChanged`,
`onChangeStart`, `onChangeEnd`, `focusNode`, `autofocus`, and `snapDivisions`
API. Their additive multi-thumb mode uses an ascending `List<double> values`
and `onValuesChanged`, `onValuesChangeStart`, and `onValuesChangeEnd`.

```dart
FortalSlider(
  values: range,
  min: 0,
  max: 100,
  step: 5,
  minSpacing: 10,
  orientation: Axis.horizontal,
  onValuesChanged: (values) => setState(() => range = values),
)
```

`min < max`, `step > 0`, and `minSpacing >= 0`. `orientation`, `inverted`,
per-thumb focus nodes, an autofocus thumb index, semantic labels/formatters,
feedback, cursor, and hover/drag/focus callbacks are supported. In scalar mode,
the 0–1 range remains the default; multi-thumb mode defaults to 0–100.

### TextField

`RemixTextField` exposes the normal Flutter editable-text surface plus Remix
fields `label`, `hintText`, `helperText`, `error`, `leading`, `trailing`,
`semanticLabel`, `semanticHint`, and `excludeSemantics`. `error: true` supplies
`WidgetState.error`; disabled and error visuals are state-driven. The widget
forwards controller, focus, keyboard, selection, formatting, line/length,
scrolling, tap/outside-tap, autofill, undo, spell-check, context-menu, and
restoration fields. `FortalTextField` mirrors this behavior and adds theme
props.

### Select

`RemixSelect<T>` and `FortalSelect<T>` require:

- `RemixSelectTrigger trigger`, containing a required placeholder and optional
  leading icon.
- `List<RemixSelectItemData<T>> items`.

Item types are `RemixSelectItem<T>`, `RemixSelectGroup<T>`,
`RemixSelectLabel<T>`, and `RemixSelectSeparator<T>`. Items carry value, label,
enabled/semantic fields, and an optional row style. The Select also accepts
`selectedValue`, nullable `onChanged`, open/close callbacks, `enabled`,
`closeOnSelect`, focus, semantics, and `OverlayPositionConfig`. Nullable `open`
selects uncontrolled or owner-controlled overlay state; `onOpenChanged`
reports requests without overriding an owner's rejected value. When `onChanged`
is null but `enabled` is true, the popup remains browsable but does not commit
a selection.

Fortal Select separates trigger and content configuration:
`triggerVariant`, `contentVariant`, `size`, `triggerColor`, `triggerRadius`,
`contentColor`, and `contentHighContrast`.

## Data display

### Avatar

`RemixAvatar` supports foreground/background `ImageProvider`s and error
callbacks, arbitrary `child`, string or builder fallback labels, and icon or
builder fallback icons. `FortalAvatar` adds sizes 1–9, `soft`/`solid`, color,
radius, and high contrast; its string fallback is normalized to uppercase.

### Badge

`RemixBadge` accepts the established `label`/`labelBuilder` API or arbitrary
`Widget child`; arbitrary content inherits resolved text and icon styles.
`FortalBadge` adds variant, size, color, radius, and high contrast.

### Card

`RemixCard` has optional `child`. `onTap` or `onLongPress` makes it an
interactive Naked button with enabled, focus, cursor, feedback, hover/press,
and semantics fields. With neither callback it remains a passive container and
does not acquire button semantics. `FortalCard` adds `surface`, `classic`, or
`ghost` and sizes 1–5. A card used as a `RemixPopover` trigger inherits
`WidgetState.selected` while the overlay is open; the Fortal recipe maps it to
the Radix open treatment and gives open precedence over pressed.

### Callout

`RemixCallout` accepts established `text` and `IconData icon` values or an
arbitrary `child` and `iconWidget`. `FortalCallout` adds variant, size, color,
and high contrast.

### Progress

`RemixProgress` accepts nullable `value`, `max` (default 1), indeterminate
animation `duration`, and semantic fields. Null is indeterminate; determinate
values must be in `0...max`. `FortalProgress` adds variant, size, color, radius,
and high contrast.

### Spinner

`RemixSpinner` accepts `loading` (default true), optional `child`, and semantic
fields. When not loading it returns the child; while loading it preserves child
layout. `FortalSpinner` adds sizes 1–3.

### Divider

`RemixDivider` accepts `orientation`, `decorative` (default true), and an
optional semantic label. `FortalDivider` adds sizes 1–4 and optional accent
color; every size remains one logical pixel thick and changes length.

## Overlays

### Dialog

`showRemixDialog<T>` installs the modal route. `RemixDialog` composes optional
`title`, `description`, `child`, and `actions`; a lone child remains a fully
custom body. It accepts modal/alignment, width/height constraints, inset
padding, and semantics. `FortalDialog` adds size and `start`/`center` alignment,
defaults to `width: infinity` and `maxWidth: 600`, and replays the active
Fortal/Mix scopes through Navigator overlays.

### Popover

`RemixPopover` requires trigger `child` and overlay `popoverChild`. It supports
width/height constraints, optional trigger-width matching, positioning,
an optional separate keyed positioning anchor, outside-tap/root-overlay
behavior, controlled callbacks/controller, focus, and semantics.
`FortalPopover` adds sizes 1–4, defaults to `maxWidth: 480`, matches the trigger
width, and intentionally has no arrow.

### Tooltip

`RemixTooltip` requires trigger `child` and `tooltipChild`, and supports
controlled open state, positioning, touch/hover behavior, animations,
root-overlay use, width constraints, semantics, and optional arrow geometry.
`FortalTooltip` defaults to a 200 ms wait, 360 px maximum width, and a styled
arrow.

### Menu

`RemixMenu<T>` and `FortalMenu<T>` require arbitrary trigger `Widget` and
`List<Widget> items`. Supported items are:

- `RemixMenuAction<T>`
- `RemixMenuCheckboxItem<T>`
- `RemixMenuGroup` and `RemixMenuLabel`
- `RemixMenuSeparator`
- `RemixMenuRadioGroup<T>` and `RemixMenuRadioItem<T>`
- recursive `RemixMenuSubmenu<T>`

The menu forwards selection and lifecycle callbacks, root/outside-tap behavior,
controller/focus options, root and submenu positioning, and semantics. Actions
and check/radio items control whether activation closes the menu. Fortal Menu
adds content variant, size, color, and high contrast.

## Navigation and disclosure

### Tabs

`RemixTabs` is the behavioral root with `selectedTabId`, nullable `onChanged`,
`activationMode` (`automatic` or `manual`), orientation, and `child`. Below it,
`RemixTabBar`/`FortalTabBar` retain arbitrary `Widget child` and additionally
accept `List<Widget> children` for wrap/justify configuration;
`RemixTab`/`FortalTab` require `tabId` and accept arbitrary
child or label/icon content; `RemixTabView`/`FortalTabView` require `tabId` and
child and can maintain inactive state. There is no `FortalTabs`.

### Accordion

`RemixAccordionGroup<T>` requires a `RemixAccordionController<T>` and child.
Each `RemixAccordion<T>`/`FortalAccordion<T>` requires `value` and content
`child`, with optional title/icons, custom trigger builder, enabled/focus/state
callbacks, semantics, and transition builder. `FortalAccordion` is a Fortal
extension with variant, size, color, and radius.
