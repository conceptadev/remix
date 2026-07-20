// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixMenuSpec implements Spec<RemixMenuSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get overlay;
  RemixSurfaceLayerSpec? get surface;
  StyleSpec<RemixMenuItemSpec> get item;
  StyleSpec<RemixMenuItemSpec> get label;
  StyleSpec<RemixDividerSpec> get divider;

  @override
  Type get type => RemixMenuSpec;

  @override
  RemixMenuSpec copyWith({
    StyleSpec<FlexBoxSpec>? overlay,
    RemixSurfaceLayerSpec? surface,
    StyleSpec<RemixMenuItemSpec>? item,
    StyleSpec<RemixMenuItemSpec>? label,
    StyleSpec<RemixDividerSpec>? divider,
  }) {
    return RemixMenuSpec(
      overlay: overlay ?? this.overlay,
      surface: surface ?? this.surface,
      item: item ?? this.item,
      label: label ?? this.label,
      divider: divider ?? this.divider,
    );
  }

  @override
  RemixMenuSpec lerp(RemixMenuSpec? other, double t) {
    return RemixMenuSpec(
      overlay: overlay.lerp(other?.overlay, t),
      surface: MixOps.lerpSnap(surface, other?.surface, t),
      item: item.lerp(other?.item, t),
      label: label.lerp(other?.label, t),
      divider: divider.lerp(other?.divider, t),
    );
  }

  @override
  List<Object?> get props => [overlay, surface, item, label, divider];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixMenuSpec &&
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
      ..add(DiagnosticsProperty('overlay', overlay))
      ..add(DiagnosticsProperty('surface', surface))
      ..add(DiagnosticsProperty('item', item))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('divider', divider));
  }
}

@Deprecated(
  'Rename to `_\$RemixMenuSpec` and migrate the class declaration to `class RemixMenuSpec with _\$RemixMenuSpec`. The `_\$RemixMenuSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixMenuSpecMethods = _$RemixMenuSpec; // ignore: unused_element

mixin _$RemixMenuItemSpec implements Spec<RemixMenuItemSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get leadingIcon;
  StyleSpec<IconSpec> get trailingIcon;
  StyleSpec<BoxSpec> get indicator;
  StyleSpec<IconSpec> get indicatorIcon;
  double? get leadingInset;
  double? get checkableLeadingInset;
  double? get trailingInset;
  double? get adjacentItemSpacing;

  @override
  Type get type => RemixMenuItemSpec;

  @override
  RemixMenuItemSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? leadingIcon,
    StyleSpec<IconSpec>? trailingIcon,
    StyleSpec<BoxSpec>? indicator,
    StyleSpec<IconSpec>? indicatorIcon,
    double? leadingInset,
    double? checkableLeadingInset,
    double? trailingInset,
    double? adjacentItemSpacing,
  }) {
    return RemixMenuItemSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      indicator: indicator ?? this.indicator,
      indicatorIcon: indicatorIcon ?? this.indicatorIcon,
      leadingInset: leadingInset ?? this.leadingInset,
      checkableLeadingInset:
          checkableLeadingInset ?? this.checkableLeadingInset,
      trailingInset: trailingInset ?? this.trailingInset,
      adjacentItemSpacing: adjacentItemSpacing ?? this.adjacentItemSpacing,
    );
  }

  @override
  RemixMenuItemSpec lerp(RemixMenuItemSpec? other, double t) {
    return RemixMenuItemSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      leadingIcon: leadingIcon.lerp(other?.leadingIcon, t),
      trailingIcon: trailingIcon.lerp(other?.trailingIcon, t),
      indicator: indicator.lerp(other?.indicator, t),
      indicatorIcon: indicatorIcon.lerp(other?.indicatorIcon, t),
      leadingInset: MixOps.lerp(leadingInset, other?.leadingInset, t),
      checkableLeadingInset: MixOps.lerp(
        checkableLeadingInset,
        other?.checkableLeadingInset,
        t,
      ),
      trailingInset: MixOps.lerp(trailingInset, other?.trailingInset, t),
      adjacentItemSpacing: MixOps.lerp(
        adjacentItemSpacing,
        other?.adjacentItemSpacing,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [
    container,
    label,
    leadingIcon,
    trailingIcon,
    indicator,
    indicatorIcon,
    leadingInset,
    checkableLeadingInset,
    trailingInset,
    adjacentItemSpacing,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixMenuItemSpec &&
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
      ..add(DiagnosticsProperty('leadingIcon', leadingIcon))
      ..add(DiagnosticsProperty('trailingIcon', trailingIcon))
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DiagnosticsProperty('indicatorIcon', indicatorIcon))
      ..add(DoubleProperty('leadingInset', leadingInset))
      ..add(DoubleProperty('checkableLeadingInset', checkableLeadingInset))
      ..add(DoubleProperty('trailingInset', trailingInset))
      ..add(DoubleProperty('adjacentItemSpacing', adjacentItemSpacing));
  }
}

@Deprecated(
  'Rename to `_\$RemixMenuItemSpec` and migrate the class declaration to `class RemixMenuItemSpec with _\$RemixMenuItemSpec`. The `_\$RemixMenuItemSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixMenuItemSpecMethods = _$RemixMenuItemSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixMenuStyler extends MixStyler<RemixMenuStyler, RemixMenuSpec> {
  final Prop<StyleSpec<FlexBoxSpec>>? $overlay;
  final Prop<RemixSurfaceLayerSpec>? $surface;
  final Prop<StyleSpec<RemixMenuItemSpec>>? $item;
  final Prop<StyleSpec<RemixMenuItemSpec>>? $label;
  final Prop<StyleSpec<RemixDividerSpec>>? $divider;

  const RemixMenuStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? overlay,
    Prop<RemixSurfaceLayerSpec>? surface,
    Prop<StyleSpec<RemixMenuItemSpec>>? item,
    Prop<StyleSpec<RemixMenuItemSpec>>? label,
    Prop<StyleSpec<RemixDividerSpec>>? divider,
    super.variants,
    super.modifier,
    super.animation,
  }) : $overlay = overlay,
       $surface = surface,
       $item = item,
       $label = label,
       $divider = divider;

  RemixMenuStyler({
    FlexBoxStyler? overlay,
    RemixSurfaceLayerMix? surface,
    RemixMenuItemStyler? item,
    RemixMenuItemStyler? label,
    RemixDividerStyler? divider,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixMenuSpec>>? variants,
  }) : this.create(
         overlay: Prop.maybeMix(overlay),
         surface: Prop.maybeMix(surface),
         item: Prop.maybeMix(item),
         label: Prop.maybeMix(label),
         divider: Prop.maybeMix(divider),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixMenuStyler.overlay(FlexBoxStyler value) =>
      RemixMenuStyler().overlay(value);
  factory RemixMenuStyler.surface(RemixSurfaceLayerMix value) =>
      RemixMenuStyler().surface(value);
  factory RemixMenuStyler.item(RemixMenuItemStyler value) =>
      RemixMenuStyler().item(value);
  factory RemixMenuStyler.label(RemixMenuItemStyler value) =>
      RemixMenuStyler().label(value);
  factory RemixMenuStyler.divider(RemixDividerStyler value) =>
      RemixMenuStyler().divider(value);

  /// Sets the overlay.
  RemixMenuStyler overlay(FlexBoxStyler value) {
    return merge(RemixMenuStyler(overlay: value));
  }

  /// Sets the surface.
  RemixMenuStyler surface(RemixSurfaceLayerMix value) {
    return merge(RemixMenuStyler(surface: value));
  }

  /// Sets the item.
  RemixMenuStyler item(RemixMenuItemStyler value) {
    return merge(RemixMenuStyler(item: value));
  }

  /// Sets the label.
  RemixMenuStyler label(RemixMenuItemStyler value) {
    return merge(RemixMenuStyler(label: value));
  }

  /// Sets the divider.
  RemixMenuStyler divider(RemixDividerStyler value) {
    return merge(RemixMenuStyler(divider: value));
  }

  /// Sets the animation configuration.
  @override
  RemixMenuStyler animate(AnimationConfig value) {
    return merge(RemixMenuStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixMenuStyler variants(List<VariantStyle<RemixMenuSpec>> value) {
    return merge(RemixMenuStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixMenuStyler wrap(WidgetModifierConfig value) {
    return merge(RemixMenuStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixMenuStyler modifier(WidgetModifierConfig value) {
    return merge(RemixMenuStyler(modifier: value));
  }

  /// Merges with another [RemixMenuStyler].
  @override
  RemixMenuStyler merge(RemixMenuStyler? other) {
    return RemixMenuStyler.create(
      overlay: MixOps.merge($overlay, other?.$overlay),
      surface: MixOps.merge($surface, other?.$surface),
      item: MixOps.merge($item, other?.$item),
      label: MixOps.merge($label, other?.$label),
      divider: MixOps.merge($divider, other?.$divider),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixMenuSpec>] using [context].
  @override
  StyleSpec<RemixMenuSpec> resolve(BuildContext context) {
    final spec = RemixMenuSpec(
      overlay: MixOps.resolve(context, $overlay),
      surface: MixOps.resolve(context, $surface),
      item: MixOps.resolve(context, $item),
      label: MixOps.resolve(context, $label),
      divider: MixOps.resolve(context, $divider),
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
      ..add(DiagnosticsProperty('overlay', $overlay))
      ..add(DiagnosticsProperty('surface', $surface))
      ..add(DiagnosticsProperty('item', $item))
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('divider', $divider));
  }

  @override
  List<Object?> get props => [
    $overlay,
    $surface,
    $item,
    $label,
    $divider,
    $animation,
    $modifier,
    $variants,
  ];
}

class RemixMenuItemStyler
    extends MixStyler<RemixMenuItemStyler, RemixMenuItemSpec>
    with RemixBoxStylerMixin<RemixMenuItemStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $leadingIcon;
  final Prop<StyleSpec<IconSpec>>? $trailingIcon;
  final Prop<StyleSpec<BoxSpec>>? $indicator;
  final Prop<StyleSpec<IconSpec>>? $indicatorIcon;
  final Prop<double>? $leadingInset;
  final Prop<double>? $checkableLeadingInset;
  final Prop<double>? $trailingInset;
  final Prop<double>? $adjacentItemSpacing;

  const RemixMenuItemStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? leadingIcon,
    Prop<StyleSpec<IconSpec>>? trailingIcon,
    Prop<StyleSpec<BoxSpec>>? indicator,
    Prop<StyleSpec<IconSpec>>? indicatorIcon,
    Prop<double>? leadingInset,
    Prop<double>? checkableLeadingInset,
    Prop<double>? trailingInset,
    Prop<double>? adjacentItemSpacing,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $leadingIcon = leadingIcon,
       $trailingIcon = trailingIcon,
       $indicator = indicator,
       $indicatorIcon = indicatorIcon,
       $leadingInset = leadingInset,
       $checkableLeadingInset = checkableLeadingInset,
       $trailingInset = trailingInset,
       $adjacentItemSpacing = adjacentItemSpacing;

  RemixMenuItemStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? leadingIcon,
    IconStyler? trailingIcon,
    BoxStyler? indicator,
    IconStyler? indicatorIcon,
    double? leadingInset,
    double? checkableLeadingInset,
    double? trailingInset,
    double? adjacentItemSpacing,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixMenuItemSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         leadingIcon: Prop.maybeMix(leadingIcon),
         trailingIcon: Prop.maybeMix(trailingIcon),
         indicator: Prop.maybeMix(indicator),
         indicatorIcon: Prop.maybeMix(indicatorIcon),
         leadingInset: Prop.maybe(leadingInset),
         checkableLeadingInset: Prop.maybe(checkableLeadingInset),
         trailingInset: Prop.maybe(trailingInset),
         adjacentItemSpacing: Prop.maybe(adjacentItemSpacing),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixMenuItemStyler.container(FlexBoxStyler value) =>
      RemixMenuItemStyler().container(value);
  factory RemixMenuItemStyler.label(TextStyler value) =>
      RemixMenuItemStyler().label(value);
  factory RemixMenuItemStyler.leadingIcon(IconStyler value) =>
      RemixMenuItemStyler().leadingIcon(value);
  factory RemixMenuItemStyler.trailingIcon(IconStyler value) =>
      RemixMenuItemStyler().trailingIcon(value);
  factory RemixMenuItemStyler.indicator(BoxStyler value) =>
      RemixMenuItemStyler().indicator(value);
  factory RemixMenuItemStyler.indicatorIcon(IconStyler value) =>
      RemixMenuItemStyler().indicatorIcon(value);
  factory RemixMenuItemStyler.leadingInset(double value) =>
      RemixMenuItemStyler().leadingInset(value);
  factory RemixMenuItemStyler.checkableLeadingInset(double value) =>
      RemixMenuItemStyler().checkableLeadingInset(value);
  factory RemixMenuItemStyler.trailingInset(double value) =>
      RemixMenuItemStyler().trailingInset(value);
  factory RemixMenuItemStyler.adjacentItemSpacing(double value) =>
      RemixMenuItemStyler().adjacentItemSpacing(value);
  factory RemixMenuItemStyler.color(Color value) =>
      RemixMenuItemStyler().color(value);
  factory RemixMenuItemStyler.gradient(GradientMix value) =>
      RemixMenuItemStyler().gradient(value);
  factory RemixMenuItemStyler.border(BoxBorderMix value) =>
      RemixMenuItemStyler().border(value);
  factory RemixMenuItemStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixMenuItemStyler().borderRadius(value);
  factory RemixMenuItemStyler.elevation(ElevationShadow value) =>
      RemixMenuItemStyler().elevation(value);
  factory RemixMenuItemStyler.shadow(BoxShadowMix value) =>
      RemixMenuItemStyler().shadow(value);
  factory RemixMenuItemStyler.shadows(List<BoxShadowMix> value) =>
      RemixMenuItemStyler().shadows(value);
  factory RemixMenuItemStyler.width(double value) =>
      RemixMenuItemStyler().width(value);
  factory RemixMenuItemStyler.height(double value) =>
      RemixMenuItemStyler().height(value);
  factory RemixMenuItemStyler.size(double width, double height) =>
      RemixMenuItemStyler().size(width, height);
  factory RemixMenuItemStyler.minWidth(double value) =>
      RemixMenuItemStyler().minWidth(value);
  factory RemixMenuItemStyler.maxWidth(double value) =>
      RemixMenuItemStyler().maxWidth(value);
  factory RemixMenuItemStyler.minHeight(double value) =>
      RemixMenuItemStyler().minHeight(value);
  factory RemixMenuItemStyler.maxHeight(double value) =>
      RemixMenuItemStyler().maxHeight(value);
  factory RemixMenuItemStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixMenuItemStyler().scale(scale, alignment: alignment);
  factory RemixMenuItemStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixMenuItemStyler().rotate(radians, alignment: alignment);
  factory RemixMenuItemStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixMenuItemStyler().translate(x, y, z);
  factory RemixMenuItemStyler.skew(double skewX, double skewY) =>
      RemixMenuItemStyler().skew(skewX, skewY);
  factory RemixMenuItemStyler.textStyle(TextStyler value) =>
      RemixMenuItemStyler().textStyle(value);
  factory RemixMenuItemStyler.image(DecorationImageMix value) =>
      RemixMenuItemStyler().image(value);
  factory RemixMenuItemStyler.shape(ShapeBorderMix value) =>
      RemixMenuItemStyler().shape(value);
  factory RemixMenuItemStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixMenuItemStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixMenuItemStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixMenuItemStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixMenuItemStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixMenuItemStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixMenuItemStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.row() => RemixMenuItemStyler().row();
  factory RemixMenuItemStyler.column() => RemixMenuItemStyler().column();
  factory RemixMenuItemStyler.alignment(AlignmentGeometry value) =>
      RemixMenuItemStyler().alignment(value);
  factory RemixMenuItemStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixMenuItemStyler().padding(value);
  factory RemixMenuItemStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixMenuItemStyler().margin(value);
  factory RemixMenuItemStyler.constraints(BoxConstraintsMix value) =>
      RemixMenuItemStyler().constraints(value);
  factory RemixMenuItemStyler.decoration(DecorationMix value) =>
      RemixMenuItemStyler().decoration(value);
  factory RemixMenuItemStyler.foregroundDecoration(DecorationMix value) =>
      RemixMenuItemStyler().foregroundDecoration(value);
  factory RemixMenuItemStyler.clipBehavior(Clip value) =>
      RemixMenuItemStyler().clipBehavior(value);
  factory RemixMenuItemStyler.direction(Axis value) =>
      RemixMenuItemStyler().direction(value);
  factory RemixMenuItemStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixMenuItemStyler().mainAxisAlignment(value);
  factory RemixMenuItemStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixMenuItemStyler().crossAxisAlignment(value);
  factory RemixMenuItemStyler.mainAxisSize(MainAxisSize value) =>
      RemixMenuItemStyler().mainAxisSize(value);
  factory RemixMenuItemStyler.spacing(double value) =>
      RemixMenuItemStyler().spacing(value);
  factory RemixMenuItemStyler.verticalDirection(VerticalDirection value) =>
      RemixMenuItemStyler().verticalDirection(value);
  factory RemixMenuItemStyler.textDirection(TextDirection value) =>
      RemixMenuItemStyler().textDirection(value);
  factory RemixMenuItemStyler.textBaseline(TextBaseline value) =>
      RemixMenuItemStyler().textBaseline(value);
  factory RemixMenuItemStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixMenuItemStyler().transform(value, alignment: alignment);

  RemixMenuItemStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixMenuItemStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixMenuItemStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixMenuItemStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixMenuItemStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixMenuItemStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixMenuItemStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixMenuItemStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixMenuItemStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixMenuItemStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixMenuItemStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixMenuItemStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixMenuItemStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixMenuItemStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixMenuItemStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixMenuItemStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixMenuItemStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixMenuItemStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixMenuItemStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixMenuItemStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixMenuItemStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixMenuItemStyler backgroundImage(
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

  RemixMenuItemStyler backgroundImageUrl(
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

  RemixMenuItemStyler backgroundImageAsset(
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

  RemixMenuItemStyler linearGradient({
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

  RemixMenuItemStyler radialGradient({
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

  RemixMenuItemStyler sweepGradient({
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

  RemixMenuItemStyler foregroundLinearGradient({
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

  RemixMenuItemStyler foregroundRadialGradient({
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

  RemixMenuItemStyler foregroundSweepGradient({
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

  RemixMenuItemStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixMenuItemStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixMenuItemStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixMenuItemStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixMenuItemStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixMenuItemStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixMenuItemStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixMenuItemStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixMenuItemStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixMenuItemStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixMenuItemStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixMenuItemStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixMenuItemStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixMenuItemStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixMenuItemStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixMenuItemStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixMenuItemStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixMenuItemStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixMenuItemStyler container(FlexBoxStyler value) {
    return merge(RemixMenuItemStyler(container: value));
  }

  /// Sets the label.
  RemixMenuItemStyler label(TextStyler value) {
    return merge(RemixMenuItemStyler(label: value));
  }

  /// Sets the leadingIcon.
  RemixMenuItemStyler leadingIcon(IconStyler value) {
    return merge(RemixMenuItemStyler(leadingIcon: value));
  }

  /// Sets the trailingIcon.
  RemixMenuItemStyler trailingIcon(IconStyler value) {
    return merge(RemixMenuItemStyler(trailingIcon: value));
  }

  /// Sets the indicator.
  RemixMenuItemStyler indicator(BoxStyler value) {
    return merge(RemixMenuItemStyler(indicator: value));
  }

  /// Sets the indicatorIcon.
  RemixMenuItemStyler indicatorIcon(IconStyler value) {
    return merge(RemixMenuItemStyler(indicatorIcon: value));
  }

  /// Sets the leadingInset.
  RemixMenuItemStyler leadingInset(double value) {
    return merge(RemixMenuItemStyler(leadingInset: value));
  }

  /// Sets the checkableLeadingInset.
  RemixMenuItemStyler checkableLeadingInset(double value) {
    return merge(RemixMenuItemStyler(checkableLeadingInset: value));
  }

  /// Sets the trailingInset.
  RemixMenuItemStyler trailingInset(double value) {
    return merge(RemixMenuItemStyler(trailingInset: value));
  }

  /// Sets the adjacentItemSpacing.
  RemixMenuItemStyler adjacentItemSpacing(double value) {
    return merge(RemixMenuItemStyler(adjacentItemSpacing: value));
  }

  /// Sets the animation configuration.
  @override
  RemixMenuItemStyler animate(AnimationConfig value) {
    return merge(RemixMenuItemStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixMenuItemStyler variants(List<VariantStyle<RemixMenuItemSpec>> value) {
    return merge(RemixMenuItemStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixMenuItemStyler wrap(WidgetModifierConfig value) {
    return merge(RemixMenuItemStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixMenuItemStyler modifier(WidgetModifierConfig value) {
    return merge(RemixMenuItemStyler(modifier: value));
  }

  /// Merges with another [RemixMenuItemStyler].
  @override
  RemixMenuItemStyler merge(RemixMenuItemStyler? other) {
    return RemixMenuItemStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      leadingIcon: MixOps.merge($leadingIcon, other?.$leadingIcon),
      trailingIcon: MixOps.merge($trailingIcon, other?.$trailingIcon),
      indicator: MixOps.merge($indicator, other?.$indicator),
      indicatorIcon: MixOps.merge($indicatorIcon, other?.$indicatorIcon),
      leadingInset: MixOps.merge($leadingInset, other?.$leadingInset),
      checkableLeadingInset: MixOps.merge(
        $checkableLeadingInset,
        other?.$checkableLeadingInset,
      ),
      trailingInset: MixOps.merge($trailingInset, other?.$trailingInset),
      adjacentItemSpacing: MixOps.merge(
        $adjacentItemSpacing,
        other?.$adjacentItemSpacing,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixMenuItemSpec>] using [context].
  @override
  StyleSpec<RemixMenuItemSpec> resolve(BuildContext context) {
    final spec = RemixMenuItemSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      leadingIcon: MixOps.resolve(context, $leadingIcon),
      trailingIcon: MixOps.resolve(context, $trailingIcon),
      indicator: MixOps.resolve(context, $indicator),
      indicatorIcon: MixOps.resolve(context, $indicatorIcon),
      leadingInset: MixOps.resolve(context, $leadingInset),
      checkableLeadingInset: MixOps.resolve(context, $checkableLeadingInset),
      trailingInset: MixOps.resolve(context, $trailingInset),
      adjacentItemSpacing: MixOps.resolve(context, $adjacentItemSpacing),
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
      ..add(DiagnosticsProperty('leadingIcon', $leadingIcon))
      ..add(DiagnosticsProperty('trailingIcon', $trailingIcon))
      ..add(DiagnosticsProperty('indicator', $indicator))
      ..add(DiagnosticsProperty('indicatorIcon', $indicatorIcon))
      ..add(DiagnosticsProperty('leadingInset', $leadingInset))
      ..add(
        DiagnosticsProperty('checkableLeadingInset', $checkableLeadingInset),
      )
      ..add(DiagnosticsProperty('trailingInset', $trailingInset))
      ..add(DiagnosticsProperty('adjacentItemSpacing', $adjacentItemSpacing));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $leadingIcon,
    $trailingIcon,
    $indicator,
    $indicatorIcon,
    $leadingInset,
    $checkableLeadingInset,
    $trailingInset,
    $adjacentItemSpacing,
    $animation,
    $modifier,
    $variants,
  ];
}
