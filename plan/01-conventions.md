# Plan: Component-gap implementation conventions

> Shared execution, testing, documentation, screenshot, and review contract for all eight PRs.

## Objective

Make every PR independently reviewable, release-ready, and consistent with the current Remix/Mix architecture. These rules override generic habits when they are more specific.

- Primary outcome: the same quality gate and evidence shape for each PR.
- Out of scope: restoring removed screenshot automation or adding unrelated components.
- Compatibility posture: additive public APIs only; no migrations or flags.

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

Follow the current Mix annotation and variant APIs from the repository's `mix` skill and the concrete nearest-neighbor component named by the PR plan. Prefer immutable public data models, `const` constructors where legal, directional geometry (`EdgeInsetsDirectional`, `AlignmentDirectional`), and resolver-time token lookup.

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
- Public collections are copied at the boundary; do not retain caller-owned mutable lists/sets.
- Assertions must reject ambiguous models (duplicate values, multiple autofocus items, invalid line ranges, or both/neither value sources).
- Avoid exposing Naked implementation types unless the existing neighboring API already does so.

## Styling conventions

- Keep structure and interaction in the Remix widget; keep Radix visual policy in Fortal recipes.
- Resolve all Fortal colors, spacing, radii, typography, durations, and shadows from tokens. If the exact Radix value lacks a token, add a narrowly named token and its light/dark resolution tests rather than copying literals through recipes.
- Use `foregroundDecoration` for focus rings so focus does not change layout.
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

Use the platform model exposed by [Flutter Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html). Do not invent roles to imitate HTML. Preserve child semantics when a slot can contain an interactive widget. Visual-only icons/labels beneath an explicit semantic wrapper should use `ExcludeSemantics`.

Looping animations must honor [`MediaQuery.disableAnimationsOf`](https://api.flutter.dev/flutter/widgets/MediaQuery/disableAnimationsOf.html). Pump explicit durations in tests; never call `pumpAndSettle` while an animation repeats.

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

Each Phase 1 PR adds or updates a page under `docs/components/` and updates root `docs.json`. Model frontmatter and the CodeGroup shape on `docs/components/spinner.mdx`.

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

Open `?component=<slug>` when direct selection is useful. The playground already runs inside `FortalScope` and exposes brightness switching; do not add a second app-level theme wrapper.

For every PR description attach:

- one light screenshot and one dark screenshot at the same viewport;
- all material variants/states, including disabled/selected/loading where relevant;
- a keyboard-focus state for interactive surfaces;
- a short caption naming any expected Radix difference.

For PRs 7 and 8, also capture the matching Radix Themes 3.3 state and present Flutter and Radix side by side. Do this manually; commit no new atlas harness or general screenshot binary. The only committed reference image regenerated by these PRs is the existing parity fixture output.

## Fortal parity update protocol

Any PR that changes a mapped Fortal family must update the contract atomically:

1. Recipe/source and generated wrapper.
2. Family entry in `packages/remix/reference/radix_themes_3_3_0/manifest.json`.
3. Evidence in `coverage_evidence.json`.
4. Source selectors, family sets/counts, state requirements, probe expectations, and success text in `packages/remix/tool/fortal_parity/check.dart`.
5. Per-family parity and shared control/widget tests.
6. Chromium fixture probes in `tool/fortal_parity/chromium/fixture.html`.
7. Regenerated `reference/radix_themes_3_3_0/chromium/computed-styles.json` and `families-light.png`.
8. Reference README when commands, counts, or dependency wording change.

Regenerate the web fixture with:

```bash
cd packages/remix/tool/fortal_parity/chromium
npm ci
npm run generate
```

Keep the output at 1440x1280. Record a manifest approximation for a real platform or v1 difference; never silently omit an upstream prop/state.

## Required validation

During implementation, run the narrowest test file after each behavioral slice. Before handing off any PR, return to the repository root and run in order:

```bash
fvm dart format --output=none --set-exit-if-changed packages/remix/lib packages/remix/test packages/playground/lib
fvm dart run melos run generate
git diff --exit-code -- packages/remix/lib/src '**/*.g.dart'
fvm dart analyze packages/remix
fvm dart run melos run generate:check
fvm dart run melos run docs:check
fvm dart run melos run fortal:parity:check
fvm dart run melos run test:flutter
fvm dart run melos run mix:consumer:check
fvm dart run melos run ci
```

The `git diff --exit-code` line is only a generated-drift check after generation: inspect and stage intentional source/generated changes first, or substitute `git status --short` plus a reviewed generated diff. The completion report must name every command actually run and distinguish unrelated pre-existing failures.

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

No feature flags, staged deploys, or data migrations are required. Each component is an additive package release. Roll back by reverting its single PR; PRs 7/8 must be reverted with their manifest/evidence/checker/fixture changes as one unit so the parity gate remains internally consistent.
