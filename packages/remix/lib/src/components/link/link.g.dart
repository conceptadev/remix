// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$LinkSpec implements Spec<LinkSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<TextSpec> get label;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => LinkSpec;

  @override
  LinkSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return LinkSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  LinkSpec lerp(LinkSpec? other, double t) {
    return LinkSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [container, label, containerEffects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LinkSpec &&
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
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$LinkSpec` and migrate the class declaration to `class LinkSpec with _\$LinkSpec`. The `_\$LinkSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$LinkSpecMethods = _$LinkSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class LinkStyler extends MixStyler<LinkStyler, LinkSpec>
    with RemixBoxStylerMixin<LinkStyler>, LabelStyleMixin<LinkStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const LinkStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $containerEffects = containerEffects;

  LinkStyler({
    BoxStyler? container,
    TextStyler? label,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<LinkSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory LinkStyler.container(BoxStyler value) =>
      LinkStyler().container(value);
  factory LinkStyler.label(TextStyler value) => LinkStyler().label(value);
  factory LinkStyler.containerEffects(RemixBoxEffectsMix value) =>
      LinkStyler().containerEffects(value);
  factory LinkStyler.alignment(AlignmentGeometry value) =>
      LinkStyler().alignment(value);
  factory LinkStyler.padding(EdgeInsetsGeometryMix value) =>
      LinkStyler().padding(value);
  factory LinkStyler.margin(EdgeInsetsGeometryMix value) =>
      LinkStyler().margin(value);
  factory LinkStyler.constraints(BoxConstraintsMix value) =>
      LinkStyler().constraints(value);
  factory LinkStyler.decoration(DecorationMix value) =>
      LinkStyler().decoration(value);
  factory LinkStyler.foregroundDecoration(DecorationMix value) =>
      LinkStyler().foregroundDecoration(value);
  factory LinkStyler.clipBehavior(Clip value) =>
      LinkStyler().clipBehavior(value);
  factory LinkStyler.color(Color value) => LinkStyler().color(value);
  factory LinkStyler.gradient(GradientMix value) =>
      LinkStyler().gradient(value);
  factory LinkStyler.border(BoxBorderMix value) => LinkStyler().border(value);
  factory LinkStyler.borderRadius(BorderRadiusGeometryMix value) =>
      LinkStyler().borderRadius(value);
  factory LinkStyler.elevation(ElevationShadow value) =>
      LinkStyler().elevation(value);
  factory LinkStyler.shadow(BoxShadowMix value) => LinkStyler().shadow(value);
  factory LinkStyler.shadows(List<BoxShadowMix> value) =>
      LinkStyler().shadows(value);
  factory LinkStyler.width(double value) => LinkStyler().width(value);
  factory LinkStyler.height(double value) => LinkStyler().height(value);
  factory LinkStyler.size(double width, double height) =>
      LinkStyler().size(width, height);
  factory LinkStyler.minWidth(double value) => LinkStyler().minWidth(value);
  factory LinkStyler.maxWidth(double value) => LinkStyler().maxWidth(value);
  factory LinkStyler.minHeight(double value) => LinkStyler().minHeight(value);
  factory LinkStyler.maxHeight(double value) => LinkStyler().maxHeight(value);
  factory LinkStyler.scale(double scale, {Alignment alignment = .center}) =>
      LinkStyler().scale(scale, alignment: alignment);
  factory LinkStyler.rotate(double radians, {Alignment alignment = .center}) =>
      LinkStyler().rotate(radians, alignment: alignment);
  factory LinkStyler.translate(double x, double y, [double z = 0.0]) =>
      LinkStyler().translate(x, y, z);
  factory LinkStyler.skew(double skewX, double skewY) =>
      LinkStyler().skew(skewX, skewY);
  factory LinkStyler.textStyle(TextStyler value) =>
      LinkStyler().textStyle(value);
  factory LinkStyler.image(DecorationImageMix value) =>
      LinkStyler().image(value);
  factory LinkStyler.shape(ShapeBorderMix value) => LinkStyler().shape(value);
  factory LinkStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => LinkStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory LinkStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => LinkStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory LinkStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => LinkStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory LinkStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => LinkStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory LinkStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => LinkStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory LinkStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => LinkStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory LinkStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => LinkStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory LinkStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => LinkStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory LinkStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => LinkStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory LinkStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => LinkStyler().transform(value, alignment: alignment);

  LinkStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  LinkStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  LinkStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  LinkStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  LinkStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  LinkStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  LinkStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  LinkStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  LinkStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  LinkStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  LinkStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  LinkStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  LinkStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  LinkStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  LinkStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  LinkStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  LinkStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  LinkStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  LinkStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  LinkStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  LinkStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  LinkStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  LinkStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  LinkStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  LinkStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  LinkStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  LinkStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  LinkStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  LinkStyler backgroundImage(
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

  LinkStyler backgroundImageUrl(
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

  LinkStyler backgroundImageAsset(
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

  LinkStyler linearGradient({
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

  LinkStyler radialGradient({
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

  LinkStyler sweepGradient({
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

  LinkStyler foregroundLinearGradient({
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

  LinkStyler foregroundRadialGradient({
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

  LinkStyler foregroundSweepGradient({
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

  LinkStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  LinkStyler container(BoxStyler value) {
    return merge(LinkStyler(container: value));
  }

  /// Sets the label.
  @override
  LinkStyler label(TextStyler value) {
    return merge(LinkStyler(label: value));
  }

  /// Sets the containerEffects.
  LinkStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(LinkStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  LinkStyler animate(AnimationConfig value) {
    return merge(LinkStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  LinkStyler variants(List<VariantStyle<LinkSpec>> value) {
    return merge(LinkStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  LinkStyler wrap(WidgetModifierConfig value) {
    return merge(LinkStyler(modifier: value));
  }

  /// Sets the widget modifier.
  LinkStyler modifier(WidgetModifierConfig value) {
    return merge(LinkStyler(modifier: value));
  }

  RemixLink call({
    Key? key,
    String? label,
    Widget? child,
    VoidCallback? onPressed,
    bool enabled = true,
    Uri? linkUrl,
    FocusNode? focusNode,
    bool autofocus = false,
    bool enableFeedback = true,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    String? semanticLabel,
    String? semanticHint,
    bool excludeSemantics = false,
  }) {
    return RemixLink(
      key: key,
      style: this,
      label: label,
      child: child,
      onPressed: onPressed,
      enabled: enabled,
      linkUrl: linkUrl,
      focusNode: focusNode,
      autofocus: autofocus,
      enableFeedback: enableFeedback,
      mouseCursor: mouseCursor,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
    );
  }

  /// Merges with another [LinkStyler].
  @override
  LinkStyler merge(LinkStyler? other) {
    return LinkStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<LinkSpec>] using [context].
  @override
  StyleSpec<LinkSpec> resolve(BuildContext context) {
    final spec = LinkSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
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
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
