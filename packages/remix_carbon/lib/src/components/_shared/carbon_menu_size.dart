import '../../foundation/carbon_layout_scope.dart';
import '../menu/carbon_menu.dart';

/// Maps the global Carbon control scale to the menu row scale.
CarbonMenuSize carbonMenuSizeFor(CarbonSize size) =>
    switch (size.clampTo(.xs, .lg)) {
      .xs => .xSmall,
      .sm => .small,
      .md => .medium,
      .lg || .xl || .x2l => .large,
    };
