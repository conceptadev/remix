// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_button.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$IconButtonSpec implements Spec<IconButtonSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<IconSpec> get icon;
  StyleSpec<SpinnerSpec> get spinner;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => IconButtonSpec;

  @override
  IconButtonSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<IconSpec>? icon,
    StyleSpec<SpinnerSpec>? spinner,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return IconButtonSpec(
      container: container ?? this.container,
      icon: icon ?? this.icon,
      spinner: spinner ?? this.spinner,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  IconButtonSpec lerp(IconButtonSpec? other, double t) {
    return IconButtonSpec(
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
        other is IconButtonSpec &&
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
  'Rename to `_\$IconButtonSpec` and migrate the class declaration to `class IconButtonSpec with _\$IconButtonSpec`. The `_\$IconButtonSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$IconButtonSpecMethods = _$IconButtonSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed IconButton with the Radix size, variant, and override contract.
class FortalIconButton extends StatelessWidget {
  const FortalIconButton({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.semanticLabel,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  });

  const FortalIconButton.classic({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.semanticLabel,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.classic;

  const FortalIconButton.solid({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.semanticLabel,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.solid;

  const FortalIconButton.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.semanticLabel,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.soft;

  const FortalIconButton.surface({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.semanticLabel,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.surface;

  const FortalIconButton.outline({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.semanticLabel,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.outline;

  const FortalIconButton.ghost({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.icon,
    this.iconBuilder,
    this.semanticLabel,
    this.loadingBuilder,
    this.loading = false,
    this.enabled = true,
    this.enableFeedback = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalIconButtonVariant.ghost;

  final FortalIconButtonVariant variant;

  final FortalIconButtonSize size;

  final bool highContrast;

  final IconData icon;

  final RemixIconButtonIconBuilder? iconBuilder;

  final String? semanticLabel;

  final RemixIconButtonLoadingBuilder? loadingBuilder;

  final bool loading;

  final bool enabled;

  final bool enableFeedback;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final FocusNode? focusNode;

  final bool autofocus;

  final String? semanticHint;

  final bool excludeSemantics;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return RemixIconButton(
      key: this.key,
      style: fortalIconButtonStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ),
      icon: this.icon,
      iconBuilder: this.iconBuilder,
      semanticLabel: this.semanticLabel,
      loadingBuilder: this.loadingBuilder,
      loading: this.loading,
      enabled: this.enabled,
      enableFeedback: this.enableFeedback,
      onPressed: this.onPressed,
      onLongPress: this.onLongPress,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      semanticHint: this.semanticHint,
      excludeSemantics: this.excludeSemantics,
      mouseCursor: this.mouseCursor,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class IconButtonStyler extends MixStyler<IconButtonStyler, IconButtonSpec>
    with
        RemixBoxStylerMixin<IconButtonStyler>,
        IconStyleMixin<IconButtonStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<IconSpec>>? $icon;
  final Prop<StyleSpec<SpinnerSpec>>? $spinner;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const IconButtonStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<IconSpec>>? icon,
    Prop<StyleSpec<SpinnerSpec>>? spinner,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $icon = icon,
       $spinner = spinner,
       $containerEffects = containerEffects;

  IconButtonStyler({
    BoxStyler? container,
    IconStyler? icon,
    SpinnerStyler? spinner,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<IconButtonSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         icon: Prop.maybeMix(icon),
         spinner: Prop.maybeMix(spinner),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory IconButtonStyler.container(BoxStyler value) =>
      IconButtonStyler().container(value);
  factory IconButtonStyler.icon(IconStyler value) =>
      IconButtonStyler().icon(value);
  factory IconButtonStyler.spinner(SpinnerStyler value) =>
      IconButtonStyler().spinner(value);
  factory IconButtonStyler.containerEffects(RemixBoxEffectsMix value) =>
      IconButtonStyler().containerEffects(value);
  factory IconButtonStyler.alignment(AlignmentGeometry value) =>
      IconButtonStyler().alignment(value);
  factory IconButtonStyler.padding(EdgeInsetsGeometryMix value) =>
      IconButtonStyler().padding(value);
  factory IconButtonStyler.margin(EdgeInsetsGeometryMix value) =>
      IconButtonStyler().margin(value);
  factory IconButtonStyler.constraints(BoxConstraintsMix value) =>
      IconButtonStyler().constraints(value);
  factory IconButtonStyler.decoration(DecorationMix value) =>
      IconButtonStyler().decoration(value);
  factory IconButtonStyler.foregroundDecoration(DecorationMix value) =>
      IconButtonStyler().foregroundDecoration(value);
  factory IconButtonStyler.clipBehavior(Clip value) =>
      IconButtonStyler().clipBehavior(value);
  factory IconButtonStyler.color(Color value) =>
      IconButtonStyler().color(value);
  factory IconButtonStyler.gradient(GradientMix value) =>
      IconButtonStyler().gradient(value);
  factory IconButtonStyler.border(BoxBorderMix value) =>
      IconButtonStyler().border(value);
  factory IconButtonStyler.borderRadius(BorderRadiusGeometryMix value) =>
      IconButtonStyler().borderRadius(value);
  factory IconButtonStyler.elevation(ElevationShadow value) =>
      IconButtonStyler().elevation(value);
  factory IconButtonStyler.shadow(BoxShadowMix value) =>
      IconButtonStyler().shadow(value);
  factory IconButtonStyler.shadows(List<BoxShadowMix> value) =>
      IconButtonStyler().shadows(value);
  factory IconButtonStyler.width(double value) =>
      IconButtonStyler().width(value);
  factory IconButtonStyler.height(double value) =>
      IconButtonStyler().height(value);
  factory IconButtonStyler.size(double width, double height) =>
      IconButtonStyler().size(width, height);
  factory IconButtonStyler.minWidth(double value) =>
      IconButtonStyler().minWidth(value);
  factory IconButtonStyler.maxWidth(double value) =>
      IconButtonStyler().maxWidth(value);
  factory IconButtonStyler.minHeight(double value) =>
      IconButtonStyler().minHeight(value);
  factory IconButtonStyler.maxHeight(double value) =>
      IconButtonStyler().maxHeight(value);
  factory IconButtonStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => IconButtonStyler().scale(scale, alignment: alignment);
  factory IconButtonStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => IconButtonStyler().rotate(radians, alignment: alignment);
  factory IconButtonStyler.translate(double x, double y, [double z = 0.0]) =>
      IconButtonStyler().translate(x, y, z);
  factory IconButtonStyler.skew(double skewX, double skewY) =>
      IconButtonStyler().skew(skewX, skewY);
  factory IconButtonStyler.textStyle(TextStyler value) =>
      IconButtonStyler().textStyle(value);
  factory IconButtonStyler.image(DecorationImageMix value) =>
      IconButtonStyler().image(value);
  factory IconButtonStyler.shape(ShapeBorderMix value) =>
      IconButtonStyler().shape(value);
  factory IconButtonStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => IconButtonStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory IconButtonStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => IconButtonStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory IconButtonStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => IconButtonStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory IconButtonStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => IconButtonStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory IconButtonStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => IconButtonStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory IconButtonStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => IconButtonStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory IconButtonStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => IconButtonStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory IconButtonStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => IconButtonStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory IconButtonStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => IconButtonStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory IconButtonStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => IconButtonStyler().transform(value, alignment: alignment);

  IconButtonStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  IconButtonStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  IconButtonStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  IconButtonStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  IconButtonStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  IconButtonStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  IconButtonStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  IconButtonStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  IconButtonStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  IconButtonStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  IconButtonStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  IconButtonStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  IconButtonStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  IconButtonStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  IconButtonStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  IconButtonStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  IconButtonStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  IconButtonStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  IconButtonStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  IconButtonStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  IconButtonStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  IconButtonStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  IconButtonStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  IconButtonStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  IconButtonStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  IconButtonStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  IconButtonStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  IconButtonStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  IconButtonStyler backgroundImage(
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

  IconButtonStyler backgroundImageUrl(
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

  IconButtonStyler backgroundImageAsset(
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

  IconButtonStyler linearGradient({
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

  IconButtonStyler radialGradient({
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

  IconButtonStyler sweepGradient({
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

  IconButtonStyler foregroundLinearGradient({
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

  IconButtonStyler foregroundRadialGradient({
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

  IconButtonStyler foregroundSweepGradient({
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

  IconButtonStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  IconButtonStyler container(BoxStyler value) {
    return merge(IconButtonStyler(container: value));
  }

  /// Sets the icon.
  @override
  IconButtonStyler icon(IconStyler value) {
    return merge(IconButtonStyler(icon: value));
  }

  /// Sets the spinner.
  IconButtonStyler spinner(SpinnerStyler value) {
    return merge(IconButtonStyler(spinner: value));
  }

  /// Sets the containerEffects.
  IconButtonStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(IconButtonStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  IconButtonStyler animate(AnimationConfig value) {
    return merge(IconButtonStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  IconButtonStyler variants(List<VariantStyle<IconButtonSpec>> value) {
    return merge(IconButtonStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  IconButtonStyler wrap(WidgetModifierConfig value) {
    return merge(IconButtonStyler(modifier: value));
  }

  /// Sets the widget modifier.
  IconButtonStyler modifier(WidgetModifierConfig value) {
    return merge(IconButtonStyler(modifier: value));
  }

  /// Merges with another [IconButtonStyler].
  @override
  IconButtonStyler merge(IconButtonStyler? other) {
    return IconButtonStyler.create(
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

  /// Resolves to [StyleSpec<IconButtonSpec>] using [context].
  @override
  StyleSpec<IconButtonSpec> resolve(BuildContext context) {
    final spec = IconButtonSpec(
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
