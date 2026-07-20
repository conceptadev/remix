// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixDialogSpec implements Spec<RemixDialogSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  RemixSurfaceLayerSpec? get surface;
  StyleSpec<TextSpec> get title;
  StyleSpec<TextSpec> get description;
  StyleSpec<FlexBoxSpec> get actions;

  @override
  Type get type => RemixDialogSpec;

  @override
  RemixDialogSpec copyWith({
    StyleSpec<BoxSpec>? container,
    RemixSurfaceLayerSpec? surface,
    StyleSpec<TextSpec>? title,
    StyleSpec<TextSpec>? description,
    StyleSpec<FlexBoxSpec>? actions,
  }) {
    return RemixDialogSpec(
      container: container ?? this.container,
      surface: surface ?? this.surface,
      title: title ?? this.title,
      description: description ?? this.description,
      actions: actions ?? this.actions,
    );
  }

  @override
  RemixDialogSpec lerp(RemixDialogSpec? other, double t) {
    return RemixDialogSpec(
      container: container.lerp(other?.container, t),
      surface: MixOps.lerpSnap(surface, other?.surface, t),
      title: title.lerp(other?.title, t),
      description: description.lerp(other?.description, t),
      actions: actions.lerp(other?.actions, t),
    );
  }

  @override
  List<Object?> get props => [container, surface, title, description, actions];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixDialogSpec &&
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
      ..add(DiagnosticsProperty('surface', surface))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('actions', actions));
  }
}

@Deprecated(
  'Rename to `_\$RemixDialogSpec` and migrate the class declaration to `class RemixDialogSpec with _\$RemixDialogSpec`. The `_\$RemixDialogSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixDialogSpecMethods = _$RemixDialogSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixDialogStyler extends MixStyler<RemixDialogStyler, RemixDialogSpec>
    with RemixBoxStylerMixin<RemixDialogStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<RemixSurfaceLayerSpec>? $surface;
  final Prop<StyleSpec<TextSpec>>? $title;
  final Prop<StyleSpec<TextSpec>>? $description;
  final Prop<StyleSpec<FlexBoxSpec>>? $actions;

  const RemixDialogStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<RemixSurfaceLayerSpec>? surface,
    Prop<StyleSpec<TextSpec>>? title,
    Prop<StyleSpec<TextSpec>>? description,
    Prop<StyleSpec<FlexBoxSpec>>? actions,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $surface = surface,
       $title = title,
       $description = description,
       $actions = actions;

  RemixDialogStyler({
    BoxStyler? container,
    RemixSurfaceLayerMix? surface,
    TextStyler? title,
    TextStyler? description,
    FlexBoxStyler? actions,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixDialogSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         surface: Prop.maybeMix(surface),
         title: Prop.maybeMix(title),
         description: Prop.maybeMix(description),
         actions: Prop.maybeMix(actions),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixDialogStyler.container(BoxStyler value) =>
      RemixDialogStyler().container(value);
  factory RemixDialogStyler.surface(RemixSurfaceLayerMix value) =>
      RemixDialogStyler().surface(value);
  factory RemixDialogStyler.title(TextStyler value) =>
      RemixDialogStyler().title(value);
  factory RemixDialogStyler.description(TextStyler value) =>
      RemixDialogStyler().description(value);
  factory RemixDialogStyler.actions(FlexBoxStyler value) =>
      RemixDialogStyler().actions(value);
  factory RemixDialogStyler.alignment(AlignmentGeometry value) =>
      RemixDialogStyler().alignment(value);
  factory RemixDialogStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixDialogStyler().padding(value);
  factory RemixDialogStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixDialogStyler().margin(value);
  factory RemixDialogStyler.constraints(BoxConstraintsMix value) =>
      RemixDialogStyler().constraints(value);
  factory RemixDialogStyler.decoration(DecorationMix value) =>
      RemixDialogStyler().decoration(value);
  factory RemixDialogStyler.foregroundDecoration(DecorationMix value) =>
      RemixDialogStyler().foregroundDecoration(value);
  factory RemixDialogStyler.clipBehavior(Clip value) =>
      RemixDialogStyler().clipBehavior(value);
  factory RemixDialogStyler.color(Color value) =>
      RemixDialogStyler().color(value);
  factory RemixDialogStyler.gradient(GradientMix value) =>
      RemixDialogStyler().gradient(value);
  factory RemixDialogStyler.border(BoxBorderMix value) =>
      RemixDialogStyler().border(value);
  factory RemixDialogStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixDialogStyler().borderRadius(value);
  factory RemixDialogStyler.elevation(ElevationShadow value) =>
      RemixDialogStyler().elevation(value);
  factory RemixDialogStyler.shadow(BoxShadowMix value) =>
      RemixDialogStyler().shadow(value);
  factory RemixDialogStyler.shadows(List<BoxShadowMix> value) =>
      RemixDialogStyler().shadows(value);
  factory RemixDialogStyler.width(double value) =>
      RemixDialogStyler().width(value);
  factory RemixDialogStyler.height(double value) =>
      RemixDialogStyler().height(value);
  factory RemixDialogStyler.size(double width, double height) =>
      RemixDialogStyler().size(width, height);
  factory RemixDialogStyler.minWidth(double value) =>
      RemixDialogStyler().minWidth(value);
  factory RemixDialogStyler.maxWidth(double value) =>
      RemixDialogStyler().maxWidth(value);
  factory RemixDialogStyler.minHeight(double value) =>
      RemixDialogStyler().minHeight(value);
  factory RemixDialogStyler.maxHeight(double value) =>
      RemixDialogStyler().maxHeight(value);
  factory RemixDialogStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixDialogStyler().scale(scale, alignment: alignment);
  factory RemixDialogStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixDialogStyler().rotate(radians, alignment: alignment);
  factory RemixDialogStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixDialogStyler().translate(x, y, z);
  factory RemixDialogStyler.skew(double skewX, double skewY) =>
      RemixDialogStyler().skew(skewX, skewY);
  factory RemixDialogStyler.textStyle(TextStyler value) =>
      RemixDialogStyler().textStyle(value);
  factory RemixDialogStyler.image(DecorationImageMix value) =>
      RemixDialogStyler().image(value);
  factory RemixDialogStyler.shape(ShapeBorderMix value) =>
      RemixDialogStyler().shape(value);
  factory RemixDialogStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixDialogStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixDialogStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixDialogStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixDialogStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixDialogStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixDialogStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixDialogStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixDialogStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixDialogStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixDialogStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixDialogStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixDialogStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixDialogStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixDialogStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixDialogStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixDialogStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixDialogStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixDialogStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixDialogStyler().transform(value, alignment: alignment);

  RemixDialogStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixDialogStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixDialogStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixDialogStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixDialogStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixDialogStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixDialogStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixDialogStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixDialogStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixDialogStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixDialogStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixDialogStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixDialogStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixDialogStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixDialogStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixDialogStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixDialogStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixDialogStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixDialogStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixDialogStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixDialogStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixDialogStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixDialogStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixDialogStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixDialogStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixDialogStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixDialogStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixDialogStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixDialogStyler backgroundImage(
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

  RemixDialogStyler backgroundImageUrl(
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

  RemixDialogStyler backgroundImageAsset(
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

  RemixDialogStyler linearGradient({
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

  RemixDialogStyler radialGradient({
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

  RemixDialogStyler sweepGradient({
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

  RemixDialogStyler foregroundLinearGradient({
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

  RemixDialogStyler foregroundRadialGradient({
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

  RemixDialogStyler foregroundSweepGradient({
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

  RemixDialogStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixDialogStyler container(BoxStyler value) {
    return merge(RemixDialogStyler(container: value));
  }

  /// Sets the surface.
  RemixDialogStyler surface(RemixSurfaceLayerMix value) {
    return merge(RemixDialogStyler(surface: value));
  }

  /// Sets the title.
  RemixDialogStyler title(TextStyler value) {
    return merge(RemixDialogStyler(title: value));
  }

  /// Sets the description.
  RemixDialogStyler description(TextStyler value) {
    return merge(RemixDialogStyler(description: value));
  }

  /// Sets the actions.
  RemixDialogStyler actions(FlexBoxStyler value) {
    return merge(RemixDialogStyler(actions: value));
  }

  /// Sets the animation configuration.
  @override
  RemixDialogStyler animate(AnimationConfig value) {
    return merge(RemixDialogStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixDialogStyler variants(List<VariantStyle<RemixDialogSpec>> value) {
    return merge(RemixDialogStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixDialogStyler wrap(WidgetModifierConfig value) {
    return merge(RemixDialogStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixDialogStyler modifier(WidgetModifierConfig value) {
    return merge(RemixDialogStyler(modifier: value));
  }

  /// Merges with another [RemixDialogStyler].
  @override
  RemixDialogStyler merge(RemixDialogStyler? other) {
    return RemixDialogStyler.create(
      container: MixOps.merge($container, other?.$container),
      surface: MixOps.merge($surface, other?.$surface),
      title: MixOps.merge($title, other?.$title),
      description: MixOps.merge($description, other?.$description),
      actions: MixOps.merge($actions, other?.$actions),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixDialogSpec>] using [context].
  @override
  StyleSpec<RemixDialogSpec> resolve(BuildContext context) {
    final spec = RemixDialogSpec(
      container: MixOps.resolve(context, $container),
      surface: MixOps.resolve(context, $surface),
      title: MixOps.resolve(context, $title),
      description: MixOps.resolve(context, $description),
      actions: MixOps.resolve(context, $actions),
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
      ..add(DiagnosticsProperty('surface', $surface))
      ..add(DiagnosticsProperty('title', $title))
      ..add(DiagnosticsProperty('description', $description))
      ..add(DiagnosticsProperty('actions', $actions));
  }

  @override
  List<Object?> get props => [
    $container,
    $surface,
    $title,
    $description,
    $actions,
    $animation,
    $modifier,
    $variants,
  ];
}
