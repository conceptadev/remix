part of 'select.dart';

/// Fortal select size presets.
enum FortalSelectSize {
  /// Compact select.
  size1,

  /// Default select.
  size2,

  /// Large select.
  size3,
}

/// Fortal select color and emphasis variants.
enum FortalSelectVariant {
  /// Surface-backed trigger with border.
  surface,

  /// Soft accent trigger.
  soft,

  /// Transparent trigger.
  ghost,
}

/// Fortal-themed preset for [RemixSelect].
RemixSelectStyler fortalSelectStyler({
  FortalSelectVariant variant = .surface,
  FortalSelectSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .surface => _fortalSelectSurfaceStyler(size, highContrast: highContrast),
    .soft => _fortalSelectSoftStyler(size, highContrast: highContrast),
    .ghost => _fortalSelectGhostStyler(size, highContrast: highContrast),
  };
}

RemixSelectStyler _fortalSelectBaseStyler(
  FortalSelectVariant variant,
  FortalSelectSize size, {
  bool highContrast = false,
}) {
  return RemixSelectStyler()
      .trigger(
        RemixSelectTriggerStyler()
            .direction(.horizontal)
            .mainAxisAlignment(.spaceBetween)
            .crossAxisAlignment(.center)
            .borderRadiusAll(FortalTokens.radius3())
            .label(TextStyler().color(FortalTokens.gray12()))
            .icon(IconStyler(color: FortalTokens.gray12(), size: 16.0)),
      )
      .menuContainer(
        FlexBoxStyler()
            .width(150)
            .color(FortalTokens.colorPanel())
            .marginTop(8)
            .borderAll(
              color: FortalTokens.gray6(),
              width: FortalTokens.borderWidth1(),
            )
            .borderRadiusAll(FortalTokens.radius3())
            .padding(EdgeInsetsMix.all(8.0)),
      )
      .item(
        fortalSelectMenuItemStyler(
          variant: variant,
          size: size,
          highContrast: highContrast,
        ),
      )
      .onFocused(
        RemixSelectStyler().trigger(
          RemixSelectTriggerStyler().borderAll(
            color: FortalTokens.focusA8(),
            width: FortalTokens.focusRingWidth(),
          ),
        ),
      )
      .merge(_fortalSelectSizeStyler(size));
}

RemixSelectStyler _fortalSelectSurfaceStyler(
  FortalSelectSize size, {
  bool highContrast = false,
}) {
  return _fortalSelectBaseStyler(
    .surface,
    size,
    highContrast: highContrast,
  ).trigger(
    RemixSelectTriggerStyler()
        .color(FortalTokens.colorSurface())
        .borderAll(
          color: FortalTokens.gray6(),
          width: FortalTokens.borderWidth1(),
        ),
  );
}

RemixSelectStyler _fortalSelectSoftStyler(
  FortalSelectSize size, {
  bool highContrast = false,
}) {
  return _fortalSelectBaseStyler(
    .soft,
    size,
    highContrast: highContrast,
  ).trigger(
    RemixSelectTriggerStyler()
        .color(FortalTokens.accent3())
        .label(
          TextStyler().color(
            highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
          ),
        )
        .icon(
          IconStyler(
            color: highContrast
                ? FortalTokens.accent12()
                : FortalTokens.accent11(),
            size: 16.0,
          ),
        ),
  );
}

RemixSelectStyler _fortalSelectGhostStyler(
  FortalSelectSize size, {
  bool highContrast = false,
}) {
  return _fortalSelectBaseStyler(
    .ghost,
    size,
    highContrast: highContrast,
  ).trigger(RemixSelectTriggerStyler().color(Colors.transparent).paddingY(6.0));
}

RemixSelectStyler _fortalSelectSizeStyler(FortalSelectSize size) {
  return switch (size) {
    .size1 => RemixSelectStyler().trigger(
      RemixSelectTriggerStyler().paddingX(8.0).height(24.0),
    ),
    .size2 => RemixSelectStyler().trigger(
      RemixSelectTriggerStyler().paddingX(12.0).height(32.0),
    ),
    .size3 => RemixSelectStyler().trigger(
      RemixSelectTriggerStyler().paddingX(16.0).height(40.0),
    ),
  };
}

/// Creates a Fortal-themed [RemixSelectMenuItemStyler].
RemixSelectMenuItemStyler fortalSelectMenuItemStyler({
  FortalSelectVariant variant = .surface,
  FortalSelectSize size = .size2,
  bool highContrast = false,
}) {
  return switch (variant) {
    .surface => _fortalSelectMenuItemSurfaceStyler(size),
    .soft => _fortalSelectMenuItemSoftStyler(size, highContrast: highContrast),
    .ghost => _fortalSelectMenuItemGhostStyler(size),
  };
}

RemixSelectMenuItemStyler _fortalSelectMenuItemBaseStyler(
  FortalSelectSize size,
) {
  return RemixSelectMenuItemStyler()
      .icon(IconStyler(size: 16.0))
      .borderRadiusAll(FortalTokens.radius2())
      .merge(_fortalSelectMenuItemSizeStyler(size));
}

RemixSelectMenuItemStyler _fortalSelectMenuItemSurfaceStyler([
  FortalSelectSize size = .size2,
]) {
  return _fortalSelectMenuItemBaseStyler(size)
      .color(Colors.transparent)
      .text(TextStyler().color(FortalTokens.gray12()))
      .onHovered(
        RemixSelectMenuItemStyler()
            .color(FortalTokens.grayA3())
            .text(TextStyler().color(FortalTokens.gray12())),
      );
}

RemixSelectMenuItemStyler _fortalSelectMenuItemSoftStyler(
  FortalSelectSize size, {
  bool highContrast = false,
}) {
  return _fortalSelectMenuItemBaseStyler(size)
      .color(Colors.transparent)
      .text(TextStyler().color(FortalTokens.gray12()))
      .onHovered(
        RemixSelectMenuItemStyler()
            .color(FortalTokens.accentA3())
            .iconColor(
              highContrast ? FortalTokens.accent12() : FortalTokens.accent11(),
            )
            .text(
              TextStyler().color(
                highContrast
                    ? FortalTokens.accent12()
                    : FortalTokens.accent11(),
              ),
            ),
      );
}

RemixSelectMenuItemStyler _fortalSelectMenuItemGhostStyler([
  FortalSelectSize size = .size2,
]) {
  return _fortalSelectMenuItemBaseStyler(size)
      .color(Colors.transparent)
      .text(TextStyler().color(FortalTokens.gray12()))
      .onHovered(
        RemixSelectMenuItemStyler()
            .color(FortalTokens.grayA2())
            .text(TextStyler().color(FortalTokens.gray12())),
      );
}

RemixSelectMenuItemStyler _fortalSelectMenuItemSizeStyler(
  FortalSelectSize size,
) {
  return switch (size) {
    .size1 => RemixSelectMenuItemStyler().paddingX(6.0).height(20.0),
    .size2 => RemixSelectMenuItemStyler().paddingX(8.0).height(24.0),
    .size3 => RemixSelectMenuItemStyler().paddingX(10.0).height(28.0),
  };
}

/// Fortal-themed preset for [RemixSelect].
class FortalSelect<T> extends StatelessWidget {
  const FortalSelect({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      targetAnchor: .bottomCenter,
      followerAnchor: .topCenter,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.enabled = true,
    this.closeOnSelect = true,
    this.semanticLabel,
    this.focusNode,
  });

  /// Surface-backed trigger with border.
  const FortalSelect.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      targetAnchor: .bottomCenter,
      followerAnchor: .topCenter,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.enabled = true,
    this.closeOnSelect = true,
    this.semanticLabel,
    this.focusNode,
  }) : variant = FortalSelectVariant.surface;

  /// Soft accent trigger.
  const FortalSelect.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      targetAnchor: .bottomCenter,
      followerAnchor: .topCenter,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.enabled = true,
    this.closeOnSelect = true,
    this.semanticLabel,
    this.focusNode,
  }) : variant = FortalSelectVariant.soft;

  /// Transparent trigger.
  const FortalSelect.ghost({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.selectedValue,
    this.positioning = const OverlayPositionConfig(
      targetAnchor: .bottomCenter,
      followerAnchor: .topCenter,
    ),
    this.onChanged,
    this.onOpen,
    this.onClose,
    this.enabled = true,
    this.closeOnSelect = true,
    this.semanticLabel,
    this.focusNode,
  }) : variant = FortalSelectVariant.ghost;

  final FortalSelectVariant variant;

  final FortalSelectSize size;

  /// Optional accent color override for this select subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this select subtree.
  final FortalRadius? radius;

  /// Whether to use higher-contrast accent colors.
  final bool highContrast;

  final RemixSelectTrigger trigger;

  final List<RemixSelectItem<T>> items;

  final T? selectedValue;

  final OverlayPositionConfig positioning;

  final ValueChanged<T?>? onChanged;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;

  final bool enabled;

  final bool closeOnSelect;

  final String? semanticLabel;

  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return FortalOverride(
      color: this.color,
      radius: this.radius,
      child:
          fortalSelectStyler(
            variant: this.variant,
            size: this.size,
            highContrast: this.highContrast,
          ).call<T>(
            key: this.key,
            trigger: this.trigger,
            items: this.items,
            selectedValue: this.selectedValue,
            positioning: this.positioning,
            onChanged: this.onChanged,
            onOpen: this.onOpen,
            onClose: this.onClose,
            enabled: this.enabled,
            closeOnSelect: this.closeOnSelect,
            semanticLabel: this.semanticLabel,
            focusNode: this.focusNode,
          ),
    );
  }
}
