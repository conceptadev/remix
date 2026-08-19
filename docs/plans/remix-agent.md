# Plan: `remix_agent` domain package

> Remix companion for agent-run surfaces. New anatomies and status machines.
> No theme, no model SDK, no third-party catalog names in shipped text.
>
> Scaffold is in place. Visual hierarchy is
> [remix-agent-hierarchy.md](remix-agent-hierarchy.md).

## Objective

Give Flutter apps the product contracts for long-running agent work — start a
run, watch it, interrupt it, approve a tool, inspect evidence — in Remix's
layer model: unstyled behavior + stylers, host-owned Overlay/Navigator.

- Primary outcome: unpublished workspace package `packages/remix_agent` that a
  `WidgetsApp` host can compose without Fortal, Material, or a model SDK.
- Out of scope: markdown parsing, syntax highlighting, a chat shell, Fortal
  recipes, putting `Agent*` on the `remix` 1.0-beta barrel.
- Constraint: Remix ships no theme. Fortal does not re-export Remix. This
  package depends on `remix` only.

## Approach

`remix_agent` is a product domain, not a visual preset. Public widgets use
the package vocabulary (`Agent*`). The barrel does not re-export Remix or Mix.

v1 surfaces:

| Widget | Role |
| --- | --- |
| `AgentComposer` | Growable prompt. Enter submits; Shift+Enter newline; IME ignored. Send becomes Stop while a run is live. |
| `AgentMessage` / `AgentMessageGroup` | Sender-aware row with avatar, header, footer, content. |
| `AgentTranscript` | Follows growth at the live edge; user scroll away releases; return re-attaches. |
| `AgentAnswer` | Host children. Copy/retry/sources only when complete or errored. |
| `AgentPermission` | In-transcript allow once / always allow / deny. Seven-state machine. |
| `AgentExecution` | running / success / error / cancelled. Collapses when settled. |
| `AgentPlan` | pending / in-progress / completed / cancelled plus a completion count. |
| `AgentActivity` | Slim `{id, title, status, child?}` ledger. |

No chat shell, sidebar, or file tree. Compose these in the host.

## Compat

- Additive workspace package. `remix` and `remix_fortal` public APIs unchanged.
- Fortal must not depend on `remix_agent`.
- Unpublished (`publish_to: none`) until the surface is real.

## Layout

```
packages/remix_agent/
  lib/remix_agent.dart
  lib/src/models/
  lib/src/behavior/
  lib/src/components/
  example/
  test/
```
