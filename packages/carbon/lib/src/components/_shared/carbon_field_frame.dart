import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_tokens.g.dart';

/// Internal Carbon field layout for a label, control, and support message.
class CarbonFieldFrame extends StatelessWidget {
  const CarbonFieldFrame({
    super.key,
    required this.child,
    this.label,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.hideLabel = false,
    this.inline = false,
  });

  final Widget child;
  final String? label;
  final String? helperText;
  final String? errorText;
  final bool enabled;
  final bool hideLabel;
  final bool inline;

  @override
  Widget build(BuildContext context) {
    final labelWidget = label == null || hideLabel
        ? null
        : ExcludeSemantics(
            child: StyledText(
              label!,
              style: TextStyler()
                  .style(CarbonTokens.label01.mix())
                  .color(
                    enabled
                        ? CarbonTokens.textSecondary()
                        : CarbonTokens.textDisabled(),
                  ),
            ),
          );
    final supportText = errorText ?? helperText;
    final supportWidget = supportText == null
        ? null
        : ExcludeSemantics(
            child: StyledText(
              supportText,
              style: TextStyler()
                  .style(CarbonTokens.helperText01.mix())
                  .color(
                    errorText == null
                        ? CarbonTokens.textHelper()
                        : CarbonTokens.textError(),
                  ),
            ),
          );

    if (inline) {
      return Row(
        mainAxisSize: .min,
        spacing: CarbonTokens.spacing03.resolve(context),
        children: [?labelWidget, child],
      );
    }

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        if (labelWidget != null) ...[
          labelWidget,
          SizedBox(height: CarbonTokens.spacing03.resolve(context)),
        ],
        child,
        if (supportWidget != null) ...[
          SizedBox(height: CarbonTokens.spacing02.resolve(context)),
          supportWidget,
        ],
      ],
    );
  }
}
