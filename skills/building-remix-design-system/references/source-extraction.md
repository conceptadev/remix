# Source extraction strategy — getting the critical set out of any source

This is a **strategy, not a toolchain**. Sources vary (code, Figma, websites,
PDFs, screenshots, or nothing but a written brand brief) and the tools
available will vary even more between environments. Never let a missing tool
change *what* you extract — only *how* a value gets read and how much
confidence it carries. Tools are named below only as examples; at extraction
time, survey what the current environment actually offers and pick the best
available capability.

## Table of Contents

- [Critical set](#1-the-critical-set--what-must-come-out-regardless-of-source)
- [Invariants](#2-the-invariants--hold-these-under-any-tooling)
- [Classify sources](#3-classify-each-source-by-capability-per-domain)
- [Extraction modes](#4-extraction-mode-notes-tool-agnostic)
- [Where values land](#5-where-values-land)
- [Conflicts and upgrades](#6-conflicts-and-upgrades)
- [What not to build](#7-what-not-to-build)

## 1. The critical set — what must come out, regardless of source

Extraction is done when you can fill this, or have explicitly marked a gap:

**Per token domain:**

| Domain | Minimum extraction |
| --- | --- |
| Color | every named role/token per theme; raw palette if the system has one; state colors (hover/active/disabled) — these are tokens, not effects to guess |
| Spacing | the scale (every step, exact values); component-local paddings that aren't on the scale |
| Sizes | control heights per size name; icon sizes; container widths; breakpoints |
| Typography | families + weights; every named text style (size, line height, letter spacing, weight); responsive behavior if any |
| Motion | durations; easing curves; which interactions animate at all |
| Shape/elevation | radii and shadows **only if the system defines them** — absence is a finding, not a gap to fill |

**Per component (feeds the worksheet):**

- anatomy (slots, structure), variants/kinds, supported sizes + default,
- every state with distinct visuals (rest/hover/active/focus/disabled/loading/error/…),
- exactly which tokens each state consumes,
- non-token measurements, each with its source,
- behavior notes (keyboard, focus, RTL) when the source shows them.

## 2. The invariants — hold these under any tooling

1. **One meeting point.** Everything converges on the committed normalized
   snapshot; generation and verification downstream never care where values
   came from.
2. **Inventory before values.** Enumerate every token name and every
   component's variants/sizes/states from the source *first*; then fill
   values. Gaps become explicit (`"status": "missing-in-source"`), never
   silent absences.
3. **Every value is traceable**: a citation (page, node link, URL + date,
   image + coordinates, brief section) and a confidence level:
   `specified` (stated) / `derived` (computed by a documented rule) /
   `measured` (sampled from a rendering) / `assumed` (judgment — must also
   appear in a worksheet's approximations) / `designed` (deliberately chosen
   from a brief or design intent — rationale recorded in the ADR).
4. **Pin what can be pinned; hash and date the rest.** Versions and commits
   for code; file versions + sha256 + retrieval dates for documents and
   images; URLs + dates + viewport for anything rendered.
5. **Never fabricate.** No invented scale steps, no guessed hover colors, no
   filled-in themes the source doesn't define. Absence is data.
6. **Deterministic downstream.** From the committed extraction artifacts,
   regeneration is byte-identical and verification is read-only.

## 3. Classify each source by capability, per domain

Classify **per domain** (colors may come from a better source than spacing).
The tier is a function of the source *and* of what the current environment
lets you do with it — re-survey both each time:

| Tier | You have… | Extraction mode | Default confidence |
| --- | --- | --- | --- |
| 1 | machine-readable values (token packages, tokens JSON, stylesheet variables) | automated, re-runnable script | specified |
| 2 | a queryable structured source (design-tool API, a rendered page you can programmatically inspect) | semi-automated harvest, re-runnable against a pinned version | specified/derived |
| 3 | a readable document (PDF, brand book, docs prose) | manual transcription with citations | specified |
| 4 | only images (screenshots, exports) | manual measurement with a recorded methodology | measured |
| — | no artifacts — a brand brief or verbal description | authored design (see §4b) | designed |

**Degrade gracefully.** If the capability a tier needs is missing in the
current environment (no browser automation, no API token), treat the source
as the next tier down rather than blocking — e.g. a live styleguide you can't
programmatically inspect becomes a document you read (tier 3) or screenshots
you measure (tier 4). Record the degradation so a later environment can
upgrade it.

**Upgrade opportunistically.** Before manual work, check whether the source
secretly offers a higher tier: websites often ship their tokens as stylesheet
custom properties (tier 1 hiding behind a tier 2/3 page); design files often
have an export or API path; vendors often publish a tokens package you
weren't told about. Ten minutes of looking beats a day of measuring.

## 4. Extraction mode notes (tool-agnostic)

### Automated (tier 1)

Import/parse the machine-readable source with a small, package-owned script.
Pin exact versions; assert inventory counts so upstream drift fails loudly.
Whatever the language/runtime, the script's contract is: committed lock +
re-runnable + deterministic output.

### Queryable (tier 2)

- Pin the queryable source's version (file version, API revision) so
  harvests are reproducible against it.
- For rendered pages: prefer the page's own declared values (stylesheet
  variables) over computed values; when you must read computed values, record
  the viewport and simulate each state the styleguide can render. Computed
  values freeze responsive behavior — harvest at multiple widths if the
  system is fluid.
- For design files: variables/styles usually map to color/type tokens;
  spacing usually lives in the component frames' layout values. Cite node
  links.

### Transcription (tier 3)

- Read the document end-to-end for the inventory pass, then transcribe token
  tables with per-page citations.
- Prefer digital color values stated in the document; print-space values
  (CMYK/Pantone) need an officially stated digital mapping, else the value is
  `assumed`.

### Measurement (tier 4)

Record the methodology once in provenance and apply it consistently:

- Lossless images only; compression artifacts corrupt colors and edges.
- **Calibrate scale first** against an element of known size; record the
  calibration; convert all measurements through it.
- Colors: sample flat regions away from edges (anti-aliasing bleeds); use the
  dominant value of a patch, not one pixel.
- Spacing: measure raw, convert, and only snap to a base grid when multiple
  independent measurements agree; keep raw and snapped values.
- Each interaction state needs its own capture; a state with no capture is a
  gap or an `assumed` value, never a silent invention.
- Keep the images (license permitting) or their hashes + origin, plus
  coordinates per sample, so any value can be re-checked.

### 4b. Designed from a brief (no source artifacts)

When the only input is a description ("our brand is calm and premium, primary
color teal, dark-first"), there is nothing to extract — the token set is
*designed*. The same discipline applies, with the brief in the source role:

- **Commit the brief.** Capture the user's constraints verbatim (a
  `docs/brief.md` or an ADR section) so every `designed` value can cite it.
  Anything the brief doesn't constrain is a design decision to make and
  record — not a gap and not a silent invention.
- **Inventory first, still.** Decide the full token inventory (which color
  roles, how many scale steps, which text styles, which themes) before
  filling values, and record the chosen theme model in the ADR.
- **Design with a documented rule wherever possible** — a perceptually even
  color ramp generated from the brand color, a modular type scale, a 4px
  spacing base — so values are `derived` from a stated rule rather than
  one-off picks. Reserve plain `designed` for genuine taste calls.
- **Elicit before inventing** when the user is available: brand colors,
  light/dark requirements, density, typeface constraints, and any existing
  assets (a logo alone pins brand hues). One round of questions beats a
  redesign.
- The authored file, normalize, generate, and verify all run unchanged;
  verification lints that every value cites the brief or a stated rule.

## 5. Where values land

Tier 1 output feeds normalize directly. Everything else (tiers 2–4 and
brief-designed systems) lands in a committed, hand-reviewable authored file
(`tool/authored/<sys>-authored-tokens.json`) holding the inventory, values,
citations, confidences, and gap markers — normalize/generate/verify run
unchanged on top of it. Verification for authored sources lints traceability
(every value cited, every `assumed` echoed in a worksheet) instead of
re-running extraction; human review of the authored file against the source
*is* the extraction test.

```json
{
  "provenance": {"sources": [{"id": "brandbook", "type": "pdf",
    "title": "Acme Brand Guidelines v2.3", "sha256": "…", "retrieved": "2026-07-11"}]},
  "colors": {
    "interactivePrimary": {"value": "#0B5FFF", "cite": "brandbook p.14", "confidence": "specified"},
    "interactivePrimaryHover": {"value": null, "status": "missing-in-source"}
  }
}
```

## 6. Conflicts and upgrades

- **Precedence** when sources disagree: shipped code/styles → design-tool
  source → docs prose → PDF → screenshots. Deviate deliberately (record it in
  the ADR) and keep the losing source cited so the conflict stays visible.
- **Tier upgrades**: when a better source or capability appears later, run
  the higher-tier extraction and diff against the authored file — changed
  `measured`/`assumed` values are expected corrections; changed `specified`
  values are transcription bugs worth a look. Then retire the authored file
  for that domain.

## 7. What NOT to build

- Automation for its own sake (OCR/vision pipelines for a 40-page PDF): a
  brand book defines dozens of tokens; cited transcription is faster and
  reviewable.
- A generic multi-source extraction framework, or tooling that assumes a
  specific environment. Each harvester is a small script owned by one
  package, written against whatever the environment offers *that day*.
- Completeness the source doesn't support. Ship what the source defines;
  mark the rest missing; extend when evidence appears.
