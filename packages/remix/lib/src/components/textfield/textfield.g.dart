// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'textfield.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixTextFieldSpec implements Spec<RemixTextFieldSpec>, Diagnosticable {
  StyleSpec<TextSpec> get text;
  StyleSpec<TextSpec> get hintText;
  TextAlign? get textAlign;
  double? get cursorWidth;
  double? get cursorHeight;
  Radius? get cursorRadius;
  Color? get cursorColor;
  BoxHeightStyle? get selectionHeightStyle;
  BoxWidthStyle? get selectionWidthStyle;
  EdgeInsets? get scrollPadding;
  Brightness? get keyboardAppearance;
  bool? get cursorOpacityAnimates;
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<FlexBoxSpec> get layout;
  StyleSpec<TextSpec> get helperText;
  StyleSpec<TextSpec> get label;
  RemixSurfaceEffectsSpec? get effects;

  @override
  Type get type => RemixTextFieldSpec;

  @override
  RemixTextFieldSpec copyWith({
    StyleSpec<TextSpec>? text,
    StyleSpec<TextSpec>? hintText,
    TextAlign? textAlign,
    double? cursorWidth,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    BoxHeightStyle? selectionHeightStyle,
    BoxWidthStyle? selectionWidthStyle,
    EdgeInsets? scrollPadding,
    Brightness? keyboardAppearance,
    bool? cursorOpacityAnimates,
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<FlexBoxSpec>? layout,
    StyleSpec<TextSpec>? helperText,
    StyleSpec<TextSpec>? label,
    RemixSurfaceEffectsSpec? effects,
  }) {
    return RemixTextFieldSpec(
      text: text ?? this.text,
      hintText: hintText ?? this.hintText,
      textAlign: textAlign ?? this.textAlign,
      cursorWidth: cursorWidth ?? this.cursorWidth,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      cursorRadius: cursorRadius ?? this.cursorRadius,
      cursorColor: cursorColor ?? this.cursorColor,
      selectionHeightStyle: selectionHeightStyle ?? this.selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle ?? this.selectionWidthStyle,
      scrollPadding: scrollPadding ?? this.scrollPadding,
      keyboardAppearance: keyboardAppearance ?? this.keyboardAppearance,
      cursorOpacityAnimates:
          cursorOpacityAnimates ?? this.cursorOpacityAnimates,
      container: container ?? this.container,
      layout: layout ?? this.layout,
      helperText: helperText ?? this.helperText,
      label: label ?? this.label,
      effects: effects ?? this.effects,
    );
  }

  @override
  RemixTextFieldSpec lerp(RemixTextFieldSpec? other, double t) {
    return RemixTextFieldSpec(
      text: text.lerp(other?.text, t),
      hintText: hintText.lerp(other?.hintText, t),
      textAlign: MixOps.lerpSnap(textAlign, other?.textAlign, t),
      cursorWidth: MixOps.lerp(cursorWidth, other?.cursorWidth, t),
      cursorHeight: MixOps.lerp(cursorHeight, other?.cursorHeight, t),
      cursorRadius: MixOps.lerpSnap(cursorRadius, other?.cursorRadius, t),
      cursorColor: MixOps.lerp(cursorColor, other?.cursorColor, t),
      selectionHeightStyle: MixOps.lerpSnap(
        selectionHeightStyle,
        other?.selectionHeightStyle,
        t,
      ),
      selectionWidthStyle: MixOps.lerpSnap(
        selectionWidthStyle,
        other?.selectionWidthStyle,
        t,
      ),
      scrollPadding: MixOps.lerp(scrollPadding, other?.scrollPadding, t),
      keyboardAppearance: MixOps.lerpSnap(
        keyboardAppearance,
        other?.keyboardAppearance,
        t,
      ),
      cursorOpacityAnimates: MixOps.lerpSnap(
        cursorOpacityAnimates,
        other?.cursorOpacityAnimates,
        t,
      ),
      container: container.lerp(other?.container, t),
      layout: layout.lerp(other?.layout, t),
      helperText: helperText.lerp(other?.helperText, t),
      label: label.lerp(other?.label, t),
      effects: MixOps.lerpSnap(effects, other?.effects, t),
    );
  }

  @override
  List<Object?> get props => [
    text,
    hintText,
    textAlign,
    cursorWidth,
    cursorHeight,
    cursorRadius,
    cursorColor,
    selectionHeightStyle,
    selectionWidthStyle,
    scrollPadding,
    keyboardAppearance,
    cursorOpacityAnimates,
    container,
    layout,
    helperText,
    label,
    effects,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixTextFieldSpec &&
            runtimeType == other.runtimeType &&
            propsEquals(props, other.props);
  }

  @override
  int get hashCode => propsHash(runtimeType, props);

  @override
  bool get stringify => true;

  @override
  Map<String, String> getDiff(Equatable other) {
    if (this == other) return const {};

    return propsDiff(props, other.props);
  }

  @override
  String toStringShort() => '$runtimeType';

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) =>
      toDiagnosticsNode(
        style: DiagnosticsTreeStyle.singleLine,
      ).toString(minLevel: minLevel);

  @override
  DiagnosticsNode toDiagnosticsNode({
    String? name,
    DiagnosticsTreeStyle? style,
  }) =>
      DiagnosticableNode<Diagnosticable>(name: name, value: this, style: style);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('hintText', hintText))
      ..add(EnumProperty<TextAlign>('textAlign', textAlign))
      ..add(DoubleProperty('cursorWidth', cursorWidth))
      ..add(DoubleProperty('cursorHeight', cursorHeight))
      ..add(DiagnosticsProperty('cursorRadius', cursorRadius))
      ..add(ColorProperty('cursorColor', cursorColor))
      ..add(DiagnosticsProperty('selectionHeightStyle', selectionHeightStyle))
      ..add(DiagnosticsProperty('selectionWidthStyle', selectionWidthStyle))
      ..add(DiagnosticsProperty('scrollPadding', scrollPadding))
      ..add(DiagnosticsProperty('keyboardAppearance', keyboardAppearance))
      ..add(DiagnosticsProperty('cursorOpacityAnimates', cursorOpacityAnimates))
      ..add(DiagnosticsProperty('container', container))
      ..add(DiagnosticsProperty('layout', layout))
      ..add(DiagnosticsProperty('helperText', helperText))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('effects', effects));
  }
}

@Deprecated(
  'Rename to `_\$RemixTextFieldSpec` and migrate the class declaration to `class RemixTextFieldSpec with _\$RemixTextFieldSpec`. The `_\$RemixTextFieldSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixTextFieldSpecMethods = _$RemixTextFieldSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixTextFieldStyler
    extends MixStyler<RemixTextFieldStyler, RemixTextFieldSpec>
    with
        RemixBoxStylerMixin<RemixTextFieldStyler>,
        LabelStyleMixin<RemixTextFieldStyler> {
  final Prop<StyleSpec<TextSpec>>? $text;
  final Prop<StyleSpec<TextSpec>>? $hintText;
  final Prop<TextAlign>? $textAlign;
  final Prop<double>? $cursorWidth;
  final Prop<double>? $cursorHeight;
  final Prop<Radius>? $cursorRadius;
  final Prop<Color>? $cursorColor;
  final Prop<BoxHeightStyle>? $selectionHeightStyle;
  final Prop<BoxWidthStyle>? $selectionWidthStyle;
  final Prop<EdgeInsets>? $scrollPadding;
  final Prop<Brightness>? $keyboardAppearance;
  final Prop<bool>? $cursorOpacityAnimates;
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<FlexBoxSpec>>? $layout;
  final Prop<StyleSpec<TextSpec>>? $helperText;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<RemixSurfaceEffectsSpec>? $effects;

  const RemixTextFieldStyler.create({
    Prop<StyleSpec<TextSpec>>? text,
    Prop<StyleSpec<TextSpec>>? hintText,
    Prop<TextAlign>? textAlign,
    Prop<double>? cursorWidth,
    Prop<double>? cursorHeight,
    Prop<Radius>? cursorRadius,
    Prop<Color>? cursorColor,
    Prop<BoxHeightStyle>? selectionHeightStyle,
    Prop<BoxWidthStyle>? selectionWidthStyle,
    Prop<EdgeInsets>? scrollPadding,
    Prop<Brightness>? keyboardAppearance,
    Prop<bool>? cursorOpacityAnimates,
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<FlexBoxSpec>>? layout,
    Prop<StyleSpec<TextSpec>>? helperText,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<RemixSurfaceEffectsSpec>? effects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $text = text,
       $hintText = hintText,
       $textAlign = textAlign,
       $cursorWidth = cursorWidth,
       $cursorHeight = cursorHeight,
       $cursorRadius = cursorRadius,
       $cursorColor = cursorColor,
       $selectionHeightStyle = selectionHeightStyle,
       $selectionWidthStyle = selectionWidthStyle,
       $scrollPadding = scrollPadding,
       $keyboardAppearance = keyboardAppearance,
       $cursorOpacityAnimates = cursorOpacityAnimates,
       $container = container,
       $layout = layout,
       $helperText = helperText,
       $label = label,
       $effects = effects;

  RemixTextFieldStyler({
    TextStyler? text,
    TextStyler? hintText,
    TextAlign? textAlign,
    double? cursorWidth,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    BoxHeightStyle? selectionHeightStyle,
    BoxWidthStyle? selectionWidthStyle,
    EdgeInsets? scrollPadding,
    Brightness? keyboardAppearance,
    bool? cursorOpacityAnimates,
    FlexBoxStyler? container,
    FlexBoxStyler? layout,
    TextStyler? helperText,
    TextStyler? label,
    RemixSurfaceEffectsMix? effects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixTextFieldSpec>>? variants,
  }) : this.create(
         text: Prop.maybeMix(text),
         hintText: Prop.maybeMix(hintText),
         textAlign: Prop.maybe(textAlign),
         cursorWidth: Prop.maybe(cursorWidth),
         cursorHeight: Prop.maybe(cursorHeight),
         cursorRadius: Prop.maybe(cursorRadius),
         cursorColor: Prop.maybe(cursorColor),
         selectionHeightStyle: Prop.maybe(selectionHeightStyle),
         selectionWidthStyle: Prop.maybe(selectionWidthStyle),
         scrollPadding: Prop.maybe(scrollPadding),
         keyboardAppearance: Prop.maybe(keyboardAppearance),
         cursorOpacityAnimates: Prop.maybe(cursorOpacityAnimates),
         container: Prop.maybeMix(container),
         layout: Prop.maybeMix(layout),
         helperText: Prop.maybeMix(helperText),
         label: Prop.maybeMix(label),
         effects: Prop.maybeMix(effects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixTextFieldStyler.text(TextStyler value) =>
      RemixTextFieldStyler().text(value);
  factory RemixTextFieldStyler.hintText(TextStyler value) =>
      RemixTextFieldStyler().hintText(value);
  factory RemixTextFieldStyler.textAlign(TextAlign value) =>
      RemixTextFieldStyler().textAlign(value);
  factory RemixTextFieldStyler.cursorWidth(double value) =>
      RemixTextFieldStyler().cursorWidth(value);
  factory RemixTextFieldStyler.cursorHeight(double value) =>
      RemixTextFieldStyler().cursorHeight(value);
  factory RemixTextFieldStyler.cursorRadius(Radius value) =>
      RemixTextFieldStyler().cursorRadius(value);
  factory RemixTextFieldStyler.cursorColor(Color value) =>
      RemixTextFieldStyler().cursorColor(value);
  factory RemixTextFieldStyler.selectionHeightStyle(BoxHeightStyle value) =>
      RemixTextFieldStyler().selectionHeightStyle(value);
  factory RemixTextFieldStyler.selectionWidthStyle(BoxWidthStyle value) =>
      RemixTextFieldStyler().selectionWidthStyle(value);
  factory RemixTextFieldStyler.scrollPadding(EdgeInsets value) =>
      RemixTextFieldStyler().scrollPadding(value);
  factory RemixTextFieldStyler.keyboardAppearance(Brightness value) =>
      RemixTextFieldStyler().keyboardAppearance(value);
  factory RemixTextFieldStyler.cursorOpacityAnimates(bool value) =>
      RemixTextFieldStyler().cursorOpacityAnimates(value);
  factory RemixTextFieldStyler.container(FlexBoxStyler value) =>
      RemixTextFieldStyler().container(value);
  factory RemixTextFieldStyler.layout(FlexBoxStyler value) =>
      RemixTextFieldStyler().layout(value);
  factory RemixTextFieldStyler.helperText(TextStyler value) =>
      RemixTextFieldStyler().helperText(value);
  factory RemixTextFieldStyler.label(TextStyler value) =>
      RemixTextFieldStyler().label(value);
  factory RemixTextFieldStyler.effects(RemixSurfaceEffectsMix value) =>
      RemixTextFieldStyler().effects(value);
  factory RemixTextFieldStyler.color(Color value) =>
      RemixTextFieldStyler().color(value);
  factory RemixTextFieldStyler.gradient(GradientMix value) =>
      RemixTextFieldStyler().gradient(value);
  factory RemixTextFieldStyler.border(BoxBorderMix value) =>
      RemixTextFieldStyler().border(value);
  factory RemixTextFieldStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixTextFieldStyler().borderRadius(value);
  factory RemixTextFieldStyler.elevation(ElevationShadow value) =>
      RemixTextFieldStyler().elevation(value);
  factory RemixTextFieldStyler.shadow(BoxShadowMix value) =>
      RemixTextFieldStyler().shadow(value);
  factory RemixTextFieldStyler.shadows(List<BoxShadowMix> value) =>
      RemixTextFieldStyler().shadows(value);
  factory RemixTextFieldStyler.width(double value) =>
      RemixTextFieldStyler().width(value);
  factory RemixTextFieldStyler.height(double value) =>
      RemixTextFieldStyler().height(value);
  factory RemixTextFieldStyler.size(double width, double height) =>
      RemixTextFieldStyler().size(width, height);
  factory RemixTextFieldStyler.minWidth(double value) =>
      RemixTextFieldStyler().minWidth(value);
  factory RemixTextFieldStyler.maxWidth(double value) =>
      RemixTextFieldStyler().maxWidth(value);
  factory RemixTextFieldStyler.minHeight(double value) =>
      RemixTextFieldStyler().minHeight(value);
  factory RemixTextFieldStyler.maxHeight(double value) =>
      RemixTextFieldStyler().maxHeight(value);
  factory RemixTextFieldStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixTextFieldStyler().scale(scale, alignment: alignment);
  factory RemixTextFieldStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixTextFieldStyler().rotate(radians, alignment: alignment);
  factory RemixTextFieldStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => RemixTextFieldStyler().translate(x, y, z);
  factory RemixTextFieldStyler.skew(double skewX, double skewY) =>
      RemixTextFieldStyler().skew(skewX, skewY);
  factory RemixTextFieldStyler.textStyle(TextStyler value) =>
      RemixTextFieldStyler().textStyle(value);
  factory RemixTextFieldStyler.image(DecorationImageMix value) =>
      RemixTextFieldStyler().image(value);
  factory RemixTextFieldStyler.shape(ShapeBorderMix value) =>
      RemixTextFieldStyler().shape(value);
  factory RemixTextFieldStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTextFieldStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTextFieldStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTextFieldStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTextFieldStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTextFieldStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTextFieldStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixTextFieldStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixTextFieldStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixTextFieldStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixTextFieldStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixTextFieldStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixTextFieldStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixTextFieldStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixTextFieldStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixTextFieldStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixTextFieldStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixTextFieldStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixTextFieldStyler.row() => RemixTextFieldStyler().row();
  factory RemixTextFieldStyler.column() => RemixTextFieldStyler().column();
  factory RemixTextFieldStyler.alignment(AlignmentGeometry value) =>
      RemixTextFieldStyler().alignment(value);
  factory RemixTextFieldStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixTextFieldStyler().padding(value);
  factory RemixTextFieldStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixTextFieldStyler().margin(value);
  factory RemixTextFieldStyler.constraints(BoxConstraintsMix value) =>
      RemixTextFieldStyler().constraints(value);
  factory RemixTextFieldStyler.decoration(DecorationMix value) =>
      RemixTextFieldStyler().decoration(value);
  factory RemixTextFieldStyler.foregroundDecoration(DecorationMix value) =>
      RemixTextFieldStyler().foregroundDecoration(value);
  factory RemixTextFieldStyler.clipBehavior(Clip value) =>
      RemixTextFieldStyler().clipBehavior(value);
  factory RemixTextFieldStyler.direction(Axis value) =>
      RemixTextFieldStyler().direction(value);
  factory RemixTextFieldStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixTextFieldStyler().mainAxisAlignment(value);
  factory RemixTextFieldStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixTextFieldStyler().crossAxisAlignment(value);
  factory RemixTextFieldStyler.mainAxisSize(MainAxisSize value) =>
      RemixTextFieldStyler().mainAxisSize(value);
  factory RemixTextFieldStyler.spacing(double value) =>
      RemixTextFieldStyler().spacing(value);
  factory RemixTextFieldStyler.verticalDirection(VerticalDirection value) =>
      RemixTextFieldStyler().verticalDirection(value);
  factory RemixTextFieldStyler.textDirection(TextDirection value) =>
      RemixTextFieldStyler().textDirection(value);
  factory RemixTextFieldStyler.textBaseline(TextBaseline value) =>
      RemixTextFieldStyler().textBaseline(value);
  factory RemixTextFieldStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixTextFieldStyler().transform(value, alignment: alignment);

  RemixTextFieldStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixTextFieldStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixTextFieldStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixTextFieldStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixTextFieldStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixTextFieldStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixTextFieldStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixTextFieldStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixTextFieldStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixTextFieldStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixTextFieldStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixTextFieldStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixTextFieldStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixTextFieldStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixTextFieldStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixTextFieldStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixTextFieldStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixTextFieldStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixTextFieldStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixTextFieldStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixTextFieldStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixTextFieldStyler backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImage(
        image,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  RemixTextFieldStyler backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImageUrl(
        url,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  RemixTextFieldStyler backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      FlexBoxStyler().backgroundImageAsset(
        path,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  RemixTextFieldStyler linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().linearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  RemixTextFieldStyler radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().radialGradient(
        colors: colors,
        stops: stops,
        center: center,
        radius: radius,
        focal: focal,
        focalRadius: focalRadius,
        tileMode: tileMode,
      ),
    );
  }

  RemixTextFieldStyler sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().sweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  RemixTextFieldStyler foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundLinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  RemixTextFieldStyler foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundRadialGradient(
        colors: colors,
        stops: stops,
        center: center,
        radius: radius,
        focal: focal,
        focalRadius: focalRadius,
        tileMode: tileMode,
      ),
    );
  }

  RemixTextFieldStyler foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      FlexBoxStyler().foregroundSweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  RemixTextFieldStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixTextFieldStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixTextFieldStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixTextFieldStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixTextFieldStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixTextFieldStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixTextFieldStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixTextFieldStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixTextFieldStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixTextFieldStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixTextFieldStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixTextFieldStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixTextFieldStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixTextFieldStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixTextFieldStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixTextFieldStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixTextFieldStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixTextFieldStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the text.
  RemixTextFieldStyler text(TextStyler value) {
    return merge(RemixTextFieldStyler(text: value));
  }

  /// Sets the hintText.
  RemixTextFieldStyler hintText(TextStyler value) {
    return merge(RemixTextFieldStyler(hintText: value));
  }

  /// Sets the textAlign.
  RemixTextFieldStyler textAlign(TextAlign value) {
    return merge(RemixTextFieldStyler(textAlign: value));
  }

  /// Sets the cursorWidth.
  RemixTextFieldStyler cursorWidth(double value) {
    return merge(RemixTextFieldStyler(cursorWidth: value));
  }

  /// Sets the cursorHeight.
  RemixTextFieldStyler cursorHeight(double value) {
    return merge(RemixTextFieldStyler(cursorHeight: value));
  }

  /// Sets the cursorRadius.
  RemixTextFieldStyler cursorRadius(Radius value) {
    return merge(RemixTextFieldStyler(cursorRadius: value));
  }

  /// Sets the cursorColor.
  RemixTextFieldStyler cursorColor(Color value) {
    return merge(RemixTextFieldStyler(cursorColor: value));
  }

  /// Sets the selectionHeightStyle.
  RemixTextFieldStyler selectionHeightStyle(BoxHeightStyle value) {
    return merge(RemixTextFieldStyler(selectionHeightStyle: value));
  }

  /// Sets the selectionWidthStyle.
  RemixTextFieldStyler selectionWidthStyle(BoxWidthStyle value) {
    return merge(RemixTextFieldStyler(selectionWidthStyle: value));
  }

  /// Sets the scrollPadding.
  RemixTextFieldStyler scrollPadding(EdgeInsets value) {
    return merge(RemixTextFieldStyler(scrollPadding: value));
  }

  /// Sets the keyboardAppearance.
  RemixTextFieldStyler keyboardAppearance(Brightness value) {
    return merge(RemixTextFieldStyler(keyboardAppearance: value));
  }

  /// Sets the cursorOpacityAnimates.
  RemixTextFieldStyler cursorOpacityAnimates(bool value) {
    return merge(RemixTextFieldStyler(cursorOpacityAnimates: value));
  }

  /// Sets the container.
  RemixTextFieldStyler container(FlexBoxStyler value) {
    return merge(RemixTextFieldStyler(container: value));
  }

  /// Sets the layout.
  RemixTextFieldStyler layout(FlexBoxStyler value) {
    return merge(RemixTextFieldStyler(layout: value));
  }

  /// Sets the helperText.
  RemixTextFieldStyler helperText(TextStyler value) {
    return merge(RemixTextFieldStyler(helperText: value));
  }

  /// Sets the label.
  @override
  RemixTextFieldStyler label(TextStyler value) {
    return merge(RemixTextFieldStyler(label: value));
  }

  /// Sets the effects.
  RemixTextFieldStyler effects(RemixSurfaceEffectsMix value) {
    return merge(RemixTextFieldStyler(effects: value));
  }

  /// Sets the animation configuration.
  @override
  RemixTextFieldStyler animate(AnimationConfig value) {
    return merge(RemixTextFieldStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixTextFieldStyler variants(List<VariantStyle<RemixTextFieldSpec>> value) {
    return merge(RemixTextFieldStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixTextFieldStyler wrap(WidgetModifierConfig value) {
    return merge(RemixTextFieldStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixTextFieldStyler modifier(WidgetModifierConfig value) {
    return merge(RemixTextFieldStyler(modifier: value));
  }

  /// Merges with another [RemixTextFieldStyler].
  @override
  RemixTextFieldStyler merge(RemixTextFieldStyler? other) {
    return RemixTextFieldStyler.create(
      text: MixOps.merge($text, other?.$text),
      hintText: MixOps.merge($hintText, other?.$hintText),
      textAlign: MixOps.merge($textAlign, other?.$textAlign),
      cursorWidth: MixOps.merge($cursorWidth, other?.$cursorWidth),
      cursorHeight: MixOps.merge($cursorHeight, other?.$cursorHeight),
      cursorRadius: MixOps.merge($cursorRadius, other?.$cursorRadius),
      cursorColor: MixOps.merge($cursorColor, other?.$cursorColor),
      selectionHeightStyle: MixOps.merge(
        $selectionHeightStyle,
        other?.$selectionHeightStyle,
      ),
      selectionWidthStyle: MixOps.merge(
        $selectionWidthStyle,
        other?.$selectionWidthStyle,
      ),
      scrollPadding: MixOps.merge($scrollPadding, other?.$scrollPadding),
      keyboardAppearance: MixOps.merge(
        $keyboardAppearance,
        other?.$keyboardAppearance,
      ),
      cursorOpacityAnimates: MixOps.merge(
        $cursorOpacityAnimates,
        other?.$cursorOpacityAnimates,
      ),
      container: MixOps.merge($container, other?.$container),
      layout: MixOps.merge($layout, other?.$layout),
      helperText: MixOps.merge($helperText, other?.$helperText),
      label: MixOps.merge($label, other?.$label),
      effects: MixOps.merge($effects, other?.$effects),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixTextFieldSpec>] using [context].
  @override
  StyleSpec<RemixTextFieldSpec> resolve(BuildContext context) {
    final spec = RemixTextFieldSpec(
      text: MixOps.resolve(context, $text),
      hintText: MixOps.resolve(context, $hintText),
      textAlign: MixOps.resolve(context, $textAlign),
      cursorWidth: MixOps.resolve(context, $cursorWidth),
      cursorHeight: MixOps.resolve(context, $cursorHeight),
      cursorRadius: MixOps.resolve(context, $cursorRadius),
      cursorColor: MixOps.resolve(context, $cursorColor),
      selectionHeightStyle: MixOps.resolve(context, $selectionHeightStyle),
      selectionWidthStyle: MixOps.resolve(context, $selectionWidthStyle),
      scrollPadding: MixOps.resolve(context, $scrollPadding),
      keyboardAppearance: MixOps.resolve(context, $keyboardAppearance),
      cursorOpacityAnimates: MixOps.resolve(context, $cursorOpacityAnimates),
      container: MixOps.resolve(context, $container),
      layout: MixOps.resolve(context, $layout),
      helperText: MixOps.resolve(context, $helperText),
      label: MixOps.resolve(context, $label),
      effects: MixOps.resolve(context, $effects),
    );

    return StyleSpec(
      spec: spec,
      animation: $animation,
      widgetModifiers: $modifier?.resolve(context),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('text', $text))
      ..add(DiagnosticsProperty('hintText', $hintText))
      ..add(DiagnosticsProperty('textAlign', $textAlign))
      ..add(DiagnosticsProperty('cursorWidth', $cursorWidth))
      ..add(DiagnosticsProperty('cursorHeight', $cursorHeight))
      ..add(DiagnosticsProperty('cursorRadius', $cursorRadius))
      ..add(DiagnosticsProperty('cursorColor', $cursorColor))
      ..add(DiagnosticsProperty('selectionHeightStyle', $selectionHeightStyle))
      ..add(DiagnosticsProperty('selectionWidthStyle', $selectionWidthStyle))
      ..add(DiagnosticsProperty('scrollPadding', $scrollPadding))
      ..add(DiagnosticsProperty('keyboardAppearance', $keyboardAppearance))
      ..add(
        DiagnosticsProperty('cursorOpacityAnimates', $cursorOpacityAnimates),
      )
      ..add(DiagnosticsProperty('container', $container))
      ..add(DiagnosticsProperty('layout', $layout))
      ..add(DiagnosticsProperty('helperText', $helperText))
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('effects', $effects));
  }

  @override
  List<Object?> get props => [
    $text,
    $hintText,
    $textAlign,
    $cursorWidth,
    $cursorHeight,
    $cursorRadius,
    $cursorColor,
    $selectionHeightStyle,
    $selectionWidthStyle,
    $scrollPadding,
    $keyboardAppearance,
    $cursorOpacityAnimates,
    $container,
    $layout,
    $helperText,
    $label,
    $effects,
    $animation,
    $modifier,
    $variants,
  ];
}
