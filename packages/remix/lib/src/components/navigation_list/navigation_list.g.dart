// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_list.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$NavigationListSpec implements Spec<NavigationListSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<FlexBoxSpec> get section;
  StyleSpec<TextSpec> get sectionLabel;
  StyleSpec<FlexBoxSpec> get destinations;
  StyleSpec<ToggleSpec> get destination;

  @override
  Type get type => NavigationListSpec;

  @override
  NavigationListSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<FlexBoxSpec>? section,
    StyleSpec<TextSpec>? sectionLabel,
    StyleSpec<FlexBoxSpec>? destinations,
    StyleSpec<ToggleSpec>? destination,
  }) {
    return NavigationListSpec(
      container: container ?? this.container,
      section: section ?? this.section,
      sectionLabel: sectionLabel ?? this.sectionLabel,
      destinations: destinations ?? this.destinations,
      destination: destination ?? this.destination,
    );
  }

  @override
  NavigationListSpec lerp(NavigationListSpec? other, double t) {
    return NavigationListSpec(
      container: container.lerp(other?.container, t),
      section: section.lerp(other?.section, t),
      sectionLabel: sectionLabel.lerp(other?.sectionLabel, t),
      destinations: destinations.lerp(other?.destinations, t),
      destination: destination.lerp(other?.destination, t),
    );
  }

  @override
  List<Object?> get props => [
    container,
    section,
    sectionLabel,
    destinations,
    destination,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NavigationListSpec &&
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
      ..add(DiagnosticsProperty('section', section))
      ..add(DiagnosticsProperty('sectionLabel', sectionLabel))
      ..add(DiagnosticsProperty('destinations', destinations))
      ..add(DiagnosticsProperty('destination', destination));
  }
}

@Deprecated(
  'Rename to `_\$NavigationListSpec` and migrate the class declaration to `class NavigationListSpec with _\$NavigationListSpec`. The `_\$NavigationListSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$NavigationListSpecMethods = _$NavigationListSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class NavigationListStyler
    extends MixStyler<NavigationListStyler, NavigationListSpec>
    with RemixBoxStylerMixin<NavigationListStyler>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<FlexBoxSpec>>? $section;
  final Prop<StyleSpec<TextSpec>>? $sectionLabel;
  final Prop<StyleSpec<FlexBoxSpec>>? $destinations;
  final Prop<StyleSpec<ToggleSpec>>? $destination;

  const NavigationListStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<FlexBoxSpec>>? section,
    Prop<StyleSpec<TextSpec>>? sectionLabel,
    Prop<StyleSpec<FlexBoxSpec>>? destinations,
    Prop<StyleSpec<ToggleSpec>>? destination,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $section = section,
       $sectionLabel = sectionLabel,
       $destinations = destinations,
       $destination = destination;

  NavigationListStyler({
    FlexBoxStyler? container,
    FlexBoxStyler? section,
    TextStyler? sectionLabel,
    FlexBoxStyler? destinations,
    ToggleStyler? destination,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<NavigationListSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         section: Prop.maybeMix(section),
         sectionLabel: Prop.maybeMix(sectionLabel),
         destinations: Prop.maybeMix(destinations),
         destination: Prop.maybeMix(destination),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory NavigationListStyler.container(FlexBoxStyler value) =>
      NavigationListStyler().container(value);
  factory NavigationListStyler.section(FlexBoxStyler value) =>
      NavigationListStyler().section(value);
  factory NavigationListStyler.sectionLabel(TextStyler value) =>
      NavigationListStyler().sectionLabel(value);
  factory NavigationListStyler.destinations(FlexBoxStyler value) =>
      NavigationListStyler().destinations(value);
  factory NavigationListStyler.destination(ToggleStyler value) =>
      NavigationListStyler().destination(value);
  factory NavigationListStyler.color(Color value) =>
      NavigationListStyler().color(value);
  factory NavigationListStyler.gradient(GradientMix value) =>
      NavigationListStyler().gradient(value);
  factory NavigationListStyler.border(BoxBorderMix value) =>
      NavigationListStyler().border(value);
  factory NavigationListStyler.borderRadius(BorderRadiusGeometryMix value) =>
      NavigationListStyler().borderRadius(value);
  factory NavigationListStyler.elevation(ElevationShadow value) =>
      NavigationListStyler().elevation(value);
  factory NavigationListStyler.shadow(BoxShadowMix value) =>
      NavigationListStyler().shadow(value);
  factory NavigationListStyler.shadows(List<BoxShadowMix> value) =>
      NavigationListStyler().shadows(value);
  factory NavigationListStyler.width(double value) =>
      NavigationListStyler().width(value);
  factory NavigationListStyler.height(double value) =>
      NavigationListStyler().height(value);
  factory NavigationListStyler.size(double width, double height) =>
      NavigationListStyler().size(width, height);
  factory NavigationListStyler.minWidth(double value) =>
      NavigationListStyler().minWidth(value);
  factory NavigationListStyler.maxWidth(double value) =>
      NavigationListStyler().maxWidth(value);
  factory NavigationListStyler.minHeight(double value) =>
      NavigationListStyler().minHeight(value);
  factory NavigationListStyler.maxHeight(double value) =>
      NavigationListStyler().maxHeight(value);
  factory NavigationListStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => NavigationListStyler().scale(scale, alignment: alignment);
  factory NavigationListStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => NavigationListStyler().rotate(radians, alignment: alignment);
  factory NavigationListStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => NavigationListStyler().translate(x, y, z);
  factory NavigationListStyler.skew(double skewX, double skewY) =>
      NavigationListStyler().skew(skewX, skewY);
  factory NavigationListStyler.textStyle(TextStyler value) =>
      NavigationListStyler().textStyle(value);
  factory NavigationListStyler.image(DecorationImageMix value) =>
      NavigationListStyler().image(value);
  factory NavigationListStyler.shape(ShapeBorderMix value) =>
      NavigationListStyler().shape(value);
  factory NavigationListStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => NavigationListStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory NavigationListStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => NavigationListStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory NavigationListStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => NavigationListStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory NavigationListStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => NavigationListStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory NavigationListStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => NavigationListStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory NavigationListStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => NavigationListStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory NavigationListStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => NavigationListStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory NavigationListStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => NavigationListStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory NavigationListStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => NavigationListStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory NavigationListStyler.row() => NavigationListStyler().row();
  factory NavigationListStyler.column() => NavigationListStyler().column();
  factory NavigationListStyler.alignment(AlignmentGeometry value) =>
      NavigationListStyler().alignment(value);
  factory NavigationListStyler.padding(EdgeInsetsGeometryMix value) =>
      NavigationListStyler().padding(value);
  factory NavigationListStyler.margin(EdgeInsetsGeometryMix value) =>
      NavigationListStyler().margin(value);
  factory NavigationListStyler.constraints(BoxConstraintsMix value) =>
      NavigationListStyler().constraints(value);
  factory NavigationListStyler.decoration(DecorationMix value) =>
      NavigationListStyler().decoration(value);
  factory NavigationListStyler.foregroundDecoration(DecorationMix value) =>
      NavigationListStyler().foregroundDecoration(value);
  factory NavigationListStyler.clipBehavior(Clip value) =>
      NavigationListStyler().clipBehavior(value);
  factory NavigationListStyler.direction(Axis value) =>
      NavigationListStyler().direction(value);
  factory NavigationListStyler.mainAxisAlignment(MainAxisAlignment value) =>
      NavigationListStyler().mainAxisAlignment(value);
  factory NavigationListStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      NavigationListStyler().crossAxisAlignment(value);
  factory NavigationListStyler.mainAxisSize(MainAxisSize value) =>
      NavigationListStyler().mainAxisSize(value);
  factory NavigationListStyler.spacing(double value) =>
      NavigationListStyler().spacing(value);
  factory NavigationListStyler.verticalDirection(VerticalDirection value) =>
      NavigationListStyler().verticalDirection(value);
  factory NavigationListStyler.textDirection(TextDirection value) =>
      NavigationListStyler().textDirection(value);
  factory NavigationListStyler.textBaseline(TextBaseline value) =>
      NavigationListStyler().textBaseline(value);
  factory NavigationListStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => NavigationListStyler().transform(value, alignment: alignment);

  NavigationListStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  NavigationListStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  NavigationListStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  NavigationListStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  NavigationListStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  NavigationListStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  NavigationListStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  NavigationListStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  NavigationListStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  NavigationListStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  NavigationListStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  NavigationListStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  NavigationListStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  NavigationListStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  NavigationListStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  NavigationListStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  NavigationListStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  NavigationListStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  NavigationListStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  NavigationListStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  NavigationListStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  NavigationListStyler backgroundImage(
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

  NavigationListStyler backgroundImageUrl(
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

  NavigationListStyler backgroundImageAsset(
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

  NavigationListStyler linearGradient({
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

  NavigationListStyler radialGradient({
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

  NavigationListStyler sweepGradient({
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

  NavigationListStyler foregroundLinearGradient({
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

  NavigationListStyler foregroundRadialGradient({
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

  NavigationListStyler foregroundSweepGradient({
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

  NavigationListStyler row() {
    return container(FlexBoxStyler().row());
  }

  NavigationListStyler column() {
    return container(FlexBoxStyler().column());
  }

  NavigationListStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  NavigationListStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  NavigationListStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  NavigationListStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  NavigationListStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  NavigationListStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  NavigationListStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  NavigationListStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  NavigationListStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  NavigationListStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  NavigationListStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  NavigationListStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  NavigationListStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  NavigationListStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  NavigationListStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  NavigationListStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  @override
  Set<String> get $stylerFieldNames => const {
    'container',
    'section',
    'sectionLabel',
    'destinations',
    'destination',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the container.
  NavigationListStyler container(FlexBoxStyler value) {
    return merge(NavigationListStyler(container: value));
  }

  /// Sets the section.
  NavigationListStyler section(FlexBoxStyler value) {
    return merge(NavigationListStyler(section: value));
  }

  /// Sets the sectionLabel.
  NavigationListStyler sectionLabel(TextStyler value) {
    return merge(NavigationListStyler(sectionLabel: value));
  }

  /// Sets the destinations.
  NavigationListStyler destinations(FlexBoxStyler value) {
    return merge(NavigationListStyler(destinations: value));
  }

  /// Sets the destination.
  NavigationListStyler destination(ToggleStyler value) {
    return merge(NavigationListStyler(destination: value));
  }

  /// Sets the animation configuration.
  @override
  NavigationListStyler animate(AnimationConfig value) {
    return merge(NavigationListStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  NavigationListStyler variants(List<VariantStyle<NavigationListSpec>> value) {
    return merge(NavigationListStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  NavigationListStyler wrap(WidgetModifierConfig value) {
    return merge(NavigationListStyler(modifier: value));
  }

  /// Sets the widget modifier.
  NavigationListStyler modifier(WidgetModifierConfig value) {
    return merge(NavigationListStyler(modifier: value));
  }

  RemixNavigationList<T> call<T extends Object>({
    Key? key,
    required List<RemixNavigationSection<T>> sections,
    required T? selectedValue,
    ValueChanged<T>? onSelected,
    bool enabled = true,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixNavigationList<T>(
      key: key,
      style: this,
      sections: sections,
      selectedValue: selectedValue,
      onSelected: onSelected,
      enabled: enabled,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
    );
  }

  /// Merges with another [NavigationListStyler].
  @override
  NavigationListStyler merge(NavigationListStyler? other) {
    return NavigationListStyler.create(
      container: MixOps.merge($container, other?.$container),
      section: MixOps.merge($section, other?.$section),
      sectionLabel: MixOps.merge($sectionLabel, other?.$sectionLabel),
      destinations: MixOps.merge($destinations, other?.$destinations),
      destination: MixOps.merge($destination, other?.$destination),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<NavigationListSpec>] using [context].
  @override
  StyleSpec<NavigationListSpec> resolve(BuildContext context) {
    final spec = NavigationListSpec(
      container: MixOps.resolve(context, $container),
      section: MixOps.resolve(context, $section),
      sectionLabel: MixOps.resolve(context, $sectionLabel),
      destinations: MixOps.resolve(context, $destinations),
      destination: MixOps.resolve(context, $destination),
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
      ..add(DiagnosticsProperty('section', $section))
      ..add(DiagnosticsProperty('sectionLabel', $sectionLabel))
      ..add(DiagnosticsProperty('destinations', $destinations))
      ..add(DiagnosticsProperty('destination', $destination));
  }

  @override
  List<Object?> get props => [
    $container,
    $section,
    $sectionLabel,
    $destinations,
    $destination,
    $animation,
    $modifier,
    $variants,
  ];
}
