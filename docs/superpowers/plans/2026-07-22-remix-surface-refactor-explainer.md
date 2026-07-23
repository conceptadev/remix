# Remix Surface Refactor Explainer Implementation Plan

> **Superseded:** This historical plan targeted an explainer that has been
> removed. Do not execute its implementation steps or treat its names as the
> current Remix API.

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a self-contained interactive HTML document that explains why commit `0fd5983` changed Remix surface ownership, how every surface type participates, and what the architecture enables across real components.

**Architecture:** One standalone HTML file contains the article, responsive theme-aware CSS, inline SVG diagrams, immutable source inventory data, and dependency-free JavaScript. Static content carries the whole explanation; JavaScript progressively enhances the type map, paint stack, data-flow stepper, and component gallery.

**Tech Stack:** Semantic HTML5, embedded CSS, inline SVG, browser-native JavaScript, macOS `tidy`, Node.js syntax checking, and headless Google Chrome.

## Global Constraints

- Create exactly one runtime artifact: `docs/remix-surface-refactor-explainer.html`.
- Embed all CSS, JavaScript, diagrams, and data; make no network requests.
- Use precise SVG/CSS technical diagrams, not generated raster artwork.
- Cover every surface building block listed in the approved design.
- Include eight detailed examples and all 15 affected component families.
- Remain understandable without JavaScript and usable by keyboard.
- Support WCAG AA contrast, narrow screens, dark color schemes, and reduced motion.
- Do not change Remix runtime code, APIs, tests, or documentation navigation.

## File Structure

- Create: `docs/remix-surface-refactor-explainer.html` — complete portable explainer.
- Reference only: `packages/remix/lib/src/rendering/remix_surface.dart`.
- Reference only: `packages/remix/lib/src/rendering/remix_blend_mode.dart`.
- Reference only: `packages/remix/lib/src/components/*/*_spec.dart`.
- Reference only: `packages/remix/lib/src/components/*/*_widget.dart`.
- Reference only: `packages/remix/lib/src/components/*/fortal_*_styles.dart`.
- Reference only: `packages/remix/test/rendering/remix_surface_test.dart`.
- Reference only: `packages/remix/test/components/surface_layer_component_lerp_test.dart`.
- Reference only: `packages/remix/test/rendering/remix_blend_mode_test.dart`.

The one-file boundary is deliberate: this is a portable review aid, not a new
application. Keep its script internally divided into immutable data, render
functions, event binding, and initial activation.

---

### Task 1: Static Narrative and Ownership Split

**Files:**
- Create: `docs/remix-surface-refactor-explainer.html`
- Reference: `docs/superpowers/specs/2026-07-22-remix-surface-refactor-explainer-design.md`

**Interfaces:**
- Consumes: the approved narrative and exact ownership rule.
- Produces: stable section IDs `overview`, `why`, `types`, `paint-order`,
  `data-flow`, `components`, `migration`, `constraints`, and `decision-tree`.

- [ ] **Step 1: Write the accessible document shell**

Create an HTML5 document with `lang="en"`, UTF-8 and viewport metadata,
`color-scheme: light dark`, a skip link targeting `#main`, a visible
`<header id="overview">`, sticky section navigation, `<main id="main">`, all
nine section IDs, and a footer identifying commit `0fd5983`.

- [ ] **Step 2: Add the theme and responsive foundation**

Define semantic tokens for page, panel, ink, muted ink, border, Mix blue, Remix
teal, warning/focus, and code surfaces. Add a dark-scheme override, a two-column
grid that stacks below 720px, visible `:focus-visible`, responsive headings,
horizontal navigation overflow, and `prefers-reduced-motion` overrides.

- [ ] **Step 3: Write the permanent before/after explanation**

State this exact rule prominently:

```text
Mix owns normal box geometry and decoration. Remix owns only the advanced paint
that Mix cannot express while preserving Fortal fidelity.
```

Render an old/new comparison and an ownership table with these rows:

```javascript
const ownershipRows = [
  ['Color, ordinary gradient/shadow, border, radius','Mix BoxSpec/FlexBoxSpec'],
  ['Padding, margin, constraints, alignment, transform, clipping','Mix box layout'],
  ['Multiple token-aware gradients and independent insets','RemixSurfaceLayerMix/Spec'],
  ['Ordered outer and true inset shadows','RemixSurfaceLayerMix/Spec'],
  ['Background/foreground grouping, blur, offset outline','RemixSurfaceEffectsMix/Spec'],
  ['Composition at the decoration boundary','remixSurfaceBox/remixSurfaceFlexBox']
];
```

Explain duplicate ownership, radius drift, paired surface/overlay fields, the
exposed public wrapper, and the ordinary Mix fast path after the refactor.

- [ ] **Step 4: Validate and commit the static document**

Run:

```bash
tidy -errors -quiet docs/remix-surface-refactor-explainer.html
rg -n 'id="(overview|why|types|paint-order|data-flow|components|migration|constraints|decision-tree)"' docs/remix-surface-refactor-explainer.html
git add docs/remix-surface-refactor-explainer.html
git commit -m "docs: add surface refactor explainer structure"
```

Expected: no structural errors and all nine IDs printed before the commit.

---

### Task 2: Complete Surface Type Map

**Files:**
- Modify: `docs/remix-surface-refactor-explainer.html`
- Reference: `packages/remix/lib/src/rendering/remix_surface.dart`
- Reference: `packages/remix/lib/remix.dart`

**Interfaces:**
- Consumes: `#types` and the Mix/Remix theme tokens.
- Produces: `surfaceTypes`, `renderTypeMap()`, keyboard-accessible `.type-node`
  buttons, an `aria-live="polite"` detail panel, and an always-visible fallback
  definition list.

- [ ] **Step 1: Add the exact inventory**

Define immutable entries with `id`, `name`, `kind`, `owner`, `purpose`,
`inputs`, `output`, `consumers`, and a relative `source` link. Include:

```javascript
const surfaceTypeNames = Object.freeze([
  'RemixPaintShadowKind','RemixPaintShadow','RemixPaintShadowMix',
  'RemixPaintShadowListToken','RemixLinearGradientMix','_normalizeGradient',
  'RemixSurfaceLayerMix','RemixSurfaceLayerSpec','Private list Mix adapters',
  'RemixSurfaceEffectsMix','RemixSurfaceEffectsSpec','Component Spec effect slots',
  'remixSurfaceBox / remixSurfaceFlexBox','_RemixEffectsBox / _RemixEffectsFlexBox',
  '_RemixDecoratedBox / _RemixDecoratedFlexBox','_RemixNegativeMargin render pair',
  '_RemixDecorationClipper','_RemixBoxBorderPainter','_SurfacePaintPhase',
  '_RemixSurfacePainter','_RemixSurfaceForegroundPainter','_surfacePaintBounds',
  'RemixBlendMode','Removed RemixSurface widget',
  'Removed RemixSurfaceBox / RemixSurfaceFlexBox widgets'
]);
```

- [ ] **Step 2: Render four connected lanes**

Render Authoring, Resolution, Composition, and Painting lanes. Each node is a
native button with `aria-pressed`. Selection highlights its upstream/downstream
connections in inline SVG and shows role, fields, output, consumers, source,
merge behavior, and interpolation behavior. Keep the same details in a visible
ordered fallback list.

- [ ] **Step 3: Verify every symbol and commit**

```bash
for symbol in RemixPaintShadow RemixPaintShadowMix RemixPaintShadowListToken RemixLinearGradientMix RemixSurfaceLayerMix RemixSurfaceLayerSpec RemixSurfaceEffectsMix RemixSurfaceEffectsSpec remixSurfaceBox remixSurfaceFlexBox _RemixEffectsBox _RemixEffectsFlexBox _RemixDecoratedBox _RemixDecoratedFlexBox _RemixNegativeMargin _RenderRemixNegativeMargin _RemixDecorationClipper _RemixBoxBorderPainter _SurfacePaintPhase _RemixSurfacePainter _RemixSurfaceForegroundPainter _surfacePaintBounds RemixBlendMode RemixSurface RemixSurfaceBox RemixSurfaceFlexBox; do rg -q "$symbol" docs/remix-surface-refactor-explainer.html || exit 1; done
git add docs/remix-surface-refactor-explainer.html
git commit -m "docs: map the complete Remix surface pipeline"
```

Expected: the loop exits silently with status 0 before the commit.

---

### Task 3: Paint Laboratory and Resolution Stepper

**Files:**
- Modify: `docs/remix-surface-refactor-explainer.html`
- Reference: `packages/remix/lib/src/rendering/remix_surface.dart:939`

**Interfaces:**
- Consumes: `#paint-order`, `#data-flow`, and type node IDs.
- Produces: `paintLayers`, `flowSteps`, `renderPaintLab()`, `setPaintLayer()`,
  `renderFlowStepper()`, and `setFlowStep()`.

- [ ] **Step 1: Encode the exact paint order**

```javascript
const paintLayers = Object.freeze([
  ['advanced-outer','Advanced background outer shadows','Remix','outer'],
  ['mix-shadow','Standard Mix box shadows','Mix','decoration'],
  ['backdrop','Clipped backdrop blur','Remix','aggregate'],
  ['mix-fill','Mix fill, image, or single gradient','Mix','decoration'],
  ['advanced-inner','Background gradients and inset shadows','Remix','inner'],
  ['mix-border','Standard Mix border','Mix','border'],
  ['child','Padded and aligned child content','Mix','content'],
  ['mix-foreground','Mix foreground decoration','Mix','foreground'],
  ['advanced-foreground','Advanced foreground gradients and shadows','Remix','all'],
  ['outline','Offset outline','Remix','outline']
]);
```

- [ ] **Step 2: Render the exploded stack and capability toggles**

Render a button-like cutaway as ten labeled SVG/CSS planes. Add one native
button per layer and checkboxes for multi-gradient, inset shadow, outer shadow,
blur, foreground focus, and outline. Selection updates `aria-pressed`, one
detail line, the rendered sample, and matching type-map highlights. Keep all
ten labels visible and include an equivalent ordered text description.

- [ ] **Step 3: Render the five-step resolution path**

```javascript
const flowSteps = Object.freeze([
  ['1. Author','Fortal recipe → RemixSurfaceEffectsMix','Token-aware values describe advanced paint and state overrides.'],
  ['2. Resolve','MixOps.resolve(context, …)','Tokens and widget state become concrete runtime values.'],
  ['3. Carry','ComponentStyler → ComponentSpec effects','One aggregate or role-specific aggregates cross the component boundary.'],
  ['4. Compose','remixSurfaceBox / remixSurfaceFlexBox','Empty effects keep Mix; advanced effects select the private adapter.'],
  ['5. Paint','Mix decoration + private painters','Split phases preserve clipping, border order, semantics, and overflow bounds.']
]);
```

Use native step buttons, retain all titles, and show the slider focus merge
`base.merge(focus)` in step 3.

- [ ] **Step 4: Parse the script and commit**

```bash
node -e "const fs=require('fs'),vm=require('vm');const h=fs.readFileSync('docs/remix-surface-refactor-explainer.html','utf8');const s=[...h.matchAll(/<script>([\\s\\S]*?)<\\/script>/g)].map(m=>m[1]);for(const x of s)new vm.Script(x);console.log('scripts parse:',s.length)"
git add docs/remix-surface-refactor-explainer.html
git commit -m "docs: illustrate surface paint order and resolution"
```

Expected: `scripts parse:` followed by a positive integer.

---

### Task 4: Component Evidence and Maintainer Guidance

**Files:**
- Modify: `docs/remix-surface-refactor-explainer.html`
- Reference: component specs, widgets, and Fortal style files under `packages/remix/lib/src/components/`.

**Interfaces:**
- Consumes: `#components`, `#migration`, `#constraints`, and `#decision-tree`.
- Produces: `componentExamples`, `componentCoverage`, source-linked example
  panels, migration comparisons, constraints, test evidence, and decision tree.

- [ ] **Step 1: Add eight source-backed examples**

```javascript
const componentExamples = Object.freeze([
  ['Button',['effects'],'remixSurfaceFlexBox'],
  ['Card',['effects'],'remixSurfaceBox'],
  ['Switch',['trackEffects','thumbEffects'],'two nested remixSurfaceBox calls'],
  ['Slider',['trackEffects','rangeEffects','thumbEffects','thumbFocusEffects'],'role-specific remixSurfaceBox calls'],
  ['Progress',['trackEffects','indicatorEffects'],'two remixSurfaceBox calls'],
  ['Select',['trigger.effects','content.effects'],'remixSurfaceFlexBox + remixSurfaceBox'],
  ['Dialog, Popover, and Menu',['effects'],'helpers at overlay boundaries'],
  ['Checkbox and Radio',['effects'],'remixSurfaceBox']
]);
```

Give each example an anatomy SVG, effect slots, short current recipe excerpt,
resolved spec path, widget helper call, capability enabled, reason it is not
ordinary Mix decoration, and relative source links.

- [ ] **Step 2: Add the complete affected-family matrix**

```javascript
const componentCoverage = Object.freeze([
  ['Badge','effects'],['Button','effects'],['Callout','effects'],['Card','effects'],
  ['Checkbox','effects'],['Dialog','effects'],['IconButton','effects'],['Menu','effects'],
  ['Popover','effects'],['Radio','effects'],['TextField','effects'],
  ['Progress','trackEffects · indicatorEffects'],['Switch','trackEffects · thumbEffects'],
  ['Select','trigger.effects · content.effects'],
  ['Slider','trackEffects · rangeEffects · thumbEffects · thumbFocusEffects']
]);
```

- [ ] **Step 3: Add migration, constraints, tests, and decision tree**

Cover standard decoration moving into Mix, `surface`/`overlay` collapsing into
`effects.background`/`foreground`, outline moving to `BorderSideMix`, wrappers
becoming helper functions, and role-named compound fields. Include all design
constraints and relative links to the three central tests. End with these five
decisions:

```html
<li>Can Mix BoxDecoration express it? Put it in the component container spec.</li>
<li>Does it need ordered multi-gradients, inset shadows, blur, an offset outline, or foreground paint? Use effects.</li>
<li>Does the component have independently painted anatomy? Name one slot per role.</li>
<li>Does a transient state augment base effects? Merge and verify interpolation.</li>
<li>Can paint overflow? Verify custom paint bounds and any subtree blend.</li>
```

- [ ] **Step 4: Verify coverage and commit**

```bash
for name in Badge Button Callout Card Checkbox Dialog IconButton Menu Popover Radio TextField Progress Switch Select Slider; do rg -q "$name" docs/remix-surface-refactor-explainer.html || exit 1; done
for field in effects trackEffects indicatorEffects thumbEffects rangeEffects thumbFocusEffects; do rg -q "$field" docs/remix-surface-refactor-explainer.html || exit 1; done
git add docs/remix-surface-refactor-explainer.html
git commit -m "docs: add surface component evidence and guidance"
```

Expected: both loops exit silently with status 0.

---

### Task 5: Accuracy, Accessibility, and Browser Audit

**Files:**
- Modify if defects are found: `docs/remix-surface-refactor-explainer.html`
- Reference: all sources and tests listed above.

**Interfaces:**
- Consumes: the completed standalone document.
- Produces: a validated artifact with no external requests, browser errors,
  missing source symbols, inaccessible controls, or narrow-layout overflow.

- [ ] **Step 1: Run structural and dependency checks**

```bash
tidy -errors -quiet docs/remix-surface-refactor-explainer.html
if rg -n 'https?://|fetch\(|XMLHttpRequest|WebSocket' docs/remix-surface-refactor-explainer.html; then exit 1; fi
git diff --check
```

Expected: no output classified as an error.

- [ ] **Step 2: Re-audit current source names and slots**

```bash
rg -n 'final RemixSurfaceEffectsSpec\?' packages/remix/lib/src/components/*/*_spec.dart
rg -n 'remixSurface(Box|FlexBox)\(' packages/remix/lib/src/components --glob '*_widget.dart'
rg -n 'class RemixSurfaceEffectsSpec|class RemixSurfaceEffectsMix|class RemixSurfaceLayerSpec|class RemixSurfaceLayerMix|class RemixPaintShadow|class RemixLinearGradientMix|Widget remixSurface' packages/remix/lib/src/rendering/remix_surface.dart
```

Compare the output with the HTML inventory and correct any mismatch.

- [ ] **Step 3: Render desktop and mobile screenshots**

```bash
explainer_url="file://$PWD/docs/remix-surface-refactor-explainer.html"
profile_dir="$(mktemp -d)"
'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --headless --disable-gpu --no-first-run --user-data-dir="$profile_dir" --window-size=1440,1200 --screenshot=/tmp/remix-surface-desktop.png "$explainer_url"
'/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --headless --disable-gpu --no-first-run --user-data-dir="$profile_dir" --window-size=390,844 --screenshot=/tmp/remix-surface-mobile.png "$explainer_url"
```

Inspect both images for clipping, horizontal page overflow, overlap, and
illegible diagrams.

- [ ] **Step 4: Verify progressive enhancement and keyboard semantics**

Confirm tab order follows document order; selected buttons update
`aria-pressed`/`aria-selected`; live details announce politely; fallback type
definitions, paint order, examples, constraints, and decisions remain visible
without JavaScript; reduced-motion selection changes do not move.

- [ ] **Step 5: Run final checks and commit corrections**

```bash
git diff --check origin/main...
tidy -errors -quiet docs/remix-surface-refactor-explainer.html
git status --short
git add docs/remix-surface-refactor-explainer.html
git commit -m "docs: verify surface refactor explainer"
```

Expected: no whitespace or HTML errors; only intentional files appear before
the final commit.
