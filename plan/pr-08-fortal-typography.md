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
- Radix Text and Heading expose sizes 1-9, weights, align, truncate/wrap, color, and high contrast. Heading defaults to visual size 6 and semantic `h1`.
- Code adds solid/soft/outline/ghost variants and a code font stack. Kbd adds classic/soft variants and em-relative geometry. Link adds auto/always/hover/none underline behavior.
- Flutter provides explicit `header`/`headingLevel`, `keyboardKey`, and `link`/`linkUrl` semantics, but no code role, CSS `as` element, leading-trim layout, or pretty/balanced line wrapping.
- `NakedButton` is appropriate only for an actionable Link. It already owns pointer, keyboard, focus, feedback, and widget-state behavior.

Official references: [Text](https://www.radix-ui.com/themes/docs/components/text), [Heading](https://www.radix-ui.com/themes/docs/components/heading), [Code](https://www.radix-ui.com/themes/docs/components/code), [Kbd](https://www.radix-ui.com/themes/docs/components/kbd), [Link](https://www.radix-ui.com/themes/docs/components/link), plus Flutter [`headingLevel`](https://api.flutter.dev/flutter/widgets/SemanticsProperties/headingLevel.html) and [`keyboardKey`](https://api.flutter.dev/flutter/widgets/SemanticsProperties/keyboardKey.html).

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

There are deliberately no `@MixableSpec`, `@MixWidget`, `.g.dart`, or Remix base types. Plain text widgets accept `TextStyler` overrides; boxed inline widgets accept a `BoxStyler` container override plus `TextStyler` text override. Merge caller styles after the Fortal recipe.

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
    this.size = FortalTextSize.size3,
    this.weight = FortalTextWeight.regular,
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
    this.size = FortalTextSize.size3,
    this.variant = FortalCodeVariant.soft,
    this.weight = FortalTextWeight.regular,
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
    this.size = FortalTextSize.size3,
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
    this.size = FortalTextSize.size3,
    this.weight = FortalTextWeight.regular,
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

All string content and semantic labels must be nonempty. `color` is `FortalAccentColor?`. A non-null color creates a nested `FortalScope(accent: color, hasBackground: false)` so all accent tokens resolve coherently; never translate enum values into copied color literals. A null color uses the current scope.

Text/Heading without an explicit color use neutral `gray12`; with a color they use `accentA11` or `accent12` at high contrast. Code and Link use the current/local accent by design. Kbd stays neutral.

## Visual mapping

### Text and Heading

- Text uses the selected existing text token and weight token directly.
- Heading uses the selected token's font size/letter spacing and Radix heading line-height ratios: 16, 18, 22, 24, 26, 30, 36, 40, and 60 px at scale 1. Derive the `TextStyle.height` ratio so scaling remains inherited from the selected token.
- Heading defaults bold/size6 independently of semantic level; changing `headingLevel` must not silently change visual size.
- `style` merges last but must not remove the semantic wrapper.

### Code

Resolve the chosen base text token inside the consuming `BuildContext` and derive the pinned CSS em formulas:

- monospaced fallback stack beginning with Menlo/Consolas and ending in `monospace`/emoji fallbacks;
- ghost font-size factor 0.95; decorated variants 0.95 × 0.95;
- preserve the base absolute line height; add -0.007 em letter spacing;
- decorated padding 0.10 em vertical and 0.25 em horizontal; ghost has zero padding;
- radius `(0.5 px + 0.2 em) × radiusFactor`, deriving the factor from resolved `radius1` and active scaling rather than duplicating the Fortal radius enum table.

Variant roles:

- solid: `accentA9`/accent contrast; high contrast `accent12`/`accent1`;
- soft: `accentA3` and `accentA11`; high contrast text `accent12`;
- outline: inset accentA8 ring and accentA11; high contrast accentA7 + grayA11 rings and accent12;
- ghost: transparent and accentA11/accent12.

Code remains inert, so omit Radix hover styles that apply only when Code itself is an HTML link/button. There is no Flutter code semantics role; expose ordinary text semantics once.

### Kbd

Derive geometry from the resolved base font size: 0.8 em type scale, 1.7 line-height, 1.75 em minimum width, 0.5 em horizontal padding, 0.05 em bottom padding, -0.1 em word spacing, and `.35 em × radiusFactor` radius. Center the single-line label and prevent wrapping.

- classic uses gray1 and the pinned six-layer light/dark em-relative shadow stack, resolving all colors from existing gray/white/black tokens;
- soft uses grayA3 with no classic stack;
- do not add hover/pressed/focus states to inert Kbd; those upstream selectors apply only when nested as an actionable element.

If Flutter's shadow/raster model cannot express a layer exactly, record the measured tolerance rather than dropping layers silently.

### Link

Base foreground is accentA11 or accent12 at high contrast. Decoration rules:

- always: underline at rest/hover;
- hover: underline only while hovered;
- auto: hover-only normally, always at high contrast;
- none: never underline;
- focused actionable links suppress underline and draw a 2 px `focus8` foreground ring with 2 px offset so layout does not move.

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

## Work breakdown

- [ ] Task 1: Lock public API, defaults, named constructors, and exact semantics with failing tests.
  - Files: new `packages/remix/test/components/typography/typography_widget_test.dart`, both public-API tests.
  - Cover all constructors/enums, heading levels, keyboard-key semantics, inert/actionable/disabled Link trees, URL metadata, pointer/keyboard callbacks, focus-node ownership, and exclusions.

- [ ] Task 2: Add failing style-resolution tests for all sizes/variants/scopes.
  - Files: new `typography_style_test.dart` plus five focused per-family parity test files.
  - Cover text/heading metrics, code/kbd em formulas, every variant/highContrast role, link underline states, light/dark, local accent override, Fortal scaling/radius, and caller override merge order.

- [ ] Task 3: Implement the hand-written typography module.
  - Files: the eight library/part files listed above; `packages/remix/lib/remix.dart`.
  - Reuse shared resolvers and tokens; add no generated/spec files.
  - Acceptance: five widgets render under `FortalScope`, fail clearly through normal missing-token behavior outside it, and all focused tests pass.

- Checkpoint: run the typography test directory and both public-API tests; inspect semantics dumps for every widget before parity-ledger changes.

- [ ] Task 4: Advance the parity contract from 24/3 to 29/3.
  - Files: `manifest.json`, `coverage_evidence.json`, `tool/fortal_parity/check.dart`, five parity tests, reference README.
  - Add mapped IDs `text`, `heading`, `code`, `kbd`, and `link`; set exact total 32 and success text 29 mapped/3 extensions.
  - Map every typography ID to `components/typography/fortal_<id>_styles.dart`; concatenate `typography_shared.dart` for shared enum inspection without contaminating per-family highContrast detection.
  - Teach size-enum validation that all five intentionally use `FortalTextSize`.
  - Teach named-variant validation to include sibling `typography_widget.dart`, then require all Code/Kbd constructors.
  - Add exact source files/selectors, upstream props/defaults/states, coverage, visual mappings, deferred capabilities, and approximations.

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

- All size/weight/align/wrap/variant/underline enum domains and defaults compile.
- Code/Kbd named constructors pin exactly one matching variant.
- Local `color` changes only the nested typography scope and does not paint a background or leak to siblings.
- Caller `TextStyler`/`BoxStyler` merges after recipe values while semantic wrappers remain intact.

### Metrics and variants

- Resolve all nine base sizes and heading line heights at 90%, 100%, and 110% scaling.
- Assert Code adjusted font size, absolute line height, family fallback, padding/radius, rings/fills/foregrounds for four variants and high contrast.
- Assert Kbd type/min-width/padding/radius and every classic shadow layer in light/dark; soft has no classic shadow.
- Assert Link underline in idle/hover/focus/highContrast and ring geometry without size movement.
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
- Leading trim is deferred; normal Flutter font metrics remain. State the pixel tolerance used in screenshots.
- `pretty` and `balance` map to normal wrapping; `nowrap`/truncate map directly.
- Responsive values map to application rebuilds rather than a prop-object DSL.
- Code uses the closest installed platform font from the pinned fallback list; glyph widths may differ when Menlo/Consolas are unavailable.
- Kbd uses Flutter box-shadow rasterization; retain all layers and document a small pixel/color tolerance.
- Link URL navigation is caller-owned; `linkUrl` is semantics metadata only.

## Acceptance criteria

- [ ] Five Fortal-only public widgets and shared enums are exported with the specified defaults.
- [ ] No fictional Remix typography base/spec/codegen layer exists.
- [ ] Every visual value derives from existing Fortal tokens or a localized pinned CSS em formula resolved from those tokens.
- [ ] Heading, Kbd, and Link semantics are exact, single-node, and behaviorally tested; Code has no invented role.
- [ ] Link delegates all interaction to Naked only when callback-backed and never launches URLs internally.
- [ ] All size/weight/variant/underline/accent/highContrast states are tested.
- [ ] Manifest/evidence/checker/fixture agree on 29 mapped + 3 extensions = 32 families.
- [ ] Docs/playground/README and light/dark Radix comparisons are complete.

## Risks and mitigations

- Risk: one shared typography file makes parity source detection ambiguous. Mitigation: separate family style parts and explicitly map/concatenate only the shared enum helper.
- Risk: `NakedButton` contributes button semantics under Link. Mitigation: exclude Naked semantics and replace them with one outer link node; exact-tree tests block duplication.
- Risk: platform fonts/shadows prevent byte-identical web pixels. Mitigation: preserve the fallback/layer formulas, test computed roles/metrics, and record a measured tolerance.
- Risk: caller style overrides remove accessibility cues. Mitigation: semantics never live in the styler; docs warn against suppressing focused-link contrast and tests keep wrapper behavior.
- Risk: PR 7 parity changes conflict. Mitigation: rebase after PR 7 and update cumulative 29/3/32 counts once.

## Validation and rollout

Run typography/public API tests, regenerate the Chromium fixture, run `fortal:parity:check`, then every command in `01-conventions.md`. No feature flag or data migration is required. Rollback must revert the library/export, tests/docs, five manifest/evidence owners, checker set/count/source maps, and five fixture probes together.
