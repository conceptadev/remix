import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../loading/carbon_loading.dart';

/// Carbon inline-loading states.
enum CarbonInlineLoadingStatus { inactive, active, finished, error }

/// A compact Carbon status line for in-place asynchronous work.
class CarbonInlineLoading extends StatefulWidget {
  const CarbonInlineLoading({
    super.key,
    required this.label,
    this.status = .active,
    this.onSuccess,
  });

  final String label;
  final CarbonInlineLoadingStatus status;

  /// Invoked once each time [status] enters [CarbonInlineLoadingStatus.finished].
  final VoidCallback? onSuccess;

  @override
  State<CarbonInlineLoading> createState() => _CarbonInlineLoadingState();
}

class _CarbonInlineLoadingState extends State<CarbonInlineLoading> {
  var _successNotified = false;

  @override
  void initState() {
    super.initState();
    _scheduleSuccessIfNeeded();
  }

  @override
  void didUpdateWidget(CarbonInlineLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != .finished) {
      _successNotified = false;
    }
    _scheduleSuccessIfNeeded();
  }

  void _scheduleSuccessIfNeeded() {
    if (widget.status != .finished ||
        _successNotified ||
        widget.onSuccess == null) {
      return;
    }
    _successNotified = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.status == .finished) {
        widget.onSuccess?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final terminal = widget.status == .finished || widget.status == .error;
    final statusValue = switch (widget.status) {
      .inactive => 'Inactive',
      .active => 'In progress',
      .finished => 'Complete',
      .error => 'Error',
    };

    return Semantics(
      label: widget.label,
      value: statusValue,
      liveRegion: terminal,
      child: ExcludeSemantics(
        child: SizedBox(
          height: 32,
          child: Row(
            mainAxisSize: .min,
            spacing: CarbonTokens.spacing03.resolve(context),
            children: [
              _statusIndicator(context),
              StyledText(
                widget.label,
                style: TextStyler()
                    .style(CarbonTokens.label02.mix())
                    .color(CarbonTokens.textPrimary()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusIndicator(BuildContext context) => switch (widget.status) {
    .inactive => const SizedBox.square(dimension: 16),
    .active => carbonLoadingStyle(small: true)(),
    .finished => Icon(
      CarbonIcons.checkmarkFilled,
      size: 16,
      color: CarbonTokens.supportSuccess.resolve(context),
    ),
    .error => Icon(
      CarbonIcons.errorFilled,
      size: 16,
      color: CarbonTokens.supportError.resolve(context),
    ),
  };
}
