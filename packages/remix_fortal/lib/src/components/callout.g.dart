// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callout.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed Callout with the Radix size, variant, and override contract.
class FortalCallout extends StatelessWidget {
  const FortalCallout({
    super.key,
    this.variant = .soft,
    this.size = .size2,
    this.highContrast = false,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  });

  const FortalCallout.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  }) : variant = FortalCalloutVariant.soft;

  const FortalCallout.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  }) : variant = FortalCalloutVariant.surface;

  const FortalCallout.outline({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    this.style = const CalloutStyler.create(),
    this.text,
    this.icon,
    this.child,
  }) : variant = FortalCalloutVariant.outline;

  final FortalCalloutVariant variant;

  final FortalCalloutSize size;

  final bool highContrast;

  final CalloutStyler style;

  final String? text;

  final IconData? icon;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return RemixCallout(
      key: this.key,
      style: fortalCalloutStyle(
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
