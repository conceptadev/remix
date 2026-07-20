part of 'button.dart';

/// Style builder for [RemixButton].
///
/// Use this class to style the button container, label, icons, and loading
/// spinner. It supports Mix variants and widget state variants for focused,
/// hovered, pressed, disabled, and loading states.
extension RemixButtonStylerRemixHelpers on RemixButtonStyler {
  /// Creates a [RemixButton] widget with this style applied.
  RemixButton call({
    Key? key,
    required Widget child,
    RemixButtonLoadingBuilder? loadingBuilder,
    bool loading = false,
    bool enabled = true,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableFeedback = true,
    String? semanticLabel,
    String? semanticHint,
    bool excludeSemantics = false,
    MouseCursor mouseCursor = SystemMouseCursors.click,
  }) {
    return RemixButton(
      key: key,
      child: child,
      loadingBuilder: loadingBuilder,
      loading: loading,
      enabled: enabled,
      onPressed: onPressed,
      onLongPress: onLongPress,
      focusNode: focusNode,
      autofocus: autofocus,
      enableFeedback: enableFeedback,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
      mouseCursor: mouseCursor,
      style: this,
    );
  }
}

extension RemixButtonStyleContainerHelpers on RemixButtonStyler {
  RemixButtonStyler paddingTop(double value) {
    return padding(EdgeInsetsGeometryMix.top(value));
  }

  RemixButtonStyler paddingBottom(double value) {
    return padding(EdgeInsetsGeometryMix.bottom(value));
  }

  RemixButtonStyler paddingLeft(double value) {
    return padding(EdgeInsetsGeometryMix.left(value));
  }

  RemixButtonStyler paddingRight(double value) {
    return padding(EdgeInsetsGeometryMix.right(value));
  }

  RemixButtonStyler paddingX(double value) {
    return padding(EdgeInsetsGeometryMix.horizontal(value));
  }

  RemixButtonStyler paddingY(double value) {
    return padding(EdgeInsetsGeometryMix.vertical(value));
  }

  RemixButtonStyler paddingAll(double value) {
    return padding(EdgeInsetsGeometryMix.all(value));
  }

  RemixButtonStyler paddingStart(double value) {
    return padding(EdgeInsetsGeometryMix.start(value));
  }

  RemixButtonStyler paddingEnd(double value) {
    return padding(EdgeInsetsGeometryMix.end(value));
  }

  RemixButtonStyler paddingOnly({
    double? horizontal,
    double? vertical,
    double? start,
    double? end,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    if (start != null || end != null) {
      return padding(
        EdgeInsetsGeometryMix.directional(
          start: start ?? left ?? horizontal,
          end: end ?? right ?? horizontal,
          top: top ?? vertical,
          bottom: bottom ?? vertical,
        ),
      );
    }

    return padding(
      EdgeInsetsGeometryMix.only(
        left: left ?? horizontal,
        right: right ?? horizontal,
        top: top ?? vertical,
        bottom: bottom ?? vertical,
      ),
    );
  }

  RemixButtonStyler marginTop(double value) {
    return margin(EdgeInsetsGeometryMix.top(value));
  }

  RemixButtonStyler marginBottom(double value) {
    return margin(EdgeInsetsGeometryMix.bottom(value));
  }

  RemixButtonStyler marginLeft(double value) {
    return margin(EdgeInsetsGeometryMix.left(value));
  }

  RemixButtonStyler marginRight(double value) {
    return margin(EdgeInsetsGeometryMix.right(value));
  }

  RemixButtonStyler marginX(double value) {
    return margin(EdgeInsetsGeometryMix.horizontal(value));
  }

  RemixButtonStyler marginY(double value) {
    return margin(EdgeInsetsGeometryMix.vertical(value));
  }

  RemixButtonStyler marginAll(double value) {
    return margin(EdgeInsetsGeometryMix.all(value));
  }

  RemixButtonStyler marginStart(double value) {
    return margin(EdgeInsetsGeometryMix.start(value));
  }

  RemixButtonStyler marginEnd(double value) {
    return margin(EdgeInsetsGeometryMix.end(value));
  }

  RemixButtonStyler marginOnly({
    double? horizontal,
    double? vertical,
    double? start,
    double? end,
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    if (start != null || end != null) {
      return margin(
        EdgeInsetsGeometryMix.directional(
          start: start ?? left ?? horizontal,
          end: end ?? right ?? horizontal,
          top: top ?? vertical,
          bottom: bottom ?? vertical,
        ),
      );
    }

    return margin(
      EdgeInsetsGeometryMix.only(
        left: left ?? horizontal,
        right: right ?? horizontal,
        top: top ?? vertical,
        bottom: bottom ?? vertical,
      ),
    );
  }

  RemixButtonStyler constraintsOnly({
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

  RemixButtonStyler minimumSize(Size value) {
    return constraintsOnly(minWidth: value.width, minHeight: value.height);
  }

  RemixButtonStyler fixedSize(Size value) {
    return constraintsOnly(
      minWidth: value.width,
      maxWidth: value.width,
      minHeight: value.height,
      maxHeight: value.height,
    );
  }

  RemixButtonStyler maximumSize(Size value) {
    return constraintsOnly(maxWidth: value.width, maxHeight: value.height);
  }

  RemixButtonStyler flex(FlexStyler value) {
    return container(FlexBoxStyler().flex(value));
  }

  /// Rotates the complete button with a widget modifier.
  ///
  /// Use [RemixButtonStyler.rotate] for the generated container transform
  /// shortcut.
  RemixButtonStyler modifierRotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return wrap(.rotate(radians: radians, alignment: alignment));
  }

  RemixButtonStyler transformReset() {
    return transform(Matrix4.identity());
  }
}

extension RemixButtonStyleDecorationHelpers on RemixButtonStyler {
  RemixButtonStyler backgroundColor(Color value) => color(value);

  RemixButtonStyler foregroundColor(Color value) {
    return label(.color(value)).icon(.color(value));
  }

  RemixButtonStyler borderTop({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return container(
      FlexBoxStyler().borderTop(
        color: color,
        width: width,
        style: style,
        strokeAlign: strokeAlign,
      ),
    );
  }

  RemixButtonStyler borderBottom({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return container(
      FlexBoxStyler().borderBottom(
        color: color,
        width: width,
        style: style,
        strokeAlign: strokeAlign,
      ),
    );
  }

  RemixButtonStyler borderLeft({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return container(
      FlexBoxStyler().borderLeft(
        color: color,
        width: width,
        style: style,
        strokeAlign: strokeAlign,
      ),
    );
  }

  RemixButtonStyler borderRight({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return container(
      FlexBoxStyler().borderRight(
        color: color,
        width: width,
        style: style,
        strokeAlign: strokeAlign,
      ),
    );
  }

  RemixButtonStyler borderStart({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return container(
      FlexBoxStyler().borderStart(
        color: color,
        width: width,
        style: style,
        strokeAlign: strokeAlign,
      ),
    );
  }

  RemixButtonStyler borderEnd({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return container(
      FlexBoxStyler().borderEnd(
        color: color,
        width: width,
        style: style,
        strokeAlign: strokeAlign,
      ),
    );
  }

  RemixButtonStyler borderVertical({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return container(
      FlexBoxStyler().borderVertical(
        color: color,
        width: width,
        style: style,
        strokeAlign: strokeAlign,
      ),
    );
  }

  RemixButtonStyler borderHorizontal({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return container(
      FlexBoxStyler().borderHorizontal(
        color: color,
        width: width,
        style: style,
        strokeAlign: strokeAlign,
      ),
    );
  }

  RemixButtonStyler borderAll({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
  }) {
    return border(
      BoxBorderMix.all(
        BorderSideMix(
          color: color,
          strokeAlign: strokeAlign,
          style: style,
          width: width,
        ),
      ),
    );
  }

  RemixButtonStyler borderRadiusAll(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.all(radius));
  }

  RemixButtonStyler borderRadiusTop(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.top(radius));
  }

  RemixButtonStyler borderRadiusBottom(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottom(radius));
  }

  RemixButtonStyler borderRadiusLeft(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.left(radius));
  }

  RemixButtonStyler borderRadiusRight(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.right(radius));
  }

  RemixButtonStyler borderRadiusTopLeft(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topLeft(radius));
  }

  RemixButtonStyler borderRadiusTopRight(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topRight(radius));
  }

  RemixButtonStyler borderRadiusBottomLeft(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomLeft(radius));
  }

  RemixButtonStyler borderRadiusBottomRight(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomRight(radius));
  }

  RemixButtonStyler borderRadiusTopStart(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topStart(radius));
  }

  RemixButtonStyler borderRadiusTopEnd(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topEnd(radius));
  }

  RemixButtonStyler borderRadiusBottomStart(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomStart(radius));
  }

  RemixButtonStyler borderRadiusBottomEnd(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomEnd(radius));
  }

  RemixButtonStyler borderRounded(double radius) {
    return borderRadius(BorderRadiusGeometryMix.circular(radius));
  }

  RemixButtonStyler borderRoundedTop(double radius) {
    return borderRadius(BorderRadiusGeometryMix.top(.circular(radius)));
  }

  RemixButtonStyler borderRoundedBottom(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottom(.circular(radius)));
  }

  RemixButtonStyler borderRoundedLeft(double radius) {
    return borderRadius(BorderRadiusGeometryMix.left(.circular(radius)));
  }

  RemixButtonStyler borderRoundedRight(double radius) {
    return borderRadius(BorderRadiusGeometryMix.right(.circular(radius)));
  }

  RemixButtonStyler borderRoundedTopLeft(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topLeft(.circular(radius)));
  }

  RemixButtonStyler borderRoundedTopRight(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topRight(.circular(radius)));
  }

  RemixButtonStyler borderRoundedBottomLeft(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomLeft(.circular(radius)));
  }

  RemixButtonStyler borderRoundedBottomRight(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomRight(.circular(radius)));
  }

  RemixButtonStyler borderRoundedTopStart(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topStart(.circular(radius)));
  }

  RemixButtonStyler borderRoundedTopEnd(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topEnd(.circular(radius)));
  }

  RemixButtonStyler borderRoundedBottomStart(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomStart(.circular(radius)));
  }

  RemixButtonStyler borderRoundedBottomEnd(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomEnd(.circular(radius)));
  }

  RemixButtonStyler shadowOnly({
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    return container(
      FlexBoxStyler().shadowOnly(
        color: color,
        offset: offset,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
    );
  }

  RemixButtonStyler boxShadows(List<BoxShadowMix> value) {
    return shadows(value);
  }

  RemixButtonStyler boxElevation(ElevationShadow value) {
    return elevation(value);
  }

  RemixButtonStyler shapeCircle({BorderSideMix? side}) {
    return shape(CircleBorderMix(side: side));
  }

  RemixButtonStyler shapeStadium({BorderSideMix? side}) {
    return shape(StadiumBorderMix(side: side));
  }

  RemixButtonStyler shapeRoundedRectangle({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      RoundedRectangleBorderMix(borderRadius: borderRadius, side: side),
    );
  }

  RemixButtonStyler shapeBeveledRectangle({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      BeveledRectangleBorderMix(borderRadius: borderRadius, side: side),
    );
  }

  RemixButtonStyler shapeContinuousRectangle({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      ContinuousRectangleBorderMix(borderRadius: borderRadius, side: side),
    );
  }

  RemixButtonStyler shapeStar({
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

  RemixButtonStyler shapeLinear({
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

  RemixButtonStyler shapeSuperellipse({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      RoundedSuperellipseBorderMix(borderRadius: borderRadius, side: side),
    );
  }
}
