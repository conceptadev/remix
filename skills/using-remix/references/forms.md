# Form Components

Constructor details for Remix form controls. Fortal widgets mentioned here live in the separate `remix_fortal` package; see [Fortal](fortal.md).

## Table of Contents

- [Checkbox](#remixcheckbox)
- [Checkbox group](#remixcheckboxgroupt)
- [Checkbox group item](#remixcheckboxgroupitemt)
- [Radio group](#remixradiogroupt)
- [Radio](#remixradiot)
- [Switch](#remixswitch)
- [Slider](#remixslider)
- [Text field](#remixtextfield)
- [Text area](#remixtextarea)
- [Select](#remixselectt)
- [Segmented control](#remixsegmentedcontrolt)

## Components

### RemixCheckbox

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `selected` | `bool?` | — | yes |
| `onChanged` | `ValueChanged<bool?>?` | `null` | no |
| `enabled` | `bool` | `true` | no |
| `tristate` | `bool` | `false` | no |
| `checkedIcon` | `IconData` | `Icons.check_rounded` | no |
| `uncheckedIcon` | `IconData?` | `null` | no |
| `indeterminateIcon` | `IconData` | `Icons.horizontal_rule` | no |
| `autofocus` | `bool` | `false` | no |
| `enableFeedback` | `bool` | `true` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `label` | `String?` | `null` | no |
| `semanticLabel` | `String?` | `null` | no |
| `minimumTapTargetSize` | `Size` | `Size.square(48)` | no |
| `mouseCursor` | `MouseCursor` | `SystemMouseCursors.click` | no |

The visible `label` is inside the pointer/focus/single-semantics target;
`semanticLabel` overrides its accessible name. `Size.zero` explicitly opts out
of the default minimum target. Fortal preset: `FortalCheckbox` — `variant`
(`classic|surface|soft`), `size` (`size1–size3`), preserving 14/16/20 visual squares
inside the 48px target.

### RemixCheckboxGroup\<T\>

Purely behavioral — no `style`/`styleSpec` and no layout; the `child` owns the
Row/Column, while each item owns its visible label and is styled individually.
`values` is controlled and every callback receives a new unmodifiable set.
`T extends Object`, so nullable value types cannot compile.

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `values` | `Set<T>` | — | yes |
| `child` | `Widget` | — | yes |
| `onChanged` | `ValueChanged<Set<T>>?` | `null` | no (null disables the group) |
| `enabled` | `bool` | `true` | no |
| `isRequired` | `bool` | `false` | no (needs a nonblank `semanticLabel` unless `excludeSemantics`) |
| `semanticLabel` | `String?` | `null` | no (must be nonblank when provided) |
| `excludeSemantics` | `bool` | `false` | no |

### RemixCheckboxGroupItem\<T\>

Must be a descendant of a matching `RemixCheckboxGroup<T>` (throws otherwise).
Composes `RemixCheckbox`, so `CheckboxStyler`/`fortalCheckboxStyle()` styles it.
No `tristate`: set membership is binary.

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `value` | `T` | — | yes |
| `label` | `String` | — | yes (must not be blank) |
| `semanticLabel` | `String?` | `null` | no (nonblank accessible-name override) |
| `enabled` | `bool` | `true` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `autofocus` | `bool` | `false` | no |
| `checkedIcon` | `IconData` | `Icons.check_rounded` | no |
| `uncheckedIcon` | `IconData?` | `null` | no |
| `enableFeedback` | `bool` | `true` | no |
| `minimumTapTargetSize` | `Size` | `Size.square(48)` | no |
| `mouseCursor` | `MouseCursor` | `SystemMouseCursors.click` | no |

The indicator, label gap, visible label, and padded edge are one interaction
and semantics target. The visible label supplies the accessible name unless
`semanticLabel` overrides it; no outer `Row`/`ExcludeSemantics` label pattern
is needed.

Keyboard: every enabled option is an ordinary Tab stop in widget order, and
Space/Enter toggle the focused option. Unlike Radix Themes, the group does not
rove focus with arrow keys. Disabled options are skipped in traditional Tab
traversal but stay focusable (never activatable) under
`NavigationMode.directional`.

### RemixRadioGroup\<T\>

Purely behavioral — no `style`/`styleSpec`; each `RemixRadio` is styled
individually.

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `groupValue` | `T?` | — | yes |
| `onChanged` | `ValueChanged<T?>?` | `null` | no (null disables the group) |
| `child` | `Widget` | — | yes |

### RemixRadio\<T\>

Must be a descendant of `RemixRadioGroup<T>` (throws otherwise).

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `value` | `T` | — | yes |
| `enabled` | `bool` | `true` | no |
| `toggleable` | `bool` | `false` | no |
| `autofocus` | `bool` | `false` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `mouseCursor` | `MouseCursor?` | `null` | no |

Fortal preset: `FortalRadio<T>` — `variant` (`classic|surface|soft`), `size`
(`size1–size3`). Still must sit inside a `RemixRadioGroup<T>`.

### RemixSwitch

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `selected` | `bool` | — | yes |
| `onChanged` | `ValueChanged<bool>?` | `null` | no |
| `enabled` | `bool` | `true` | no |
| `enableFeedback` | `bool` | `true` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `autofocus` | `bool` | `false` | no |
| `semanticLabel` | `String?` | `null` | no |
| `mouseCursor` | `MouseCursor` | `SystemMouseCursors.click` | no |

Fortal preset: `FortalSwitch` — `variant` (`classic|surface|soft`), `size`
(`size1–size3`).

### RemixSlider

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `value` | `double` | — | yes (must be within `min..max`) |
| `onChanged` | `ValueChanged<double>?` | `null` | no |
| `min` | `double` | `0.0` | no |
| `max` | `double` | `1.0` | no |
| `enabled` | `bool` | `true` | no |
| `enableFeedback` | `bool` | `true` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `autofocus` | `bool` | `false` | no |
| `snapDivisions` | `int?` | `null` | no |
| `onChangeStart` | `ValueChanged<double>?` | `null` | no |
| `onChangeEnd` | `ValueChanged<double>?` | `null` | no |

Fortal preset: `FortalSlider` — `variant` (`classic|surface|soft`), `size`
(`size1–size3`).

### RemixTextField

Remix-specific parameters:

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `controller` | `TextEditingController?` | `null` | no |
| `label` | `String?` | `null` | no |
| `hintText` | `String?` | `null` | no |
| `helperText` | `String?` | `null` | no |
| `error` | `bool` | `false` | no |
| `leading` | `Widget?` | `null` | no |
| `trailing` | `Widget?` | `null` | no |
| `enabled` | `bool` | `true` | no |
| `semanticLabel` | `String?` | `null` | no |
| `semanticHint` | `String?` | `null` | no |
| `excludeSemantics` | `bool` | `false` | no |

Plus the standard Flutter text-input surface, passed through: `focusNode`,
`keyboardType`, `textInputAction`, `textCapitalization`, `textDirection`,
`readOnly`, `showCursor`, `autofocus`, `obscureText`, `obscuringCharacter`,
`autocorrect`, `enableSuggestions`, `smartDashesType`, `smartQuotesType`,
`maxLines` (default `1`), `minLines`, `expands`, `maxLength`,
`maxLengthEnforcement`, `onChanged`, `onEditingComplete`, `onSubmitted`,
`onAppPrivateCommand`, `inputFormatters`, `dragStartBehavior`,
`enableInteractiveSelection`, `selectionControls`, `onTap`, `onTapOutside`,
`onPressUpOutside`, `onTapAlwaysCalled`, `scrollController`, `scrollPhysics`,
`autofillHints`, `contentInsertionConfiguration`, `clipBehavior`,
`restorationId`, `stylusHandwritingEnabled`,
`enableIMEPersonalizedLearning`, `contextMenuBuilder`,
`spellCheckConfiguration`, `magnifierConfiguration`, `canRequestFocus`,
`ignorePointers`, `undoController`, `groupId`.

Sets `WidgetState.error` when `error == true`, enabling error-state styling.
Semantics use `semanticLabel ?? label`, `semanticHint ?? hintText`, and expose
`helperText` as the semantic error text only when `error` is true.

Fortal preset: `FortalTextField` — mirrors the entire param list plus
`variant` (`classic|surface|soft`), `size` (`size1–size3`).

### RemixTextArea

A multiline facade over `RemixTextField` with `keyboardType` defaulting to
`TextInputType.multiline`, `textInputAction` to `TextInputAction.newline`,
`minLines` to `2`, `maxLines` to `null`, and `expands`/`obscureText` fixed to
false. It otherwise accepts the text-field behavior, semantics, and styling
surface.

Fortal preset: `FortalTextArea` — `variant` (`classic|surface|soft`), `size`
(`size1–size3`).

### RemixSelect\<T\>

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `trigger` | `RemixSelectTrigger` | — | yes |
| `items` | `List<RemixSelectItem<T>>` | — | yes |
| `selectedValue` | `T?` | `null` | no |
| `onChanged` | `ValueChanged<T?>?` | `null` | no |
| `onOpen` / `onClose` | `VoidCallback?` | `null` | no |
| `enabled` | `bool` | `true` | no |
| `closeOnSelect` | `bool` | `true` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `semanticLabel` | `String?` | `null` | no |
| `positioning` | `OverlayPositionConfig` | `bottomCenter/topCenter anchors` | no |

`RemixSelectTrigger` and `RemixSelectItem<T>` are **data classes**, not
widgets:

- **RemixSelectTrigger**: `placeholder` (required), `icon` (optional).
- **RemixSelectItem\<T\>**: `value` (required), `label` (required),
  `enabled` (default true), `style` (a `SelectMenuItemStyler`),
  `semanticLabel`.

`onChanged: null` does not disable the Select. When `enabled` is true it can
still open for inspection; choosing an item simply does not report a change.

Fortal preset: `FortalSelect<T>` — `variant` (`surface|soft|ghost`), `size`
(`size1–size3`). The preset includes a matching default item style; an
individual `RemixSelectItem.style` is an optional row-level override.

### RemixSegmentedControl\<T\>

An equal-segment, controlled single-select control with roving focus. `T`
extends `Object`; null is reserved for no selection.

| Parameter | Type | Default | Required |
| --- | --- | --- | --- |
| `items` | `List<RemixSegmentedControlItem<T>>` | — | yes |
| `selectedValue` | `T?` | — | yes |
| `onChanged` | `ValueChanged<T>?` | `null` | no; null disables the control |
| `enabled` | `bool` | `true` | no |
| `orientation` | `Axis` | `Axis.horizontal` | no |
| `loop` | `bool` | `true` | no |
| `semanticLabel` | `String?` | `null` | no |
| `excludeSemantics` | `bool` | `false` | no |

Each `RemixSegmentedControlItem<T>` requires `value` and at least one of
`label` or `icon`; icon-only items also require `semanticLabel`.

Fortal preset: `FortalSegmentedControl<T>` — `variant`
(`surface|classic`), `size` (`size1–size3`).

---
