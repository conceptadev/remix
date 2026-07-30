// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle_group.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixToggleGroupSpec
    implements Spec<RemixToggleGroupSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<RemixToggleGroupItemSpec> get item;

  @override
  Type get type => RemixToggleGroupSpec;

  @override
  RemixToggleGroupSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<RemixToggleGroupItemSpec>? item,
  }) {
    return RemixToggleGroupSpec(
      container: container ?? this.container,
      item: item ?? this.item,
    );
  }

  @override
  RemixToggleGroupSpec lerp(RemixToggleGroupSpec? other, double t) {
    return RemixToggleGroupSpec(
      container: container.lerp(other?.container, t),
      item: item.lerp(other?.item, t),
    );
  }

  @override
  List<Object?> get props => [container, item];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixToggleGroupSpec &&
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
      ..add(DiagnosticsProperty('item', item));
  }
}

@Deprecated(
  'Rename to `_\$RemixToggleGroupSpec` and migrate the class declaration to `class RemixToggleGroupSpec with _\$RemixToggleGroupSpec`. The `_\$RemixToggleGroupSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixToggleGroupSpecMethods = _$RemixToggleGroupSpec; // ignore: unused_element

mixin _$RemixToggleGroupItemSpec
    implements Spec<RemixToggleGroupItemSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => RemixToggleGroupItemSpec;

  @override
  RemixToggleGroupItemSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) {
    return RemixToggleGroupItemSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  @override
  RemixToggleGroupItemSpec lerp(RemixToggleGroupItemSpec? other, double t) {
    return RemixToggleGroupItemSpec(
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
        other is RemixToggleGroupItemSpec &&
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
  'Rename to `_\$RemixToggleGroupItemSpec` and migrate the class declaration to `class RemixToggleGroupItemSpec with _\$RemixToggleGroupItemSpec`. The `_\$RemixToggleGroupItemSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixToggleGroupItemSpecMethods = _$RemixToggleGroupItemSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed segmented-control preset for [RemixToggleGroup].
class FortalToggleGroup<T> extends StatelessWidget {
  const FortalToggleGroup({
    super.key,
    this.variant = .soft,
    this.size = .size2,
    this.highContrast = false,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  const FortalToggleGroup.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = FortalToggleGroupVariant.soft;

  const FortalToggleGroup.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : variant = FortalToggleGroupVariant.surface;

  final FortalToggleGroupVariant variant;

  final FortalToggleGroupSize size;

  final bool highContrast;

  final List<RemixToggleGroupItem<T>> items;

  final T? selectedValue;

  final ValueChanged<T?>? onChanged;

  final bool enabled;

  final Axis orientation;

  final bool loop;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixToggleGroup<T>(
      key: this.key,
      style: fortalToggleGroupStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ),
      items: this.items,
      selectedValue: this.selectedValue,
      onChanged: this.onChanged,
      enabled: this.enabled,
      orientation: this.orientation,
      loop: this.loop,
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixToggleGroupStyler
    extends MixStyler<RemixToggleGroupStyler, RemixToggleGroupSpec>
    with RemixBoxStylerMixin<RemixToggleGroupStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<RemixToggleGroupItemSpec>>? $item;

  const RemixToggleGroupStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<RemixToggleGroupItemSpec>>? item,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $item = item;

  RemixToggleGroupStyler({
    FlexBoxStyler? container,
    RemixToggleGroupItemStyler? item,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixToggleGroupSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         item: Prop.maybeMix(item),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixToggleGroupStyler.container(FlexBoxStyler value) =>
      RemixToggleGroupStyler().container(value);
  factory RemixToggleGroupStyler.item(RemixToggleGroupItemStyler value) =>
      RemixToggleGroupStyler().item(value);
  factory RemixToggleGroupStyler.color(Color value) =>
      RemixToggleGroupStyler().color(value);
  factory RemixToggleGroupStyler.gradient(GradientMix value) =>
      RemixToggleGroupStyler().gradient(value);
  factory RemixToggleGroupStyler.border(BoxBorderMix value) =>
      RemixToggleGroupStyler().border(value);
  factory RemixToggleGroupStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixToggleGroupStyler().borderRadius(value);
  factory RemixToggleGroupStyler.elevation(ElevationShadow value) =>
      RemixToggleGroupStyler().elevation(value);
  factory RemixToggleGroupStyler.shadow(BoxShadowMix value) =>
      RemixToggleGroupStyler().shadow(value);
  factory RemixToggleGroupStyler.shadows(List<BoxShadowMix> value) =>
      RemixToggleGroupStyler().shadows(value);
  factory RemixToggleGroupStyler.width(double value) =>
      RemixToggleGroupStyler().width(value);
  factory RemixToggleGroupStyler.height(double value) =>
      RemixToggleGroupStyler().height(value);
  factory RemixToggleGroupStyler.size(double width, double height) =>
      RemixToggleGroupStyler().size(width, height);
  factory RemixToggleGroupStyler.minWidth(double value) =>
      RemixToggleGroupStyler().minWidth(value);
  factory RemixToggleGroupStyler.maxWidth(double value) =>
      RemixToggleGroupStyler().maxWidth(value);
  factory RemixToggleGroupStyler.minHeight(double value) =>
      RemixToggleGroupStyler().minHeight(value);
  factory RemixToggleGroupStyler.maxHeight(double value) =>
      RemixToggleGroupStyler().maxHeight(value);
  factory RemixToggleGroupStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixToggleGroupStyler().scale(scale, alignment: alignment);
  factory RemixToggleGroupStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixToggleGroupStyler().rotate(radians, alignment: alignment);
  factory RemixToggleGroupStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => RemixToggleGroupStyler().translate(x, y, z);
  factory RemixToggleGroupStyler.skew(double skewX, double skewY) =>
      RemixToggleGroupStyler().skew(skewX, skewY);
  factory RemixToggleGroupStyler.textStyle(TextStyler value) =>
      RemixToggleGroupStyler().textStyle(value);
  factory RemixToggleGroupStyler.image(DecorationImageMix value) =>
      RemixToggleGroupStyler().image(value);
  factory RemixToggleGroupStyler.shape(ShapeBorderMix value) =>
      RemixToggleGroupStyler().shape(value);
  factory RemixToggleGroupStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixToggleGroupStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixToggleGroupStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixToggleGroupStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixToggleGroupStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixToggleGroupStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixToggleGroupStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixToggleGroupStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixToggleGroupStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixToggleGroupStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixToggleGroupStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixToggleGroupStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixToggleGroupStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixToggleGroupStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixToggleGroupStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixToggleGroupStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixToggleGroupStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixToggleGroupStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixToggleGroupStyler.row() => RemixToggleGroupStyler().row();
  factory RemixToggleGroupStyler.column() => RemixToggleGroupStyler().column();
  factory RemixToggleGroupStyler.alignment(AlignmentGeometry value) =>
      RemixToggleGroupStyler().alignment(value);
  factory RemixToggleGroupStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixToggleGroupStyler().padding(value);
  factory RemixToggleGroupStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixToggleGroupStyler().margin(value);
  factory RemixToggleGroupStyler.constraints(BoxConstraintsMix value) =>
      RemixToggleGroupStyler().constraints(value);
  factory RemixToggleGroupStyler.decoration(DecorationMix value) =>
      RemixToggleGroupStyler().decoration(value);
  factory RemixToggleGroupStyler.foregroundDecoration(DecorationMix value) =>
      RemixToggleGroupStyler().foregroundDecoration(value);
  factory RemixToggleGroupStyler.clipBehavior(Clip value) =>
      RemixToggleGroupStyler().clipBehavior(value);
  factory RemixToggleGroupStyler.direction(Axis value) =>
      RemixToggleGroupStyler().direction(value);
  factory RemixToggleGroupStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixToggleGroupStyler().mainAxisAlignment(value);
  factory RemixToggleGroupStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixToggleGroupStyler().crossAxisAlignment(value);
  factory RemixToggleGroupStyler.mainAxisSize(MainAxisSize value) =>
      RemixToggleGroupStyler().mainAxisSize(value);
  factory RemixToggleGroupStyler.spacing(double value) =>
      RemixToggleGroupStyler().spacing(value);
  factory RemixToggleGroupStyler.verticalDirection(VerticalDirection value) =>
      RemixToggleGroupStyler().verticalDirection(value);
  factory RemixToggleGroupStyler.textDirection(TextDirection value) =>
      RemixToggleGroupStyler().textDirection(value);
  factory RemixToggleGroupStyler.textBaseline(TextBaseline value) =>
      RemixToggleGroupStyler().textBaseline(value);
  factory RemixToggleGroupStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixToggleGroupStyler().transform(value, alignment: alignment);

  RemixToggleGroupStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixToggleGroupStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixToggleGroupStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixToggleGroupStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixToggleGroupStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixToggleGroupStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixToggleGroupStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixToggleGroupStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixToggleGroupStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixToggleGroupStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixToggleGroupStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixToggleGroupStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixToggleGroupStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixToggleGroupStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixToggleGroupStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixToggleGroupStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixToggleGroupStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixToggleGroupStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixToggleGroupStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixToggleGroupStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixToggleGroupStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixToggleGroupStyler backgroundImage(
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

  RemixToggleGroupStyler backgroundImageUrl(
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

  RemixToggleGroupStyler backgroundImageAsset(
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

  RemixToggleGroupStyler linearGradient({
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

  RemixToggleGroupStyler radialGradient({
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

  RemixToggleGroupStyler sweepGradient({
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

  RemixToggleGroupStyler foregroundLinearGradient({
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

  RemixToggleGroupStyler foregroundRadialGradient({
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

  RemixToggleGroupStyler foregroundSweepGradient({
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

  RemixToggleGroupStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixToggleGroupStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixToggleGroupStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixToggleGroupStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixToggleGroupStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixToggleGroupStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixToggleGroupStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixToggleGroupStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixToggleGroupStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixToggleGroupStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixToggleGroupStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixToggleGroupStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixToggleGroupStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixToggleGroupStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixToggleGroupStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixToggleGroupStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixToggleGroupStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixToggleGroupStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixToggleGroupStyler container(FlexBoxStyler value) {
    return merge(RemixToggleGroupStyler(container: value));
  }

  /// Sets the item.
  RemixToggleGroupStyler item(RemixToggleGroupItemStyler value) {
    return merge(RemixToggleGroupStyler(item: value));
  }

  /// Sets the animation configuration.
  @override
  RemixToggleGroupStyler animate(AnimationConfig value) {
    return merge(RemixToggleGroupStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixToggleGroupStyler variants(
    List<VariantStyle<RemixToggleGroupSpec>> value,
  ) {
    return merge(RemixToggleGroupStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixToggleGroupStyler wrap(WidgetModifierConfig value) {
    return merge(RemixToggleGroupStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixToggleGroupStyler modifier(WidgetModifierConfig value) {
    return merge(RemixToggleGroupStyler(modifier: value));
  }

  /// Merges with another [RemixToggleGroupStyler].
  @override
  RemixToggleGroupStyler merge(RemixToggleGroupStyler? other) {
    return RemixToggleGroupStyler.create(
      container: MixOps.merge($container, other?.$container),
      item: MixOps.merge($item, other?.$item),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixToggleGroupSpec>] using [context].
  @override
  StyleSpec<RemixToggleGroupSpec> resolve(BuildContext context) {
    final spec = RemixToggleGroupSpec(
      container: MixOps.resolve(context, $container),
      item: MixOps.resolve(context, $item),
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
      ..add(DiagnosticsProperty('item', $item));
  }

  @override
  List<Object?> get props => [
    $container,
    $item,
    $animation,
    $modifier,
    $variants,
  ];
}

class RemixToggleGroupItemStyler
    extends MixStyler<RemixToggleGroupItemStyler, RemixToggleGroupItemSpec>
    with
        RemixBoxStylerMixin<RemixToggleGroupItemStyler>,
        LabelStyleMixin<RemixToggleGroupItemStyler>,
        IconStyleMixin<RemixToggleGroupItemStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const RemixToggleGroupItemStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon;

  RemixToggleGroupItemStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixToggleGroupItemSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixToggleGroupItemStyler.container(FlexBoxStyler value) =>
      RemixToggleGroupItemStyler().container(value);
  factory RemixToggleGroupItemStyler.label(TextStyler value) =>
      RemixToggleGroupItemStyler().label(value);
  factory RemixToggleGroupItemStyler.icon(IconStyler value) =>
      RemixToggleGroupItemStyler().icon(value);
  factory RemixToggleGroupItemStyler.color(Color value) =>
      RemixToggleGroupItemStyler().color(value);
  factory RemixToggleGroupItemStyler.gradient(GradientMix value) =>
      RemixToggleGroupItemStyler().gradient(value);
  factory RemixToggleGroupItemStyler.border(BoxBorderMix value) =>
      RemixToggleGroupItemStyler().border(value);
  factory RemixToggleGroupItemStyler.borderRadius(
    BorderRadiusGeometryMix value,
  ) => RemixToggleGroupItemStyler().borderRadius(value);
  factory RemixToggleGroupItemStyler.elevation(ElevationShadow value) =>
      RemixToggleGroupItemStyler().elevation(value);
  factory RemixToggleGroupItemStyler.shadow(BoxShadowMix value) =>
      RemixToggleGroupItemStyler().shadow(value);
  factory RemixToggleGroupItemStyler.shadows(List<BoxShadowMix> value) =>
      RemixToggleGroupItemStyler().shadows(value);
  factory RemixToggleGroupItemStyler.width(double value) =>
      RemixToggleGroupItemStyler().width(value);
  factory RemixToggleGroupItemStyler.height(double value) =>
      RemixToggleGroupItemStyler().height(value);
  factory RemixToggleGroupItemStyler.size(double width, double height) =>
      RemixToggleGroupItemStyler().size(width, height);
  factory RemixToggleGroupItemStyler.minWidth(double value) =>
      RemixToggleGroupItemStyler().minWidth(value);
  factory RemixToggleGroupItemStyler.maxWidth(double value) =>
      RemixToggleGroupItemStyler().maxWidth(value);
  factory RemixToggleGroupItemStyler.minHeight(double value) =>
      RemixToggleGroupItemStyler().minHeight(value);
  factory RemixToggleGroupItemStyler.maxHeight(double value) =>
      RemixToggleGroupItemStyler().maxHeight(value);
  factory RemixToggleGroupItemStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixToggleGroupItemStyler().scale(scale, alignment: alignment);
  factory RemixToggleGroupItemStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixToggleGroupItemStyler().rotate(radians, alignment: alignment);
  factory RemixToggleGroupItemStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => RemixToggleGroupItemStyler().translate(x, y, z);
  factory RemixToggleGroupItemStyler.skew(double skewX, double skewY) =>
      RemixToggleGroupItemStyler().skew(skewX, skewY);
  factory RemixToggleGroupItemStyler.textStyle(TextStyler value) =>
      RemixToggleGroupItemStyler().textStyle(value);
  factory RemixToggleGroupItemStyler.image(DecorationImageMix value) =>
      RemixToggleGroupItemStyler().image(value);
  factory RemixToggleGroupItemStyler.shape(ShapeBorderMix value) =>
      RemixToggleGroupItemStyler().shape(value);
  factory RemixToggleGroupItemStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixToggleGroupItemStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixToggleGroupItemStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixToggleGroupItemStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixToggleGroupItemStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixToggleGroupItemStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixToggleGroupItemStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixToggleGroupItemStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixToggleGroupItemStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixToggleGroupItemStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixToggleGroupItemStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixToggleGroupItemStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixToggleGroupItemStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixToggleGroupItemStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixToggleGroupItemStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixToggleGroupItemStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixToggleGroupItemStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixToggleGroupItemStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixToggleGroupItemStyler.row() =>
      RemixToggleGroupItemStyler().row();
  factory RemixToggleGroupItemStyler.column() =>
      RemixToggleGroupItemStyler().column();
  factory RemixToggleGroupItemStyler.alignment(AlignmentGeometry value) =>
      RemixToggleGroupItemStyler().alignment(value);
  factory RemixToggleGroupItemStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixToggleGroupItemStyler().padding(value);
  factory RemixToggleGroupItemStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixToggleGroupItemStyler().margin(value);
  factory RemixToggleGroupItemStyler.constraints(BoxConstraintsMix value) =>
      RemixToggleGroupItemStyler().constraints(value);
  factory RemixToggleGroupItemStyler.decoration(DecorationMix value) =>
      RemixToggleGroupItemStyler().decoration(value);
  factory RemixToggleGroupItemStyler.foregroundDecoration(
    DecorationMix value,
  ) => RemixToggleGroupItemStyler().foregroundDecoration(value);
  factory RemixToggleGroupItemStyler.clipBehavior(Clip value) =>
      RemixToggleGroupItemStyler().clipBehavior(value);
  factory RemixToggleGroupItemStyler.direction(Axis value) =>
      RemixToggleGroupItemStyler().direction(value);
  factory RemixToggleGroupItemStyler.mainAxisAlignment(
    MainAxisAlignment value,
  ) => RemixToggleGroupItemStyler().mainAxisAlignment(value);
  factory RemixToggleGroupItemStyler.crossAxisAlignment(
    CrossAxisAlignment value,
  ) => RemixToggleGroupItemStyler().crossAxisAlignment(value);
  factory RemixToggleGroupItemStyler.mainAxisSize(MainAxisSize value) =>
      RemixToggleGroupItemStyler().mainAxisSize(value);
  factory RemixToggleGroupItemStyler.spacing(double value) =>
      RemixToggleGroupItemStyler().spacing(value);
  factory RemixToggleGroupItemStyler.verticalDirection(
    VerticalDirection value,
  ) => RemixToggleGroupItemStyler().verticalDirection(value);
  factory RemixToggleGroupItemStyler.textDirection(TextDirection value) =>
      RemixToggleGroupItemStyler().textDirection(value);
  factory RemixToggleGroupItemStyler.textBaseline(TextBaseline value) =>
      RemixToggleGroupItemStyler().textBaseline(value);
  factory RemixToggleGroupItemStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixToggleGroupItemStyler().transform(value, alignment: alignment);

  RemixToggleGroupItemStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixToggleGroupItemStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixToggleGroupItemStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixToggleGroupItemStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixToggleGroupItemStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixToggleGroupItemStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixToggleGroupItemStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixToggleGroupItemStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixToggleGroupItemStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixToggleGroupItemStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixToggleGroupItemStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixToggleGroupItemStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixToggleGroupItemStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixToggleGroupItemStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixToggleGroupItemStyler scale(
    double scale, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixToggleGroupItemStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixToggleGroupItemStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixToggleGroupItemStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixToggleGroupItemStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixToggleGroupItemStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixToggleGroupItemStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixToggleGroupItemStyler backgroundImage(
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

  RemixToggleGroupItemStyler backgroundImageUrl(
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

  RemixToggleGroupItemStyler backgroundImageAsset(
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

  RemixToggleGroupItemStyler linearGradient({
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

  RemixToggleGroupItemStyler radialGradient({
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

  RemixToggleGroupItemStyler sweepGradient({
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

  RemixToggleGroupItemStyler foregroundLinearGradient({
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

  RemixToggleGroupItemStyler foregroundRadialGradient({
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

  RemixToggleGroupItemStyler foregroundSweepGradient({
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

  RemixToggleGroupItemStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixToggleGroupItemStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixToggleGroupItemStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixToggleGroupItemStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixToggleGroupItemStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixToggleGroupItemStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixToggleGroupItemStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixToggleGroupItemStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixToggleGroupItemStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixToggleGroupItemStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixToggleGroupItemStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixToggleGroupItemStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixToggleGroupItemStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixToggleGroupItemStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixToggleGroupItemStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixToggleGroupItemStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixToggleGroupItemStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixToggleGroupItemStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixToggleGroupItemStyler container(FlexBoxStyler value) {
    return merge(RemixToggleGroupItemStyler(container: value));
  }

  /// Sets the label.
  @override
  RemixToggleGroupItemStyler label(TextStyler value) {
    return merge(RemixToggleGroupItemStyler(label: value));
  }

  /// Sets the icon.
  @override
  RemixToggleGroupItemStyler icon(IconStyler value) {
    return merge(RemixToggleGroupItemStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  RemixToggleGroupItemStyler animate(AnimationConfig value) {
    return merge(RemixToggleGroupItemStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixToggleGroupItemStyler variants(
    List<VariantStyle<RemixToggleGroupItemSpec>> value,
  ) {
    return merge(RemixToggleGroupItemStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixToggleGroupItemStyler wrap(WidgetModifierConfig value) {
    return merge(RemixToggleGroupItemStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixToggleGroupItemStyler modifier(WidgetModifierConfig value) {
    return merge(RemixToggleGroupItemStyler(modifier: value));
  }

  /// Merges with another [RemixToggleGroupItemStyler].
  @override
  RemixToggleGroupItemStyler merge(RemixToggleGroupItemStyler? other) {
    return RemixToggleGroupItemStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixToggleGroupItemSpec>] using [context].
  @override
  StyleSpec<RemixToggleGroupItemSpec> resolve(BuildContext context) {
    final spec = RemixToggleGroupItemSpec(
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
