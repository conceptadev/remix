## Unreleased

- **BREAKING**: Replace the unreleased surface paint API with the box-effects
  domain: `RemixBoxShadow*`, `RemixBoxEffectLayer*`, and `RemixBoxEffects*`.
  Rename generic component `effects` slots to `containerEffects` and layer
  positions to `behindContent`/`overContent`; no deprecated aliases are kept.
- **BREAKING**: Move ordinary Dialog, Menu, Popover, Select-content, Slider
  thumb, and Switch thumb elevation into the component's Mix box decoration.
  `FortalTokens.shadow2` through `shadow6` are now `BoxShadowToken` values;
  inset, `shapeInset`, mixed, and explicitly positioned shadows remain Remix
  effects.
- **CHORE**: Upgrade to hosted `mix` 2.2.0-beta.1 while keeping hosted
  `mix_annotations`/`mix_generator` 2.2.0-beta.0 and the unhosted
  `mix_protocol` development dependency on git.
- **FEAT**: Expose `ButtonStyler` as the canonical button styling API.
  `RemixButtonStyler` remains available as a deprecated compatibility alias.
- **BREAKING**: Align the 20 mapped Fortal families with the pinned
  `@radix-ui/themes@3.3.0` contract. Accordion, Toggle, and ToggleGroup remain
  documented Fortal extensions and are excluded from the Radix parity score.
- **FIX**: Restore variant-specific Fortal named constructors while retaining
  the enum-based constructor for runtime variant selection.
- **BREAKING**: Replace the root theme inputs with partial, inheritable
  `appearance`, `accentColor`, `grayColor`, `panelBackground`, `radius`,
  `scaling`, and `hasBackground` values. Root `FortalScope` belongs above the
  app widget so platform appearance and Navigator overlays share one theme.
- **BREAKING**: Button and IconButton accept arbitrary `child` widgets;
  IconButton requires a nonempty `semanticLabel`. Badge and other content
  components also inherit resolved text/icon styles through arbitrary content.
- **BREAKING**: Slider is an arbitrary multi-thumb control with ascending
  `values`, list-valued callbacks, `step`, `minSpacing`, orientation, inversion,
  per-thumb focus, and per-thumb semantics. Remove scalar `value` and
  `snapDivisions`.
- **BREAKING**: `RemixTabs.activationMode` now exposes automatic and manual
  keyboard activation from Naked beta.6.
- **BREAKING**: Menu now takes an arbitrary trigger widget and compositional
  action, checkbox, group, label, separator, radio, and recursive submenu
  entries. Select uses `entries` with selectable, group, label, and separator
  types and exposes owner-authoritative `open`/`onOpenChanged` control.
- **FEAT**: Add Radix-aligned Popover and Fortal ToggleGroup; complete missing
  classic variants, sizes, high-contrast roles, geometry, focus/disabled/open
  states, separate Popover anchors, and semantic behavior across the mapped
  families.
- **FEAT**: Add partial theme resolution, platform-brightness observation,
  automatic matching gray scales, complete 90%–110% scaling, derived radii,
  translucent panels, and premultiplied-alpha OKLab shadow-stroke mixing.
- **FEAT**: Add box effects with token-aware multiple gradients, positioned
  and inset shadows, clip insets, CSS-style outlines, and backdrop blur.
- **FIX**: Preserve token-backed shadow-list identity when state styles replace
  explicit surface shadows, and use dedicated scaled radio-indicator tokens so
  Mix token references are never multiplied as raw sentinel doubles.
- **FIX**: Propagate Popover trigger interaction and open state into composed
  Remix recipes. Card now preserves inherited states, holds the Radix open
  treatment over pressed, and applies the exact focused-active surface layer.
- **FIX**: Keep Tooltip arrows anchored to the trigger after collision shifts
  and flips, including rotated side geometry; stabilize indeterminate Progress
  at its completed-growth frame when accessible animations are disabled.
- **FIX**: Define `RemixDialog.modal` as accessibility route scoping and
  document the Flutter route boundary: `showRemixDialog` remains pointer-modal
  for both values because it uses a Navigator dialog route.
- **FIX**: Keep full-length Fortal dividers at one logical pixel on their cross
  axis even when a tight parent supplies extra height or width.
- **FIX**: Use Naked beta.7's public slider visual-percentage mapping instead
  of mirroring its direction, orientation, and inversion logic locally.
- **FIX**: Open default Remix and Fortal submenus toward the leading side in
  RTL while preserving explicit physical positioning overrides.
- **FIX**: Preserve unresolved constraint tokens in portable Fortal Button
  container documents so every variant and size remains protocol-encodable.
- **CHORE**: Target exact `naked_ui` 1.0.0-beta.7 behavior, add the pinned
  Chromium reference fixture and parity manifest/checker.
- **CHORE**: Require every parity-manifest enum and state to cite an exact
  executable test case; reject missing, stale, extra, or uncited evidence.
- **DOCS**: Migrate the complete MDX guide and public examples to the hard-break
  APIs. Add a documentation gate that rejects retired component syntax across
  MDX and app/example sources and analyzes every self-contained Dart snippet
  against the package.

## 1.0.0-beta.1

- **BREAKING** **FIX**: `RemixDialog.child` now composes with `title`,
  `description`, and `actions` in `AlertDialog` order instead of silently
  discarding them. A lone `child` still fills the container directly, so fully
  custom dialog bodies are unaffected.

- **BREAKING**: Rename fluent style builders from `RemixXStyle` to `RemixXStyler` and Fortal helpers from `fortalXStyle()` to `fortalXStyler()`, matching Mix terminology (`BoxStyler`, `TextStyler`, `MixStyler`). Widget parameter stays `style:`. No deprecated aliases.
- **BREAKING**: Public `styleSpec` is raw `RemixXSpec?` on all component surfaces (resolved via `RemixStyleSpecBuilder`); StyleWidget-based components converted to explicit widgets.
- **BREAKING**: `RemixSelect` overlay placement is `positioning: OverlayPositionConfig` (removed public `targetAnchor`/`followerAnchor`).
- **BREAKING**: Remove `enableFeedback` from `RemixRadio` (not exposed by `NakedRadio`).
- **BREAKING**: `RemixButtonStyler` unnamed constructor now takes unresolved stylers (`FlexBoxStyler`, `TextStyler`, `IconStyler`, `RemixSpinnerStyler`) instead of resolved `StyleSpec` values, matching sibling components.
- **BREAKING**: Rename `text` to `label` on `RemixAvatarSpec`/`RemixAvatarStyler` and `RemixBadgeSpec`/`RemixBadgeStyler` (fields, constructor params, and generated setters).
- **BREAKING**: Remove `RemixAvatarStyler.iconColor`/`.textColor` and `RemixCalloutStyler.iconColor`/`.textColor` factory constructors; use the `iconColor()`/`labelColor()`/`textColor()` instance methods instead.
- **BREAKING**: Rename `RemixSlider.enableHapticFeedback` to `enableFeedback`, matching the other interactive components.
- **BREAKING**: `onChanged` is now optional/nullable on `RemixSlider`, `RemixSwitch`, `RemixToggle`, and `RemixRadioGroup`; omitting it (or passing null) disables the control.
- **BREAKING**: `RemixButton.onPressed` and `RemixIconButton.onPressed` are no longer `required`; omitting them renders a disabled button.
- **BREAKING**: Remove the nonfunctional `RemixDialogStyler.overlay`, `RemixTextFieldStyler.cursorOffset`, and raw `RemixTextFieldSpec.spacing` APIs. Dialog barriers remain configured through `showRemixDialog(barrierColor:)`; Naked UI does not expose a cursor-offset override. The existing `RemixTextFieldStyler.spacing()` convenience still configures the input row.
- **BREAKING**: `package:remix/remix.dart` no longer exports `src/theme/remix_theme.dart` (`resolveRemixBrightness`/`resolveRemixBrightnessValues` were test-only helpers).
- **BREAKING**: Bump `mix` to ^2.1.0, `mix_annotations`/`mix_generator` to hosted `^2.1.2`, and `naked_ui` to `^1.0.0-beta.3` (stable 1.0 pub tag blocked until `naked_ui` is stable).
- **FIX**: Consume `naked_ui` beta.3's type-specific state scopes, including typed menu-item and select-option controllers, while preserving callback-optional `RemixSelect` browsing.
- **FIX**: Forward menu interception, outside-tap, root-overlay, close-on-outside-click, focus, and positioning options through `RemixMenuStyler.call()` and generated `FortalMenu` widgets.
- **FEAT**: Add `call()` widget-builder methods to all component stylers and reproducibly generate every `FortalX` convenience widget via `@MixWidget`, including generic Radio/Accordion/Menu/Select surfaces.
- **FEAT**: Add generated named constructors for Fortal variants.
- **FEAT**: Fortal wrappers for dialog, menu, select, tooltip, and tabs parts (`FortalTabBar`/`FortalTab`/`FortalTabView`).
- **FEAT**: Tooltip `dismissDuration` (hover-exit → `NakedTooltip.dismissDelay`); `showDuration` maps to the post-activation touch visibility interval (`touchDelay`).
- **FEAT**: Add `positioning` (`OverlayPositionConfig`) to `RemixTooltip` and `enabled` to `RemixIconButton`.
- **FEAT**: Add `FortalAccordionVariant`/`FortalAccordionSize` parameters to `fortalAccordionStyler()`.
- **FIX**: Menu trigger renders icon before label.
- **FIX**: Fortal TextField disabled surface/soft use background-fill tokens (no debug `Colors.red`).
- **FIX**: `RemixMenuStyler.item(...)` default item styling is now applied to menu items (per-item styles override it); previously it was silently ignored.
- **FIX**: Forward TextField alignment, cursor, selection, scroll-padding, keyboard-appearance, outside-tap, pointer, and semantics values to `NakedTextField` while preserving widget-state variants.
- **FIX**: `showRemixDialog` works with or without a `MixScope`, and scoped dialog builders now receive a context below the cloned scope.
- **FIX**: Preserve nested spinner and divider animation/modifier metadata instead of dropping the enclosing `StyleSpec`.
- **FIX**: Apply `RemixButtonStyler.iconAlignment` to a single icon while preserving explicit leading/trailing positions when both are present.
- **FIX**: Apply `RemixTooltipStyler.label` to text descendants of custom tooltip content.
- **FEAT**: `FortalSelect` now includes its matching default item style, while per-item styles remain optional overrides.
- **FEAT**: `RemixIconButtonStyler.call()` and generated `FortalIconButton` widgets now forward the complete widget behavior surface.

## 0.2.0

- **FEAT**: Add RemixToggle component (#50).
- **FEAT**: Add backgroundColor, foregroundColor, shape and factory methods to RemixCalloutStyle (#49).
- **FEAT**: Add factory constructors and shape to RemixCardStyle (#48).
- **FEAT**: Align component style APIs with Material conventions (#47).
- **FEAT**: Rename badge color to backgroundColor, add foregroundColor and factory constructors (#46).
- **FEAT**: Add convenience factory methods to RemixAccordionStyle (#44).
- **FEAT**: Add convenience methods and factory constructors to RemixAvatarStyle (#45).
- **FEAT**: Add Material-like style convenience methods to RemixButtonStyle (#43).
- **FEAT**: Create FortalScope widget (#37).
- **FEAT**: Add leading and trailing icon support to RemixButton (#20).
- **FEAT**: Add call() method to design system styles (#30).
- **REFACTOR**: Migrate components to mix annotations and code generation (#35).
- **FIX**: Handle unbounded width constraints in RemixSelect (#31).
- **FIX**: Add slider min/max validation and export StyledTextStyleMixin (#32).
- **DOCS**: Fix component documentation to match Dart source code (#51).
- **CHORE**: Migrate to Dart 3.10 dot shorthand syntax (#34).
- **CHORE**: Fix documentation API references and add error logging (#33).

## 0.1.0-beta.3

- **FEAT**: Add iconAlignment property to Button component (#29).
- **CHORE**: Remove Mix 2.0 incompatible helpers and improve tests (#25).
- **TEST**: Add comprehensive tests for accordion and divider components (#27).

## 0.1.0-beta.2

 - Update dart min version to 3.10.0

## 0.1.0-beta.1

 - Update a dependency

## 0.0.4+2

 - Update a dependency to the latest release.

## 0.0.4+1

 - Update a dependency to the latest release.

## 0.0.4

 - **FEAT**: Support header on scaffold (#554).
 - **FEAT**: Accordion interaction based on open variable (#546).

## 0.0.3

 - **REFACTOR**: Create a new Architecture for remix's components (#446).
 - **REFACTOR**(remix): improve widgetbook navigation (#524).
 - **REFACTOR**: Add in code documentation and rename params for each component (#514).
 - **REFACTOR**: Remix progress (#429).
 - **REFACTOR**: small fixes on remix (#512).
 - **REFACTOR**: Rewrite Fortaleza theme using the new code gen for tokens (#528).
 - **REFACTOR**: Remix was rewritten using Fluent API (#476).
 - **REFACTOR**: Rewrite all components in the new Archtecture (#467).
 - **FIX**: Textfield helper Text (#531).
 - **FIX**: Toast animation trigger (#530).
 - **FEAT**: Create Textfield (#511).
 - **FEAT**: Chip component (#504).
 - **FEAT**: implement toast component (#503).
 - **FEAT**: Card has child instead of children parameter (#499).
 - **FEAT**: Create dark base theme for Remix (#498).
 - **FEAT**: remix-styling-configuration (#483).
 - **FEAT**: Segmented control (#479).
 - **FEAT**: Accordion component (#433).
 - **FEAT**: Slider component (#509).
 - **FEAT**: Add more directives to Colors (#477).
 - **FEAT**: Menu Item Component (#508).
 - **FEAT**: Add group feature to Radio (#435).
 - **FEAT**: Create Select component (#448).
 - **FEAT**: Add parameter onEnd for AnimatedStyle (#458).
 - **FEAT**: button supports component builder (#444).
 - **FEAT**: Create a theme for Remix (#470).
 - **FEAT**: Refactor Remix components (#428).
 - **FEAT**: Remix improvements and further improvements (#410).
 - **FEAT**: Rewrite FlexBox as a Mix's primitive component (#517).

## 0.0.2-alpha.3

 - Update a dependency to the latest release.

## 0.0.2-alpha.2

 - Update a dependency to the latest release.

## 0.0.2-alpha.1

 - First Release

## 0.0.2+6

 - Update a dependency to the latest release.

## 0.0.2+5

 - Update a dependency to the latest release.

## 0.0.2+4

 - Update a dependency to the latest release.

## 0.0.2+3

 - Update a dependency to the latest release.

## 0.0.2+2

 - Update a dependency to the latest release.

## 0.0.2+1

 - **DOCS**: improve mix theme data features explanations (#404).

## 0.0.2

 - **FEAT**: Ability to pass MixWidgetStateController to SpecBuilder (#391).
 - **FEAT**: Foundational components (#317).
