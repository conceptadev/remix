// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carbon_accordion.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Carbon's visual recipe for an accordion item.
class CarbonAccordion<T> extends StatelessWidget {
  const CarbonAccordion({
    super.key,
    this.size = .medium,
    required this.value,
    required this.child,
    required this.title,
    this.leadingIcon,
    this.trailingIcon,
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

  final CarbonAccordionSize size;

  final T value;

  final Widget child;

  final String title;

  final IconData? leadingIcon;

  final IconData? trailingIcon;

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
    return _CarbonAccordionBase<T>(
      key: this.key,
      style: carbonAccordionStyle(size: this.size),
      value: this.value,
      child: this.child,
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
    );
  }
}
