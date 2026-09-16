# ADR 0001 — Package boundary

A clean-sheet review of this package against the open-code workflow retained
the behavior boundary below and proposed registry-distributed,
application-owned recipes instead of an Agent theme. The eight surfaces are now derived into both existing registries. The private
package remains the single authoring/test source. Distribution and remaining
release checks are recorded under
[Runtime and recipe split](#runtime-and-recipe-split).

## Decision

Author and test agent-run surfaces in `remix_agent`, source under `registry_source/lib/src/agent` that
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

The example installs all eight surfaces plus Theme, Card, TextField,
IconButton, and Button from the default registry. Its Composer recipe is the
worked styling integration; the installed source
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

The example imports installed `Ui*` source and no longer depends on
`remix_agent`. Fresh consumer checks exercise both complete catalogs and each
Agent component and recipe independently. These checkout checks are distinct
from hosted-release verification.

The recipe is a **bundle**, not a single styler. `AgentComposer` takes
`style`, `surfaceStyle`, `fieldStyle`, `submitStyle`, and `stopStyle`, and
`AgentComposerSpec` holds only the toolbar, so one `@MixWidget` recipe cannot
supply the other four. `uiAgentComposerRecipe()` returns all five and the call
site spreads them. The four child stylers stay unresolved, for the reason the
section above gives.

## Source distribution and remaining boundaries

Each registry contains eight component items, eight opt-in recipe items, plus shared `models` and
`support`. Source comes from this package; generated adapters come from the
consumer's resolved Mix generator. No installed item depends on this private
package. Public model files are exported; internal support helpers stay out of
the managed barrel. The existing theme item owns the single Remix dependency
floor, inherited through support.

`tool/build_registry.dart` derives this package into `templates/agent/**` of
both presets as an extension of each preset's own source; the preset writer
merges it and owns the whole tree, so regeneration cannot prune it and a
whole-tree drift check covers it.

Mix's spec-styler builder is opt-in at the current supported version. The CLI
therefore enables it for installed spec sources in application `build.yaml`,
preserving unrelated settings and refusing explicit exclusions or disabled
builders. This is a discovered prerequisite to distribution, not a new theme,
registry schema, or copied generated implementation.

All eight surfaces expose preset-specific recipe bundles, authored as Dart in
`registry_source/lib/src/{default,fortal}/recipes/` against these components,
and derived into each preset. The dashboard and playground use those installed
bundles; their chat orchestration remains application-owned rather than a
runtime API.
Hosted release validation remains a separate release gate. Private-package
publication is neither required nor planned for these source-distributed items.
