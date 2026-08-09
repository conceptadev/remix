---
name: remix
description: Use when working on the Remix Flutter component library or its Fortal theme package in this repository. Covers remix and remix_fortal package boundaries, Remix* and Fortal* widgets, stylers and recipes, FortalScope and tokens, component docs, generated APIs, Radix parity, Melos verification, and publishing constraints.
---

# Remix and Fortal

Remix is a theme-free Flutter component library built on Naked UI and Mix.
Fortal is the optional Radix Themes-inspired preset distributed as the separate
`remix_fortal` package.

## Resolve Ground Truth

Use current repository state instead of memorized APIs:

1. Read the relevant package `pubspec.yaml` for current versions and SDK floors.
2. Check the public barrels: `packages/remix/lib/remix.dart` and
   `packages/remix_fortal/lib/remix_fortal.dart`.
3. Read `docs/components/<component>.mdx` for documented usage and the local
   component or recipe source for exact constructors and enum values.
4. Use generated `*.g.dart` only to inspect emitted APIs; edit the annotated
   source and regenerate instead of editing generated files.
5. For underlying Mix semantics, consult the sibling [`mix` skill](../mix/SKILL.md).

## Choose the Correct Layer

| Need | Use |
|---|---|
| Accessible behavior with a custom visual system | `remix` and `Remix*` widgets/stylers |
| Ready-made Radix-inspired visuals | `remix_fortal`, `FortalScope`, and `Fortal*` widgets |
| Custom composition with Fortal tokens and states | `fortal*Style()` recipes applied to Remix widgets |
| Low-level styling primitives or new specs | Mix APIs and the sibling `mix` skill |

Read [`references/fortal.md`](references/fortal.md) for every Fortal task. It
defines the package boundary, scope placement, widget/recipe conventions,
source routing, and required verification.

## Package Boundaries

- `remix` deliberately exports no Fortal symbols.
- `remix_fortal` depends on `remix` but does not re-export it. Import both when
  code uses base Remix types alongside Fortal APIs.
- Behavioral roots without visual styling remain Remix APIs. Do not invent
  wrappers such as `FortalTabs`; inspect the component docs and recipe source.
- Confirm variants, sizes, defaults, and constructor parameters from local
  source. Fortal families do not share one universal variant surface.

## Editing Workflow

- Edit Remix behavior and base styling under `packages/remix/lib/src/`.
- Edit Fortal tokens under `packages/remix_fortal/lib/src/fortal/` and recipes
  under `packages/remix_fortal/lib/src/recipes/`.
- Update the corresponding `docs/components/*.mdx` page when a public API or
  documented usage changes.
- Preserve the separation: generic visual behavior belongs in `remix`; the
  Radix-specific preset belongs in `remix_fortal`.

## Commands

```bash
melos bootstrap
melos run generate
melos run generate:check
melos run docs:check
melos run fortal:parity:check
melos run test:flutter
melos run ci
```

Use `melos run ci` as the complete repository gate. Run the narrower commands
while iterating, then run the complete gate before claiming the change is ready.

## References

- [`references/fortal.md`](references/fortal.md) — choosing, using, extending,
  documenting, and verifying Fortal
- [`../mix/SKILL.md`](../mix/SKILL.md) — Mix Styler, token, variant, animation,
  and code-generation fundamentals
