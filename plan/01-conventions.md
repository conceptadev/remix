# Plan: Component-gap implementation conventions

> Shared execution, testing, documentation, screenshot, and review contract for all ten planned PRs.

## Objective

Make every PR independently reviewable, release-ready, and consistent with the current Remix/Mix architecture. These rules override generic habits when they are more specific.

- Primary outcome: the same quality gate and evidence shape for each PR.
- Out of scope: restoring removed screenshot automation or adding unrelated components.
- Compatibility posture: additive public APIs, plus the explicitly named
  TextField semantics and Fortal TextField parity corrections in PRs 5 and 7;
  no migrations or flags.

## Starting a PR

1. Branch from current `main`; use the order and exact conventional titles in the corresponding plan.
2. Run `fvm dart run melos bootstrap` after rebasing or when dependencies change.
3. Re-read the named adjacent implementation and tests. Treat plan code sketches as contracts, not paste-ready replacements for current source.
4. Write the first focused failing test before production code. Keep generated code out of the red-test step.
5. Keep the PR scoped to its component plus the required shared API, docs, playground, parity, and generated updates.

Do not rename the branch as part of execution. Do not edit generated `.g.dart` files by hand.

## Component shape and reuse rule

For a genuinely new styled component, use:

```text
packages/remix/lib/src/components/<name>/
  <name>.dart
  <name>_spec.dart
  <name>_style.dart
  <name>_widget.dart
  <name>.g.dart                 # generated
  fortal_<name>_styles.dart     # only when the Fortal recipe lands
```

Follow the current Mix annotation and variant APIs from the repository's `mix` skill and the concrete nearest-neighbor component named by the PR plan. After rebasing #100, new generated families use canonical `{Component}Spec` and `{Component}Styler` names while the widget remains `Remix{Component}`; do not add legacy `Remix*Spec`/`Remix*Styler` aliases to brand-new APIs. Prefer immutable public data models, `const` constructors where legal, directional geometry (`EdgeInsetsDirectional`, `AlignmentDirectional`), and resolver-time token lookup.

Every PR description must contain a short **Reuse and duplication** section:

- Name the Naked/Flutter/Remix primitive reused.
- Explain any deliberately parallel public component or spec tree.
- State why wrapping or inheritance would create the wrong API/anatomy.
- Put the same rationale in one code comment at the relevant class or renderer when future maintainers might otherwise merge the abstractions.

Do not create spec/style files or tests for a nonvisual coordinator or a facade that intentionally reuses an existing spec. That is noise, not coverage.

## Public API conventions

- Export new public libraries/types from `packages/remix/lib/remix.dart`.
- Add compile-time construction coverage to `packages/remix/test/public_api_test.dart`.
- Update `packages/remix/test/public_api_compatibility_test.dart` for the intended stable names, constructor shapes, enum values, named constructors, and generic inference.
- Prefer controlled APIs: input state plus callback, with callbacks receiving a fresh immutable snapshot.
- Keep collection-owning constructors `const`, matching the existing
  `RemixMenu` and `RemixToggleGroup` APIs. Because Dart cannot call
  `List.unmodifiable` or `Set.unmodifiable` in a const initializer, document
  that callers must not mutate a collection during a build and take a fresh
  unmodifiable snapshot when the component consumes it or emits it from a
  callback. Do not claim both constructor-time defensive copying and a const
  constructor.
- Assertions must reject ambiguous models (duplicate values, multiple autofocus items, invalid line ranges, or both/neither value sources).
- Avoid exposing Naked implementation types unless the existing neighboring API already does so.

## Styling conventions

- Keep structure and interaction in the Remix widget; keep Radix visual policy in Fortal recipes.
- Resolve all Fortal colors, spacing, radii, typography, durations, and shadows from tokens. If the exact Radix value lacks a token, add a narrowly named token and its light/dark resolution tests rather than copying literals through recipes.
- Use `RemixBoxEffectsSpec` / `Remix*WithEffects` for focus outlines when CSS
  outline offset, inset rings, or multiple paint layers matter. A plain
  `foregroundDecoration` is acceptable only for a single in-bounds decoration
  that the pinned source does not offset or stack. Neither approach may change
  layout; `fortalFocusOutline` is the local offset-outline precedent.
- Keep recipes memoized in the same way as adjacent `fortal_*_styles.dart` files.
- Use widget-state variants for selected, checked, disabled, hover, focus, and pressed visuals; do not rebuild a headless state machine in styling code.
- Use directional alignment and padding. Add an RTL test whenever an icon, chevron, arrow key, or horizontal order is involved.
- Regenerate with `fvm dart run melos run generate` and commit the resulting `.g.dart` changes.

## Semantics and headless-control checklist

For every behavior-bearing widget test:

1. Create a semantics handle with `tester.ensureSemantics()` and dispose it.
2. Assert the exact role/state/action contract, not only that a label can be found.
3. Assert there is one semantic representation of visual text, not a visible child plus a duplicate wrapper.
4. Cover enabled, disabled, selected/checked, focus, keyboard activation, and callback suppression as applicable.
5. Exercise LTR and RTL for directional keys or layout.
6. Exercise high text scale and narrow constraints for layout components.
7. Exercise dynamic update/removal when a coordinator owns focus registration.

Use the platform model exposed by [Flutter Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html). Do not invent roles to imitate HTML. Preserve child semantics when a slot can contain an interactive widget, and keep nested interactive accessories outside any parent `MergeSemantics` boundary. Visual-only icons/labels beneath an explicit semantic wrapper should use `ExcludeSemantics`. When `excludeSemantics` means removal of a complete composite, implement it with an outer `ExcludeSemantics` rather than relying on `Semantics(excludeSemantics: true)` to hide only selected descendants.

Flutter 3.44's `matchesSemantics`/`isSemantics` arguments cover labels, flags, and actions but do not expose a role argument. Assert roles through `tester.getSemantics(finder).getSemanticsData().role`, then use the matcher appropriate to exact versus partial remaining properties. Never omit the role assertion merely because the convenience matcher lacks it.

Looping animations must honor [`MediaQuery.disableAnimationsOf`](https://api.flutter.dev/flutter/widgets/MediaQuery/disableAnimationsOf.html). Pump explicit durations in tests; never call `pumpAndSettle` while an animation repeats.

## Scope, overlay, and lifecycle checklist

Do not introduce a general `RemixScope` or Remix-owned application wrapper. A scope is justified only when one component family owns real shared lifecycle/state that cannot live in a leaf widget.

- `FortalScope` remains design-token/theme infrastructure only.
- Menu, select, popover, and tooltip continue to consume the nearest caller-owned Overlay; dialogs continue to consume the caller-owned Navigator.
- PR 10 adds only `RemixToastScope`, because a bounded queue, timers, controller attachment, dismissal futures, and one portal region require a stable owner.
- A coordinator that accepts an external controller disposes only its internally created controller, detaches external state on widget replacement/disposal, and rejects simultaneous attachment to multiple owners.
- Cancel Timer, Ticker, listener, FocusNode, and portal resources on every removal/disposal path. Tests must finish without pending asynchronous work or framework exceptions.
- Prefer `OverlayPortal` when overlay content must inherit live Directionality/MediaQuery/localization/Mix/Fortal state and must not outlive its owner. Mount the portal owner in a stable app shell; never in a recycled/offstage list item.
- Missing host capabilities throw focused diagnostics that name the required Overlay/Navigator/scope and show a minimal valid tree. Do not claim MaterialApp or Scaffold is mandatory when WidgetsApp/Overlay is sufficient.

## Test layout

For new styled components:

```text
packages/remix/test/components/<name>/<name>_spec_test.dart
packages/remix/test/components/<name>/<name>_style_test.dart
packages/remix/test/components/<name>/<name>_widget_test.dart
```

For facades/coordinators, add the focused widget test beside the reused family as specified by the PR. Fortal recipe work also updates:

- `packages/remix/test/fortal/fortal_control_matrix_test.dart`
- `packages/remix/test/components/fortal_widget_test.dart`
- `packages/remix/test/components/<name>/<name>_fortal_parity_test.dart` for each mapped family
- token/theme/high-contrast tests when tokens or accent resolution change

Test names should state observable behavior. Prefer selectors by type/key/semantics rather than implementation-private widget depth.

## Docs contract

Each component PR (PRs 1-6, 9, and 10) adds or updates a page under `docs/components/` and updates root `docs.json`. Model frontmatter and the CodeGroup shape on `docs/components/spinner.mdx`.

Each page contains:

- “When to use this” and a concrete non-use case.
- Public API examples that compile in `docs:check`.
- Controlled-state example where applicable.
- Keyboard, focus, semantics, reduced-motion, and RTL behavior where applicable.
- Styling/spec example for styled components.
- Fortal example only after its recipe exists; until PR 7, clearly label the Remix component as unopinionated.
- Documented deviations from Radix web behavior.

Update `README.md` / component inventory only in the PR named by the component plan. Never document `showFortalDialog`; dialogs compose `FortalDialog` with `showRemixDialog`.

## Playground and screenshots

Add `packages/playground/lib/registry/entries/<name>_entry.dart` and a slug entry in `packages/playground/lib/registry/component_registry.dart`. PR 1 must create the currently missing menu entry rather than “extend” a nonexistent one.

Run:

```bash
fvm dart run melos bootstrap
cd packages/playground
fvm flutter run -d chrome
```

Open `?component=<slug>` when direct selection is useful. The playground already runs inside `FortalScope` and exposes brightness switching; do not add a second app-level theme wrapper. PR 10 installs one `RemixToastScope` in the stable playground preview shell rather than creating a scope per button/example.

For every PR description attach:

- one light screenshot and one dark screenshot at the same viewport;
- all material variants/states, including disabled/selected/loading where relevant;
- a keyboard-focus state for interactive surfaces;
- a short caption naming any expected Radix difference.

For PRs 7, 8, and 9, also capture the matching Radix Themes 3.3 state and present Flutter and Radix side by side. PR 10 captures Fortal light/dark stacked Toast evidence but no Radix comparison because Toast is an extension. Do this manually; commit no new atlas harness or general screenshot binary. The only committed reference image regenerated by mapped-family PRs is the existing parity fixture output.

## Fortal parity update protocol

Any PR that changes a mapped Fortal family must update the contract atomically:

1. Recipe/source and generated wrapper.
2. Family entry in `packages/remix/reference/radix_themes_3_3_0/manifest.json`.
3. Matching aggregate count/schema changes in
   `packages/remix/reference/radix_themes_3_3_0/manifest.schema.json`.
4. Evidence in `coverage_evidence.json`.
5. Source selectors, family sets/counts, state requirements, probe expectations, and success text in `packages/remix/tool/fortal_parity/check.dart`.
6. Per-family parity and shared control/widget tests.
7. Chromium fixture probes in `tool/fortal_parity/chromium/fixture.html`.
8. Regenerated `reference/radix_themes_3_3_0/chromium/computed-styles.json` and `families-light.png`.
9. Reference README when commands, counts, or dependency wording change.

If an upstream family is intentionally not mapped, it must still have a
schema-validated inventory record with pinned source files/selectors, the
reason it is unmapped, the supported Flutter composition, and the condition
that would reopen mapping. The checker must reject an untracked omission; an
unmapped record does not increase mapped/extension family counts.

Regenerate the web fixture with:

```bash
cd packages/remix/tool/fortal_parity/chromium
npm ci
npm run generate
```

Keep the output at 1440x1280. Record a manifest approximation for a real platform or v1 difference; never silently omit an upstream prop/state.

For a Fortal extension such as Toast, update the manifest/evidence family entry, expected extension set, total count, success text, and relevant tests. Keep upstream source files/selectors empty and do not add a Chromium probe for a Radix Themes component that does not exist.

## Required validation

During implementation, run the narrowest test file after each behavioral slice. Before handing off any PR, return to the repository root and run the nonduplicative release gate in order:

```bash
fvm dart format --output=none --set-exit-if-changed packages/remix/lib packages/remix/test packages/playground/lib
fvm dart run melos run generate
git diff --check
# Review every intentional generated-file diff before continuing.
fvm dart analyze packages/remix
fvm dart run melos run ci
```

`melos run ci` is the aggregate gate for generation drift, docs, Fortal parity,
Flutter tests, and the Mix consumer. Run its constituent scripts separately
only to diagnose a failure; running all of them immediately before the
aggregate command adds time without additional evidence. The completion report
must name every command actually run, confirm that generated diffs were
reviewed, and distinguish unrelated pre-existing failures.

## PR description checklist

- [ ] Exact conventional title from the plan.
- [ ] Problem and user-facing outcome.
- [ ] Reuse and duplication decision.
- [ ] Public API with migration statement (“additive; no migration”).
- [ ] Keyboard/focus/semantics behavior.
- [ ] Radix 3.3 mapping and documented approximations.
- [ ] Tests and exact validation commands/results.
- [ ] Light/dark screenshots; Radix side-by-side where required.
- [ ] Generated files reviewed and committed.
- [ ] Docs/navigation/playground/public API updated.
- [ ] No unrelated formatting or refactor churn.

## Rollout and rollback

No feature flags, staged deploys, or data migrations are required. Each component is an additive package release. Roll back by reverting its single PR; PRs 7/8/9 must each be reverted with their manifest/evidence/checker/fixture changes as one unit, and PR 10 with its extension-ledger changes as one unit, so the parity gate remains internally consistent.
