// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed Card with the Radix size and variant contract.
class FortalCard extends StatelessWidget {
  const FortalCard({
    super.key,
    this.variant = .surface,
    this.size = .size1,
    this.style = const CardStyler.create(),
    this.child,
  });

  const FortalCard.surface({
    super.key,
    this.size = .size1,
    this.style = const CardStyler.create(),
    this.child,
  }) : variant = FortalCardVariant.surface;

  const FortalCard.classic({
    super.key,
    this.size = .size1,
    this.style = const CardStyler.create(),
    this.child,
  }) : variant = FortalCardVariant.classic;

  const FortalCard.ghost({
    super.key,
    this.size = .size1,
    this.style = const CardStyler.create(),
    this.child,
  }) : variant = FortalCardVariant.ghost;

  final FortalCardVariant variant;

  final FortalCardSize size;

  final CardStyler style;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return RemixCard(
      key: this.key,
      style: fortalCardStyle(
        variant: this.variant,
        size: this.size,
        style: this.style,
      ),
      child: this.child,
    );
  }
}
