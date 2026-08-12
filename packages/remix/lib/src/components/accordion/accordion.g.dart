// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accordion.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$AccordionSpec implements Spec<AccordionSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  RemixBoxEffectsSpec? get containerEffects;
  StyleSpec<FlexBoxSpec> get trigger;
  StyleSpec<IconSpec> get leadingIcon;
  StyleSpec<TextSpec> get title;
  StyleSpec<IconSpec> get trailingIcon;
  StyleSpec<BoxSpec> get content;

  @override
  Type get type => AccordionSpec;

  @override
  AccordionSpec copyWith({
    StyleSpec<BoxSpec>? container,
    RemixBoxEffectsSpec? containerEffects,
    StyleSpec<FlexBoxSpec>? trigger,
    StyleSpec<IconSpec>? leadingIcon,
    StyleSpec<TextSpec>? title,
    StyleSpec<IconSpec>? trailingIcon,
    StyleSpec<BoxSpec>? content,
  }) {
    return AccordionSpec(
      container: container ?? this.container,
      containerEffects: containerEffects ?? this.containerEffects,
      trigger: trigger ?? this.trigger,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      title: title ?? this.title,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      content: content ?? this.content,
    );
  }

  @override
  AccordionSpec lerp(AccordionSpec? other, double t) {
    return AccordionSpec(
      container: container.lerp(other?.container, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
      trigger: trigger.lerp(other?.trigger, t),
      leadingIcon: leadingIcon.lerp(other?.leadingIcon, t),
      title: title.lerp(other?.title, t),
      trailingIcon: trailingIcon.lerp(other?.trailingIcon, t),
      content: content.lerp(other?.content, t),
    );
  }

  @override
  List<Object?> get props => [
    container,
    containerEffects,
    trigger,
    leadingIcon,
    title,
    trailingIcon,
    content,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AccordionSpec &&
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
      ..add(DiagnosticsProperty('leadingIcon', leadingIcon))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('trailingIcon', trailingIcon))
      ..add(DiagnosticsProperty('content', content));
  }
}

@Deprecated(
  'Rename to `_\$AccordionSpec` and migrate the class declaration to `class AccordionSpec with _\$AccordionSpec`. The `_\$AccordionSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$AccordionSpecMethods = _$AccordionSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class AccordionStyler extends MixStyler<AccordionStyler, AccordionSpec>
    with RemixBoxStylerMixin<AccordionStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;
  final Prop<StyleSpec<FlexBoxSpec>>? $trigger;
  final Prop<StyleSpec<IconSpec>>? $leadingIcon;
  final Prop<StyleSpec<TextSpec>>? $title;
  final Prop<StyleSpec<IconSpec>>? $trailingIcon;
  final Prop<StyleSpec<BoxSpec>>? $content;

  const AccordionStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    Prop<StyleSpec<FlexBoxSpec>>? trigger,
    Prop<StyleSpec<IconSpec>>? leadingIcon,
    Prop<StyleSpec<TextSpec>>? title,
    Prop<StyleSpec<IconSpec>>? trailingIcon,
    Prop<StyleSpec<BoxSpec>>? content,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $containerEffects = containerEffects,
       $trigger = trigger,
       $leadingIcon = leadingIcon,
       $title = title,
       $trailingIcon = trailingIcon,
       $content = content;

  AccordionStyler({
    BoxStyler? container,
    RemixBoxEffectsMix? containerEffects,
    FlexBoxStyler? trigger,
    IconStyler? leadingIcon,
    TextStyler? title,
    IconStyler? trailingIcon,
    BoxStyler? content,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<AccordionSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         containerEffects: Prop.maybeMix(containerEffects),
         trigger: Prop.maybeMix(trigger),
         leadingIcon: Prop.maybeMix(leadingIcon),
         title: Prop.maybeMix(title),
         trailingIcon: Prop.maybeMix(trailingIcon),
         content: Prop.maybeMix(content),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory AccordionStyler.container(BoxStyler value) =>
      AccordionStyler().container(value);
  factory AccordionStyler.containerEffects(RemixBoxEffectsMix value) =>
      AccordionStyler().containerEffects(value);
  factory AccordionStyler.trigger(FlexBoxStyler value) =>
      AccordionStyler().trigger(value);
  factory AccordionStyler.leadingIcon(IconStyler value) =>
      AccordionStyler().leadingIcon(value);
  factory AccordionStyler.title(TextStyler value) =>
      AccordionStyler().title(value);
  factory AccordionStyler.trailingIcon(IconStyler value) =>
      AccordionStyler().trailingIcon(value);
  factory AccordionStyler.content(BoxStyler value) =>
      AccordionStyler().content(value);
  factory AccordionStyler.color(Color value) => AccordionStyler().color(value);
  factory AccordionStyler.gradient(GradientMix value) =>
      AccordionStyler().gradient(value);
  factory AccordionStyler.border(BoxBorderMix value) =>
      AccordionStyler().border(value);
  factory AccordionStyler.borderRadius(BorderRadiusGeometryMix value) =>
      AccordionStyler().borderRadius(value);
  factory AccordionStyler.elevation(ElevationShadow value) =>
      AccordionStyler().elevation(value);
  factory AccordionStyler.shadow(BoxShadowMix value) =>
      AccordionStyler().shadow(value);
  factory AccordionStyler.shadows(List<BoxShadowMix> value) =>
      AccordionStyler().shadows(value);
  factory AccordionStyler.width(double value) => AccordionStyler().width(value);
  factory AccordionStyler.height(double value) =>
      AccordionStyler().height(value);
  factory AccordionStyler.size(double width, double height) =>
      AccordionStyler().size(width, height);
  factory AccordionStyler.minWidth(double value) =>
      AccordionStyler().minWidth(value);
  factory AccordionStyler.maxWidth(double value) =>
      AccordionStyler().maxWidth(value);
  factory AccordionStyler.minHeight(double value) =>
      AccordionStyler().minHeight(value);
  factory AccordionStyler.maxHeight(double value) =>
      AccordionStyler().maxHeight(value);
  factory AccordionStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => AccordionStyler().scale(scale, alignment: alignment);
  factory AccordionStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => AccordionStyler().rotate(radians, alignment: alignment);
  factory AccordionStyler.translate(double x, double y, [double z = 0.0]) =>
      AccordionStyler().translate(x, y, z);
  factory AccordionStyler.skew(double skewX, double skewY) =>
      AccordionStyler().skew(skewX, skewY);
  factory AccordionStyler.textStyle(TextStyler value) =>
      AccordionStyler().textStyle(value);
  factory AccordionStyler.image(DecorationImageMix value) =>
      AccordionStyler().image(value);
  factory AccordionStyler.shape(ShapeBorderMix value) =>
      AccordionStyler().shape(value);
  factory AccordionStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => AccordionStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory AccordionStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => AccordionStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory AccordionStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => AccordionStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory AccordionStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => AccordionStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory AccordionStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => AccordionStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory AccordionStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => AccordionStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory AccordionStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => AccordionStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory AccordionStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => AccordionStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory AccordionStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => AccordionStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory AccordionStyler.row() => AccordionStyler().row();
  factory AccordionStyler.column() => AccordionStyler().column();
  factory AccordionStyler.alignment(AlignmentGeometry value) =>
      AccordionStyler().alignment(value);
  factory AccordionStyler.padding(EdgeInsetsGeometryMix value) =>
      AccordionStyler().padding(value);
  factory AccordionStyler.margin(EdgeInsetsGeometryMix value) =>
      AccordionStyler().margin(value);
  factory AccordionStyler.constraints(BoxConstraintsMix value) =>
      AccordionStyler().constraints(value);
  factory AccordionStyler.decoration(DecorationMix value) =>
      AccordionStyler().decoration(value);
  factory AccordionStyler.foregroundDecoration(DecorationMix value) =>
      AccordionStyler().foregroundDecoration(value);
  factory AccordionStyler.clipBehavior(Clip value) =>
      AccordionStyler().clipBehavior(value);
  factory AccordionStyler.direction(Axis value) =>
      AccordionStyler().direction(value);
  factory AccordionStyler.mainAxisAlignment(MainAxisAlignment value) =>
      AccordionStyler().mainAxisAlignment(value);
  factory AccordionStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      AccordionStyler().crossAxisAlignment(value);
  factory AccordionStyler.mainAxisSize(MainAxisSize value) =>
      AccordionStyler().mainAxisSize(value);
  factory AccordionStyler.spacing(double value) =>
      AccordionStyler().spacing(value);
  factory AccordionStyler.verticalDirection(VerticalDirection value) =>
      AccordionStyler().verticalDirection(value);
  factory AccordionStyler.textDirection(TextDirection value) =>
      AccordionStyler().textDirection(value);
  factory AccordionStyler.textBaseline(TextBaseline value) =>
      AccordionStyler().textBaseline(value);
  factory AccordionStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => AccordionStyler().transform(value, alignment: alignment);

  AccordionStyler color(Color value) {
    return trigger(FlexBoxStyler().color(value));
  }

  AccordionStyler gradient(GradientMix value) {
    return trigger(FlexBoxStyler().gradient(value));
  }

  AccordionStyler border(BoxBorderMix value) {
    return trigger(FlexBoxStyler().border(value));
  }

  AccordionStyler borderRadius(BorderRadiusGeometryMix value) {
    return trigger(FlexBoxStyler().borderRadius(value));
  }

  AccordionStyler elevation(ElevationShadow value) {
    return trigger(FlexBoxStyler().elevation(value));
  }

  AccordionStyler shadow(BoxShadowMix value) {
    return trigger(FlexBoxStyler().shadow(value));
  }

  AccordionStyler shadows(List<BoxShadowMix> value) {
    return trigger(FlexBoxStyler().shadows(value));
  }

  AccordionStyler width(double value) {
    return trigger(FlexBoxStyler().width(value));
  }

  AccordionStyler height(double value) {
    return trigger(FlexBoxStyler().height(value));
  }

  AccordionStyler size(double width, double height) {
    return trigger(FlexBoxStyler().size(width, height));
  }

  AccordionStyler minWidth(double value) {
    return trigger(FlexBoxStyler().minWidth(value));
  }

  AccordionStyler maxWidth(double value) {
    return trigger(FlexBoxStyler().maxWidth(value));
  }

  AccordionStyler minHeight(double value) {
    return trigger(FlexBoxStyler().minHeight(value));
  }

  AccordionStyler maxHeight(double value) {
    return trigger(FlexBoxStyler().maxHeight(value));
  }

  AccordionStyler scale(double scale, {Alignment alignment = .center}) {
    return trigger(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  AccordionStyler rotate(double radians, {Alignment alignment = .center}) {
    return trigger(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  AccordionStyler translate(double x, double y, [double z = 0.0]) {
    return trigger(FlexBoxStyler().translate(x, y, z));
  }

  AccordionStyler skew(double skewX, double skewY) {
    return trigger(FlexBoxStyler().skew(skewX, skewY));
  }

  AccordionStyler textStyle(TextStyler value) {
    return trigger(FlexBoxStyler().textStyle(value));
  }

  AccordionStyler image(DecorationImageMix value) {
    return trigger(FlexBoxStyler().image(value));
  }

  AccordionStyler shape(ShapeBorderMix value) {
    return trigger(FlexBoxStyler().shape(value));
  }

  AccordionStyler backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return trigger(
      FlexBoxStyler().backgroundImage(
        image,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  AccordionStyler backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return trigger(
      FlexBoxStyler().backgroundImageUrl(
        url,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  AccordionStyler backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return trigger(
      FlexBoxStyler().backgroundImageAsset(
        path,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  AccordionStyler linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return trigger(
      FlexBoxStyler().linearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  AccordionStyler radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return trigger(
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

  AccordionStyler sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return trigger(
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

  AccordionStyler foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return trigger(
      FlexBoxStyler().foregroundLinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  AccordionStyler foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return trigger(
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

  AccordionStyler foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return trigger(
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

  AccordionStyler row() {
    return trigger(FlexBoxStyler().row());
  }

  AccordionStyler column() {
    return trigger(FlexBoxStyler().column());
  }

  AccordionStyler alignment(AlignmentGeometry value) {
    return trigger(FlexBoxStyler().alignment(value));
  }

  AccordionStyler padding(EdgeInsetsGeometryMix value) {
    return trigger(FlexBoxStyler().padding(value));
  }

  AccordionStyler margin(EdgeInsetsGeometryMix value) {
    return trigger(FlexBoxStyler().margin(value));
  }

  AccordionStyler constraints(BoxConstraintsMix value) {
    return trigger(FlexBoxStyler().constraints(value));
  }

  AccordionStyler decoration(DecorationMix value) {
    return trigger(FlexBoxStyler().decoration(value));
  }

  AccordionStyler foregroundDecoration(DecorationMix value) {
    return trigger(FlexBoxStyler().foregroundDecoration(value));
  }

  AccordionStyler clipBehavior(Clip value) {
    return trigger(FlexBoxStyler().clipBehavior(value));
  }

  AccordionStyler direction(Axis value) {
    return trigger(FlexBoxStyler().direction(value));
  }

  AccordionStyler mainAxisAlignment(MainAxisAlignment value) {
    return trigger(FlexBoxStyler().mainAxisAlignment(value));
  }

  AccordionStyler crossAxisAlignment(CrossAxisAlignment value) {
    return trigger(FlexBoxStyler().crossAxisAlignment(value));
  }

  AccordionStyler mainAxisSize(MainAxisSize value) {
    return trigger(FlexBoxStyler().mainAxisSize(value));
  }

  AccordionStyler spacing(double value) {
    return trigger(FlexBoxStyler().spacing(value));
  }

  AccordionStyler verticalDirection(VerticalDirection value) {
    return trigger(FlexBoxStyler().verticalDirection(value));
  }

  AccordionStyler textDirection(TextDirection value) {
    return trigger(FlexBoxStyler().textDirection(value));
  }

  AccordionStyler textBaseline(TextBaseline value) {
    return trigger(FlexBoxStyler().textBaseline(value));
  }

  AccordionStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return trigger(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  AccordionStyler container(BoxStyler value) {
    return merge(AccordionStyler(container: value));
  }

  /// Sets the containerEffects.
  AccordionStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(AccordionStyler(containerEffects: value));
  }

  /// Sets the trigger.
  AccordionStyler trigger(FlexBoxStyler value) {
    return merge(AccordionStyler(trigger: value));
  }

  /// Sets the leadingIcon.
  AccordionStyler leadingIcon(IconStyler value) {
    return merge(AccordionStyler(leadingIcon: value));
  }

  /// Sets the title.
  AccordionStyler title(TextStyler value) {
    return merge(AccordionStyler(title: value));
  }

  /// Sets the trailingIcon.
  AccordionStyler trailingIcon(IconStyler value) {
    return merge(AccordionStyler(trailingIcon: value));
  }

  /// Sets the content.
  AccordionStyler content(BoxStyler value) {
    return merge(AccordionStyler(content: value));
  }

  /// Sets the animation configuration.
  @override
  AccordionStyler animate(AnimationConfig value) {
    return merge(AccordionStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  AccordionStyler variants(List<VariantStyle<AccordionSpec>> value) {
    return merge(AccordionStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  AccordionStyler wrap(WidgetModifierConfig value) {
    return merge(AccordionStyler(modifier: value));
  }

  /// Sets the widget modifier.
  AccordionStyler modifier(WidgetModifierConfig value) {
    return merge(AccordionStyler(modifier: value));
  }

  /// Merges with another [AccordionStyler].
  @override
  AccordionStyler merge(AccordionStyler? other) {
    return AccordionStyler.create(
      container: MixOps.merge($container, other?.$container),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      trigger: MixOps.merge($trigger, other?.$trigger),
      leadingIcon: MixOps.merge($leadingIcon, other?.$leadingIcon),
      title: MixOps.merge($title, other?.$title),
      trailingIcon: MixOps.merge($trailingIcon, other?.$trailingIcon),
      content: MixOps.merge($content, other?.$content),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<AccordionSpec>] using [context].
  @override
  StyleSpec<AccordionSpec> resolve(BuildContext context) {
    final spec = AccordionSpec(
      container: MixOps.resolve(context, $container),
      containerEffects: MixOps.resolve(context, $containerEffects),
      trigger: MixOps.resolve(context, $trigger),
      leadingIcon: MixOps.resolve(context, $leadingIcon),
      title: MixOps.resolve(context, $title),
      trailingIcon: MixOps.resolve(context, $trailingIcon),
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
      ..add(DiagnosticsProperty('leadingIcon', $leadingIcon))
      ..add(DiagnosticsProperty('title', $title))
      ..add(DiagnosticsProperty('trailingIcon', $trailingIcon))
      ..add(DiagnosticsProperty('content', $content));
  }

  @override
  List<Object?> get props => [
    $container,
    $containerEffects,
    $trigger,
    $leadingIcon,
    $title,
    $trailingIcon,
    $content,
    $animation,
    $modifier,
    $variants,
  ];
}
