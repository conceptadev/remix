# Plan: Add Remix CheckboxGroup

> Add a controlled, generic checkbox-group coordinator with correct roving focus while reusing `RemixCheckbox` for every visual and semantic option.

## PR contract

- Title: `feat(remix): add checkbox group component`
- Depends on: none.
- Compatibility: additive part/types in the checkbox library; no migration.
- Primary outcome: applications can manage a typed set of checkbox values with group disabled/required semantics and Radix-compatible keyboard focus.
- Out of scope: a second checkbox spec, group-owned visual layout, validation messages, form serialization, and a separate Fortal wrapper.

## Context

- `RemixCheckbox` is a non-generic visual widget with `bool? selected`; changing it to carry `T` would be breaking and unnecessary.
- Flutter has `RadioGroup`, used by `RemixRadioGroup`, but no equivalent checkbox-group coordinator.
- The pinned Radix Themes 3.3 CheckboxGroup is not merely a passive inherited value. It supports controlled values, required/disabled state, orientation, loop, RTL direction, and one-tab-stop roving focus.
- `NakedToggleGroup` contains a private roving implementation that cannot be reused without wrapping checkboxes in the wrong toggle semantics. Implement the minimal coordinator in Remix and leave an upstream extraction as a separate follow-up.
- Flutter has no checkbox-group semantics role. The correct native tree is a labeled container with explicit checkbox children, not a fabricated role.

Official references: [Radix Themes Checkbox Group](https://www.radix-ui.com/themes/docs/components/checkbox-group), [Flutter FocusTraversalGroup](https://api.flutter.dev/flutter/widgets/FocusTraversalGroup-class.html), and [Flutter Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html).

## Public API

Add `part 'checkbox_group_widget.dart';` to `checkbox.dart` and export the existing checkbox library as before.

```dart
class RemixCheckboxGroup<T> extends StatefulWidget {
  const RemixCheckboxGroup({
    super.key,
    required this.values,
    required this.child,
    this.onChanged,
    this.enabled = true,
    this.isRequired = false,
    this.orientation = Axis.vertical,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final Set<T> values;
  final ValueChanged<Set<T>>? onChanged;
  final bool enabled;
  final bool isRequired;
  final Axis orientation;
  final bool loop;
  final String? semanticLabel;
  final bool excludeSemantics;
  final Widget child;
}

class RemixCheckboxGroupItem<T> extends StatefulWidget {
  const RemixCheckboxGroupItem({
    super.key,
    required this.value,
    required this.semanticLabel,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.checkedIcon = Icons.check_rounded,
    this.uncheckedIcon,
    this.enableFeedback = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.style = const RemixCheckboxStyler.create(),
    this.styleSpec,
  });

  final T value;
  final String semanticLabel;
  // Remaining fields pass through to RemixCheckbox; no selected/onChanged/tristate.
}
```

Contract details:

- `values` is controlled. Copy it with `Set.unmodifiable(Set.of(values))` for comparisons/use during a build.
- Every callback receives a new `Set.unmodifiable` snapshot. Checking adds the value; unchecking removes it; never mutate the caller's set.
- Effective group enabled state is `enabled && onChanged != null`. Group and item disabled states combine.
- Group items are binary; do not expose `tristate` because set membership has only present/absent states.
- `semanticLabel` is required and nonempty because the item deliberately owns no visible label/layout. Docs show pairing it with visible text and excluding/merging that text so the name is announced once.
- Values must be non-null, unique among mounted items, and stable in equality/hash code. Throw a descriptive `FlutterError` in debug for duplicates.
- At most one mounted item may set `autofocus: true`.
- A `RemixCheckboxGroupItem<T>` outside a matching group throws a descriptive error.

Put a class-site comment on `RemixCheckboxGroupItem` stating that it intentionally composes the bool-based `RemixCheckbox`; duplicating its spec or making the existing checkbox generic would be wrong.

## Focus and keyboard contract

The private group controller registers items in widget order and maintains one roving tab target:

1. Keep the last focused enabled item when possible.
2. Otherwise use the first checked and enabled item.
3. Otherwise use the first enabled item.
4. If none are enabled, the group has no tab stop.

Arrow behavior:

| Orientation | LTR | RTL |
| --- | --- | --- |
| Vertical | Down = next, Up = previous | same |
| Horizontal | Right = next, Left = previous | Left = next, Right = previous |
| Either | Home = first, End = last | same |

Skip disabled items. `loop: true` wraps; `false` clamps without moving. Arrow/Home/End only move focus and do not toggle. Space/Enter activation remains owned by `RemixCheckbox`/`NakedCheckbox`.

Use `FocusTraversalGroup(policy: WidgetOrderTraversalPolicy())` and `Shortcuts`/`Actions` around the group. Mirror Naked's external-focus-node hygiene: snapshot caller-owned `canRequestFocus` and `skipTraversal`, never make a node focusable when the caller disabled it, and restore original properties on unregister/dispose. Internally owned nodes are disposed; caller-owned nodes are not.

When the focused item is removed or becomes disabled, repair focus to the nearest enabled neighbor (then wrap if configured) after the current build. When a nonfocused item changes, do not steal focus. Reordering follows current widget registration order.

## Semantics contract

- Default wrapper: `Semantics(container: true, explicitChildNodes: true, label: semanticLabel, isRequired: isRequired, child: ...)`.
- Do not set a nonexistent group role or check state on the group.
- Each composed `RemixCheckbox` supplies exactly one checkbox node with label, checked, enabled, focus, and tap action.
- `excludeSemantics: true` excludes the complete group and all options.
- Required state belongs to the group. Do not mark every item required.
- A disabled group leaves no semantic tap actions on options and no focusable nodes.

## Approach

Implement a private stateful `_RemixCheckboxGroupController<T>`, inherited scope, and item registration entry inside `checkbox_group_widget.dart`. The scope provides the immutable value snapshot, effective callback, combined configuration, and controller. The item resolves membership and forwards all visual props to `RemixCheckbox(selected: values.contains(value), ...)`.

Keep the group layout-transparent: `child` controls Row/Column/Grid and visible labels. This matches `RemixRadioGroup`'s coordinator role and lets existing `fortalCheckboxStyle` style group items without a new group recipe.

Alternatives rejected:

- Make `RemixCheckbox<T>` generic — breaking public API with no visual benefit.
- Use `NakedToggleOption` as a focus wrapper — introduces toggle roles/actions around checkbox roles.
- Omit roving focus — diverges from the pinned CheckboxGroup contract and creates too many tab stops.
- Add a styled label/row to each group item — invents visual anatomy and conflicts with the nonvisual coordinator scope.

## Work breakdown

- [ ] Task 1: Write failing controlled-state and semantics tests.
  - Files: new `packages/remix/test/components/checkbox/checkbox_group_widget_test.dart`, both public-API tests.
  - Acceptance: tests define immutable set emission, combined disabled state, required group semantics, exact checkbox child semantics, and scope errors before types exist.

- [ ] Task 2: Write failing roving-focus tests.
  - Files: `checkbox_group_widget_test.dart`.
  - Cover initial target priority, Tab entry/exit, vertical/horizontal arrows, RTL, Home/End, loop/clamp, disabled skipping, activation separation, dynamic removal/disable/reorder, autofocus assertions, and external-node restoration.
  - Acceptance: each test has a focusable widget before and after the group so group tab boundaries are observable.

- [ ] Task 3: Implement scope, controller, and composed item.
  - Files: `packages/remix/lib/src/components/checkbox/checkbox.dart`, new `checkbox_group_widget.dart`.
  - Keep all focus machinery private and add the composition rationale comment.
  - Acceptance: no checkbox rendering or semantics code is duplicated from `RemixCheckbox`.

- Checkpoint: run the checkbox test directory, then manually inspect the semantics tree for a three-item group before API/docs work.

- [ ] Task 4: Stabilize public API coverage.
  - Files: `packages/remix/lib/remix.dart` only if its checkbox export is not already sufficient, `public_api_test.dart`, `public_api_compatibility_test.dart`.
  - Compile generic values using string and enum examples, optional external focus nodes, all group flags, and item styling passthrough.

- [ ] Task 5: Add docs and playground.
  - Files: `docs/components/checkbox_group.mdx`, root `docs.json`, `packages/playground/lib/registry/entries/checkbox_group_entry.dart`, registry.
  - Show vertical required interests, horizontal filters, controlled set output, a disabled item/group, keyboard instructions, and visible labels with nonduplicated semantics.
  - Use the existing Fortal checkbox recipe only as an item style; state clearly that the group itself is unstyled.

- [ ] Task 6: Capture light/dark screenshots and run the shared gate.
  - PR reuse note must name `RemixCheckbox` and explain the private coordinator/roving layer.

## Test strategy

### Controlled data

- Input set is not retained/mutated.
- Check emits old values plus item; uncheck emits old values minus item.
- Emitted sets are new, unmodifiable, and preserve `T`.
- Rebuilding without accepting the callback leaves UI controlled at the original values.
- Null callback, disabled group, and disabled item suppress callback and action.

### Focus/keyboard

- Exactly one enabled option participates in Tab; Shift-Tab exits correctly.
- Selected-first/first-enabled/last-focused target priority is deterministic.
- All directional keys follow the table above under LTR/RTL.
- Space and Enter toggle only the focused checkbox and emit once.
- Disabled options are skipped and cannot autofocus.
- Removing/disabling the focused node repairs focus without a framework exception.
- User focus-node properties are restored and user nodes survive unmount.

### Semantics

- Group label and `isRequired` exist once with explicit child nodes.
- Each option has checkbox role/state/label and correct enabled/action flags.
- Visible labels do not duplicate item names in the example composition.
- Excluded group contributes no subtree.

### Manual

- Traverse the playground using Tab, arrows, Home/End, Space, and Shift-Tab in both text directions.
- Use a screen reader to confirm one group name followed by individual option names/states.
- Capture light/dark vertical and horizontal examples.

## Acceptance criteria

- [ ] Controlled typed sets are immutable at both input and callback boundaries.
- [ ] One-tab-stop roving focus matches orientation, loop, disabled, and RTL behavior.
- [ ] `RemixCheckbox` remains unchanged and owns all option visuals/checkbox semantics.
- [ ] The group uses native container/required semantics without a fake role.
- [ ] Dynamic item and external focus-node cases are covered.
- [ ] No spec/style/generated files are added for this nonvisual coordinator.
- [ ] Public API, docs, nav, playground, screenshots, and shared validation are complete.

## Risks and mitigations

- Risk: manipulating caller focus-node traversal fields leaks after disposal. Mitigation: snapshot/restore and test both normal removal and group disposal.
- Risk: registry order differs from visual order in unusual custom layouts. Mitigation: document widget order as keyboard order; custom visual reordering must reorder children too.
- Risk: label semantics duplicate visible text. Mitigation: required item semantic label plus a documented `ExcludeSemantics`/merged-label pattern and exact tree tests.
- Risk: generic equality changes while mounted. Mitigation: document stable equality/hash requirement and key entries by stable widget identity plus value validation.

## Validation and rollout

Run `fvm flutter test test/components/checkbox` from `packages/remix`, followed by the shared gate. This is additive and unflagged. Roll back by reverting the part, tests, docs, and examples; no persisted data or Fortal parity counts change.
