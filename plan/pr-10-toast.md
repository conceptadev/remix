# Plan: Add Remix Toast

> Add a host-neutral, queued toast system with a dedicated scope, native Flutter status/alert semantics, generated Fortal visuals, and migration of the dashboard prototype.

## PR contract

- Title: `feat(remix): add toast component`
- Execution dependency: rebase onto current `origin/main`, then land after PR 9 because both PRs update the Fortal family ledger. The Toast code is otherwise independent of DataTable.
- Compatibility: additive Remix/Fortal public API plus an internal dashboard migration; no consumer or data migration.
- Primary outcome: applications can present one or more nonmodal notifications through a caller-hosted Overlay without requiring MaterialApp, Scaffold, Navigator, or a Remix-owned application wrapper.
- Out of scope: operating-system notifications, banners, snackbars tied to Scaffold geometry, modal alerts, arbitrary custom overlay children, swipe-to-dismiss, notification history/inbox, cross-isolate delivery, persistence across a disposed scope, and a general-purpose `RemixScope`.

## Context

- There is no current `RemixScope`. `FortalScope` owns only theme/token resolution; menu, select, popover, and tooltip use a caller-owned `Overlay`; dialog helpers use a caller-owned `Navigator`. Preserve that host-capability split.
- `origin/main:packages/dashboard/lib/widgets/toast.dart` proves demand for a four-second message, optional action, 180 ms entrance, bottom-end placement, and live Fortal token changes. It creates one `OverlayEntry` per call at the same coordinates, so concurrent calls overlap and timers/actions can remove entries without a coordinated lifecycle.
- `origin/main:packages/dashboard/test/toast_test.dart` protects live theme changes, action dismissal, and the four-second default. Migrate those behaviors rather than moving the file unchanged.
- Remix had a 2024 `ToastLayer` implementation in commit `f71db7221`. It replaced the current item instead of queueing, rendered inside a Stack, had no status/alert semantics or focus policy, and belonged to the pre-rewrite application-wrapper architecture. Treat it as historical failure evidence, not an API to restore.
- `naked_ui` 1.0.0-beta.8 has no toast primitive. Queueing, timers, and presentation ownership are therefore a small Remix coordinator over Flutter primitives.
- Flutter 3.44 provides `SemanticsRole.status` and `SemanticsRole.alert`. Its debug validator rejects either role when `liveRegion: true` is also set. Flutter also recommends implicit semantic updates over `SemanticsService.sendAnnouncement` for ordinary UI state.
- Flutter's `OverlayPortal` keeps the overlay child under the portal's inherited-widget subtree and guarantees that it cannot outlive the portal. This avoids stale Mix/Fortal snapshots and manual `OverlayEntry` cleanup. Its semantics remain attached to the portal, so the Toast scope must live in a stable app-shell subtree rather than inside a lazily recycled/offstage list item.

Primary implementation references are the installed Flutter 3.44 sources for `SemanticsRole`, `SemanticsService`, `OverlayPortal`, Focus, MediaQuery, and AppLifecycleListener. Material `ScaffoldMessenger` is behavioral prior art for returned dismissal reasons, queue ownership, and accessibility-aware timeouts; Remix must not import or require it. There is deliberately no `radix-reference/` capture for Toast: it is not a Radix Themes component (see `radix-reference/README.md`), so visual evidence is the dashboard prototype and Fortal design only.

## Architecture and scope boundary

Add a focused `RemixToastScope`; do not add a broad `RemixScope`, `RemixApp`, or global overlay registry.

```text
FortalScope (optional visual tokens; above the host Overlay)
└─ caller host: WidgetsApp / MaterialApp / CupertinoApp / router
   └─ caller-owned Overlay
      └─ stable app shell
         └─ RemixToastScope
            ├─ inherited coordinator + optional controller attachment
            ├─ OverlayPortal (one toast region, shown only while needed)
            └─ application content
```

- `RemixToastScope` is stateful, owns the visible/pending entries and timers, and exposes its coordinator through a private inherited widget used by `showRemixToast`.
- Use one `OverlayPortal` and one positioned toast region for the whole stack. Do not create one `OverlayEntry` or portal per toast.
- Target the nearest caller-owned Overlay. The scope belongs below that Overlay in a stable app shell, for example inside `Overlay.wrap(child: ...)`, a persistent router shell, or a MaterialApp home/shell. Missing scope and missing Overlay failures must explain the required placement.
- The portal preserves Directionality, MediaQuery, localization, Mix, and Fortal inherited state. Do not snapshot Mix tokens or copy the dialog helper's Navigator-theme capture workaround.
- Existing menu/select/popover/tooltip code remains unchanged. Those controls need positioning/focus behavior but no shared notification queue, so they do not need `RemixToastScope`.
- `RemixToastScope` creates and disposes an internal controller when none is supplied. A supplied controller is caller-owned, is never disposed by the scope, and may attach to only one mounted scope at a time. Calling it while detached throws a descriptive state error.
- Scope disposal cancels every timer, hides the portal, detaches the controller, and completes visible and queued handles with `RemixToastDismissReason.scopeDisposed`.

Do not generate `FortalToastScope` or add `showFortalToast`. The generated visual `FortalToast` and the behavior coordinator compose the same way `FortalDialog` composes with `showRemixDialog`:

Public contract excerpt (method bodies are omitted):

```dart
RemixToastScope(
  style: fortalToastStyle(),
  child: const DashboardShell(),
)
```

## Public API

Use the canonical post-#100 generated names for a new family: `ToastSpec` and `ToastStyler`; the widget remains `RemixToast`.

```dart
enum RemixToastPriority { polite, assertive }

enum RemixToastPlacement {
  topStart,
  topCenter,
  topEnd,
  bottomStart,
  bottomCenter,
  bottomEnd,
}

enum RemixToastDismissReason {
  timeout,
  action,
  closeButton,
  programmatic,
  replaced,
  queueOverflow,
  scopeDisposed,
}

@immutable
final class RemixToastAction {
  const RemixToastAction({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;
}

@immutable
final class RemixToastData {
  const RemixToastData({
    this.id,
    required this.title,
    this.description,
    this.semanticLabel,
    this.icon,
    this.action,
    this.duration = const Duration(seconds: 4),
    this.priority = RemixToastPriority.polite,
    this.showCloseButton = true,
    this.style,
  });

  final Object? id;
  final String title;
  final String? description;
  final String? semanticLabel;
  final IconData? icon;
  final RemixToastAction? action;
  final Duration? duration;
  final RemixToastPriority priority;
  final bool showCloseButton;
  final ToastStyler? style;
}

abstract interface class RemixToastHandle {
  Object get id;
  Future<RemixToastDismissReason> get closed;
  void dismiss();
}

final class RemixToastController {
  RemixToastHandle show(RemixToastData toast);
  bool dismiss(Object id);
  void clear();
}

RemixToastHandle showRemixToast(
  BuildContext context,
  RemixToastData toast,
);

class RemixToastScope extends StatefulWidget {
  const RemixToastScope({
    super.key,
    this.controller,
    this.placement = RemixToastPlacement.bottomEnd,
    this.maxVisible = 3,
    this.maxQueued = 20,
    this.inset = const EdgeInsetsDirectional.all(24),
    this.gap = 12,
    this.dismissLabel = 'Dismiss notification',
    this.style = const ToastStyler.create(),
    required this.child,
  });

  final RemixToastController? controller;
  final RemixToastPlacement placement;
  final int maxVisible;
  final int maxQueued;
  final EdgeInsetsGeometry inset;
  final double gap;
  final String dismissLabel;
  final ToastStyler style;
  final Widget child;
}

class RemixToast extends StatelessWidget {
  const RemixToast({
    super.key,
    required this.title,
    this.description,
    this.semanticLabel,
    this.icon,
    this.action,
    this.dismissLabel,
    this.onDismiss,
    this.priority = RemixToastPriority.polite,
    this.style = const ToastStyler.create(),
    this.styleSpec,
  });

  final String title;
  final String? description;
  final String? semanticLabel;
  final IconData? icon;
  final RemixToastAction? action;
  final String? dismissLabel;
  final VoidCallback? onDismiss;
  final RemixToastPriority priority;
  final ToastStyler style;
  final ToastSpec? styleSpec;
}
```

### Data and validation contract

- Trim checks reject empty `title`, `description` when present, `semanticLabel` when present, action labels, and the scope `dismissLabel`. Preserve the caller's displayed string; validation must not silently rewrite localized text.
- `maxVisible` is at least one, `maxQueued` is nonnegative, `gap` is nonnegative, and every resolved inset side is nonnegative.
- `duration == null` means persistent. A non-null duration must be positive. A persistent toast must expose an action or close button so it is not an inaccessible permanent obstruction; programmatic dismissal remains available in addition.
- The icon is decorative and always excluded from semantics. Meaning conveyed only by an icon belongs in `title` or `semanticLabel`.
- `RemixToast` models its optional action as one typed `RemixToastAction`, the same concept `RemixToastData` uses, so a label/callback pair can never be supplied half-configured. `dismissLabel` must be nonempty whenever `onDismiss` is supplied. Scope-managed toasts obtain the default/overridden dismiss label from the scope's `dismissLabel`.
- Scope style is the base; a data item's non-null style merges after it and wins. Copy the immutable request at `show` time; do not retain mutable caller collections or a BuildContext.
- A null ID receives a private monotonically unique ID. Showing an equal non-null ID replaces the existing visible or queued request in place, completes the old handle with `replaced`, resets its lifetime, and produces one new handle. Unkeyed duplicate text is allowed; Remix must not guess product-level deduplication.
- `showRemixToast` is a convenience lookup for the closest scope and returns the same handle as `controller.show`. Presentation during a build phase fails descriptively; callers use an event callback or post-frame callback rather than causing coordinator mutation during build.

## Queue, lifetime, and dismissal contract

- Admit requests FIFO up to `maxVisible`. Additional requests wait FIFO up to `maxQueued`; if a nonzero pending queue is full, remove the oldest pending request and complete it with `queueOverflow` before adding the new request. When `maxQueued == 0`, complete the new excess request immediately with `queueOverflow`.
- The newest visible toast sits nearest the configured top/bottom edge. Keep stable IDs/keys while older items reflow; never use `UniqueKey` merely to restart animation.
- A queued toast has no visual or semantic node and no timer. It becomes announced and timed only when promoted into the visible stack.
- Each visible toast owns an independently cancellable timer. The four-second countdown starts only after it becomes visible. Dismissal runs the exit transition, completes its handle exactly once, then promotes the next queued item.
- Pause automatic dismissal while the pointer is over that toast, while focus is anywhere inside it, and while app lifecycle is inactive/hidden/paused/detached. Cancel the timer on pause and restart the full configured duration on resume; the generous restart policy is deterministic and avoids a toast disappearing immediately after interaction.
- When `MediaQuery.accessibleNavigationOf(context)` is true, an interactive toast (action or close button) does not auto-dismiss. A noninteractive advisory toast may still use its configured duration.
- `MediaQuery.disableAnimationsOf(context)` skips entrance, reflow, and exit animation without changing timer or handle semantics. Normal motion uses stable keyed fade/short directional translation; do not animate semantics labels or focus nodes.
- Action activation invokes the callback and dismisses with `action` in a `finally` block so a thrown callback does not strand the toast. Close, timeout, handle/controller dismissal, replacement, overflow, and scope disposal each report their own reason and never invoke the action.
- `clear()` dismisses visible and queued requests programmatically and completes every handle once. Repeated dismiss/clear calls are idempotent.

## Focus, keyboard, layout, and host contract

### Focus and keyboard

- Inserting or announcing a toast never requests primary focus. The operation that triggered it keeps focus.
- Action and close controls participate in ordinary traversal and expose normal button behavior. Pause the timer while either is focused.
- Capture the primary FocusNode when the toast becomes visible. If dismissal occurs while focus is inside that toast, restore the captured node only when it is still attached and can request focus; otherwise let the nearest FocusScope choose its normal fallback. Never move focus for a toast that was not focused.
- Escape dismisses the focused toast when it is dismissible. Do not install a global Escape handler that closes an unfocused notification or masks a dialog/menu shortcut.

### Layout and overlay

- Placement uses start/end, never hard-coded left/right. Cover all six placements in LTR and RTL; default bottom-end matches the dashboard.
- The overlay region uses SafeArea plus the directional `inset`, accounts for `MediaQuery.viewInsets` at the bottom so the keyboard does not cover notifications, and constrains every toast to the available width. The visual recipe may cap width (dashboard baseline: 360 logical pixels) but must shrink on narrow screens and at high text scale.
- Only toast surfaces receive pointer hits. The rest of the overlay remains transparent to pointer events and contributes no modal barrier or route semantics.
- The region must work under `WidgetsApp + Overlay.wrap + RemixToastScope` with no MaterialApp, Scaffold, or Navigator. Add the same host test under FortalScope to prove live token inheritance through the portal.
- Missing scope and missing Overlay errors name `RemixToastScope`, show a minimal valid host tree, and do not claim Scaffold is required.

## Semantics contract

Use implicit semantic-tree updates; do not call deprecated `SemanticsService.announce` or its view-scoped replacement for normal Toast presentation.

- Informational/success/advisory messages map to `SemanticsRole.status`; urgent, destructive, or time-sensitive messages use `RemixToastPriority.assertive` and map to `SemanticsRole.alert`.
- Do not also set `liveRegion: true`. Flutter 3.44 explicitly rejects live-region flags on status/alert role nodes.
- Build one message node whose label is `semanticLabel ?? [title, if (description case final value?) value].join('\n')`. Exclude the corresponding visual title/description and decorative icon beneath that node so content is announced once.
- Keep action and close as separate button nodes outside the message node. Their visible/localized labels are announced once and remain independently reachable.
- A containing semantic node may use `container: true` and `explicitChildNodes: true`, but it must not merge the status text with interactive descendants or pretend to be a dialog/route.
- A theme, brightness, placement, animation-frame, hover, or focus-style rebuild must not create a new message identity or reannounce unchanged text. A newly visible request or same-ID replacement with meaningful new text is one new semantic update.
- Exact widget tests use `tester.ensureSemantics()`, assert `getSemanticsData().role` directly (Flutter 3.44's matcher has no role parameter), and match label, absent `liveRegion`, separate button actions, decorative icon exclusion, and removal/promotion. Manual checks cover actual announcement cadence because widget tests cannot prove platform speech queues.

## Spec, styling, and Fortal generation

Create `packages/remix/lib/src/components/toast/` with the normal spec/style/widget/generated/Fortal anatomy plus focused controller/scope source parts. Keep queue/timer/focus fields out of the visual spec.

```dart
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin, IconStyleMixin])
class ToastSpec with _$ToastSpec {
  final StyleSpec<FlexBoxSpec> container;
  final StyleSpec<FlexBoxSpec> content;
  final StyleSpec<TextSpec> title;
  final StyleSpec<TextSpec> description;
  final StyleSpec<IconSpec> icon;
  final StyleSpec<ButtonSpec> action;
  final StyleSpec<IconButtonSpec> closeButton;
  final RemixBoxEffectsSpec? containerEffects;
}
```

- Recheck the exact canonical nested spec names after rebasing #100; use current `ButtonSpec`/`IconButtonSpec` names rather than adding legacy `Remix*Spec` aliases to a new family.
- Render action and close by composing existing Remix Button/IconButton behavior with resolved nested style specs. Do not recreate press, focus, keyboard, or enabled semantics with GestureDetector.
- The visual `RemixToast` is stateless. Scope/controller state supplies callbacks and lifecycle; direct composition remains useful for custom presenters and generated `FortalToast` API tests.
- The unopinionated style has bounded, overflow-safe structure but no Material surface. Fortal owns color, type, spacing, radius, effects, icon/action treatment, and width cap.

Add the Fortal extension recipe:

```dart
enum FortalToastSize { size1, size2, size3 }
enum FortalToastVariant { surface, classic }
enum FortalToastIntent { accent, neutral, error }

@MixWidget(target: RemixToast.new)
ToastStyler fortalToastStyle({
  FortalToastSize size = .size2,
  FortalToastVariant variant = .classic,
  FortalToastIntent intent = .accent,
});
```

- Generate `FortalToast` with `.surface` and `.classic` named constructors. Compile-test the full action/dismiss/priority/style API; never hand-edit generated output.
- Reuse Fortal panel, stroke, shadow, button, typography, spacing, radius, accent/gray, and existing error tokens. Do not nest `FortalCard` as the implementation or copy its token literals; Toast needs independently styled content/action/close regions and stable keyed motion.
- `intent` is visual only. It never silently changes `RemixToastPriority`; callers explicitly choose assertive semantics when the content truly needs immediate attention.
- Toast is not a Radix Themes 3.3 component. Record it as a Fortal extension with empty upstream source/selectors and explicit dashboard/Fortaleza design evidence. Do not fabricate a Radix Chromium probe or claim mapped parity.
- PR 10 advances the ledger after PR 9 from 30 mapped + 3 extensions to 30 mapped + 4 extensions (34 total). Update manifest, coverage evidence, expected extension set, total count, checker success text, and reference README atomically.

## Work breakdown

- [ ] Task 1: Rebase and lock public API/ownership with failing tests.
  - Files: new `test/components/toast/toast_controller_test.dart`, both public-API tests, current host-capability tests.
  - Cover canonical `ToastStyler`/`ToastSpec` names, immutable requests, validation, internal/external controller ownership, single-scope attachment, handle completion exactly once, detached calls, missing scope/Overlay diagnostics, and no Material/Scaffold/Navigator requirement.

- [ ] Task 2: Implement queue and lifetime behavior test-first.
  - Files: `toast_controller.dart`, `toast_scope.dart`, controller/scope tests.
  - Cover FIFO visible/pending order, max counts, same-ID replacement, overflow, independent timers, pause/resume, accessibility navigation, app lifecycle, every dismissal reason, idempotence, and scope disposal.

- [ ] Task 3: Implement the single portal region, motion, focus, and layout.
  - Files: scope/region implementation and `toast_scope_test.dart`.
  - Cover one portal for multiple toasts, live inherited theme updates, stable keys, action exception cleanup, focus preservation/restoration, focused Escape only, pointer pass-through, safe area/view insets, six directional placements, RTL, high text scale, and reduced motion.

- Checkpoint: run controller/scope/host tests. Do not start visual generation until queue completion, native host operation, and focus/timer cleanup pass without pending timers or framework exceptions.

- [ ] Task 4: Add the visual Remix component, semantics, and generated FortalToast.
  - Files: `toast.dart`, `_spec.dart`, `_style.dart`, `_widget.dart`, generated `.g.dart`, `fortal_toast_styles.dart`, `remix.dart`, spec/style/widget/parity tests.
  - Cover every spec region/lerp, nested control reuse, status/alert roles without liveRegion, one message label, separate actions, icon exclusion, sizes/variants/intents, light/dark/scaling, and current canonical generator naming.

- [ ] Task 5: Migrate the dashboard prototype.
  - Files after rebase: Dashboard app/shell setup, all `showToast` call sites, dashboard toast tests, and `packages/dashboard/lib/widgets/toast.dart`.
  - Install one stable `RemixToastScope(style: fortalToastStyle())`, replace local helper calls with `showRemixToast`, preserve four-second/action/live-theme behavior, add a multi-toast stack regression, then delete the private widget when no import remains.

- [ ] Task 6: Advance the Fortal extension ledger.
  - Files: manifest, coverage evidence, checker, reference README, shared Fortal widget/control tests.
  - Add `toast` to the extension set and 34-family total with no Radix selectors, source files, or Chromium probe. State clearly that the pinned Radix Themes package does not supply this family.

- [ ] Task 7: Add docs, playground, host guidance, and manual evidence.
  - Files: `docs/components/toast.mdx`, `docs.json`, README/package README host tables and inventories, new playground registry entry.
  - Show scope placement, controller and context APIs, action/close, persistent and keyed replacement, polite/assertive use, accessible-navigation timeout policy, reduced motion, RTL placements, and Fortal customization. Capture light/dark stacked states; do not label them Radix comparisons.

## Test strategy

### API, queue, and lifecycle

- Validate every coupled field and boundary; copy requests and complete handles exactly once.
- Pump exact durations for promotion, pause/restart, exit, accessible navigation, and app lifecycle. End every test with no live Timer, Ticker, portal, or unattached controller.
- Verify same-ID replacement and queue overflow deterministically without deduplicating ordinary equal text.

### Accessibility, focus, and hosts

- Use exact `status`/`alert` role tests and prove `liveRegion` is absent. Verify visual text/icon exclusion and separate action/close button nodes.
- Verify no focus movement on show, timer pause inside, focused Escape, and conditional restoration on each interactive dismissal path.
- Pump under WidgetsApp/Overlay, Fortal, and dashboard hosts; verify live theme, Directionality, MediaQuery, safe area, keyboard insets, high text scale, and pointer pass-through.
- Manually test TalkBack, VoiceOver on iOS/macOS, keyboard-only desktop, and Flutter web's generated accessibility tree. Confirm one announcement on presentation/replacement, no announcement on theme/motion rebuild, polite versus assertive behavior, reachability, and no premature timeout for interactive toasts under accessible navigation.

### Styling and generation

- Resolve every size, surface/classic variant, and accent/neutral/error intent at scale 1 and one nondefault scale in light/dark themes.
- Assert action/close nested control styles and hit targets without duplicating their behavior tests.
- Run generated consumer/API tests for `FortalToast`, but keep scope/helper hand-written and behavior-named.

## Acceptance criteria

- [ ] `RemixToast`, `RemixToastScope`, `RemixToastController`, `RemixToastData`, `RemixToastAction`, `RemixToastHandle`, `showRemixToast`, and generated `FortalToast` are exported and documented.
- [ ] No general `RemixScope`, Remix-owned app wrapper, Material ScaffoldMessenger, third-party toast dependency, or Naked primitive is introduced.
- [ ] One OverlayPortal owns a bounded FIFO visible stack and queue with stable IDs, explicit overflow/replacement, complete dismissal reasons, and leak-free disposal.
- [ ] Timers respect hover, focus, app lifecycle, accessible navigation, persistent requests, and reduced motion.
- [ ] Focus is never stolen, focused dismissal restores safely, and Escape affects only a focused dismissible toast.
- [ ] Native status/alert semantics are emitted once without `liveRegion` or explicit announcement calls; actions remain independently accessible.
- [ ] Placement is safe-area, keyboard-inset, narrow-width, high-text-scale, LTR, and RTL safe and leaves the rest of the overlay interactive.
- [ ] Dashboard consumers use the package API; the private helper is deleted and its existing plus stacked-toast regressions pass.
- [ ] Toast is honestly tracked as Fortal extension number 4: 30 mapped + 4 extensions, with no fake Radix fixture.
- [ ] Docs, playground, host guidance, generated code, visual evidence, focused/full tests, and every shared validation command are complete.

## Risks and mitigations

- Risk: a generic scope becomes a service locator for unrelated components. Mitigation: expose only `RemixToastScope`; leave existing Overlay/Navigator host contracts unchanged.
- Risk: portal semantics disappear when a scope is mounted in a recycled/offstage child. Mitigation: document and test stable app-shell placement and fail host examples that put the scope inside list items.
- Risk: persistent/accessible interactive toasts fill the visible slots. Mitigation: always provide close by default, bound the pending queue, expose `clear`, and report overflow explicitly.
- Risk: status and alert messages announce twice or on every theme rebuild. Mitigation: one stable keyed role node, excluded duplicate visual content, no liveRegion flag, and no SemanticsService call.
- Risk: async/application callback failures strand lifecycle state. Mitigation: dismiss action paths in `finally`, complete handles once, and route uncaught errors through normal Flutter error handling.
- Risk: Fortal styling is mistaken for Radix Themes parity. Mitigation: extension-only manifest entry, no selectors/probe, and screenshots labeled as Fortal/dashboard design evidence.

## Validation and rollout

Run focused controller/scope/semantics/dashboard tests after each task, regenerate Mix output, then run every shared command in `01-conventions.md`, including docs, parity, consumer resolution, and full Flutter tests. Manually inspect the playground at narrow/mobile and desktop widths in both directions and brightnesses.

No feature flag or data migration is required. Roll back PR 10 as one unit: Toast source/generated API, dashboard migration, docs/playground/inventories, and the extension manifest/evidence/checker counts must never describe different family sets.
