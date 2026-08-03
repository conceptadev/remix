# Plan: Add Fortal recipes for the Phase 1 components

> Theme Skeleton, SegmentedControl, TextArea, and DataList from the pinned Radix 3.3 source; finish menu indicator/trailing geometry; audit the intentionally unmapped CheckboxGroup visual family; and advance the executable parity ledger atomically.

## PR contract

- Title: `feat(fortal): add recipes for new components`
- Depends on: PRs 1-6 merged.
- Compatibility: additive generated wrappers/enums/tokens plus internal TextField
  recipe refactoring and a disclosed Fortal TextField soft-variant parity
  correction; no migration.
- Primary outcome: four new mapped Fortal families, exact menu item
  indicator color/size/gutter and submenu-trailing geometry, and a checker-enforced audit of CheckboxGroup's
  supported composition and intentionally unmapped visual anatomy.
- Out of scope: a styled `FortalCheckboxGroup`, typography (PR 8), SegmentedControl sliding-indicator behavior, browser TextArea resizing, DataList's compositional child API/responsive prop DSL/leading trim, and unrelated component gaps.

## Context

- Fortal recipes are parts of their Remix component libraries and use `@MixWidget(target: Remix<Name>.new)` to generate `Fortal*` wrappers in the component `.g.dart`.
- The current parity contract has 20 mapped Radix families plus three Fortal extensions. This PR adds `skeleton`, `segmented_control`, `text_area`, and `data_list`: 24 mapped, three extensions, 27 total.
- `packages/remix/tool/fortal_parity/check.dart` hard-codes family sets, exact counts, style-source paths, evidence owners, computed-style probe ownership, and success text. Updating only the manifest will fail by design.
- TextArea intentionally shares `TextFieldStyler` and its visual-state helpers. Its Fortal source should be `components/textfield/fortal_textarea_styles.dart`, registered as a part of `textfield.dart` and special-cased in the parity source map.
- Remix CheckboxGroup is a nonvisual, layout-transparent coordinator and its
  options accept `CheckboxStyler`, so `fortalCheckboxStyle(...)` supplies
  checkbox visuals without another wrapper/spec. Pinned Radix CheckboxGroup
  nevertheless owns a column gap, optional label-row gap, and propagation of
  size/variant/color/highContrast. This PR records that family in a
  schema/checker-validated `unmappedUpstreamFamilies` inventory instead of
  silently calling the composition mapped parity.
- PR 1 leaves one explicit temporary menu-indicator visual approximation. This PR closes and removes it.

Reference authority is the pinned `@radix-ui/themes@3.3.0` source declared in `reference/radix_themes_3_3_0/manifest.json`; the live docs are navigation aids: [Skeleton](https://www.radix-ui.com/themes/docs/components/skeleton), [Checkbox Group](https://www.radix-ui.com/themes/docs/components/checkbox-group), [Segmented Control](https://www.radix-ui.com/themes/docs/components/segmented-control), [Text Area](https://www.radix-ui.com/themes/docs/components/text-area), and [Data List](https://www.radix-ui.com/themes/docs/components/data-list). Feature-comparison captures for all six touched families (`skeleton`, `segmented-control`, `text-area`, `data-list`, `dropdown-menu`, `checkbox-group`) are in `radix-reference/` with expected deltas indexed in `radix-reference/README.md`.

## Generated public surface

Add these recipe APIs and generated wrappers:

```dart
@MixWidget(target: RemixSkeleton.new)
SkeletonStyler fortalSkeletonStyle();

enum FortalSegmentedControlSize { size1, size2, size3 }
enum FortalSegmentedControlVariant { surface, classic }

@MixWidget(target: RemixSegmentedControl.new)
SegmentedControlStyler fortalSegmentedControlStyle({
  FortalSegmentedControlVariant variant = .surface,
  FortalSegmentedControlSize size = .size2,
});

enum FortalTextAreaSize { size1, size2, size3 }
enum FortalTextAreaVariant { classic, surface, soft }

@MixWidget(target: RemixTextArea.new)
TextFieldStyler fortalTextAreaStyle({
  FortalTextAreaVariant variant = .surface,
  FortalTextAreaSize size = .size2,
});

enum FortalDataListSize { size1, size2, size3 }

@MixWidget(target: RemixDataList.new)
DataListStyler fortalDataListStyle({
  FortalDataListSize size = .size2,
  bool highContrast = false,
});
```

Generated expectations:

- `FortalSegmentedControl<T>` has `.surface` and `.classic` named constructors and preserves generic inference.
- `FortalTextArea` has `.classic`, `.surface`, and `.soft` named constructors and forwards the full facade API.
- Skeleton and DataList have no variant named constructors; their unnamed constructors expose recipe arguments where applicable.
- Radius and color remain `FortalScope` concerns, consistent with existing wrappers. Do not add literal color/radius constructor props.
- The four wrappers and enums export through their existing component libraries and `remix.dart`.

Separate TextArea enums are deliberate even though TextField currently has the same domains: the Radix components have independent APIs and may diverge. Share private metrics/variant helpers, not public enum types.

## Token additions

Add narrowly named tokens to `packages/remix/lib/src/fortal/fortal_theme.dart` only where an existing token cannot express the pinned value:

| Token | Type/value at scale 1 | Purpose |
| --- | --- | --- |
| `skeletonPulseDuration` | `DurationToken`, 1000 ms | Radix pulse leg duration. |
| `segmentedControlIndicatorBackground` | `ColorToken`, light `colorBackground`, dark `grayA3` | Selected surface mode switch. |
| `segmentedControlClassicIndicatorShadows` | `RemixBoxShadowListToken`, the active light/dark `shadow2` layers with fixed `shapeInset: 1` | Preserve all five classic shadow layers on Radix's 1 px inset indicator shape; derive from the same computed shadow-2 list rather than copying formulas. |
| `textAreaMinHeight3` | `DoubleToken`, fixed 80 logical px | Size 3; the pinned CSS uses literal `80px`, while sizes 1/2 reuse scalable spacing tokens. |
| `textAreaPaddingY1` | `DoubleToken`, `space1 - fixed borderWidth1` (`4 × scaling - 1` at the current theme) | Bordered size-1 vertical inset. |
| `dataListRowGap3` | `DoubleToken`, 20 × scaling | Radix `space4 × 1.25`. |
| `dataListLabelMinWidth` | `DoubleToken`, fixed 120 logical px | Horizontal implicit label minimum; the pinned CSS uses literal `120px`. |
| `menuSubmenuChevronEndOffset` | `DoubleToken`, -2 × scaling | Pinned submenu-chevron end pull; a named signed token avoids an inline recipe formula. |

Reuse existing `textFieldPadding1/2/3`, `selectSpace1Half`, space, radius, text, gray/accent, focus, and shadow tokens for every other metric. Add light/dark/scaling resolution coverage to `fortal_tokens_test.dart` / `fortal_theme_resolution_test.dart`, including assertions that the two literal CSS lengths remain fixed while derived spacing metrics scale. Do not introduce a token when a current one is exact.

## Recipe mapping

### Skeleton

In `components/skeleton/fortal_skeleton_styles.dart`:

- base fill `grayA3`, pulse fill `grayA4`;
- `radius1`;
- `skeletonPulseDuration`;
- childless minimum height `space3` while allowing child geometry to exceed it;
- no loading semantics and no extra motion logic in the recipe—the Remix widget owns both.

No size/variant/high-contrast enum exists upstream. Width/height remain caller style/constraints and child geometry; record responsive CSS width/height props as normal Flutter layout adaptation, not generated enums.

### SegmentedControl

In `components/segmented_control/fortal_segmented_control_styles.dart`:

- size heights: `space5` / `space6` / `space7` (24/32/40 at scale 1);
- text: `text1` / `text2` / `text3`;
- horizontal padding: `space3` / `space4` / `space4`;
- item gap: `space1` / `space2` / `space3`;
- radius: `radius2OrFull` / `radius2OrFull` / `radius3OrFull`;
- track: `colorSurface` with the Radix `grayA3` layer;
- disabled root track `gray3`;
- inactive label regular with 0 em letter/word spacing; active label medium
  with the pinned tab-active `-0.01em` letter spacing and 0 em word spacing; disabled text
  `grayA8`; unselected hover `grayA2`;
- selected background `segmentedControlIndicatorBackground` painted on the
  pinned 1 px inset shape, including the radius-minus-1 px rule;
- surface selected ring `grayA4` is painted at `shapeInset: 1`; classic selected
  uses `FortalTokens.segmentedControlClassicIndicatorShadows`, not the
  incompatible ordinary `BoxShadowToken` `FortalTokens.shadow2`;
- disabled selected state switches the background shape to a 0 px inset with
  `grayA3` and removes every selected ring/shadow;
- focus uses `fortalFocusOutline`/`RemixBoxEffectsSpec` at 2 px with the pinned
  -1 px offset. Selected inset, classic shadows, and focus outline compose in
  `SegmentedControlItemSpec.containerEffects`; do not flatten them into
  `foregroundDecoration`.

The Remix constructor's orientation and item-disabled support flow through. The recipe does not implement the upstream 100 ms translated indicator, inactive/active duplicate-label crossfade, or separators. Add explicit manifest approximations with visual tolerance and screenshot captions for those v1 differences.

### TextArea

In `components/textfield/fortal_textarea_styles.dart`:

- sizes: min heights `space8` / `space9` / `textAreaMinHeight3` (48/64/80); text1/2/3; radius2/2/3;
- bordered classic/surface padding:
  - size1 x `textFieldPadding1`, y `textAreaPaddingY1`;
  - size2 x `textFieldPadding2`, y `textFieldPadding1`;
  - size3 x `textFieldPadding3`, y `textFieldPadding2`;
- soft padding:
  - size1 x `selectSpace1Half`, y `space1`;
  - size2 x `space2`, y `selectSpace1Half`;
  - size3 x `space3`, y `space2`;
- container cross-axis alignment is start; do not reuse TextField's fixed height/center alignment;
- classic/surface fill, text, placeholder, disabled/read-only, error, focus
  ring, cursor, and effect layers reuse refactored private TextField helpers;
- soft placeholder uses `accent12` at 0.65 opacity, and the soft focus outline
  uses `accent8` rather than the general `focus8` role. Keep these values
  explicit and parameterized in the shared helper contract: pinned TextField
  uses the same role at 0.60 opacity, while TextArea uses 0.65.

Refactor `fortal_textfield_styles.dart` into shared private
“apply classic/surface/soft/neutral/disabled/error effects to a supplied base
styler” helpers. The existing Fortal TextField soft recipe currently uses
`focus8` and the TextField helper placeholder role, which do not match the
pinned soft CSS. Correct its focus outline to `accent8` and placeholder to
`accent12` at 0.60 opacity in this PR, update those exact expectations, and
require every unaffected TextField size/variant/state to resolve identically
before and after the refactor. The shared soft helper must accept the component-
specific placeholder opacity so TextArea remains at its pinned 0.65. Do not
copy the three complete variant bodies.

Record browser `resize` and fixed web textarea sizing as approximations:
Flutter uses `minLines`, `maxLines`, constraints, and scrolling with no web drag
handle, and the default `maxLines: null` auto-grows until constrained.
Responsive CSS size/radius props map to rebuilt Flutter values/scope, as
elsewhere.

### DataList

In `components/data_list/fortal_data_list_styles.dart`:

- size text: text1/text2/text3 for labels and values;
- row gaps: space3/space4/dataListRowGap3 (12/16/20);
- vertical label/value gap: space1;
- horizontal label minimum: dataListLabelMinWidth;
- normal weight; label `grayA11`, or `gray12` when global `highContrast`; value inherits `gray12`;
- root/background remains transparent; orientation and per-item alignment stay constructor/data arguments.

Expose global `highContrast` for the data-driven list because per-label recipe props do not exist. Manifest-defer Radix's compositional Root/Item/Label/Value model, per-label color/highContrast/width props, responsive breakpoints, and CSS leading trim with a clear Flutter alternative/tolerance. Do not silently claim them.

### Menu and CheckboxGroup

- Extend `_fortalMenuItemStyler` to style the new `indicator` and
  `compoundLeadingGutter` fields. Resolve the panel-wide size1/size2 gutter and
  indicator centering from the pinned base-menu padding rules; mixed ordinary
  and compound rows must share the same label start, while ordinary-only panels
  retain the original inset.
- Verify the pinned thick-check indicator for checked checkbox/selected radio
  items, its absent unchecked state, and the directional submenu chevron in
  solid/soft, size1/2, disabled, highContrast, light/dark, LTR/RTL.
- Use the exact existing `RemixPathGlyph.thickCheck` transcription for both
  compound item kinds and PR 1's exact `thickChevronRight` transcription for
  submenus; no glyph-shape tolerance is justified. Set the trailing slot's
  leading gap to `space4`, align it to the directional row end, and set only the
  default submenu chevron's end offset to
  `menuSubmenuChevronEndOffset`. Test the paths and coordinates at both sizes
  and directions; a caller-supplied replacement `trailingIcon` keeps the shared
  end alignment/gap but not the submenu-only chevron offset.
- Remove PR 1's temporary neutral-indicator approximation and update menu evidence/selectors/states if needed.
- Add a Fortal section to CheckboxGroup docs showing
  `RemixCheckboxGroupItem(style: fortalCheckboxStyle(...))`. Do not create
  `FortalCheckboxGroup` or `FortalCheckboxGroupItem` in this series because the
  public group deliberately owns no layout/style anatomy.
- Add a `checkbox_group` entry to a new top-level
  `unmappedUpstreamFamilies` manifest section, validated by the schema and
  checker. Record the pinned root/item selectors and source files, upstream
  root gap/item label gap/size/variant/color/highContrast contract, supported
  Remix composition, reason for deferral, and reopen condition. It contributes
  no evidence owner or Chromium probe and does not change the 24/3 count.

## Work breakdown

- [ ] Task 1: Add failing token, enum/default, wrapper, and resolved-metric tests.
  - Files: `test/fortal/fortal_tokens_test.dart`, `fortal_theme_resolution_test.dart`, `fortal_control_matrix_test.dart`, `test/components/fortal_widget_test.dart`, both public-API tests.
  - Acceptance: all eight new tokens, four wrappers, enum domains/defaults,
    named constructors, generic inference, and scale/light/dark values are
    specified before recipes exist; the classic indicator token retains all
    five shadow-2 layers with fixed 1 px shape insets.

- [ ] Task 2: Implement tokens and the Skeleton/Segmented recipes.
  - Files: `fortal_theme.dart`, `computed.dart`; new Fortal style parts in
    skeleton/segmented libraries; library part declarations; generated files;
    per-family parity tests.
  - Acceptance: exact metric/state tests pass and Skeleton reduced-motion behavior remains owned by Remix.

- [ ] Task 3: Refactor TextField recipe helpers and add TextArea.
  - Files: `components/textfield/fortal_textfield_styles.dart`, new `fortal_textarea_styles.dart`, `textfield.dart`, generated `textfield.g.dart`, TextField regression and TextArea parity tests.
  - Acceptance: before/after resolved TextField styles are identical for every
    unaffected size/variant/state; soft placeholder/focus expectations change
    only to the pinned TextField accent12-at-0.60/accent8 values; TextArea uses
    its distinct pinned accent12-at-0.65/accent8 values and adds only multiline
    metrics on top of the corrected shared helpers.

- Checkpoint: run all TextField/TextArea, Skeleton, SegmentedControl, token, control-matrix, and wrapper tests before DataList/parity-ledger work.

- [ ] Task 4: Implement DataList and finish Menu/CheckboxGroup presentation.
  - Files: new DataList Fortal part/generated file,
    `menu/fortal_menu_styles.dart`, menu parity tests, CheckboxGroup
    docs/playground.
  - Acceptance: four recipes and exact menu indicator/gutter/trailing geometry cover
    light/dark/high-contrast/state matrices with no new checkbox-group visual
    type; docs label the group composition supported rather than mapped parity.

- [ ] Task 5: Advance the parity contract from 20/3 to 24/3.
  - Files: `reference/.../manifest.json`, `manifest.schema.json`,
    `coverage_evidence.json`, `tool/fortal_parity/check.dart`, per-family parity
    tests, reference README.
  - Add the four IDs to `_expectedMappedFamilies`, update exact total to 27 and success text to 24 mapped/3 extensions.
  - Map `text_area` to `components/textfield/fortal_textarea_styles.dart` in `_readFortalStylesSource`; standard mappings handle the other three.
  - Add exact source files/selectors, upstream inventories, defaults/enums/states, visual mappings, deferred capabilities, and named approximations described above.
  - Add and validate the `checkbox_group` unmapped-upstream inventory record;
    require unique IDs, real pinned source paths/selectors, a nonempty reason and
    reopen condition, and disjointness from mapped/extension IDs.
  - Acceptance: evidence owners are exactly `theme + 24 mapped + 3
    extensions`, CheckboxGroup is audited but owns no evidence/probe, and every
    cited case string exists in a real test.

- [ ] Task 6: Expand and regenerate the pinned Chromium reference.
  - Files: `tool/fortal_parity/chromium/fixture.html`, `generate.mjs`, committed `reference/.../chromium/computed-styles.json`, `families-light.png`, README if layout description changes.
  - Add one probe per new mapped family with stable representative states/properties. Change the grid to five columns and roughly 160 px minimum cells now so PR 8's 29 mapped probes also fit; preserve 1440x1280 output.
  - Run `npm ci && npm run generate` in the fixture directory.
  - Acceptance: normalized computed probe IDs exactly equal the 24-family set and the screenshot signature/dimensions pass.

- Checkpoint: run `fvm dart run melos run fortal:parity:check`; do not proceed to screenshots while manifest, evidence, tests, and fixture disagree.

- [ ] Task 7: Finish docs, playground, inventories, and visual review.
  - Files: the Skeleton, SegmentedControl, TextArea, DataList, Menu, and CheckboxGroup MDX pages; their playground entries; root and `packages/remix/README.md` kept identical.
  - Capture matched light/dark Flutter screenshots and matching Radix 3.3 reference states side by side in the PR description.
  - Acceptance: captions name every intentional approximation, all docs snippets compile, and both README component lists match.

## Test strategy

### Recipe/control matrix

- Resolve every size and variant at scaling 1 and one nondefault scaling.
- Assert exact heights/min-heights, padding, gaps, radii, typography, fills, rings/shadows, duration, and label minimum width.
- At nondefault scaling, assert `textAreaMinHeight3` and
  `dataListLabelMinWidth` remain 80/120 while space-derived row gaps and padding
  scale.
- Resolve light/dark and at least two accent colors; DataList highContrast and menu highContrast must use intended roles.
- Assert default constructors and all generated named constructors; generic SegmentedControl inference remains intact.

### States and semantics

- Skeleton loading/loaded/reduced-motion semantics remain unchanged after styling.
- Segmented selected/unselected/hover/pressed/focus/disabled/RTL states style
  without changing button/selected semantics or geometry; root disabled track,
  active spacing, selected inset, and composed effect layers are exact.
- TextArea idle/hover/focus/disabled/readOnly/error and multiline semantics
  match corrected TextField behavior except for the pinned soft-placeholder
  opacity split: TextField is 0.60 and TextArea is 0.65; both use `accent12`
  placeholders and `accent8` focus outlines.
- DataList styles do not change list/list-item or custom-child semantics.
- Menu indicators track checked/selected/open/disabled state and remain excluded beneath Naked semantics.
- CheckboxGroup focus/semantics tests still pass with `fortalCheckboxStyle` item styling.

### Parity evidence

- One dedicated `*_fortal_parity_test.dart` per new mapped family plus menu indicator parity coverage.
- Every manifest enum/state is named by coverage and by an exact evidence case.
- Checker validates recipe `highContrast` exposure against manifest (`data_list` true; other new families false).
- Checker validates `checkbox_group` as an intentionally unmapped upstream
  family, rejects overlap with mapped/extension IDs, and does not expect a
  recipe, evidence owner, or Chromium probe for it.
- Chromium computed styles include stable probes for all mapped IDs and source integrity/version.

### Manual visual review

- Compare identical states at matching scale/viewport in light and dark.
- Inspect focus at 200% zoom and ensure effect-rendered offset rings do not shift content.
- Verify selected Segment surfaces, all TextArea variants/sizes, DataList column
  geometry, Skeleton pulse/reduced motion, and menu indicators/chevrons.
- Treat the committed Chromium image as upstream evidence only; judge Flutter output in the playground.

## Acceptance criteria

- [ ] `FortalSkeleton`, `FortalSegmentedControl<T>`, `FortalTextArea`, and `FortalDataList` are generated, exported, documented, and tested.
- [ ] All styling resolves from Fortal tokens; the eight justified new tokens have theme/scaling tests.
- [ ] Existing FortalTextField output is unchanged outside the disclosed
  `accent12`-at-0.60 soft placeholder and `accent8` focus parity correction;
  FortalTextArea retains its distinct 0.65 soft-placeholder opacity.
- [ ] Menu indicators, panel-wide conditional gutter, exact check/chevron paths,
  and submenu trailing geometry are fully Fortal-styled and the temporary
  approximation is removed.
- [ ] CheckboxGroup remains a nonvisual Remix coordinator composed with the
  existing Fortal checkbox recipe, and its omitted Radix visual anatomy is
  checker-audited rather than silently counted as mapped.
- [ ] Manifest/evidence/checker/tests/fixture all agree on 24 mapped + 3 extensions = 27 families.
- [ ] Segmented slide/separators, TextArea resize/auto-grow, and DataList
  compositional/per-label/responsive/trim gaps are explicit approximations;
  exact available menu vectors are not mislabeled as approximations.
- [ ] Light/dark side-by-side Radix screenshots and all shared validation results are in the PR.

## Risks and mitigations

- Risk: generated TextArea wrapper does not accept a subtype target sharing the parent styler. Mitigation: write the compile-time wrapper test first; if generator support is missing, make the smallest generator fix with a regression test rather than introduce a duplicate TextArea spec.
- Risk: TextField helper refactor changes unrelated existing pixels.
  Mitigation: snapshot resolved specs before refactoring, permit only the named
  soft placeholder/focus correction, assert the TextField 0.60 versus TextArea
  0.65 opacity split, and require equality for every unaffected size/variant/state.
- Risk: new probes overflow the fixed Chromium canvas. Mitigation: adopt the 5-column/shorter-cell layout before regeneration and visually inspect every label/probe.
- Risk: parity counts become internally inconsistent. Mitigation: make ledger/checker/fixture updates one task and gate at the checkpoint.
- Risk: CheckboxGroup disappears from the parity story because it is not
  counted. Mitigation: schema/checker-enforce its unmapped inventory record and
  require a future mapped implementation to remove that record atomically.
- Risk: “token-only” recipes hide copied formulas. Mitigation: add named tokens only for missing exact values and cite the pinned CSS selector/source in token comments/tests.

## Validation and rollout

Run the Chromium generator, focused recipe/parity tests, `fortal:parity:check`, then every shared command in `01-conventions.md`. No flag or data migration is required. Rollback must revert recipes, generated wrappers, tokens, manifest/evidence/checker, fixture outputs, docs, and README changes together so the parity contract never describes absent code.
