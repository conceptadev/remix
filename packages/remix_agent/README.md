# Remix Agent

Unstyled Flutter widgets for long-running agent work: compose a prompt, follow
a transcript, pause for permission, and inspect execution and plans.

This branch is a draft stacked on the open-code workflow. See the
[clean-sheet review and registry integration plan](docs/open-code-review.md).
Agent is not yet an installable CLI registry item.

This private workspace package depends on [remix](https://pub.dev/packages/remix),
Mix's styling runtime, and Lucide's icon font. It ships no theme, token scope,
Fortal dependency, or model SDK. Every visual surface exposes a generated
`Agent*Spec` and `Agent*Styler`; every visual field is empty until the host
supplies a style.
Those specs describe Agent-owned, noninteractive anatomy. Remix child controls
receive independent unresolved stylers such as `submitStyle`, `detailsStyle`,
and `disclosureStyle`, so their hover, press, focus, selected variants,
animations, and modifiers resolve against the child control's own state.

Functional glyphs (send, stop, copy, retry, disclosure, tool, and statuses)
have neutral Material-free Lucide defaults. Their public builders remain the
replacement point; visual color and size still come from host styles.

A `MixScope` is not an Agent requirement. Add one only when the host's own
styles resolve scoped Mix tokens. The local catalog uses `MixScope.empty`
because its review-only light and dark recipes use Mix.

## Install

Add the path or hosted constraint your workspace uses, then:

```dart
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';
```

Ordinary surfaces need only a normal Flutter host. A model picker built with
`RemixSelect` still needs the caller’s `Overlay`.

## What this is

| Widget | Role |
| --- | --- |
| `AgentComposer` | Growable prompt field. Enter submits, Shift+Enter inserts a newline, IME composition is ignored. Send becomes Stop while a run is live. |
| `AgentMessage` / `AgentMessageCollapsible` | Unclamped message card plus an explicit, noninteractive-content collapse wrapper. |
| `AgentTranscript` | Static `children` or lazy `builder` viewport that styles both paths identically, follows growing output at the live edge, and releases when the reader scrolls away. |
| `AgentAnswer` | Streaming answer with callback-owned copy/retry controls, host feedback, and optional sources disclosure. |
| `AgentPermission` | In-transcript tool permission: allow once, always allow, or deny. |
| `AgentExecution` | Tool output with running / success / error / cancelled and collapse when done. |
| `AgentPlan` | Task plan with pending / in-progress / completed / cancelled and a completion count. |
| `AgentActivity` | Slim activity ledger. Hosts supply each item’s child. |

There is no chat shell, sidebar, or file tree. Compose these widgets in the
host.

## What this is not

- A visual preset. Remix Agent does not ship colors as a design system.
- A markdown renderer, syntax highlighter, or citation engine.
- An LLM client or tool runtime.

## Local catalog

A full review page lives in `example/`. It is unpublished and meant for
walking every surface:

```bash
cd packages/remix_agent/example
fvm flutter run -d chrome
```

## Host

```dart
WidgetsApp(
  color: const Color(0xFFFFFFFF),
  builder: (_, _) => const MyTranscript(),
);
```

Do not wrap the tree in a package-owned app or overlay host. Provide
`Overlay.wrap` only when a slot opens a picker. See
[`docs/provenance.md`](docs/provenance.md) for the behavioral benchmark record.
