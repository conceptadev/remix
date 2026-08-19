# Remix Agent

Unstyled Flutter widgets for long-running agent work: compose a prompt, follow
a transcript, pause for permission, and inspect execution and plans.

This package depends on [remix](https://pub.dev/packages/remix) only. It ships
no theme, no token scope, and no model SDK. Style slots with Remix `*Styler`s,
or pass Fortal recipes from a host that already uses `remix_fortal`.

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
| `AgentMessage` / `AgentMessageGroup` | Sender-aware row with avatar, header, footer, and content slots. |
| `AgentTranscript` | Viewport that follows growing output at the live edge and releases when the reader scrolls away. |
| `AgentAnswer` | Streaming answer. Copy, retry, and feedback slots appear only when complete or errored. |
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
`Overlay.wrap` only when a slot opens a picker.
