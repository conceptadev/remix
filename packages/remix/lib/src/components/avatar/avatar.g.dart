// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixAvatarSpec implements Spec<RemixAvatarSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => RemixAvatarSpec;

  @override
  RemixAvatarSpec copyWith({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) {
    return RemixAvatarSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  @override
  RemixAvatarSpec lerp(RemixAvatarSpec? other, double t) {
    return RemixAvatarSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      icon: icon.lerp(other?.icon, t),
    );
  }

  @override
  List<Object?> get props => [container, label, icon];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixAvatarSpec &&
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
      ..add(DiagnosticsProperty('icon', icon));
  }
}

@Deprecated(
  'Rename to `_\$RemixAvatarSpec` and migrate the class declaration to `class RemixAvatarSpec with _\$RemixAvatarSpec`. The `_\$RemixAvatarSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixAvatarSpecMethods = _$RemixAvatarSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal recipe for [RemixAvatar].
///
/// [fallbackLength] selects the pinned one- or two-character fallback
/// typography. Pass `2` when [RemixAvatar.label] contains two initials.
class FortalAvatar extends StatelessWidget {
  const FortalAvatar({
    super.key,
    this.variant = .soft,
    this.size = .size3,
    this.highContrast = false,
    this.fallbackLength = 1,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
  });

  const FortalAvatar.soft({
    super.key,
    this.size = .size3,
    this.highContrast = false,
    this.fallbackLength = 1,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
  }) : variant = FortalAvatarVariant.soft;

  const FortalAvatar.solid({
    super.key,
    this.size = .size3,
    this.highContrast = false,
    this.fallbackLength = 1,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
  }) : variant = FortalAvatarVariant.solid;

  final FortalAvatarVariant variant;

  final FortalAvatarSize size;

  final bool highContrast;

  final int fallbackLength;

  final ImageProvider<Object>? backgroundImage;

  final ImageProvider<Object>? foregroundImage;

  final ImageErrorListener? onBackgroundImageError;

  final ImageErrorListener? onForegroundImageError;

  final Widget? child;

  final String? label;

  final RemixAvatarLabelBuilder? labelBuilder;

  final IconData? icon;

  final RemixAvatarIconBuilder? iconBuilder;

  @override
  Widget build(BuildContext context) {
    return RemixAvatar(
      key: this.key,
      style: fortalAvatarStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
        fallbackLength: this.fallbackLength,
      ),
      backgroundImage: this.backgroundImage,
      foregroundImage: this.foregroundImage,
      onBackgroundImageError: this.onBackgroundImageError,
      onForegroundImageError: this.onForegroundImageError,
      child: this.child,
      label: this.label,
      labelBuilder: this.labelBuilder,
      icon: this.icon,
      iconBuilder: this.iconBuilder,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixAvatarStyler extends MixStyler<RemixAvatarStyler, RemixAvatarSpec>
    with
        RemixBoxStylerMixin<RemixAvatarStyler>,
        LabelStyleMixin<RemixAvatarStyler>,
        IconStyleMixin<RemixAvatarStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const RemixAvatarStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon;

  RemixAvatarStyler({
    BoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixAvatarSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixAvatarStyler.container(BoxStyler value) =>
      RemixAvatarStyler().container(value);
  factory RemixAvatarStyler.label(TextStyler value) =>
      RemixAvatarStyler().label(value);
  factory RemixAvatarStyler.icon(IconStyler value) =>
      RemixAvatarStyler().icon(value);
  factory RemixAvatarStyler.alignment(AlignmentGeometry value) =>
      RemixAvatarStyler().alignment(value);
  factory RemixAvatarStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixAvatarStyler().padding(value);
  factory RemixAvatarStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixAvatarStyler().margin(value);
  factory RemixAvatarStyler.constraints(BoxConstraintsMix value) =>
      RemixAvatarStyler().constraints(value);
  factory RemixAvatarStyler.decoration(DecorationMix value) =>
      RemixAvatarStyler().decoration(value);
  factory RemixAvatarStyler.foregroundDecoration(DecorationMix value) =>
      RemixAvatarStyler().foregroundDecoration(value);
  factory RemixAvatarStyler.clipBehavior(Clip value) =>
      RemixAvatarStyler().clipBehavior(value);
  factory RemixAvatarStyler.color(Color value) =>
      RemixAvatarStyler().color(value);
  factory RemixAvatarStyler.gradient(GradientMix value) =>
      RemixAvatarStyler().gradient(value);
  factory RemixAvatarStyler.border(BoxBorderMix value) =>
      RemixAvatarStyler().border(value);
  factory RemixAvatarStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixAvatarStyler().borderRadius(value);
  factory RemixAvatarStyler.elevation(ElevationShadow value) =>
      RemixAvatarStyler().elevation(value);
  factory RemixAvatarStyler.shadow(BoxShadowMix value) =>
      RemixAvatarStyler().shadow(value);
  factory RemixAvatarStyler.shadows(List<BoxShadowMix> value) =>
      RemixAvatarStyler().shadows(value);
  factory RemixAvatarStyler.width(double value) =>
      RemixAvatarStyler().width(value);
  factory RemixAvatarStyler.height(double value) =>
      RemixAvatarStyler().height(value);
  factory RemixAvatarStyler.size(double width, double height) =>
      RemixAvatarStyler().size(width, height);
  factory RemixAvatarStyler.minWidth(double value) =>
      RemixAvatarStyler().minWidth(value);
  factory RemixAvatarStyler.maxWidth(double value) =>
      RemixAvatarStyler().maxWidth(value);
  factory RemixAvatarStyler.minHeight(double value) =>
      RemixAvatarStyler().minHeight(value);
  factory RemixAvatarStyler.maxHeight(double value) =>
      RemixAvatarStyler().maxHeight(value);
  factory RemixAvatarStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixAvatarStyler().scale(scale, alignment: alignment);
  factory RemixAvatarStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixAvatarStyler().rotate(radians, alignment: alignment);
  factory RemixAvatarStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixAvatarStyler().translate(x, y, z);
  factory RemixAvatarStyler.skew(double skewX, double skewY) =>
      RemixAvatarStyler().skew(skewX, skewY);
  factory RemixAvatarStyler.textStyle(TextStyler value) =>
      RemixAvatarStyler().textStyle(value);
  factory RemixAvatarStyler.image(DecorationImageMix value) =>
      RemixAvatarStyler().image(value);
  factory RemixAvatarStyler.shape(ShapeBorderMix value) =>
      RemixAvatarStyler().shape(value);
  factory RemixAvatarStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixAvatarStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixAvatarStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixAvatarStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixAvatarStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixAvatarStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixAvatarStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixAvatarStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixAvatarStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixAvatarStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixAvatarStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixAvatarStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixAvatarStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixAvatarStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixAvatarStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixAvatarStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixAvatarStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixAvatarStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixAvatarStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixAvatarStyler().transform(value, alignment: alignment);

  RemixAvatarStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixAvatarStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixAvatarStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixAvatarStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixAvatarStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixAvatarStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixAvatarStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixAvatarStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixAvatarStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixAvatarStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixAvatarStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixAvatarStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixAvatarStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixAvatarStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixAvatarStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixAvatarStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixAvatarStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixAvatarStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixAvatarStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixAvatarStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixAvatarStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixAvatarStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixAvatarStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixAvatarStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixAvatarStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixAvatarStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixAvatarStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixAvatarStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixAvatarStyler backgroundImage(
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

  RemixAvatarStyler backgroundImageUrl(
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

  RemixAvatarStyler backgroundImageAsset(
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

  RemixAvatarStyler linearGradient({
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

  RemixAvatarStyler radialGradient({
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

  RemixAvatarStyler sweepGradient({
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

  RemixAvatarStyler foregroundLinearGradient({
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

  RemixAvatarStyler foregroundRadialGradient({
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

  RemixAvatarStyler foregroundSweepGradient({
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

  RemixAvatarStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixAvatarStyler container(BoxStyler value) {
    return merge(RemixAvatarStyler(container: value));
  }

  /// Sets the label.
  @override
  RemixAvatarStyler label(TextStyler value) {
    return merge(RemixAvatarStyler(label: value));
  }

  /// Sets the icon.
  @override
  RemixAvatarStyler icon(IconStyler value) {
    return merge(RemixAvatarStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  RemixAvatarStyler animate(AnimationConfig value) {
    return merge(RemixAvatarStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixAvatarStyler variants(List<VariantStyle<RemixAvatarSpec>> value) {
    return merge(RemixAvatarStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixAvatarStyler wrap(WidgetModifierConfig value) {
    return merge(RemixAvatarStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixAvatarStyler modifier(WidgetModifierConfig value) {
    return merge(RemixAvatarStyler(modifier: value));
  }

  /// Merges with another [RemixAvatarStyler].
  @override
  RemixAvatarStyler merge(RemixAvatarStyler? other) {
    return RemixAvatarStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixAvatarSpec>] using [context].
  @override
  StyleSpec<RemixAvatarSpec> resolve(BuildContext context) {
    final spec = RemixAvatarSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      icon: MixOps.resolve(context, $icon),
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
      ..add(DiagnosticsProperty('icon', $icon));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $icon,
    $animation,
    $modifier,
    $variants,
  ];
}
