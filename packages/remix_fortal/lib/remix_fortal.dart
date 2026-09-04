/// Fortal: a Radix Themes-inspired preset theme and widget catalog for Remix.
///
/// Fortal is built on [package:remix](https://pub.dev/packages/remix). It adds a
/// token scope ([FortalScope]), the `fortal*Style()` recipes, and a matching
/// catalog of ready-made `Fortal*` widgets. It does not re-export `remix`; add
/// `package:remix/remix.dart` alongside this import when you need the base
/// widgets or stylers.
library remix_fortal;

/// ICONS
export 'src/icons.dart';

/// THEME
export 'src/theme/radix_colors.dart';
export 'src/theme/theme.dart';
export 'src/components/base_button.dart'
    hide
        FortalBaseButtonStateStyle,
        FortalBaseButtonStateStyles,
        fortalBaseButtonStateStyles;

/// RECIPES
export 'src/components/accordion.dart';
export 'src/components/avatar.dart';
export 'src/components/badge.dart';
export 'src/components/button.dart';
export 'src/components/callout.dart';
export 'src/components/card.dart';
export 'src/components/chart.dart';
export 'src/components/checkbox.dart';
export 'src/components/code.dart';
export 'src/components/data_list.dart';
export 'src/components/data_table.dart';
export 'src/components/dialog.dart';
export 'src/components/disclosure.dart';
export 'src/components/divider.dart';
export 'src/components/heading.dart';
export 'src/components/icon_button.dart';
export 'src/components/kbd.dart';
export 'src/components/link.dart';
export 'src/components/menu.dart';
export 'src/components/popover.dart';
export 'src/components/progress.dart';
export 'src/components/radio.dart';
export 'src/components/segmented_control.dart';
export 'src/components/select.dart';
export 'src/components/sidebar.dart';
export 'src/components/skeleton.dart';
export 'src/components/slider.dart';
export 'src/components/spinner.dart';
export 'src/components/switch.dart';
export 'src/components/tabs.dart';
export 'src/components/text.dart';
export 'src/components/textfield.dart';
export 'src/components/toggle.dart';
export 'src/components/toggle_group.dart';
export 'src/components/tooltip.dart';
export 'src/components/typography.dart';
