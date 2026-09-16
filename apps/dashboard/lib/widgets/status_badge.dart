import 'package:flutter/material.dart';
import '../ui/ui.dart';

import '../data/models.dart';
import '../utils/text.dart';
import 'app_accent_scope.dart';

/// A domain status rendered as a Fortal badge in a status-specific accent.
///
/// Re-scoping the accent rather than restyling the badge keeps every status on
/// the same recipe, so a badge change reaches all of them at once. The named
/// constructors are the single owner of each status-to-accent mapping; before
/// this existed, Overview and Orders disagreed about both the colour and the
/// casing of the same order.
class StatusBadge extends StatelessWidget {
  const StatusBadge._({super.key, required this.label, required this.accent});

  factory StatusBadge.order(OrderStatus status, {Key? key}) => StatusBadge._(
    key: key,
    label: capitalize(status.name),
    accent: switch (status) {
      OrderStatus.paid => UiAccentColor.green,
      OrderStatus.pending => UiAccentColor.amber,
      OrderStatus.refunded => UiAccentColor.red,
      OrderStatus.cancelled => UiAccentColor.gray,
    },
  );

  factory StatusBadge.customer(CustomerStatus status, {Key? key}) =>
      StatusBadge._(
        key: key,
        label: capitalize(status.name),
        accent: switch (status) {
          CustomerStatus.active => UiAccentColor.green,
          CustomerStatus.invited => UiAccentColor.blue,
          CustomerStatus.suspended => UiAccentColor.red,
        },
      );

  final String label;
  final UiAccentColor accent;

  @override
  Widget build(BuildContext context) => AppAccentScope(
    accent: accent,
    child: UiBadge(highContrast: true, label: label),
  );
}
