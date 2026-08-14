import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../button/carbon_button.dart';

/// Lifecycle states displayed by [CarbonFileUploadItem].
enum CarbonFileUploadStatus { uploading, complete, error, editing }

/// Platform-neutral Carbon file picker surface.
///
/// File-system access remains with the host application through [onBrowse],
/// keeping this package usable on every Flutter platform without a picker
/// plugin dependency.
class CarbonFileUploader extends StatelessWidget {
  const CarbonFileUploader({
    super.key,
    required this.labelTitle,
    required this.buttonLabel,
    this.labelDescription,
    this.items = const [],
    this.onBrowse,
    this.enabled = true,
    this.multiple = true,
    this.accept,
  });

  final String labelTitle;
  final String? labelDescription;
  final String buttonLabel;
  final List<CarbonFileUploadItem> items;
  final VoidCallback? onBrowse;
  final bool enabled;
  final bool multiple;
  final List<String>? accept;

  @override
  Widget build(BuildContext context) => Semantics(
    label: labelTitle,
    container: true,
    explicitChildNodes: true,
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        ExcludeSemantics(
          child: StyledText(
            labelTitle,
            style: TextStyler()
                .style(CarbonTokens.headingCompact01.mix())
                .color(CarbonTokens.textPrimary()),
          ),
        ),
        if (labelDescription != null) ...[
          SizedBox(height: CarbonTokens.spacing02.resolve(context)),
          ExcludeSemantics(
            child: StyledText(
              labelDescription!,
              style: TextStyler()
                  .style(CarbonTokens.bodyCompact01.mix())
                  .color(CarbonTokens.textHelper()),
            ),
          ),
        ],
        SizedBox(height: CarbonTokens.spacing05.resolve(context)),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: CarbonButton(
            label: buttonLabel,
            semanticLabel: buttonLabel,
            kind: .tertiary,
            size: .md,
            enabled: enabled && onBrowse != null,
            onPressed: enabled ? onBrowse : null,
          ),
        ),
        if (accept case final formats? when formats.isNotEmpty) ...[
          SizedBox(height: CarbonTokens.spacing03.resolve(context)),
          ExcludeSemantics(
            child: StyledText(
              'Accepted: ${formats.join(', ')}${multiple ? '' : ' · one file'}',
              style: TextStyler()
                  .style(CarbonTokens.helperText01.mix())
                  .color(CarbonTokens.textHelper()),
            ),
          ),
        ],
        if (items.isNotEmpty) ...[
          SizedBox(height: CarbonTokens.spacing05.resolve(context)),
          Column(
            mainAxisSize: .min,
            spacing: CarbonTokens.spacing03.resolve(context),
            children: List<Widget>.unmodifiable(items),
          ),
        ],
      ],
    ),
  );
}

/// One controlled file row in [CarbonFileUploader].
class CarbonFileUploadItem extends StatelessWidget {
  const CarbonFileUploadItem({
    super.key,
    required this.name,
    this.status = .complete,
    this.sizeDescription,
    this.errorMessage,
    this.progress,
    this.onDelete,
  }) : assert(progress == null || (progress >= 0 && progress <= 1)),
       assert(status != .error || errorMessage != null);

  final String name;
  final CarbonFileUploadStatus status;
  final String? sizeDescription;
  final String? errorMessage;
  final double? progress;
  final VoidCallback? onDelete;

  String get _statusLabel => switch (status) {
    .uploading =>
      progress == null
          ? 'uploading'
          : 'uploading ${(progress! * 100).round()} percent',
    .complete => 'upload complete',
    .error => errorMessage!,
    .editing => 'ready to upload',
  };

  @override
  Widget build(BuildContext context) {
    final error = status == .error;
    final borderColor = error
        ? CarbonTokens.supportError()
        : CarbonLayer.of(context).color(.borderSubtle).resolve(context);

    return Semantics(
      label: '$name, $_statusLabel',
      liveRegion: status == .error || status == .complete,
      container: true,
      explicitChildNodes: true,
      child: Box(
        style: BoxStyler()
            .minHeight(CarbonTokens.sizeLarge())
            .padding(.all(CarbonTokens.spacing05()))
            .color(CarbonLayer.of(context).color(.layer).resolve(context))
            .border(
              BoxBorderMix.all(BorderSideMix(color: borderColor, width: 1)),
            ),
        child: Row(
          children: [
            Expanded(
              child: ExcludeSemantics(
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  children: [
                    StyledText(
                      name,
                      style: TextStyler()
                          .style(CarbonTokens.bodyCompact01.mix())
                          .color(CarbonTokens.textPrimary()),
                    ),
                    if (sizeDescription != null || error) ...[
                      SizedBox(height: CarbonTokens.spacing02.resolve(context)),
                      StyledText(
                        error ? errorMessage! : sizeDescription!,
                        style: TextStyler()
                            .style(CarbonTokens.helperText01.mix())
                            .color(
                              error
                                  ? CarbonTokens.textError()
                                  : CarbonTokens.textHelper(),
                            ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(width: CarbonTokens.spacing05.resolve(context)),
            ExcludeSemantics(
              child: StyledText(
                switch (status) {
                  .uploading => '…',
                  .complete => '✓',
                  .error => '!',
                  .editing => '○',
                },
                style: TextStyler()
                    .style(CarbonTokens.headingCompact01.mix())
                    .color(
                      error
                          ? CarbonTokens.supportError()
                          : CarbonTokens.iconPrimary(),
                    ),
              ),
            ),
            if (onDelete != null) ...[
              SizedBox(width: CarbonTokens.spacing03.resolve(context)),
              CarbonButton(
                label: '×',
                semanticLabel: 'Remove $name',
                kind: .ghost,
                size: .sm,
                onPressed: onDelete,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
