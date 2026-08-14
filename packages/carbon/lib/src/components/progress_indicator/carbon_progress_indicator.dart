import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_tokens.g.dart';

enum CarbonProgressStepState {
  complete,
  current,
  incomplete,
  invalid,
  disabled,
}

/// One labeled step rendered by [CarbonProgressIndicator].
class CarbonProgressStep extends StatelessWidget {
  const CarbonProgressStep({
    super.key,
    required this.label,
    this.secondaryLabel,
    this.description,
    this.state,
    this.onPressed,
  });

  final String label;
  final String? secondaryLabel;
  final String? description;
  final CarbonProgressStepState? state;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) =>
      _build(context, state ?? .incomplete, includeConnector: false);

  Widget _build(
    BuildContext context,
    CarbonProgressStepState resolvedState, {
    required bool includeConnector,
  }) {
    final current = resolvedState == .current;
    final disabled = resolvedState == .disabled;
    final color = switch (resolvedState) {
      .complete || .current => CarbonTokens.interactive,
      .invalid => CarbonTokens.supportError,
      .incomplete => CarbonTokens.iconSecondary,
      .disabled => CarbonTokens.iconDisabled,
    };
    final status = switch (resolvedState) {
      .complete => 'complete',
      .current => 'current',
      .incomplete => 'not started',
      .invalid => 'invalid',
      .disabled => 'disabled',
    };
    final content = Semantics(
      role: .listItem,
      label: '$label, $status',
      selected: current,
      enabled: !disabled,
      button: onPressed != null && !disabled,
      onTap: onPressed != null && !disabled ? onPressed : null,
      child: ExcludeSemantics(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                Box(
                  style: BoxStyler()
                      .width(16)
                      .height(16)
                      .borderRadius(.all(.circular(8)))
                      .color(color())
                      .alignment(.center),
                  child: StyledText(
                    switch (resolvedState) {
                      .complete => '✓',
                      .invalid => '!',
                      .current || .incomplete || .disabled => '',
                    },
                    style: TextStyler()
                        .style(CarbonTokens.label01.mix())
                        .color(CarbonTokens.textOnColor()),
                  ),
                ),
                if (includeConnector)
                  Expanded(
                    child: Box(style: BoxStyler().height(1).color(color())),
                  ),
              ],
            ),
            SizedBox(height: CarbonTokens.spacing03.resolve(context)),
            StyledText(
              label,
              style: TextStyler()
                  .style(CarbonTokens.bodyCompact01.mix())
                  .color(
                    disabled
                        ? CarbonTokens.textDisabled()
                        : CarbonTokens.textPrimary(),
                  ),
            ),
            if (secondaryLabel != null)
              StyledText(
                secondaryLabel!,
                style: TextStyler()
                    .style(CarbonTokens.label01.mix())
                    .color(CarbonTokens.textSecondary()),
              ),
            if (description != null)
              StyledText(
                description!,
                style: TextStyler()
                    .style(CarbonTokens.helperText01.mix())
                    .color(CarbonTokens.textHelper()),
              ),
          ],
        ),
      ),
    );

    if (onPressed == null || disabled) return content;

    return GestureDetector(
      behavior: .opaque,
      excludeFromSemantics: true,
      onTap: onPressed,
      child: content,
    );
  }
}

/// Ordered Carbon workflow progress.
class CarbonProgressIndicator extends StatelessWidget {
  const CarbonProgressIndicator({
    super.key,
    required this.steps,
    this.currentIndex = 0,
    this.semanticLabel = 'Progress',
  });

  final List<CarbonProgressStep> steps;
  final int currentIndex;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    assert(steps.isNotEmpty, 'CarbonProgressIndicator.steps cannot be empty.');
    assert(
      currentIndex >= 0 && currentIndex < steps.length,
      'CarbonProgressIndicator.currentIndex is out of range.',
    );

    return Semantics(
      role: .list,
      label: semanticLabel,
      container: true,
      explicitChildNodes: true,
      child: Row(
        crossAxisAlignment: .start,
        children: [
          for (var index = 0; index < steps.length; index++)
            Expanded(
              child: steps[index]._build(
                context,
                steps[index].state ??
                    (index < currentIndex
                        ? CarbonProgressStepState.complete
                        : index == currentIndex
                        ? CarbonProgressStepState.current
                        : CarbonProgressStepState.incomplete),
                includeConnector: index < steps.length - 1,
              ),
            ),
        ],
      ),
    );
  }
}
