# Plan: Add Remix Skeleton

> Add a decorative, reduced-motion-aware loading placeholder that preserves child geometry while suppressing hidden interactions and semantics.

## PR contract

- Title: `feat(remix): add skeleton component`
- Depends on: none.
- Compatibility: additive component; no migration.
- Primary outcome: `RemixSkeleton` supports child-sized and explicitly sized placeholders with a configurable Mix pulse.
- Out of scope: loading-state orchestration, live-region announcements, shimmer gradients, Fortal tokens/recipe (PR 7), and a Naked primitive.

## Context

- Radix Skeleton defaults to loading, preserves the dimensions of its child, makes loading content noninteractive, and hides it from accessibility. Its pinned visual pulse transitions gray alpha 3 to 4 over 1000 ms with alternate direction.
- There is no corresponding Naked primitive because Skeleton has no interaction contract.
- `packages/remix/lib/src/components/spinner/spinner_widget.dart` is the local lifecycle reference for a repeating controller, but Skeleton must additionally react to reduced-motion changes.
- A visual-only `ExcludeSemantics` is insufficient by itself: hidden descendants could still accept pointer or keyboard focus. Loading content needs `IgnorePointer`, `ExcludeFocus`, and `ExcludeSemantics` together.
- Flutter exposes the platform animation preference through [`MediaQuery.disableAnimationsOf`](https://api.flutter.dev/flutter/widgets/MediaQuery/disableAnimationsOf.html).

Official reference: [Radix Themes Skeleton](https://www.radix-ui.com/themes/docs/components/skeleton).

## Public API and spec

Create a new `skeleton` library and export it from `remix.dart`.

```dart
class RemixSkeleton extends StatelessWidget {
  const RemixSkeleton({
    super.key,
    this.child,
    this.loading = true,
    this.style = const RemixSkeletonStyler.create(),
    this.styleSpec,
  });

  final Widget? child;
  final bool loading;
  final RemixSkeletonStyler style;
  final RemixSkeletonSpec? styleSpec;

  static final styleFrom = RemixSkeletonStyler.new;
}

@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class RemixSkeletonSpec with _$RemixSkeletonSpec {
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  final Color? pulseColor;
  final Duration? duration;
}
```

Semantics of spec fields:

- `container` owns explicit width/height/constraints, base color, decoration, radius, and opacity.
- `pulseColor` is the alternate fill. When both base and pulse colors resolve, interpolate color; otherwise multiply the resolved caller opacity by the pulse factor as a generic Remix fallback. Never replace or normalize away caller opacity.
- `duration` is one forward pulse leg and defaults to 1000 ms. The reverse leg uses `repeat(reverse: true)`.
- A zero or negative duration is rejected in debug assertions and handled defensively as the default in release.

Do not add semantic label/value props: a skeleton is decorative, not a progress indicator. The docs should show a separate labeled status/live region when an application needs to announce loading.

## Rendering contract

When a child exists, keep one stable child element path across every `loading`
toggle. Use the same layout-transparent host and wrapper chain in both states;
when `loading == false` its exclusion/opacity/pointer/focus/ticker flags are all
inactive, so the child's original semantics and interaction pass through and no
pulse controller ticks. A childless, nonloading skeleton returns
`SizedBox.shrink()`.

When loading:

1. Resolve the style/spec once through `RemixStyleSpecBuilder`.
2. Mount a private stateful pulse body only as the loading overlay; adding or
   removing that sibling must not reparent the child subtree.
3. If a child exists, keep that single child instance as the non-positioned
   sizing child in a stable `Stack(fit: StackFit.passthrough)` wrapper chain.
   Toggle `TickerMode`, `IgnorePointer`, `ExcludeFocus`, `ExcludeSemantics`, and
   paint opacity on those existing wrappers. Never mount an invisible duplicate
   of the child. When loaded, the same wrappers become behaviorally transparent;
   when loading, the child remains mounted for intrinsic size and local state
   but is inert and hidden. Use opacity only for paint hiding, not as the
   accessibility control.
4. Fill that geometry with the animated styled box. If no child exists, the styled box's explicit constraints determine size.
5. Wrap the complete loading subtree in `ExcludeSemantics` as defense in depth.
6. In `didChangeDependencies`, stop the controller and set a deterministic base-frame value when animations are disabled; resume `repeat(reverse: true)` when enabled again.
7. In `didUpdateWidget`, update duration and resolved endpoints without replacing the controller. Dispose it exactly once.
8. When `loading` changes from false to true while focus is inside the child,
   the loading subtree must relinquish focus by the next frame. Prefer the
   natural `ExcludeFocus` transition; explicitly unfocus the subtree if the
   target SDK leaves a descendant as `primaryFocus`.

The base and pulse frames must not affect layout. Interpolate paint properties or an overlay box spec, never child dimensions.

Alternatives rejected:

- `AnimatedOpacity` with an endless callback loop — awkward lifecycle/reduced-motion control and easy test leaks.
- A shimmer shader — adds visual policy and GPU complexity not present in the reference.
- `Visibility`/`Offstage` for the child — does not preserve intrinsic geometry in the required way.
- Progress semantics — inaccurately announces a decorative placeholder with no measurable progress.

## Work breakdown

- [ ] Task 1: Add failing API, semantics, geometry, and interaction tests.
  - Files: new `packages/remix/test/components/skeleton/skeleton_widget_test.dart`, both public-API tests.
  - Acceptance: tests describe loading true/false, child/no-child, suppressed pointer/focus/semantics, and preserved size before production types exist.

- [ ] Task 2: Add spec/style contracts with failing generated-behavior tests.
  - Files: new `skeleton_spec_test.dart`, `skeleton_style_test.dart`.
  - Cover container forwarding, duration/pulseColor copy/lerp/equality, fluent and raw-spec paths.
  - Acceptance: fields are sufficient to express a rectangle, circle, text line, and child-sized placeholder without widget flags.

- [ ] Task 3: Implement and generate the component.
  - Files: `packages/remix/lib/src/components/skeleton/skeleton.dart`, `_spec.dart`, `_style.dart`, `_widget.dart`, generated `skeleton.g.dart`; `packages/remix/lib/remix.dart`.
  - Follow `spinner` only for controller ownership. Add a class-site comment explaining why a noninteractive component intentionally has no Naked primitive.
  - Acceptance: focused tests pass and `loading: false` creates no active ticker.

- Checkpoint: run all skeleton tests with `debugPrintRebuildDirtyWidgets` off/on if useful; verify no pending timers/tickers at test teardown.

- [ ] Task 4: Cover reduced motion and dynamic updates.
  - Files: `skeleton_widget_test.dart`.
  - Toggle `MediaQueryData(disableAnimations: true/false)` at runtime, change
    duration/style, switch to loading while a descendant is already focused,
    toggle loading around a keyed stateful child, remove the child, and unmount
    while pulsing.
  - Acceptance: disabled mode schedules no repeating frame; resuming animates; all controllers dispose cleanly.

- [ ] Task 5: Add docs and playground examples.
  - Files: `docs/components/skeleton.mdx`, root `docs.json`, `packages/playground/lib/registry/entries/skeleton_entry.dart`, registry.
  - Examples: avatar circle, two text lines, card block, a child-sized button placeholder, loading toggle, and reduced-motion explanation.
  - Acceptance: playground lays out the same before/after loading toggle with no jump for child-sized examples.

- [ ] Task 6: Capture screenshots and complete validation.
  - Light/dark screenshots show varied shapes and the loading-off state; animation can be captured at any deterministic-looking frame.
  - Include the reuse note: no Naked primitive, controller lifecycle borrowed from Spinner, semantics deliberately different from Spinner.

## Test strategy

### Widget tests

- Default `loading` is true.
- A child-sized skeleton has exactly the child's width and height under bounded and intrinsic parents.
- An explicitly styled childless skeleton resolves its requested size/radius.
- The loading subtree has no label, button, text-field, or tap semantic node from the child.
- Tapping the hidden child does not invoke it; Tab traversal does not focus it; its ticker is disabled.
- `loading: false` restores pointer, keyboard focus, and the child's exact semantics.
- A keyed stateful child's identity and local state survive
  loaded-to-loading-to-loaded transitions; it is never mounted twice.
- Changing from loaded to loading while the child is focused removes focus from
  the hidden subtree and does not leave it as `primaryFocus`.
- Pumping 500/1000 ms changes only paint color/opacity, not geometry.
- `disableAnimations: true` remains visually static and has no transient callback/ticker exception.
- Switching reduced motion and duration at runtime behaves deterministically.
- Unmounting at an arbitrary animation frame produces no ticker leak.

Never use `pumpAndSettle` in this test directory. Use `pump()`, `pump(const Duration(...))`, and explicit controller-frame expectations.

### Spec/style tests

- `container`, `pulseColor`, and `duration` participate in equality, copy, merge, and lerp.
- A raw `styleSpec` bypasses the styler consistently with other Remix widgets.
- A user opacity is composed with the pulse fallback rather than discarded.

### Manual

- Compare loading-on/off dimensions in Chrome at normal and 200% text scale.
- Turn on the platform/browser reduced-motion preference and verify no pulse.
- Keyboard-tab through the page and confirm placeholders do not create stops.

## Acceptance criteria

- [ ] Loading placeholders preserve child geometry and do not change size over the pulse.
- [ ] Loading toggles preserve the identity/local state of an existing child
  while mounting the pulse overlay only for the loading branch.
- [ ] Hidden descendants cannot receive pointer input, keyboard focus, semantics, or tick animations.
- [ ] Entering loading state actively releases any focus already held inside the hidden child.
- [ ] Reduced motion is honored initially and after `MediaQuery` changes.
- [ ] No loading or progress semantics are fabricated.
- [ ] Mix spec/style/widget and generated/public APIs are covered.
- [ ] Docs, nav, playground, light/dark screenshots, and full validation are included.
- [ ] No Fortal recipe or literal Radix token values land before PR 7.

## Risks and mitigations

- Risk: an invisible child remains focusable. Mitigation: test and use `ExcludeFocus` in addition to pointer/semantics wrappers.
- Risk: switching between a direct child and a nested loading subtree remounts
  stateful content. Mitigation: keep one stable child wrapper path across both
  branches and assert keyed local-state retention and single mount/dispose
  counts.
- Risk: resolving a color from arbitrary decoration is lossy. Mitigation: interpolate the supported resolved fill when present and document/test opacity fallback for other decorations.
- Risk: reduced motion is checked only once. Mitigation: own the transition in `didChangeDependencies` and test runtime changes.
- Risk: loop tests never settle. Mitigation: explicit frame pumps and teardown assertions.

## Validation and rollout

Run `fvm flutter test test/components/skeleton` from `packages/remix`, then the complete shared gate in `01-conventions.md`. This is additive and unflagged. Rollback is a single revert; there is no persisted state or parity manifest change in this PR.
