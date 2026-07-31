# Plan: Add Remix SegmentedControl

> Add a dedicated equal-segment, single-select control over Naked's proven toggle-group behavior, with its own track/item style anatomy.

## PR contract

- Title: `feat(remix): add segmented control component`
- Depends on: none.
- Compatibility: additive component; no migration.
- Primary outcome: a controlled segmented selector with equal item extents, roving focus, orientation/RTL support, and independent track/item styling.
- Out of scope: multi-select, deselecting the active segment, Radix's sliding indicator and separator treatment, and Fortal size/variant recipes (PR 7).

## Context

- `RemixToggleGroup<T>` already composes `NakedToggleGroup<T>` / `NakedToggleOption<T>` and has comprehensive selection, assertion, roving-focus, disabled, orientation, and RTL coverage.
- SegmentedControl has different visual anatomy: a persistent track and equal segments with an active surface. Wrapping `RemixToggleGroup` would expose the wrong public type/spec and make nested style-state resolution brittle.
- The pre-rewrite Remix history (`7f8750b11`, PR #479) contains visual inspiration but used a Pressable implementation without the current semantics/focus contract. Do not copy its behavior.
- Pinned Radix 3.3 SegmentedControl uses controlled single ToggleGroup semantics, equal-width columns, sizes 1-3, surface/classic variants, and does not emit an empty selection when the selected item is activated.
- `NakedToggleOption` already suppresses callback when its value equals the selected value.

Official reference: [Radix Themes Segmented Control](https://www.radix-ui.com/themes/docs/components/segmented-control).

## Public API and specs

Mirror the proven ToggleGroup data model deliberately, while using SegmentedControl names and its own stylers.

```dart
class RemixSegmentedControlItem<T> {
  const RemixSegmentedControlItem({
    required this.value,
    this.label,
    this.icon,
    this.semanticLabel,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.style = const RemixSegmentedControlItemStyler.create(),
  });
}

class RemixSegmentedControl<T> extends StatelessWidget {
  const RemixSegmentedControl({
    super.key,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = Axis.horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const RemixSegmentedControlStyler.create(),
    this.styleSpec,
  });
}

@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixSegmentedControlSpec with _$RemixSegmentedControlSpec {
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  final StyleSpec<RemixSegmentedControlItemSpec> item;
}

@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class RemixSegmentedControlItemSpec
    with _$RemixSegmentedControlItemSpec {
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> container;
  final StyleSpec<TextSpec> label;
  final StyleSpec<IconSpec> icon;
}
```

Use the same public assertions as ToggleGroup:

- non-null, unique item values;
- selected value is null or matches exactly one item;
- at most one autofocus item;
- label/icon requirement and semantic label for icon-only items;
- copied, unmodifiable item list.

`onChanged == null` disables the group through Naked. An active item cannot toggle itself to null. `orientation` and per-item disabled state are intentional Flutter extensions; document them.

## Layout and state contract

- Force the resolved container direction from `orientation` after style resolution so both fluent and raw-spec paths agree, matching ToggleGroup's `_withOrientation` precedent.
- Every item receives the same main-axis extent, based on the largest intrinsic item within available constraints. Keep cross-axis sizing controlled by the resolved item spec.
- In bounded horizontal space, use all available width only when the caller's container style requests it; the default remains intrinsic-width. In intrinsic mode, the track width is `largest segment intrinsic width × item count`.
- Apply the analogous rule vertically for item height.
- Encapsulate equalization in a private layout widget with focused layout tests; start with `IntrinsicWidth + Row/Expanded` (and vertical analogue), but change implementation if Flutter's intrinsic/flex assertions reveal a safer custom `MultiChildRenderObjectWidget` is needed. The acceptance contract, not the mechanism, is fixed.
- Each option's Naked state controller feeds `WidgetStateProvider`; selected/disabled/hover/focus/press styles resolve inside that provider.
- Wrap visual icon/text in `ExcludeSemantics`; Naked owns the one accessible option node.
- v1 paints a static selected surface through `onSelected`. It does not reserve or animate a sliding indicator layer.

Place a class-site comment explaining why this deliberately parallels `RemixToggleGroup` rather than wrapping it: shared headless primitives, different public visual anatomy.

Alternatives rejected:

- Style `RemixToggleGroup` in place — wrong public abstraction and spec ownership.
- Port the old Pressable implementation — loses current roving focus and semantic guarantees.
- Reimplement selection/focus — duplicates Naked.
- Add the sliding indicator in v1 — introduces measurement/animation risk and is explicitly a recorded follow-up.

## Work breakdown

- [ ] Task 1: Add failing API/behavior tests by adapting ToggleGroup coverage.
  - Files: new `packages/remix/test/components/segmented_control/segmented_control_widget_test.dart`, both public-API tests.
  - Cover controlled selection/no re-emission, assertions, group/item disabled state, focus-node ownership, orientation, loop, RTL, semantics, and activation.

- [ ] Task 2: Add failing spec/style and equal-layout tests.
  - Files: new `segmented_control_spec_test.dart`, `segmented_control_style_test.dart`, widget layout tests.
  - Acceptance: track/item nested style resolution, raw spec, state variants, and equal extents are independently specified before implementation.

- [ ] Task 3: Implement the dedicated component and generate code.
  - Files: new `packages/remix/lib/src/components/segmented_control/segmented_control.dart`, `_spec.dart`, `_style.dart`, `_widget.dart`, generated `.g.dart`; `packages/remix/lib/remix.dart`.
  - Reuse Naked types directly and carry over only Remix's small data-to-widget/style glue.
  - Acceptance: there is no dependency on the public `RemixToggleGroup` widget or spec.

- Checkpoint: run segmented-control and existing toggle-group tests together. Any ToggleGroup regression blocks docs work.

- [ ] Task 4: Validate layout across constraints and text directions.
  - Files: widget tests.
  - Test short/long labels, icons, mixed content, bounded/intrinsic parents, horizontal/vertical axes, 200% text scale, and narrow width without overflow.
  - Acceptance: all segments are equal on the main axis and semantics order matches visual/widget order.

- [ ] Task 5: Add docs and playground.
  - Files: `docs/components/segmented_control.mdx`, root `docs.json`, `packages/playground/lib/registry/entries/segmented_control_entry.dart`, registry.
  - Demonstrate text, icon-only, disabled item, horizontal and vertical controls, controlled output, keyboard table, custom Remix styling, and the no-sliding-indicator v1 note.

- [ ] Task 6: Capture screenshots and validate.
  - Light/dark images include selected, focus, hover/disabled, and unequal-label examples proving equal sizing.
  - PR description includes the deliberate-parallel reuse rationale and sliding-indicator follow-up.

## Test strategy

### Behavior/headless

- Tapping or pressing Space/Enter on an inactive item emits its value once.
- Activating the selected item emits nothing and never clears selection.
- Null callback, disabled group, and disabled item suppress actions/focus as Naked specifies.
- Tab enters one item; arrows, Home/End, loop/clamp, last-focused behavior, and horizontal RTL match existing ToggleGroup tests.
- User focus nodes survive disposal; assertion failures are descriptive.

### Semantics

- Group label is a container with explicit children.
- Each option exposes its selected/checked, enabled, focused, and tap state exactly once.
- Icon-only options use `semanticLabel`; visual text/icon is excluded beneath Naked.
- `excludeSemantics` removes the group subtree.

### Style/layout

- Group and per-item styles merge in the same state context.
- Raw spec and fluent styles produce equivalent anatomy.
- Selected, disabled, hovered, focused, and pressed variants resolve.
- Item main-axis extents match within a pixel for all supported constraint/orientation cases.
- Focus decoration does not change geometry.

### Manual

- Keyboard-only traversal in LTR/RTL and vertical mode.
- Light/dark custom Remix demo at normal/high text scale.
- Compare the static-selected treatment with Radix and caption the expected missing slide.

## Acceptance criteria

- [ ] Dedicated public SegmentedControl types/specs exist and no public ToggleGroup wrapper is used.
- [ ] Naked remains the sole selection, activation, semantics, and roving-focus implementation.
- [ ] Selected values cannot toggle off; disabled and orientation behavior is covered.
- [ ] Segment extents are equal without forced full width by default.
- [ ] Sliding indicator/separators are explicitly out of v1 and carried into PR 7's parity approximation.
- [ ] Spec/style/widget/public API/docs/playground/screenshots/generated code all pass the shared gate.

## Risks and mitigations

- Risk: intrinsic sizing plus flex asserts in unbounded constraints. Mitigation: isolate layout, test both axes/constraints, and use a custom render object only if the simple composition cannot satisfy the fixed contract.
- Risk: copying ToggleGroup glue drifts. Mitigation: keep the parallel surface small, test both directories together, and document why specs cannot be shared.
- Risk: selected styling resolves outside the option state. Mitigation: resolve nested item style under Naked's `WidgetStateProvider`, as ToggleGroup does.
- Risk: long localized labels overflow. Mitigation: high-scale/narrow tests and label wrapping policy documented in the component page.

## Validation and rollout

Run the segmented-control and toggle-group directories first, then all commands in `01-conventions.md`. This is additive and unflagged. Roll back by reverting the component/export/docs/playground changes; no Fortal parity family is added until PR 7.
