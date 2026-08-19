# Plan: `remix_agent` 1-by-1 polish

> Each shipped `Agent*` surface gets a published-quality layout, the options
> the product actually needs, and a recaptured catalog proof. Behavior stays.

## Goal (paste into `/goal`)

Polish `packages/remix_agent` one component at a time until every catalog
surface looks and behaves like a finished Remix primitive, not a first
scaffold. For each surface: audit against its worksheet and the running
catalog, add only the options the product needs, implement, test, then
recapture that section before moving on.

Read this file and follow `skills/using-remix`,
`skills/building-remix-design-system`, `.agents/skills/mix`, and
frontend-design. Do not mention third-party catalog names in any shipped
file. Do not change `remix` or `remix_fortal` public APIs. Do not add a
theme, token pipeline, `AgentScope`, model SDK, or chat shell.

Done when every surface below has been recaptured, package + example tests
are green under FVM, `lib/` stays Material-free, and
an isolation search for third-party catalog names over
`packages/remix_agent` and `docs/plans` is empty.

## Objective

- Primary outcome: unpublished `remix_agent` catalog that a reviewer can walk
  component-by-component and accept as complete (still unpublished).
- Who: Leo reviewing the local example catalog; future hosts copying these
  widgets.
- Out of scope: publishing, Fortal recipes, markdown/syntax highlighting,
  a chat app shell, sidebar, file tree, Overlay/Navigator wrappers, changing
  status machines, changing live-edge policy, changing Enter/IME submit.
- Constraint: chrome still derives from host `DefaultTextStyle` via
  `agentInkOf` / `agentMutedOf`. Workshop ledger in `example/lib/host.dart`
  stays example-only.

## Context

The package already exists and tests pass (38 across package + example).
The gap is interpretation, not scaffolding.

Verified gaps:

| Surface | File | What's wrong |
| --- | --- | --- |
| Composer | `lib/src/components/composer.dart` | Field and send/stop are two stacked pieces, not one instrument. `agentComposerFieldStyle()` takes no context and adds no chrome. Missing `autofocus`, `canSubmit`, `surfaceStyle`. |
| Message | `lib/src/components/message.dart` | No `align` / `showAvatar` / `expand`. `Flexible` + `Column` makes user and assistant cards both full width. |
| Transcript | `lib/src/components/transcript.dart` | No clip. Growing lines paint outside the viewport (catalog overlap). |
| Disclosure | `lib/src/components/disclosure.dart` | `AgentDisclosureSummary` uses Show/Hide `RemixBadge`s — implementation chrome. Collapse behavior in `resolveCollapseWhenComplete` is correct. |
| Permission | `lib/src/components/permission.dart` | `RemixDataList` + empty `agentDataListStyle()` concatenates label and value (`Commandflutter test`). Wrong primitive for long tool args. |
| Execution | `lib/src/components/execution.dart` | Inherits Show/Hide. Output is bare, not a well. Tests in `test/components/execution_test.dart` assert `Show`/`Hide`. |
| Plan / Activity | `lib/src/components/plan.dart`, `activity.dart` | Status marks are loud badges. |
| Answer | `lib/src/components/answer.dart` | No host override for `showActions`; slots exist but the option does not. |
| Composed run | `example/lib/demos.dart` (`ComposedRunDemo`) | `AgentTranscript` defaults `followOutput: true`, so the hero jumps to the permission card and hides the start of the turn. |

Existing contracts to keep:

- Enter submits, Shift+Enter newline, IME ignored — `composer.dart` + `test/components/composer_test.dart`.
- Seven-state permission machine — `lib/src/models/statuses.dart`.
- Collapse-when-complete — `lib/src/behavior/collapse_when_complete.dart`.
- Live-edge follow jumps, pointer/UserScroll only releases — `lib/src/behavior/live_edge.dart` + `test/components/transcript_test.dart`.
- Example is `WidgetsApp` + `MixScope.empty` + `Overlay.wrap` — `example/lib/main.dart`.
- Tests pump via `test/helpers/pump.dart`; text fields need `overlay: true`.
- Worksheets live in `specs/components/*.yaml`. They are the review artifact.

Utilities already available (do not reinvent):

- `agentInkOf` / `agentMutedOf` / `agentCardStyle` / `agentButtonStyle` /
  `agentQuietButtonStyle` / `agentDangerButtonStyle` / `agentBadgeStyle` /
  `agentAvatarStyle` in `lib/src/style/defaults.dart`.
- `RemixCard`, `RemixButton`, `RemixTextArea`, `RemixCallout`, `RemixAvatar`,
  `Box`, `TextStyler` from `package:remix/remix.dart` (re-exports Mix).
- Catalog server (if still up): `packages/remix_agent/example` on
  `http://127.0.0.1:7388`. Restart with
  `cd packages/remix_agent/example && fvm flutter run -d web-server --web-hostname 127.0.0.1 --web-port 7388`.
  System Dart 3.11 is too old; always use FVM.

## Approach

One shared foundation, then one vertical slice per component. Do not polish
everything horizontally (all APIs, then all visuals, then all tests).

**Shared first**, because disclosure, wells, and composer field style have
multiple consumers:

1. Replace Show/Hide badges with a caret + title + meta in
   `AgentDisclosureSummary`. Exclude the caret from semantics; the
   disclosure already announces `expanded`.
2. Add `agentWellStyle` (inset surface for parameters and tool output).
3. Change `agentComposerFieldStyle` to take `BuildContext` and paint a
   borderless field (card is the instrument). Remove unused
   `agentDataListStyle`.

**Then each component**, in catalog order, with this loop:

1. Re-read the worksheet and the widget.
2. Add only options with a real product job (rule: ≥1 catalog or test
   consumer, or an enforced invariant).
3. Implement with Mix/Remix stylers. No `package:flutter/material.dart`
   in `lib/`. Unicode marks, not Material icons.
4. Update that component's tests and worksheet.
5. Recapture the catalog section (screenshot + interact: send, deny,
   succeed, reopen).
6. Only then start the next component.

Recommended options (smallest set that matches a published catalog):

| Widget | Add | Do not add |
| --- | --- | --- |
| `AgentComposer` | `autofocus`, `canSubmit`, `surfaceStyle`; wrap in one `RemixCard` with field / hairline / toolbar | header slot, icon-only send |
| `AgentMessage` | `AgentMessageAlign? align`, `showAvatar`, `expand`, `maxWidth` | new role enum values |
| `AgentTranscript` | `clipBehavior`; wrap scroller in `ClipRect` | reverse lists, animate follow |
| `AgentPermission` | private parameter rows (label muted, value monospace, wrap); `showParameters` | keep `RemixDataList` |
| `AgentExecution` | output well + `showActions` | new statuses |
| `AgentPlan` / `AgentActivity` | muted status words, not badges | shared public `AgentStatusMark` (only two callers; keep private) |
| `AgentAnswer` | `bool? showActions` (null = `status.showsActions`) | built-in copy/retry widgets |

Composed-run catalog: set `followOutput: false` so the hero shows the start
of the turn.

- Alternatives considered:
  - Keep `RemixDataList` and just fill `DataListStyler` spacing — rejected.
    Even with spacing, a definition-list primitive is wrong for long
    commands. The smash is the empty styler; the deeper miss is the
    primitive.
  - Intrinsic-width user bubbles — rejected. Text max-intrinsic is the
    unwrapped line; expensive and brittle. Use `Align` + `ConstrainedBox`
    (~82% of the row) so user rows sit at the end without a full-bleed card.
  - Public `AgentParameterList` / `AgentStatusMark` — rejected. One or two
    callers. Private widgets until a third consumer appears.
  - Token pipeline / `AgentScope` — rejected. Remix ships no theme; this
    package inherits ink from the host.

## Compat & migration

- Breaking change? Soft, unpublished-only (`publish_to: none`,
  `0.1.0-beta.1`). Hard-cut is correct:
  - `agentComposerFieldStyle()` → `agentComposerFieldStyle(BuildContext)`.
  - Delete `agentDataListStyle()` if nothing remains.
  - Show/Hide strings go away; update `execution_test.dart` to tap the
    title (`Fetch` / `Tests`).
- Widget constructors used by tests and `example/` stay source-compatible
  except new optional named args.
- `remix` and `remix_fortal` public APIs: unchanged.
- Data migration: none.
- Rollback: revert the polish commits. No on-disk state.

## Work breakdown

- [ ] **0. Shared chrome**
  - Dependencies: none
  - Scope: `lib/src/style/defaults.dart`, `lib/src/components/disclosure.dart`
  - Acceptance: caret + title + meta; no `Show`/`Hide` text; `agentWellStyle`
    exists; composer field style takes context and is borderless; no
    `agentDataListStyle`.
  - Verification: `rg "Show|Hide" packages/remix_agent/lib` is empty.

- [ ] **1. Composer**
  - Dependencies: 0
  - Scope: `lib/src/components/composer.dart`, `specs/components/composer.yaml`,
    `test/components/composer_test.dart`, `example/lib/demos.dart`
  - Acceptance: one card; field, hairline, leading/trailing/send-stop in
    the same surface; empty send disabled; running shows Stop; Enter/IME
    unchanged.
  - Verification: existing composer tests plus one "builds a single
    `RemixCard`" case. Recapture Composer section.

- [ ] **2. Message**
  - Dependencies: none
  - Scope: `lib/src/components/message.dart`, `specs/components/message.yaml`,
    `test/components/message_test.dart`
  - Acceptance: user aligns end and is width-capped; assistant fills the
    content column; `placeholderAvatar` still lines up grouped turns;
    `showAvatar: false` drops the slot.
  - Verification: existing slot test plus a geometry assertion that the
    user body sits further end-ward than the assistant body in a 400-wide
    pump. Recapture Message section.

- [ ] **3. Transcript**
  - Dependencies: none
  - Scope: `lib/src/components/transcript.dart`,
    `specs/components/transcript.yaml`, `example/lib/demos.dart`
    (`TranscriptDemo` viewport border so clip is visible)
  - Acceptance: overflow is clipped; follow/release tests still pass.
  - Verification: `test/components/transcript_test.dart` green. Recapture
    Transcript: append lines, confirm no overlap, scroll away, append
    again, confirm history does not jump.

- [ ] **4. Permission**
  - Dependencies: 0
  - Scope: `lib/src/components/permission.dart`,
    `specs/components/permission.yaml`, `test/components/permission_test.dart`
  - Acceptance: `Command` and `flutter test` are separate, readable rows;
    no `RemixDataList`; actions only while pending; seven-state badge stays
    (that badge is product state, not implementation chrome).
  - Verification: existing decision tests plus
    `find.byType(RemixDataList) == findsNothing` and both label and value
    findable. Recapture: Deny, Replay, Allow once.

- [ ] **5. Execution**
  - Dependencies: 0, 3
  - Scope: `lib/src/components/execution.dart`,
    `specs/components/execution.yaml`, `test/components/execution_test.dart`
  - Acceptance: running stays open; settled collapses; tap title reopens;
    output sits in a well; copy/retry honor `showActions`.
  - Verification: rewrite Show/Hide assertions to tap `Fetch` / `Tests`.
    Recapture: Succeed, Fail, Cancel, reopen.

- [ ] **6. Plan and Activity**
  - Dependencies: 0
  - Scope: `plan.dart`, `activity.dart`, their worksheets and tests
  - Acceptance: muted status words (Todo/Doing/Done/Skip, Next/Now/Done);
    count meta still on the summary; collapse-when-complete unchanged.
  - Verification: existing harness tests. Recapture Advance/Complete.

- [ ] **7. Answer**
  - Dependencies: none
  - Scope: `lib/src/components/answer.dart`, `specs/components/answer.yaml`,
    `test/components/answer_test.dart`
  - Acceptance: `showActions: false` hides slots even when complete;
    default still follows `status.showsActions`.
  - Verification: existing hide-while-streaming / show-when-complete tests
    plus one override case. Recapture Complete / Error.

- [ ] **8. Composed run + isolation**
  - Dependencies: 1–7
  - Scope: `example/lib/demos.dart` (`ComposedRunDemo`)
  - Acceptance: `followOutput: false` on the hero transcript; submitting
    still appends; Allow/Deny still drive the machines.
  - Verification: example `catalog_test.dart` and `consumer_test.dart`.
    Recapture the hero. Isolation grep empty.

- Checkpoint after 0+1, after 4, and after 8: `fvm flutter test` in
  `packages/remix_agent` and `packages/remix_agent/example`.

- Safe to parallelize: none. Shared disclosure/style land first; catalog
  recapture is sequential so screenshots stay comparable.
- Must stay sequential: public style helpers, disclosure summary, then
  each catalog section.

## Test strategy

- Unit / widget (package):
  - `test/components/composer_test.dart` — keep Enter/IME/send-stop; add
    card + `canSubmit`.
  - `test/components/message_test.dart` — add align/expand geometry.
  - `test/components/permission_test.dart` — add readable params, no
    `RemixDataList`.
  - `test/components/execution_test.dart` — drop Show/Hide; tap title.
  - `test/components/answer_test.dart` — add `showActions: false`.
  - `test/components/transcript_test.dart`, `plan_test.dart`,
    `activity_test.dart` — behavior unchanged; must stay green.
  - `test/public_api_test.dart` — Material scan of `lib/` stays empty;
    constructors still construct.
- Example:
  - `example/test/catalog_test.dart` — every surface still mounts;
    permission Deny still updates the card.
  - `example/test/consumer_test.dart` — submit + deny still fire.
- Manual / catalog (required; appearance is the bug):
  1. Run the example on web-server (FVM, port 7388).
  2. For each rail item: screenshot, then exercise the demo controls
     (Send/Stop, Append, Deny/Replay, Succeed/Fail/Cancel, Advance,
     Complete/Error).
  3. Check Night as well as Day on composer + permission at least.
  4. Hunt regressions: composed run must still show the opening user
     turn; transcript must not overlap; params must not smash.
- Commands (from repo root, FVM required):

```bash
cd packages/remix_agent && fvm flutter test
cd packages/remix_agent/example && fvm flutter test
cd packages/remix_agent && fvm dart analyze .
rg -i 'third-party-catalog-names' packages/remix_agent docs/plans
rg 'package:flutter/material.dart' packages/remix_agent/lib
```

Success: all tests pass, analyzer clean, both greps empty, and each
catalog section has a post-change screenshot that matches the worksheet.

## Risks & open questions

- Risk: `agentComposerFieldStyle(BuildContext)` is a public signature
  change. Mitigation: package is unpublished; grep shows only
  `composer.dart` calls it.
- Risk: caret characters announce badly. Mitigation: `ExcludeSemantics`
  on the mark; disclosure already sets `expanded` + `semanticLabel`.
- Risk: catalog hot-restart misses Mix style changes. Mitigation:
  full restart of the web-server before the recapture pass.
- Risk: `ListView` lazy-build hid `AgentExecution` once. Mitigation:
  catalog already uses `SingleChildScrollView` + `Column` in
  `example/lib/showcase.dart`; do not revert that.
- Open question: none that block execution. Additive options vs. visual
  rewrite is decided above (both, smallest option set).

## Rollout

- Flag? None. Unpublished workspace package.
- Publish? No.
- Rollback: revert. No data, no generated tokens.
- Comms: update worksheets as each slice lands. Do not advertise
  completeness in the root README beyond the existing "unpublished
  review catalog" line.

## Execution rules

- Address the user as Leo.
- Use `fvm`; never system `dart`/`flutter` for this package.
- Re-derive. If a current wrapper is a single-use subtractive shape, delete
  it rather than style around it (`RemixDataList` here).
- Prove with tests or a screenshot, not argument.
- Do not write third-party catalog names into shipped files or this plan's
  future diffs.
