// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_button.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixIconButtonSpec
    implements Spec<RemixIconButtonSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<IconSpec> get icon;
  StyleSpec<RemixSpinnerSpec> get spinner;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => RemixIconButtonSpec;

  @override
  RemixIconButtonSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<IconSpec>? icon,
    StyleSpec<RemixSpinnerSpec>? spinner,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return RemixIconButtonSpec(
      container: container ?? this.container,
      icon: icon ?? this.icon,
      spinner: spinner ?? this.spinner,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  RemixIconButtonSpec lerp(RemixIconButtonSpec? other, double t) {
    return RemixIconButtonSpec(
      container: container.lerp(other?.container, t),
      icon: icon.lerp(other?.icon, t),
      spinner: spinner.lerp(other?.spinner, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [container, icon, spinner, containerEffects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixIconButtonSpec &&
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
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('spinner', spinner))
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$RemixIconButtonSpec` and migrate the class declaration to `class RemixIconButtonSpec with _\$RemixIconButtonSpec`. The `_\$RemixIconButtonSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixIconButtonSpecMethods = _$RemixIconButtonSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixIconButtonStyler
    extends MixStyler<RemixIconButtonStyler, RemixIconButtonSpec>
    with
        RemixBoxStylerMixin<RemixIconButtonStyler>,
        IconStyleMixin<RemixIconButtonStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<IconSpec>>? $icon;
  final Prop<StyleSpec<RemixSpinnerSpec>>? $spinner;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const RemixIconButtonStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<IconSpec>>? icon,
    Prop<StyleSpec<RemixSpinnerSpec>>? spinner,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $icon = icon,
       $spinner = spinner,
       $containerEffects = containerEffects;

  RemixIconButtonStyler({
    BoxStyler? container,
    IconStyler? icon,
    RemixSpinnerStyler? spinner,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixIconButtonSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         icon: Prop.maybeMix(icon),
         spinner: Prop.maybeMix(spinner),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixIconButtonStyler.container(BoxStyler value) =>
      RemixIconButtonStyler().container(value);
  factory RemixIconButtonStyler.icon(IconStyler value) =>
      RemixIconButtonStyler().icon(value);
  factory RemixIconButtonStyler.spinner(RemixSpinnerStyler value) =>
      RemixIconButtonStyler().spinner(value);
  factory RemixIconButtonStyler.containerEffects(RemixBoxEffectsMix value) =>
      RemixIconButtonStyler().containerEffects(value);
  factory RemixIconButtonStyler.alignment(AlignmentGeometry value) =>
      RemixIconButtonStyler().alignment(value);
  factory RemixIconButtonStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixIconButtonStyler().padding(value);
  factory RemixIconButtonStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixIconButtonStyler().margin(value);
  factory RemixIconButtonStyler.constraints(BoxConstraintsMix value) =>
      RemixIconButtonStyler().constraints(value);
  factory RemixIconButtonStyler.decoration(DecorationMix value) =>
      RemixIconButtonStyler().decoration(value);
  factory RemixIconButtonStyler.foregroundDecoration(DecorationMix value) =>
      RemixIconButtonStyler().foregroundDecoration(value);
  factory RemixIconButtonStyler.clipBehavior(Clip value) =>
      RemixIconButtonStyler().clipBehavior(value);
  factory RemixIconButtonStyler.color(Color value) =>
      RemixIconButtonStyler().color(value);
  factory RemixIconButtonStyler.gradient(GradientMix value) =>
      RemixIconButtonStyler().gradient(value);
  factory RemixIconButtonStyler.border(BoxBorderMix value) =>
      RemixIconButtonStyler().border(value);
  factory RemixIconButtonStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixIconButtonStyler().borderRadius(value);
  factory RemixIconButtonStyler.elevation(ElevationShadow value) =>
      RemixIconButtonStyler().elevation(value);
  factory RemixIconButtonStyler.shadow(BoxShadowMix value) =>
      RemixIconButtonStyler().shadow(value);
  factory RemixIconButtonStyler.shadows(List<BoxShadowMix> value) =>
      RemixIconButtonStyler().shadows(value);
  factory RemixIconButtonStyler.width(double value) =>
      RemixIconButtonStyler().width(value);
  factory RemixIconButtonStyler.height(double value) =>
      RemixIconButtonStyler().height(value);
  factory RemixIconButtonStyler.size(double width, double height) =>
      RemixIconButtonStyler().size(width, height);
  factory RemixIconButtonStyler.minWidth(double value) =>
      RemixIconButtonStyler().minWidth(value);
  factory RemixIconButtonStyler.maxWidth(double value) =>
      RemixIconButtonStyler().maxWidth(value);
  factory RemixIconButtonStyler.minHeight(double value) =>
      RemixIconButtonStyler().minHeight(value);
  factory RemixIconButtonStyler.maxHeight(double value) =>
      RemixIconButtonStyler().maxHeight(value);
  factory RemixIconButtonStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixIconButtonStyler().scale(scale, alignment: alignment);
  factory RemixIconButtonStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixIconButtonStyler().rotate(radians, alignment: alignment);
  factory RemixIconButtonStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => RemixIconButtonStyler().translate(x, y, z);
  factory RemixIconButtonStyler.skew(double skewX, double skewY) =>
      RemixIconButtonStyler().skew(skewX, skewY);
  factory RemixIconButtonStyler.textStyle(TextStyler value) =>
      RemixIconButtonStyler().textStyle(value);
  factory RemixIconButtonStyler.image(DecorationImageMix value) =>
      RemixIconButtonStyler().image(value);
  factory RemixIconButtonStyler.shape(ShapeBorderMix value) =>
      RemixIconButtonStyler().shape(value);
  factory RemixIconButtonStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixIconButtonStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixIconButtonStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixIconButtonStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixIconButtonStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixIconButtonStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixIconButtonStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixIconButtonStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixIconButtonStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixIconButtonStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixIconButtonStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixIconButtonStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixIconButtonStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixIconButtonStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixIconButtonStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixIconButtonStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixIconButtonStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixIconButtonStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixIconButtonStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixIconButtonStyler().transform(value, alignment: alignment);

  RemixIconButtonStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixIconButtonStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixIconButtonStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixIconButtonStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixIconButtonStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixIconButtonStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixIconButtonStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixIconButtonStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixIconButtonStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixIconButtonStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixIconButtonStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixIconButtonStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixIconButtonStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixIconButtonStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixIconButtonStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixIconButtonStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixIconButtonStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixIconButtonStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixIconButtonStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixIconButtonStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixIconButtonStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixIconButtonStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixIconButtonStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixIconButtonStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixIconButtonStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixIconButtonStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixIconButtonStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixIconButtonStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixIconButtonStyler backgroundImage(
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

  RemixIconButtonStyler backgroundImageUrl(
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

  RemixIconButtonStyler backgroundImageAsset(
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

  RemixIconButtonStyler linearGradient({
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

  RemixIconButtonStyler radialGradient({
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

  RemixIconButtonStyler sweepGradient({
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

  RemixIconButtonStyler foregroundLinearGradient({
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

  RemixIconButtonStyler foregroundRadialGradient({
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

  RemixIconButtonStyler foregroundSweepGradient({
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

  RemixIconButtonStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixIconButtonStyler container(BoxStyler value) {
    return merge(RemixIconButtonStyler(container: value));
  }

  /// Sets the icon.
  @override
  RemixIconButtonStyler icon(IconStyler value) {
    return merge(RemixIconButtonStyler(icon: value));
  }

  /// Sets the spinner.
  RemixIconButtonStyler spinner(RemixSpinnerStyler value) {
    return merge(RemixIconButtonStyler(spinner: value));
  }

  /// Sets the containerEffects.
  RemixIconButtonStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(RemixIconButtonStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  RemixIconButtonStyler animate(AnimationConfig value) {
    return merge(RemixIconButtonStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixIconButtonStyler variants(
    List<VariantStyle<RemixIconButtonSpec>> value,
  ) {
    return merge(RemixIconButtonStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixIconButtonStyler wrap(WidgetModifierConfig value) {
    return merge(RemixIconButtonStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixIconButtonStyler modifier(WidgetModifierConfig value) {
    return merge(RemixIconButtonStyler(modifier: value));
  }

  /// Merges with another [RemixIconButtonStyler].
  @override
  RemixIconButtonStyler merge(RemixIconButtonStyler? other) {
    return RemixIconButtonStyler.create(
      container: MixOps.merge($container, other?.$container),
      icon: MixOps.merge($icon, other?.$icon),
      spinner: MixOps.merge($spinner, other?.$spinner),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixIconButtonSpec>] using [context].
  @override
  StyleSpec<RemixIconButtonSpec> resolve(BuildContext context) {
    final spec = RemixIconButtonSpec(
      container: MixOps.resolve(context, $container),
      icon: MixOps.resolve(context, $icon),
      spinner: MixOps.resolve(context, $spinner),
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
      ..add(DiagnosticsProperty('icon', $icon))
      ..add(DiagnosticsProperty('spinner', $spinner))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $icon,
    $spinner,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
