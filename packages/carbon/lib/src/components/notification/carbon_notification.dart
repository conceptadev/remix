import 'dart:ui' show SemanticsRole;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../icons/icons.dart';
import '../../tokens/generated/carbon_component_tokens.g.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_icon_button_style.dart';
import '../button/carbon_button.dart';

enum CarbonNotificationKind { info, success, warning, error }

enum CarbonNotificationVariant { inline, toast }

/// Carbon inline or toast notification adapted over [RemixCallout].
class CarbonNotification extends StatelessWidget {
  const CarbonNotification({
    super.key,
    required this.title,
    this.subtitle,
    this.kind = .info,
    this.variant = .inline,
    this.lowContrast = true,
    this.actionLabel,
    this.onAction,
    this.onClose,
    this.hideCloseButton = false,
    this.semanticLabel,
  }) : assert((actionLabel == null) == (onAction == null));

  final String title;
  final String? subtitle;
  final CarbonNotificationKind kind;
  final CarbonNotificationVariant variant;
  final bool lowContrast;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onClose;
  final bool hideCloseButton;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (kind) {
      .info => CarbonTokens.supportInfo,
      .success => CarbonTokens.supportSuccess,
      .warning => CarbonTokens.supportWarning,
      .error => CarbonTokens.supportError,
    };
    final background = lowContrast
        ? switch (kind) {
            .info => CarbonComponentTokens.notificationBackgroundInfo,
            .success => CarbonComponentTokens.notificationBackgroundSuccess,
            .warning => CarbonComponentTokens.notificationBackgroundWarning,
            .error => CarbonComponentTokens.notificationBackgroundError,
          }
        : CarbonTokens.backgroundInverse;
    final foreground = lowContrast
        ? CarbonTokens.textPrimary
        : CarbonTokens.textInverse;
    final role = kind == .error || kind == .warning
        ? SemanticsRole.alert
        : SemanticsRole.status;
    var calloutStyle = CalloutStyler()
        .padding(.all(CarbonTokens.spacing05()))
        .spacing(CarbonTokens.spacing05())
        .crossAxisAlignment(.start)
        .color(background())
        .border(
          BoxBorderMix.left(BorderSideMix(color: statusColor(), width: 3)),
        );
    if (variant == .toast) {
      calloutStyle = calloutStyle.width(384);
    }

    return Semantics(
      role: role,
      label: semanticLabel ?? title,
      container: true,
      explicitChildNodes: true,
      child: RemixCallout(
        style: calloutStyle,
        child: Row(
          crossAxisAlignment: .start,
          children: [
            ExcludeSemantics(
              child: Icon(
                switch (kind) {
                  .info => CarbonIcons.informationFilled,
                  .success => CarbonIcons.checkmarkFilled,
                  .warning => CarbonIcons.warningFilled,
                  .error => CarbonIcons.errorFilled,
                },
                size: CarbonTokens.iconSize02.resolve(context),
                color: statusColor.resolve(context),
              ),
            ),
            SizedBox(width: CarbonTokens.spacing05.resolve(context)),
            Expanded(
              child: ExcludeSemantics(
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    StyledText(
                      title,
                      style: TextStyler()
                          .style(CarbonTokens.headingCompact01.mix())
                          .color(foreground()),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: CarbonTokens.spacing02.resolve(context)),
                      StyledText(
                        subtitle!,
                        style: TextStyler()
                            .style(CarbonTokens.bodyCompact01.mix())
                            .color(foreground()),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (actionLabel != null) ...[
              SizedBox(width: CarbonTokens.spacing05.resolve(context)),
              CarbonButton(
                label: actionLabel!,
                semanticLabel: actionLabel,
                kind: lowContrast ? .tertiary : .ghost,
                size: .sm,
                onPressed: onAction,
              ),
            ],
            if (!hideCloseButton && onClose != null) ...[
              SizedBox(width: CarbonTokens.spacing03.resolve(context)),
              CarbonIconButton(
                icon: CarbonIcons.close,
                semanticLabel: 'Close $title',
                kind: .ghost,
                size: .sm,
                onPressed: onClose,
                style: carbonIconButtonForegroundStyle(foreground),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
