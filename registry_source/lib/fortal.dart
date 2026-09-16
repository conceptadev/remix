/// Fortal: a Radix Themes-inspired preset theme and widget catalog for Remix.
///
/// Fortal is built on [package:remix](https://pub.dev/packages/remix). It adds a
/// token scope ([FortalScope]), the `fortal*Style()` recipes, and a matching
/// catalog of ready-made `Fortal*` widgets. It does not re-export `remix`; add
/// `package:remix/remix.dart` alongside this import when you need the base
/// widgets or stylers.
library;

/// ICONS
export 'src/fortal/icons.dart';

/// THEME
export 'src/fortal/theme/radix_colors.dart';
export 'src/fortal/theme/theme.dart';
export 'src/fortal/components/base_button.dart'
    hide
        FortalBaseButtonStateStyle,
        FortalBaseButtonStateStyles,
        fortalBaseButtonStateStyles;

/// RECIPES
export 'src/fortal/components/accordion.dart';
export 'src/fortal/components/avatar.dart';
export 'src/fortal/components/badge.dart';
export 'src/fortal/components/button.dart';
export 'src/fortal/components/callout.dart';
export 'src/fortal/components/card.dart';
export 'src/fortal/components/chart.dart';
export 'src/fortal/components/checkbox.dart';
export 'src/fortal/components/code.dart';
export 'src/fortal/components/data_list.dart';
export 'src/fortal/components/data_table.dart';
export 'src/fortal/components/dialog.dart';
export 'src/fortal/components/disclosure.dart';
export 'src/fortal/components/divider.dart';
export 'src/fortal/components/heading.dart';
export 'src/fortal/components/icon_button.dart';
export 'src/fortal/components/kbd.dart';
export 'src/fortal/components/link.dart';
export 'src/fortal/components/menu.dart';
export 'src/fortal/components/popover.dart';
export 'src/fortal/components/progress.dart';
export 'src/fortal/components/radio.dart';
export 'src/fortal/components/segmented_control.dart';
export 'src/fortal/components/select.dart';
export 'src/fortal/components/sidebar.dart';
export 'src/fortal/components/sidebar_layout.dart';
export 'src/fortal/components/skeleton.dart';
export 'src/fortal/components/slider.dart';
export 'src/fortal/components/spinner.dart';
export 'src/fortal/components/switch.dart';
export 'src/fortal/components/tabs.dart';
export 'src/fortal/components/text.dart';
export 'src/fortal/components/textfield.dart';
export 'src/fortal/components/toast.dart';
export 'src/fortal/components/toggle.dart';
export 'src/fortal/components/toggle_group.dart';
export 'src/fortal/components/tooltip.dart';
export 'src/fortal/components/typography.dart';
