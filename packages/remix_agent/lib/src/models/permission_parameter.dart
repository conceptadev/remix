import 'package:flutter/widgets.dart';

/// One inspectable argument on an [AgentPermission] card.
class AgentPermissionParameter {
  /// Creates a parameter row. Provide exactly one of [value] or [child].
  const AgentPermissionParameter({
    required this.id,
    required this.label,
    this.value,
    this.child,
  }) : assert(
         (value == null) != (child == null),
         'Provide exactly one of value or child.',
       );

  /// Stable identity.
  final String id;

  /// Field name shown to the operator.
  final String label;

  /// Plain-text value.
  final String? value;

  /// Host-rendered value (for example a monospace command).
  final Widget? child;
}
