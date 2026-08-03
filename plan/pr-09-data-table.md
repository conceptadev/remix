# Plan: Add Remix DataTable

> Add a host-neutral, controlled table for moderate or paginated record sets, with native table semantics, Mix styling, Fortal Radix visuals, and migration of the dashboard prototype.

## PR contract

- Title: `feat(remix): add data table component`
- Execution dependency: rebase onto current `origin/main`, then land after PR 8 because both PRs update the Fortal parity ledger and Chromium fixture.
- Compatibility: additive Remix/Fortal public API plus an internal dashboard migration; no consumer migration or data migration.
- Primary outcome: applications render arbitrary typed rows in shared columns and opt into caller-controlled single-column sorting, page-scoped row selection, and pagination without importing Material or a grid engine.
- Out of scope: filtering UI, client/server sorting implementation, data fetching/caching, multi-column sort, column visibility/reorder/resize/pinning, frozen rows, virtualization, infinite scrolling, cell selection/editing, spreadsheet keyboard navigation, and a general compositional table DSL.

## Context

- `origin/main:packages/dashboard/lib/widgets/data_grid.dart` already defines typed columns and rows, controlled sort descriptors, optional selection, page controls, arbitrary cells, fixed/flex columns, an empty slot, and horizontal overflow. Customers and Orders are independent real consumers.
- The dashboard implementation is not reusable as-is: it imports Material, hard-codes Fortal tokens, dimensions, English strings, and page-size choices, names a nonvirtualized component `DataGrid`, and does not emit Flutter's native table-role hierarchy.
- Flutter 3.44 exposes `SemanticsRole.table`, `row`, `columnHeader`, and `cell`; debug validation requires table -> row -> cell/header parentage. Those roles are the accessibility authority.
- Flutter's core `Table` is host-neutral and sufficient for one bounded page. It lays out every supplied row, which is acceptable because callers own pagination and large virtualized sets are explicitly outside this PR.
- Current `origin/main` exposes canonical generated style names (`CalloutStyler`, `CalloutSpec`, and equivalents) while keeping `Remix*` for widgets. Because DataTable is new after that migration, use `DataTableStyler`/`DataTableSpec` directly and add no legacy aliases.
- The pinned Radix Themes 3.3.0 source defines Table sizes 1-3, surface/ghost variants, gray row dividers, bold column headers, and exact panel/padding/min-height/radius metrics. Sorting, selection, pagination, hover, and arbitrary row actions are documented Fortal extensions around that passive visual baseline.
- DataList remains separate: it describes one record as key/value metadata, while DataTable compares many records under shared column headers.

References: [Radix Themes Table](https://www.radix-ui.com/themes/docs/components/table), [Flutter Table](https://api.flutter.dev/flutter/widgets/Table-class.html), [Flutter SemanticsRole](https://api.flutter.dev/flutter/dart-ui/SemanticsRole.html), and the [shadcn data-table composition guide](https://ui.shadcn.com/docs/components/base/data-table). Feature-comparison capture: `radix-reference/table.png` — it shows the passive Radix visual baseline only; sorting/selection/pagination are Flutter extensions with no Radix counterpart (see `radix-reference/README.md`).

## Public API

Create `packages/remix/lib/src/components/data_table/` with the normal spec/style/widget/generated/Fortal anatomy.

```dart
enum RemixDataTableSortDirection { ascending, descending }

typedef RemixDataTablePageRangeFormatter = String Function({
  required int start,
  required int end,
  required int total,
});

String remixDefaultDataTablePageRangeFormatter({
  required int start,
  required int end,
  required int total,
}) => '$start–$end of $total';

@immutable
final class RemixDataTableSort {
  const RemixDataTableSort({
    required this.columnId,
    required this.direction,
  });

  final String columnId;
  final RemixDataTableSortDirection direction;
}

enum RemixDataTableCellAlignment { start, center, end }

@immutable
final class RemixDataTableColumn<T> {
  const RemixDataTableColumn({
    required this.id,
    required this.cellBuilder,
    this.label,
    this.header,
    this.semanticLabel,
    this.width = const FlexColumnWidth(),
    this.alignment = RemixDataTableCellAlignment.start,
    this.sortable = false,
  }) : assert((label == null) != (header == null));

  final String id;
  final String? label;
  final Widget? header;
  final String? semanticLabel;
  final TableColumnWidth width;
  final RemixDataTableCellAlignment alignment;
  final bool sortable;
  final Widget Function(BuildContext context, T row) cellBuilder;
}

@immutable
final class RemixDataTableLabels {
  const RemixDataTableLabels({
    this.rowsPerPage = 'Rows per page',
    this.previousPage = 'Previous page',
    this.nextPage = 'Next page',
    this.selectAllRows = 'Select all rows on this page',
    this.selectRow = 'Select row',
  });

  final String rowsPerPage;
  final String previousPage;
  final String nextPage;
  final String selectAllRows;
  final String selectRow;
}

class RemixDataTable<T> extends StatelessWidget {
  const RemixDataTable({
    super.key,
    required this.rows,
    required this.columns,
    this.semanticLabel,
    this.sort,
    this.onSortChanged,
    this.rowId,
    this.selectedRowIds = const {},
    this.onSelectionChanged,
    this.totalRows,
    this.pageIndex = 0,
    this.pageSize = 10,
    this.pageSizeOptions = const [10, 20, 50],
    this.onPageChanged,
    this.onPageSizeChanged,
    this.minimumWidth = 0,
    this.emptyBuilder,
    this.labels = const RemixDataTableLabels(),
    this.pageRangeFormatter = remixDefaultDataTablePageRangeFormatter,
    this.style = const DataTableStyler.create(),
    this.styleSpec,
  });

  final List<T> rows;
  final List<RemixDataTableColumn<T>> columns;
  final String? semanticLabel;
  final RemixDataTableSort? sort;
  final ValueChanged<RemixDataTableSort>? onSortChanged;
  final Object Function(T row)? rowId;
  final Set<Object> selectedRowIds;
  final ValueChanged<Set<Object>>? onSelectionChanged;
  final int? totalRows;
  final int pageIndex;
  final int pageSize;
  final List<int> pageSizeOptions;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onPageSizeChanged;
  final double minimumWidth;
  final WidgetBuilder? emptyBuilder;
  final RemixDataTableLabels labels;
  final RemixDataTablePageRangeFormatter pageRangeFormatter;
  final DataTableStyler style;
  final DataTableSpec? styleSpec;
}
```

Row identity is keyed by `Object` so callers choose any stable value-equal key;
the dashboard's `String` keys satisfy it without a second generic parameter.
These field contracts apply:

- Copy `rows`, `columns`, `selectedRowIds`, and `pageSizeOptions` at the boundary with unmodifiable collections. Column IDs are nonempty and unique.
- `label` must be nonempty when used. A custom `header` requires a nonempty `semanticLabel`; exactly one of `label` and `header` is supplied.
- `sort`, when present, names an existing sortable column. Sortable columns require `onSortChanged`; tapping cycles ascending/descending and emits a new descriptor but never reorders `rows` internally.
- Selection is enabled only when `rowId` and `onSelectionChanged` are both supplied. Visible row IDs must be nonempty/unique; callbacks receive a fresh unmodifiable set. Select-all affects current `rows` only and preserves selections from other pages.
- Pagination is enabled only when `totalRows`, `onPageChanged`, and `onPageSizeChanged` are all supplied. `rows` is already the current page; the widget never slices it. Counts/options are positive, options are unique and contain `pageSize`, and `pageIndex` is in range (zero for an empty result).
- `minimumWidth` is nonnegative. Under bounded width, the renderer uses `max(minimumWidth, availableWidth)` before placing the core `Table` in a horizontal scroll view, so flex columns never resolve in unbounded width.
- `labels` and `pageRangeFormatter` keep Remix independent of `MaterialLocalizations`; apps can replace every built-in English control/semantic label and reorder the range/count for their locale. Invoke the formatter once with the one-based visible start/end (both zero when empty) and total count; expose its result as one text/semantics value.
- `emptyBuilder` replaces body rows but preserves the column header and optional pagination footer. Its semantics remain caller-owned beneath a single table cell spanning the visual width; if Flutter `Table` cannot span cells, render the empty surface adjacent visually while preserving one valid body row/cell semantics node.

## Spec and styling contract

Add `@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])` with independently addressable visual regions:

```dart
class DataTableSpec with _$DataTableSpec {
  final StyleSpec<BoxSpec> container;
  final StyleSpec<BoxSpec> headerRow;
  final StyleSpec<BoxSpec> bodyRow;
  final StyleSpec<BoxSpec> selectedBodyRow;
  final StyleSpec<BoxSpec> headerCell;
  final StyleSpec<BoxSpec> bodyCell;
  final StyleSpec<BoxSpec> selectionCell;
  final StyleSpec<BoxSpec> footer;
  final StyleSpec<TextSpec> headerLabel;
  final StyleSpec<TextSpec> footerLabel;
  final StyleSpec<IconSpec> sortIcon;
  final double? headerMinHeight;
  final double? rowMinHeight;
  final double? selectionColumnWidth;
}
```

- Keep behavior/configuration (`rows`, columns, sort, selection, pagination, labels, width, builders) out of the style spec.
- Resolve negative dimensions as errors; unopinionated Remix defaults are transparent/zero except for safe minimum hit-target/layout behavior explicitly documented in the widget.
- Each region is rendered with Mix primitives/specs; do not ship `Container`, Material `DataTable`, Material `Card`, `DataColumn`, `DataRow`, or `DataCell` in the public/renderer implementation.
- Caller cell widgets retain their own semantics and interaction. Apply inherited text/icon defaults without excluding custom descendants.
- Header sort, checkbox, and pagination controls compose existing Remix controls. The DataTable owns coordination only; it does not copy their pointer, focus, keyboard, or checkbox state machines.
- Selection and hover visuals must not change row geometry. Reduced motion disables any row color transition; the passive Radix Table baseline has no required animation.

If generation cannot represent `FortalDataTable<T>` for the generic target, stop and make the smallest `mix_generator` regression fix before inventing a handwritten wrapper. Generic `FortalMenu<T>` and `FortalSelect<T>` are the expected precedent.

## Layout and semantics contract

### Layout

- Build the visible header and body with Flutter's core `Table` so every row shares the same `TableColumnWidth` map.
- Prepend one fixed selection column only when selection is enabled. Apply the same complete column map to header and body; do not render independent Rows whose widths can drift.
- Use directional alignment and padding. `start`/`end` follow `Directionality`; numeric callers opt into `end` rather than receiving a locale guess.
- Horizontal scrolling is owned by the widget. Vertical scrolling, sticky headers, and viewport height remain parent/application concerns.
- Empty, one-row, narrow, RTL, and high-text-scale layouts must not overflow. Arbitrary cell content is responsible for its own internal overflow after receiving bounded cell constraints.

### Semantics

- Emit one `SemanticsRole.table` node with `semanticLabel` when supplied.
- Its immediate semantic children are header/body `SemanticsRole.row` nodes. Header cells are `columnHeader`; body cells, including the selection column, are `cell`.
- Do not add `list`/`listItem` roles: those belong to DataList, not DataTable.
- A sortable header has one button/tap action and announces current ascending/descending state once. The visible header child is excluded only when the explicit header semantics node already represents it.
- Selection cells retain native checkbox semantics exactly once. Select-all is false/true/mixed for zero/all/some visible row IDs while preserving selections from other pages.
- Custom interactive cell descendants remain actionable and are not summarized into the cell node.
- Pagination controls remain outside the table-role node if Flutter's role validation would otherwise make them invalid children; associate them with the table through labels and traversal order rather than violating the native hierarchy.

## Fortal mapping

Add:

```dart
enum FortalDataTableSize { size1, size2, size3 }
enum FortalDataTableVariant { surface, ghost }

@MixWidget(target: RemixDataTable.new)
DataTableStyler fortalDataTableStyle({
  FortalDataTableSize size = .size2,
  FortalDataTableVariant variant = .ghost,
});
```

Generated `FortalDataTable<T>` has `.surface` and `.ghost` named constructors and preserves generic inference and the complete controlled API.

Map pinned Radix 3.3.0 `table.css` exactly where Flutter has the same concept:

| Size | Cell padding | Minimum row height | Typography | Radius |
| --- | --- | --- | --- | --- |
| size1 | `space2` | 36 x scaling | `text2` | `radius3` |
| size2 | `space3` | 44 x scaling | `text2` | `radius4` |
| size3 | vertical `space3`, horizontal `space4` | `space8` | `text3` | `radius4` |

- Body/header text `gray12`; column headers bold; row divider `grayA5`. Radix row-header cells use normal weight, but Flutter 3.44 has no row-header role and the v1 data-driven API has no separate row-header model; record that upstream part as deferred instead of fabricating semantics.
- Surface: `colorPanel`, blended `grayA5`/`gray6` border through the existing panel-stroke/effects model, header `grayA2`, clipped radius, no divider after the last body row.
- Ghost: transparent outer surface and normal row dividers.
- Selection, hover, sorting controls, pagination, arbitrary row actions, and horizontal scroll are Fortal/Flutter extensions, not Radix parity claims. Use existing accent/gray/control tokens and record them as extensions/approximations in the family manifest.
- Radix responsive `layout`, per-row alignment, and per-cell width/min/max/padding props map to concrete `TableColumnWidth`, column alignment, cell widgets/styles, and caller-driven responsive rebuilds in v1. Record unsupported per-row/per-cell overrides and CSS responsive-object syntax explicitly instead of silently claiming them.
- Do not add new tokens unless an exact pinned metric cannot be expressed by existing Fortal tokens; 36/44 scaled minimum heights may justify narrowly named table tokens only after the token inventory is checked in the failing-test step.

PR 9 advances the parity ledger after PR 8 from 29 mapped + 3 extensions to 30 mapped + 3 extensions. Add `table` source files/selectors, size/variant/default/state inventories, evidence, checker set/count/success text, and one Chromium probe. The mapped family is named `data_table` publicly but cites Radix `Table`; the manifest must state that controlled behavior is a Flutter extension.

## Work breakdown

- [ ] Task 1: Rebase and lock the public/semantics contract with failing tests.
  - Files: new `test/components/data_table/data_table_widget_test.dart`, both public-API tests.
  - Cover immutable inputs, duplicate/invalid models, generic inference, controlled sort/selection/pagination emissions, labels/page-range localization overrides, native table hierarchy, preserved custom-cell actions, RTL, empty state, and host operation without `MaterialApp`/`Scaffold`.

- [ ] Task 2: Add failing spec/style/layout tests.
  - Files: new `data_table_spec_test.dart`, `data_table_style_test.dart`.
  - Cover every region field, merge/lerp/equality/debug behavior, fixed/flex columns, optional selection-column parity, minimum width, narrow/high-scale overflow, and selection without geometry changes.

- [ ] Task 3: Implement the unopinionated Remix DataTable and generate code.
  - Files: `components/data_table/data_table.dart`, `_spec.dart`, `_style.dart`, `_widget.dart`, generated `.g.dart`, `remix.dart`.
  - Compose existing Remix checkbox/select/button/icon-button controls; keep all data transformations caller-owned and every public collection immutable.

- Checkpoint: run focused DataTable tests and both public-API tests. Do not start Fortal/parity work until native role validation, generic generation, and bounded layout pass.

- [ ] Task 4: Add the Fortal recipe and exact Radix visual tests.
  - Files: `fortal_data_table_styles.dart`, generated wrapper, `data_table_fortal_parity_test.dart`, shared control/widget/token tests if needed.
  - Cover sizes 1-3, surface/ghost, light/dark, scaling, hover/selected extension states, sort controls, pagination, last-row divider, and panel background behavior.

- [ ] Task 5: Advance the parity contract from 29/3 to 30/3.
  - Files: manifest, coverage evidence, checker, Chromium fixture/output, reference README.
  - Cite `src/components/table.props.tsx`, `table.css`, and `table.tsx`; add selectors `.rt-TableRoot`, `.rt-TableRootTable`, `.rt-TableHeader`, `.rt-TableBody`, `.rt-TableRow`, `.rt-TableCell`, `.rt-TableColumnHeaderCell`, and `.rt-TableRowHeaderCell` as supported by the pinned artifact.

- [ ] Task 6: Migrate the dashboard prototype and its tests.
  - Files after rebase: Customers/Orders pages, `packages/dashboard/lib/widgets/data_grid.dart`, `packages/dashboard/test/app_smoke_test.dart`.
  - Replace local `DataGrid*` public models with `FortalDataTable*`, preserve the two current consumers and observable sort/select/page behavior, then delete the private widget when no import remains.

- [ ] Task 7: Add docs, playground, inventories, and visual evidence.
  - Files: `docs/components/data_table.mdx` (underscore naming, matching `toggle_group.mdx` and PR 6's `data_list.mdx`), `docs.json`, new playground registry entry, root/package README inventories.
  - Show a passive table, sortable table, selectable paginated table, custom action cell, empty state, RTL, and a clear DataList-versus-DataTable comparison. Capture matched light/dark Flutter and Radix screenshots.

## Test strategy

### API and behavior

- Sort descriptors cycle predictably and never mutate/reorder supplied rows.
- Selection emits fresh immutable sets, select-all is page-scoped, and disabled configuration cannot produce partial behavior.
- Pagination validates ranges/options, invokes only controlled callbacks, and renders localized labels/ranges through the explicit labels/formatter API.
- Rows/columns are copied; duplicate IDs and invalid coupled fields fail descriptively in debug.

### Accessibility and hosts

- Use `tester.ensureSemantics()` and exact role/state/action assertions for table -> row -> header/cell structure.
- Verify sortable headers and checkboxes are represented once, arbitrary action cells remain interactive, and pagination is outside the structural table node.
- Pump under Widgets/Overlay/Fortal hosts without requiring Material ancestors. Verify RTL traversal and high text scale.

### Styling, layout, and parity

- Resolve every size/variant at scale 1 and one nondefault scale; assert exact padding, minimum heights, type, radius, divider, header, panel, and last-row behavior.
- Verify fixed/flex column widths stay identical between header/body with and without selection.
- Document and test controlled behavior as extensions without claiming Radix supplies a data engine.
- Preserve dashboard smoke expectations for sorting, ten-row select-all, checkbox sizing, pagination, filtering, and Orders/Customers rendering.

## Acceptance criteria

- [ ] `RemixDataTable<T>` and generated `FortalDataTable<T>` are exported, documented, and constructible with stable generic inference.
- [ ] DataList remains unchanged and docs explain the one-record versus many-record distinction.
- [ ] No Material table/card/scaffold API or third-party grid dependency enters core Remix.
- [ ] Sorting, selection, and pagination are controlled signals; Remix never fetches, filters, sorts, or slices caller data.
- [ ] Native table/row/header/cell semantics validate exactly and interactive descendants remain usable.
- [ ] Fixed/flex columns align across all rows and remain overflow-safe at narrow width, RTL, and high text scale.
- [ ] Fortal sizes/variants match pinned Radix Table metrics; non-Radix behavior is explicitly recorded as an extension.
- [ ] Dashboard Customers and Orders use the new component with all existing smoke behavior preserved and the private DataGrid removed.
- [ ] Manifest/evidence/checker/fixture agree on 30 mapped + 3 extensions after PR 9.
- [ ] Docs, playground, README inventories, generated code, visual comparisons, and every shared validation command are complete.

## Risks and mitigations

- Risk: the initial API drifts toward an all-purpose grid. Mitigation: reject features named in out of scope and preserve caller-owned data operations.
- Risk: Flutter table roles fail because visual scroll/layout wrappers appear in the semantic hierarchy. Mitigation: write exact failing role tests first and separate pagination/empty visuals from the structural role tree where required.
- Risk: `TableColumnWidth` flex columns receive unbounded horizontal constraints. Mitigation: compute a bounded table width before entering the horizontal scroll view and test zero/minimum/viewport widths.
- Risk: generic `@MixWidget` output regresses. Mitigation: compile-test `FortalDataTable<Customer>` and named constructors before recipe implementation; fix the generator rather than hand-writing a divergent wrapper.
- Risk: Radix passive Table parity is overstated for interactive DataTable features. Mitigation: split mapped visuals from documented Flutter/Fortal extension states in manifest, evidence, tests, and screenshots.
- Risk: dashboard migration accidentally moves filtering/sorting into Remix. Mitigation: retain page state and comparator/filter functions in Customers/Orders and assert supplied visible row order in widget tests.

## Validation and rollout

Run focused DataTable/dashboard tests after each task, regenerate Mix output, then run every shared command in `01-conventions.md`, including docs, parity, consumer-resolution, and full Flutter tests. Regenerate the pinned Chromium fixture with `npm ci && npm run generate` and visually inspect the fixed 1440x1280 output.

No flag or data migration is required. Roll back PR 9 as one unit: DataTable source/generated API, dashboard migration, docs/playground/inventories, parity manifest/evidence/checker, Chromium outputs, and README counts must never describe different family sets.
