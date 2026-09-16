// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callout.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Ui-themed Callout with the Radix size, variant, and override contract.
class UiCallout extends StatelessWidget {
  const UiCallout({
    super.key,
    this.variant = .soft,
    this.size = .size2,
    this.highContrast = false,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  });

  const UiCallout.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  }) : variant = UiCalloutVariant.soft;

  const UiCallout.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  }) : variant = UiCalloutVariant.surface;

  const UiCallout.outline({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  }) : variant = UiCalloutVariant.outline;

  final UiCalloutVariant variant;

  final UiCalloutSize size;

  final bool highContrast;

  final CalloutStyler style;

  final String? text;

  final IconData? icon;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return RemixCallout(
      key: this.key,
      style: uiCalloutStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
        style: this.style,
      ),
      text: this.text,
      icon: this.icon,
      child: this.child,
    );
  }
}
