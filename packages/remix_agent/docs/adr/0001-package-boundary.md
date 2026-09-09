# ADR 0001 — Package boundary

A clean-sheet review of this package against the open-code workflow retained
the behavior boundary below and proposed registry-distributed,
application-owned recipes instead of an Agent theme. That integration is
planned, not implemented by this package decision. What the first consumer
established, and what is still gated, is recorded under
[Runtime and recipe split](#runtime-and-recipe-split).

## Decision

Ship agent-run surfaces as `remix_agent`, a private workspace package that
depends on `remix` plus Mix's generator/runtime. Do not add these widgets to
`remix` or `remix_fortal`, and do not create an `AgentScope`.

## Why

`remix` is unstyled primitive machinery (button, text area, card).
`remix_fortal` is a Radix-inspired look over those primitives. Conversation,
permission, and plan surfaces are a product domain: they introduce new
anatomies and status machines, not a new color scale.

A third package keeps the 1.0 Remix barrel generic and keeps Fortal free of
domain types. Generated Agent specs provide named visual slots but resolve to
empty values. Hosts own all color, typography, spacing, dimensions, radii,
status visuals, and motion recipes.

## What the design-system skill applies

- Workspace scaffold and Material-free library
- Do not re-export Remix or Mix
- Example listed as its own workspace member
- Host owns Overlay and Navigator

## What it does not apply

- A generated token map, theme enum, or package-owned visual defaults
- `@MixWidget` wrappers as the primary shape (those wrap matching Remix
  anatomies; these surfaces do not match)

The package does use `@MixableSpec` generation for ordinary `style` resolution,
`styleSpec` bypass, fluent `Agent*Styler`s, and named nested slots. A `MixScope`
is needed only when host styles use scoped tokens.

Agent specs are co-located with their widgets and contain only static,
Agent-owned anatomy. Each composed Remix control accepts its own unresolved
styler on the Agent constructor. Resolving a button, text field, card, or
disclosure spec in the parent would detach it from that control's Naked state
controller and discard variant, animation, and modifier metadata.

## v1 cut

Composer, message, transcript, answer, permission, execution, plan, activity.
No shell widget, no file tree, no highlighter, no citation engine.

## Runtime and recipe split

The package owns behavior. The application owns appearance, and receives it as
installed `remix_cli` source rather than as an Agent theme.

| Remix Agent owns | The application owns |
|---|---|
| Controller and focus-node ownership, IME handling | The composer, message, and permission recipes |
| Permission latches and status machines | Every colour, size, radius, and inset |
| Live-edge follow and release | The theme those values resolve from |
| Accessibility semantics and keyboard rules | Per-instance overrides at the call site |
| `Agent*Spec` slot names, empty by default | Which installed recipes a surface reuses |

One surface has a proven consumer, and it is the catalog app rather than a
purpose-built fixture. `example/` runs `remix init` and installs Theme, Card,
TextField, and IconButton exactly as any application does; the installed source
is committed, and `tool/check_open_code_dogfood.dart` holds it against the
templates. `example/test/composer_recipe_test.dart` then proves:

- `uiAgentComposerRecipe()` combines the toolbar style with four child
  stylers derived from installed recipes;
- Agent's send button has the same dimensions as a standalone installed
  IconButton with the same 48px touch override and uses the expected theme color;
- an instance override still beats the recipe;
- field focus and button hover still resolve in the child controllers;
- Enter, Shift+Enter, IME composition, and a controller swap still behave;
- the semantic tree holds one field and one action;
- the light and dark themes both reach Agent through the same recipe.

The example resolves `remix_agent` as a workspace sibling. That is development
evidence; nothing here claims hosted installation works.

The recipe is a **bundle**, not a single styler. `AgentComposer` takes
`style`, `surfaceStyle`, `fieldStyle`, `submitStyle`, and `stopStyle`, and
`AgentComposerSpec` holds only the toolbar, so one `@MixWidget` recipe cannot
supply the other four. `uiAgentComposerRecipe()` returns all five and the call
site spreads them. The four child stylers stay unresolved, for the reason the
section above gives.

Two things remain gated, and neither is claimed anywhere in this package:

1. **Publication.** The package is `publish_to: none`. A registry item's
   dependency is a hosted version constraint, not a way to publish a private
   workspace sibling, so there is no Agent registry item and hosted
   installation is not advertised. Resolving the publication metadata,
   dependency floors, provenance, and release checks is the next decision, and
   it is not a code change.
2. **The other seven surfaces.** Message, transcript, answer, permission,
   execution, plan, and activity have no proven recipe yet. Their worksheets
   record the benchmark measurements, not shipped defaults.

Local Chrome checks cover the catalog in light, dark, narrow, wide, and
reduced-motion states, including Composer submit/stop and permission and
disclosure interactions. Hosted-consumer verification remains open and depends
on publication; local browser and widget tests do not establish installability.
