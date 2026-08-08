// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'textfield.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$TextFieldSpec implements Spec<TextFieldSpec>, Diagnosticable {
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
  StyleSpec<BoxSpec> get container;
  double? get spacing;
  CrossAxisAlignment? get crossAxisAlignment;
  StyleSpec<FlexBoxSpec> get layout;
  StyleSpec<TextSpec> get helperText;
  StyleSpec<TextSpec> get label;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => TextFieldSpec;

  @override
  TextFieldSpec copyWith({
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
    StyleSpec<BoxSpec>? container,
    double? spacing,
    CrossAxisAlignment? crossAxisAlignment,
    StyleSpec<FlexBoxSpec>? layout,
    StyleSpec<TextSpec>? helperText,
    StyleSpec<TextSpec>? label,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return TextFieldSpec(
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
      spacing: spacing ?? this.spacing,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      layout: layout ?? this.layout,
      helperText: helperText ?? this.helperText,
      label: label ?? this.label,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  TextFieldSpec lerp(TextFieldSpec? other, double t) {
    return TextFieldSpec(
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
      spacing: MixOps.lerp(spacing, other?.spacing, t),
      crossAxisAlignment: MixOps.lerpSnap(
        crossAxisAlignment,
        other?.crossAxisAlignment,
        t,
      ),
      layout: layout.lerp(other?.layout, t),
      helperText: helperText.lerp(other?.helperText, t),
      label: label.lerp(other?.label, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
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
    spacing,
    crossAxisAlignment,
    layout,
    helperText,
    label,
    containerEffects,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TextFieldSpec &&
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
      ..add(DoubleProperty('spacing', spacing))
      ..add(
        EnumProperty<CrossAxisAlignment>(
          'crossAxisAlignment',
          crossAxisAlignment,
        ),
      )
      ..add(DiagnosticsProperty('layout', layout))
      ..add(DiagnosticsProperty('helperText', helperText))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$TextFieldSpec` and migrate the class declaration to `class TextFieldSpec with _\$TextFieldSpec`. The `_\$TextFieldSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$TextFieldSpecMethods = _$TextFieldSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class TextFieldStyler extends MixStyler<TextFieldStyler, TextFieldSpec>
    with
        RemixBoxStylerMixin<TextFieldStyler>,
        LabelStyleMixin<TextFieldStyler> {
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
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<double>? $spacing;
  final Prop<CrossAxisAlignment>? $crossAxisAlignment;
  final Prop<StyleSpec<FlexBoxSpec>>? $layout;
  final Prop<StyleSpec<TextSpec>>? $helperText;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const TextFieldStyler.create({
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
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<double>? spacing,
    Prop<CrossAxisAlignment>? crossAxisAlignment,
    Prop<StyleSpec<FlexBoxSpec>>? layout,
    Prop<StyleSpec<TextSpec>>? helperText,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<RemixBoxEffectsSpec>? containerEffects,
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
       $spacing = spacing,
       $crossAxisAlignment = crossAxisAlignment,
       $layout = layout,
       $helperText = helperText,
       $label = label,
       $containerEffects = containerEffects;

  TextFieldStyler({
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
    BoxStyler? container,
    double? spacing,
    CrossAxisAlignment? crossAxisAlignment,
    FlexBoxStyler? layout,
    TextStyler? helperText,
    TextStyler? label,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<TextFieldSpec>>? variants,
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
         spacing: Prop.maybe(spacing),
         crossAxisAlignment: Prop.maybe(crossAxisAlignment),
         layout: Prop.maybeMix(layout),
         helperText: Prop.maybeMix(helperText),
         label: Prop.maybeMix(label),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory TextFieldStyler.text(TextStyler value) =>
      TextFieldStyler().text(value);
  factory TextFieldStyler.hintText(TextStyler value) =>
      TextFieldStyler().hintText(value);
  factory TextFieldStyler.textAlign(TextAlign value) =>
      TextFieldStyler().textAlign(value);
  factory TextFieldStyler.cursorWidth(double value) =>
      TextFieldStyler().cursorWidth(value);
  factory TextFieldStyler.cursorHeight(double value) =>
      TextFieldStyler().cursorHeight(value);
  factory TextFieldStyler.cursorRadius(Radius value) =>
      TextFieldStyler().cursorRadius(value);
  factory TextFieldStyler.cursorColor(Color value) =>
      TextFieldStyler().cursorColor(value);
  factory TextFieldStyler.selectionHeightStyle(BoxHeightStyle value) =>
      TextFieldStyler().selectionHeightStyle(value);
  factory TextFieldStyler.selectionWidthStyle(BoxWidthStyle value) =>
      TextFieldStyler().selectionWidthStyle(value);
  factory TextFieldStyler.scrollPadding(EdgeInsets value) =>
      TextFieldStyler().scrollPadding(value);
  factory TextFieldStyler.keyboardAppearance(Brightness value) =>
      TextFieldStyler().keyboardAppearance(value);
  factory TextFieldStyler.cursorOpacityAnimates(bool value) =>
      TextFieldStyler().cursorOpacityAnimates(value);
  factory TextFieldStyler.container(BoxStyler value) =>
      TextFieldStyler().container(value);
  factory TextFieldStyler.spacing(double value) =>
      TextFieldStyler().spacing(value);
  factory TextFieldStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      TextFieldStyler().crossAxisAlignment(value);
  factory TextFieldStyler.layout(FlexBoxStyler value) =>
      TextFieldStyler().layout(value);
  factory TextFieldStyler.helperText(TextStyler value) =>
      TextFieldStyler().helperText(value);
  factory TextFieldStyler.label(TextStyler value) =>
      TextFieldStyler().label(value);
  factory TextFieldStyler.containerEffects(RemixBoxEffectsMix value) =>
      TextFieldStyler().containerEffects(value);
  factory TextFieldStyler.alignment(AlignmentGeometry value) =>
      TextFieldStyler().alignment(value);
  factory TextFieldStyler.padding(EdgeInsetsGeometryMix value) =>
      TextFieldStyler().padding(value);
  factory TextFieldStyler.margin(EdgeInsetsGeometryMix value) =>
      TextFieldStyler().margin(value);
  factory TextFieldStyler.constraints(BoxConstraintsMix value) =>
      TextFieldStyler().constraints(value);
  factory TextFieldStyler.decoration(DecorationMix value) =>
      TextFieldStyler().decoration(value);
  factory TextFieldStyler.foregroundDecoration(DecorationMix value) =>
      TextFieldStyler().foregroundDecoration(value);
  factory TextFieldStyler.clipBehavior(Clip value) =>
      TextFieldStyler().clipBehavior(value);
  factory TextFieldStyler.color(Color value) => TextFieldStyler().color(value);
  factory TextFieldStyler.gradient(GradientMix value) =>
      TextFieldStyler().gradient(value);
  factory TextFieldStyler.border(BoxBorderMix value) =>
      TextFieldStyler().border(value);
  factory TextFieldStyler.borderRadius(BorderRadiusGeometryMix value) =>
      TextFieldStyler().borderRadius(value);
  factory TextFieldStyler.elevation(ElevationShadow value) =>
      TextFieldStyler().elevation(value);
  factory TextFieldStyler.shadow(BoxShadowMix value) =>
      TextFieldStyler().shadow(value);
  factory TextFieldStyler.shadows(List<BoxShadowMix> value) =>
      TextFieldStyler().shadows(value);
  factory TextFieldStyler.width(double value) => TextFieldStyler().width(value);
  factory TextFieldStyler.height(double value) =>
      TextFieldStyler().height(value);
  factory TextFieldStyler.size(double width, double height) =>
      TextFieldStyler().size(width, height);
  factory TextFieldStyler.minWidth(double value) =>
      TextFieldStyler().minWidth(value);
  factory TextFieldStyler.maxWidth(double value) =>
      TextFieldStyler().maxWidth(value);
  factory TextFieldStyler.minHeight(double value) =>
      TextFieldStyler().minHeight(value);
  factory TextFieldStyler.maxHeight(double value) =>
      TextFieldStyler().maxHeight(value);
  factory TextFieldStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => TextFieldStyler().scale(scale, alignment: alignment);
  factory TextFieldStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => TextFieldStyler().rotate(radians, alignment: alignment);
  factory TextFieldStyler.translate(double x, double y, [double z = 0.0]) =>
      TextFieldStyler().translate(x, y, z);
  factory TextFieldStyler.skew(double skewX, double skewY) =>
      TextFieldStyler().skew(skewX, skewY);
  factory TextFieldStyler.textStyle(TextStyler value) =>
      TextFieldStyler().textStyle(value);
  factory TextFieldStyler.image(DecorationImageMix value) =>
      TextFieldStyler().image(value);
  factory TextFieldStyler.shape(ShapeBorderMix value) =>
      TextFieldStyler().shape(value);
  factory TextFieldStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TextFieldStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TextFieldStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TextFieldStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TextFieldStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TextFieldStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TextFieldStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => TextFieldStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory TextFieldStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => TextFieldStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory TextFieldStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => TextFieldStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory TextFieldStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => TextFieldStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory TextFieldStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => TextFieldStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory TextFieldStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => TextFieldStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory TextFieldStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => TextFieldStyler().transform(value, alignment: alignment);

  TextFieldStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  TextFieldStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  TextFieldStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  TextFieldStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  TextFieldStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  TextFieldStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  TextFieldStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  TextFieldStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  TextFieldStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  TextFieldStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  TextFieldStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  TextFieldStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  TextFieldStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  TextFieldStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  TextFieldStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  TextFieldStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  TextFieldStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  TextFieldStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  TextFieldStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  TextFieldStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  TextFieldStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  TextFieldStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  TextFieldStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  TextFieldStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  TextFieldStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  TextFieldStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  TextFieldStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  TextFieldStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  TextFieldStyler backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      BoxStyler().backgroundImage(
        image,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  TextFieldStyler backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      BoxStyler().backgroundImageUrl(
        url,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  TextFieldStyler backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return container(
      BoxStyler().backgroundImageAsset(
        path,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  TextFieldStyler linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().linearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  TextFieldStyler radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().radialGradient(
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

  TextFieldStyler sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().sweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  TextFieldStyler foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().foregroundLinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  TextFieldStyler foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().foregroundRadialGradient(
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

  TextFieldStyler foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return container(
      BoxStyler().foregroundSweepGradient(
        colors: colors,
        stops: stops,
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        tileMode: tileMode,
      ),
    );
  }

  TextFieldStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the text.
  TextFieldStyler text(TextStyler value) {
    return merge(TextFieldStyler(text: value));
  }

  /// Sets the hintText.
  TextFieldStyler hintText(TextStyler value) {
    return merge(TextFieldStyler(hintText: value));
  }

  /// Sets the textAlign.
  TextFieldStyler textAlign(TextAlign value) {
    return merge(TextFieldStyler(textAlign: value));
  }

  /// Sets the cursorWidth.
  TextFieldStyler cursorWidth(double value) {
    return merge(TextFieldStyler(cursorWidth: value));
  }

  /// Sets the cursorHeight.
  TextFieldStyler cursorHeight(double value) {
    return merge(TextFieldStyler(cursorHeight: value));
  }

  /// Sets the cursorRadius.
  TextFieldStyler cursorRadius(Radius value) {
    return merge(TextFieldStyler(cursorRadius: value));
  }

  /// Sets the cursorColor.
  TextFieldStyler cursorColor(Color value) {
    return merge(TextFieldStyler(cursorColor: value));
  }

  /// Sets the selectionHeightStyle.
  TextFieldStyler selectionHeightStyle(BoxHeightStyle value) {
    return merge(TextFieldStyler(selectionHeightStyle: value));
  }

  /// Sets the selectionWidthStyle.
  TextFieldStyler selectionWidthStyle(BoxWidthStyle value) {
    return merge(TextFieldStyler(selectionWidthStyle: value));
  }

  /// Sets the scrollPadding.
  TextFieldStyler scrollPadding(EdgeInsets value) {
    return merge(TextFieldStyler(scrollPadding: value));
  }

  /// Sets the keyboardAppearance.
  TextFieldStyler keyboardAppearance(Brightness value) {
    return merge(TextFieldStyler(keyboardAppearance: value));
  }

  /// Sets the cursorOpacityAnimates.
  TextFieldStyler cursorOpacityAnimates(bool value) {
    return merge(TextFieldStyler(cursorOpacityAnimates: value));
  }

  /// Sets the container.
  TextFieldStyler container(BoxStyler value) {
    return merge(TextFieldStyler(container: value));
  }

  /// Sets the spacing.
  TextFieldStyler spacing(double value) {
    return merge(TextFieldStyler(spacing: value));
  }

  /// Sets the crossAxisAlignment.
  TextFieldStyler crossAxisAlignment(CrossAxisAlignment value) {
    return merge(TextFieldStyler(crossAxisAlignment: value));
  }

  /// Sets the layout.
  TextFieldStyler layout(FlexBoxStyler value) {
    return merge(TextFieldStyler(layout: value));
  }

  /// Sets the helperText.
  TextFieldStyler helperText(TextStyler value) {
    return merge(TextFieldStyler(helperText: value));
  }

  /// Sets the label.
  @override
  TextFieldStyler label(TextStyler value) {
    return merge(TextFieldStyler(label: value));
  }

  /// Sets the containerEffects.
  TextFieldStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(TextFieldStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  TextFieldStyler animate(AnimationConfig value) {
    return merge(TextFieldStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  TextFieldStyler variants(List<VariantStyle<TextFieldSpec>> value) {
    return merge(TextFieldStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  TextFieldStyler wrap(WidgetModifierConfig value) {
    return merge(TextFieldStyler(modifier: value));
  }

  /// Sets the widget modifier.
  TextFieldStyler modifier(WidgetModifierConfig value) {
    return merge(TextFieldStyler(modifier: value));
  }

  /// Merges with another [TextFieldStyler].
  @override
  TextFieldStyler merge(TextFieldStyler? other) {
    return TextFieldStyler.create(
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
      spacing: MixOps.merge($spacing, other?.$spacing),
      crossAxisAlignment: MixOps.merge(
        $crossAxisAlignment,
        other?.$crossAxisAlignment,
      ),
      layout: MixOps.merge($layout, other?.$layout),
      helperText: MixOps.merge($helperText, other?.$helperText),
      label: MixOps.merge($label, other?.$label),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<TextFieldSpec>] using [context].
  @override
  StyleSpec<TextFieldSpec> resolve(BuildContext context) {
    final spec = TextFieldSpec(
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
      spacing: MixOps.resolve(context, $spacing),
      crossAxisAlignment: MixOps.resolve(context, $crossAxisAlignment),
      layout: MixOps.resolve(context, $layout),
      helperText: MixOps.resolve(context, $helperText),
      label: MixOps.resolve(context, $label),
      containerEffects: MixOps.resolve(context, $containerEffects),
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
      ..add(DiagnosticsProperty('spacing', $spacing))
      ..add(DiagnosticsProperty('crossAxisAlignment', $crossAxisAlignment))
      ..add(DiagnosticsProperty('layout', $layout))
      ..add(DiagnosticsProperty('helperText', $helperText))
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
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
    $spacing,
    $crossAxisAlignment,
    $layout,
    $helperText,
    $label,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
