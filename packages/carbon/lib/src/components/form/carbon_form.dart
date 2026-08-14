import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_tokens.g.dart';

/// A Carbon form landmark with standard vertical field spacing.
class CarbonForm extends StatelessWidget {
  const CarbonForm({
    super.key,
    required this.children,
    this.semanticLabel,
    this.spacing = 24,
  });

  final List<Widget> children;
  final String? semanticLabel;
  final double spacing;

  @override
  Widget build(BuildContext context) => Semantics(
    role: .form,
    label: semanticLabel,
    container: true,
    explicitChildNodes: true,
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      spacing: spacing,
      children: children,
    ),
  );
}

/// A labeled Carbon form section.
class CarbonFormGroup extends StatelessWidget {
  const CarbonFormGroup({
    super.key,
    required this.label,
    required this.children,
    this.helperText,
    this.spacing = 16,
  });

  final String label;
  final String? helperText;
  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    container: true,
    explicitChildNodes: true,
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        ExcludeSemantics(
          child: StyledText(
            label,
            style: TextStyler()
                .style(CarbonTokens.headingCompact01.mix())
                .color(CarbonTokens.textPrimary()),
          ),
        ),
        if (helperText != null) ...[
          SizedBox(height: CarbonTokens.spacing02.resolve(context)),
          ExcludeSemantics(
            child: StyledText(
              helperText!,
              style: TextStyler()
                  .style(CarbonTokens.helperText01.mix())
                  .color(CarbonTokens.textHelper()),
            ),
          ),
        ],
        SizedBox(height: CarbonTokens.spacing05.resolve(context)),
        Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          spacing: spacing,
          children: children,
        ),
      ],
    ),
  );
}
