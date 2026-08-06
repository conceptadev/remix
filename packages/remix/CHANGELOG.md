## Unreleased

- **FIX**: Center `RemixSegmentedControl` segment content along the main axis,
  matching the Radix segmented control item anatomy. Equal segments make most
  surfaces wider than their content, which previously start-aligned the
  icon/label cluster. An explicit item container `alignment` still overrides
  the centered default.
- **FEAT**: Add `RemixSegmentedControl`, an equal-segment single-select control
  mapped from Radix Segmented Control. A custom render object sizes every
  segment to the largest one and divides an explicit track extent equally,
  reporting intrinsics that stay consistent with layout so intrinsic-sizing
  parents wrap labels instead of overflowing. Selection is controlled and
  never cleared by reactivating the selected segment; `T extends Object` keeps
  `null` reserved as the no-selection sentinel and `onChanged` non-null.
  Roving keyboard focus, `Home`/`End`, optional looping, RTL-aware arrow
  navigation, per-item disabled state, and vertical orientation are supported,
  and each segment exposes one merged selected-button semantics node. No
  Fortal preset ships in v1, so callers own the visual layer.
- **FEAT**: Add `RemixTextArea`, a constructor-only multiline facade over
  `RemixTextField` with two-line auto-growing defaults and the canonical
  `TextFieldStyler` / `TextFieldSpec` styling surface.
- **BREAKING**: Change `TextFieldSpec.container` and
  `TextFieldStyler.container` from `FlexBoxSpec` / `FlexBoxStyler` to
  `BoxSpec` / `BoxStyler` because TextField and TextArea always render their
  input anatomy as a fixed horizontal row. The full forwarded Box surface is
  honored, generated `spacing` and `crossAxisAlignment` methods control the row
  directly, and the row follows the ambient text direction. Misleading Flex
  direction, main-axis, vertical-direction, text-direction, text-baseline, and
  `flex(FlexStyler)` container methods are no longer exposed.
- **FIX**: Render the separate label/input/helper `layout` as a real `FlexBox`
  so its full generated Flex direction surface is truthful. The base style
  preserves the existing vertical, min-size, start-aligned layout with 8px
  spacing, while explicit row layouts are now honored without a forced-column
  assertion.
- **FIX**: Remove the unreleased `RemixTextArea.styleFrom` affordance because
  the shared `TextFieldStyler` callable constructs a single-line
  `RemixTextField`. Pass a `TextFieldStyler` to `RemixTextArea.style` instead.
- **FIX**: Top-align multiline TextField hints and expose label, hint, helper,
  error, and interactive accessory semantics once without narrowing the
  existing composite tap target.
- **FEAT**: Add an optional styled `RemixCheckbox.label` inside the checkbox's
  pointer, focus, and single semantics target, with a 48-by-48 default minimum
  target and an explicit `Size.zero` compact opt-out. Mix now generates the
  label, label-spacing, interpolation, equality, and fluent label APIs, and
  generated Fortal checkbox wrappers forward the new widget parameters.
- **FEAT**: Add `RemixCheckboxGroup<T extends Object>` and
  `RemixCheckboxGroupItem<T extends Object>`, a controlled, layout-transparent
  coordinator for a typed `Set<T>` of checkbox options. The group owns selected
  values plus group-wide enabled/required semantics; items compose
  `RemixCheckbox`, require a visible `label`, accept `semanticLabel` as an
  accessible-name override, and forward `minimumTapTargetSize`, so existing
  `CheckboxStyler`/`fortalCheckboxStyle()` recipes apply unchanged while the
  entire labeled 48px target stays interactive. Emits a new unmodifiable set
  per change and renders a labeled semantics container with explicit checkbox
  children. Debug builds validate duplicate values, duplicate autofocus, and
  blank accessible names, and require a nonblank group `semanticLabel`
  whenever `isRequired` is true and semantics are not excluded.
- **BREAKING** **FEAT**: Add checkbox items, radio groups, and submenus to the
  sealed `RemixMenuItemData` hierarchy. Downstream exhaustive switches must
  handle the new cases or add a wildcard; no runtime migration is required.
- **FEAT**: Support reusable menu-wide customization by passing
  `fortalMenuStyle(...).merge(customStyle)` to `RemixMenu.style`; generated
  `FortalMenu` constructors remain recipe-only.
- **FEAT**: Add `RemixDataList`, a semantic label/value list mapped from
  Radix DataList. Horizontal orientation shares one negotiated label column
  across every row, supports intrinsic-width parents, and lets string values
  wrap unbroken identifiers at grapheme-safe boundaries while custom value
  widgets retain their intrinsic sizing; vertical orientation stacks label
  above value. Rows expose one `list`/`listItem` semantics pair with full-row
  bounds, interactive custom values stay actionable, `semanticValue` opts a
  display-only child into a summarized announcement, and
  `RemixDataListItem.key` gives rows stable identity across reorder, insertion,
  and removal.
- **FEAT**: Add the Remix rendering subsystem for layered inset and outer
  shadows, gradients, outlines, backdrop blur, blend modes, and ordered color
  filters used by the Radix-accurate Fortal recipes.
- **FEAT**: Expose the complete Fortal theme surface through `FortalScope`,
  including accent and gray palettes, brightness, panel backgrounds, radius,
  scaling, optional background painting, and modifier ordering.
- **FEAT**: Expose `ButtonStyler` as the canonical button styling API.
  `RemixButtonStyler` remains available as a deprecated compatibility alias.
- **FEAT**: Unprefixed styling names are now canonical for every component.
  `RemixXStyler` becomes `XStyler` and `RemixXSpec` becomes `XSpec` across
  Accordion, Avatar, Badge, Callout, Card, Checkbox, Dialog, Divider,
  IconButton, Menu, Popover, Progress, Radio, Select, Slider, Spinner, Switch,
  Tabs, TextField, Toggle, ToggleGroup, and Tooltip. Every `RemixXStyler` name
  remains as a deprecated source-compatible alias exported from
  `package:remix/remix.dart`, and every `RemixXSpec` name remains as a typedef
  beside its canonical spec, so existing code keeps compiling. Widgets, data
  classes, and rendering primitives keep the `Remix` prefix — for example
  `RemixButton`, `RemixMenu`, `RemixMenuItem`, `RemixBoxEffectsSpec`, and
  `RemixBoxStylerMixin` are unchanged. Public styler extension names such as
  `RemixCardStylerRemixHelpers` are also unchanged, so explicit extension
  invocation stays source-compatible.
- **BREAKING**: Rename Fortal recipe helpers from `fortalXStyler()` to
  `fortalXStyle()` so `@MixWidget` can infer every generated `FortalX` name.
  Remix component styler types such as `ButtonStyler` and
  `AvatarStyler` are unchanged.
- **FEAT**: Expose every Fortal recipe parameter on its generated widget,
  including `highContrast` and Avatar's `fallbackLength`, while retaining both
  the unnamed `variant:` constructor and generated named variant constructors.
- **FEAT**: Add `RemixSkeleton`, a decorative loading placeholder that keeps a
  child mounted for its geometry and local state while suppressing that child's
  paint, pointer input, keyboard focus, semantics, and tickers. The pulse
  interpolates the container fill between `color` and `pulseColor`, falls back
  to a composed whole-surface opacity fade whenever a gradient, image, or
  foreground decoration would mask that fill, and honours
  `MediaQuery.disableAnimationsOf` initially and on runtime changes.
- **FIX**: Allow `naked_ui` releases compatible with `^1.0.0-beta.8` so open
  labelled tooltips retain one interactive semantics node without hiding
  unlabelled overlay semantics.
- **FIX**: Keep dialog titles and actions fixed while structured descriptions
  and body content scroll within bounded dialogs.
- **FIX**: Resolve Fortal Avatar icon geometry through scaled design tokens for
  both the default icon and custom icon-builder paths.
- **FIX**: Keep Remix icon-button semantics on one interactive node across
  normal, loading, and excluded-semantics states.
- **FIX**: Support 200 percent text scaling in Fortal buttons and toggles
  without clipping labels or changing normal-scale geometry.
- **FIX**: Render `FortalSpinner` and Fortal button loading states with the
  eight fading Radix leaves while preserving the arc painter for plain
  `RemixSpinner`.

## 1.0.0-beta.1

- **BREAKING** **FIX**: `RemixDialog.child` now composes with `title`,
  `description`, and `actions` in `AlertDialog` order instead of silently
  discarding them. A lone `child` still fills the container directly, so fully
  custom dialog bodies are unaffected.

- **BREAKING**: Rename fluent style builders from `RemixXStyle` to `RemixXStyler` and Fortal helpers from `fortalXStyle()` to `fortalXStyler()`, matching Mix terminology (`BoxStyler`, `TextStyler`, `MixStyler`). Widget parameter stays `style:`. No deprecated aliases were kept for the removed `RemixXStyle` names.
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
- **FEAT**: Add generated named constructors for Fortal variants (for example, `FortalButton.solid(...)`); Dart infers generic types for calls such as `FortalRadio.soft(...)`, and the unnamed constructors remain available.
- **FEAT**: Fortal wrappers for dialog, menu, select, tooltip, and tabs parts (`FortalTabBar`/`FortalTab`/`FortalTabView`).
- **FEAT**: Tooltip `dismissDuration` (hover-exit → `NakedTooltip.dismissDelay`); `showDuration` remains touch wait → `touchDelay`.
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
