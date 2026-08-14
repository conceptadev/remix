import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

const _carbonLoadingTrack = ContextToken(_resolveCarbonLoadingTrack);

Color _resolveCarbonLoadingTrack(BuildContext context) =>
    CarbonLayer.of(context).color(.layerAccent).resolve(context);

/// The Carbon circular loading recipe.
SpinnerStyler carbonLoadingStyle({bool small = false}) => .new()
    .size(small ? 16 : 88)
    .strokeWidth(small ? 2 : 10)
    .trackStrokeWidth(small ? 2 : 10)
    .indicatorColor(CarbonTokens.interactive())
    .trackColor(_carbonLoadingTrack())
    .duration(CarbonTokens.durationSlow02());

/// Carbon loading indicator with optional full-area overlay behavior.
class CarbonLoading extends StatelessWidget {
  const CarbonLoading({
    super.key,
    this.active = true,
    this.small = false,
    this.withOverlay = true,
    this.description = 'Active loading indicator',
  });

  /// Whether the indicator is present.
  final bool active;

  /// Uses Carbon's 16px inline size instead of the 88px regular size.
  final bool small;

  /// Centers the spinner in a Carbon overlay that fills available space.
  final bool withOverlay;

  /// Accessible status name.
  final String description;

  @override
  Widget build(BuildContext context) {
    if (!active) return const SizedBox.shrink();

    final spinner = carbonLoadingStyle(small: small)(
      semanticsLabel: description,
    );
    if (!withOverlay) return spinner;

    return ColoredBox(
      color: CarbonTokens.overlay.resolve(context),
      child: Center(child: spinner),
    );
  }
}
