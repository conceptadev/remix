# Plan: Remix component-gap discovery

> Verified baseline and decision record for six additive Remix components followed by Fortal recipes and typography.

## Objective

Establish the source-backed constraints that every implementation PR must preserve. The target is Radix Themes 3.3.0 parity where that maps cleanly to Flutter, while keeping interaction behavior in Flutter or `naked_ui` primitives and keeping visual policy in Mix/Fortal recipes.

- Primary outcome: a shared evidence base for `pr-01` through `pr-08`.
- Out of scope: implementing the components in this planning change.
- Reference baseline: the repository's pinned `@radix-ui/themes@3.3.0` artifact, not the moving Radix website.

## Repository baseline

| Concern | Verified state | Evidence |
| --- | --- | --- |
| Branch baseline | This plan was researched at `40704eb37`, equal to `origin/main` at the time of research. | `git rev-parse HEAD origin/main` |
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
| Checkbox roving focus | `ExcludeFocusTraversal` leaves one Tab stop while direct `FocusNode.requestFocus()` still reaches excluded siblings. | Roving traversal uses wrappers, not mutations as its primary mechanism. |
| Equal segment layout | The proposed intrinsic `Flex` plus `Expanded` composition equalizes horizontal and vertical extents in a focused widget test. | Keep the simple private layout first, with constraint/high-scale tests before considering a render object. |
| TextField semantics | A real semantics dump repeats label/hint/helper text, and an interactive trailing button is absorbed by Naked's `MergeSemantics`. | PR 5 includes a shared TextField semantics-boundary correction, not only TextArea hint alignment. |
| TextField outer hit fallback | Naked's selection detector currently owns multi-tap callback policy and pressed transitions, while a normal `GestureDetector` adds a semantic tap action. | PR 5 requires a semantics-silent fallback that preserves `onTapAlwaysCalled`, pressed down/up/cancel, focus-node lifecycle, and child gesture precedence. |
| Menu radio activation | Pinned Naked beta.8 invokes both root selection and group change even when the selected radio item is activated again. | Tests require re-emission; they do not speculate about suppression. |
| Menu vectors/geometry | `RemixPathGlyph.thickCheck` exactly transcribes Radix's nine-unit check path; the pinned right-chevron path is absent locally. Radix also auto-end-aligns the trailing slot with `space4` leading padding and a -2 × scaling submenu-icon end margin. | PRs 1/7 use exact path assets and explicit trailing geometry rather than an unjustified glyph tolerance. |
| Skeleton child identity | Switching between a direct child and a nested loading branch changes the Flutter element path even when the child has a stable key. | PR 2 keeps one child wrapper path across loading toggles and tests local-state retention/single mount. |
| Checkbox-group reconciliation | Keyed children can reorder without unregistering, and forwarding item autofocus lets Naked bypass group arbitration. | PR 3 derives order from the current focus hierarchy and consumes autofocus in the group while passing `autofocus: false` inward. |
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
- All 23 currently tracked Fortal families have a recipe source and public/generated wrapper where the family is visual. Generic wrappers such as `FortalMenu<T>` live in generated files.
- There is intentionally no `showFortalDialog`; compose `FortalDialog` with `showRemixDialog`. `RemixRadioGroup` is nonvisual, and menu/select item visuals resolve through their parent spec trees rather than separate Fortal item widgets.

### `naked_ui` beta.8 capability inventory

The installed source contains button, accordion, popover, checkbox, dialog, menu, tabs, radio, select, slider, text field, tooltip, toggle, and toggle-group primitives. Relevant unexposed capabilities are:

- `NakedMenuCheckboxItem<T>` with checked state, optional callback, disabled state, close-on-activate, and `menuItemCheckbox` semantics.
- `NakedMenuRadioGroup<T>` / `NakedMenuRadioItem<T>` with controlled selection, mutual-exclusion semantics, and disabled propagation.
- `NakedMenuSubmenu<T>` with hover delay, positioning, LTR/RTL arrow behavior, Escape handling, focus restoration, and recursive close.
- `NakedToggleGroup<T>` / `NakedToggleOption<T>` with single selection, orientation, looping roving focus, Home/End, and RTL-aware navigation.
- `NakedTextField` with native multiline arguments and editable semantics.

No Naked primitive is needed for Skeleton or DataList because neither introduces interaction state. Flutter has no checkbox-group coordinator, so PR 3 owns a bounded private registration and roving-focus layer while continuing to delegate each option's activation and semantics to `RemixCheckbox`/Naked.

## Reference behavior by proposed component

| Surface | Required baseline | Deliberate Flutter adaptation |
| --- | --- | --- |
| Menu item variants | Checkbox items, radio group/items, and recursive submenu; preserve Naked keyboard/focus behavior. | Add an indicator style plus a panel-wide conditional leading gutter, and reuse one recursive Remix renderer/spec tree. |
| Skeleton | Loading defaults true; child geometry is preserved; loading content is noninteractive and absent from accessibility; pulse is 1000 ms. | Respect `MediaQuery.disableAnimationsOf`; expose no fake progress semantics. |
| CheckboxGroup | Controlled set, required/disabled, orientation, loop, RTL-aware roving focus. | No fabricated group role exists in Flutter; options retain checkbox semantics inside a labeled container. |
| SegmentedControl | Controlled single selection; equal segments; sizes 1-3; surface/classic variants. | Orientation and item-disabled are useful extensions. Sliding selection and Radix separators are recorded approximations for v1. |
| TextArea | Same editable as TextField with two-line multiline defaults; Radix sizes 1-3 and classic/surface/soft recipes. | No browser drag-resize; Flutter constraints and line counts are the public layout mechanism, and the default unbounded `maxLines` auto-grows rather than behaving like a fixed web textarea. |
| DataList | Semantic label/value rows; horizontal aligned label column or vertical stack; sizes 1-3. | Use `Table` horizontally so labels align across rows; preserve custom-child semantics. |
| Typography | Text/Heading/Code/Kbd/Link sizes 1-9 and component variants. | Flutter has heading, keyboard-key, and link semantics but no code role, CSS tag polymorphism, trim, or browser wrap modes. |

The behavior references are the official [Radix Dropdown Menu](https://www.radix-ui.com/themes/docs/components/dropdown-menu), [Checkbox Group](https://www.radix-ui.com/themes/docs/components/checkbox-group), [Skeleton](https://www.radix-ui.com/themes/docs/components/skeleton), [Segmented Control](https://www.radix-ui.com/themes/docs/components/segmented-control), [Text Area](https://www.radix-ui.com/themes/docs/components/text-area), [Data List](https://www.radix-ui.com/themes/docs/components/data-list), and typography pages ([Text](https://www.radix-ui.com/themes/docs/components/text), [Heading](https://www.radix-ui.com/themes/docs/components/heading), [Code](https://www.radix-ui.com/themes/docs/components/code), [Kbd](https://www.radix-ui.com/themes/docs/components/kbd), [Link](https://www.radix-ui.com/themes/docs/components/link)). The [shadcn/ui component inventory](https://ui.shadcn.com/docs/components) was used as a breadth check, not as the styling or behavior authority. Exact visual claims must be checked against `packages/remix/reference/radix_themes_3_3_0/manifest.json` and its pinned source artifact before implementation.

## Semantics contract

Flutter's `Semantics` API and `SemanticsRole` are the authority for the native tree. Tests must use `tester.ensureSemantics()` and exact matchers where feasible.

- Menu checkbox/radio options expose `SemanticsRole.menuItemCheckbox` / `menuItemRadio`, checked state, mutual exclusion for radio, enabled state, and one tap action.
- Skeleton loading output contributes no semantics and suppresses child pointer actions. When `loading == false`, the original child semantics and interaction return.
- Checkbox-group options remain checkboxes. The group is a container with an optional label and required state; do not invent an unavailable role.
- Segmented options retain Naked's button + selected semantics and keyboard actions; do not assert checkbox/checked semantics.
- TextArea exposes `isTextField`, `isMultiline`, enabled/read-only state, and label/hint/helper/error exactly once.
- DataList uses list/list-item roles. A string row combines label and value once; a custom child retains its own interactive semantics.
- Heading sets `header: true` and `headingLevel` 1-6. Kbd sets `keyboardKey: true`. An actionable Link exposes link state/action exactly once; inert text must not pretend to be a link.

Useful Flutter references: [Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html), [SemanticsRole](https://api.flutter.dev/flutter/dart-ui/SemanticsRole.html), [`headingLevel`](https://api.flutter.dev/flutter/widgets/SemanticsProperties/headingLevel.html), [`keyboardKey`](https://api.flutter.dev/flutter/widgets/SemanticsProperties/keyboardKey.html), and [`matchesSemantics`](https://api.flutter.dev/flutter/flutter_test/matchesSemantics.html).

## Fortal parity contract

Fortal parity is executable, not a documentation-only checklist:

- `packages/remix/tool/fortal_parity/check.dart` validates the manifest, evidence, source selectors, recipe ownership, props/variants, state tests, approximation records, and Chromium probes.
- `packages/remix/reference/radix_themes_3_3_0/manifest.json` currently describes 20 mapped families and three Fortal extensions.
- `coverage_evidence.json` and each per-family parity test are part of the contract.
- `tool/fortal_parity/chromium/fixture.html` and `generate.mjs` produce the pinned computed styles and a fixed 1440x1280 reference image.
- PR 7 raises the mapped count to 24 (27 total including extensions); PR 8 raises it to 29 (32 total including extensions). Update manifest-schema min/max, hard-coded checker counts, and success text in the same PR.
- CheckboxGroup adds no separate mapped Fortal family in this series: the Remix group is intentionally layout-transparent and its options use the already mapped Fortal Checkbox recipe. PR 7 adds a checker-enforced `unmappedUpstreamFamilies` record for Radix CheckboxGroup's root/item gap, label row, and propagated size/variant/color/high-contrast anatomy so this is an audited scope decision rather than a silent parity claim. A future styled group API must remove that record and add a mapped family atomically.
- The fixture currently lays out 20 probes in four columns. Expand it for the added probes (five columns and a smaller cell minimum is the recommended starting point) while preserving the exact output dimensions.
- The Chromium image is evidence of Radix's web output, not an oracle that validates Flutter rendering.

PR 1 must also update the existing menu family's manifest/evidence because checkbox, radio, and submenu are currently declared deferred. Correct the parity README's stale `naked_ui` beta.7 wording to beta.8 there.

## Screenshot finding

The old automated component atlas was intentionally removed in commit `2520131a8` (#83). Do not restore it. Each PR uses the real playground for manually captured light and dark states. Fortal PRs additionally include a side-by-side Radix 3.3 reference comparison in the PR description. The pinned parity fixture remains a separate machine-generated reference artifact.

## Dependency graph

```text
PR 1 menu ───────────┐
PR 2 skeleton ───────┤
PR 3 checkbox group ─┤
PR 4 segmented ──────┼──> PR 7 Fortal recipes
PR 5 textarea ───────┤
PR 6 data list ──────┘

PR 8 Fortal typography (independent of PR 1-7; sequence last to reduce parity-file conflicts)
```

PRs 1-6 are logically independent, but all touch `remix.dart`, public-API tests, docs navigation, and the playground registry, so parallel branches will need small conflict resolutions. PR 7 must start after all six land. PR 8 is code-independent from PR 7 but should follow it because both rewrite parity manifest/evidence/checker and the Chromium fixture.

## Exclusions and escalation boundary

Toast, sheet, context menu, hover card, combobox, table, and date picker remain out of scope. They require behavior or upstream headless primitives that are not safely supplied by this component-gap series. Do not broaden any PR to include them.

## Decisions closed by this discovery

- All changes are additive; no feature flags or data migrations.
- Phase 1 is one PR per requested component.
- SegmentedControl is a dedicated public component over the same Naked primitives, not a styled ToggleGroup wrapper.
- TextArea is a constructor-only subtype/facade over `RemixTextField`, not a second spec tree.
- CheckboxGroup is a headless coordinator that composes `RemixCheckbox`.
- Const collection-owning public constructors retain the caller collection, as existing Remix components do; every implementation snapshots at consumption/emission and documents no mutation during a build.
- CheckboxGroup remains intentionally unmapped visually in this series, with an executable upstream-inventory record added in PR 7.
- PR 5 corrects the shared TextField semantics boundary so visible label/hint/helper text is announced once and interactive accessories remain independent nodes.
- Skeleton loading toggles preserve a mounted child's identity/local state.
- CheckboxGroup ordering follows the current focus hierarchy, not historical registration order; group-owned autofocus is never forwarded to the inner checkbox.
- Horizontal DataList documents its intrinsic minimum-width boundary and caller-owned vertical fallback.
- Offset or layered focus/selected surfaces use Remix effects, not a one-layer foreground decoration shortcut.
- Fortal typography is a hand-written Fortal-only module because its meaning depends on Fortal tokens; upstream null-color inheritance is preserved.
- The post-review choices above close the known implementation-blocking decisions. Any unavoidable public-API deviation discovered during a PR must be called out before expanding scope.
