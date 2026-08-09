import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../data/models.dart';
import '../utils/text.dart';

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
      OrderStatus.paid => FortalAccentColor.green,
      OrderStatus.pending => FortalAccentColor.amber,
      OrderStatus.refunded => FortalAccentColor.red,
      OrderStatus.cancelled => FortalAccentColor.gray,
    },
  );

  factory StatusBadge.customer(CustomerStatus status, {Key? key}) =>
      StatusBadge._(
        key: key,
        label: capitalize(status.name),
        accent: switch (status) {
          CustomerStatus.active => FortalAccentColor.green,
          CustomerStatus.invited => FortalAccentColor.blue,
          CustomerStatus.suspended => FortalAccentColor.red,
        },
      );

  final String label;
  final FortalAccentColor accent;

  @override
  Widget build(BuildContext context) => FortalScope(
    accent: accent,
    hasBackground: false,
    child: FortalBadge(label: label),
  );
}
