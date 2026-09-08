import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';

/// Resolves a fluent style or bypasses it with a raw resolved spec.
class AgentStyleBuilder<S extends Spec<S>> extends StatelessWidget {
  const AgentStyleBuilder({
    super.key,
    required this.style,
    required this.styleSpec,
    required this.builder,
    this.controller,
  });

  final Style<S> style;
  final S? styleSpec;
  final WidgetStatesController? controller;
  final Widget Function(BuildContext context, S spec) builder;

  @override
  Widget build(BuildContext context) {
    final resolved = styleSpec;
    if (resolved != null) {
      return StyleSpecBuilder<S>(
        styleSpec: StyleSpec(spec: resolved),
        builder: builder,
      );
    }
    return StyleBuilder<S>(
      style: style,
      controller: controller,
      builder: builder,
    );
  }
}
