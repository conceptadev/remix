# Plan: Add Fortal typography components

> Add token-backed Text, Heading, Code, Kbd, and Link widgets with exact Flutter semantics and honest platform approximations, without inventing tokenless Remix base components.

## PR contract

- Title: `feat(fortal): add typography components`
- Functional dependency: none on PR 7's component code.
- Execution baseline: merge/rebase after PR 7 because both change the parity family set, evidence, checker, and Chromium fixture.
- Compatibility: additive Fortal-only widgets/enums; no migration.
- Primary outcome: `FortalText`, `FortalHeading`, `FortalCode`, `FortalKbd`, and `FortalLink` cover the pinned Radix typography families using `FortalTokens.text1`-`text9` and native Flutter semantics.
- Out of scope: tokenless `RemixText` equivalents, rich spans/Markdown, automatic URL launching, selectable text, CSS element polymorphism, exact CSS leading trim, and new font assets.

## Context

- Fortal already resolves the complete nine-step Radix text scale and four weights in `fortal_theme.dart`; there is no Remix typography abstraction to reuse.
- These widgets are meaningful only inside Fortal token scope. A parallel Remix spec/widget/codegen layer would add names without a design-independent contract.
- Radix Text and Heading expose sizes 1-9, weights, align, truncate/wrap,
  color, and high contrast. Text inherits size/weight when omitted; Heading
  defaults to visual size 6, bold weight, and semantic `h1`.
- Code adds solid/soft/outline/ghost variants and a code font stack. Kbd adds
  classic/soft variants and em-relative geometry. Link adds
  auto/always/hover/none underline behavior. Code, Kbd, and Link inherit
  surrounding typography when size/weight props are omitted; a fixed size3
  default would be observably wrong when nested.
- Flutter provides explicit `header`/`headingLevel`, `keyboardKey`, and `link`/`linkUrl` semantics, but no code role, CSS `as` element, leading-trim layout, or pretty/balanced line wrapping.
- `NakedButton` is appropriate only for an actionable Link. It already owns pointer, keyboard, focus, feedback, and widget-state behavior.

Official references: [Text](https://www.radix-ui.com/themes/docs/components/text), [Heading](https://www.radix-ui.com/themes/docs/components/heading), [Code](https://www.radix-ui.com/themes/docs/components/code), [Kbd](https://www.radix-ui.com/themes/docs/components/kbd), [Link](https://www.radix-ui.com/themes/docs/components/link), plus Flutter [`headingLevel`](https://api.flutter.dev/flutter/widgets/SemanticsProperties/headingLevel.html) and [`keyboardKey`](https://api.flutter.dev/flutter/widgets/SemanticsProperties/keyboardKey.html). Feature-comparison captures: `radix-reference/text.png`, `heading.png`, `code.png`, `kbd.png`, and `link.png`, with expected deltas indexed in `radix-reference/README.md`.

## Module architecture

Create one hand-written library, exported by `remix.dart`:

```text
packages/remix/lib/src/components/typography/
  typography.dart
  typography_shared.dart
  typography_widget.dart
  fortal_text_styles.dart
  fortal_heading_styles.dart
  fortal_code_styles.dart
  fortal_kbd_styles.dart
  fortal_link_styles.dart
```

The five style files are separate so the parity checker can inspect each family's `highContrast` and variant surface independently. Shared enums, text-token selection, wrap/truncate policy, accent scoping, and resolved em helpers live once in `typography_shared.dart`. All public widgets live in `typography_widget.dart`.

There are deliberately no `@MixableSpec`, `@MixWidget`, `.g.dart`, or Remix base types. Plain text widgets accept `TextStyler` overrides; boxed inline widgets accept a `BoxStyler` container override plus `TextStyler` text override. Merge caller styles after the Fortal recipe. Internally, boxed widgets resolve the container styler and render through `RemixBoxWithEffects` with a separately derived `RemixBoxEffectsSpec`; `BoxStyler`/`foregroundDecoration` alone cannot represent Code inset rings, Kbd's six-layer stack, or Link's offset focus outline.

Put a library/class comment explaining this exception to normal component anatomy: typography is token-defined and behavior-light, so a generated wrapper over a fictional Remix base would be duplication.

## Shared public types

```dart
enum FortalTextSize {
  size1, size2, size3, size4, size5, size6, size7, size8, size9,
}

enum FortalTextWeight { light, regular, medium, bold }
enum FortalTextAlign { left, center, right }
enum FortalTextWrap { wrap, nowrap, pretty, balance }
enum FortalCodeVariant { solid, soft, outline, ghost }
enum FortalKbdVariant { classic, soft }
enum FortalLinkUnderline { auto, always, hover, none }
```

Map sizes by exhaustive switch to `FortalTokens.text1` through `text9`; never use enum index arithmetic for public token selection. Map weights to the four existing font-weight tokens. Map align physically (left/center/right) to match the upstream names.

Wrap policy:

- `wrap`: normal Flutter wrapping.
- `nowrap`: `softWrap: false`; document that overflow follows the available constraints.
- `pretty` and `balance`: normal wrapping in v1 with named manifest approximations because Flutter has no native equivalent.
- `truncate: true` takes precedence over `wrap`, forcing one line, no soft wrap, and ellipsis.

Responsive Radix props map to ordinary Flutter rebuilds at breakpoints; no responsive-value DSL is added.

## Widget APIs

The exact public constructor surface is:

```dart
class FortalText extends StatelessWidget {
  const FortalText({
    super.key,
    required this.text,
    this.size,
    this.weight,
    this.align,
    this.wrap = FortalTextWrap.wrap,
    this.truncate = false,
    this.color,
    this.highContrast = false,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const TextStyler.create(),
  });
}

class FortalHeading extends StatelessWidget {
  const FortalHeading({
    super.key,
    required this.text,
    this.headingLevel = 1,
    this.size = FortalTextSize.size6,
    this.weight = FortalTextWeight.bold,
    this.align,
    this.wrap = FortalTextWrap.wrap,
    this.truncate = false,
    this.color,
    this.highContrast = false,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.style = const TextStyler.create(),
  }) : assert(headingLevel >= 1 && headingLevel <= 6);
}

class FortalCode extends StatelessWidget {
  const FortalCode({
    super.key,
    required this.text,
    this.size,
    this.variant = FortalCodeVariant.soft,
    this.weight,
    this.wrap = FortalTextWrap.wrap,
    this.truncate = false,
    this.color,
    this.highContrast = false,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.containerStyle = const BoxStyler.create(),
    this.textStyle = const TextStyler.create(),
  });
  // Also const .solid/.soft/.outline/.ghost constructors.
}

class FortalKbd extends StatelessWidget {
  const FortalKbd({
    super.key,
    required this.text,
    this.size,
    this.variant = FortalKbdVariant.classic,
    this.semanticLabel,
    this.excludeSemantics = false,
    this.containerStyle = const BoxStyler.create(),
    this.textStyle = const TextStyler.create(),
  });
  // Also const .classic/.soft constructors.
}

class FortalLink extends StatelessWidget {
  const FortalLink({
    super.key,
    required this.text,
    this.size,
    this.weight,
    this.underline = FortalLinkUnderline.auto,
    this.wrap = FortalTextWrap.wrap,
    this.truncate = false,
    this.color,
    this.highContrast = false,
    this.onPressed,
    this.enabled = true,
    this.linkUrl,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.containerStyle = const BoxStyler.create(),
    this.textStyle = const TextStyler.create(),
  }) : assert(linkUrl == null || onPressed != null);
}
```

`size` is `FortalTextSize?` on all five widgets; `weight` is
`FortalTextWeight?` where exposed. Text, Code, and Link use null size/weight to
derive from ambient `DefaultTextStyle`; Kbd uses null size to derive its em base
from the ambient font size but always applies its pinned normal weight and 1.7
line-height. Heading retains explicit defaults of size6/bold. Explicit enum
values select Fortal tokens exhaustively. Standalone examples that want the
current root appearance pass size3/regular explicitly; the API does not convert
that common case into a false inheritance default.

All string content and semantic labels must be nonempty. `linkUrl` is `Uri?`,
not `String?`. `color` is `FortalAccentColor?`. A non-null color creates a
nested `FortalScope(accent: color, hasBackground: false)` so all accent tokens
resolve coherently; never translate enum values into copied color literals. A
null color uses the current scope.

Text/Heading without an explicit color preserve the ambient
`DefaultTextStyle.color`; a non-null color uses `accentA11`, or `accent12` at
high contrast, from the nested accent scope. Code solid/soft/outline and Link
use the current/local accent roles by design. Ghost Code with no explicit color
inherits ambient text color; its accentA11/accent12 text applies only when a
color is supplied. Kbd stays neutral.

## Visual mapping

### Text and Heading

- Text uses the selected existing text/weight tokens when supplied; otherwise
  it preserves the ambient `DefaultTextStyle` metrics/weight/color. Heading
  preserves ambient color when its color is null. Caller style still merges
  last.
- Heading uses the selected token's font size/letter spacing and Radix heading line-height ratios: 16, 18, 22, 24, 26, 30, 36, 40, and 60 px at scale 1. Derive the `TextStyle.height` ratio so scaling remains inherited from the selected token.
- Heading defaults bold/size6 independently of semantic level; changing `headingLevel` must not silently change visual size.
- `style` merges last but must not remove the semantic wrapper.

### Code

Resolve the explicit text token or inherited ambient metrics inside the consuming `BuildContext`, then derive the pinned CSS em formulas:

- monospaced fallback stack beginning with Menlo/Consolas and ending in `monospace`/emoji fallbacks;
- when `size` is explicit, resolve that text token as the base; otherwise use
  the ambient font size/absolute line height;
- ghost font-size factor 0.95; decorated variants 0.95 × 0.95;
- explicit sizes preserve the selected token's absolute line height; the
  unsized path uses the pinned unitless 1.25 line-height. Add -0.007 em to the
  selected or ambient letter spacing;
- decorated padding 0.10 em vertical and 0.25 em horizontal; ghost has zero padding;
- radius `(0.5 px + 0.2 em) × radiusFactor`, deriving the factor from resolved `radius1` and active scaling rather than duplicating the Fortal radius enum table.

Variant roles:

- solid: `accentA9`/accent contrast; high contrast `accent12`/`accent1`;
- soft: `accentA3` and `accentA11`; high contrast text `accent12`;
- outline: an inset `max(1px, 0.033em)` accentA8 ring and accentA11 text;
  high contrast preserves two inset layers at that width (accentA7 + grayA11)
  and uses accent12 text;
- ghost: transparent; preserve ambient text color when `color == null`, or use
  accentA11/accent12 for an explicit local color.

Render outline/inset layers with `RemixBoxEffectsSpec`, not a border or
foreground-decoration approximation. Code remains inert, so omit Radix hover
styles that apply only when Code itself is an HTML link/button. There is no
Flutter code semantics role; expose ordinary text semantics once.

### Kbd

When `size` is explicit, derive geometry from the resolved token font size and
use the pinned 0.8 type-scale factor. When `size` is null, inherit the ambient
base and use the upstream unsized 0.75 em factor. In both paths use 1.7
line-height, 1.75 em minimum width, 0.5 em horizontal padding, 0.05 em bottom
padding, -0.1 em word spacing, a -0.03 em visual top offset, and
`.35 em × radiusFactor` radius. Force normal weight, center the single-line
label, and prevent wrapping.

- classic uses gray1 and the pinned six-layer light/dark em-relative shadow
  stack, resolving all colors from existing gray/white/black tokens and
  rendering every layer through `RemixBoxEffectsSpec`;
- soft uses grayA3 with no classic stack;
- do not add hover/pressed/focus states to inert Kbd; those upstream selectors apply only when nested as an actionable element.

If Flutter's shadow/raster model cannot express a layer exactly, record the measured tolerance rather than dropping layers silently.

### Link

Size and weight inherit from `DefaultTextStyle` when null and select explicit
Fortal tokens otherwise. Base foreground is accentA11 or accent12 at high
contrast. Decoration rules:

- always: underline at rest/hover;
- hover: underline only while hovered;
- auto: hover-only normally, always at high contrast;
- none: never underline;
- focused actionable links suppress underline and draw a 2 px `focus8` outline
  with 2 px offset and radius `0.07em × radiusFactor`, composed through
  `RemixBoxEffectsSpec` so layout does not move.

Flutter `TextStyle` can control underline style/thickness but not CSS
`text-underline-offset`. Use the closest native underline and record the pinned
offset/thickness difference as a measured visual approximation; do not add a
custom painter that would compromise wrapping, selection geometry, or text
semantics for this v1 surface.

When `onPressed == null`, render inert StyledText: no NakedButton, link role/action, focus stop, or link cursor. When a callback exists, use `NakedButton(excludeSemantics: true)` for pointer/keyboard/focus/widget states and one outer `Semantics` node with `link: true`, `enabled`, optional `linkUrl`, label/hint, and `onTap` only when enabled. A disabled callback-backed link keeps disabled link identity but no action.

Never launch `linkUrl`; it is assistive metadata. The caller owns navigation in `onPressed`.

## Semantics contract

- Text/Code: ordinary text semantics once, using `semanticLabel` only as a replacement label.
- Heading: one replacement semantics node with `header: true`, `headingLevel: 1..6`, and label `semanticLabel ?? text`; exclude visible child semantics beneath it.
- Kbd: one replacement node with `keyboardKey: true` and label `semanticLabel ?? text`; no tap role/action.
- Actionable Link: one link node, optional URL metadata, correct enabled/focused/tap state, and no nested button node.
- Inert Link: ordinary text only and no fake link metadata/action.
- `excludeSemantics: true` removes the entire corresponding node/subtree.

Use exact `matchesSemantics` expectations with all unrelated flags false where stable. Verify at 1x and high text scale; visual scaling must not change roles/labels.
Do not set Flutter 3.44's deprecated `focusable` semantics property in new
code. The actual `Focus`/NakedButton path contributes focusability; assert the
observable focused state and actions instead of manufacturing a duplicate
flag.

## Work breakdown

- [ ] Task 1: Lock public API, defaults, named constructors, and exact semantics with failing tests.
  - Files: new `packages/remix/test/components/typography/typography_widget_test.dart`, both public-API tests.
  - Cover nullable inherited vs explicit size/weight contracts, all named
    constructors/enums, heading levels, keyboard-key semantics,
    inert/actionable/disabled Link trees, `Uri` URL metadata,
    pointer/keyboard callbacks, focus-node ownership, absence of deprecated
    explicit focusable semantics, and exclusions.

- [ ] Task 2: Add failing style-resolution tests for all sizes/variants/scopes.
  - Files: new `typography_style_test.dart` plus five focused per-family parity test files.
  - Cover inherited and explicit text/heading metrics, Code/Kbd unsized versus
    sized em formulas, every variant/highContrast role, complete effect stacks,
    Link underline/focus radius states, light/dark, local accent override,
    Fortal scaling/radius, and caller override merge order.

- [ ] Task 3: Implement the hand-written typography module.
  - Files: the eight library/part files listed above; `packages/remix/lib/remix.dart`.
  - Reuse shared resolvers and tokens; add no generated/spec files.
  - Acceptance: five widgets render under `FortalScope`, fail clearly through normal missing-token behavior outside it, and all focused tests pass.

- Checkpoint: run the typography test directory and both public-API tests; inspect semantics dumps for every widget before parity-ledger changes.

- [ ] Task 4: Advance the parity contract from 24/3 to 29/3.
  - Files: `manifest.json`, `manifest.schema.json`, `coverage_evidence.json`,
    `tool/fortal_parity/check.dart`, five parity tests, reference README.
  - Add mapped IDs `text`, `heading`, `code`, `kbd`, and `link`; raise the
    schema's exact family min/max from 27 to 32 and set checker total/success
    text to 29 mapped/3 extensions.
  - Map every typography ID to `components/typography/fortal_<id>_styles.dart`; concatenate `typography_shared.dart` for shared enum inspection without contaminating per-family highContrast detection.
  - Teach size-enum validation that all five intentionally use `FortalTextSize`.
  - Teach named-variant validation to include sibling `typography_widget.dart`, then require all Code/Kbd constructors.
  - Replace the recipe-function-only highContrast detector for these five
    hand-written families with family-specific inspection of the matching
    `FortalText`/`FortalHeading`/`FortalCode`/`FortalKbd`/`FortalLink`
    constructor. It must detect highContrast on Text, Heading, Code, and Link,
    reject it for Kbd, and must not let one sibling class satisfy another
    family's manifest record.
  - Add exact source files/selectors, upstream props/defaults/states (including
    inherited/omitted size and weight), coverage, visual mappings, deferred
    capabilities, and approximations.
  - Preserve and revalidate PR 7's `checkbox_group`
    `unmappedUpstreamFamilies` record; it remains outside the mapped/extension
    counts and probe set.

- [ ] Task 5: Add five Chromium probes and regenerate evidence.
  - Files: fixture HTML/generator, computed styles JSON, 1440x1280 image.
  - Probe representative Text size/weight, Heading size/line-height, all Code/Kbd variant-critical properties, and actionable Link color/underline/focus baseline.
  - Keep the PR 7 five-column layout; 29 mapped families should fit in six rows at the established compact cell height.
  - Acceptance: computed probe IDs exactly equal the 29 mapped set.

- Checkpoint: `fvm dart run melos run fortal:parity:check` passes with 29/3 and no undocumented approximation.

- [ ] Task 6: Add docs, playground, README inventories, and accessibility examples.
  - Files: `docs/components/typography.mdx`, root `docs.json`, `packages/playground/lib/registry/entries/typography_entry.dart`, registry, root and package READMEs kept identical.
  - Show the nine-step scale, heading level independent from size, every Code/Kbd variant, link underline/action states, local accent, high contrast, wrapping/truncation, and screen-reader guidance.

- [ ] Task 7: Capture visual comparisons and complete the shared gate.
  - Create light/dark playground composites and matching Radix Text/Heading/Code/Kbd/Link reference captures side by side in the PR description.
  - Captions name font fallback/shadow raster differences, wrap/trim/as limitations, and caller-owned navigation.

## Test strategy

### Public/default behavior

- All size/weight/align/wrap/variant/underline enum domains compile; nullable
  Text/Code/Kbd/Link size/weight inheritance and Heading's size6/bold defaults
  are explicit.
- Code/Kbd named constructors pin exactly one matching variant.
- A null Text/Heading color and null-color ghost Code preserve ambient text
  color. A local explicit `color` changes only the nested typography scope and
  does not paint a background or leak to siblings.
- Caller `TextStyler`/`BoxStyler` merges after recipe values while semantic wrappers remain intact.

### Metrics and variants

- Resolve all nine base sizes and heading line heights at 90%, 100%, and 110% scaling.
- Assert Code inherited/explicit adjusted font size, unsized 1.25 versus
  explicit token line-height, family fallback, padding/radius, and every
  effects-backed ring/fill/foreground for four variants and high contrast.
- Assert Kbd's unsized 0.75 em and explicit-size 0.8 token factors,
  normal weight, 1.7 line-height, -0.03 em top offset,
  min-width/padding/radius, and every classic effect layer in light/dark; soft
  has no classic shadow.
- Assert Link inherited/explicit metrics, native underline in
  idle/hover/focus/highContrast, the documented underline-offset tolerance, and
  effect outline/radius geometry without size movement.
- `truncate` wins over every wrap enum; nowrap/pretty/balance mappings are explicit.

### Interaction and semantics

- Pointer and Space/Enter activate an enabled callback-backed Link exactly once.
- Disabled Link cannot focus/activate and exposes no tap action; caller focus node survives disposal.
- Inert Link has no NakedButton, link role, link URL, action, or focus stop.
- Heading level flags and Kbd keyboard-key flag are exact and nonduplicated.
- Code remains ordinary text; all exclusion and replacement-label paths work.

### Parity and manual

- Each family owns real evidence cases for every manifest enum/state.
- Live Chromium probes preserve Radix 3.3 integrity and all 29 mapped owners.
- Screen-reader review covers heading navigation, keyboard-key pronunciation, actionable/inert links, and no duplicate labels.
- Visual review covers light/dark, two accents, high contrast, large text, and platform font fallback.

## Manifest approximations to record

- Text/Heading/Link CSS `as`/`asChild` have no Flutter DOM equivalent; dedicated Flutter widgets/semantics are fixed.
- Code/Kbd/Link are standalone widgets rather than inline `TextSpan` children;
  mixed-run baseline/wrapping through `WidgetSpan` is deferred with rich-text
  composition.
- Leading trim is deferred; normal Flutter font metrics remain. State the pixel tolerance used in screenshots.
- `pretty` and `balance` map to normal wrapping; `nowrap`/truncate map directly.
- Responsive values map to application rebuilds rather than a prop-object DSL.
- Code uses the closest installed platform font from the pinned fallback list; glyph widths may differ when Menlo/Consolas are unavailable.
- Kbd uses Flutter box-shadow rasterization; retain all layers and document a small pixel/color tolerance.
- Link URL navigation is caller-owned; `linkUrl` is semantics metadata only.
- Flutter native underline placement approximates Radix's CSS underline offset
  (and any unrepresentable thickness detail); record the measured tolerance.

## Acceptance criteria

- [ ] Five Fortal-only public widgets and shared enums are exported with the specified defaults.
- [ ] No fictional Remix typography base/spec/codegen layer exists.
- [ ] Every visual value derives from existing Fortal tokens or a localized pinned CSS em formula resolved from those tokens.
- [ ] Omitted Text/Code/Kbd/Link typography inherits ambient metrics; null-color
  Text/Heading and ghost Code inherit ambient color; explicit sizes use Fortal
  tokens, including Kbd's distinct 0.75/0.8 factors.
- [ ] Code inset rings, all six Kbd classic layers, and Link's offset focus outline/radius render through Remix effects rather than flattened Box decorations.
- [ ] Heading, Kbd, and Link semantics are exact, single-node, and behaviorally tested; Code has no invented role.
- [ ] Link delegates all interaction to Naked only when callback-backed and never launches URLs internally.
- [ ] All size/weight/variant/underline/accent/highContrast states are tested.
- [ ] Manifest/evidence/checker/fixture agree on 29 mapped + 3 extensions = 32 families.
- [ ] Docs/playground/README and light/dark Radix comparisons are complete.

## Risks and mitigations

- Risk: shared typography files make parity source/prop detection ambiguous.
  Mitigation: separate family style parts, concatenate only the shared enum
  helper, and make widget-constructor highContrast inspection family-specific
  with positive and negative checker tests.
- Risk: `NakedButton` contributes button semantics under Link. Mitigation: exclude Naked semantics and replace them with one outer link node; exact-tree tests block duplication.
- Risk: platform fonts/shadows prevent byte-identical web pixels. Mitigation: preserve the fallback/layer formulas, test computed roles/metrics, and record a measured tolerance.
- Risk: caller style overrides remove accessibility cues. Mitigation: semantics never live in the styler; docs warn against suppressing focused-link contrast and tests keep wrapper behavior.
- Risk: a fixed standalone typography default looks correct in isolation but
  breaks nested inheritance. Mitigation: keep nullable inherited defaults for
  Text/Code/Kbd/Link and test nested `DefaultTextStyle` plus explicit token
  selection separately.
- Risk: native underline placement cannot match CSS offset exactly. Mitigation:
  use native decoration for correct wrapping/semantics, measure and record the
  visual tolerance, and defer a painter until a demonstrated requirement
  justifies it.
- Risk: PR 7 parity changes conflict. Mitigation: rebase after PR 7 and update cumulative 29/3/32 counts once.

## Validation and rollout

Run typography/public API tests, regenerate the Chromium fixture, run
`fortal:parity:check`, then every command in `01-conventions.md`. No feature
flag or data migration is required. Rollback must revert the library/export,
tests/docs, manifest and its exact-count schema, five evidence owners, checker
set/count/source maps, and five fixture probes together.
