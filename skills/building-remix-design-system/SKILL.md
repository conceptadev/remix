---
name: building-remix-design-system
description: >-
  Use this skill when the user wants to build, port, generate, or scaffold a
  design-system package on top of Remix (Mix + Naked UI), such as implementing
  Material, Polaris, Fluent, or Spectrum on Remix; creating a design-system
  package; adding a token pipeline for a named system; or wrapping Remix
  components in brand-specific styling. Also trigger for token extraction,
  design-token generation, theme scopes, or component recipes for any
  Remix-based design system other than Fortal, including questions about
  @MixWidget, mix_generator, generic generated wrappers, or named variant
  constructors in such a package. Sources can be npm token packages, Figma
  files, documentation, PDFs or brand books, screenshots, or only a written
  brand brief.
---

# Building a Design System Package on Remix

The result of following this skill is a standalone package under `packages/`
that:

- reuses **Naked UI** for interaction behavior, **Mix** for styling mechanics,
  and **Remix** for component machinery — and adds only the target system's
  design decisions on top;
- generates its entire token surface from **pinned, traceable sources**
  (never hand-copied values), reproducibly and CI-enforced;
- exposes an idiomatic public API in the *target system's* vocabulary, not
  Remix's or Fortal's.

Do not clone Fortal and swap colors — Fortal is a hand-authored theme *inside*
remix; new design systems are generated, standalone packages.

## Architecture at a glance

```
naked_ui        interaction primitives (focus, press, semantics, keyboard)
   ↑
mix             styling engine, tokens, MixScope, variants
   ↑
remix           reusable component machinery (ButtonStyler, specs, widgets)
   ↑
<your package>  generated tokens + <System>Scope + component recipes/facades
                exposes ONLY <System>* widgets and tokens publicly
```

Three layers per package:

| Layer | Path | Contents |
| --- | --- | --- |
| Tokens | `lib/src/tokens/` | hand-written shared types + `generated/*.g.dart` (committed) |
| Foundation | `lib/src/foundation/` | `<System>Scope`, theme enum, contextual scopes, type/motion helpers |
| Components | `lib/src/components/<name>/` | one recipe/facade per component + worksheet in `specs/components/` |

The pipeline that produces `generated/` lives in `tool/` and is
**development-only** — consumers never need its toolchain or network access.

## Design sources — any input works

The pipeline is source-agnostic. Classify what is available per token domain
(colors may come from a better source than spacing) and take the highest tier
per domain — see `references/source-extraction.md`:

| Tier | Input | Extract mode |
| --- | --- | --- |
| 1 | machine-readable tokens (npm package, tokens JSON, CSS variables) | automated, re-runnable script |
| 2 | queryable source (Figma API, inspectable docs site) | semi-automated harvest |
| 3 | readable document (PDF, brand book, docs prose) | cited transcription |
| 4 | images only (screenshots, exports) | calibrated measurement |
| — | **no artifacts — a brand brief or verbal description** | authored design: design the token set deliberately, inventory-first, decisions recorded |

Everything converges on one committed snapshot; normalize → generate → verify
run identically no matter where the values came from. Mixed tiers are normal.
When the input is a brief, there is nothing to extract — *design* the tokens
(confidence `designed`), record the rationale in the ADR, and treat the brief
itself as the pinned source (commit it, or quote it verbatim in the ADR).

## Workflow

Work through the phases in order. Each phase ends with something verifiable.

### Phase 0 — Pin sources and record decisions

1. Inventory every available source and classify each token domain by tier
   (table above). Record the tiers plus a conflict-precedence order in the ADR.
2. Pin whatever can be pinned: **exact versions** and commit SHAs for tier 1;
   file versions, URLs + retrieval dates, and sha256 hashes for everything
   else. No caret ranges, no "latest", no un-dated web sources. For a brief,
   commit the brief.
3. Record in an ADR (`docs/adr/0001-…`): source tiers, dependency strategy,
   what the first release covers, what is explicitly out of scope, font/icon
   strategy, and naming/trademark constraints.
4. Decide the theme model up front: how many themes, whether the system uses
   role-based tokens (semantic names like `interactivePrimary`), numbered
   scales (like Radix/Fortal's `accent1–12`), or something else. **Preserve
   the target system's model** — never translate it into another system's
   concepts. When designing from a brief, pick one model deliberately and
   record why.

### Phase 1 — Package scaffold

Create `packages/<name>/` with `pubspec.yaml`, `analysis_options.yaml`,
`README.md`, `CHANGELOG.md`, `LICENSE`, `NOTICE`, `.gitignore`, `lib/<name>.dart`.

Non-obvious requirements (each one has produced a real failure):

- `publish_to: none` **while `remix` is a path dependency** — otherwise the
  analyzer emits a fatal `invalid_dependency` warning. Leave a comment saying
  when to remove it.
- Add the package to the **root `pubspec.yaml`** in *two* places: the
  `workspace:` list and the `melos: packages:` globs. Nested members
  (`packages/<name>/example`) must be listed explicitly — `packages/*` does
  **not** cross path separators, so melos scripts silently skip them.
- `NOTICE` must carry upstream attribution (license of the design system,
  font licenses, trademark disclaimer) and the package license must be
  compatible with the upstream token license.
- Exclude `tool/` from Dart analysis and gitignore `tool/build/` and any
  toolchain dependency directories (e.g. `tool/**/node_modules/`).
- The main entry point (`lib/<name>.dart`) must **not** re-export the full
  Remix or Mix API — export only the package's scopes, tokens, and components.

### Phase 2 — Token pipeline

Read `references/token-pipeline.md` before writing any pipeline code. When
the source is not executable code, also read
`references/source-extraction.md` — only the **extract** stage changes:

- Tier 1 sources use an automated extract script.
- Everything else replaces it with a committed, hand-authored
  `tool/authored/<sys>-authored-tokens.json` where **every value carries a
  citation and a confidence level** (`specified`/`derived`/`measured`/
  `assumed`/`designed`), authored inventory-first so gaps are explicit.
  Normalize, generate, and verify run unchanged on top of it.

The contract (runtime-agnostic — pick whatever single toolchain best reads
the source, as long as these properties hold):

- Four stages: **extract → normalize → generate → verify**, with all
  conversion rules in one shared module so stages can never disagree.
- The normalized JSON snapshot **and** the generated Dart are **committed**.
- Regeneration from the same source lock is **byte-identical**, and the
  verify script is **read-only** (every writer takes `--out`).
- Every generated file carries provenance headers (source, versions, commit,
  SPDX license) and contains **no unparsed CSS units**.
- Add a CI workflow that runs the verifier on PRs touching the package — it
  needs only the script runtime, no dependency install (generation runs from
  the committed snapshot). Docs may only claim "CI enforced" once this
  workflow file exists.

### Phase 3 — Foundation runtime

Read `references/foundation-patterns.md`. The essentials:

- `<System>Scope` resolves the generated token maps into a `MixScope`.
  **Memoize the per-theme base map** (top-level cache, `Map.unmodifiable`) so
  repeated scope rebuilds return the identical instance — Mix dependents then
  short-circuit equality checks. Rebuilding ~hundreds of map entries per
  ancestor rebuild is real, measured waste.
- Any typed overrides object needs **value equality** (`==`/`hashCode`), or
  the scope's `updateShouldNotify` always fires.
- Everything the scope configures must be **readable back from context**
  (e.g. `overridesOf(context)`) so helpers like type resolvers can honor it
  without re-plumbing at every call site. A setting that only affects half
  the system (e.g. a fontFamily override that reaches fixed text styles but
  not fluid ones or component labels) is a bug.
- Contextual scopes (`of`/`maybeOf` pattern): provide `maybeOf` whenever a
  component has its own default that differs from the scope's default — only
  `maybeOf` can distinguish "no scope present" from "scope chose its default".
- Runtime lookups keyed by name must **throw `ArgumentError` in all build
  modes** on unknown input — an assert-plus-silent-fallback ships typos to
  production as wrong-but-plausible rendering.
- If the system has an indexed/leveled concept (layered surfaces, elevation
  levels), generate the index mechanically and add a test asserting the
  hand-written enum covers every generated entry — hand-written switches over
  generated data drift.

### Phase 4 — Components

Read `references/component-playbook.md` **before the first component** — it
contains the Remix/Mix behavioral gotchas that have produced real bugs
(loading-state styling, focus-ring layout shift, and others).

Per component:

1. Write the worksheet `specs/components/<component>.yaml` first (template in
   the playbook). It is the reviewable bridge between the design source and
   the Flutter code: anatomy, kinds, sizes, states, exact tokens, non-token
   measurements *with sources*, and approved approximations.
2. Apply the **wrapper decision rule**: generate a `@MixWidget` wrapper only
   when the target system's anatomy matches the Remix component, the public
   API reads in the target vocabulary, and no Remix-only types leak. Otherwise
   write a hand-written facade (a `StatelessWidget` that builds a
   `*Styler` recipe and calls it).
3. Style **through tokens, never copied values**: `token()` inside styler
   chains, `TextStyler().style(textToken.mix())` for text styles,
   `token.resolve(context)` for direct widget use. A hand-copied measurement
   "kept in sync" with a token is a drift bug waiting to be found.
4. **Memoize recipes.** Styler chains are pure functions of a few enums;
   cache them in a top-level `Map<(kind, size, …), Styler>` keyed by records.

### Phase 5 — Tests, example, docs

- **Token tests**: inventory counts against the source manifest, per-theme
  spot values, cached-and-unmodifiable base maps, override behavior,
  partial-theme omissions preserved (never fabricate a missing source value).
- **Drift tests**: every hand-written enum that mirrors generated data gets a
  coverage test against the generated structure.
- **Widget tests**: one regression test per state that has distinct visuals —
  including **loading** (assert the container color is the kind's fill, not
  the disabled treatment) and **default size without any scope** (assert the
  measured height). Spinners animate forever: use `tester.pump(duration)`,
  never `pumpAndSettle`, in loading tests.
- **Example app**: must consume the package's own token system for its chrome
  (`token.resolve(context)`), never hand-picked palette values — the example
  is the first pattern adopters copy.
- Docs claims must match code. If the README promises something ("CI
  enforced", "applies to every text style"), verify the mechanism exists.

### Definition of done (per release)

- `dart analyze <pkg> <pkg>/example` clean (package root included — catches
  pubspec lints).
- `flutter test` green, including the regression matrix above.
- The verify script passes; a full fresh extract→normalize→generate leaves
  `git status` clean.
- Worksheets exist for every shipped component; approximations documented.
- NOTICE/LICENSE/attribution complete; no temporary claims in docs.

## Quick pitfall index

Ten rules that have caused real bugs or review findings, each explained where
it applies — component gotchas (1, 2, 4, 5) in
`references/component-playbook.md`, pipeline rules (3, 8, 9, 10) in
`references/token-pipeline.md`, scaffold rules (6, 7) in Phase 1 above:

1. `RemixButton` folds `loading` into the **disabled** widget-state — style
   loading via the disabled variant, parameterized by a `loading` flag.
2. Focus rings via `borderAll` shift layout and clobber the kind's border —
   paint them with `foregroundDecoration` instead.
3. Mix tokens override `==` → they **cannot be const-map keys**; emit
   generated maps as **top-level `final`s**, not per-call functions.
4. `num.clamp()` returns `num` — add `.toInt()` before indexing.
5. `pumpAndSettle` never settles while a spinner animates.
6. melos/workspace globs don't cross path separators — list nested example
   packages explicitly.
7. Path dependency without `publish_to: none` = fatal analyzer warning.
8. Source color strings may use CSS Color 4 syntax (`rgb(141 141 141 / 30%)`)
   — parse both legacy and modern forms.
9. Version pins must have **one** source of truth (derive provenance from the
   pinned manifest, don't restate versions in scripts).
10. Never use `Date.now()`/randomness in generation — byte-identical output is
    the invariant that makes verification possible.

## Additional resources

- **`references/source-extraction.md`** — getting tokens out of any source
  (code, Figma, websites, PDFs, screenshots, or a brand brief).
- **`references/token-pipeline.md`** — stage contracts for
  extract → normalize → generate → verify.
- **`references/foundation-patterns.md`** — scope, theme map, contextual
  scopes, type, and motion runtime patterns.
- **`references/component-playbook.md`** — per-component workflow, worksheet
  template, and Remix/Mix gotchas.
