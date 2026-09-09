# Remix Agent

Unstyled Flutter widgets for long-running agent work: compose a prompt, follow
a transcript, pause for permission, and inspect execution and plans.

This branch is a draft stacked on the open-code workflow. See
[ADR 0001](docs/adr/0001-package-boundary.md) for the package boundary and the
runtime/recipe split. Agent is not yet an installable CLI registry item.

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

Ordinary surfaces need only a normal Flutter host. `AgentComposer` is the one
exception, and the requirement is the text field's rather than Agent's:
`EditableText` asserts on an `Overlay` ancestor the moment it takes focus, for
its selection handles and magnifier. `MaterialApp`, `CupertinoApp`, and any
`WidgetsApp` with routes already provide one; a bare `WidgetsApp(builder: ...)`
does not. A model picker built with `RemixSelect` needs the same `Overlay`.

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

## Styling with installed recipes

An application styles these surfaces with the same `remix_cli` source it
installs for the rest of its UI. There is no Agent theme and no Agent preset.

A surface takes more than one styler, so a recipe returns a **bundle** and the
call site spreads it. `AgentComposer` takes five: its own anatomy, plus
unresolved stylers for the card, the field, and the two buttons.

```dart
final recipe = uiAgentComposerRecipe();

AgentComposer(
  onSubmit: submit,
  style: recipe.style,
  surfaceStyle: recipe.surfaceStyle,
  fieldStyle: recipe.fieldStyle,
  submitStyle: recipe.submitStyle,
  stopStyle: recipe.stopStyle,
)
```

The bundle calls the application's installed `uiCardStyle`, `uiTextAreaStyle`,
and `uiIconButtonStyle` and adds only Agent-specific geometry, so editing one
of those files changes the composer with it. A working recipe lives in
[`open_code/agent_fixture/lib/agent/composer.dart`](../../open_code/agent_fixture/lib/agent/composer.dart),
and `dart run tool/check_agent_consumer.dart` builds a fresh application around
it. The other seven surfaces have no proven recipe yet.

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
`Overlay.wrap` yourself around any subtree holding a composer or a picker:

```dart
WidgetsApp(
  color: const Color(0xFFFFFFFF),
  builder: (_, _) => Overlay.wrap(child: const MyComposerPage()),
);
```

See [`docs/provenance.md`](docs/provenance.md) for the behavioral benchmark
record.
