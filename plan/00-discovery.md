# Plan: Remix component-gap discovery

> Verified baseline and decision record for six Phase 1 Remix components, Fortal recipes and typography, plus follow-up DataTable and Toast vertical slices.

## Objective

Establish the source-backed constraints that every implementation PR must preserve. The target is Radix Themes 3.3.0 parity where that maps cleanly to Flutter, while keeping interaction behavior in Flutter or `naked_ui` primitives and keeping visual policy in Mix/Fortal recipes.

- Primary outcome: a shared evidence base for `pr-01` through `pr-10` and explicit disposition of the remaining gaps.
- Out of scope: implementing the components in this planning change.
- Reference baseline: the repository's pinned `@radix-ui/themes@3.3.0` artifact, not the moving Radix website.

## Repository baseline

| Concern | Verified state | Evidence |
| --- | --- | --- |
| Branch baseline | This plan was researched at `40704eb37`, equal to `origin/main` at the time of research. | `git rev-parse HEAD origin/main` |
| Follow-up baseline | PRs 9-10 were researched against `origin/main` through `f9d3e6249`, which adds the dashboard prototypes, host-capability contract, and canonical generated Styler/Spec names after the original audit baseline. Rebase before executing either PR and re-check current names. | `git log origin/main`, dashboard widgets/tests, `docs/styler-api.mdx` |
| Flutter/Dart | FVM Flutter 3.44.0 and Dart 3.12.0; the system Flutter is older and must not be used for validation. | `.fvmrc`, root `pubspec.yaml` |
| Styling | `mix: ^2.2.0-beta.1`, `mix_annotations: ^2.2.0-beta.1`, `mix_generator: ^2.2.0-beta.2`. | `packages/remix/pubspec.yaml` |
| Headless controls | `naked_ui: 1.0.0-beta.8` exactly. | `packages/remix/pubspec.yaml`, lockfile |
| Public surface | Package exports are curated through `packages/remix/lib/remix.dart` and guarded by two public-API tests. | `packages/remix/test/public_api_test.dart`, `packages/remix/test/public_api_compatibility_test.dart` |
| Docs | MDX lives under `docs/components/`; navigation is in root `docs.json`; snippets and navigation are CI-gated. | `packages/remix/tool/validate_docs.dart` |
| Playground | The active app is `packages/playground`, with slug builders in `lib/registry/component_registry.dart`. | `packages/playground/lib/main.dart`, `packages/playground/lib/registry/` |

Do not use `packages/remix/scripts/playground_component.sh` as the source of truth: it still assumes an older playground path. Run the workspace app directly as documented in `01-conventions.md`.

### Post-review validation evidence

The plan was re-reviewed on the plan branch at `7e60b62` without changing
implementation code. These probes close the contracts that were ambiguous in
the first draft:

| Question | Verified result | Consequence for the plans |
| --- | --- | --- |
| Clean baseline | `melos bootstrap`, Remix analysis, and `melos run ci` pass under FVM Flutter 3.44.0 / Dart 3.12.0; all 2,109 Flutter tests pass. | Existing failures are not being hidden by the plan work. |
| Const collection copying | A const constructor cannot call `List.unmodifiable` or `Set.unmodifiable`. | Preserve const public APIs and snapshot collections at consumption/emission time. |
| TextArea constructor shape | Dart 3.12 accepts super-parameters together with an explicit `super(...)` initializer when forwarded names are not duplicated. | The constructor-only subtype sketch is language-valid; its generated Fortal target remains an implementation-time compile gate. |
| Checkbox roving focus | `ExcludeFocusTraversal` leaves one Tab stop while direct `FocusNode.requestFocus()` still reaches excluded siblings. | Evidence retained for the deferred roving follow-up; v1 CheckboxGroup uses standard traversal. |
| Equal segment layout | The proposed intrinsic `Flex` plus `Expanded` composition equalizes horizontal and vertical extents in a focused widget test. | Keep the simple private layout first, with constraint/high-scale tests before considering a render object. |
| TextField semantics | A real semantics dump repeats label/hint/helper text, and an interactive trailing button is absorbed by Naked's `MergeSemantics`. | PR 5 includes a shared TextField semantics-boundary correction, not only TextArea hint alignment. |
| TextField outer hit fallback | Naked's selection detector currently owns multi-tap callback policy and pressed transitions, while a normal `GestureDetector` adds a semantic tap action. | PR 5 requires a semantics-silent fallback that preserves `onTapAlwaysCalled`, pressed down/up/cancel, focus-node lifecycle, and child gesture precedence. |
| Menu radio activation | Pinned Naked beta.8 invokes both root selection and group change even when the selected radio item is activated again. | Tests require re-emission; they do not speculate about suppression. |
| Menu vectors/geometry | `RemixPathGlyph.thickCheck` exactly transcribes Radix's nine-unit check path; the pinned right-chevron path is absent locally. Radix also auto-end-aligns the trailing slot with `space4` leading padding and a -2 × scaling submenu-icon end margin. | PR 1 uses exact path assets with standard flex row geometry; the CSS-absolute offsets are a recorded manifest approximation while glyph paths keep zero tolerance. |
| Skeleton child identity | Switching between a direct child and a nested loading branch changes the Flutter element path even when the child has a stable key. | PR 2 keeps one child wrapper path across loading toggles and tests local-state retention/single mount. |
| Checkbox-group reconciliation | Keyed children can reorder without unregistering, and forwarding item autofocus lets Naked bypass group arbitration. | Evidence retained for the deferred roving follow-up; v1 forwards focus props straight to the composed checkbox. |
| DataList minimum width | Flutter `Table` cannot shrink a column below its minimum intrinsic width; the pinned horizontal layout also owns a 120 px label minimum. | PR 6 bounds the horizontal no-overflow guarantee and documents caller-owned vertical fallback below it. |
| Focus/effect rendering | The repository already has `fortalFocusOutline` and multi-layer `RemixBoxEffectsSpec` rendering. | Offset/inset/multi-layer outlines use effects instead of `foregroundDecoration`. |
| Segmented classic shadows | Existing `FortalTokens.shadow2` is an ordinary `BoxShadowToken`, not the `RemixBoxShadowListToken` accepted by the effects renderer; Radix paints it on a 1 px inset pseudo-element. | PR 7 adds a derived inset-capable shadow-2 token and verifies all five layers/shape insets. |
| Typography color inheritance | Pinned Text/Heading and null-color ghost Code set no foreground color; they inherit. | PR 8 preserves ambient color for those null-color paths and uses accent roles only where upstream does. |
| Parity schema counts | `manifest.schema.json` pins the aggregate family array length as well as the checker. | PRs 7/8 update schema min/max atomically with 27/32 totals. |

Scratch probes lived only under the gitignored `.context` directory and were
removed after validation.

## Architecture findings

### Styled component anatomy

A new visual Remix component normally follows `packages/remix/lib/src/components/spinner/`:

- `<name>.dart`: library, imports, and `part` declarations.
- `<name>_spec.dart`: `@MixableSpec()` contract.
- `<name>_style.dart`: `Style<Spec>` and generated-style plumbing.
- `<name>_widget.dart`: public widget and resolved rendering.
- `<name>.g.dart`: generated code; commit it.
- `fortal_<name>_styles.dart`: Fortal recipe and `@MixWidget` wrapper, added only in the Fortal phase here.

The spec/style/widget test triple applies only when those three production layers exist. A coordinator or constructor-only facade must have behavior and API tests, not empty ceremonial spec/style tests.

### Headless composition patterns

- `menu/menu_widget.dart` uses a sealed `RemixMenuItemData<T>` hierarchy and maps data to internal widgets over Naked menu primitives.
- `toggle_group/toggle_group_widget.dart` maps public item data to `NakedToggleGroup` and `NakedToggleOption`, including roving focus.
- `radio/radio_group_widget.dart` wraps Flutter's `RadioGroup` and contributes only group state; the visual option remains `RemixRadio`.
- `checkbox/checkbox_widget.dart` is deliberately non-generic and accepts `bool? selected`; a generic checkbox group must compose it rather than make it breaking.
- `spinner/spinner_widget.dart` is the local lifecycle pattern for a repeating `AnimationController`.
- `textfield/textfield_widget.dart` already forwards `minLines`, `maxLines`, and `expands` to `NakedTextField`; TextArea does not need a second editable implementation.
- `origin/main` now contains a dashboard-local generic `DataGrid<T>` used by Customers and Orders. It proves demand for columns, controlled sorting, optional page-scoped selection, pagination, arbitrary cell widgets, and horizontal overflow, but its Material imports, Fortal literals, fixed page options, and missing table-role hierarchy make it evidence rather than a reusable implementation.
- The dashboard-local `showToast` proves demand for timed status feedback, an optional action, bottom-end placement, and live Fortal changes. One independent OverlayEntry and Timer per call makes concurrent requests overlap and leaves queue, focus, semantics, reduced-motion, and disposal behavior unresolved.
- There is no current `RemixScope`. `FortalScope` is deliberately token/theme-only; caller-owned Overlay and Navigator capabilities remain separate. Toast needs a focused `RemixToastScope` because it owns a queue and timers, not a global Remix service locator.
- All 23 currently tracked Fortal families have a recipe source and public/generated wrapper where the family is visual. Generic wrappers such as `FortalMenu<T>` live in generated files.
- There is intentionally no `showFortalDialog`; compose `FortalDialog` with `showRemixDialog`. `RemixRadioGroup` is nonvisual, and menu/select item visuals resolve through their parent spec trees rather than separate Fortal item widgets.

### `naked_ui` beta.8 capability inventory

The installed source contains button, accordion, popover, checkbox, dialog, menu, tabs, radio, select, slider, text field, tooltip, toggle, and toggle-group primitives. Relevant unexposed capabilities are:

- `NakedMenuCheckboxItem<T>` with checked state, optional callback, disabled state, close-on-activate, and `menuItemCheckbox` semantics.
- `NakedMenuRadioGroup<T>` / `NakedMenuRadioItem<T>` with controlled selection, mutual-exclusion semantics, and disabled propagation.
- `NakedMenuSubmenu<T>` with hover delay, positioning, LTR/RTL arrow behavior, Escape handling, focus restoration, and recursive close.
- `NakedToggleGroup<T>` / `NakedToggleOption<T>` with single selection, orientation, looping roving focus, Home/End, and RTL-aware navigation.
- `NakedTextField` with native multiline arguments and editable semantics.

No Naked primitive is needed for Skeleton, DataList, DataTable, or Toast. Flutter has no checkbox-group or toast-queue coordinator, so PR 3 owns a lightweight value-coordination scope (one-tab-stop roving focus is deferred) while continuing to delegate each option's activation and semantics to `RemixCheckbox`/Naked, and PR 10 owns the focused toast queue layer. Flutter 3.44 provides native `table`, `row`, `columnHeader`, and `cell` semantics roles with enforced parent/child structure; PR 9 must use those roles rather than inventing a web-like accessibility model. It also provides `status` and `alert` roles that must not be combined with `liveRegion`; PR 10 must prefer those implicit updates over explicit announcement calls.

## Reference behavior by proposed component

| Surface | Required baseline | Deliberate Flutter adaptation |
| --- | --- | --- |
| Menu item variants | Checkbox items, radio group/items, and recursive submenu; preserve Naked keyboard/focus behavior. | Add an indicator style plus a panel-wide conditional leading gutter, and reuse one recursive Remix renderer/spec tree. |
| Skeleton | Loading defaults true; child geometry is preserved; loading content is noninteractive and absent from accessibility; pulse is 1000 ms. | Respect `MediaQuery.disableAnimationsOf`; expose no fake progress semantics. |
| CheckboxGroup | Controlled set, required/disabled; upstream also roves focus with orientation/loop/RTL. | No fabricated group role exists in Flutter; options retain checkbox semantics inside a labeled container, and v1 uses standard traversal with roving recorded as deferred. |
| SegmentedControl | Controlled single selection; equal segments; sizes 1-3; surface/classic variants. | Orientation and item-disabled are useful extensions. Sliding selection and Radix separators are recorded approximations for v1. |
| TextArea | Same editable as TextField with two-line multiline defaults; Radix sizes 1-3 and classic/surface/soft recipes. | No browser drag-resize; Flutter constraints and line counts are the public layout mechanism, and the default unbounded `maxLines` auto-grows rather than behaving like a fixed web textarea. |
| DataList | Semantic label/value rows; horizontal aligned label column or vertical stack; sizes 1-3. | Use `Table` horizontally so labels align across rows; preserve custom-child semantics. |
| DataTable | Compare many records in shared columns; caller-owned sorting/filtering, optional controlled page selection and pagination, arbitrary cells, sizes 1-3, surface/ghost variants. | Build the current page with Flutter's host-neutral `Table`; keep data mutation/fetching outside the widget and defer virtualization/editing/pinning to a future grid. |
| Toast | Nonmodal queued feedback with optional action/close, four-second or persistent lifetime, polite/assertive priority, bounded stack, and stable dismissal handles. | Coordinate through `RemixToastScope` and one `OverlayPortal`; pause interactive lifetimes for accessibility/focus/hover/app lifecycle, use directional safe-area placement, and track Fortal visuals as an extension rather than Radix Themes parity. |
| Typography | Text/Heading/Code/Kbd/Link sizes 1-9 and component variants. | Flutter has heading, keyboard-key, and link semantics but no code role, CSS tag polymorphism, trim, or browser wrap modes. |

Full-page live-site captures of every relevant Radix Themes docs page live in
`plan/radix-reference/` (index and expected per-component deltas in its
`README.md`). They are feature-comparison aids for the implementing PRs; the
pinned artifact below remains the exact-value authority, and Toast has no
capture because it is not a Radix Themes component.

The behavior references are the official [Radix Dropdown Menu](https://www.radix-ui.com/themes/docs/components/dropdown-menu), [Checkbox Group](https://www.radix-ui.com/themes/docs/components/checkbox-group), [Skeleton](https://www.radix-ui.com/themes/docs/components/skeleton), [Segmented Control](https://www.radix-ui.com/themes/docs/components/segmented-control), [Text Area](https://www.radix-ui.com/themes/docs/components/text-area), [Data List](https://www.radix-ui.com/themes/docs/components/data-list), [Table](https://www.radix-ui.com/themes/docs/components/table), and typography pages ([Text](https://www.radix-ui.com/themes/docs/components/text), [Heading](https://www.radix-ui.com/themes/docs/components/heading), [Code](https://www.radix-ui.com/themes/docs/components/code), [Kbd](https://www.radix-ui.com/themes/docs/components/kbd), [Link](https://www.radix-ui.com/themes/docs/components/link)). The [shadcn/ui component inventory](https://ui.shadcn.com/docs/components) was used as a breadth check, not as the styling or behavior authority. Toast behavior is grounded in Flutter 3.44 semantics/overlay/lifecycle APIs and the dashboard consumer; Radix Themes has no mapped Toast family. Exact visual claims must be checked against `packages/remix/reference/radix_themes_3_3_0/manifest.json` and its pinned source artifact before implementation.

## Semantics contract

Flutter's `Semantics` API and `SemanticsRole` are the authority for the native tree. Tests must use `tester.ensureSemantics()` and exact matchers where feasible.

- Menu checkbox/radio options expose `SemanticsRole.menuItemCheckbox` / `menuItemRadio`, checked state, mutual exclusion for radio, enabled state, and one tap action.
- Skeleton loading output contributes no semantics and suppresses child pointer actions. When `loading == false`, the original child semantics and interaction return.
- Checkbox-group options remain checkboxes. The group is a container with an optional label and required state; do not invent an unavailable role.
- Segmented options retain Naked's button + selected semantics and keyboard actions; do not assert checkbox/checked semantics.
- TextArea exposes `isTextField`, `isMultiline`, enabled/read-only state, and label/hint/helper/error exactly once.
- DataList uses list/list-item roles. A string row combines label and value once; a custom child retains its own interactive semantics.
- DataTable exposes one `table` node whose immediate children are `row` nodes. Header-row children are `columnHeader` nodes and body-row children are `cell` nodes. Sort and selection controls retain exactly one action/checked state beneath those structural nodes, and arbitrary interactive cells keep their own semantics.
- Toast advisory text exposes one `SemanticsRole.status` node; urgent/time-sensitive text uses `SemanticsRole.alert`. Neither also sets `liveRegion`. Decorative icons and duplicate visual text are excluded, action/close controls stay separate, and presentation never steals focus or calls SemanticsService for an ordinary update.
- Heading sets `header: true` and `headingLevel` 1-6. Kbd sets `keyboardKey: true`. An actionable Link exposes link state/action exactly once; inert text must not pretend to be a link.

Useful Flutter references: [Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html), [SemanticsRole](https://api.flutter.dev/flutter/dart-ui/SemanticsRole.html), [`headingLevel`](https://api.flutter.dev/flutter/widgets/SemanticsProperties/headingLevel.html), [`keyboardKey`](https://api.flutter.dev/flutter/widgets/SemanticsProperties/keyboardKey.html), and [`matchesSemantics`](https://api.flutter.dev/flutter/flutter_test/matchesSemantics.html).

## Fortal parity contract

Fortal parity is executable, not a documentation-only checklist:

- `packages/remix/tool/fortal_parity/check.dart` validates the manifest, evidence, source selectors, recipe ownership, props/variants, state tests, approximation records, and Chromium probes.
- `packages/remix/reference/radix_themes_3_3_0/manifest.json` currently describes 20 mapped families and three Fortal extensions.
- `coverage_evidence.json` and each per-family parity test are part of the contract.
- `tool/fortal_parity/chromium/fixture.html` and `generate.mjs` produce the pinned computed styles and a fixed 1440x1280 reference image.
- Count rebase (2026-08-07): PR 9 merged early (#109), so main is already at 21
  mapped + 3 extensions. PR 7 raises the mapped count to 25 (28 total including
  extensions); PR 8 raises it to 30 (33 total); PR 10 keeps 30 mapped and adds
  Toast as extension 4 (34 total). Update manifest-schema min/max, hard-coded
  checker counts, and success text in the same PR, and re-verify live counts at
  branch time.
- CheckboxGroup adds no separate mapped Fortal family in this series: the Remix group is intentionally layout-transparent and its options use the already mapped Fortal Checkbox recipe. PR 7 adds a checker-enforced `unmappedUpstreamFamilies` record for Radix CheckboxGroup's root/item gap, label row, and propagated size/variant/color/high-contrast anatomy so this is an audited scope decision rather than a silent parity claim. A future styled group API must remove that record and add a mapped family atomically.
- The fixture currently lays out the mapped-family probes in a four-column grid (21 probes after #109). Expand it for the added probes (five columns and a smaller cell minimum is the recommended starting point) while preserving the exact output dimensions.
- The Chromium image is evidence of Radix's web output, not an oracle that validates Flutter rendering.

PR 1 must also update the existing menu family's manifest/evidence because checkbox, radio, and submenu are currently declared deferred. Correct the parity README's stale `naked_ui` beta.7 wording to beta.8 there.

## Screenshot finding

The old automated component atlas was intentionally removed in commit `2520131a8` (#83). Do not restore it. Each PR uses the real playground for manually captured light and dark states. Fortal PRs additionally include a side-by-side Radix 3.3 reference comparison in the PR description. The pinned parity fixture remains a separate machine-generated reference artifact.

## Execution status (2026-08-07)

Merged on `origin/main`: PR 1 menu items (#101), PR 2 skeleton (#104), PR 3
checkbox group (#105 + #106, standard traversal with roving deferred as
planned), PR 4 segmented control (#108), PR 5 textarea (#107), PR 6 data list
(#103), and PR 9 data table (#109 with follow-ups #110-#112), including the
dashboard DataGrid migration and the `data_table` mapped family. Remaining:
PR 7 Fortal recipes (skeleton, segmented control, textarea, data list — menu
was completed inside #101), PR 8 Fortal typography, and PR 10 Toast (the
dashboard `toast.dart` prototype still exists and awaits migration). Remaining
order: 7 → 8 → 10, serialized on the parity ledger.

## Dependency graph

```text
PR 1 menu ───────────┐
PR 2 skeleton ───────┤
PR 3 checkbox group ─┤
PR 4 segmented ──────┼──> PR 7 Fortal recipes
PR 5 textarea ───────┤
PR 6 data list ──────┘

PR 8 Fortal typography (independent of PR 1-7; sequence last to reduce parity-file conflicts)

PR 9 DataTable (vertical Remix + Fortal slice; execute after PR 8 and after rebasing onto origin/main)

PR 10 Toast (vertical Remix + Fortal slice; code-independent, but execute after PR 9 to serialize parity-ledger edits)
```

PRs 1-6 are logically independent, but all touch `remix.dart`, public-API tests, docs navigation, and the playground registry, so parallel branches will need small conflict resolutions. PR 7 must start after all six land. PR 8 is code-independent from PR 7 but should follow it because both rewrite parity manifest/evidence/checker and the Chromium fixture. PR 9 is a self-contained vertical slice and follows PR 8 so it can advance the already-expanded parity ledger once rather than reopening PR 7. PR 10 is code-independent from DataTable but follows PR 9 because both change the family set/count; unlike mapped families, the Toast extension must not add a fake Radix Chromium probe.

## Exclusions and escalation boundary

Sheet, context menu, hover card, combobox, date picker, and an advanced data grid remain out of scope. DataTable and Toast are accepted as PRs 9-10; they do not absorb those gaps. The evidence and promotion criteria for every deferred item live in `02-deferred-gaps.md`.

## Decisions closed by this discovery

- All changes are additive; no feature flags or data migrations.
- Every per-PR API sketch uses the canonical post-#100 `{Component}Spec` /
  `{Component}Styler` names (for example `SkeletonStyler`, `MenuItemStyler`,
  `TextFieldSpec`); the deprecated `Remix*` typedefs are compatibility aliases
  only and no new family or field may introduce one.
- Phase 1 is one PR per requested component.
- SegmentedControl is a dedicated public component over the same Naked primitives, not a styled ToggleGroup wrapper.
- TextArea is a constructor-only subtype/facade over `RemixTextField`, not a second spec tree.
- CheckboxGroup is a headless coordinator that composes `RemixCheckbox`.
- Const collection-owning public constructors retain the caller collection, as existing Remix components do; every implementation snapshots at consumption/emission and documents no mutation during a build.
- CheckboxGroup remains intentionally unmapped visually in this series, with an executable upstream-inventory record added in PR 7.
- PR 5 corrects the shared TextField semantics boundary so visible label/hint/helper text is announced once and interactive accessories remain independent nodes.
- Skeleton loading toggles preserve a mounted child's identity/local state.
- CheckboxGroup v1 uses standard Flutter traversal; Radix's one-tab-stop roving focus (and its orientation/loop parameters) is a recorded deferred capability, and focus props forward straight to the composed checkbox.
- Menu compound items ship with standard flex row geometry and a permanent manifest approximation for Radix's CSS-absolute indicator/trailing offsets; `origin/feat/menu-items` implements PR 1 including full Fortal menu styling, so PR 7 no longer touches the menu family.
- Horizontal DataList documents its intrinsic minimum-width boundary and caller-owned vertical fallback.
- Offset or layered focus/selected surfaces use Remix effects, not a one-layer foreground decoration shortcut.
- Fortal typography is a hand-written Fortal-only module because its meaning depends on Fortal tokens; upstream null-color inheritance is preserved.
- DataList and DataTable both remain: DataList describes one record as label/value metadata; DataTable compares many records in shared columns.
- `RemixDataTable<T>` is controlled presentation and interaction plumbing. Callers own sorting, filtering, fetching, and which rows form the current page.
- The public name is DataTable, not DataGrid. Virtualization, pinned/resizable/reorderable columns, cell editing/selection, and spreadsheet keyboard navigation are a separate future integration.
- Toast is a package component, but its queue/timer/portal ownership lives in the dedicated `RemixToastScope`; no general `RemixScope`, `RemixApp`, or global overlay registry is introduced.
- Toast uses one caller-hosted `OverlayPortal`, explicit controller ownership, bounded FIFO visible/pending sets, status/alert roles without `liveRegion`, focus-safe interactive timeouts, reduced motion, and directional safe-area placement. `FortalToast` is generated, while scope/helper behavior remains Remix-level composition.
- The post-review choices above close the known implementation-blocking decisions. Any unavoidable public-API deviation discovered during a PR must be called out before expanding scope.
