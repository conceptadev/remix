// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$ToggleSpec implements Spec<ToggleSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => ToggleSpec;

  @override
  ToggleSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) {
    return ToggleSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  @override
  ToggleSpec lerp(ToggleSpec? other, double t) {
    return ToggleSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      icon: icon.lerp(other?.icon, t),
    );
  }

  @override
  List<Object?> get props => [container, label, icon];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ToggleSpec &&
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
      ..add(DiagnosticsProperty('container', container))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('icon', icon));
  }
}

@Deprecated(
  'Rename to `_\$ToggleSpec` and migrate the class declaration to `class ToggleSpec with _\$ToggleSpec`. The `_\$ToggleSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$ToggleSpecMethods = _$ToggleSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class ToggleStyler extends MixStyler<ToggleStyler, ToggleSpec>
    with
        RemixBoxStylerMixin<ToggleStyler>,
        LabelStyleMixin<ToggleStyler>,
        IconStyleMixin<ToggleStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const ToggleStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon;

  ToggleStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<ToggleSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory ToggleStyler.container(FlexBoxStyler value) =>
      ToggleStyler().container(value);
  factory ToggleStyler.label(TextStyler value) => ToggleStyler().label(value);
  factory ToggleStyler.icon(IconStyler value) => ToggleStyler().icon(value);
  factory ToggleStyler.color(Color value) => ToggleStyler().color(value);
  factory ToggleStyler.gradient(GradientMix value) =>
      ToggleStyler().gradient(value);
  factory ToggleStyler.border(BoxBorderMix value) =>
      ToggleStyler().border(value);
  factory ToggleStyler.borderRadius(BorderRadiusGeometryMix value) =>
      ToggleStyler().borderRadius(value);
  factory ToggleStyler.elevation(ElevationShadow value) =>
      ToggleStyler().elevation(value);
  factory ToggleStyler.shadow(BoxShadowMix value) =>
      ToggleStyler().shadow(value);
  factory ToggleStyler.shadows(List<BoxShadowMix> value) =>
      ToggleStyler().shadows(value);
  factory ToggleStyler.width(double value) => ToggleStyler().width(value);
  factory ToggleStyler.height(double value) => ToggleStyler().height(value);
  factory ToggleStyler.size(double width, double height) =>
      ToggleStyler().size(width, height);
  factory ToggleStyler.minWidth(double value) => ToggleStyler().minWidth(value);
  factory ToggleStyler.maxWidth(double value) => ToggleStyler().maxWidth(value);
  factory ToggleStyler.minHeight(double value) =>
      ToggleStyler().minHeight(value);
  factory ToggleStyler.maxHeight(double value) =>
      ToggleStyler().maxHeight(value);
  factory ToggleStyler.scale(double scale, {Alignment alignment = .center}) =>
      ToggleStyler().scale(scale, alignment: alignment);
  factory ToggleStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => ToggleStyler().rotate(radians, alignment: alignment);
  factory ToggleStyler.translate(double x, double y, [double z = 0.0]) =>
      ToggleStyler().translate(x, y, z);
  factory ToggleStyler.skew(double skewX, double skewY) =>
      ToggleStyler().skew(skewX, skewY);
  factory ToggleStyler.textStyle(TextStyler value) =>
      ToggleStyler().textStyle(value);
  factory ToggleStyler.image(DecorationImageMix value) =>
      ToggleStyler().image(value);
  factory ToggleStyler.shape(ShapeBorderMix value) =>
      ToggleStyler().shape(value);
  factory ToggleStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToggleStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToggleStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToggleStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToggleStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToggleStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToggleStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ToggleStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ToggleStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ToggleStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ToggleStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ToggleStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ToggleStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ToggleStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ToggleStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ToggleStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ToggleStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ToggleStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ToggleStyler.row() => ToggleStyler().row();
  factory ToggleStyler.column() => ToggleStyler().column();
  factory ToggleStyler.alignment(AlignmentGeometry value) =>
      ToggleStyler().alignment(value);
  factory ToggleStyler.padding(EdgeInsetsGeometryMix value) =>
      ToggleStyler().padding(value);
  factory ToggleStyler.margin(EdgeInsetsGeometryMix value) =>
      ToggleStyler().margin(value);
  factory ToggleStyler.constraints(BoxConstraintsMix value) =>
      ToggleStyler().constraints(value);
  factory ToggleStyler.decoration(DecorationMix value) =>
      ToggleStyler().decoration(value);
  factory ToggleStyler.foregroundDecoration(DecorationMix value) =>
      ToggleStyler().foregroundDecoration(value);
  factory ToggleStyler.clipBehavior(Clip value) =>
      ToggleStyler().clipBehavior(value);
  factory ToggleStyler.direction(Axis value) => ToggleStyler().direction(value);
  factory ToggleStyler.mainAxisAlignment(MainAxisAlignment value) =>
      ToggleStyler().mainAxisAlignment(value);
  factory ToggleStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      ToggleStyler().crossAxisAlignment(value);
  factory ToggleStyler.mainAxisSize(MainAxisSize value) =>
      ToggleStyler().mainAxisSize(value);
  factory ToggleStyler.spacing(double value) => ToggleStyler().spacing(value);
  factory ToggleStyler.verticalDirection(VerticalDirection value) =>
      ToggleStyler().verticalDirection(value);
  factory ToggleStyler.textDirection(TextDirection value) =>
      ToggleStyler().textDirection(value);
  factory ToggleStyler.textBaseline(TextBaseline value) =>
      ToggleStyler().textBaseline(value);
  factory ToggleStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => ToggleStyler().transform(value, alignment: alignment);

  ToggleStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  ToggleStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  ToggleStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  ToggleStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  ToggleStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  ToggleStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  ToggleStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  ToggleStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  ToggleStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  ToggleStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  ToggleStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  ToggleStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  ToggleStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  ToggleStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  ToggleStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  ToggleStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  ToggleStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  ToggleStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  ToggleStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  ToggleStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  ToggleStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  ToggleStyler backgroundImage(
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

  ToggleStyler backgroundImageUrl(
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

  ToggleStyler backgroundImageAsset(
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

  ToggleStyler linearGradient({
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

  ToggleStyler radialGradient({
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

  ToggleStyler sweepGradient({
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

  ToggleStyler foregroundLinearGradient({
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

  ToggleStyler foregroundRadialGradient({
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

  ToggleStyler foregroundSweepGradient({
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

  ToggleStyler row() {
    return container(FlexBoxStyler().row());
  }

  ToggleStyler column() {
    return container(FlexBoxStyler().column());
  }

  ToggleStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  ToggleStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  ToggleStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  ToggleStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  ToggleStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  ToggleStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  ToggleStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  ToggleStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  ToggleStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  ToggleStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  ToggleStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  ToggleStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  ToggleStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  ToggleStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  ToggleStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  ToggleStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  ToggleStyler container(FlexBoxStyler value) {
    return merge(ToggleStyler(container: value));
  }

  /// Sets the label.
  @override
  ToggleStyler label(TextStyler value) {
    return merge(ToggleStyler(label: value));
  }

  /// Sets the icon.
  @override
  ToggleStyler icon(IconStyler value) {
    return merge(ToggleStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  ToggleStyler animate(AnimationConfig value) {
    return merge(ToggleStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  ToggleStyler variants(List<VariantStyle<ToggleSpec>> value) {
    return merge(ToggleStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  ToggleStyler wrap(WidgetModifierConfig value) {
    return merge(ToggleStyler(modifier: value));
  }

  /// Sets the widget modifier.
  ToggleStyler modifier(WidgetModifierConfig value) {
    return merge(ToggleStyler(modifier: value));
  }

  /// Merges with another [ToggleStyler].
  @override
  ToggleStyler merge(ToggleStyler? other) {
    return ToggleStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<ToggleSpec>] using [context].
  @override
  StyleSpec<ToggleSpec> resolve(BuildContext context) {
    final spec = ToggleSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      icon: MixOps.resolve(context, $icon),
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
      ..add(DiagnosticsProperty('container', $container))
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('icon', $icon));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $icon,
    $animation,
    $modifier,
    $variants,
  ];
}
