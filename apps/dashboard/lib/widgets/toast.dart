import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'typography.dart';

void showToast(
  BuildContext context, {
  required String message,
  IconData icon = Icons.check_circle_outline,
  String? actionLabel,
  VoidCallback? onAction,
}) {
  // DashboardApp places its caller-owned Overlay below FortalScope, so entries
  // inherit live Fortal and Mix state without snapshots.
  final overlay = Overlay.of(context);
  late final OverlayEntry entry;
  entry = OverlayEntry(
    builder: (_) => Positioned(
      right: 24,
      bottom: 24,
      child: _ToastBody(
        message: message,
        icon: icon,
        actionLabel: actionLabel,
        onAction: () {
          onAction?.call();
          if (entry.mounted) entry.remove();
        },
      ),
    ),
  );
  overlay.insert(entry);
  Timer(const Duration(seconds: 4), () {
    if (entry.mounted) entry.remove();
  });
}

class _ToastBody extends StatelessWidget {
  const _ToastBody({
    required this.message,
    required this.icon,
    required this.actionLabel,
    required this.onAction,
  });

  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      child: FortalCard.classic(
        size: .size2,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Row(
            mainAxisSize: .min,
            spacing: 10,
            children: [
              Icon(
                icon,
                size: 19,
                color: MixScope.tokenOf(FortalTokens.accent11, context),
              ),
              Flexible(
                child: StyledText(
                  message,
                  style: dashboardText(FortalTokens.text2, weight: .w500),
                ),
              ),
              if (actionLabel case final label?)
                FortalButton.ghost(
                  size: .size1,
                  onPressed: onAction,
                  label: label,
                ),
            ],
          ),
        ),
      ),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 16 * (1 - value)),
          child: child,
        ),
      ),
    );
  }
}
