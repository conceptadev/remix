// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segmented_control.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$SegmentedControlSpec
    implements Spec<SegmentedControlSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  MainAxisSize? get mainAxisSize;
  double? get spacing;
  StyleSpec<SegmentedControlItemSpec> get item;

  @override
  Type get type => SegmentedControlSpec;

  @override
  SegmentedControlSpec copyWith({
    StyleSpec<BoxSpec>? container,
    MainAxisSize? mainAxisSize,
    double? spacing,
    StyleSpec<SegmentedControlItemSpec>? item,
  }) {
    return SegmentedControlSpec(
      container: container ?? this.container,
      mainAxisSize: mainAxisSize ?? this.mainAxisSize,
      spacing: spacing ?? this.spacing,
      item: item ?? this.item,
    );
  }

  @override
  SegmentedControlSpec lerp(SegmentedControlSpec? other, double t) {
    return SegmentedControlSpec(
      container: container.lerp(other?.container, t),
      mainAxisSize: MixOps.lerpSnap(mainAxisSize, other?.mainAxisSize, t),
      spacing: MixOps.lerp(spacing, other?.spacing, t),
      item: item.lerp(other?.item, t),
    );
  }

  @override
  List<Object?> get props => [container, mainAxisSize, spacing, item];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SegmentedControlSpec &&
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
      ..add(EnumProperty<MainAxisSize>('mainAxisSize', mainAxisSize))
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('item', item));
  }
}

@Deprecated(
  'Rename to `_\$SegmentedControlSpec` and migrate the class declaration to `class SegmentedControlSpec with _\$SegmentedControlSpec`. The `_\$SegmentedControlSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SegmentedControlSpecMethods = _$SegmentedControlSpec; // ignore: unused_element

mixin _$SegmentedControlItemSpec
    implements Spec<SegmentedControlItemSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  double? get spacing;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => SegmentedControlItemSpec;

  @override
  SegmentedControlItemSpec copyWith({
    StyleSpec<BoxSpec>? container,
    double? spacing,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return SegmentedControlItemSpec(
      container: container ?? this.container,
      spacing: spacing ?? this.spacing,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  SegmentedControlItemSpec lerp(SegmentedControlItemSpec? other, double t) {
    return SegmentedControlItemSpec(
      container: container.lerp(other?.container, t),
      spacing: MixOps.lerp(spacing, other?.spacing, t),
      label: label.lerp(other?.label, t),
      icon: icon.lerp(other?.icon, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [
    container,
    spacing,
    label,
    icon,
    containerEffects,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SegmentedControlItemSpec &&
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
      ..add(DoubleProperty('spacing', spacing))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$SegmentedControlItemSpec` and migrate the class declaration to `class SegmentedControlItemSpec with _\$SegmentedControlItemSpec`. The `_\$SegmentedControlItemSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SegmentedControlItemSpecMethods = _$SegmentedControlItemSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class SegmentedControlStyler
    extends MixStyler<SegmentedControlStyler, SegmentedControlSpec>
    with RemixBoxStylerMixin<SegmentedControlStyler>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<MainAxisSize>? $mainAxisSize;
  final Prop<double>? $spacing;
  final Prop<StyleSpec<SegmentedControlItemSpec>>? $item;

  const SegmentedControlStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<MainAxisSize>? mainAxisSize,
    Prop<double>? spacing,
    Prop<StyleSpec<SegmentedControlItemSpec>>? item,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $mainAxisSize = mainAxisSize,
       $spacing = spacing,
       $item = item;

  SegmentedControlStyler({
    BoxStyler? container,
    MainAxisSize? mainAxisSize,
    double? spacing,
    SegmentedControlItemStyler? item,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SegmentedControlSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         mainAxisSize: Prop.maybe(mainAxisSize),
         spacing: Prop.maybe(spacing),
         item: Prop.maybeMix(item),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SegmentedControlStyler.container(BoxStyler value) =>
      SegmentedControlStyler().container(value);
  factory SegmentedControlStyler.mainAxisSize(MainAxisSize value) =>
      SegmentedControlStyler().mainAxisSize(value);
  factory SegmentedControlStyler.spacing(double value) =>
      SegmentedControlStyler().spacing(value);
  factory SegmentedControlStyler.item(SegmentedControlItemStyler value) =>
      SegmentedControlStyler().item(value);
  factory SegmentedControlStyler.alignment(AlignmentGeometry value) =>
      SegmentedControlStyler().alignment(value);
  factory SegmentedControlStyler.padding(EdgeInsetsGeometryMix value) =>
      SegmentedControlStyler().padding(value);
  factory SegmentedControlStyler.margin(EdgeInsetsGeometryMix value) =>
      SegmentedControlStyler().margin(value);
  factory SegmentedControlStyler.constraints(BoxConstraintsMix value) =>
      SegmentedControlStyler().constraints(value);
  factory SegmentedControlStyler.decoration(DecorationMix value) =>
      SegmentedControlStyler().decoration(value);
  factory SegmentedControlStyler.foregroundDecoration(DecorationMix value) =>
      SegmentedControlStyler().foregroundDecoration(value);
  factory SegmentedControlStyler.clipBehavior(Clip value) =>
      SegmentedControlStyler().clipBehavior(value);
  factory SegmentedControlStyler.color(Color value) =>
      SegmentedControlStyler().color(value);
  factory SegmentedControlStyler.gradient(GradientMix value) =>
      SegmentedControlStyler().gradient(value);
  factory SegmentedControlStyler.border(BoxBorderMix value) =>
      SegmentedControlStyler().border(value);
  factory SegmentedControlStyler.borderRadius(BorderRadiusGeometryMix value) =>
      SegmentedControlStyler().borderRadius(value);
  factory SegmentedControlStyler.elevation(ElevationShadow value) =>
      SegmentedControlStyler().elevation(value);
  factory SegmentedControlStyler.shadow(BoxShadowMix value) =>
      SegmentedControlStyler().shadow(value);
  factory SegmentedControlStyler.shadows(List<BoxShadowMix> value) =>
      SegmentedControlStyler().shadows(value);
  factory SegmentedControlStyler.width(double value) =>
      SegmentedControlStyler().width(value);
  factory SegmentedControlStyler.height(double value) =>
      SegmentedControlStyler().height(value);
  factory SegmentedControlStyler.size(double width, double height) =>
      SegmentedControlStyler().size(width, height);
  factory SegmentedControlStyler.minWidth(double value) =>
      SegmentedControlStyler().minWidth(value);
  factory SegmentedControlStyler.maxWidth(double value) =>
      SegmentedControlStyler().maxWidth(value);
  factory SegmentedControlStyler.minHeight(double value) =>
      SegmentedControlStyler().minHeight(value);
  factory SegmentedControlStyler.maxHeight(double value) =>
      SegmentedControlStyler().maxHeight(value);
  factory SegmentedControlStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => SegmentedControlStyler().scale(scale, alignment: alignment);
  factory SegmentedControlStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => SegmentedControlStyler().rotate(radians, alignment: alignment);
  factory SegmentedControlStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => SegmentedControlStyler().translate(x, y, z);
  factory SegmentedControlStyler.skew(double skewX, double skewY) =>
      SegmentedControlStyler().skew(skewX, skewY);
  factory SegmentedControlStyler.textStyle(TextStyler value) =>
      SegmentedControlStyler().textStyle(value);
  factory SegmentedControlStyler.image(DecorationImageMix value) =>
      SegmentedControlStyler().image(value);
  factory SegmentedControlStyler.shape(ShapeBorderMix value) =>
      SegmentedControlStyler().shape(value);
  factory SegmentedControlStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SegmentedControlStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SegmentedControlStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SegmentedControlStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SegmentedControlStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SegmentedControlStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SegmentedControlStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SegmentedControlStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SegmentedControlStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SegmentedControlStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SegmentedControlStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SegmentedControlStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SegmentedControlStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SegmentedControlStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SegmentedControlStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SegmentedControlStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SegmentedControlStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SegmentedControlStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SegmentedControlStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => SegmentedControlStyler().transform(value, alignment: alignment);

  SegmentedControlStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  SegmentedControlStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  SegmentedControlStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  SegmentedControlStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  SegmentedControlStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  SegmentedControlStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  SegmentedControlStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  SegmentedControlStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  SegmentedControlStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  SegmentedControlStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  SegmentedControlStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  SegmentedControlStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  SegmentedControlStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  SegmentedControlStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  SegmentedControlStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  SegmentedControlStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  SegmentedControlStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  SegmentedControlStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  SegmentedControlStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  SegmentedControlStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  SegmentedControlStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  SegmentedControlStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  SegmentedControlStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  SegmentedControlStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  SegmentedControlStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  SegmentedControlStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  SegmentedControlStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  SegmentedControlStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  SegmentedControlStyler backgroundImage(
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

  SegmentedControlStyler backgroundImageUrl(
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

  SegmentedControlStyler backgroundImageAsset(
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

  SegmentedControlStyler linearGradient({
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

  SegmentedControlStyler radialGradient({
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

  SegmentedControlStyler sweepGradient({
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

  SegmentedControlStyler foregroundLinearGradient({
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

  SegmentedControlStyler foregroundRadialGradient({
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

  SegmentedControlStyler foregroundSweepGradient({
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

  SegmentedControlStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  @override
  Set<String> get $stylerFieldNames => const {
    'container',
    'mainAxisSize',
    'spacing',
    'item',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the container.
  SegmentedControlStyler container(BoxStyler value) {
    return merge(SegmentedControlStyler(container: value));
  }

  /// Sets the mainAxisSize.
  SegmentedControlStyler mainAxisSize(MainAxisSize value) {
    return merge(SegmentedControlStyler(mainAxisSize: value));
  }

  /// Sets the spacing.
  SegmentedControlStyler spacing(double value) {
    return merge(SegmentedControlStyler(spacing: value));
  }

  /// Sets the item.
  SegmentedControlStyler item(SegmentedControlItemStyler value) {
    return merge(SegmentedControlStyler(item: value));
  }

  /// Sets the animation configuration.
  @override
  SegmentedControlStyler animate(AnimationConfig value) {
    return merge(SegmentedControlStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SegmentedControlStyler variants(
    List<VariantStyle<SegmentedControlSpec>> value,
  ) {
    return merge(SegmentedControlStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SegmentedControlStyler wrap(WidgetModifierConfig value) {
    return merge(SegmentedControlStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SegmentedControlStyler modifier(WidgetModifierConfig value) {
    return merge(SegmentedControlStyler(modifier: value));
  }

  RemixSegmentedControl<T> call<T extends Object>({
    Key? key,
    required List<RemixSegmentedControlItem<T>> items,
    required T? selectedValue,
    ValueChanged<T>? onChanged,
    bool enabled = true,
    Axis orientation = .horizontal,
    bool loop = true,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixSegmentedControl<T>(
      key: key,
      style: this,
      items: items,
      selectedValue: selectedValue,
      onChanged: onChanged,
      enabled: enabled,
      orientation: orientation,
      loop: loop,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
    );
  }

  /// Merges with another [SegmentedControlStyler].
  @override
  SegmentedControlStyler merge(SegmentedControlStyler? other) {
    return SegmentedControlStyler.create(
      container: MixOps.merge($container, other?.$container),
      mainAxisSize: MixOps.merge($mainAxisSize, other?.$mainAxisSize),
      spacing: MixOps.merge($spacing, other?.$spacing),
      item: MixOps.merge($item, other?.$item),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SegmentedControlSpec>] using [context].
  @override
  StyleSpec<SegmentedControlSpec> resolve(BuildContext context) {
    final spec = SegmentedControlSpec(
      container: MixOps.resolve(context, $container),
      mainAxisSize: MixOps.resolve(context, $mainAxisSize),
      spacing: MixOps.resolve(context, $spacing),
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
      ..add(DiagnosticsProperty('mainAxisSize', $mainAxisSize))
      ..add(DiagnosticsProperty('spacing', $spacing))
      ..add(DiagnosticsProperty('item', $item));
  }

  @override
  List<Object?> get props => [
    $container,
    $mainAxisSize,
    $spacing,
    $item,
    $animation,
    $modifier,
    $variants,
  ];
}

class SegmentedControlItemStyler
    extends MixStyler<SegmentedControlItemStyler, SegmentedControlItemSpec>
    with
        RemixBoxStylerMixin<SegmentedControlItemStyler>,
        LabelStyleMixin<SegmentedControlItemStyler>,
        IconStyleMixin<SegmentedControlItemStyler>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<double>? $spacing;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const SegmentedControlItemStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<double>? spacing,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $spacing = spacing,
       $label = label,
       $icon = icon,
       $containerEffects = containerEffects;

  SegmentedControlItemStyler({
    BoxStyler? container,
    double? spacing,
    TextStyler? label,
    IconStyler? icon,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SegmentedControlItemSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         spacing: Prop.maybe(spacing),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SegmentedControlItemStyler.container(BoxStyler value) =>
      SegmentedControlItemStyler().container(value);
  factory SegmentedControlItemStyler.spacing(double value) =>
      SegmentedControlItemStyler().spacing(value);
  factory SegmentedControlItemStyler.label(TextStyler value) =>
      SegmentedControlItemStyler().label(value);
  factory SegmentedControlItemStyler.icon(IconStyler value) =>
      SegmentedControlItemStyler().icon(value);
  factory SegmentedControlItemStyler.containerEffects(
    RemixBoxEffectsMix value,
  ) => SegmentedControlItemStyler().containerEffects(value);
  factory SegmentedControlItemStyler.alignment(AlignmentGeometry value) =>
      SegmentedControlItemStyler().alignment(value);
  factory SegmentedControlItemStyler.padding(EdgeInsetsGeometryMix value) =>
      SegmentedControlItemStyler().padding(value);
  factory SegmentedControlItemStyler.margin(EdgeInsetsGeometryMix value) =>
      SegmentedControlItemStyler().margin(value);
  factory SegmentedControlItemStyler.constraints(BoxConstraintsMix value) =>
      SegmentedControlItemStyler().constraints(value);
  factory SegmentedControlItemStyler.decoration(DecorationMix value) =>
      SegmentedControlItemStyler().decoration(value);
  factory SegmentedControlItemStyler.foregroundDecoration(
    DecorationMix value,
  ) => SegmentedControlItemStyler().foregroundDecoration(value);
  factory SegmentedControlItemStyler.clipBehavior(Clip value) =>
      SegmentedControlItemStyler().clipBehavior(value);
  factory SegmentedControlItemStyler.color(Color value) =>
      SegmentedControlItemStyler().color(value);
  factory SegmentedControlItemStyler.gradient(GradientMix value) =>
      SegmentedControlItemStyler().gradient(value);
  factory SegmentedControlItemStyler.border(BoxBorderMix value) =>
      SegmentedControlItemStyler().border(value);
  factory SegmentedControlItemStyler.borderRadius(
    BorderRadiusGeometryMix value,
  ) => SegmentedControlItemStyler().borderRadius(value);
  factory SegmentedControlItemStyler.elevation(ElevationShadow value) =>
      SegmentedControlItemStyler().elevation(value);
  factory SegmentedControlItemStyler.shadow(BoxShadowMix value) =>
      SegmentedControlItemStyler().shadow(value);
  factory SegmentedControlItemStyler.shadows(List<BoxShadowMix> value) =>
      SegmentedControlItemStyler().shadows(value);
  factory SegmentedControlItemStyler.width(double value) =>
      SegmentedControlItemStyler().width(value);
  factory SegmentedControlItemStyler.height(double value) =>
      SegmentedControlItemStyler().height(value);
  factory SegmentedControlItemStyler.size(double width, double height) =>
      SegmentedControlItemStyler().size(width, height);
  factory SegmentedControlItemStyler.minWidth(double value) =>
      SegmentedControlItemStyler().minWidth(value);
  factory SegmentedControlItemStyler.maxWidth(double value) =>
      SegmentedControlItemStyler().maxWidth(value);
  factory SegmentedControlItemStyler.minHeight(double value) =>
      SegmentedControlItemStyler().minHeight(value);
  factory SegmentedControlItemStyler.maxHeight(double value) =>
      SegmentedControlItemStyler().maxHeight(value);
  factory SegmentedControlItemStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => SegmentedControlItemStyler().scale(scale, alignment: alignment);
  factory SegmentedControlItemStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => SegmentedControlItemStyler().rotate(radians, alignment: alignment);
  factory SegmentedControlItemStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => SegmentedControlItemStyler().translate(x, y, z);
  factory SegmentedControlItemStyler.skew(double skewX, double skewY) =>
      SegmentedControlItemStyler().skew(skewX, skewY);
  factory SegmentedControlItemStyler.textStyle(TextStyler value) =>
      SegmentedControlItemStyler().textStyle(value);
  factory SegmentedControlItemStyler.image(DecorationImageMix value) =>
      SegmentedControlItemStyler().image(value);
  factory SegmentedControlItemStyler.shape(ShapeBorderMix value) =>
      SegmentedControlItemStyler().shape(value);
  factory SegmentedControlItemStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SegmentedControlItemStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SegmentedControlItemStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SegmentedControlItemStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SegmentedControlItemStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SegmentedControlItemStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SegmentedControlItemStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SegmentedControlItemStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SegmentedControlItemStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SegmentedControlItemStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SegmentedControlItemStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SegmentedControlItemStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SegmentedControlItemStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SegmentedControlItemStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SegmentedControlItemStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SegmentedControlItemStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SegmentedControlItemStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SegmentedControlItemStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SegmentedControlItemStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => SegmentedControlItemStyler().transform(value, alignment: alignment);

  SegmentedControlItemStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  SegmentedControlItemStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  SegmentedControlItemStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  SegmentedControlItemStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  SegmentedControlItemStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  SegmentedControlItemStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  SegmentedControlItemStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  SegmentedControlItemStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  SegmentedControlItemStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  SegmentedControlItemStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  SegmentedControlItemStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  SegmentedControlItemStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  SegmentedControlItemStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  SegmentedControlItemStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  SegmentedControlItemStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  SegmentedControlItemStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  SegmentedControlItemStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  SegmentedControlItemStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  SegmentedControlItemStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  SegmentedControlItemStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  SegmentedControlItemStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  SegmentedControlItemStyler scale(
    double scale, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  SegmentedControlItemStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  SegmentedControlItemStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  SegmentedControlItemStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  SegmentedControlItemStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  SegmentedControlItemStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  SegmentedControlItemStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  SegmentedControlItemStyler backgroundImage(
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

  SegmentedControlItemStyler backgroundImageUrl(
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

  SegmentedControlItemStyler backgroundImageAsset(
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

  SegmentedControlItemStyler linearGradient({
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

  SegmentedControlItemStyler radialGradient({
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

  SegmentedControlItemStyler sweepGradient({
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

  SegmentedControlItemStyler foregroundLinearGradient({
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

  SegmentedControlItemStyler foregroundRadialGradient({
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

  SegmentedControlItemStyler foregroundSweepGradient({
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

  SegmentedControlItemStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  @override
  Set<String> get $stylerFieldNames => const {
    'container',
    'spacing',
    'label',
    'icon',
    'containerEffects',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the container.
  SegmentedControlItemStyler container(BoxStyler value) {
    return merge(SegmentedControlItemStyler(container: value));
  }

  /// Sets the spacing.
  SegmentedControlItemStyler spacing(double value) {
    return merge(SegmentedControlItemStyler(spacing: value));
  }

  /// Sets the label.
  @override
  SegmentedControlItemStyler label(TextStyler value) {
    return merge(SegmentedControlItemStyler(label: value));
  }

  /// Sets the icon.
  @override
  SegmentedControlItemStyler icon(IconStyler value) {
    return merge(SegmentedControlItemStyler(icon: value));
  }

  /// Sets the containerEffects.
  SegmentedControlItemStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(SegmentedControlItemStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  SegmentedControlItemStyler animate(AnimationConfig value) {
    return merge(SegmentedControlItemStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SegmentedControlItemStyler variants(
    List<VariantStyle<SegmentedControlItemSpec>> value,
  ) {
    return merge(SegmentedControlItemStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SegmentedControlItemStyler wrap(WidgetModifierConfig value) {
    return merge(SegmentedControlItemStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SegmentedControlItemStyler modifier(WidgetModifierConfig value) {
    return merge(SegmentedControlItemStyler(modifier: value));
  }

  /// Merges with another [SegmentedControlItemStyler].
  @override
  SegmentedControlItemStyler merge(SegmentedControlItemStyler? other) {
    return SegmentedControlItemStyler.create(
      container: MixOps.merge($container, other?.$container),
      spacing: MixOps.merge($spacing, other?.$spacing),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SegmentedControlItemSpec>] using [context].
  @override
  StyleSpec<SegmentedControlItemSpec> resolve(BuildContext context) {
    final spec = SegmentedControlItemSpec(
      container: MixOps.resolve(context, $container),
      spacing: MixOps.resolve(context, $spacing),
      label: MixOps.resolve(context, $label),
      icon: MixOps.resolve(context, $icon),
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
      ..add(DiagnosticsProperty('container', $container))
      ..add(DiagnosticsProperty('spacing', $spacing))
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('icon', $icon))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $spacing,
    $label,
    $icon,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
