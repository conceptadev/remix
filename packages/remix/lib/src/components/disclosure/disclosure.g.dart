// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disclosure.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$DisclosureSpec implements Spec<DisclosureSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  RemixBoxEffectsSpec? get containerEffects;
  StyleSpec<BoxSpec> get trigger;
  StyleSpec<BoxSpec> get content;

  @override
  Type get type => DisclosureSpec;

  @override
  DisclosureSpec copyWith({
    StyleSpec<BoxSpec>? container,
    RemixBoxEffectsSpec? containerEffects,
    StyleSpec<BoxSpec>? trigger,
    StyleSpec<BoxSpec>? content,
  }) {
    return DisclosureSpec(
      container: container ?? this.container,
      containerEffects: containerEffects ?? this.containerEffects,
      trigger: trigger ?? this.trigger,
      content: content ?? this.content,
    );
  }

  @override
  DisclosureSpec lerp(DisclosureSpec? other, double t) {
    return DisclosureSpec(
      container: container.lerp(other?.container, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
      trigger: trigger.lerp(other?.trigger, t),
      content: content.lerp(other?.content, t),
    );
  }

  @override
  List<Object?> get props => [container, containerEffects, trigger, content];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DisclosureSpec &&
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
      ..add(DiagnosticsProperty('trigger', trigger))
      ..add(DiagnosticsProperty('content', content));
  }
}

@Deprecated(
  'Rename to `_\$DisclosureSpec` and migrate the class declaration to `class DisclosureSpec with _\$DisclosureSpec`. The `_\$DisclosureSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$DisclosureSpecMethods = _$DisclosureSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class DisclosureStyler extends MixStyler<DisclosureStyler, DisclosureSpec>
    with RemixBoxStylerMixin<DisclosureStyler>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;
  final Prop<StyleSpec<BoxSpec>>? $trigger;
  final Prop<StyleSpec<BoxSpec>>? $content;

  const DisclosureStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    Prop<StyleSpec<BoxSpec>>? trigger,
    Prop<StyleSpec<BoxSpec>>? content,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $containerEffects = containerEffects,
       $trigger = trigger,
       $content = content;

  DisclosureStyler({
    BoxStyler? container,
    RemixBoxEffectsMix? containerEffects,
    BoxStyler? trigger,
    BoxStyler? content,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<DisclosureSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         containerEffects: Prop.maybeMix(containerEffects),
         trigger: Prop.maybeMix(trigger),
         content: Prop.maybeMix(content),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory DisclosureStyler.container(BoxStyler value) =>
      DisclosureStyler().container(value);
  factory DisclosureStyler.containerEffects(RemixBoxEffectsMix value) =>
      DisclosureStyler().containerEffects(value);
  factory DisclosureStyler.trigger(BoxStyler value) =>
      DisclosureStyler().trigger(value);
  factory DisclosureStyler.content(BoxStyler value) =>
      DisclosureStyler().content(value);
  factory DisclosureStyler.alignment(AlignmentGeometry value) =>
      DisclosureStyler().alignment(value);
  factory DisclosureStyler.padding(EdgeInsetsGeometryMix value) =>
      DisclosureStyler().padding(value);
  factory DisclosureStyler.margin(EdgeInsetsGeometryMix value) =>
      DisclosureStyler().margin(value);
  factory DisclosureStyler.constraints(BoxConstraintsMix value) =>
      DisclosureStyler().constraints(value);
  factory DisclosureStyler.decoration(DecorationMix value) =>
      DisclosureStyler().decoration(value);
  factory DisclosureStyler.foregroundDecoration(DecorationMix value) =>
      DisclosureStyler().foregroundDecoration(value);
  factory DisclosureStyler.clipBehavior(Clip value) =>
      DisclosureStyler().clipBehavior(value);
  factory DisclosureStyler.color(Color value) =>
      DisclosureStyler().color(value);
  factory DisclosureStyler.gradient(GradientMix value) =>
      DisclosureStyler().gradient(value);
  factory DisclosureStyler.border(BoxBorderMix value) =>
      DisclosureStyler().border(value);
  factory DisclosureStyler.borderRadius(BorderRadiusGeometryMix value) =>
      DisclosureStyler().borderRadius(value);
  factory DisclosureStyler.elevation(ElevationShadow value) =>
      DisclosureStyler().elevation(value);
  factory DisclosureStyler.shadow(BoxShadowMix value) =>
      DisclosureStyler().shadow(value);
  factory DisclosureStyler.shadows(List<BoxShadowMix> value) =>
      DisclosureStyler().shadows(value);
  factory DisclosureStyler.width(double value) =>
      DisclosureStyler().width(value);
  factory DisclosureStyler.height(double value) =>
      DisclosureStyler().height(value);
  factory DisclosureStyler.size(double width, double height) =>
      DisclosureStyler().size(width, height);
  factory DisclosureStyler.minWidth(double value) =>
      DisclosureStyler().minWidth(value);
  factory DisclosureStyler.maxWidth(double value) =>
      DisclosureStyler().maxWidth(value);
  factory DisclosureStyler.minHeight(double value) =>
      DisclosureStyler().minHeight(value);
  factory DisclosureStyler.maxHeight(double value) =>
      DisclosureStyler().maxHeight(value);
  factory DisclosureStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => DisclosureStyler().scale(scale, alignment: alignment);
  factory DisclosureStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => DisclosureStyler().rotate(radians, alignment: alignment);
  factory DisclosureStyler.translate(double x, double y, [double z = 0.0]) =>
      DisclosureStyler().translate(x, y, z);
  factory DisclosureStyler.skew(double skewX, double skewY) =>
      DisclosureStyler().skew(skewX, skewY);
  factory DisclosureStyler.textStyle(TextStyler value) =>
      DisclosureStyler().textStyle(value);
  factory DisclosureStyler.image(DecorationImageMix value) =>
      DisclosureStyler().image(value);
  factory DisclosureStyler.shape(ShapeBorderMix value) =>
      DisclosureStyler().shape(value);
  factory DisclosureStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DisclosureStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DisclosureStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DisclosureStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DisclosureStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => DisclosureStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory DisclosureStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => DisclosureStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory DisclosureStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => DisclosureStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory DisclosureStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => DisclosureStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory DisclosureStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => DisclosureStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory DisclosureStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => DisclosureStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory DisclosureStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => DisclosureStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory DisclosureStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => DisclosureStyler().transform(value, alignment: alignment);

  DisclosureStyler alignment(AlignmentGeometry value) {
    return trigger(BoxStyler().alignment(value));
  }

  DisclosureStyler padding(EdgeInsetsGeometryMix value) {
    return trigger(BoxStyler().padding(value));
  }

  DisclosureStyler margin(EdgeInsetsGeometryMix value) {
    return trigger(BoxStyler().margin(value));
  }

  DisclosureStyler constraints(BoxConstraintsMix value) {
    return trigger(BoxStyler().constraints(value));
  }

  DisclosureStyler decoration(DecorationMix value) {
    return trigger(BoxStyler().decoration(value));
  }

  DisclosureStyler foregroundDecoration(DecorationMix value) {
    return trigger(BoxStyler().foregroundDecoration(value));
  }

  DisclosureStyler clipBehavior(Clip value) {
    return trigger(BoxStyler().clipBehavior(value));
  }

  DisclosureStyler color(Color value) {
    return trigger(BoxStyler().color(value));
  }

  DisclosureStyler gradient(GradientMix value) {
    return trigger(BoxStyler().gradient(value));
  }

  DisclosureStyler border(BoxBorderMix value) {
    return trigger(BoxStyler().border(value));
  }

  DisclosureStyler borderRadius(BorderRadiusGeometryMix value) {
    return trigger(BoxStyler().borderRadius(value));
  }

  DisclosureStyler elevation(ElevationShadow value) {
    return trigger(BoxStyler().elevation(value));
  }

  DisclosureStyler shadow(BoxShadowMix value) {
    return trigger(BoxStyler().shadow(value));
  }

  DisclosureStyler shadows(List<BoxShadowMix> value) {
    return trigger(BoxStyler().shadows(value));
  }

  DisclosureStyler width(double value) {
    return trigger(BoxStyler().width(value));
  }

  DisclosureStyler height(double value) {
    return trigger(BoxStyler().height(value));
  }

  DisclosureStyler size(double width, double height) {
    return trigger(BoxStyler().size(width, height));
  }

  DisclosureStyler minWidth(double value) {
    return trigger(BoxStyler().minWidth(value));
  }

  DisclosureStyler maxWidth(double value) {
    return trigger(BoxStyler().maxWidth(value));
  }

  DisclosureStyler minHeight(double value) {
    return trigger(BoxStyler().minHeight(value));
  }

  DisclosureStyler maxHeight(double value) {
    return trigger(BoxStyler().maxHeight(value));
  }

  DisclosureStyler scale(double scale, {Alignment alignment = .center}) {
    return trigger(BoxStyler().scale(scale, alignment: alignment));
  }

  DisclosureStyler rotate(double radians, {Alignment alignment = .center}) {
    return trigger(BoxStyler().rotate(radians, alignment: alignment));
  }

  DisclosureStyler translate(double x, double y, [double z = 0.0]) {
    return trigger(BoxStyler().translate(x, y, z));
  }

  DisclosureStyler skew(double skewX, double skewY) {
    return trigger(BoxStyler().skew(skewX, skewY));
  }

  DisclosureStyler textStyle(TextStyler value) {
    return trigger(BoxStyler().textStyle(value));
  }

  DisclosureStyler image(DecorationImageMix value) {
    return trigger(BoxStyler().image(value));
  }

  DisclosureStyler shape(ShapeBorderMix value) {
    return trigger(BoxStyler().shape(value));
  }

  DisclosureStyler backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return trigger(
      BoxStyler().backgroundImage(
        image,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  DisclosureStyler backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return trigger(
      BoxStyler().backgroundImageUrl(
        url,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  DisclosureStyler backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return trigger(
      BoxStyler().backgroundImageAsset(
        path,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  DisclosureStyler linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return trigger(
      BoxStyler().linearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  DisclosureStyler radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return trigger(
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

  DisclosureStyler sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return trigger(
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

  DisclosureStyler foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return trigger(
      BoxStyler().foregroundLinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  DisclosureStyler foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return trigger(
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

  DisclosureStyler foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return trigger(
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

  DisclosureStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return trigger(BoxStyler().transform(value, alignment: alignment));
  }

  @override
  Set<String> get $stylerFieldNames => const {
    'container',
    'containerEffects',
    'trigger',
    'content',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the container.
  DisclosureStyler container(BoxStyler value) {
    return merge(DisclosureStyler(container: value));
  }

  /// Sets the containerEffects.
  DisclosureStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(DisclosureStyler(containerEffects: value));
  }

  /// Sets the trigger.
  DisclosureStyler trigger(BoxStyler value) {
    return merge(DisclosureStyler(trigger: value));
  }

  /// Sets the content.
  DisclosureStyler content(BoxStyler value) {
    return merge(DisclosureStyler(content: value));
  }

  /// Sets the animation configuration.
  @override
  DisclosureStyler animate(AnimationConfig value) {
    return merge(DisclosureStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  DisclosureStyler variants(List<VariantStyle<DisclosureSpec>> value) {
    return merge(DisclosureStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  DisclosureStyler wrap(WidgetModifierConfig value) {
    return merge(DisclosureStyler(modifier: value));
  }

  /// Sets the widget modifier.
  DisclosureStyler modifier(WidgetModifierConfig value) {
    return merge(DisclosureStyler(modifier: value));
  }

  RemixDisclosure call({
    Key? key,
    required Widget trigger,
    required Widget content,
    ValueWidgetBuilder<NakedDisclosureState>? triggerBuilder,
    bool? expanded,
    bool defaultExpanded = false,
    ValueChanged<bool>? onExpandedChanged,
    bool enabled = true,
    MouseCursor mouseCursor = SystemMouseCursors.click,
    bool enableFeedback = true,
    FocusNode? focusNode,
    bool autofocus = false,
    ValueChanged<bool>? onFocusChange,
    ValueChanged<bool>? onHoverChange,
    ValueChanged<bool>? onPressChange,
    String? semanticLabel,
    String? semanticHint,
    bool excludeSemantics = false,
    NakedDisclosureTransitionBuilder? transitionBuilder,
    AnimationStyle animationStyle = const AnimationStyle(
      curve: Curves.ease,
      duration: Duration(milliseconds: 200),
      reverseDuration: Duration(milliseconds: 200),
    ),
  }) {
    return RemixDisclosure(
      key: key,
      style: this,
      trigger: trigger,
      content: content,
      triggerBuilder: triggerBuilder,
      expanded: expanded,
      defaultExpanded: defaultExpanded,
      onExpandedChanged: onExpandedChanged,
      enabled: enabled,
      mouseCursor: mouseCursor,
      enableFeedback: enableFeedback,
      focusNode: focusNode,
      autofocus: autofocus,
      onFocusChange: onFocusChange,
      onHoverChange: onHoverChange,
      onPressChange: onPressChange,
      semanticLabel: semanticLabel,
      semanticHint: semanticHint,
      excludeSemantics: excludeSemantics,
      transitionBuilder: transitionBuilder,
      animationStyle: animationStyle,
    );
  }

  /// Merges with another [DisclosureStyler].
  @override
  DisclosureStyler merge(DisclosureStyler? other) {
    return DisclosureStyler.create(
      container: MixOps.merge($container, other?.$container),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      trigger: MixOps.merge($trigger, other?.$trigger),
      content: MixOps.merge($content, other?.$content),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<DisclosureSpec>] using [context].
  @override
  StyleSpec<DisclosureSpec> resolve(BuildContext context) {
    final spec = DisclosureSpec(
      container: MixOps.resolve(context, $container),
      containerEffects: MixOps.resolve(context, $containerEffects),
      trigger: MixOps.resolve(context, $trigger),
      content: MixOps.resolve(context, $content),
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
      ..add(DiagnosticsProperty('trigger', $trigger))
      ..add(DiagnosticsProperty('content', $content));
  }

  @override
  List<Object?> get props => [
    $container,
    $containerEffects,
    $trigger,
    $content,
    $animation,
    $modifier,
    $variants,
  ];
}
