import 'package:flutter/foundation.dart' show internal;
import 'package:flutter/material.dart';
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
  });

  /// The fluent style to resolve when [styleSpec] is null.
  final Style<S> style;

  /// Optional raw spec that bypasses style resolution when provided.
  final S? styleSpec;

  /// Optional widget state controller for fluent style resolution.
  final WidgetStatesController? controller;

  /// Builds the widget with the resolved or supplied spec.
  final Widget Function(BuildContext context, S spec) builder;

  @override
  Widget build(BuildContext context) {
    final spec = styleSpec;
    if (spec != null) {
      return StyleSpecBuilder<S>(
        styleSpec: StyleSpec(spec: spec),
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

/// Fluent-only Box conveniences retained alongside generated canonical APIs.
extension RemixBoxStylerConvenience<T extends Mix<Object?>>
    on RemixBoxStylerAnchors<T> {
  T paddingTop(double value) => padding(EdgeInsetsGeometryMix.top(value));

  T paddingBottom(double value) => padding(EdgeInsetsGeometryMix.bottom(value));

  T paddingLeft(double value) => padding(EdgeInsetsGeometryMix.left(value));

  T paddingRight(double value) => padding(EdgeInsetsGeometryMix.right(value));

  T paddingX(double value) => padding(EdgeInsetsGeometryMix.horizontal(value));

  T paddingY(double value) => padding(EdgeInsetsGeometryMix.vertical(value));

  T paddingAll(double value) => padding(EdgeInsetsGeometryMix.all(value));

  T paddingStart(double value) => padding(EdgeInsetsGeometryMix.start(value));

  T paddingEnd(double value) => padding(EdgeInsetsGeometryMix.end(value));

  T paddingOnly({
    double? horizontal,
    double? vertical,
    double? start,
    double? end,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    final resolvedLeft = left ?? horizontal;
    final resolvedRight = right ?? horizontal;
    final resolvedTop = top ?? vertical;
    final resolvedBottom = bottom ?? vertical;

    if (start != null || end != null) {
      return padding(
        EdgeInsetsGeometryMix.directional(
          start: start ?? resolvedLeft,
          end: end ?? resolvedRight,
          top: resolvedTop,
          bottom: resolvedBottom,
        ),
      );
    }

    return padding(
      EdgeInsetsGeometryMix.only(
        left: resolvedLeft,
        right: resolvedRight,
        top: resolvedTop,
        bottom: resolvedBottom,
      ),
    );
  }

  T marginTop(double value) => margin(EdgeInsetsGeometryMix.top(value));

  T marginBottom(double value) => margin(EdgeInsetsGeometryMix.bottom(value));

  T marginLeft(double value) => margin(EdgeInsetsGeometryMix.left(value));

  T marginRight(double value) => margin(EdgeInsetsGeometryMix.right(value));

  T marginX(double value) => margin(EdgeInsetsGeometryMix.horizontal(value));

  T marginY(double value) => margin(EdgeInsetsGeometryMix.vertical(value));

  T marginAll(double value) => margin(EdgeInsetsGeometryMix.all(value));

  T marginStart(double value) => margin(EdgeInsetsGeometryMix.start(value));

  T marginEnd(double value) => margin(EdgeInsetsGeometryMix.end(value));

  T marginOnly({
    double? horizontal,
    double? vertical,
    double? start,
    double? end,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    final resolvedLeft = left ?? horizontal;
    final resolvedRight = right ?? horizontal;
    final resolvedTop = top ?? vertical;
    final resolvedBottom = bottom ?? vertical;

    if (start != null || end != null) {
      return margin(
        EdgeInsetsGeometryMix.directional(
          start: start ?? resolvedLeft,
          end: end ?? resolvedRight,
          top: resolvedTop,
          bottom: resolvedBottom,
        ),
      );
    }

    return margin(
      EdgeInsetsGeometryMix.only(
        left: resolvedLeft,
        right: resolvedRight,
        top: resolvedTop,
        bottom: resolvedBottom,
      ),
    );
  }

  T constraintsOnly({
    double? width,
    double? height,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) {
    return constraints(
      BoxConstraintsMix(
        minWidth: minWidth ?? width,
        maxWidth: maxWidth ?? width,
        minHeight: minHeight ?? height,
        maxHeight: maxHeight ?? height,
      ),
    );
  }

  T borderTop({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) => border(
    BorderMix.top(
      BorderSideMix(
        color: color,
        strokeAlign: strokeAlign,
        style: style,
        width: width,
      ),
    ),
  );

  T borderBottom({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) => border(
    BorderMix.bottom(
      BorderSideMix(
        color: color,
        strokeAlign: strokeAlign,
        style: style,
        width: width,
      ),
    ),
  );

  T borderLeft({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) => border(
    BorderMix.left(
      BorderSideMix(
        color: color,
        strokeAlign: strokeAlign,
        style: style,
        width: width,
      ),
    ),
  );

  T borderRight({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) => border(
    BorderMix.right(
      BorderSideMix(
        color: color,
        strokeAlign: strokeAlign,
        style: style,
        width: width,
      ),
    ),
  );

  T borderStart({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) => border(
    BorderDirectionalMix.start(
      BorderSideMix(
        color: color,
        strokeAlign: strokeAlign,
        style: style,
        width: width,
      ),
    ),
  );

  T borderEnd({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) => border(
    BorderDirectionalMix.end(
      BorderSideMix(
        color: color,
        strokeAlign: strokeAlign,
        style: style,
        width: width,
      ),
    ),
  );

  T borderVertical({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) => border(
    BorderMix.vertical(
      BorderSideMix(
        color: color,
        strokeAlign: strokeAlign,
        style: style,
        width: width,
      ),
    ),
  );

  T borderHorizontal({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) => border(
    BorderMix.horizontal(
      BorderSideMix(
        color: color,
        strokeAlign: strokeAlign,
        style: style,
        width: width,
      ),
    ),
  );

  T borderAll({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) => border(
    BorderMix.all(
      BorderSideMix(
        color: color,
        strokeAlign: strokeAlign,
        style: style,
        width: width,
      ),
    ),
  );

  T borderRadiusAll(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.all(radius));
  }

  T borderRadiusTop(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.top(radius));
  }

  T borderRadiusBottom(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottom(radius));
  }

  T borderRadiusLeft(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.left(radius));
  }

  T borderRadiusRight(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.right(radius));
  }

  T borderRadiusTopLeft(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topLeft(radius));
  }

  T borderRadiusTopRight(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topRight(radius));
  }

  T borderRadiusBottomLeft(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomLeft(radius));
  }

  T borderRadiusBottomRight(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomRight(radius));
  }

  T borderRadiusTopStart(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topStart(radius));
  }

  T borderRadiusTopEnd(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topEnd(radius));
  }

  T borderRadiusBottomStart(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomStart(radius));
  }

  T borderRadiusBottomEnd(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomEnd(radius));
  }

  T borderRounded(double radius) {
    return borderRadius(BorderRadiusGeometryMix.circular(radius));
  }

  T borderRoundedTop(double radius) {
    return borderRadius(BorderRadiusGeometryMix.top(.circular(radius)));
  }

  T borderRoundedBottom(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottom(.circular(radius)));
  }

  T borderRoundedLeft(double radius) {
    return borderRadius(BorderRadiusGeometryMix.left(.circular(radius)));
  }

  T borderRoundedRight(double radius) {
    return borderRadius(BorderRadiusGeometryMix.right(.circular(radius)));
  }

  T borderRoundedTopLeft(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topLeft(.circular(radius)));
  }

  T borderRoundedTopRight(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topRight(.circular(radius)));
  }

  T borderRoundedBottomLeft(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomLeft(.circular(radius)));
  }

  T borderRoundedBottomRight(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomRight(.circular(radius)));
  }

  T borderRoundedTopStart(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topStart(.circular(radius)));
  }

  T borderRoundedTopEnd(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topEnd(.circular(radius)));
  }

  T borderRoundedBottomStart(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomStart(.circular(radius)));
  }

  T borderRoundedBottomEnd(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomEnd(.circular(radius)));
  }

  T shapeCircle({BorderSideMix? side}) {
    return shape(CircleBorderMix(side: side));
  }

  T shapeStadium({BorderSideMix? side}) {
    return shape(StadiumBorderMix(side: side));
  }

  T shapeRoundedRectangle({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      RoundedRectangleBorderMix(borderRadius: borderRadius, side: side),
    );
  }

  T shapeBeveledRectangle({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      BeveledRectangleBorderMix(borderRadius: borderRadius, side: side),
    );
  }

  T shapeContinuousRectangle({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      ContinuousRectangleBorderMix(borderRadius: borderRadius, side: side),
    );
  }

  T shapeStar({
    BorderSideMix? side,
    double? points,
    double? innerRadiusRatio,
    double? pointRounding,
    double? valleyRounding,
    double? rotation,
    double? squash,
  }) {
    return shape(
      StarBorderMix(
        side: side,
        points: points,
        innerRadiusRatio: innerRadiusRatio,
        pointRounding: pointRounding,
        valleyRounding: valleyRounding,
        rotation: rotation,
        squash: squash,
      ),
    );
  }

  T shapeLinear({
    BorderSideMix? side,
    LinearBorderEdgeMix? start,
    LinearBorderEdgeMix? end,
    LinearBorderEdgeMix? top,
    LinearBorderEdgeMix? bottom,
  }) {
    return shape(
      LinearBorderMix(
        side: side,
        start: start,
        end: end,
        top: top,
        bottom: bottom,
      ),
    );
  }

  T shapeSuperellipse({BorderSideMix? side, BorderRadiusMix? borderRadius}) {
    return shape(
      RoundedSuperellipseBorderMix(borderRadius: borderRadius, side: side),
    );
  }

  T shadowOnly({
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    return decoration(
      BoxDecorationMix.boxShadow([
        BoxShadowMix(
          color: color,
          offset: offset,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ]),
    );
  }

  T boxShadows(List<BoxShadowMix> value) {
    return decoration(BoxDecorationMix.boxShadow(value));
  }

  T boxElevation(ElevationShadow value) {
    return decoration(
      BoxDecorationMix.boxShadow(BoxShadowMix.fromElevation(value)),
    );
  }

  T transformReset() => transform(Matrix4.identity());
}
