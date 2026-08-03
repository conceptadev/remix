# Plan: Add Remix DataList

> Add a semantic label/value list with a shared horizontal label column, vertical layout, custom value slots, and Mix-owned typography/layout metrics.

## PR contract

- Title: `feat(remix): add data list component`
- Depends on: none.
- Compatibility: additive component; no migration.
- Primary outcome: metadata rows render as an aligned horizontal table or vertical list and expose label/value relationships without duplicate semantics.
- Out of scope: an editable data grid/table, sorting, row actions,
  virtualization, responsive breakpoint API, Radix's fully compositional
  Root/Item/Label/Value child model, per-label accent props, CSS leading trim,
  and the Fortal recipe (PR 7).

## Context

- Radix DataList is display-only and maps to semantic `dl`/`dt`/`dd`; there is no appropriate Naked primitive.
- Its horizontal mode uses a shared two-column grid/subgrid, not independent Rows. Labels therefore align across every item and have an implicit 120 px minimum in the Radix recipe.
- Vertical mode stacks label/value with a small inner gap. Sizes 1-3 change type and row gaps. Items support start/center/end/baseline/stretch alignment.
- Flutter has native list/list-item roles but no definition-list role. Use a list container, list-item rows, and explicit labels/values.
- A Flutter `Table` is the correct horizontal layout primitive because it negotiates one label-column width for all rows.
- The proposed String-or-Widget item model is intentionally narrower than
  Radix's arbitrary compositional children. It provides a deterministic
  data-driven API and preserves an interactive value child, but records that
  upstream composition difference explicitly rather than claiming it maps one
  for one.

Official references: [Radix Themes Data List](https://www.radix-ui.com/themes/docs/components/data-list), [Flutter Table](https://api.flutter.dev/flutter/widgets/Table-class.html), and [SemanticsRole](https://api.flutter.dev/flutter/dart-ui/SemanticsRole.html).

## Public API

```dart
enum RemixDataListItemAlignment { start, center, end, baseline, stretch }

class RemixDataListItem {
  const RemixDataListItem({
    required this.label,
    this.value,
    this.child,
    this.semanticValue,
    this.alignment = RemixDataListItemAlignment.baseline,
  }) : assert((value == null) != (child == null));

  final String label;
  final String? value;
  final Widget? child;
  final String? semanticValue;
  final RemixDataListItemAlignment alignment;
}

class RemixDataList extends StatelessWidget {
  const RemixDataList({
    super.key,
    required this.items,
    this.orientation = Axis.horizontal,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const RemixDataListStyler.create(),
    this.styleSpec,
  });
}
```

Validation and semantics of item fields:

- Keep the const widget constructor, retain the supplied list with a documented
  no-mutation-during-build contract, and take one
  `List.unmodifiable(List.of(items))` snapshot when rendering/asserting. Empty
  lists are allowed; constructor-time copying is impossible in a const API.
- `label` and string `value` must be nonempty. `semanticValue`, when supplied, must be nonempty and is valid only with `child`.
- Exactly one of `value` or `child` is supplied.
- A string row is represented as one list-item semantics node with `label` and `value`; exclude both visible text nodes beneath it.
- A custom child with no `semanticValue` keeps its own semantics. The row node
  supplies the label and explicit child nodes, and the visual label is wrapped
  in `ExcludeSemantics` so it is not announced a second time.
- A custom child with `semanticValue` opts into a single summarized label/value node and excludes the child's semantics. Document that this form is for noninteractive custom display only; interactive children must omit `semanticValue` so their actions survive.
- `baseline` is the horizontal default for string values, where both cells have
  a known text baseline. An arbitrary custom child may expose no baseline, so a
  custom-child row requesting `baseline` deterministically maps to top/start
  instead of relying on `RenderTable` fallback behavior. Vertical orientation
  also maps baseline to start. Document and test both adaptations.

## Spec contract

```dart
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixDataListSpec with _$RemixDataListSpec {
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  final StyleSpec<BoxSpec> labelContainer;
  final StyleSpec<BoxSpec> valueContainer;
  final StyleSpec<TextSpec> label;
  final StyleSpec<TextSpec> value;
  final double? rowSpacing;
  final double? columnSpacing;
  final double? labelValueSpacing;
  final double? minLabelWidth;
}
```

- Geometry scalars default defensively to zero in the unopinionated Remix renderer; reject negative resolved values.
- `container` wraps the complete layout and can own size/padding/decoration.
- Cell containers allow alignment/padding/constraints without coupling label/value text styles.
- `rowSpacing` is the gap between items; `columnSpacing` is the directional horizontal gap; `labelValueSpacing` is the inner vertical gap; `minLabelWidth` feeds the horizontal shared column.
- Do not put `orientation` in the spec: it is semantic/layout behavior and the constructor wins over styles.

## Layout contract

### Horizontal

Build one `Table(textDirection: Directionality.of(context))` with two columns:

- Label column: `MaxColumnWidth(FixedColumnWidth(minLabelWidth), IntrinsicColumnWidth())`.
- Value column under bounded width: `FlexColumnWidth(1)` so long values wrap and shrink.
- Value column under unbounded width: `IntrinsicColumnWidth()` to avoid a flex-in-unbounded assertion.
- Apply `columnSpacing` as directional padding between cells and `rowSpacing` as bottom cell padding except on the last row.
- Map item alignment to
  `TableCellVerticalAlignment.top/middle/bottom/baseline/fill` and set a text
  baseline for string baseline rows. Map a custom-child baseline row to `top`
  before creating `TableCell`s; do not ask `RenderTable` to infer whether an
  arbitrary subtree has a baseline.

If mixed per-row `TableCellVerticalAlignment` exposes a Flutter limitation, keep one Table and wrap individual cell content in `Align`/`Baseline`; do not fall back to independent Rows.

### Vertical

Use a top-level Column with `rowSpacing` between item Columns. Inside each item, place label then `labelValueSpacing` then value. Map start/center/end/stretch across the horizontal cross axis; map baseline to start. Use directional alignment for text and cell containers.

In both orientations, soft-wrappable text must wrap at high text scale. For a
bounded horizontal list, the supported width is at least the resolved label
column minimum (the greater of `minLabelWidth` and every label's minimum
intrinsic width) plus `columnSpacing` plus the value column's minimum intrinsic
width. Below that bound—especially with an unbreakable label/value—the pinned
`auto 1fr`/120 px contract cannot fit; preserve explicit orientation and let the
caller rebuild with `orientation: vertical` rather than silently switching
layout. A caller-supplied child remains responsible for its own internal
overflow, while the value cell supplies bounded constraints when the list is
bounded.

Alternatives rejected:

- One Row per item — label columns drift and fail the reference's core layout behavior.
- `RichText` label/value concatenation — cannot preserve custom interactive values or two-column layout.
- A Naked primitive — no interaction behavior exists to headlessly coordinate.
- HTML-like fake definition roles — Flutter does not expose them.

## Work breakdown

- [ ] Task 1: Add failing data-model and semantics tests.
  - Files: new `packages/remix/test/components/data_list/data_list_widget_test.dart`, both public-API tests.
  - Cover assertions, per-build immutable list snapshot, empty list, one-node
    string rows, excluded visual labels, preserved interactive custom child,
    summarized noninteractive child, roles, labels, and exclusion.

- [ ] Task 2: Add failing spec/style tests.
  - Files: new `data_list_spec_test.dart`, `data_list_style_test.dart`.
  - Cover every nested slot/scalar in equality, copy, merge, lerp, fluent helpers, raw spec, and negative-value handling.

- [ ] Task 3: Implement the component and generate code.
  - Files: new `packages/remix/lib/src/components/data_list/data_list.dart`, `_spec.dart`, `_style.dart`, `_widget.dart`, generated `.g.dart`; `packages/remix/lib/remix.dart`.
  - Put a class-site comment explaining the deliberate `Table` choice and absence of Naked behavior.
  - Acceptance: one renderer chooses horizontal/vertical after a single style resolution.

- Checkpoint: run focused tests and inspect the semantics tree for string, button-child, and summarized custom rows before documentation.

- [ ] Task 4: Harden geometry and directionality.
  - Files: widget tests.
  - Cover aligned label x-coordinates, five alignments, string baseline,
    deterministic custom-child baseline-to-top fallback, LTR/RTL column order
    and directional gap, bounded/unbounded width, long soft-wrappable localized
    text, an explicitly below-minimum-width case, empty/custom child, and
    200%/300% text scale.
  - Acceptance: no overflow/assertion at or above the documented horizontal
    minimum; the below-minimum fixture demonstrates the caller-owned vertical
    fallback contract, and horizontal labels share one column width.

- [ ] Task 5: Add docs and playground.
  - Files: `docs/components/data_list.mdx`, root `docs.json`, `packages/playground/lib/registry/entries/data_list_entry.dart`, registry.
  - Show account metadata, long/wrapping values, a badge/link-like custom child, horizontal/vertical orientation, per-item alignment, semantics guidance, and custom Remix style.

- [ ] Task 6: Capture screenshots and run validation.
  - Light/dark screenshots include both orientations, aligned labels, a custom value, and wrapped text.
  - PR reuse note explains why Table is reused and why no Naked primitive is appropriate.

## Test strategy

### Semantics

- Root has list role and optional label; each row has list-item role.
- String rows expose each label/value exactly once.
- Custom interactive child keeps its role/action and the visual label is not duplicated.
- `semanticValue` summary excludes noninteractive child semantics and exposes one value.
- `excludeSemantics` removes the full list.

### Layout

- Every horizontal label/value boundary shares the same x-coordinate regardless of label length.
- The label column respects `minLabelWidth` and grows for a wider intrinsic label.
- The value column flexes under bounded width and becomes intrinsic under unbounded width.
- RTL reverses leading/trailing placement and gap without reversing logical item order in semantics.
- All five horizontal alignments map correctly for supported content; custom-child horizontal baseline maps to top and vertical baseline maps to start.
- Large-scale text wraps without `RenderFlex`/Table overflow when the bounded
  width satisfies the documented horizontal minimum; tests switch the same data
  to vertical below that bound. Long unbreakable content is explicitly outside
  the no-overflow guarantee.

### Spec/style

- Nested container/text slots and four metrics resolve through fluent and raw APIs.
- Orientation always comes from the constructor.
- Per-state variants inherited from surrounding Mix context still resolve for custom content.

### Manual

- Screen-reader traversal announces one list and meaningful row/value pairs; an embedded action remains separately actionable.
- Inspect both orientations under LTR/RTL, supported narrow/wide viewports, and
  light/dark playground themes; demonstrate a caller-owned responsive switch to
  vertical below the horizontal minimum.

## Acceptance criteria

- [ ] Horizontal layout uses one shared-column Table, not independent Rows.
- [ ] The horizontal minimum-width condition and caller-owned vertical fallback
  are documented and tested; no automatic orientation change is hidden in the
  renderer.
- [ ] Vertical layout and all item alignments have documented deterministic mappings.
- [ ] String and custom-child semantics are nonduplicated and interactive children remain actionable.
- [ ] The narrower data-driven API and deterministic baseline fallbacks are recorded as explicit Radix adaptations.
- [ ] Spec exposes all required cells/metrics without embedding Fortal values.
- [ ] Responsive/supported-narrow/RTL/high-scale cases and the below-minimum
  vertical fallback have tests.
- [ ] Public API, generated code, docs, nav, playground, screenshots, and shared validation are complete.

## Risks and mitigations

- Risk: baseline rows with arbitrary children cannot report a baseline.
  Mitigation: map every custom-child baseline request to top deterministically,
  document the adaptation, and test it while retaining one Table.
- Risk: `semanticValue` hides an interactive child. Mitigation: define it as an explicit noninteractive-summary opt-in and test/document the interactive no-summary path.
- Risk: flex column asserts under unbounded constraints. Mitigation: choose width strategy via `LayoutBuilder` and test both paths.
- Risk: fixed/intrinsic column minima exceed a very narrow bound. Mitigation:
  state the computable horizontal minimum, test its boundary, and show callers
  switching the explicit orientation to vertical below it.
- Risk: responsive Radix width props expand scope. Mitigation: record them as a PR 7 parity approximation; Remix callers can style global metrics/containers in v1.

## Validation and rollout

Run `fvm flutter test test/components/data_list`, then the shared gate. This is additive and unflagged. Rollback removes the component/export/docs/playground files; no Fortal family is added until PR 7.
