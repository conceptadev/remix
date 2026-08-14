import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

enum CarbonProgressStepState {
  complete,
  current,
  incomplete,
  invalid,
  disabled,
}

extension on CarbonProgressStepState {
  bool get isCurrent => this == .current;

  bool get isDisabled => this == .disabled;

  ColorToken get color => switch (this) {
    .complete || .current => CarbonTokens.interactive,
    .invalid => CarbonTokens.supportError,
    .incomplete => CarbonTokens.iconSecondary,
    .disabled => CarbonTokens.iconDisabled,
  };

  String get statusLabel => switch (this) {
    .complete => 'complete',
    .current => 'current',
    .incomplete => 'not started',
    .invalid => 'invalid',
    .disabled => 'disabled',
  };

  IconData get icon => switch (this) {
    .complete => CarbonIcons.checkmarkOutline,
    .current => CarbonIcons.incomplete,
    .invalid => CarbonIcons.errorFilled,
    .incomplete || .disabled => CarbonIcons.circleDash,
  };
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
    final action = onPressed;
    final interactive = action != null && !resolvedState.isDisabled;
    final content = Semantics(
      role: .listItem,
      label: '$label, ${resolvedState.statusLabel}',
      selected: resolvedState.isCurrent,
      enabled: !resolvedState.isDisabled,
      button: interactive,
      onTap: interactive ? action : null,
      child: ExcludeSemantics(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                SizedBox.square(
                  dimension: 16,
                  child: Icon(
                    resolvedState.icon,
                    size: 16,
                    color: resolvedState.color.resolve(context),
                  ),
                ),
                if (includeConnector)
                  Expanded(
                    child: Box(
                      style: BoxStyler().height(1).color(resolvedState.color()),
                    ),
                  ),
              ],
            ),
            SizedBox(height: CarbonTokens.spacing03.resolve(context)),
            StyledText(
              label,
              style: TextStyler()
                  .style(CarbonTokens.bodyCompact01.mix())
                  .color(
                    resolvedState.isDisabled
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

    if (!interactive) return content;

    return GestureDetector(
      behavior: .opaque,
      excludeFromSemantics: true,
      onTap: action,
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

  CarbonProgressStepState _stateFor(CarbonProgressStep step, int index) {
    final explicitState = step.state;
    if (explicitState != null) return explicitState;

    return switch (index.compareTo(currentIndex)) {
      < 0 => .complete,
      0 => .current,
      _ => .incomplete,
    };
  }

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
          for (final (index, step) in steps.indexed)
            Expanded(
              child: step._build(
                context,
                _stateFor(step, index),
                includeConnector: index < steps.length - 1,
              ),
            ),
        ],
      ),
    );
  }
}
