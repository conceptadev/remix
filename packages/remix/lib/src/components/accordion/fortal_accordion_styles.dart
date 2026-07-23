part of 'accordion.dart';

/// Fortal accordion size presets.
enum FortalAccordionSize { size1, size2, size3 }

/// Fortal accordion color variants.
enum FortalAccordionVariant { surface, soft }

/// Fortal-themed preset for [RemixAccordion].
RemixAccordionStyler fortalAccordionStyler({
  FortalAccordionVariant variant = .surface,
  FortalAccordionSize size = .size2,
}) {
  return switch (variant) {
    .surface => _fortalAccordionSurfaceStyler(size),
    .soft => _fortalAccordionSoftStyler(size),
  };
}

RemixAccordionStyler _fortalAccordionBaseStyler(FortalAccordionSize size) {
  return RemixAccordionStyler()
      .trigger(FlexBoxStyler().direction(.horizontal).clipBehavior(.antiAlias))
      .leadingIcon(IconStyler().color(FortalTokens.gray11()))
      .title(
        TextStyler()
            .fontWeight(FortalTokens.fontWeightMedium())
            .color(FortalTokens.gray12()),
      )
      .trailingIcon(IconStyler().color(FortalTokens.gray11()))
      .content(BoxStyler().width(.infinity))
      .merge(_fortalAccordionSizeStyler(size));
}

RemixAccordionStyler _fortalAccordionFocusStyler() {
  return RemixAccordionStyler().trigger(
    FlexBoxStyler().borderAll(
      color: FortalTokens.focusA8(),
      width: FortalTokens.focusRingWidth(),
      strokeAlign: BorderSide.strokeAlignInside,
    ),
  );
}

RemixAccordionStyler _fortalAccordionDisabledStyler() {
  return RemixAccordionStyler()
      .trigger(FlexBoxStyler().color(FortalTokens.grayA3()))
      .leadingIcon(IconStyler().color(FortalTokens.gray8()))
      .title(TextStyler().color(FortalTokens.gray8()))
      .trailingIcon(IconStyler().color(FortalTokens.gray8()));
}

RemixAccordionStyler _fortalAccordionSurfaceStyler([
  FortalAccordionSize size = .size2,
]) {
  return _fortalAccordionBaseStyler(size)
      .trigger(FlexBoxStyler().color(FortalTokens.gray1()))
      .content(
        BoxStyler()
            .borderTop(
              color: FortalTokens.gray6(),
              width: FortalTokens.borderWidth1(),
            )
            .color(FortalTokens.gray2())
            .wrap(
              .defaultTextStyle(
                style: TextStyleMix().color(FortalTokens.gray12()),
              ),
            ),
      )
      .onHovered(
        RemixAccordionStyler().trigger(
          FlexBoxStyler().color(FortalTokens.gray2()),
        ),
      )
      .onPressed(
        RemixAccordionStyler().trigger(
          FlexBoxStyler().color(FortalTokens.gray3()),
        ),
      )
      .onFocused(_fortalAccordionFocusStyler())
      .onDisabled(_fortalAccordionDisabledStyler());
}

RemixAccordionStyler _fortalAccordionSoftStyler([
  FortalAccordionSize size = .size2,
]) {
  return _fortalAccordionBaseStyler(size)
      .trigger(FlexBoxStyler().color(FortalTokens.accent2()))
      .title(TextStyler().color(FortalTokens.accent12()))
      .trailingIcon(IconStyler().color(FortalTokens.accent11()))
      .content(
        BoxStyler()
            .borderTop(
              color: FortalTokens.accent6(),
              width: FortalTokens.borderWidth1(),
            )
            .color(FortalTokens.accent2())
            .wrap(
              .defaultTextStyle(
                style: TextStyleMix().color(FortalTokens.accent12()),
              ),
            ),
      )
      .onHovered(
        RemixAccordionStyler().trigger(
          FlexBoxStyler().color(FortalTokens.accent3()),
        ),
      )
      .onPressed(
        RemixAccordionStyler().trigger(
          FlexBoxStyler().color(FortalTokens.accent4()),
        ),
      )
      .onFocused(_fortalAccordionFocusStyler())
      .onDisabled(_fortalAccordionDisabledStyler());
}

RemixAccordionStyler _fortalAccordionSizeStyler(FortalAccordionSize size) {
  return switch (size) {
    .size1 => RemixAccordionStyler(
      trigger: FlexBoxStyler()
          .paddingX(FortalTokens.space2())
          .paddingY(FortalTokens.space2())
          .borderRadiusAll(FortalTokens.radius3()),
      leadingIcon: IconStyler().size(FortalTokens.space4()),
      title: TextStyler(style: FortalTokens.text2.mix()),
      trailingIcon: IconStyler().size(FortalTokens.space4()),
      content: BoxStyler()
          .paddingAll(FortalTokens.space2())
          .borderRadiusBottom(FortalTokens.radius3())
          .clipBehavior(.antiAlias),
    ),
    .size2 => RemixAccordionStyler(
      trigger: FlexBoxStyler()
          .paddingX(FortalTokens.space3())
          .paddingY(FortalTokens.space3())
          .borderRadiusAll(FortalTokens.radius4()),
      leadingIcon: IconStyler().size(FortalTokens.spinnerSize3()),
      title: TextStyler(style: FortalTokens.accordionText2.mix()),
      trailingIcon: IconStyler().size(FortalTokens.spinnerSize3()),
      content: BoxStyler()
          .paddingAll(FortalTokens.space3())
          .borderRadiusBottom(FortalTokens.radius4())
          .clipBehavior(.antiAlias),
    ),
    .size3 => RemixAccordionStyler(
      trigger: FlexBoxStyler()
          .paddingX(FortalTokens.space4())
          .paddingY(FortalTokens.space4())
          .borderRadiusAll(FortalTokens.radius5()),
      leadingIcon: IconStyler().size(FortalTokens.space5()),
      title: TextStyler(style: FortalTokens.text3.mix()),
      trailingIcon: IconStyler().size(FortalTokens.space5()),
      content: BoxStyler()
          .paddingAll(FortalTokens.space4())
          .borderRadiusBottom(FortalTokens.radius5())
          .clipBehavior(.antiAlias),
    ),
  };
}

/// Fortal-themed preset for [RemixAccordion].
class FortalAccordion<T> extends StatelessWidget {
  const FortalAccordion({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    this.color,
    this.radius,
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.builder,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.transitionBuilder,
  });

  const FortalAccordion.surface({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.builder,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.transitionBuilder,
  }) : variant = .surface;

  const FortalAccordion.soft({
    super.key,
    this.size = .size2,
    this.color,
    this.radius,
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.builder,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.transitionBuilder,
  }) : variant = .soft;

  final FortalAccordionVariant variant;

  final FortalAccordionSize size;

  /// Optional accent color override for this accordion subtree.
  final FortalAccentColor? color;

  /// Optional radius override for this accordion subtree.
  final FortalRadius? radius;

  final T value;

  final Widget child;

  final String? title;

  final IconData? leadingIcon;

  final IconData? trailingIcon;

  final NakedAccordionTriggerBuilder<T>? builder;

  final bool enabled;

  final MouseCursor mouseCursor;

  final bool enableFeedback;

  final bool autofocus;

  final FocusNode? focusNode;

  final ValueChanged<bool>? onFocusChange;

  final ValueChanged<bool>? onHoverChange;

  final ValueChanged<bool>? onPressChange;

  final String? semanticLabel;

  final Widget Function(Widget, Animation<double>)? transitionBuilder;

  @override
  Widget build(BuildContext context) {
    return FortalComponentOverride(
      color: this.color,
      radius: this.radius,
      child: fortalAccordionStyler(variant: this.variant, size: this.size)
          .call<T>(
            key: this.key,
            value: this.value,
            title: this.title,
            leadingIcon: this.leadingIcon,
            trailingIcon: this.trailingIcon,
            enabled: this.enabled,
            mouseCursor: this.mouseCursor,
            enableFeedback: this.enableFeedback,
            autofocus: this.autofocus,
            focusNode: this.focusNode,
            onFocusChange: this.onFocusChange,
            onHoverChange: this.onHoverChange,
            onPressChange: this.onPressChange,
            semanticLabel: this.semanticLabel,
            transitionBuilder: this.transitionBuilder,
            child: this.child,
            builder: this.builder,
          ),
    );
  }
}
