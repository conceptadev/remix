# Token pipeline reference

The pipeline turns pinned design-token sources into committed, strongly-typed
Dart.

## Table of Contents

- [Directory layout](#directory-layout-node-flavored-example)
- [Stage contracts](#stage-contracts)
- [CI](#ci)
- [Upgrading the source](#upgrading-the-source)

The stage *contract* below is what matters; the runtime is an implementation
detail. Node is a natural fit when the source tokens are npm packages or JS
modules — pick whatever single toolchain best reads *the actual source*, as
long as the stages, committed artifacts, determinism, and read-only
verification hold. For non-code sources (Figma/PDF/websites/screenshots/brand
brief), the extract stage is replaced per `source-extraction.md`; everything
from normalize down is unchanged.

```
source (pkg/API/doc) ──extract──▶ build/raw-tokens.json               (gitignored)
                     ──normalize▶ tokens/<sys>-tokens.normalized.json (COMMITTED)
                     ──generate─▶ lib/src/tokens/generated/*.g.dart   (COMMITTED)
                     ──verify───▶ pass/fail (read-only, CI)
```

## Directory layout (Node-flavored example)

```
packages/<name>/tool/
  package.json            # scripts: tokens:install/extract/.../tokens:all
  README.md               # stage table + upgrade procedure
  lib/convert.mjs         # ALL shared conversion helpers + shared constants
  extract_tokens.mjs      # tier 1 only; authored file replaces it otherwise
  normalize_tokens.mjs
  generate_tokens.mjs
  verify_generated.mjs
  tokens/<sys>-tokens.normalized.json   # committed snapshot
  authored/<sys>-authored-tokens.json   # committed, only for non-code sources
  upstream/
    package.json          # exact-version deps — THE single version source
    package-lock.json     # committed (integrity hashes feed the source lock)
    <sys>-source-lock.json# generated provenance record, committed
  build/                  # gitignored scratch
```

## Stage contracts

### 1. Extract (`extract_tokens.mjs`)

- When the source ships executable modules, `createRequire` against
  `tool/upstream/` and **import the official packages as executable modules**
  — never regex-parse Sass/TS source. Resolved exports are the only faithful
  values.
- Derive the pinned-version map from `upstream/package.json` `dependencies`
  (fail if any version isn't exact). Do **not** restate versions in the
  script — that's a second copy that drifts.
- Write `upstream/<sys>-source-lock.json`: repo commit, commit date, license,
  schema version, pinned versions, integrity hashes (read from the lockfile).
- End with **inventory assertions** — exact expected counts of palette
  colors, roles × themes, and component tokens for the pinned version.
  Upstream drift must fail loudly at extract time, not surface as a subtle
  diff.

### 2. Normalize (`normalize_tokens.mjs`)

Converts raw values into a repository-owned schema. All conversion rules live
in `lib/convert.mjs` so normalize and generate can never disagree:

| Source value | Normalized | Rule |
| --- | --- | --- |
| colors (hex/rgb/rgba, CSS Color 4 `rgb(r g b / a%)`) | `0xAARRGGBB` string | alpha = `round(a*255)`; parse BOTH comma and slash syntaxes |
| `rem` | logical px | × 16 (or the system's base), only at generation time |
| `ms` strings | int milliseconds | |
| `cubic-bezier(…)` | `[x1,y1,x2,y2]` | reject NaN |
| viewport units (`vw`) | `{value, unit}` | **preserve**, never freeze at one viewport |
| responsive/fluid styles | base + per-breakpoint override objects | preserve structure |
| per-theme component tokens | only the keys present in the source + `fallback` | **omission is data** — never fabricate a missing theme value |

Hard rules:

- Every numeric parser must **throw on NaN** (`[\d.]+` matches `1.2.3`).
- `stableStringify` (deep-sorted keys) + `round4` for floats → deterministic
  bytes.
- Accept `--out <path>` so verify can run read-only.

### 3. Generate (`generate_tokens.mjs`)

Emits the Dart under `lib/src/tokens/generated/`. Required properties:

- **Header on every file**: source + version/commit (or authored-file hash),
  regeneration command, `SPDX-License-Identifier`.
- Token handles as `static const` Mix tokens (`ColorToken`, `SpaceToken`,
  `TextStyleToken`, `DurationToken`, `FontWeightToken`) in one `<Sys>Tokens`
  class, namespaced (`<sys>.color.<role>` etc.).
- Resolved value maps as **top-level `final`s**, not functions — Mix tokens
  override `==` so `const` maps are illegal, and per-call functions
  re-allocate hundreds of entries per scope rebuild:

  ```dart
  final Map<ColorToken, Color> acmeRoleColorsLight = { ... };
  ```

- Validate every emitted identifier: legal Dart, not reserved, unique across
  all token domains. Fail generation on collision.
- Font-family stacks: split CSS stacks into a **usable primary family name**
  plus a `*Fallback` `List<String>` — a raw CSS stack is dead on arrival as
  `TextStyle.fontFamily`.
- If the system has indexed families (layer/level 01/02/03…), also emit the
  mechanical grouping (an `<sys>IndexedRoleFamilies` map) so runtime code
  and tests can validate coverage.
- Emit a `<Sys>SourceManifest` class: commit/versions (or source hashes),
  license, inventory counts — this is what token tests assert against.
- Accept `--out <dir>`. **Never call `Date.now()` or use randomness.**
- Double literals via a helper that always prints a decimal point; colors via
  a validator that rejects anything not matching `^0x[0-9A-F]{8}$` (this is
  what catches unparsed source values).

### 4. Verify (`verify_generated.mjs`)

Read-only; suitable for CI without a dependency install:

1. Regenerate into a temp dir via `--out`; diff byte-for-byte against the
   committed files (file set AND contents).
2. Scan committed generated files: provenance headers present; no unparsed
   CSS units on code lines (`\d(rem|vw|em)\b|cubic-bezier|rgba?\(`).
3. If `build/raw-tokens.json` exists (post-extract), re-normalize into a temp
   file via `--out` and diff against the committed snapshot. **Never write
   over the committed snapshot** — an in-place re-run masks the very drift
   being checked.
4. Print per-stage ✓/✗ using a per-stage failure counter (snapshot the global
   counter before each stage) — a global `if (!failures)` gate makes later
   stages' results unreadable after an early failure.

## CI

Add a workflow that, on PRs touching the package, sets up the script runtime
(e.g. `actions/setup-node`) and runs `node tool/verify_generated.mjs`. No
network or dependency install needed — generation runs from the committed
snapshot.

## Upgrading the source

A dedicated PR containing: the version bump in `upstream/package.json` (or a
re-retrieved, re-hashed document/authored file), a full pipeline re-run, and
the reviewed diffs of the source lock, the normalized snapshot, the generated
Dart, and any affected goldens/tests. Update extract's inventory assertions
deliberately if the token surface grew.
