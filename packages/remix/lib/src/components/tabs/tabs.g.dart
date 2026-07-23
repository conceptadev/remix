// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabs.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixTabBarSpec implements Spec<RemixTabBarSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;

  @override
  Type get type => RemixTabBarSpec;

  @override
  RemixTabBarSpec copyWith({StyleSpec<FlexBoxSpec>? container}) {
    return RemixTabBarSpec(container: container ?? this.container);
  }

  @override
  RemixTabBarSpec lerp(RemixTabBarSpec? other, double t) {
    return RemixTabBarSpec(container: container.lerp(other?.container, t));
  }

  @override
  List<Object?> get props => [container];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixTabBarSpec &&
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
    properties.add(DiagnosticsProperty('container', container));
  }
}

@Deprecated(
  'Rename to `_\$RemixTabBarSpec` and migrate the class declaration to `class RemixTabBarSpec with _\$RemixTabBarSpec`. The `_\$RemixTabBarSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixTabBarSpecMethods = _$RemixTabBarSpec; // ignore: unused_element

mixin _$RemixTabSpec implements Spec<RemixTabSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => RemixTabSpec;

  @override
  RemixTabSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) {
    return RemixTabSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  @override
  RemixTabSpec lerp(RemixTabSpec? other, double t) {
    return RemixTabSpec(
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
        other is RemixTabSpec &&
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
  'Rename to `_\$RemixTabSpec` and migrate the class declaration to `class RemixTabSpec with _\$RemixTabSpec`. The `_\$RemixTabSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixTabSpecMethods = _$RemixTabSpec; // ignore: unused_element

mixin _$RemixTabViewSpec implements Spec<RemixTabViewSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;

  @override
  Type get type => RemixTabViewSpec;

  @override
  RemixTabViewSpec copyWith({StyleSpec<BoxSpec>? container}) {
    return RemixTabViewSpec(container: container ?? this.container);
  }

  @override
  RemixTabViewSpec lerp(RemixTabViewSpec? other, double t) {
    return RemixTabViewSpec(container: container.lerp(other?.container, t));
  }

  @override
  List<Object?> get props => [container];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixTabViewSpec &&
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
    properties.add(DiagnosticsProperty('container', container));
  }
}

@Deprecated(
  'Rename to `_\$RemixTabViewSpec` and migrate the class declaration to `class RemixTabViewSpec with _\$RemixTabViewSpec`. The `_\$RemixTabViewSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixTabViewSpecMethods = _$RemixTabViewSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixTabBarStyler extends MixStyler<RemixTabBarStyler, RemixTabBarSpec>
    with RemixBoxStylerMixin<RemixTabBarStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;

  const RemixTabBarStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container;

  RemixTabBarStyler({
    FlexBoxStyler? container,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixTabBarSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixTabBarStyler.container(FlexBoxStyler value) =>
      RemixTabBarStyler().container(value);
  factory RemixTabBarStyler.color(Color value) =>
      RemixTabBarStyler().color(value);
  factory RemixTabBarStyler.gradient(GradientMix value) =>
      RemixTabBarStyler().gradient(value);
  factory RemixTabBarStyler.border(BoxBorderMix value) =>
      RemixTabBarStyler().border(value);
  factory RemixTabBarStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixTabBarStyler().borderRadius(value);
  factory RemixTabBarStyler.elevation(ElevationShadow value) =>
      RemixTabBarStyler().elevation(value);
  factory RemixTabBarStyler.shadow(BoxShadowMix value) =>
      RemixTabBarStyler().shadow(value);
  factory RemixTabBarStyler.shadows(List<BoxShadowMix> value) =>
      RemixTabBarStyler().shadows(value);
  factory RemixTabBarStyler.width(double value) =>
      RemixTabBarStyler().width(value);
  factory RemixTabBarStyler.height(double value) =>
      RemixTabBarStyler().height(value);
  factory RemixTabBarStyler.size(double width, double height) =>
      RemixTabBarStyler().size(width, height);
  factory RemixTabBarStyler.minWidth(double value) =>
      RemixTabBarStyler().minWidth(value);
  factory RemixTabBarStyler.maxWidth(double value) =>
      RemixTabBarStyler().maxWidth(value);
  factory RemixTabBarStyler.minHeight(double value) =>
      RemixTabBarStyler().minHeight(value);
  factory RemixTabBarStyler.maxHeight(double value) =>
      RemixTabBarStyler().maxHeight(value);
  factory RemixTabBarStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixTabBarStyler().scale(scale, alignment: alignment);
  factory RemixTabBarStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixTabBarStyler().rotate(radians, alignment: alignment);
  factory RemixTabBarStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixTabBarStyler().translate(x, y, z);
  factory RemixTabBarStyler.skew(double skewX, double skewY) =>
      RemixTabBarStyler().skew(skewX, skewY);
  factory RemixTabBarStyler.textStyle(TextStyler value) =>
      RemixTabBarStyler().textStyle(value);
  factory RemixTabBarStyler.image(DecorationImageMix value) =>
      RemixTabBarStyler().image(value);
  factory RemixTabBarStyler.shape(ShapeBorderMix value) =>
      RemixTabBarStyler().shape(value);
  factory RemixTabBarStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTabBarStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTabBarStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTabBarStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTabBarStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTabBarStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTabBarStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixTabBarStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixTabBarStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixTabBarStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixTabBarStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixTabBarStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixTabBarStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixTabBarStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixTabBarStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixTabBarStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixTabBarStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixTabBarStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixTabBarStyler.row() => RemixTabBarStyler().row();
  factory RemixTabBarStyler.column() => RemixTabBarStyler().column();
  factory RemixTabBarStyler.alignment(AlignmentGeometry value) =>
      RemixTabBarStyler().alignment(value);
  factory RemixTabBarStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixTabBarStyler().padding(value);
  factory RemixTabBarStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixTabBarStyler().margin(value);
  factory RemixTabBarStyler.constraints(BoxConstraintsMix value) =>
      RemixTabBarStyler().constraints(value);
  factory RemixTabBarStyler.decoration(DecorationMix value) =>
      RemixTabBarStyler().decoration(value);
  factory RemixTabBarStyler.foregroundDecoration(DecorationMix value) =>
      RemixTabBarStyler().foregroundDecoration(value);
  factory RemixTabBarStyler.clipBehavior(Clip value) =>
      RemixTabBarStyler().clipBehavior(value);
  factory RemixTabBarStyler.direction(Axis value) =>
      RemixTabBarStyler().direction(value);
  factory RemixTabBarStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixTabBarStyler().mainAxisAlignment(value);
  factory RemixTabBarStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixTabBarStyler().crossAxisAlignment(value);
  factory RemixTabBarStyler.mainAxisSize(MainAxisSize value) =>
      RemixTabBarStyler().mainAxisSize(value);
  factory RemixTabBarStyler.spacing(double value) =>
      RemixTabBarStyler().spacing(value);
  factory RemixTabBarStyler.verticalDirection(VerticalDirection value) =>
      RemixTabBarStyler().verticalDirection(value);
  factory RemixTabBarStyler.textDirection(TextDirection value) =>
      RemixTabBarStyler().textDirection(value);
  factory RemixTabBarStyler.textBaseline(TextBaseline value) =>
      RemixTabBarStyler().textBaseline(value);
  factory RemixTabBarStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixTabBarStyler().transform(value, alignment: alignment);

  RemixTabBarStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixTabBarStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixTabBarStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixTabBarStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixTabBarStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixTabBarStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixTabBarStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixTabBarStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixTabBarStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixTabBarStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixTabBarStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixTabBarStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixTabBarStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixTabBarStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixTabBarStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixTabBarStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixTabBarStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixTabBarStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixTabBarStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixTabBarStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixTabBarStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixTabBarStyler backgroundImage(
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

  RemixTabBarStyler backgroundImageUrl(
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

  RemixTabBarStyler backgroundImageAsset(
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

  RemixTabBarStyler linearGradient({
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

  RemixTabBarStyler radialGradient({
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

  RemixTabBarStyler sweepGradient({
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

  RemixTabBarStyler foregroundLinearGradient({
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

  RemixTabBarStyler foregroundRadialGradient({
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

  RemixTabBarStyler foregroundSweepGradient({
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

  RemixTabBarStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixTabBarStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixTabBarStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixTabBarStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixTabBarStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixTabBarStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixTabBarStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixTabBarStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixTabBarStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixTabBarStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixTabBarStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixTabBarStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixTabBarStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixTabBarStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixTabBarStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixTabBarStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixTabBarStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixTabBarStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixTabBarStyler container(FlexBoxStyler value) {
    return merge(RemixTabBarStyler(container: value));
  }

  /// Sets the animation configuration.
  @override
  RemixTabBarStyler animate(AnimationConfig value) {
    return merge(RemixTabBarStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixTabBarStyler variants(List<VariantStyle<RemixTabBarSpec>> value) {
    return merge(RemixTabBarStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixTabBarStyler wrap(WidgetModifierConfig value) {
    return merge(RemixTabBarStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixTabBarStyler modifier(WidgetModifierConfig value) {
    return merge(RemixTabBarStyler(modifier: value));
  }

  /// Merges with another [RemixTabBarStyler].
  @override
  RemixTabBarStyler merge(RemixTabBarStyler? other) {
    return RemixTabBarStyler.create(
      container: MixOps.merge($container, other?.$container),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixTabBarSpec>] using [context].
  @override
  StyleSpec<RemixTabBarSpec> resolve(BuildContext context) {
    final spec = RemixTabBarSpec(
      container: MixOps.resolve(context, $container),
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
    properties.add(DiagnosticsProperty('container', $container));
  }

  @override
  List<Object?> get props => [$container, $animation, $modifier, $variants];
}

class RemixTabStyler extends MixStyler<RemixTabStyler, RemixTabSpec>
    with
        RemixBoxStylerMixin<RemixTabStyler>,
        LabelStyleMixin<RemixTabStyler>,
        IconStyleMixin<RemixTabStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const RemixTabStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon;

  RemixTabStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixTabSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixTabStyler.container(FlexBoxStyler value) =>
      RemixTabStyler().container(value);
  factory RemixTabStyler.label(TextStyler value) =>
      RemixTabStyler().label(value);
  factory RemixTabStyler.icon(IconStyler value) => RemixTabStyler().icon(value);
  factory RemixTabStyler.color(Color value) => RemixTabStyler().color(value);
  factory RemixTabStyler.gradient(GradientMix value) =>
      RemixTabStyler().gradient(value);
  factory RemixTabStyler.border(BoxBorderMix value) =>
      RemixTabStyler().border(value);
  factory RemixTabStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixTabStyler().borderRadius(value);
  factory RemixTabStyler.elevation(ElevationShadow value) =>
      RemixTabStyler().elevation(value);
  factory RemixTabStyler.shadow(BoxShadowMix value) =>
      RemixTabStyler().shadow(value);
  factory RemixTabStyler.shadows(List<BoxShadowMix> value) =>
      RemixTabStyler().shadows(value);
  factory RemixTabStyler.width(double value) => RemixTabStyler().width(value);
  factory RemixTabStyler.height(double value) => RemixTabStyler().height(value);
  factory RemixTabStyler.size(double width, double height) =>
      RemixTabStyler().size(width, height);
  factory RemixTabStyler.minWidth(double value) =>
      RemixTabStyler().minWidth(value);
  factory RemixTabStyler.maxWidth(double value) =>
      RemixTabStyler().maxWidth(value);
  factory RemixTabStyler.minHeight(double value) =>
      RemixTabStyler().minHeight(value);
  factory RemixTabStyler.maxHeight(double value) =>
      RemixTabStyler().maxHeight(value);
  factory RemixTabStyler.scale(double scale, {Alignment alignment = .center}) =>
      RemixTabStyler().scale(scale, alignment: alignment);
  factory RemixTabStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixTabStyler().rotate(radians, alignment: alignment);
  factory RemixTabStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixTabStyler().translate(x, y, z);
  factory RemixTabStyler.skew(double skewX, double skewY) =>
      RemixTabStyler().skew(skewX, skewY);
  factory RemixTabStyler.textStyle(TextStyler value) =>
      RemixTabStyler().textStyle(value);
  factory RemixTabStyler.image(DecorationImageMix value) =>
      RemixTabStyler().image(value);
  factory RemixTabStyler.shape(ShapeBorderMix value) =>
      RemixTabStyler().shape(value);
  factory RemixTabStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTabStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTabStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTabStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTabStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTabStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTabStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixTabStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixTabStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixTabStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixTabStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixTabStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixTabStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixTabStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixTabStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixTabStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixTabStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixTabStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixTabStyler.row() => RemixTabStyler().row();
  factory RemixTabStyler.column() => RemixTabStyler().column();
  factory RemixTabStyler.alignment(AlignmentGeometry value) =>
      RemixTabStyler().alignment(value);
  factory RemixTabStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixTabStyler().padding(value);
  factory RemixTabStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixTabStyler().margin(value);
  factory RemixTabStyler.constraints(BoxConstraintsMix value) =>
      RemixTabStyler().constraints(value);
  factory RemixTabStyler.decoration(DecorationMix value) =>
      RemixTabStyler().decoration(value);
  factory RemixTabStyler.foregroundDecoration(DecorationMix value) =>
      RemixTabStyler().foregroundDecoration(value);
  factory RemixTabStyler.clipBehavior(Clip value) =>
      RemixTabStyler().clipBehavior(value);
  factory RemixTabStyler.direction(Axis value) =>
      RemixTabStyler().direction(value);
  factory RemixTabStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixTabStyler().mainAxisAlignment(value);
  factory RemixTabStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixTabStyler().crossAxisAlignment(value);
  factory RemixTabStyler.mainAxisSize(MainAxisSize value) =>
      RemixTabStyler().mainAxisSize(value);
  factory RemixTabStyler.spacing(double value) =>
      RemixTabStyler().spacing(value);
  factory RemixTabStyler.verticalDirection(VerticalDirection value) =>
      RemixTabStyler().verticalDirection(value);
  factory RemixTabStyler.textDirection(TextDirection value) =>
      RemixTabStyler().textDirection(value);
  factory RemixTabStyler.textBaseline(TextBaseline value) =>
      RemixTabStyler().textBaseline(value);
  factory RemixTabStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixTabStyler().transform(value, alignment: alignment);

  RemixTabStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixTabStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixTabStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixTabStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixTabStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixTabStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixTabStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixTabStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixTabStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixTabStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixTabStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixTabStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixTabStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixTabStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixTabStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixTabStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixTabStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixTabStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixTabStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixTabStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixTabStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixTabStyler backgroundImage(
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

  RemixTabStyler backgroundImageUrl(
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

  RemixTabStyler backgroundImageAsset(
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

  RemixTabStyler linearGradient({
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

  RemixTabStyler radialGradient({
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

  RemixTabStyler sweepGradient({
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

  RemixTabStyler foregroundLinearGradient({
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

  RemixTabStyler foregroundRadialGradient({
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

  RemixTabStyler foregroundSweepGradient({
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

  RemixTabStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixTabStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixTabStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixTabStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixTabStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixTabStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixTabStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixTabStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixTabStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixTabStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixTabStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixTabStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixTabStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixTabStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixTabStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixTabStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixTabStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixTabStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixTabStyler container(FlexBoxStyler value) {
    return merge(RemixTabStyler(container: value));
  }

  /// Sets the label.
  @override
  RemixTabStyler label(TextStyler value) {
    return merge(RemixTabStyler(label: value));
  }

  /// Sets the icon.
  @override
  RemixTabStyler icon(IconStyler value) {
    return merge(RemixTabStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  RemixTabStyler animate(AnimationConfig value) {
    return merge(RemixTabStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixTabStyler variants(List<VariantStyle<RemixTabSpec>> value) {
    return merge(RemixTabStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixTabStyler wrap(WidgetModifierConfig value) {
    return merge(RemixTabStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixTabStyler modifier(WidgetModifierConfig value) {
    return merge(RemixTabStyler(modifier: value));
  }

  /// Merges with another [RemixTabStyler].
  @override
  RemixTabStyler merge(RemixTabStyler? other) {
    return RemixTabStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixTabSpec>] using [context].
  @override
  StyleSpec<RemixTabSpec> resolve(BuildContext context) {
    final spec = RemixTabSpec(
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

class RemixTabViewStyler extends MixStyler<RemixTabViewStyler, RemixTabViewSpec>
    with RemixBoxStylerMixin<RemixTabViewStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;

  const RemixTabViewStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container;

  RemixTabViewStyler({
    BoxStyler? container,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixTabViewSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixTabViewStyler.container(BoxStyler value) =>
      RemixTabViewStyler().container(value);
  factory RemixTabViewStyler.alignment(AlignmentGeometry value) =>
      RemixTabViewStyler().alignment(value);
  factory RemixTabViewStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixTabViewStyler().padding(value);
  factory RemixTabViewStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixTabViewStyler().margin(value);
  factory RemixTabViewStyler.constraints(BoxConstraintsMix value) =>
      RemixTabViewStyler().constraints(value);
  factory RemixTabViewStyler.decoration(DecorationMix value) =>
      RemixTabViewStyler().decoration(value);
  factory RemixTabViewStyler.foregroundDecoration(DecorationMix value) =>
      RemixTabViewStyler().foregroundDecoration(value);
  factory RemixTabViewStyler.clipBehavior(Clip value) =>
      RemixTabViewStyler().clipBehavior(value);
  factory RemixTabViewStyler.color(Color value) =>
      RemixTabViewStyler().color(value);
  factory RemixTabViewStyler.gradient(GradientMix value) =>
      RemixTabViewStyler().gradient(value);
  factory RemixTabViewStyler.border(BoxBorderMix value) =>
      RemixTabViewStyler().border(value);
  factory RemixTabViewStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixTabViewStyler().borderRadius(value);
  factory RemixTabViewStyler.elevation(ElevationShadow value) =>
      RemixTabViewStyler().elevation(value);
  factory RemixTabViewStyler.shadow(BoxShadowMix value) =>
      RemixTabViewStyler().shadow(value);
  factory RemixTabViewStyler.shadows(List<BoxShadowMix> value) =>
      RemixTabViewStyler().shadows(value);
  factory RemixTabViewStyler.width(double value) =>
      RemixTabViewStyler().width(value);
  factory RemixTabViewStyler.height(double value) =>
      RemixTabViewStyler().height(value);
  factory RemixTabViewStyler.size(double width, double height) =>
      RemixTabViewStyler().size(width, height);
  factory RemixTabViewStyler.minWidth(double value) =>
      RemixTabViewStyler().minWidth(value);
  factory RemixTabViewStyler.maxWidth(double value) =>
      RemixTabViewStyler().maxWidth(value);
  factory RemixTabViewStyler.minHeight(double value) =>
      RemixTabViewStyler().minHeight(value);
  factory RemixTabViewStyler.maxHeight(double value) =>
      RemixTabViewStyler().maxHeight(value);
  factory RemixTabViewStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixTabViewStyler().scale(scale, alignment: alignment);
  factory RemixTabViewStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixTabViewStyler().rotate(radians, alignment: alignment);
  factory RemixTabViewStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixTabViewStyler().translate(x, y, z);
  factory RemixTabViewStyler.skew(double skewX, double skewY) =>
      RemixTabViewStyler().skew(skewX, skewY);
  factory RemixTabViewStyler.textStyle(TextStyler value) =>
      RemixTabViewStyler().textStyle(value);
  factory RemixTabViewStyler.image(DecorationImageMix value) =>
      RemixTabViewStyler().image(value);
  factory RemixTabViewStyler.shape(ShapeBorderMix value) =>
      RemixTabViewStyler().shape(value);
  factory RemixTabViewStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTabViewStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTabViewStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTabViewStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTabViewStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixTabViewStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixTabViewStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixTabViewStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixTabViewStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixTabViewStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixTabViewStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixTabViewStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixTabViewStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixTabViewStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixTabViewStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixTabViewStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixTabViewStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixTabViewStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixTabViewStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixTabViewStyler().transform(value, alignment: alignment);

  RemixTabViewStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixTabViewStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixTabViewStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixTabViewStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixTabViewStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixTabViewStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixTabViewStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixTabViewStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixTabViewStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixTabViewStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixTabViewStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixTabViewStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixTabViewStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixTabViewStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixTabViewStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixTabViewStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixTabViewStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixTabViewStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixTabViewStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixTabViewStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixTabViewStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixTabViewStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixTabViewStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixTabViewStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixTabViewStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixTabViewStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixTabViewStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixTabViewStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixTabViewStyler backgroundImage(
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

  RemixTabViewStyler backgroundImageUrl(
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

  RemixTabViewStyler backgroundImageAsset(
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

  RemixTabViewStyler linearGradient({
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

  RemixTabViewStyler radialGradient({
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

  RemixTabViewStyler sweepGradient({
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

  RemixTabViewStyler foregroundLinearGradient({
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

  RemixTabViewStyler foregroundRadialGradient({
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

  RemixTabViewStyler foregroundSweepGradient({
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

  RemixTabViewStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixTabViewStyler container(BoxStyler value) {
    return merge(RemixTabViewStyler(container: value));
  }

  /// Sets the animation configuration.
  @override
  RemixTabViewStyler animate(AnimationConfig value) {
    return merge(RemixTabViewStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixTabViewStyler variants(List<VariantStyle<RemixTabViewSpec>> value) {
    return merge(RemixTabViewStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixTabViewStyler wrap(WidgetModifierConfig value) {
    return merge(RemixTabViewStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixTabViewStyler modifier(WidgetModifierConfig value) {
    return merge(RemixTabViewStyler(modifier: value));
  }

  /// Merges with another [RemixTabViewStyler].
  @override
  RemixTabViewStyler merge(RemixTabViewStyler? other) {
    return RemixTabViewStyler.create(
      container: MixOps.merge($container, other?.$container),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixTabViewSpec>] using [context].
  @override
  StyleSpec<RemixTabViewSpec> resolve(BuildContext context) {
    final spec = RemixTabViewSpec(
      container: MixOps.resolve(context, $container),
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
    properties.add(DiagnosticsProperty('container', $container));
  }

  @override
  List<Object?> get props => [$container, $animation, $modifier, $variants];
}
