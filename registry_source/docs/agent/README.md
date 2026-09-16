# Remix Agent

Unstyled Flutter widgets for long-running agent work: compose a prompt, follow
a transcript, pause for permission, and inspect execution and plans.

The eight surfaces are application-owned source in the default CLI registry.
See [ADR 0001](docs/adr/0001-package-boundary.md) for the private authoring
package boundary and the runtime/recipe split. They are available from both
existing presets; there is no separate Agent preset.

This private workspace package depends on [remix](https://pub.dev/packages/remix),
Mix's styling runtime, and remix_ui_icons. It ships no theme, token scope,
Fortal dependency, or model SDK. Every visual surface exposes a generated
`Agent*Spec` and `Agent*Styler`; every visual field is empty until the host
supplies a style.
Those specs describe Agent-owned, noninteractive anatomy. Remix child controls
receive independent unresolved stylers such as `submitStyle`, `detailsStyle`,
and `disclosureStyle`, so their hover, press, focus, selected variants,
animations, and modifiers resolve against the child control's own state.

Functional glyphs (send, stop, copy, retry, disclosure, tool, and statuses)
have neutral Material-free `remix_ui_icons` defaults. Their public builders remain the
replacement point; visual color and size still come from host styles.

A `MixScope` is not an Agent requirement. Add one only when the host's own
styles resolve scoped Mix tokens. The catalog's Composer uses the installed
`UiThemeScope` for its light and dark tokens; the other demos use local styles.

## Install

The package remains unpublished authoring/test source. Install individual
surfaces through the project-local checkout CLI (see [open-code setup](../../open_code/README.md)):

```shell
dart run remix_cli:remix init --prefix Ui --preset default
dart run remix_cli:remix add composer
```

The CLI installs shared `models` and `support` when needed, enables Mix's
spec-styler builder for the installed source in `build.yaml`, and generates
adapters in the application. Existing builder settings are preserved; explicit
exclusions or disabled generation must be resolved by the host. Public models
are exported from the UI barrel, internal support helpers are not.

Consumers import their local barrel, not the private package. Authoring names
in the table below use `Agent`; installed names follow the chosen prefix:
`AgentComposer` becomes `UiComposer`.

```dart
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'ui/ui.dart';
```

For work on the private authoring package itself, its barrel remains:

```dart
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'package:registry_source/agent.dart';
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

There is no runtime chat shell, sidebar, or file tree. The dashboard and
playground compose them into an interactive simulated chat; applications retain
ownership of that orchestration.

## What this is not

- A visual preset. Remix Agent does not ship colors as a design system.
- A markdown renderer, syntax highlighter, or citation engine.
- An LLM client or tool runtime.

## Styling with installed recipes

An application styles these surfaces with the same `remix_cli` source it
installs for the rest of its UI. There is no Agent theme and no Agent preset.

A surface can take more than one styler, so each opt-in recipe returns a
**bundle** and the call site spreads it. `AgentComposer` takes five: its own anatomy, plus
unresolved stylers for the card, the field, and the two buttons.

```dart
final recipe = uiAgentComposerRecipe();

UiComposer(
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
of those files changes the composer with it. Install a bundle with
`remix add composer_recipe`; all eight follow the same `<component>_recipe`
convention. Default recipes use default tokens and Fortal recipes use Fortal
tokens and controls without crossing presets.

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
