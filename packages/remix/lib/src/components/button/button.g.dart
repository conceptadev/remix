// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$ButtonSpec implements Spec<ButtonSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;
  StyleSpec<RemixSpinnerSpec> get spinner;
  RemixSurfaceEffectsSpec? get effects;

  @override
  Type get type => ButtonSpec;

  @override
  ButtonSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
    StyleSpec<RemixSpinnerSpec>? spinner,
    RemixSurfaceEffectsSpec? effects,
  }) {
    return ButtonSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      spinner: spinner ?? this.spinner,
      effects: effects ?? this.effects,
    );
  }

  @override
  ButtonSpec lerp(ButtonSpec? other, double t) {
    return ButtonSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      icon: icon.lerp(other?.icon, t),
      spinner: spinner.lerp(other?.spinner, t),
      effects: MixOps.lerpSnap(effects, other?.effects, t),
    );
  }

  @override
  List<Object?> get props => [container, label, icon, spinner, effects];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ButtonSpec &&
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
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('spinner', spinner))
      ..add(DiagnosticsProperty('effects', effects));
  }
}

@Deprecated(
  'Rename to `_\$ButtonSpec` and migrate the class declaration to `class ButtonSpec with _\$ButtonSpec`. The `_\$ButtonSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$ButtonSpecMethods = _$ButtonSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class ButtonStyler extends MixStyler<ButtonStyler, ButtonSpec>
    with
        RemixBoxStylerMixin<ButtonStyler>,
        LabelStyleMixin<ButtonStyler>,
        IconStyleMixin<ButtonStyler>,
        SpinnerStyleMixin<ButtonStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;
  final Prop<StyleSpec<RemixSpinnerSpec>>? $spinner;
  final Prop<RemixSurfaceEffectsSpec>? $effects;

  const ButtonStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    Prop<StyleSpec<RemixSpinnerSpec>>? spinner,
    Prop<RemixSurfaceEffectsSpec>? effects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon,
       $spinner = spinner,
       $effects = effects;

  ButtonStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    RemixSpinnerStyler? spinner,
    RemixSurfaceEffectsMix? effects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<ButtonSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         spinner: Prop.maybeMix(spinner),
         effects: Prop.maybeMix(effects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory ButtonStyler.container(FlexBoxStyler value) =>
      ButtonStyler().container(value);
  factory ButtonStyler.label(TextStyler value) => ButtonStyler().label(value);
  factory ButtonStyler.icon(IconStyler value) => ButtonStyler().icon(value);
  factory ButtonStyler.spinner(RemixSpinnerStyler value) =>
      ButtonStyler().spinner(value);
  factory ButtonStyler.effects(RemixSurfaceEffectsMix value) =>
      ButtonStyler().effects(value);
  factory ButtonStyler.color(Color value) => ButtonStyler().color(value);
  factory ButtonStyler.gradient(GradientMix value) =>
      ButtonStyler().gradient(value);
  factory ButtonStyler.border(BoxBorderMix value) =>
      ButtonStyler().border(value);
  factory ButtonStyler.borderRadius(BorderRadiusGeometryMix value) =>
      ButtonStyler().borderRadius(value);
  factory ButtonStyler.elevation(ElevationShadow value) =>
      ButtonStyler().elevation(value);
  factory ButtonStyler.shadow(BoxShadowMix value) =>
      ButtonStyler().shadow(value);
  factory ButtonStyler.shadows(List<BoxShadowMix> value) =>
      ButtonStyler().shadows(value);
  factory ButtonStyler.width(double value) => ButtonStyler().width(value);
  factory ButtonStyler.height(double value) => ButtonStyler().height(value);
  factory ButtonStyler.size(double width, double height) =>
      ButtonStyler().size(width, height);
  factory ButtonStyler.minWidth(double value) => ButtonStyler().minWidth(value);
  factory ButtonStyler.maxWidth(double value) => ButtonStyler().maxWidth(value);
  factory ButtonStyler.minHeight(double value) =>
      ButtonStyler().minHeight(value);
  factory ButtonStyler.maxHeight(double value) =>
      ButtonStyler().maxHeight(value);
  factory ButtonStyler.scale(double scale, {Alignment alignment = .center}) =>
      ButtonStyler().scale(scale, alignment: alignment);
  factory ButtonStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => ButtonStyler().rotate(radians, alignment: alignment);
  factory ButtonStyler.translate(double x, double y, [double z = 0.0]) =>
      ButtonStyler().translate(x, y, z);
  factory ButtonStyler.skew(double skewX, double skewY) =>
      ButtonStyler().skew(skewX, skewY);
  factory ButtonStyler.textStyle(TextStyler value) =>
      ButtonStyler().textStyle(value);
  factory ButtonStyler.image(DecorationImageMix value) =>
      ButtonStyler().image(value);
  factory ButtonStyler.shape(ShapeBorderMix value) =>
      ButtonStyler().shape(value);
  factory ButtonStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ButtonStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ButtonStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ButtonStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ButtonStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ButtonStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ButtonStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ButtonStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ButtonStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ButtonStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ButtonStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ButtonStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ButtonStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ButtonStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ButtonStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ButtonStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ButtonStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ButtonStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ButtonStyler.row() => ButtonStyler().row();
  factory ButtonStyler.column() => ButtonStyler().column();
  factory ButtonStyler.alignment(AlignmentGeometry value) =>
      ButtonStyler().alignment(value);
  factory ButtonStyler.padding(EdgeInsetsGeometryMix value) =>
      ButtonStyler().padding(value);
  factory ButtonStyler.margin(EdgeInsetsGeometryMix value) =>
      ButtonStyler().margin(value);
  factory ButtonStyler.constraints(BoxConstraintsMix value) =>
      ButtonStyler().constraints(value);
  factory ButtonStyler.decoration(DecorationMix value) =>
      ButtonStyler().decoration(value);
  factory ButtonStyler.foregroundDecoration(DecorationMix value) =>
      ButtonStyler().foregroundDecoration(value);
  factory ButtonStyler.clipBehavior(Clip value) =>
      ButtonStyler().clipBehavior(value);
  factory ButtonStyler.direction(Axis value) => ButtonStyler().direction(value);
  factory ButtonStyler.mainAxisAlignment(MainAxisAlignment value) =>
      ButtonStyler().mainAxisAlignment(value);
  factory ButtonStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      ButtonStyler().crossAxisAlignment(value);
  factory ButtonStyler.mainAxisSize(MainAxisSize value) =>
      ButtonStyler().mainAxisSize(value);
  factory ButtonStyler.spacing(double value) => ButtonStyler().spacing(value);
  factory ButtonStyler.verticalDirection(VerticalDirection value) =>
      ButtonStyler().verticalDirection(value);
  factory ButtonStyler.textDirection(TextDirection value) =>
      ButtonStyler().textDirection(value);
  factory ButtonStyler.textBaseline(TextBaseline value) =>
      ButtonStyler().textBaseline(value);
  factory ButtonStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => ButtonStyler().transform(value, alignment: alignment);

  ButtonStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  ButtonStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  ButtonStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  ButtonStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  ButtonStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  ButtonStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  ButtonStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  ButtonStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  ButtonStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  ButtonStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  ButtonStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  ButtonStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  ButtonStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  ButtonStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  ButtonStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  ButtonStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  ButtonStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  ButtonStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  ButtonStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  ButtonStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  ButtonStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  ButtonStyler backgroundImage(
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

  ButtonStyler backgroundImageUrl(
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

  ButtonStyler backgroundImageAsset(
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

  ButtonStyler linearGradient({
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

  ButtonStyler radialGradient({
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

  ButtonStyler sweepGradient({
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

  ButtonStyler foregroundLinearGradient({
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

  ButtonStyler foregroundRadialGradient({
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

  ButtonStyler foregroundSweepGradient({
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

  ButtonStyler row() {
    return container(FlexBoxStyler().row());
  }

  ButtonStyler column() {
    return container(FlexBoxStyler().column());
  }

  ButtonStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  ButtonStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  ButtonStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  ButtonStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  ButtonStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  ButtonStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  ButtonStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  ButtonStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  ButtonStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  ButtonStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  ButtonStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  ButtonStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  ButtonStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  ButtonStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  ButtonStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  ButtonStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  ButtonStyler container(FlexBoxStyler value) {
    return merge(ButtonStyler(container: value));
  }

  /// Sets the label.
  @override
  ButtonStyler label(TextStyler value) {
    return merge(ButtonStyler(label: value));
  }

  /// Sets the icon.
  @override
  ButtonStyler icon(IconStyler value) {
    return merge(ButtonStyler(icon: value));
  }

  /// Sets the spinner.
  @override
  ButtonStyler spinner(RemixSpinnerStyler value) {
    return merge(ButtonStyler(spinner: value));
  }

  /// Sets the effects.
  ButtonStyler effects(RemixSurfaceEffectsMix value) {
    return merge(ButtonStyler(effects: value));
  }

  /// Sets the animation configuration.
  @override
  ButtonStyler animate(AnimationConfig value) {
    return merge(ButtonStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  ButtonStyler variants(List<VariantStyle<ButtonSpec>> value) {
    return merge(ButtonStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  ButtonStyler wrap(WidgetModifierConfig value) {
    return merge(ButtonStyler(modifier: value));
  }

  /// Sets the widget modifier.
  ButtonStyler modifier(WidgetModifierConfig value) {
    return merge(ButtonStyler(modifier: value));
  }

  /// Merges with another [ButtonStyler].
  @override
  ButtonStyler merge(ButtonStyler? other) {
    return ButtonStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      spinner: MixOps.merge($spinner, other?.$spinner),
      effects: MixOps.merge($effects, other?.$effects),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<ButtonSpec>] using [context].
  @override
  StyleSpec<ButtonSpec> resolve(BuildContext context) {
    final spec = ButtonSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      icon: MixOps.resolve(context, $icon),
      spinner: MixOps.resolve(context, $spinner),
      effects: MixOps.resolve(context, $effects),
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
      ..add(DiagnosticsProperty('icon', $icon))
      ..add(DiagnosticsProperty('spinner', $spinner))
      ..add(DiagnosticsProperty('effects', $effects));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $icon,
    $spinner,
    $effects,
    $animation,
    $modifier,
    $variants,
  ];
}
