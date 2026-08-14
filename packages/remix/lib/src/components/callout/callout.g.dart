// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callout.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$CalloutSpec implements Spec<CalloutSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get text;
  StyleSpec<IconSpec> get icon;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => CalloutSpec;

  @override
  CalloutSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    StyleSpec<IconSpec>? icon,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return CalloutSpec(
      container: container ?? this.container,
      text: text ?? this.text,
      icon: icon ?? this.icon,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  CalloutSpec lerp(CalloutSpec? other, double t) {
    return CalloutSpec(
      container: container.lerp(other?.container, t),
      text: text.lerp(other?.text, t),
      icon: icon.lerp(other?.icon, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [container, text, icon, containerEffects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CalloutSpec &&
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
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$CalloutSpec` and migrate the class declaration to `class CalloutSpec with _\$CalloutSpec`. The `_\$CalloutSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$CalloutSpecMethods = _$CalloutSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class CalloutStyler extends MixStyler<CalloutStyler, CalloutSpec>
    with RemixBoxStylerMixin<CalloutStyler>, IconStyleMixin<CalloutStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $text;
  final Prop<StyleSpec<IconSpec>>? $icon;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const CalloutStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? text,
    Prop<StyleSpec<IconSpec>>? icon,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $text = text,
       $icon = icon,
       $containerEffects = containerEffects;

  CalloutStyler({
    FlexBoxStyler? container,
    TextStyler? text,
    IconStyler? icon,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<CalloutSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         text: Prop.maybeMix(text),
         icon: Prop.maybeMix(icon),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory CalloutStyler.container(FlexBoxStyler value) =>
      CalloutStyler().container(value);
  factory CalloutStyler.text(TextStyler value) => CalloutStyler().text(value);
  factory CalloutStyler.icon(IconStyler value) => CalloutStyler().icon(value);
  factory CalloutStyler.containerEffects(RemixBoxEffectsMix value) =>
      CalloutStyler().containerEffects(value);
  factory CalloutStyler.color(Color value) => CalloutStyler().color(value);
  factory CalloutStyler.gradient(GradientMix value) =>
      CalloutStyler().gradient(value);
  factory CalloutStyler.border(BoxBorderMix value) =>
      CalloutStyler().border(value);
  factory CalloutStyler.borderRadius(BorderRadiusGeometryMix value) =>
      CalloutStyler().borderRadius(value);
  factory CalloutStyler.elevation(ElevationShadow value) =>
      CalloutStyler().elevation(value);
  factory CalloutStyler.shadow(BoxShadowMix value) =>
      CalloutStyler().shadow(value);
  factory CalloutStyler.shadows(List<BoxShadowMix> value) =>
      CalloutStyler().shadows(value);
  factory CalloutStyler.width(double value) => CalloutStyler().width(value);
  factory CalloutStyler.height(double value) => CalloutStyler().height(value);
  factory CalloutStyler.size(double width, double height) =>
      CalloutStyler().size(width, height);
  factory CalloutStyler.minWidth(double value) =>
      CalloutStyler().minWidth(value);
  factory CalloutStyler.maxWidth(double value) =>
      CalloutStyler().maxWidth(value);
  factory CalloutStyler.minHeight(double value) =>
      CalloutStyler().minHeight(value);
  factory CalloutStyler.maxHeight(double value) =>
      CalloutStyler().maxHeight(value);
  factory CalloutStyler.scale(double scale, {Alignment alignment = .center}) =>
      CalloutStyler().scale(scale, alignment: alignment);
  factory CalloutStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => CalloutStyler().rotate(radians, alignment: alignment);
  factory CalloutStyler.translate(double x, double y, [double z = 0.0]) =>
      CalloutStyler().translate(x, y, z);
  factory CalloutStyler.skew(double skewX, double skewY) =>
      CalloutStyler().skew(skewX, skewY);
  factory CalloutStyler.textStyle(TextStyler value) =>
      CalloutStyler().textStyle(value);
  factory CalloutStyler.image(DecorationImageMix value) =>
      CalloutStyler().image(value);
  factory CalloutStyler.shape(ShapeBorderMix value) =>
      CalloutStyler().shape(value);
  factory CalloutStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => CalloutStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory CalloutStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => CalloutStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory CalloutStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => CalloutStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory CalloutStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => CalloutStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory CalloutStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => CalloutStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory CalloutStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => CalloutStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory CalloutStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => CalloutStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory CalloutStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => CalloutStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory CalloutStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => CalloutStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory CalloutStyler.row() => CalloutStyler().row();
  factory CalloutStyler.column() => CalloutStyler().column();
  factory CalloutStyler.alignment(AlignmentGeometry value) =>
      CalloutStyler().alignment(value);
  factory CalloutStyler.padding(EdgeInsetsGeometryMix value) =>
      CalloutStyler().padding(value);
  factory CalloutStyler.margin(EdgeInsetsGeometryMix value) =>
      CalloutStyler().margin(value);
  factory CalloutStyler.constraints(BoxConstraintsMix value) =>
      CalloutStyler().constraints(value);
  factory CalloutStyler.decoration(DecorationMix value) =>
      CalloutStyler().decoration(value);
  factory CalloutStyler.foregroundDecoration(DecorationMix value) =>
      CalloutStyler().foregroundDecoration(value);
  factory CalloutStyler.clipBehavior(Clip value) =>
      CalloutStyler().clipBehavior(value);
  factory CalloutStyler.direction(Axis value) =>
      CalloutStyler().direction(value);
  factory CalloutStyler.mainAxisAlignment(MainAxisAlignment value) =>
      CalloutStyler().mainAxisAlignment(value);
  factory CalloutStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      CalloutStyler().crossAxisAlignment(value);
  factory CalloutStyler.mainAxisSize(MainAxisSize value) =>
      CalloutStyler().mainAxisSize(value);
  factory CalloutStyler.spacing(double value) => CalloutStyler().spacing(value);
  factory CalloutStyler.verticalDirection(VerticalDirection value) =>
      CalloutStyler().verticalDirection(value);
  factory CalloutStyler.textDirection(TextDirection value) =>
      CalloutStyler().textDirection(value);
  factory CalloutStyler.textBaseline(TextBaseline value) =>
      CalloutStyler().textBaseline(value);
  factory CalloutStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => CalloutStyler().transform(value, alignment: alignment);

  CalloutStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  CalloutStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  CalloutStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  CalloutStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  CalloutStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  CalloutStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  CalloutStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  CalloutStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  CalloutStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  CalloutStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  CalloutStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  CalloutStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  CalloutStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  CalloutStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  CalloutStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  CalloutStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  CalloutStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  CalloutStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  CalloutStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  CalloutStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  CalloutStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  CalloutStyler backgroundImage(
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

  CalloutStyler backgroundImageUrl(
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

  CalloutStyler backgroundImageAsset(
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

  CalloutStyler linearGradient({
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

  CalloutStyler radialGradient({
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

  CalloutStyler sweepGradient({
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

  CalloutStyler foregroundLinearGradient({
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

  CalloutStyler foregroundRadialGradient({
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

  CalloutStyler foregroundSweepGradient({
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

  CalloutStyler row() {
    return container(FlexBoxStyler().row());
  }

  CalloutStyler column() {
    return container(FlexBoxStyler().column());
  }

  CalloutStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  CalloutStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  CalloutStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  CalloutStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  CalloutStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  CalloutStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  CalloutStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  CalloutStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  CalloutStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  CalloutStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  CalloutStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  CalloutStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  CalloutStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  CalloutStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  CalloutStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  CalloutStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  CalloutStyler container(FlexBoxStyler value) {
    return merge(CalloutStyler(container: value));
  }

  /// Sets the text.
  CalloutStyler text(TextStyler value) {
    return merge(CalloutStyler(text: value));
  }

  /// Sets the icon.
  @override
  CalloutStyler icon(IconStyler value) {
    return merge(CalloutStyler(icon: value));
  }

  /// Sets the containerEffects.
  CalloutStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(CalloutStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  CalloutStyler animate(AnimationConfig value) {
    return merge(CalloutStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  CalloutStyler variants(List<VariantStyle<CalloutSpec>> value) {
    return merge(CalloutStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  CalloutStyler wrap(WidgetModifierConfig value) {
    return merge(CalloutStyler(modifier: value));
  }

  /// Sets the widget modifier.
  CalloutStyler modifier(WidgetModifierConfig value) {
    return merge(CalloutStyler(modifier: value));
  }

  RemixCallout call({Key? key, String? text, IconData? icon, Widget? child}) {
    return RemixCallout(
      key: key,
      style: this,
      text: text,
      icon: icon,
      child: child,
    );
  }

  /// Merges with another [CalloutStyler].
  @override
  CalloutStyler merge(CalloutStyler? other) {
    return CalloutStyler.create(
      container: MixOps.merge($container, other?.$container),
      text: MixOps.merge($text, other?.$text),
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

  /// Resolves to [StyleSpec<CalloutSpec>] using [context].
  @override
  StyleSpec<CalloutSpec> resolve(BuildContext context) {
    final spec = CalloutSpec(
      container: MixOps.resolve(context, $container),
      text: MixOps.resolve(context, $text),
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
      ..add(DiagnosticsProperty('text', $text))
      ..add(DiagnosticsProperty('icon', $icon))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $text,
    $icon,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
