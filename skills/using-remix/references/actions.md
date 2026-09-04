# Action Components

Constructor details for Remix buttons and toggles. Fortal widgets mentioned
here come from the application-owned Fortal preset; see [Fortal](fortal.md).

## Table of Contents

- [Button](#remixbutton)
- [Icon button](#remixiconbutton)
- [Toggle](#remixtoggle)
- [Toggle group](#remixtogglegroupt)

## Components

### RemixButton

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `label` | `String` | — | yes |
| `onPressed` | `VoidCallback?` | `null` | no |
| `leadingIcon` | `IconData?` | `null` | no |
| `trailingIcon` | `IconData?` | `null` | no |
| `loading` | `bool` | `false` | no |
| `enabled` | `bool` | `true` | no |
| `onLongPress` | `VoidCallback?` | `null` | no |
| `autofocus` | `bool` | `false` | no |
| `enableFeedback` | `bool` | `true` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `mouseCursor` | `MouseCursor` | `SystemMouseCursors.click` | no |
| `semanticLabel` | `String?` | `null` | no |
| `semanticHint` | `String?` | `null` | no |
| `excludeSemantics` | `bool` | `false` | no |
| `textBuilder` | `RemixButtonTextBuilder?` | `null` | no |
| `leadingIconBuilder` | `RemixButtonIconBuilder?` | `null` | no |
| `trailingIconBuilder` | `RemixButtonIconBuilder?` | `null` | no |
| `loadingBuilder` | `RemixButtonLoadingBuilder?` | `null` | no |

Effective enabled state is `enabled && !loading && onPressed != null`. During
loading, content stays laid out (invisible) with a spinner overlay to prevent
layout shift.

Icon placement is style-driven when exactly one icon is present:
`ButtonStyler().iconAlignment(RemixIconAlignment.end)` places it after the
label, regardless of whether the value came from `leadingIcon` or
`trailingIcon`. With both icons present, Remix preserves
leading → label → trailing order.

Fortal preset: `FortalButton` — all params above plus
`variant` (`classic|solid|soft|surface|outline|ghost`) and `size`
(`size1–size4`).

### RemixIconButton

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `icon` | `IconData` | — | yes |
| `onPressed` | `VoidCallback?` | `null` | no |
| `loading` | `bool` | `false` | no |
| `enabled` | `bool` | `true` | no |
| `onLongPress` | `VoidCallback?` | `null` | no |
| `autofocus` | `bool` | `false` | no |
| `enableFeedback` | `bool` | `true` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `mouseCursor` | `MouseCursor` | `SystemMouseCursors.click` | no |
| `semanticLabel` | `String?` | `null` | no |
| `semanticHint` | `String?` | `null` | no |
| `excludeSemantics` | `bool` | `false` | no |
| `iconBuilder` | `RemixIconButtonIconBuilder?` | `null` | no |
| `loadingBuilder` | `RemixIconButtonLoadingBuilder?` | `null` | no |

Fortal preset: `FortalIconButton` — `variant`
(`classic|solid|soft|surface|outline|ghost`), `size` (`size1–size4`). It
forwards the complete `RemixIconButton` behavior
surface, including long press, semantics, builders, autofocus, and cursor.

### RemixToggle

A pressable button that stays visually active while selected (unlike
`RemixSwitch`, which is a sliding on/off control).

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `selected` | `bool` | — | yes |
| `onChanged` | `ValueChanged<bool>?` | `null` | no |
| `label` | `String?` | `null` | \* |
| `icon` | `IconData?` | `null` | \* |
| `enabled` | `bool` | `true` | no |
| `enableFeedback` | `bool` | `true` | no |
| `focusNode` | `FocusNode?` | `null` | no |
| `autofocus` | `bool` | `false` | no |
| `semanticLabel` | `String?` | `null` | no |
| `mouseCursor` | `MouseCursor` | `SystemMouseCursors.click` | no |

\* At least one of `label` or `icon` must be provided.

Fortal preset: `FortalToggle` — `variant` (`ghost|outline`), `size` (`size1–size3`).

### RemixToggleGroup\<T\>

A controlled, single-select group with roving keyboard focus. It owns both the
group style and the default item style.

| Parameter | Type | Default | Required |
| --- | --- | --- | --- |
| `items` | `List<RemixToggleGroupItem<T>>` | — | yes |
| `selectedValue` | `T?` | — | yes |
| `onChanged` | `ValueChanged<T?>?` | `null` | no; null disables the group |
| `enabled` | `bool` | `true` | no |
| `orientation` | `Axis` | `Axis.horizontal` | no |
| `loop` | `bool` | `true` | no |
| `semanticLabel` | `String?` | `null` | no |
| `excludeSemantics` | `bool` | `false` | no |

Each `RemixToggleGroupItem<T>` requires `value` and at least one of `label` or
`icon`; icon-only items also require `semanticLabel`. Items can override
`enabled`, `focusNode`, `autofocus`, and `style`.

Fortal preset: `FortalToggleGroup<T>` — `variant` (`soft|surface`), `size`
(`size1–size3`).

---
