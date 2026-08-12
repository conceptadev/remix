import 'package:flutter/foundation.dart' show internal;
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart' hide AnimationConfig;

/// Applies resolved Remix text and icon specs as inherited defaults for
/// arbitrary component content.
///
/// Explicit styles on descendants still win, matching the way Radix styles
/// arbitrary button, badge, and callout children through inherited CSS.
@internal
final class RemixDefaultContentStyle extends StatelessWidget {
  const RemixDefaultContentStyle({
    super.key,
    required this.child,
    this.text,
    this.icon,
  });

  final Widget child;
  final StyleSpec<TextSpec>? text;
  final StyleSpec<IconSpec>? icon;

  @override
  Widget build(BuildContext context) {
    final textSpec = text?.spec;
    final iconSpec = icon?.spec;

    Widget current = child;
    if (iconSpec != null) {
      current = IconTheme.merge(
        data: IconThemeData(
          color: iconSpec.color,
          opacity: iconSpec.opacity,
          size: iconSpec.size,
          fill: iconSpec.fill,
          weight: iconSpec.weight,
          grade: iconSpec.grade,
          opticalSize: iconSpec.opticalSize,
          shadows: iconSpec.shadows,
          applyTextScaling: iconSpec.applyTextScaling,
        ),
        child: current,
      );
    }
    if (textSpec != null) {
      current = DefaultTextStyle.merge(
        style: textSpec.style ?? const TextStyle(),
        textAlign: textSpec.textAlign,
        softWrap: textSpec.softWrap ?? true,
        overflow: textSpec.overflow ?? TextOverflow.clip,
        maxLines: textSpec.maxLines,
        textWidthBasis: textSpec.textWidthBasis ?? TextWidthBasis.parent,
        textHeightBehavior: textSpec.textHeightBehavior,
        child: current,
      );
    }
    return current;
  }
}

/// Builds from a raw spec when supplied, otherwise resolves the fluent style.
class RemixStyleSpecBuilder<S extends Spec<S>> extends StatelessWidget {
  /// Creates a builder that supports both style and raw spec inputs.
  const RemixStyleSpecBuilder({
    super.key,
    required this.style,
    required this.styleSpec,
    required this.builder,
    this.controller,
    this.trackFocusHighlightMode = false,
  });

  /// The fluent style to resolve when [styleSpec] is null.
  final Style<S> style;

  /// Optional raw spec that bypasses style resolution when provided.
  final S? styleSpec;

  /// Optional widget state controller for fluent style resolution.
  final WidgetStatesController? controller;

  /// Whether [builder] should rebuild when the focus highlight mode changes.
  ///
  /// Mix-managed controller scopes already make [FocusVisibleVariant]
  /// reactive. Set this for composite widgets that publish focus through a
  /// manual [WidgetStateProvider], or for visuals that read
  /// [RemixFocusHighlightModeProvider.of] directly.
  final bool trackFocusHighlightMode;

  /// Builds the widget with the resolved or supplied spec.
  final Widget Function(BuildContext context, S spec) builder;

  Widget _buildTracked(BuildContext context, S spec) {
    if (trackFocusHighlightMode) {
      // Register a dependency on the Remix scope. This also rebuilds styles
      // resolved beneath manually mounted WidgetStateProvider instances, where
      // Mix's focus-visible variant otherwise observes modality on the next
      // unrelated rebuild.
      RemixFocusHighlightModeProvider.of(context);
    }
    return builder(context, spec);
  }

  @override
  Widget build(BuildContext context) {
    final spec = styleSpec;
    late final Widget result;
    if (spec != null) {
      result = StyleSpecBuilder<S>(
        styleSpec: StyleSpec(spec: spec),
        builder: _buildTracked,
      );
    } else {
      result = StyleBuilder<S>(
        style: style,
        controller: controller,
        builder: _buildTracked,
      );
    }

    if (!trackFocusHighlightMode) return result;

    return RemixFocusHighlightModeProvider._(child: result);
  }
}

/// Provides reactive access to Flutter's current focus-highlight mode.
@internal
final class RemixFocusHighlightModeProvider extends StatefulWidget {
  const RemixFocusHighlightModeProvider._({required this.child});

  /// Returns the current mode and subscribes to changes when a scope exists.
  static FocusHighlightMode of(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<_RemixFocusHighlightModeScope>()
            ?.mode ??
        FocusManager.instance.highlightMode;
  }

  final Widget child;

  @override
  State<RemixFocusHighlightModeProvider> createState() =>
      _RemixFocusHighlightModeProviderState();
}

class _RemixFocusHighlightModeProviderState
    extends State<RemixFocusHighlightModeProvider> {
  late FocusHighlightMode _mode;

  @override
  void initState() {
    super.initState();
    _mode = FocusManager.instance.highlightMode;
    FocusManager.instance.addHighlightModeListener(_handleModeChange);
  }

  void _handleModeChange(FocusHighlightMode mode) {
    if (!mounted || mode == _mode) return;

    setState(() => _mode = mode);
  }

  @override
  void dispose() {
    FocusManager.instance.removeHighlightModeListener(_handleModeChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RemixFocusHighlightModeScope(mode: _mode, child: widget.child);
  }
}

class _RemixFocusHighlightModeScope extends InheritedWidget {
  const _RemixFocusHighlightModeScope({
    required this.mode,
    required super.child,
  });

  final FocusHighlightMode mode;

  @override
  bool updateShouldNotify(_RemixFocusHighlightModeScope oldWidget) {
    return mode != oldWidget.mode;
  }
}

/// Canonical Box-style anchors supplied by a forwarded nested styler.
abstract interface class RemixBoxStylerAnchors<T extends Mix<Object?>> {
  T padding(EdgeInsetsGeometryMix value);

  T margin(EdgeInsetsGeometryMix value);

  T constraints(BoxConstraintsMix value);

  T border(BoxBorderMix value);

  T borderRadius(BorderRadiusGeometryMix value);

  T shape(ShapeBorderMix value);

  T decoration(DecorationMix value);

  T transform(Matrix4 value, {Alignment alignment = .center});
}

/// Marks generated Remix stylers that forward a Box-compatible surface.
mixin RemixBoxStylerMixin<T extends Mix<Object?>>
    implements RemixBoxStylerAnchors<T> {}
