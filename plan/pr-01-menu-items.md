# Plan: Expose menu checkbox, radio, and submenu items

> Add the compound item types already implemented by `naked_ui` to Remix's data-driven menu without forking menu behavior or styling.

## PR contract

- Title: `feat(remix): expose menu checkbox, radio, and submenu items`
- Depends on: none.
- Compatibility: additive sealed subclasses and one additive spec slot; no migration.
- Primary outcome: Remix users can build checked menu items, mutually exclusive radio sections, and recursively nested submenus with the same focus/keyboard behavior as Naked.
- Out of scope: context menus, arbitrary custom item widgets, new submenu positioning logic, and final Radix-colored indicator styling (PR 7).

## Context

- `packages/remix/lib/src/components/menu/menu_widget.dart` currently switches exhaustively over only `RemixMenuItem<T>` and `RemixMenuDivider<T>`.
- The root renderer and submenu need the same overlay/item/divider resolution; copying the current `overlayBuilder` would create two spec trees that drift.
- `RemixMenuItemSpec` already owns label, leading icon, and trailing icon slots. It needs one `indicator` `IconSpec` for checkbox checks and radio dots; the submenu arrow continues to use `trailingIcon`.
- `NakedMenuCheckboxItem<T>`, `NakedMenuRadioGroup<T>`, `NakedMenuRadioItem<T>`, and `NakedMenuSubmenu<T>` already supply activation, roles, controlled state, group exclusivity, hover timing, arrow/Escape behavior, recursive close, and focus restoration.
- The installed submenu default is right/start with a four-pixel side offset and a 100 ms hover delay. Preserve it by forwarding defaults rather than restating behavior.
- There is no menu playground entry today. This PR creates it.
- The pinned parity manifest currently lists compound items as deferred even though its source selectors already include checkbox, radio, and submenu selectors.

Official behavior references: [Radix Themes Dropdown Menu](https://www.radix-ui.com/themes/docs/components/dropdown-menu) and [Radix Dropdown Menu primitive keyboard interactions](https://www.radix-ui.com/primitives/docs/components/dropdown-menu).

## Public API

Add these immutable subclasses in `menu_widget.dart`. Names and field nullability are the contract; implementation may use super-parameters where that improves readability.

```dart
final class RemixMenuCheckboxItem<T> extends RemixMenuItemData<T> {
  const RemixMenuCheckboxItem({
    required this.value,
    required this.label,
    required this.checked,
    this.onChanged,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.closeOnActivate = true,
    this.semanticLabel,
    this.style = const RemixMenuItemStyler.create(),
  });

  final T value;
  final String label;
  final bool checked;
  final ValueChanged<bool>? onChanged;
  // Remaining fields mirror RemixMenuItem<T>.
}

final class RemixMenuRadioGroup<T> extends RemixMenuItemData<T> {
  const RemixMenuRadioGroup({
    required this.value,
    required this.items,
    this.onChanged,
    this.enabled = true,
  });

  final T value; // Naked requires a non-null controlled value.
  final List<RemixMenuRadioItem<T>> items;
  final ValueChanged<T>? onChanged;
  final bool enabled;
}

final class RemixMenuRadioItem<T> {
  const RemixMenuRadioItem({
    required this.value,
    required this.label,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.closeOnActivate = true,
    this.semanticLabel,
    this.style = const RemixMenuItemStyler.create(),
  });
  // Fields mirror a selectable item; values in a group must be unique.
}

final class RemixMenuSubmenu<T> extends RemixMenuItemData<T> {
  const RemixMenuSubmenu({
    required this.label,
    required this.items,
    this.leadingIcon,
    this.trailingIcon,
    this.controller,
    this.enabled = true,
    this.hoverDelay = const Duration(milliseconds: 100),
    this.positioning = const OverlayPositionConfig(
      side: OverlaySide.right,
      alignment: OverlayAlignment.start,
      sideOffset: 4,
    ),
    this.focusNode,
    this.semanticLabel,
    this.onOpen,
    this.onClose,
    this.style = const RemixMenuItemStyler.create(),
  });
}
```

API rules:

- Copy radio-group and submenu item lists with `List.unmodifiable` at the public boundary.
- Assert nonempty labels/semantic labels, unique radio values, and at most one caller-owned autofocus target if autofocus is later exposed.
- `onChanged == null` does not independently disable a checkbox/radio item when the root `RemixMenu.onSelected` can handle its value; forward both callbacks and let Naked compute effective enabled state.
- A checkbox activation may call root `onSelected(value)` and `onChanged(!checked)`, matching Naked. Document this explicitly.
- A radio activation may call root `onSelected(value)` and group `onChanged(value)`, matching Naked.
- Use a directional default submenu chevron. If `trailingIcon` is supplied, it replaces the default chevron rather than rendering two icons.

## Approach

Extract the current overlay body into a private recursive `_RemixMenuItemsPanel<T>` that receives the item list plus already-resolved default style/spec inputs. Its exhaustive switch renders ordinary items, dividers, checkbox items, one radio-group subtree, and submenus. Root `NakedMenu.overlayBuilder` and every `NakedMenuSubmenu.overlayBuilder` call this same panel.

Extract the duplicated visual row into a private item-content builder that accepts label/icons/indicator and the active Naked controller. Ordinary, checkbox, radio, and submenu triggers resolve per-item styling through the same helper. Wrap visual text/icons in `ExcludeSemantics`; the Naked primitive remains the single semantic owner.

Radio items must remain descendants of one `NakedMenuRadioGroup<T>`. A neutral `Column(mainAxisSize: min, crossAxisAlignment: stretch)` may group them because the current overlay recipe has no inter-child spacing. Do not add a second decorated overlay. Add a regression test that dividers and neighboring ordinary items keep their dimensions around a radio group.

Alternatives rejected:

- Reimplement compound activation in Remix — duplicates already-shipped focus, close, and semantics behavior.
- Add separate public `RemixCheckboxMenu`/`RemixSubmenu` widgets — breaks the existing declarative list model.
- Copy the root overlay builder into each submenu — creates parallel style resolution and inconsistent future fixes.
- Allow arbitrary `Widget` items — weakens the sealed exhaustive contract and lets semantics/style escape.

## Work breakdown

- [ ] Task 1: Lock the data and semantics contract with failing tests.
  - Files: `packages/remix/test/components/menu/menu_widget_test.dart`, `packages/remix/test/public_api_test.dart`, `packages/remix/test/public_api_compatibility_test.dart`
  - Cover: constructors/generic inference; checked/unchecked roles; radio mutual exclusion; callbacks; disabled suppression; submenu keyboard/focus behavior.
  - Acceptance: tests fail because the new public types do not exist.
  - Verification: `cd packages/remix && fvm flutter test test/components/menu/menu_widget_test.dart`

- [ ] Task 2: Extend the sealed data model and add the recursive renderer.
  - Files: `packages/remix/lib/src/components/menu/menu_widget.dart`
  - Implement the APIs above, immutable lists/assertions, `_RemixMenuItemsPanel<T>`, shared row renderer, and exhaustive switch.
  - Put a code comment above the panel explaining that one renderer intentionally serves root and submenu overlays.
  - Acceptance: arbitrary nesting renders; selection closes the full hierarchy according to each item's `closeOnActivate`; caller focus nodes are not disposed by Remix.

- [ ] Task 3: Add the indicator styling slot and regenerate.
  - Files: `packages/remix/lib/src/components/menu/menu_spec.dart`, `packages/remix/lib/src/components/menu/menu_style.dart`, generated `packages/remix/lib/src/components/menu/menu.g.dart`, spec/style tests.
  - Add `StyleSpec<IconSpec> indicator` with generated styler forwarding and lerp/equality coverage.
  - Render a check for checked checkboxes, a dot for selected radio items, and a fixed empty slot where alignment requires it. Keep default Remix styling neutral.
  - Acceptance: raw `styleSpec` and fluent `.item(.indicator(...))` both affect every check/radio indicator.
  - Verification: focused spec/style/widget tests pass after `fvm dart run melos run generate`.

- Checkpoint: run the complete menu test directory and manually inspect a three-level submenu in LTR and RTL before changing docs/parity files.

- [ ] Task 4: Update the public surface and examples.
  - Files: `packages/remix/lib/remix.dart`, both public-API tests, `docs/components/menu.mdx`, root `docs.json` only if the menu nav entry is missing.
  - Add controlled checkbox and radio examples, nested submenu example, callback ordering, close behavior, keyboard table, and styling slot documentation.
  - Acceptance: every MDX snippet compiles under `docs:check`.

- [ ] Task 5: Add the missing playground menu entry and capture evidence.
  - Files: `packages/playground/lib/registry/entries/menu_entry.dart`, `packages/playground/lib/registry/component_registry.dart`
  - Show an ordinary action, disabled action, checked option, radio section, two-level submenu, and visible keyboard-focus state in both brightnesses.
  - Acceptance: `?component=menu` opens directly and all demos update controlled state.

- [ ] Task 6: Bring the current menu parity record up to date.
  - Files: `packages/remix/reference/radix_themes_3_3_0/manifest.json`, `coverage_evidence.json`, `packages/remix/tool/fortal_parity/check.dart`, the reference README if it contains beta.7.
  - Remove behavioral deferrals for compositional/checkbox/radio/submenu items; add checked, unchecked, submenu-open, and RTL state evidence and tests.
  - Until PR 7 applies Fortal indicator tokens, record the neutral indicator treatment as a time-bounded visual approximation instead of claiming exact styling. PR 7 removes that approximation.
  - Correct stale `naked_ui` beta.7 text to exact beta.8.
  - Acceptance: the parity check proves the expanded menu states without changing family counts.

## Test strategy

### Widget behavior

Add named tests for:

- Checkbox role, label, checked state, one tap action, and controlled rebuild from false to true.
- Checkbox callback order/arguments, root-only callback, item-only callback, both-null disabled behavior, explicit disabled behavior, and `closeOnActivate: false`.
- Radio roles, `isChecked`, `isInMutuallyExclusiveGroup`, one selected item, selection of a different value, disabled group/item, root/group callback combinations, and no re-emission of the current value if Naked suppresses it.
- Submenu pointer hover after 99/100 ms, right-arrow open and first-item focus in LTR, left-arrow equivalent in RTL, reverse arrow close, Escape close/focus restoration, controller open/close callbacks, disabled trigger, and recursive selection closing all ancestors.
- A user-provided submenu focus node remains usable after unmount.
- Visual text/icons occur once in the semantics tree.
- The sealed switch handles nested radio/submenu data after regeneration.

Use explicit pumps for the 100 ms hover timer. Do not `pumpAndSettle` around menu animations/timers.

### Styling

- Spec copy/lerp/equality includes `indicator`.
- Fluent indicator styles and raw specs resolve identically.
- Checked/radio states feed the same `WidgetStateProvider` as their Naked controller.
- Open submenu maps to selected state so the existing Fortal `.onSelected(...)` recipe continues to work.
- Indicator/chevron order is directional in RTL.

### Manual

- Mouse through nested menus slowly enough to test the open/close corridor.
- Traverse every enabled item with keyboard only; verify disabled items are skipped.
- Verify focus returns to the invoking trigger after Escape and selection.
- Capture light/dark playground screenshots showing all new variants.

## Acceptance criteria

- [ ] No new focus, menu-anchor, or selection state machine exists outside Naked.
- [ ] Root and nested overlays use one private Remix panel renderer and one spec tree.
- [ ] Checkbox/radio/submenu public types compile through `remix.dart`.
- [ ] Roles and checked/mutual-exclusion states match Flutter semantics exactly once.
- [ ] LTR/RTL arrows, hover delay, Escape, recursive close, and focus restoration are covered.
- [ ] Menu parity no longer calls the shipped behaviors deferred; the temporary visual approximation is explicit.
- [ ] Docs, new playground entry, public API tests, generated code, validation, and two screenshots are included.

## Risks and mitigations

- Risk: a nested radio group changes overlay layout. Mitigation: keep its wrapper decoration-free and add neighbor/divider golden-free geometry assertions.
- Risk: both root and local callbacks surprise callers. Mitigation: preserve Naked's exact order and document/test it.
- Risk: submenu generic values collide with root selection. Mitigation: all selectable nested values remain `T`; submenu triggers have no value.
- Risk: visual children duplicate Naked semantics. Mitigation: one shared `ExcludeSemantics` content renderer plus exact-tree tests.
- Risk: PR 7 conflicts with menu parity files. Mitigation: PR 7 starts from this merged state and removes the named temporary approximation.

## Validation and rollout

Run the shared commands in `01-conventions.md`, with the menu directory test first. No flag or migration is required. Rollback is one revert including its behavior-evidence changes; restoring the old parity deferral is part of that revert.

The PR description must include the reuse rationale, a keyboard/semantics summary, light/dark playground screenshots, and the explicit note that final Fortal indicator color/spacing lands in PR 7.
