# ADR 0001 — Package boundary

## Decision

Ship agent-run surfaces as `remix_agent`, a workspace package that depends on
`remix` only. Do not add these widgets to `remix` or `remix_fortal`. Do not
create a token pipeline or `AgentScope`.

## Why

`remix` is unstyled primitive machinery (button, text area, card).
`remix_fortal` is a Radix-inspired look over those primitives. Conversation,
permission, and plan surfaces are a product domain: they introduce new
anatomies and status machines, not a new color scale.

A third package keeps the 1.0 Remix barrel generic and keeps Fortal free of
domain types. Hosts that already use Fortal can pass Fortal recipes into
slots. Hosts that do not use Fortal never take a Fortal dependency.

## What the design-system skill applies

- Workspace scaffold, Material-free library, worksheet-first components
- Do not re-export Remix or Mix
- Example listed as its own workspace member
- Host owns Overlay and Navigator

## What it does not apply

- extract → normalize → generate → verify
- A generated token map or theme enum
- `@MixWidget` wrappers as the primary shape (those wrap matching Remix
  anatomies; these surfaces do not match)

## v1 cut

Composer, message, transcript, answer, permission, execution, plan, activity.
No shell widget, no file tree, no highlighter, no citation engine.
