# Carbon token pipeline

Deterministic, development-only pipeline that turns the official IBM Carbon
JavaScript packages into the committed Dart token files under
`lib/src/tokens/generated/`.

Consumers of the `carbon` package never run any of this — the generated Dart and
the normalized snapshot are committed. Node is only needed to **regenerate**
after a Carbon version bump.

## Stages

| Stage | Script | Input | Output |
| --- | --- | --- | --- |
| 1. Extract | `extract_tokens.mjs` | pinned `@carbon/*` packages in `upstream/` | `build/raw-tokens.json`, `upstream/carbon-source-lock.json` |
| 2. Normalize | `normalize_tokens.mjs` | `build/raw-tokens.json` | `tokens/carbon-tokens.normalized.json` (committed) |
| 3. Generate | `generate_tokens.mjs` | normalized snapshot | `lib/src/tokens/generated/*.g.dart` (committed) |
| 4. Verify | `verify_generated.mjs` | committed artifacts | pass/fail (byte-identical regeneration, provenance, no unparsed CSS) |

## Usage

```bash
cd packages/carbon/tool
npm run tokens:install     # installs the pinned @carbon/* sources into upstream/
npm run tokens:all         # extract -> normalize -> generate -> verify
# or individually:
npm run tokens:generate    # re-emit Dart from the committed snapshot (no upstream needed)
npm run tokens:verify      # CI drift check
```

## Determinism

`verify_generated.mjs` regenerates into a scratch directory and fails on any
diff. Re-running from the same source lock is byte-identical (object keys are
sorted, floats are rounded to 4 dp, colors are emitted as `0xAARRGGBB`). CI
should run `tokens:generate` + `git diff --exit-code`, or `tokens:verify`.

## Upgrading Carbon

Bumping a `@carbon/*` version is a dedicated change:

1. Edit the pinned version(s) in `upstream/package.json`, run `npm install` there.
2. `npm run tokens:all`.
3. Review the diffs in `upstream/carbon-source-lock.json`,
   `tokens/carbon-tokens.normalized.json`, and `lib/src/tokens/generated/`.
4. Re-run affected component goldens and note changes in the changelog.

See `docs/adr/0001-carbon-token-pipeline.md` for why the emitter is implemented
in Node rather than Dart.
