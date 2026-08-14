import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

/// Carbon progress-bar heights.
enum CarbonProgressBarSize { big, small }

/// Carbon progress-bar states.
enum CarbonProgressBarStatus { active, finished, error }

const _carbonProgressTrack = ContextToken(_resolveCarbonProgressTrack);

Color _resolveCarbonProgressTrack(BuildContext context) =>
    CarbonLayer.of(context).color(.layerAccent).resolve(context);

/// Carbon's visual recipe for the underlying [RemixProgress].
ProgressStyler carbonProgressBarStyle({
  CarbonProgressBarSize size = .big,
  CarbonProgressBarStatus status = .active,
}) {
  final height = size == .big ? 8.0 : 4.0;
  final indicator = switch (status) {
    .active => CarbonTokens.interactive,
    .finished => CarbonTokens.supportSuccess,
    .error => CarbonTokens.supportError,
  };

  return ProgressStyler(
    container: BoxStyler().width(.infinity).height(height),
    track: BoxStyler()
        .width(.infinity)
        .height(height)
        .color(_carbonProgressTrack()),
    indicator: BoxStyler().height(height).color(indicator()),
  );
}

/// Carbon determinate progress with label and supporting text anatomy.
class CarbonProgressBar extends StatelessWidget {
  const CarbonProgressBar({
    super.key,
    required this.value,
    this.label,
    this.helperText,
    this.size = .big,
    this.status = .active,
    this.semanticLabel,
    this.semanticValue,
  }) : assert(value >= 0 && value <= 1);

  final double value;
  final String? label;
  final String? helperText;
  final CarbonProgressBarSize size;
  final CarbonProgressBarStatus status;
  final String? semanticLabel;
  final String? semanticValue;

  @override
  Widget build(BuildContext context) {
    final visibleLabel = label;

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        if (visibleLabel != null) ...[
          ExcludeSemantics(
            child: StyledText(
              visibleLabel,
              style: TextStyler()
                  .style(CarbonTokens.bodyCompact01.mix())
                  .color(CarbonTokens.textPrimary()),
            ),
          ),
          SizedBox(height: CarbonTokens.spacing03.resolve(context)),
        ],
        RemixProgress(
          value: value,
          semanticsLabel: semanticLabel ?? visibleLabel,
          semanticsValue: semanticValue,
          style: carbonProgressBarStyle(size: size, status: status),
        ),
        if (helperText != null) ...[
          SizedBox(height: CarbonTokens.spacing02.resolve(context)),
          ExcludeSemantics(
            child: StyledText(
              helperText!,
              style: TextStyler()
                  .style(CarbonTokens.helperText01.mix())
                  .color(
                    status == .error
                        ? CarbonTokens.textError()
                        : CarbonTokens.textHelper(),
                  ),
            ),
          ),
        ],
      ],
    );
  }
}
