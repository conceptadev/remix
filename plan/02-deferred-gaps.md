# Plan: Deferred Remix component gaps

> Keep the accepted DataTable and Toast work separate from component ideas that still lack a safe reusable behavior contract.

## Objective

Record what happens to the gaps excluded from Phase 1 so they are not forgotten or accidentally folded into unrelated PRs.

- Accepted now: DataTable and Toast, implemented by `pr-09-data-table.md` and `pr-10-toast.md`.
- Deferred: Sheet/Drawer, ContextMenu, HoverCard, Combobox, DatePicker/Calendar, and an advanced DataGrid.
- Remain examples/recipes: dashboard PageHeader, StatCard, EmptyState, and ActionPopover unless reuse evidence establishes a design-independent contract.

## Evidence added after the original audit

`origin/main` adds a product dashboard with two relevant local implementations:

- `packages/dashboard/lib/widgets/data_grid.dart` is used by Customers and Orders and already proves the reusable controlled contract for columns, sorting, page-scoped row selection, pagination, arbitrary cells, and empty content.
- `packages/dashboard/lib/widgets/toast.dart` proves live Fortal token resolution through a caller-owned `Overlay`, an optional action, and timed dismissal. Every call uses the same bottom-right position without queue/stack coordination, so concurrent entries overlap. PR 10 treats this as consumer evidence and replaces it only after the package queue/scope/semantics contract lands.

The dashboard is evidence, not a source file to move unchanged. Both widgets import Material, embed Fortal values and English copy, and lack the complete public API/semantics contract required by Remix.

## Disposition

| Gap | Decision | Why not now | Promotion trigger |
| --- | --- | --- | --- |
| DataTable | **Merged: #109** (+ follow-ups #110-#112) | — | Done: controlled vertical slice, Fortal recipe, mapped parity family, dashboard DataGrid migration. |
| Toast | **Accepted: PR 10** | — | Implement the focused scope/controller/portal, bounded queue, timer/focus/lifecycle policy, native status/alert semantics, generated Fortal extension, and dashboard migration in `pr-10-toast.md`. |
| Sheet/Drawer | **Deferred** | It needs modal/nonmodal focus containment, Escape/outside dismissal, direction, safe-area handling, and a decision on drag gestures versus keyboard/desktop behavior. | Reuse the dialog/overlay host contract after those behaviors are specified and tested without requiring `Scaffold`. |
| ContextMenu | **Deferred until PR 1** | Menu item parity must land first; the remaining work is invocation and anchor behavior, not another menu renderer. | Reuse the recursive menu panel after secondary-click, long-press, keyboard invocation, focus restoration, and RTL positioning are specified. |
| HoverCard | **Deferred** | Popover provides nearby overlay machinery, but delayed hover/focus open/close and touch fallback remain product decisions. | Demonstrate a shared behavior contract that is materially different from Tooltip and Popover composition. |
| Combobox | **Deferred** | Editable text, popup listbox, active descendant, filtering, free-form values, IME, and keyboard focus form one coupled headless control. | Add or adopt a tested headless primitive before styling it in Remix/Fortal. |
| DatePicker/Calendar | **Deferred** | Calendar-grid keyboard semantics, locale/week rules, range selection, disabled dates, time zones, and Material/Cupertino adaptation make this a larger subsystem. | Settle the calendar model and localization contract; decide whether the renderer belongs in core or an optional integration. |
| DataGrid | **Deferred optional integration** | DataTable covers moderate/paginated records. A grid implies lazy two-dimensional rendering, pinned/resizable/reorderable columns, cell focus/selection/editing, and spreadsheet navigation. | Introduce only when a real consumer needs those capabilities; evaluate Flutter's `two_dimensional_scrollables` and keep that dependency out of core Remix. |

## Naming boundary

Use these names consistently:

```text
RemixDataList   one record as label/value metadata
RemixDataTable  many records; controlled sort/selection/pagination signals
DataGrid        future virtualized or spreadsheet-like interaction model
```

Do not rename DataList to DataTable and do not describe the dashboard prototype as a reusable DataGrid after PR 9 replaces it.

## Scope boundary

Accepting Toast does not authorize a general `RemixScope`. `FortalScope` remains theme/token-only, existing overlay controls keep the caller-owned Overlay contract, and PR 10 adds only `RemixToastScope` for queue/controller/timer ownership. Promote shared overlay infrastructure later only if at least two independent components need the same lifecycle contract rather than merely the same Flutter Overlay host.

## Next audit order

After PRs 9-10, reassess gaps in this order:

1. Combobox, because it closes a common form-control gap but must start with headless behavior.
2. Sheet/Drawer, because the dashboard currently relies on a Material `Drawer` for compact navigation.
3. ContextMenu, after the shared menu item/recursive panel work from PR 1 is available.
4. DatePicker/Calendar, HoverCard, and DataGrid when product demand justifies their larger or narrower contracts.

This order is a backlog decision, not authorization to broaden any existing PR.
