part of 'button.dart';

/// Style builder for [RemixButton].
///
/// Use this class to style the button container, label, icons, and loading
/// spinner. It supports Mix variants and widget state variants for focused,
/// hovered, pressed, disabled, and loading states.
extension RemixButtonStylerRemixHelpers on ButtonStyler {
  /// Creates a [RemixButton] widget with this style applied.
  RemixButton call({
    Key? key,
    String? label,
    Widget? child,
    IconData? leadingIcon,
    IconData? trailingIcon,
    RemixButtonTextBuilder? textBuilder,
    RemixButtonIconBuilder? leadingIconBuilder,
    RemixButtonIconBuilder? trailingIconBuilder,
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
      label: label,
      child: child,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      textBuilder: textBuilder,
      leadingIconBuilder: leadingIconBuilder,
      trailingIconBuilder: trailingIconBuilder,
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

  /// Creates a button with arbitrary content using this style.
  RemixButton custom({
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
    return RemixButton.custom(
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

extension RemixButtonStyleContainerHelpers on ButtonStyler {
  ButtonStyler paddingTop(double value) {
    return padding(EdgeInsetsGeometryMix.top(value));
  }

  ButtonStyler paddingBottom(double value) {
    return padding(EdgeInsetsGeometryMix.bottom(value));
  }

  ButtonStyler paddingLeft(double value) {
    return padding(EdgeInsetsGeometryMix.left(value));
  }

  ButtonStyler paddingRight(double value) {
    return padding(EdgeInsetsGeometryMix.right(value));
  }

  ButtonStyler paddingX(double value) {
    return padding(EdgeInsetsGeometryMix.horizontal(value));
  }

  ButtonStyler paddingY(double value) {
    return padding(EdgeInsetsGeometryMix.vertical(value));
  }

  ButtonStyler paddingAll(double value) {
    return padding(EdgeInsetsGeometryMix.all(value));
  }

  ButtonStyler paddingStart(double value) {
    return padding(EdgeInsetsGeometryMix.start(value));
  }

  ButtonStyler paddingEnd(double value) {
    return padding(EdgeInsetsGeometryMix.end(value));
  }

  ButtonStyler paddingOnly({
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

  ButtonStyler marginTop(double value) {
    return margin(EdgeInsetsGeometryMix.top(value));
  }

  ButtonStyler marginBottom(double value) {
    return margin(EdgeInsetsGeometryMix.bottom(value));
  }

  ButtonStyler marginLeft(double value) {
    return margin(EdgeInsetsGeometryMix.left(value));
  }

  ButtonStyler marginRight(double value) {
    return margin(EdgeInsetsGeometryMix.right(value));
  }

  ButtonStyler marginX(double value) {
    return margin(EdgeInsetsGeometryMix.horizontal(value));
  }

  ButtonStyler marginY(double value) {
    return margin(EdgeInsetsGeometryMix.vertical(value));
  }

  ButtonStyler marginAll(double value) {
    return margin(EdgeInsetsGeometryMix.all(value));
  }

  ButtonStyler marginStart(double value) {
    return margin(EdgeInsetsGeometryMix.start(value));
  }

  ButtonStyler marginEnd(double value) {
    return margin(EdgeInsetsGeometryMix.end(value));
  }

  ButtonStyler marginOnly({
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

  ButtonStyler constraintsOnly({
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

  ButtonStyler minimumSize(Size value) {
    return constraintsOnly(minWidth: value.width, minHeight: value.height);
  }

  ButtonStyler fixedSize(Size value) {
    return constraintsOnly(
      minWidth: value.width,
      maxWidth: value.width,
      minHeight: value.height,
      maxHeight: value.height,
    );
  }

  ButtonStyler maximumSize(Size value) {
    return constraintsOnly(maxWidth: value.width, maxHeight: value.height);
  }

  ButtonStyler flex(FlexStyler value) {
    return container(FlexBoxStyler().flex(value));
  }

  /// Rotates the complete button with a widget modifier.
  ///
  /// Use [ButtonStyler.rotate] for the generated container transform
  /// shortcut.
  ButtonStyler modifierRotate(double radians, {Alignment alignment = .center}) {
    return wrap(.rotate(radians: radians, alignment: alignment));
  }

  ButtonStyler transformReset() {
    return transform(Matrix4.identity());
  }
}

extension RemixButtonStyleDecorationHelpers on ButtonStyler {
  ButtonStyler backgroundColor(Color value) => color(value);

  ButtonStyler foregroundColor(Color value) {
    return label(.color(value)).icon(.color(value));
  }

  ButtonStyler borderTop({
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

  ButtonStyler borderBottom({
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

  ButtonStyler borderLeft({
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

  ButtonStyler borderRight({
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

  ButtonStyler borderStart({
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

  ButtonStyler borderEnd({
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

  ButtonStyler borderVertical({
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

  ButtonStyler borderHorizontal({
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

  ButtonStyler borderAll({
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

  ButtonStyler borderRadiusAll(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.all(radius));
  }

  ButtonStyler borderRadiusTop(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.top(radius));
  }

  ButtonStyler borderRadiusBottom(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottom(radius));
  }

  ButtonStyler borderRadiusLeft(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.left(radius));
  }

  ButtonStyler borderRadiusRight(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.right(radius));
  }

  ButtonStyler borderRadiusTopLeft(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topLeft(radius));
  }

  ButtonStyler borderRadiusTopRight(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topRight(radius));
  }

  ButtonStyler borderRadiusBottomLeft(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomLeft(radius));
  }

  ButtonStyler borderRadiusBottomRight(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomRight(radius));
  }

  ButtonStyler borderRadiusTopStart(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topStart(radius));
  }

  ButtonStyler borderRadiusTopEnd(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.topEnd(radius));
  }

  ButtonStyler borderRadiusBottomStart(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomStart(radius));
  }

  ButtonStyler borderRadiusBottomEnd(Radius radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomEnd(radius));
  }

  ButtonStyler borderRounded(double radius) {
    return borderRadius(BorderRadiusGeometryMix.circular(radius));
  }

  ButtonStyler borderRoundedTop(double radius) {
    return borderRadius(BorderRadiusGeometryMix.top(.circular(radius)));
  }

  ButtonStyler borderRoundedBottom(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottom(.circular(radius)));
  }

  ButtonStyler borderRoundedLeft(double radius) {
    return borderRadius(BorderRadiusGeometryMix.left(.circular(radius)));
  }

  ButtonStyler borderRoundedRight(double radius) {
    return borderRadius(BorderRadiusGeometryMix.right(.circular(radius)));
  }

  ButtonStyler borderRoundedTopLeft(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topLeft(.circular(radius)));
  }

  ButtonStyler borderRoundedTopRight(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topRight(.circular(radius)));
  }

  ButtonStyler borderRoundedBottomLeft(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomLeft(.circular(radius)));
  }

  ButtonStyler borderRoundedBottomRight(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomRight(.circular(radius)));
  }

  ButtonStyler borderRoundedTopStart(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topStart(.circular(radius)));
  }

  ButtonStyler borderRoundedTopEnd(double radius) {
    return borderRadius(BorderRadiusGeometryMix.topEnd(.circular(radius)));
  }

  ButtonStyler borderRoundedBottomStart(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomStart(.circular(radius)));
  }

  ButtonStyler borderRoundedBottomEnd(double radius) {
    return borderRadius(BorderRadiusGeometryMix.bottomEnd(.circular(radius)));
  }

  ButtonStyler shadowOnly({
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

  ButtonStyler boxShadows(List<BoxShadowMix> value) {
    return shadows(value);
  }

  ButtonStyler boxElevation(ElevationShadow value) {
    return elevation(value);
  }

  ButtonStyler shapeCircle({BorderSideMix? side}) {
    return shape(CircleBorderMix(side: side));
  }

  ButtonStyler shapeStadium({BorderSideMix? side}) {
    return shape(StadiumBorderMix(side: side));
  }

  ButtonStyler shapeRoundedRectangle({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      RoundedRectangleBorderMix(borderRadius: borderRadius, side: side),
    );
  }

  ButtonStyler shapeBeveledRectangle({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      BeveledRectangleBorderMix(borderRadius: borderRadius, side: side),
    );
  }

  ButtonStyler shapeContinuousRectangle({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      ContinuousRectangleBorderMix(borderRadius: borderRadius, side: side),
    );
  }

  ButtonStyler shapeStar({
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

  ButtonStyler shapeLinear({
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

  ButtonStyler shapeSuperellipse({
    BorderSideMix? side,
    BorderRadiusMix? borderRadius,
  }) {
    return shape(
      RoundedSuperellipseBorderMix(borderRadius: borderRadius, side: side),
    );
  }
}
