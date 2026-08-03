# Plan: Add Remix CheckboxGroup

> Add a controlled, generic checkbox-group coordinator that reuses `RemixCheckbox` for every visual and semantic option and standard Flutter focus traversal, with Radix's one-tab-stop roving model recorded as a deferred extension.

## PR contract

- Title: `feat(remix): add checkbox group component`
- Depends on: none.
- Compatibility: additive part/types in the checkbox library; no migration.
- Primary outcome: applications can manage a typed set of checkbox values with group disabled/required semantics using standard Flutter keyboard traversal.
- Out of scope: a second checkbox spec, group-owned visual layout, validation messages, form serialization, a separate Fortal wrapper, and one-tab-stop roving focus with arrow-key navigation (deferred; see the focus contract below).

## Context

- `RemixCheckbox` is a non-generic visual widget with `bool? selected`; changing it to carry `T` would be breaking and unnecessary.
- Flutter has `RadioGroup`, used by `RemixRadioGroup`, but no equivalent checkbox-group coordinator.
- The pinned Radix Themes 3.3 CheckboxGroup is not merely a passive inherited value. It supports controlled values, required/disabled state, orientation, loop, RTL direction, and one-tab-stop roving focus.
- `NakedToggleGroup` contains a private, substantial roving implementation that cannot be reused without wrapping checkboxes in the wrong toggle semantics. Building an equivalent private layer for checkboxes (registration, focus-hierarchy order refresh, node-property snapshots/restoration, autofocus arbitration) was probed and is feasible, but it is the group's largest source of code and risk while delivering only arrow-key navigation. Following the menu precedent — prefer the platform's standard mechanism and record the delta — v1 uses standard Flutter traversal (every enabled checkbox is a Tab stop, exactly as native HTML checkbox groups behave) and records Radix's roving model as a deferred capability. The discovery probes (`00-discovery.md`) remain the evidence base for that follow-up.
- Flutter has no checkbox-group semantics role. The correct native tree is a labeled container with explicit checkbox children, not a fabricated role.

Official references: [Radix Themes Checkbox Group](https://www.radix-ui.com/themes/docs/components/checkbox-group), [Flutter FocusTraversalGroup](https://api.flutter.dev/flutter/widgets/FocusTraversalGroup-class.html), and [Flutter Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html). Feature-comparison capture: `radix-reference/checkbox-group.png` (behavior comparison only — visuals are intentionally unmapped this series; see `radix-reference/README.md`).

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
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final Set<T> values;
  final ValueChanged<Set<T>>? onChanged;
  final bool enabled;
  final bool isRequired;
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
    this.style = const CheckboxStyler.create(),
    this.styleSpec,
  });

  final T value;
  final String semanticLabel;
  // Remaining fields pass through to RemixCheckbox; no selected/onChanged/tristate.
}
```

Contract details:

- `values` is controlled. The const widget retains the supplied set, then takes
  `Set.unmodifiable(Set.of(values))` once per build for all comparisons and
  scope consumers. Document that callers must not mutate it during a build;
  Dart cannot copy it in a const initializer.
- Every callback receives a new `Set.unmodifiable` snapshot. Checking adds the value; unchecking removes it; never mutate the caller's set.
- Effective group enabled state is `enabled && onChanged != null`. Group and item disabled states combine.
- Group items are binary; do not expose `tristate` because set membership has only present/absent states.
- `semanticLabel` is required and nonempty because the item deliberately owns no visible label/layout. Docs show pairing it with visible text and excluding/merging that text so the name is announced once.
- Values must be non-null, unique among mounted items, and stable in equality/hash code. Throw a descriptive `FlutterError` in debug for duplicates.
- At most one mounted item may set `autofocus: true`.
- A `RemixCheckboxGroupItem<T>` outside a matching group throws a descriptive error.

Put a class-site comment on `RemixCheckboxGroupItem` stating that it intentionally composes the bool-based `RemixCheckbox`; duplicating its spec or making the existing checkbox generic would be wrong.

## Focus and keyboard contract

v1 uses standard Flutter focus traversal; the group adds no focus machinery:

- Every enabled option is an ordinary Tab stop in widget order, exactly as the
  composed `RemixCheckbox`/`NakedCheckbox` already behaves. Space/Enter
  activation remains owned by the checkbox.
- A disabled group or disabled item is not focusable and exposes no tap
  action; this falls out of forwarding effective enabled state to the
  composed checkbox rather than from group-owned focus wrappers.
- Caller-owned `focusNode` and `autofocus` forward straight to the composed
  checkbox. At most one mounted item may set `autofocus: true` (debug assert);
  caller nodes are never disposed by the group.
- Removing or disabling the focused item must not throw; Flutter's normal
  focus fallback applies. No group-owned focus repair is implemented.

### Deferred: Radix one-tab-stop roving focus

Pinned Radix CheckboxGroup roves: one Tab stop with arrow/Home/End movement,
orientation, loop, and RTL awareness. v1 deliberately does not reproduce it —
the required private layer (registration, focus-hierarchy order refresh,
caller-node snapshot/restoration, autofocus arbitration) is the largest code
and risk surface of the group while only changing how keyboard users move
between options, and platform-native checkbox groups use one stop per option.
Record this in the component docs as a known Radix behavior difference and in
PR 7's `checkbox_group` unmapped-family record as part of the deferral
contract, with the reopen condition being real user/parity demand. The
discovery probes on `ExcludeFocusTraversal` behavior and focus-hierarchy
ordering remain the design basis for that follow-up; a future `orientation`/
`loop` API lands with it, which is why v1 omits both parameters.

## Semantics contract

- Default wrapper: `Semantics(container: true, explicitChildNodes: true, label: semanticLabel, isRequired: isRequired, child: ...)`.
- Do not set a nonexistent group role or check state on the group.
- Each composed `RemixCheckbox` supplies exactly one checkbox node with label, checked, enabled, focus, and tap action.
- `excludeSemantics: true` wraps the complete group in `ExcludeSemantics`, excluding the container and all options.
- Required state belongs to the group. Do not mark every item required.
- A disabled group leaves no semantic tap actions on options and no focusable nodes.

## Approach

Implement a private inherited scope plus a lightweight debug-only mounted-value registry inside `checkbox_group_widget.dart`. The scope provides the immutable value snapshot, effective callback, and combined configuration; the registry exists only to detect duplicate values and duplicate autofocus in debug builds. The item resolves membership and forwards all visual and focus props, including `focusNode` and `autofocus`, to `RemixCheckbox(selected: values.contains(value), ...)`. There is no group focus controller.

Keep the group layout-transparent: `child` controls Row/Column/Grid and visible labels. This matches `RemixRadioGroup`'s coordinator role and lets existing `fortalCheckboxStyle` style group items without a new group recipe. Because pinned Radix CheckboxGroup does have root/item spacing, label-row, and propagated visual props, PR 7 must add a checker-enforced intentionally-unmapped upstream-family record; documentation alone is not allowed to imply full visual parity.

Alternatives rejected:

- Make `RemixCheckbox<T>` generic — breaking public API with no visual benefit.
- Use `NakedToggleOption` as a focus wrapper — introduces toggle roles/actions around checkbox roles.
- Copy Naked's complete private toggle controller — imports substantial selection-specific machinery and still relies on focus-node mutations that the nested checkbox Focus can overwrite.
- Build the private roving-focus layer now — its registration/order-refresh/
  node-restoration machinery is the group's largest risk for an arrow-key-only
  behavior difference; deferred with a recorded reopen condition instead.
- Add a styled label/row to each group item — invents visual anatomy and conflicts with the nonvisual coordinator scope.

## Work breakdown

- [ ] Task 1: Write failing controlled-state and semantics tests.
  - Files: new `packages/remix/test/components/checkbox/checkbox_group_widget_test.dart`, both public-API tests.
  - Acceptance: tests define immutable set emission, combined disabled state, required group semantics, exact checkbox child semantics, and scope errors before types exist.

- [ ] Task 2: Write failing focus and keyboard tests for standard traversal.
  - Files: `checkbox_group_widget_test.dart`.
  - Cover every enabled option as a Tab stop in widget order, Shift-Tab exit,
    disabled group/item exclusion from focus, Space toggling only the focused
    option, caller focus-node passthrough and survival after unmount, single
    enabled autofocus, duplicate-autofocus and duplicate-value debug asserts,
    and dynamic add/remove/disable of the focused item without a framework
    exception.
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
  - PR reuse note must name `RemixCheckbox`, explain the lightweight coordinator scope, and state the deferred roving-focus decision.

## Test strategy

### Controlled data

- Each build uses one immutable input snapshot; neither that snapshot nor the caller's set is mutated.
- Check emits old values plus item; uncheck emits old values minus item.
- Emitted sets are new, unmodifiable, and preserve `T`.
- Rebuilding without accepting the callback leaves UI controlled at the original values.
- Null callback, disabled group, and disabled item suppress callback and action.

### Focus/keyboard

- Every enabled option participates in Tab in widget order; Shift-Tab exits
  correctly on both boundaries.
- Space and Enter toggle only the focused checkbox and emit once.
- Disabled options and a disabled group are excluded from focus and expose no
  action.
- An enabled autofocus item focuses once on mount; duplicate autofocus and
  duplicate values fail descriptive debug asserts.
- Caller focus nodes pass through unchanged and survive item unmount; the
  group never disposes them.
- Removing or disabling the focused item does not throw; Flutter's normal
  focus fallback applies.

### Semantics

- Group label and `isRequired` exist once with explicit child nodes.
- Each option has checkbox role/state/label and correct enabled/action flags.
- Visible labels do not duplicate item names in the example composition.
- Excluded group contributes no subtree.

### Manual

- Traverse the playground using Tab, Shift-Tab, and Space in both text directions.
- Use a screen reader to confirm one group name followed by individual option names/states.
- Capture light/dark vertical and horizontal examples.

## Acceptance criteria

- [ ] Controlled typed sets are immutable at both input and callback boundaries.
- [ ] Standard traversal is covered: every enabled option is a Tab stop, disabled options are excluded, and no group-owned focus machinery exists.
- [ ] The Radix one-tab-stop roving difference is documented in the component page and carried into PR 7's `checkbox_group` unmapped-family record with its reopen condition.
- [ ] `RemixCheckbox` remains unchanged and owns all option visuals/checkbox semantics.
- [ ] The group uses native container/required semantics without a fake role.
- [ ] Dynamic item and external focus-node cases are covered.
- [ ] No spec/style/generated files are added for this nonvisual coordinator.
- [ ] Public API, docs, nav, playground, screenshots, and shared validation are complete.

## Risks and mitigations

- Risk: users expect Radix's arrow-key navigation between options. Mitigation: document the deliberate difference and its reopen condition; standard traversal still reaches every option with Tab.
- Risk: keyboard order differs from visual order in unusual custom layouts. Mitigation: document widget order as keyboard order; custom visual reordering must reorder children too.
- Risk: label semantics duplicate visible text. Mitigation: required item semantic label plus a documented `ExcludeSemantics`/merged-label pattern and exact tree tests.
- Risk: generic equality changes while mounted. Mitigation: document stable equality/hash requirement and key entries by stable widget identity plus value validation.

## Validation and rollout

Run `fvm flutter test test/components/checkbox` from `packages/remix`, followed by the shared gate. This is additive and unflagged. Roll back by reverting the part, tests, docs, and examples; no persisted data or Fortal parity counts change.
