// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popover.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$PopoverSpec implements Spec<PopoverSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => PopoverSpec;

  @override
  PopoverSpec copyWith({
    StyleSpec<BoxSpec>? container,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return PopoverSpec(
      container: container ?? this.container,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  PopoverSpec lerp(PopoverSpec? other, double t) {
    return PopoverSpec(
      container: container.lerp(other?.container, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [container, containerEffects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PopoverSpec &&
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
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$PopoverSpec` and migrate the class declaration to `class PopoverSpec with _\$PopoverSpec`. The `_\$PopoverSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$PopoverSpecMethods = _$PopoverSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixPopover].
class FortalPopover extends StatelessWidget {
  const FortalPopover({
    super.key,
    this.size = FortalPopoverSize.size2,
    required this.popoverChild,
    required this.child,
    this.positioning = const OverlayPositionConfig(),
    this.consumeOutsideTaps = true,
    this.useRootOverlay = false,
    this.openOnTap = true,
    this.triggerFocusNode,
    this.onOpen,
    this.onClose,
    this.onOpenRequested,
    this.onCloseRequested,
    this.controller,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final FortalPopoverSize size;

  final Widget popoverChild;

  final Widget child;

  final OverlayPositionConfig positioning;

  final bool consumeOutsideTaps;

  final bool useRootOverlay;

  final bool openOnTap;

  final FocusNode? triggerFocusNode;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;

  final RawMenuAnchorOpenRequestedCallback? onOpenRequested;

  final RawMenuAnchorCloseRequestedCallback? onCloseRequested;

  final MenuController? controller;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixPopover(
      key: this.key,
      style: fortalPopoverStyle(size: this.size),
      popoverChild: this.popoverChild,
      child: this.child,
      positioning: this.positioning,
      consumeOutsideTaps: this.consumeOutsideTaps,
      useRootOverlay: this.useRootOverlay,
      openOnTap: this.openOnTap,
      triggerFocusNode: this.triggerFocusNode,
      onOpen: this.onOpen,
      onClose: this.onClose,
      onOpenRequested: this.onOpenRequested,
      onCloseRequested: this.onCloseRequested,
      controller: this.controller,
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class PopoverStyler extends MixStyler<PopoverStyler, PopoverSpec>
    with RemixBoxStylerMixin<PopoverStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const PopoverStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $containerEffects = containerEffects;

  PopoverStyler({
    BoxStyler? container,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<PopoverSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory PopoverStyler.container(BoxStyler value) =>
      PopoverStyler().container(value);
  factory PopoverStyler.containerEffects(RemixBoxEffectsMix value) =>
      PopoverStyler().containerEffects(value);
  factory PopoverStyler.alignment(AlignmentGeometry value) =>
      PopoverStyler().alignment(value);
  factory PopoverStyler.padding(EdgeInsetsGeometryMix value) =>
      PopoverStyler().padding(value);
  factory PopoverStyler.margin(EdgeInsetsGeometryMix value) =>
      PopoverStyler().margin(value);
  factory PopoverStyler.constraints(BoxConstraintsMix value) =>
      PopoverStyler().constraints(value);
  factory PopoverStyler.decoration(DecorationMix value) =>
      PopoverStyler().decoration(value);
  factory PopoverStyler.foregroundDecoration(DecorationMix value) =>
      PopoverStyler().foregroundDecoration(value);
  factory PopoverStyler.clipBehavior(Clip value) =>
      PopoverStyler().clipBehavior(value);
  factory PopoverStyler.color(Color value) => PopoverStyler().color(value);
  factory PopoverStyler.gradient(GradientMix value) =>
      PopoverStyler().gradient(value);
  factory PopoverStyler.border(BoxBorderMix value) =>
      PopoverStyler().border(value);
  factory PopoverStyler.borderRadius(BorderRadiusGeometryMix value) =>
      PopoverStyler().borderRadius(value);
  factory PopoverStyler.elevation(ElevationShadow value) =>
      PopoverStyler().elevation(value);
  factory PopoverStyler.shadow(BoxShadowMix value) =>
      PopoverStyler().shadow(value);
  factory PopoverStyler.shadows(List<BoxShadowMix> value) =>
      PopoverStyler().shadows(value);
  factory PopoverStyler.width(double value) => PopoverStyler().width(value);
  factory PopoverStyler.height(double value) => PopoverStyler().height(value);
  factory PopoverStyler.size(double width, double height) =>
      PopoverStyler().size(width, height);
  factory PopoverStyler.minWidth(double value) =>
      PopoverStyler().minWidth(value);
  factory PopoverStyler.maxWidth(double value) =>
      PopoverStyler().maxWidth(value);
  factory PopoverStyler.minHeight(double value) =>
      PopoverStyler().minHeight(value);
  factory PopoverStyler.maxHeight(double value) =>
      PopoverStyler().maxHeight(value);
  factory PopoverStyler.scale(double scale, {Alignment alignment = .center}) =>
      PopoverStyler().scale(scale, alignment: alignment);
  factory PopoverStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => PopoverStyler().rotate(radians, alignment: alignment);
  factory PopoverStyler.translate(double x, double y, [double z = 0.0]) =>
      PopoverStyler().translate(x, y, z);
  factory PopoverStyler.skew(double skewX, double skewY) =>
      PopoverStyler().skew(skewX, skewY);
  factory PopoverStyler.textStyle(TextStyler value) =>
      PopoverStyler().textStyle(value);
  factory PopoverStyler.image(DecorationImageMix value) =>
      PopoverStyler().image(value);
  factory PopoverStyler.shape(ShapeBorderMix value) =>
      PopoverStyler().shape(value);
  factory PopoverStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => PopoverStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory PopoverStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => PopoverStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory PopoverStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => PopoverStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory PopoverStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => PopoverStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory PopoverStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => PopoverStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory PopoverStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => PopoverStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory PopoverStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => PopoverStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory PopoverStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => PopoverStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory PopoverStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => PopoverStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory PopoverStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => PopoverStyler().transform(value, alignment: alignment);

  PopoverStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  PopoverStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  PopoverStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  PopoverStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  PopoverStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  PopoverStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  PopoverStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  PopoverStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  PopoverStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  PopoverStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  PopoverStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  PopoverStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  PopoverStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  PopoverStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  PopoverStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  PopoverStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  PopoverStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  PopoverStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  PopoverStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  PopoverStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  PopoverStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  PopoverStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  PopoverStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  PopoverStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  PopoverStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  PopoverStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  PopoverStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  PopoverStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  PopoverStyler backgroundImage(
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

  PopoverStyler backgroundImageUrl(
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

  PopoverStyler backgroundImageAsset(
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

  PopoverStyler linearGradient({
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

  PopoverStyler radialGradient({
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

  PopoverStyler sweepGradient({
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

  PopoverStyler foregroundLinearGradient({
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

  PopoverStyler foregroundRadialGradient({
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

  PopoverStyler foregroundSweepGradient({
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

  PopoverStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  PopoverStyler container(BoxStyler value) {
    return merge(PopoverStyler(container: value));
  }

  /// Sets the containerEffects.
  PopoverStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(PopoverStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  PopoverStyler animate(AnimationConfig value) {
    return merge(PopoverStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  PopoverStyler variants(List<VariantStyle<PopoverSpec>> value) {
    return merge(PopoverStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  PopoverStyler wrap(WidgetModifierConfig value) {
    return merge(PopoverStyler(modifier: value));
  }

  /// Sets the widget modifier.
  PopoverStyler modifier(WidgetModifierConfig value) {
    return merge(PopoverStyler(modifier: value));
  }

  /// Merges with another [PopoverStyler].
  @override
  PopoverStyler merge(PopoverStyler? other) {
    return PopoverStyler.create(
      container: MixOps.merge($container, other?.$container),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<PopoverSpec>] using [context].
  @override
  StyleSpec<PopoverSpec> resolve(BuildContext context) {
    final spec = PopoverSpec(
      container: MixOps.resolve(context, $container),
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
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
