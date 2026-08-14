# ADR 0001 — Carbon token pipeline and package architecture

- Status: accepted
- Date: 2026-07-10
- Context: `packages/remix_carbon` (Carbon for Flutter), Phase 0 / Phase 1

## Context

`remix_carbon` implements the IBM Carbon Design System on top of the Remix 1.0 /
Naked UI / Mix foundations, without reusing Fortal's Radix-derived design
decisions. Carbon has a large token surface (234 color roles across four themes,
78 component tokens, fixed and fluid spacing and type, motion) that must be
faithful to official sources and reproducibly upgradeable.

## Decisions

### 1. Generate tokens from pinned official sources; commit the output

We do **not** hand-author the token surface. A four-stage pipeline
(extract → normalize → generate → verify) imports the official `@carbon/*` npm
packages at pinned versions, normalizes them into a repository-owned JSON
snapshot, and emits strongly-typed Dart.

- The normalized snapshot (`tool/tokens/carbon-tokens.normalized.json`) and the
  generated Dart (`lib/src/tokens/generated/`) are committed.
- Consumers need no Node, npm, network, or the Carbon repo.
- Upgrading Carbon is a dedicated change with visible snapshot + Dart diffs.

This directly addresses the Fortal drift problems called out in the brief
(hand-authored theme file, comment/value drift, shadow-stroke mismatch): the
values are mechanical output, and `tool/verify_generated.mjs` fails CI on any
non-deterministic or stale regeneration.

### 2. The generator is implemented in Node, not Dart

The brief sketches `generate_tokens.dart`. Because the extraction stage must
import the official Carbon **ES modules** (the only faithful source of resolved
values — safer than regex-parsing Sass/TypeScript), the whole pipeline is
Node-based. Implementing the emitter in Node too means one toolchain reproduces
every artifact, and the generation/verify stages run in CI without a Dart SDK.
The generated output is ordinary, reviewable Dart.

### 3. Preserve Carbon's model — do not translate into Fortal concepts

- Role-based themes (not Radix numbered scales): 234 roles resolved per theme.
- Contextual layer model: `CarbonLayer` maps aliases (`layer`, `field`,
  `borderSubtle`, …) to indexed role tokens for levels 1–3.
- Fluid spacing keeps its viewport unit; fluid type keeps per-breakpoint
  overrides; component tokens keep fallbacks and missing-theme omissions.
- No invented radius/elevation scale — Carbon's button radius is `0`.

### 4. Reuse Remix behavior through generated wrappers when anatomy matches

`remix_carbon → remix` uses a hosted constraint, which the Dart workspace resolves to
the sibling package during development. Interaction behavior stays in one
place. When Carbon and Remix anatomy match, a Carbon recipe targets the Remix
widget with `@MixWidget(target: ...)` and explicitly curates the target
parameters it exposes. A hand-written facade is reserved for a real anatomy or
behavior mismatch. The main entry point does not re-export Remix or Mix.

Button is the reference implementation. Its generated wrapper targets
`RemixButton`, while the recipe retains Carbon's `kind`, nullable contextual
`size`, and loading-specific visual treatment. The current generator deduplicates
compatible recipe/target parameters, so one `loading` field drives both the
recipe and Remix behavior. Carbon keeps the source term `kind`; generated named
constructors are optional convenience and do not dictate public vocabulary.

Components that reuse a Remix target should:

1. keep `mix_annotations`, `build_runner`, and `mix_generator` aligned with the
   workspace versions;
2. use a direct target and an explicit `widgetParameters: .only(...)` surface;
3. share compatible recipe/target fields when styling depends on behavior;
4. commit the generated part and let the workspace generation check prove it is
   reproducible;
5. use a hand-written facade only when anatomy or behavior truly requires an
   adapter.

An architecture checkpoint follows the Button, Text Input and Modal slices to
decide whether to keep depending on external Remix components or extract a
neutral shared component layer.

## Consequences

- Faithful, reproducible, upgradeable tokens with CI drift protection.
- One (Node) toolchain for token work; Dart/Flutter only for the library itself.
- Thin, reproducible wrappers reuse Remix behavior without mirroring its widget
  implementation, while curated parameters keep a Carbon-shaped public API.

## Follow-ups requiring product decisions (see brief §13)

- Approved Carbon Figma v11 kit node link (for goldens).
- IBM Plex font packaging strategy (bundled Latin core vs optional package vs
  consumer-provided).
- Icon packaging strategy.
- `remix_carbon` pub.dev name availability and IBM trademark/attribution review.
