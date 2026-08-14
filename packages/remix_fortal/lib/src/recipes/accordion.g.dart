// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accordion.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixAccordion].
class FortalAccordion<T> extends StatelessWidget {
  const FortalAccordion({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.collapsedIcon,
    this.expandedIcon,
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
    this.transitionBuilder = RemixAccordion.defaultAccordionTransitionBuilder,
  });

  const FortalAccordion.surface({
    super.key,
    this.size = .size2,
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.collapsedIcon,
    this.expandedIcon,
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
    this.transitionBuilder = RemixAccordion.defaultAccordionTransitionBuilder,
  }) : variant = FortalAccordionVariant.surface;

  const FortalAccordion.soft({
    super.key,
    this.size = .size2,
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.collapsedIcon,
    this.expandedIcon,
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
    this.transitionBuilder = RemixAccordion.defaultAccordionTransitionBuilder,
  }) : variant = FortalAccordionVariant.soft;

  final FortalAccordionVariant variant;

  final FortalAccordionSize size;

  final T value;

  final Widget child;

  final String? title;

  final IconData? leadingIcon;

  final IconData? trailingIcon;

  final IconData? collapsedIcon;

  final IconData? expandedIcon;

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

  final Widget Function(Widget, Animation<double>) transitionBuilder;

  @override
  Widget build(BuildContext context) {
    return RemixAccordion<T>(
      key: this.key,
      style: fortalAccordionStyle(variant: this.variant, size: this.size),
      value: this.value,
      child: this.child,
      title: this.title,
      leadingIcon: this.leadingIcon,
      trailingIcon: this.trailingIcon,
      collapsedIcon: this.collapsedIcon,
      expandedIcon: this.expandedIcon,
      builder: this.builder,
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
    );
  }
}
