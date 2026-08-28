/// Remix design system widgets and styles.
///
/// Remix ships no theme. For a ready-made Radix Themes-inspired preset, add the
/// companion `remix_fortal` package.
library remix;

/// COMPONENTS
export 'src/components/accordion/accordion.dart';
export 'src/components/avatar/avatar.dart';
export 'src/components/badge/badge.dart';
export 'src/components/button/button.dart';
export 'src/components/callout/callout.dart';
export 'src/components/dialog/dialog.dart';
export 'src/components/icon_button/icon_button.dart';
export 'src/components/card/card.dart';
export 'src/components/checkbox/checkbox.dart';
export 'src/components/data_list/data_list.dart';
export 'src/components/data_table/data_table.dart';
export 'src/components/disclosure/disclosure.dart';
export 'src/components/divider/divider.dart';
export 'src/components/link/link.dart';
export 'src/components/menu/menu.dart';
export 'src/components/navigation_list/navigation_list.dart';
export 'src/components/popover/popover.dart';
export 'src/components/progress/progress.dart';
export 'src/components/radio/radio.dart';
export 'src/components/segmented_control/segmented_control.dart';
export 'src/components/select/select.dart';
export 'src/components/skeleton/skeleton.dart';
export 'src/components/slider/slider.dart';
export 'src/components/spinner/spinner.dart';
export 'src/components/switch/switch.dart';
export 'src/components/tabs/tabs.dart';
export 'src/components/textfield/textfield.dart';
export 'src/components/toggle/toggle.dart';
export 'src/components/toggle_group/toggle_group.dart';
export 'src/components/tooltip/tooltip.dart';

/// EXTERNAL DEPENDENCIES
export 'package:mix/mix.dart';
export 'package:naked_ui/naked_ui.dart'
    show
        NakedMenuState,
        OverlayAlignment,
        OverlayPlacement,
        OverlayPositionConfig,
        OverlaySide;

/// RENDERING
export 'src/rendering/remix_blend_mode.dart' show RemixBlendMode;
export 'src/rendering/remix_ordered_color_filter.dart'
    show
        RemixCssColorFilterFunction,
        RemixCssColorFilterOperation,
        RemixOrderedColorFilterModifier;
export 'src/rendering/remix_box_effects.dart'
    show
        RemixBoxShadowKind,
        RemixBoxShadow,
        RemixBoxShadowMix,
        RemixBoxShadowListToken,
        RemixLinearGradientMix,
        RemixBoxEffectLayerSpec,
        RemixBoxEffectLayerMix,
        RemixBoxEffectsSpec,
        RemixBoxEffectsMix;

/// STYLER CONVENIENCES
export 'src/utilities/remix_style.dart'
    show RemixBoxStylerAnchors, RemixBoxStylerMixin;
export 'src/utilities/selected_mixin.dart'
    show SelectedWidgetStateVariantExtension;

/// DEPRECATED
export 'deprecated.dart'
    show
        RemixAccordionStyler,
        RemixAvatarStyler,
        RemixBadgeStyler,
        RemixButtonStyler,
        RemixCalloutStyler,
        RemixCardStyler,
        RemixCheckboxStyler,
        RemixDialogStyler,
        RemixDividerStyler,
        RemixIconButtonStyler,
        RemixMenuItemStyler,
        RemixMenuStyler,
        RemixMenuTriggerStyler,
        RemixPopoverStyler,
        RemixProgressStyler,
        RemixRadioStyler,
        RemixSelectContentStyler,
        RemixSelectMenuItemStyler,
        RemixSelectStyler,
        RemixSelectTriggerStyler,
        RemixSliderStyler,
        RemixSpinnerStyler,
        RemixSwitchStyler,
        RemixTabBarStyler,
        RemixTabStyler,
        RemixTabViewStyler,
        RemixTextFieldStyler,
        RemixToggleGroupItemStyler,
        RemixToggleGroupStyler,
        RemixToggleStyler,
        RemixTooltipStyler;
