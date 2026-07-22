# Remix Surface Refactor Explainer Design

## Purpose

Create a detailed, self-contained HTML explainer for Remix maintainers reviewing
commit `0fd5983` (`refactor(remix)!: simplify advanced surface effects`). The
explainer must make three things immediately understandable:

1. why the surface architecture needed to change;
2. which type owns each visual responsibility after the change; and
3. what the new architecture enables across real Remix components.

The deliverable is an explanatory review aid, not API documentation for general
library users. It should preserve enough implementation detail that a maintainer
can use it to review or extend the surface pipeline without first reading all 122
files changed by the commit.

## Deliverable

- A standalone, responsive HTML document at
  `docs/remix-surface-refactor-explainer.html`.
- All CSS, JavaScript, diagrams, and data are embedded in the file so it can be
  opened directly without a build step or network access.
- Technical illustrations use semantic HTML, CSS, and inline SVG derived from
  the repository architecture. Generated raster artwork is intentionally
  excluded because it would make the paint ordering and ownership boundaries
  less exact.
- The document links class names and component examples to their repository
  source paths and cites the relevant test files.

## Audience and Reading Goal

The primary reader is a Remix maintainer evaluating or revisiting the refactor.
After one pass, they should be able to answer:

- Why is there no longer a public `RemixSurface` widget?
- Which values belong in Mix `BoxSpec`/`FlexBoxSpec`, and which belong in
  `RemixSurfaceEffectsSpec`?
- What is the difference between a `Mix` type and its resolved `Spec` type?
- Why are advanced layers split into `background` and `foreground`?
- How do gradients, inset shadows, outer shadows, blur, outlines, borders,
  clipping, children, and foreground decoration stack?
- Why do simple components have one `effects` slot while compound components
  have role-specific slots?
- How do merging and interpolation work when an effect appears or disappears?
- Which private adapters and painters preserve normal Mix layout behavior?
- What must be tested when adding a new advanced surface effect or component
  slot?

## Core Message

The page revolves around one ownership rule:

> Mix owns normal box geometry and decoration. Remix owns only the advanced
> paint that Mix cannot express while preserving Fortal fidelity.

Normal Mix-owned properties include color, a standard gradient, ordinary box
shadow, border, border radius, clipping, padding, margin, constraints, alignment,
and transforms. Remix effects augment that decoration with ordered multiple
gradients, independent gradient insets, true inset shadows, ordered outer
shadows, backdrop blur, offset outlines, and foreground paint layers.

The visual language must consistently distinguish these two paths and show them
rejoining at the decoration boundary.

## Narrative Structure

### 1. Refactor in One Screen

Open with a concise before/after diagram:

- Before: `RemixSurfaceLayerSpec` owns normal decoration and advanced paint;
  public `RemixSurface`, `RemixSurfaceBox`, and `RemixSurfaceFlexBox` carry
  separate `surface` and `overlay` fields.
- After: normal decoration moves into the component's Mix box spec;
  `RemixSurfaceEffectsMix/Spec` groups only advanced background, foreground,
  blur, and outline paint; public helper functions choose the normal Mix fast
  path or a private effects adapter.

The opening should state the practical outcomes: clearer ownership, fewer
component fields, ordinary Mix behavior by default, accurate Fortal advanced
paint, and a smaller public widget surface.

### 2. Why the Old Shape Was Costly

Show the responsibilities that previously accumulated in
`RemixSurfaceLayerSpec`: color, gradients, shadows, radius, backdrop blur, and
outline. Explain the resulting ambiguity:

- standard decoration could be represented in both Mix and Remix;
- radius and geometry could drift between the box and its surface;
- components needed paired `surface` and `overlay` fields;
- a public wrapper exposed an implementation detail;
- maintainers had to decide between two styling paths for ordinary paint.

This section should frame the refactor as an ownership correction rather than a
new rendering subsystem.

### 3. Complete Type and Responsibility Map

Use an interactive architecture map. Selecting a node reveals its role, inputs,
resolved output, merge/interpolation behavior, and its immediate consumers.

The map must include every surface-related building block that is public,
introduced, removed, or materially changed by the refactor:

#### Primitive paint values

- `RemixPaintShadowKind`: distinguishes `outer` from true `inset` shadows.
- `RemixPaintShadow`: resolved CSS-shaped shadow value; include `offset`,
  `blurRadius`, `spreadRadius`, `shapeInset`, and the changed `scale()` behavior
  that fades alpha as well as geometry.
- `RemixPaintShadowMix`: token-aware unresolved representation.
- `RemixPaintShadowListToken`: theme token for ordered shadow lists.
- `RemixLinearGradientMix`: token-aware linear gradient whose colors and stops
  resolve independently.
- Gradient normalization: validates stop count and finiteness, makes stops
  monotonic, and guarantees sampled endpoints at 0 and 1.

#### Layer and aggregate values

- `RemixSurfaceLayerMix`: unresolved, mergeable background or foreground
  collection containing only gradients, gradient insets, and shadows.
- `RemixSurfaceLayerSpec`: resolved paint layer; include `isEmpty`, list
  interpolation, and `lerpNullable` behavior through an empty visual layer.
- `_RemixGradientListMix`, `_RemixDoubleListMix`, and
  `_RemixShadowListMix`: private adapters that resolve ordered lists and tokens.
- `RemixSurfaceEffectsMix`: unresolved aggregate containing `background`,
  `foreground`, `backdropBlur`, `outline`, and `outlineOffset`.
- `RemixSurfaceEffectsSpec`: resolved aggregate; include `isEmpty`, asymmetric
  merge rules for optional focus overlays, nullable interpolation, and outline
  interpolation through the effect's own transparent hue.

#### Composition and rendering

- `remixSurfaceBox` and `remixSurfaceFlexBox`: public composition functions.
- `_RemixEffectsBox` and `_RemixEffectsFlexBox`: fast-path selectors that use
  real Mix widgets when advanced effects and negative margins are absent.
- `_RemixDecoratedBox` and `_RemixDecoratedFlexBox`: private adapters that
  reproduce Mix layout while inserting advanced paint at the decoration
  boundary.
- `_RemixNegativeMargin` and `_RenderRemixNegativeMargin`: CSS-style negative
  margin support required by ghost controls, including layout, paint, hit-test,
  semantics, intrinsic sizing, and baseline behavior.
- `_RemixDecorationClipper`: clips inner decorated content to the Mix
  decoration without clipping outer shadows or outlines.
- `_RemixBoxBorderPainter`: separates the standard Mix border from the box fill
  so advanced background paint can occupy the correct layer.
- `_SurfacePaintPhase`: selects all, outer, inner, or outline painting.
- `_RemixSurfacePainter`: paints outer shadows, inset shadows, gradients, and
  outlines and reports expanded paint bounds.
- `_RemixSurfaceForegroundPainter`: paints foreground effects and the final
  outline without participating in hit testing.
- `_surfacePaintBounds`: expands bounds for overflowing shadows and outlines so
  parent blend operations include the full visual result.
- `RemixBlendMode` relationship: whole-subtree blending must consume the custom
  painters' expanded bounds while respecting descendant clips.

#### Removed or replaced public concepts

- `RemixSurface` widget: removed in favor of composition helpers and private
  adapters.
- `RemixSurfaceBox` and `RemixSurfaceFlexBox` widgets: replaced by
  `remixSurfaceBox` and `remixSurfaceFlexBox` functions.
- Per-component `surface`/`overlay` fields: replaced by one `effects` aggregate
  or role-specific effect aggregates.
- `color`, `borderRadius`, `backdropBlur`, and outline fields on
  `RemixSurfaceLayerSpec/Mix`: standard decoration moves to Mix; blur and
  outline move to the effects aggregate.

### 4. Paint-Order Laboratory

Provide the dominant interactive illustration: an exploded component stack
whose layers can be individually highlighted. The fixed paint order is:

1. advanced background outer shadows;
2. standard Mix box shadows;
3. clipped backdrop blur;
4. standard Mix fill, image, or single gradient;
5. advanced background gradients and inset shadows;
6. standard Mix border;
7. padded/aligned child content;
8. Mix foreground decoration;
9. advanced foreground gradients and shadows;
10. offset outline.

The actual implementation separates inner and outer background phases to keep
clipping correct. The visual must expose this fact instead of implying that the
background is painted in one pass.

Controls may toggle an example gradient, inset shadow, outer shadow, blur,
foreground focus layer, and outline. Every toggle changes both the rendered
sample and the highlighted pipeline nodes. The interaction is educational, not
a general-purpose style editor.

### 5. Unresolved-to-Rendered Data Flow

Animate or step through one representative Fortal recipe:

`Fortal recipe`
→ `ComponentStyler.effects(RemixSurfaceEffectsMix(...))`
→ Mix token and widget-state resolution
→ resolved component `Spec`
→ `remixSurfaceBox/FlexBox`
→ Mix fast path or private adapter
→ advanced painters around the child.

The stepper must explain why both `Mix` and `Spec` forms exist:

- `Mix` forms are token-aware, mergeable authoring values.
- `Spec` forms are concrete, resolved, interpolatable runtime values.

It must also show state recipes merging into the same aggregate—for example, a
slider thumb's base effects merged with `thumbFocusEffects` only for the
focused thumb.

### 6. Component Examples

Use eight examples so maintainers see every important composition pattern. Each
example includes a small anatomy illustration, the effect-slot names, a short
recipe excerpt, the resulting helper call, the paint capability being used, and
the reason that capability cannot or should not live in ordinary Mix
decoration.

1. **Button** — one `effects` slot on a `FlexBox`; demonstrate a standard Mix
   fill plus advanced classic gradients/shadows and a foreground focus layer.
2. **Card** — one `effects` slot on a `Box`; demonstrate interactive state
   overlays and the difference between normal and clickable cards.
3. **Switch** — `trackEffects` and `thumbEffects`; demonstrate independent
   surface ownership for nested parts.
4. **Slider** — `trackEffects`, `rangeEffects`, `thumbEffects`, and
   `thumbFocusEffects`; demonstrate role-specific slots and runtime merging of
   base plus focus paint.
5. **Progress** — `trackEffects` and `indicatorEffects`; demonstrate two-part
   rendering while animation changes geometry independently from paint.
6. **Select** — independent trigger and content `effects`; demonstrate one
   logical component with an in-tree control and an overlay surface.
7. **Dialog, Popover, and Menu** — overlay surfaces; demonstrate blur, ordered
   shadows, clipping, and why the same effects aggregate works across portal
   content.
8. **Checkbox and Radio** — compact stateful controls; demonstrate true inset
   shadows, foreground state paint, and smooth appearance/disappearance during
   interpolation.

An accompanying coverage matrix lists every affected component family and its
slot shape:

- one `effects`: Badge, Button, Callout, Card, Checkbox, Dialog, IconButton,
  Menu, Popover, Radio, TextField;
- two role-specific slots: Progress, Switch;
- two independently styled sub-spec slots: Select trigger and Select content;
- four role-specific slots: Slider.

### 7. Before/After Migration Guide

Show focused API transformations rather than a full commit diff:

- normal color/radius/border/shadow moving to the component container's Mix box
  styler;
- `surface` plus `overlay` collapsing into `effects.background` plus
  `effects.foreground`;
- outline color/width becoming `BorderSideMix` plus `outlineOffset`;
- public wrapper widgets becoming helper-function composition;
- compound component fields receiving role names that correspond to visible
  anatomy.

Each comparison states whether the change is mechanical, an ownership change,
or a behavior-preserving rendering adaptation.

### 8. Constraints, Failure Modes, and Tests

Document the architectural constraints surfaced by the implementation:

- advanced effects require a rectangular `BoxDecoration`;
- `ShapeDecoration` and `BoxShape.circle` are unsupported;
- an otherwise undecorated surface needs a radius-only `BoxDecoration`;
- outline stroke alignment must be inside;
- gradient inset count must be empty or match the gradient count;
- gradient insets must be finite and non-negative;
- shadow lists and shadow tokens are mutually exclusive;
- advanced painters never handle input or semantics;
- clips apply to blur and inner content, not outer shadows or outlines;
- empty effects should preserve the real Mix `Box`/`FlexBox` fast path;
- nullable effects must interpolate instead of snapping during state changes;
- blend bounds must include overflowing effects but stop at descendant clips.

Link these claims to:

- `packages/remix/test/rendering/remix_surface_test.dart`;
- `packages/remix/test/components/surface_layer_component_lerp_test.dart`;
- `packages/remix/test/rendering/remix_blend_mode_test.dart`; and
- representative component spec, widget, and Fortal parity tests.

Finish with a maintainer decision tree:

1. Can Mix `BoxDecoration` express the visual? Put it in the container spec.
2. Does it require ordered multiple gradients, true inset shadows, blur, an
   offset outline, or foreground paint? Use an effects aggregate.
3. Does the component have independently painted anatomy? Name a slot for each
   role.
4. Does a transient state augment rather than replace base effects? Merge the
   aggregates and verify interpolation.
5. Does paint overflow? Verify custom paint bounds and any subtree blend.

## Interaction Design

The page uses only interactions that reinforce the architecture:

- selecting a type in the relationship map;
- highlighting one paint layer in the exploded stack;
- stepping through authoring, resolution, composition, and painting;
- switching among component examples;
- expanding focused before/after code comparisons.

The page does not include search, arbitrary theme builders, draggable diagrams,
or decorative animation. Motion is short and respects
`prefers-reduced-motion`.

## Visual Direction

Use a technical cutaway aesthetic: neutral documentation surfaces, restrained
indigo/cyan accents, thin connector lines, and translucent stacked planes. The
result should feel like an annotated engineering diagram, not a marketing page.

Color is always paired with labels, layer position, and line style. Code uses a
compact monospaced treatment. The page supports light and dark color schemes,
scales from mobile to wide desktop, and never relies on hover for essential
information.

## Accessibility

- All controls use native buttons or inputs and remain keyboard accessible.
- The architecture map and paint stack have equivalent ordered text
  descriptions.
- SVG elements include titles and descriptions.
- Focus indicators remain visible.
- Contrast meets WCAG AA for normal text and diagram labels.
- Reduced-motion users receive immediate state changes.
- The document remains understandable with JavaScript disabled; interactions
  enhance already-present content instead of hiding it.

## Verification

Before handoff:

1. validate that the HTML opens locally without external requests or console
   errors;
2. inspect desktop and narrow responsive layouts;
3. exercise every control with mouse and keyboard;
4. compare every type, field, slot, and paint-order claim against commit
   `0fd5983` and the current source;
5. verify all local source links resolve;
6. check light, dark, and reduced-motion presentations;
7. confirm the page names all affected component effect slots and includes at
   least the eight detailed examples specified above.

## Out of Scope

- Changing Remix runtime code or APIs.
- Reproducing every line of the 122-file diff.
- General end-user tutorials for building applications with Remix.
- Publishing or hosting the explainer.
- Generated decorative artwork unrelated to the actual paint pipeline.
