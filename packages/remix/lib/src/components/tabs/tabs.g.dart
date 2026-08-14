// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabs.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$TabBarSpec implements Spec<TabBarSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;

  @override
  Type get type => TabBarSpec;

  @override
  TabBarSpec copyWith({StyleSpec<FlexBoxSpec>? container}) {
    return TabBarSpec(container: container ?? this.container);
  }

  @override
  TabBarSpec lerp(TabBarSpec? other, double t) {
    return TabBarSpec(container: container.lerp(other?.container, t));
  }

  @override
  List<Object?> get props => [container];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TabBarSpec &&
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
  'Rename to `_\$TabBarSpec` and migrate the class declaration to `class TabBarSpec with _\$TabBarSpec`. The `_\$TabBarSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$TabBarSpecMethods = _$TabBarSpec; // ignore: unused_element

mixin _$TabSpec implements Spec<TabSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => TabSpec;

  @override
  TabSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) {
    return TabSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  @override
  TabSpec lerp(TabSpec? other, double t) {
    return TabSpec(
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
        other is TabSpec &&
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
  'Rename to `_\$TabSpec` and migrate the class declaration to `class TabSpec with _\$TabSpec`. The `_\$TabSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$TabSpecMethods = _$TabSpec; // ignore: unused_element

mixin _$TabViewSpec implements Spec<TabViewSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;

  @override
  Type get type => TabViewSpec;

  @override
  TabViewSpec copyWith({StyleSpec<BoxSpec>? container}) {
    return TabViewSpec(container: container ?? this.container);
  }

  @override
  TabViewSpec lerp(TabViewSpec? other, double t) {
    return TabViewSpec(container: container.lerp(other?.container, t));
  }

  @override
  List<Object?> get props => [container];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TabViewSpec &&
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
  'Rename to `_\$TabViewSpec` and migrate the class declaration to `class TabViewSpec with _\$TabViewSpec`. The `_\$TabViewSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$TabViewSpecMethods = _$TabViewSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class TabBarStyler extends MixStyler<TabBarStyler, TabBarSpec>
    with RemixBoxStylerMixin<TabBarStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;

  const TabBarStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container;

  TabBarStyler({
    FlexBoxStyler? container,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<TabBarSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory TabBarStyler.container(FlexBoxStyler value) =>
      TabBarStyler().container(value);
  factory TabBarStyler.color(Color value) => TabBarStyler().color(value);
  factory TabBarStyler.gradient(GradientMix value) =>
      TabBarStyler().gradient(value);
  factory TabBarStyler.border(BoxBorderMix value) =>
      TabBarStyler().border(value);
  factory TabBarStyler.borderRadius(BorderRadiusGeometryMix value) =>
      TabBarStyler().borderRadius(value);
  factory TabBarStyler.elevation(ElevationShadow value) =>
      TabBarStyler().elevation(value);
  factory TabBarStyler.shadow(BoxShadowMix value) =>
      TabBarStyler().shadow(value);
  factory TabBarStyler.shadows(List<BoxShadowMix> value) =>
      TabBarStyler().shadows(value);
  factory TabBarStyler.width(double value) => TabBarStyler().width(value);
  factory TabBarStyler.height(double value) => TabBarStyler().height(value);
  factory TabBarStyler.size(double width, double height) =>
      TabBarStyler().size(width, height);
  factory TabBarStyler.minWidth(double value) => TabBarStyler().minWidth(value);
  factory TabBarStyler.maxWidth(double value) => TabBarStyler().maxWidth(value);
  factory TabBarStyler.minHeight(double value) =>
      TabBarStyler().minHeight(value);
  factory TabBarStyler.maxHeight(double value) =>
      TabBarStyler().maxHeight(value);
  factory TabBarStyler.scale(double scale, {Alignment alignment = .center}) =>
      TabBarStyler().scale(scale, alignment: alignment);
  factory TabBarStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => TabBarStyler().rotate(radians, alignment: alignment);
  factory TabBarStyler.translate(double x, double y, [double z = 0.0]) =>
      TabBarStyler().translate(x, y, z);
  factory TabBarStyler.skew(double skewX, double skewY) =>
      TabBarStyler().skew(skewX, skewY);
  factory TabBarStyler.textStyle(TextStyler value) =>
      TabBarStyler().textStyle(value);
  factory TabBarStyler.image(DecorationImageMix value) =>
      TabBarStyler().image(value);
  factory TabBarStyler.shape(ShapeBorderMix value) =>
      TabBarStyler().shape(value);
  factory TabBarStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TabBarStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TabBarStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TabBarStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TabBarStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TabBarStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TabBarStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => TabBarStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory TabBarStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => TabBarStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory TabBarStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => TabBarStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory TabBarStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => TabBarStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory TabBarStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => TabBarStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory TabBarStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => TabBarStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory TabBarStyler.row() => TabBarStyler().row();
  factory TabBarStyler.column() => TabBarStyler().column();
  factory TabBarStyler.alignment(AlignmentGeometry value) =>
      TabBarStyler().alignment(value);
  factory TabBarStyler.padding(EdgeInsetsGeometryMix value) =>
      TabBarStyler().padding(value);
  factory TabBarStyler.margin(EdgeInsetsGeometryMix value) =>
      TabBarStyler().margin(value);
  factory TabBarStyler.constraints(BoxConstraintsMix value) =>
      TabBarStyler().constraints(value);
  factory TabBarStyler.decoration(DecorationMix value) =>
      TabBarStyler().decoration(value);
  factory TabBarStyler.foregroundDecoration(DecorationMix value) =>
      TabBarStyler().foregroundDecoration(value);
  factory TabBarStyler.clipBehavior(Clip value) =>
      TabBarStyler().clipBehavior(value);
  factory TabBarStyler.direction(Axis value) => TabBarStyler().direction(value);
  factory TabBarStyler.mainAxisAlignment(MainAxisAlignment value) =>
      TabBarStyler().mainAxisAlignment(value);
  factory TabBarStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      TabBarStyler().crossAxisAlignment(value);
  factory TabBarStyler.mainAxisSize(MainAxisSize value) =>
      TabBarStyler().mainAxisSize(value);
  factory TabBarStyler.spacing(double value) => TabBarStyler().spacing(value);
  factory TabBarStyler.verticalDirection(VerticalDirection value) =>
      TabBarStyler().verticalDirection(value);
  factory TabBarStyler.textDirection(TextDirection value) =>
      TabBarStyler().textDirection(value);
  factory TabBarStyler.textBaseline(TextBaseline value) =>
      TabBarStyler().textBaseline(value);
  factory TabBarStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => TabBarStyler().transform(value, alignment: alignment);

  TabBarStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  TabBarStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  TabBarStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  TabBarStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  TabBarStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  TabBarStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  TabBarStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  TabBarStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  TabBarStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  TabBarStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  TabBarStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  TabBarStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  TabBarStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  TabBarStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  TabBarStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  TabBarStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  TabBarStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  TabBarStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  TabBarStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  TabBarStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  TabBarStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  TabBarStyler backgroundImage(
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

  TabBarStyler backgroundImageUrl(
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

  TabBarStyler backgroundImageAsset(
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

  TabBarStyler linearGradient({
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

  TabBarStyler radialGradient({
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

  TabBarStyler sweepGradient({
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

  TabBarStyler foregroundLinearGradient({
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

  TabBarStyler foregroundRadialGradient({
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

  TabBarStyler foregroundSweepGradient({
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

  TabBarStyler row() {
    return container(FlexBoxStyler().row());
  }

  TabBarStyler column() {
    return container(FlexBoxStyler().column());
  }

  TabBarStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  TabBarStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  TabBarStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  TabBarStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  TabBarStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  TabBarStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  TabBarStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  TabBarStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  TabBarStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  TabBarStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  TabBarStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  TabBarStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  TabBarStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  TabBarStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  TabBarStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  TabBarStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  TabBarStyler container(FlexBoxStyler value) {
    return merge(TabBarStyler(container: value));
  }

  /// Sets the animation configuration.
  @override
  TabBarStyler animate(AnimationConfig value) {
    return merge(TabBarStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  TabBarStyler variants(List<VariantStyle<TabBarSpec>> value) {
    return merge(TabBarStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  TabBarStyler wrap(WidgetModifierConfig value) {
    return merge(TabBarStyler(modifier: value));
  }

  /// Sets the widget modifier.
  TabBarStyler modifier(WidgetModifierConfig value) {
    return merge(TabBarStyler(modifier: value));
  }

  RemixTabBar call({Key? key, required Widget child}) {
    return RemixTabBar(key: key, style: this, child: child);
  }

  /// Merges with another [TabBarStyler].
  @override
  TabBarStyler merge(TabBarStyler? other) {
    return TabBarStyler.create(
      container: MixOps.merge($container, other?.$container),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<TabBarSpec>] using [context].
  @override
  StyleSpec<TabBarSpec> resolve(BuildContext context) {
    final spec = TabBarSpec(container: MixOps.resolve(context, $container));

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

class TabStyler extends MixStyler<TabStyler, TabSpec>
    with
        RemixBoxStylerMixin<TabStyler>,
        LabelStyleMixin<TabStyler>,
        IconStyleMixin<TabStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const TabStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon;

  TabStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<TabSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory TabStyler.container(FlexBoxStyler value) =>
      TabStyler().container(value);
  factory TabStyler.label(TextStyler value) => TabStyler().label(value);
  factory TabStyler.icon(IconStyler value) => TabStyler().icon(value);
  factory TabStyler.color(Color value) => TabStyler().color(value);
  factory TabStyler.gradient(GradientMix value) => TabStyler().gradient(value);
  factory TabStyler.border(BoxBorderMix value) => TabStyler().border(value);
  factory TabStyler.borderRadius(BorderRadiusGeometryMix value) =>
      TabStyler().borderRadius(value);
  factory TabStyler.elevation(ElevationShadow value) =>
      TabStyler().elevation(value);
  factory TabStyler.shadow(BoxShadowMix value) => TabStyler().shadow(value);
  factory TabStyler.shadows(List<BoxShadowMix> value) =>
      TabStyler().shadows(value);
  factory TabStyler.width(double value) => TabStyler().width(value);
  factory TabStyler.height(double value) => TabStyler().height(value);
  factory TabStyler.size(double width, double height) =>
      TabStyler().size(width, height);
  factory TabStyler.minWidth(double value) => TabStyler().minWidth(value);
  factory TabStyler.maxWidth(double value) => TabStyler().maxWidth(value);
  factory TabStyler.minHeight(double value) => TabStyler().minHeight(value);
  factory TabStyler.maxHeight(double value) => TabStyler().maxHeight(value);
  factory TabStyler.scale(double scale, {Alignment alignment = .center}) =>
      TabStyler().scale(scale, alignment: alignment);
  factory TabStyler.rotate(double radians, {Alignment alignment = .center}) =>
      TabStyler().rotate(radians, alignment: alignment);
  factory TabStyler.translate(double x, double y, [double z = 0.0]) =>
      TabStyler().translate(x, y, z);
  factory TabStyler.skew(double skewX, double skewY) =>
      TabStyler().skew(skewX, skewY);
  factory TabStyler.textStyle(TextStyler value) => TabStyler().textStyle(value);
  factory TabStyler.image(DecorationImageMix value) => TabStyler().image(value);
  factory TabStyler.shape(ShapeBorderMix value) => TabStyler().shape(value);
  factory TabStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TabStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TabStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TabStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TabStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TabStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TabStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => TabStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory TabStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => TabStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory TabStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => TabStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory TabStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => TabStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory TabStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => TabStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory TabStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => TabStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory TabStyler.row() => TabStyler().row();
  factory TabStyler.column() => TabStyler().column();
  factory TabStyler.alignment(AlignmentGeometry value) =>
      TabStyler().alignment(value);
  factory TabStyler.padding(EdgeInsetsGeometryMix value) =>
      TabStyler().padding(value);
  factory TabStyler.margin(EdgeInsetsGeometryMix value) =>
      TabStyler().margin(value);
  factory TabStyler.constraints(BoxConstraintsMix value) =>
      TabStyler().constraints(value);
  factory TabStyler.decoration(DecorationMix value) =>
      TabStyler().decoration(value);
  factory TabStyler.foregroundDecoration(DecorationMix value) =>
      TabStyler().foregroundDecoration(value);
  factory TabStyler.clipBehavior(Clip value) => TabStyler().clipBehavior(value);
  factory TabStyler.direction(Axis value) => TabStyler().direction(value);
  factory TabStyler.mainAxisAlignment(MainAxisAlignment value) =>
      TabStyler().mainAxisAlignment(value);
  factory TabStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      TabStyler().crossAxisAlignment(value);
  factory TabStyler.mainAxisSize(MainAxisSize value) =>
      TabStyler().mainAxisSize(value);
  factory TabStyler.spacing(double value) => TabStyler().spacing(value);
  factory TabStyler.verticalDirection(VerticalDirection value) =>
      TabStyler().verticalDirection(value);
  factory TabStyler.textDirection(TextDirection value) =>
      TabStyler().textDirection(value);
  factory TabStyler.textBaseline(TextBaseline value) =>
      TabStyler().textBaseline(value);
  factory TabStyler.transform(Matrix4 value, {Alignment alignment = .center}) =>
      TabStyler().transform(value, alignment: alignment);

  TabStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  TabStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  TabStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  TabStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  TabStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  TabStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  TabStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  TabStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  TabStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  TabStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  TabStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  TabStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  TabStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  TabStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  TabStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  TabStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  TabStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  TabStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  TabStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  TabStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  TabStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  TabStyler backgroundImage(
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

  TabStyler backgroundImageUrl(
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

  TabStyler backgroundImageAsset(
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

  TabStyler linearGradient({
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

  TabStyler radialGradient({
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

  TabStyler sweepGradient({
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

  TabStyler foregroundLinearGradient({
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

  TabStyler foregroundRadialGradient({
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

  TabStyler foregroundSweepGradient({
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

  TabStyler row() {
    return container(FlexBoxStyler().row());
  }

  TabStyler column() {
    return container(FlexBoxStyler().column());
  }

  TabStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  TabStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  TabStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  TabStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  TabStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  TabStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  TabStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  TabStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  TabStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  TabStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  TabStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  TabStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  TabStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  TabStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  TabStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  TabStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  TabStyler container(FlexBoxStyler value) {
    return merge(TabStyler(container: value));
  }

  /// Sets the label.
  @override
  TabStyler label(TextStyler value) {
    return merge(TabStyler(label: value));
  }

  /// Sets the icon.
  @override
  TabStyler icon(IconStyler value) {
    return merge(TabStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  TabStyler animate(AnimationConfig value) {
    return merge(TabStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  TabStyler variants(List<VariantStyle<TabSpec>> value) {
    return merge(TabStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  TabStyler wrap(WidgetModifierConfig value) {
    return merge(TabStyler(modifier: value));
  }

  /// Sets the widget modifier.
  TabStyler modifier(WidgetModifierConfig value) {
    return merge(TabStyler(modifier: value));
  }

  RemixTab call({
    Key? key,
    required String tabId,
    Widget? child,
    String? label,
    IconData? icon,
    bool enabled = true,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    bool enableFeedback = true,
    FocusNode? focusNode,
    bool autofocus = false,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    ValueChanged<bool>? onPressChange,
    ValueWidgetBuilder<NakedTabState>? builder,
    String? semanticLabel,
  }) {
    return RemixTab(
      key: key,
      style: this,
      tabId: tabId,
      child: child,
      label: label,
      icon: icon,
      enabled: enabled,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onPressChange: onPressChange,
      builder: builder,
      semanticLabel: semanticLabel,
    );
  }

  /// Merges with another [TabStyler].
  @override
  TabStyler merge(TabStyler? other) {
    return TabStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<TabSpec>] using [context].
  @override
  StyleSpec<TabSpec> resolve(BuildContext context) {
    final spec = TabSpec(
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

class TabViewStyler extends MixStyler<TabViewStyler, TabViewSpec>
    with RemixBoxStylerMixin<TabViewStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;

  const TabViewStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container;

  TabViewStyler({
    BoxStyler? container,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<TabViewSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory TabViewStyler.container(BoxStyler value) =>
      TabViewStyler().container(value);
  factory TabViewStyler.alignment(AlignmentGeometry value) =>
      TabViewStyler().alignment(value);
  factory TabViewStyler.padding(EdgeInsetsGeometryMix value) =>
      TabViewStyler().padding(value);
  factory TabViewStyler.margin(EdgeInsetsGeometryMix value) =>
      TabViewStyler().margin(value);
  factory TabViewStyler.constraints(BoxConstraintsMix value) =>
      TabViewStyler().constraints(value);
  factory TabViewStyler.decoration(DecorationMix value) =>
      TabViewStyler().decoration(value);
  factory TabViewStyler.foregroundDecoration(DecorationMix value) =>
      TabViewStyler().foregroundDecoration(value);
  factory TabViewStyler.clipBehavior(Clip value) =>
      TabViewStyler().clipBehavior(value);
  factory TabViewStyler.color(Color value) => TabViewStyler().color(value);
  factory TabViewStyler.gradient(GradientMix value) =>
      TabViewStyler().gradient(value);
  factory TabViewStyler.border(BoxBorderMix value) =>
      TabViewStyler().border(value);
  factory TabViewStyler.borderRadius(BorderRadiusGeometryMix value) =>
      TabViewStyler().borderRadius(value);
  factory TabViewStyler.elevation(ElevationShadow value) =>
      TabViewStyler().elevation(value);
  factory TabViewStyler.shadow(BoxShadowMix value) =>
      TabViewStyler().shadow(value);
  factory TabViewStyler.shadows(List<BoxShadowMix> value) =>
      TabViewStyler().shadows(value);
  factory TabViewStyler.width(double value) => TabViewStyler().width(value);
  factory TabViewStyler.height(double value) => TabViewStyler().height(value);
  factory TabViewStyler.size(double width, double height) =>
      TabViewStyler().size(width, height);
  factory TabViewStyler.minWidth(double value) =>
      TabViewStyler().minWidth(value);
  factory TabViewStyler.maxWidth(double value) =>
      TabViewStyler().maxWidth(value);
  factory TabViewStyler.minHeight(double value) =>
      TabViewStyler().minHeight(value);
  factory TabViewStyler.maxHeight(double value) =>
      TabViewStyler().maxHeight(value);
  factory TabViewStyler.scale(double scale, {Alignment alignment = .center}) =>
      TabViewStyler().scale(scale, alignment: alignment);
  factory TabViewStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => TabViewStyler().rotate(radians, alignment: alignment);
  factory TabViewStyler.translate(double x, double y, [double z = 0.0]) =>
      TabViewStyler().translate(x, y, z);
  factory TabViewStyler.skew(double skewX, double skewY) =>
      TabViewStyler().skew(skewX, skewY);
  factory TabViewStyler.textStyle(TextStyler value) =>
      TabViewStyler().textStyle(value);
  factory TabViewStyler.image(DecorationImageMix value) =>
      TabViewStyler().image(value);
  factory TabViewStyler.shape(ShapeBorderMix value) =>
      TabViewStyler().shape(value);
  factory TabViewStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TabViewStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TabViewStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TabViewStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TabViewStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => TabViewStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory TabViewStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => TabViewStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory TabViewStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => TabViewStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory TabViewStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => TabViewStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory TabViewStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => TabViewStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory TabViewStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => TabViewStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory TabViewStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => TabViewStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory TabViewStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => TabViewStyler().transform(value, alignment: alignment);

  TabViewStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  TabViewStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  TabViewStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  TabViewStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  TabViewStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  TabViewStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  TabViewStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  TabViewStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  TabViewStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  TabViewStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  TabViewStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  TabViewStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  TabViewStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  TabViewStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  TabViewStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  TabViewStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  TabViewStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  TabViewStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  TabViewStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  TabViewStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  TabViewStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  TabViewStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  TabViewStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  TabViewStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  TabViewStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  TabViewStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  TabViewStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  TabViewStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  TabViewStyler backgroundImage(
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

  TabViewStyler backgroundImageUrl(
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

  TabViewStyler backgroundImageAsset(
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

  TabViewStyler linearGradient({
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

  TabViewStyler radialGradient({
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

  TabViewStyler sweepGradient({
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

  TabViewStyler foregroundLinearGradient({
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

  TabViewStyler foregroundRadialGradient({
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

  TabViewStyler foregroundSweepGradient({
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

  TabViewStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  TabViewStyler container(BoxStyler value) {
    return merge(TabViewStyler(container: value));
  }

  /// Sets the animation configuration.
  @override
  TabViewStyler animate(AnimationConfig value) {
    return merge(TabViewStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  TabViewStyler variants(List<VariantStyle<TabViewSpec>> value) {
    return merge(TabViewStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  TabViewStyler wrap(WidgetModifierConfig value) {
    return merge(TabViewStyler(modifier: value));
  }

  /// Sets the widget modifier.
  TabViewStyler modifier(WidgetModifierConfig value) {
    return merge(TabViewStyler(modifier: value));
  }

  RemixTabView call({
    Key? key,
    required String tabId,
    required Widget child,
    bool maintainState = true,
  }) {
    return RemixTabView(
      key: key,
      style: this,
      tabId: tabId,
      child: child,
      maintainState: maintainState,
    );
  }

  /// Merges with another [TabViewStyler].
  @override
  TabViewStyler merge(TabViewStyler? other) {
    return TabViewStyler.create(
      container: MixOps.merge($container, other?.$container),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<TabViewSpec>] using [context].
  @override
  StyleSpec<TabViewSpec> resolve(BuildContext context) {
    final spec = TabViewSpec(container: MixOps.resolve(context, $container));

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
