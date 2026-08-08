// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialog.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$DialogSpec implements Spec<DialogSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  RemixBoxEffectsSpec? get containerEffects;
  StyleSpec<TextSpec> get title;
  StyleSpec<TextSpec> get description;
  StyleSpec<FlexBoxSpec> get actions;

  @override
  Type get type => DialogSpec;

  @override
  DialogSpec copyWith({
    StyleSpec<BoxSpec>? container,
    RemixBoxEffectsSpec? containerEffects,
    StyleSpec<TextSpec>? title,
    StyleSpec<TextSpec>? description,
    StyleSpec<FlexBoxSpec>? actions,
  }) {
    return DialogSpec(
      container: container ?? this.container,
      containerEffects: containerEffects ?? this.containerEffects,
      title: title ?? this.title,
      description: description ?? this.description,
      actions: actions ?? this.actions,
    );
  }

  @override
  DialogSpec lerp(DialogSpec? other, double t) {
    return DialogSpec(
      container: container.lerp(other?.container, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
      title: title.lerp(other?.title, t),
      description: description.lerp(other?.description, t),
      actions: actions.lerp(other?.actions, t),
    );
  }

  @override
  List<Object?> get props => [
    container,
    containerEffects,
    title,
    description,
    actions,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DialogSpec &&
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
      ..add(DiagnosticsProperty('containerEffects', containerEffects))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('actions', actions));
  }
}

@Deprecated(
  'Rename to `_\$DialogSpec` and migrate the class declaration to `class DialogSpec with _\$DialogSpec`. The `_\$DialogSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$DialogSpecMethods = _$DialogSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class DialogStyler extends MixStyler<DialogStyler, DialogSpec>
    with RemixBoxStylerMixin<DialogStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;
  final Prop<StyleSpec<TextSpec>>? $title;
  final Prop<StyleSpec<TextSpec>>? $description;
  final Prop<StyleSpec<FlexBoxSpec>>? $actions;

  const DialogStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    Prop<StyleSpec<TextSpec>>? title,
    Prop<StyleSpec<TextSpec>>? description,
    Prop<StyleSpec<FlexBoxSpec>>? actions,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $containerEffects = containerEffects,
       $title = title,
       $description = description,
       $actions = actions;

  DialogStyler({
    BoxStyler? container,
    RemixBoxEffectsMix? containerEffects,
    TextStyler? title,
    TextStyler? description,
    FlexBoxStyler? actions,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<DialogSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         containerEffects: Prop.maybeMix(containerEffects),
         title: Prop.maybeMix(title),
         description: Prop.maybeMix(description),
         actions: Prop.maybeMix(actions),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory DialogStyler.container(BoxStyler value) =>
      DialogStyler().container(value);
  factory DialogStyler.containerEffects(RemixBoxEffectsMix value) =>
      DialogStyler().containerEffects(value);
  factory DialogStyler.title(TextStyler value) => DialogStyler().title(value);
  factory DialogStyler.description(TextStyler value) =>
      DialogStyler().description(value);
  factory DialogStyler.actions(FlexBoxStyler value) =>
      DialogStyler().actions(value);
  factory DialogStyler.alignment(AlignmentGeometry value) =>
      DialogStyler().alignment(value);
  factory DialogStyler.padding(EdgeInsetsGeometryMix value) =>
      DialogStyler().padding(value);
  factory DialogStyler.margin(EdgeInsetsGeometryMix value) =>
      DialogStyler().margin(value);
  factory DialogStyler.constraints(BoxConstraintsMix value) =>
      DialogStyler().constraints(value);
  factory DialogStyler.decoration(DecorationMix value) =>
      DialogStyler().decoration(value);
  factory DialogStyler.foregroundDecoration(DecorationMix value) =>
      DialogStyler().foregroundDecoration(value);
  factory DialogStyler.clipBehavior(Clip value) =>
      DialogStyler().clipBehavior(value);
  factory DialogStyler.color(Color value) => DialogStyler().color(value);
  factory DialogStyler.gradient(GradientMix value) =>
      DialogStyler().gradient(value);
  factory DialogStyler.border(BoxBorderMix value) =>
      DialogStyler().border(value);
  factory DialogStyler.borderRadius(BorderRadiusGeometryMix value) =>
      DialogStyler().borderRadius(value);
  factory DialogStyler.elevation(ElevationShadow value) =>
      DialogStyler().elevation(value);
  factory DialogStyler.shadow(BoxShadowMix value) =>
      DialogStyler().shadow(value);
  factory DialogStyler.shadows(List<BoxShadowMix> value) =>
      DialogStyler().shadows(value);
  factory DialogStyler.width(double value) => DialogStyler().width(value);
  factory DialogStyler.height(double value) => DialogStyler().height(value);
  factory DialogStyler.size(double width, double height) =>
      DialogStyler().size(width, height);
  factory DialogStyler.minWidth(double value) => DialogStyler().minWidth(value);
  factory DialogStyler.maxWidth(double value) => DialogStyler().maxWidth(value);
  factory DialogStyler.minHeight(double value) =>
      DialogStyler().minHeight(value);
  factory DialogStyler.maxHeight(double value) =>
      DialogStyler().maxHeight(value);
  factory DialogStyler.scale(double scale, {Alignment alignment = .center}) =>
      DialogStyler().scale(scale, alignment: alignment);
  factory DialogStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => DialogStyler().rotate(radians, alignment: alignment);
  factory DialogStyler.translate(double x, double y, [double z = 0.0]) =>
      DialogStyler().translate(x, y, z);
  factory DialogStyler.skew(double skewX, double skewY) =>
      DialogStyler().skew(skewX, skewY);
  factory DialogStyler.textStyle(TextStyler value) =>
      DialogStyler().textStyle(value);
  factory DialogStyler.image(DecorationImageMix value) =>
      DialogStyler().image(value);
  factory DialogStyler.shape(ShapeBorderMix value) =>
      DialogStyler().shape(value);
  factory DialogStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DialogStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DialogStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DialogStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DialogStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DialogStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DialogStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => DialogStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory DialogStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => DialogStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory DialogStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => DialogStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory DialogStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => DialogStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory DialogStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => DialogStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory DialogStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => DialogStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory DialogStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => DialogStyler().transform(value, alignment: alignment);

  DialogStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  DialogStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  DialogStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  DialogStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  DialogStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  DialogStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  DialogStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  DialogStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  DialogStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  DialogStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  DialogStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  DialogStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  DialogStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  DialogStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  DialogStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  DialogStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  DialogStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  DialogStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  DialogStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  DialogStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  DialogStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  DialogStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  DialogStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  DialogStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  DialogStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  DialogStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  DialogStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  DialogStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  DialogStyler backgroundImage(
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

  DialogStyler backgroundImageUrl(
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

  DialogStyler backgroundImageAsset(
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

  DialogStyler linearGradient({
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

  DialogStyler radialGradient({
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

  DialogStyler sweepGradient({
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

  DialogStyler foregroundLinearGradient({
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

  DialogStyler foregroundRadialGradient({
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

  DialogStyler foregroundSweepGradient({
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

  DialogStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  DialogStyler container(BoxStyler value) {
    return merge(DialogStyler(container: value));
  }

  /// Sets the containerEffects.
  DialogStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(DialogStyler(containerEffects: value));
  }

  /// Sets the title.
  DialogStyler title(TextStyler value) {
    return merge(DialogStyler(title: value));
  }

  /// Sets the description.
  DialogStyler description(TextStyler value) {
    return merge(DialogStyler(description: value));
  }

  /// Sets the actions.
  DialogStyler actions(FlexBoxStyler value) {
    return merge(DialogStyler(actions: value));
  }

  /// Sets the animation configuration.
  @override
  DialogStyler animate(AnimationConfig value) {
    return merge(DialogStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  DialogStyler variants(List<VariantStyle<DialogSpec>> value) {
    return merge(DialogStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  DialogStyler wrap(WidgetModifierConfig value) {
    return merge(DialogStyler(modifier: value));
  }

  /// Sets the widget modifier.
  DialogStyler modifier(WidgetModifierConfig value) {
    return merge(DialogStyler(modifier: value));
  }

  /// Merges with another [DialogStyler].
  @override
  DialogStyler merge(DialogStyler? other) {
    return DialogStyler.create(
      container: MixOps.merge($container, other?.$container),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      title: MixOps.merge($title, other?.$title),
      description: MixOps.merge($description, other?.$description),
      actions: MixOps.merge($actions, other?.$actions),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<DialogSpec>] using [context].
  @override
  StyleSpec<DialogSpec> resolve(BuildContext context) {
    final spec = DialogSpec(
      container: MixOps.resolve(context, $container),
      containerEffects: MixOps.resolve(context, $containerEffects),
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
      ..add(DiagnosticsProperty('containerEffects', $containerEffects))
      ..add(DiagnosticsProperty('title', $title))
      ..add(DiagnosticsProperty('description', $description))
      ..add(DiagnosticsProperty('actions', $actions));
  }

  @override
  List<Object?> get props => [
    $container,
    $containerEffects,
    $title,
    $description,
    $actions,
    $animation,
    $modifier,
    $variants,
  ];
}
