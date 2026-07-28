// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toggle.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixToggleSpec implements Spec<RemixToggleSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => RemixToggleSpec;

  @override
  RemixToggleSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) {
    return RemixToggleSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  @override
  RemixToggleSpec lerp(RemixToggleSpec? other, double t) {
    return RemixToggleSpec(
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
        other is RemixToggleSpec &&
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
  'Rename to `_\$RemixToggleSpec` and migrate the class declaration to `class RemixToggleSpec with _\$RemixToggleSpec`. The `_\$RemixToggleSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixToggleSpecMethods = _$RemixToggleSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixToggle].
class FortalToggle extends StatelessWidget {
  const FortalToggle({
    super.key,
    this.variant = .ghost,
    this.size = .size2,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.label,
    this.icon,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  });

  const FortalToggle.ghost({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.label,
    this.icon,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalToggleVariant.ghost;

  const FortalToggle.outline({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.selected,
    this.onChanged,
    this.enabled = true,
    this.label,
    this.icon,
    this.enableFeedback = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.mouseCursor = SystemMouseCursors.click,
  }) : variant = FortalToggleVariant.outline;

  final FortalToggleVariant variant;

  final FortalToggleSize size;

  final bool highContrast;

  final bool selected;

  final ValueChanged<bool>? onChanged;

  final bool enabled;

  final String? label;

  final IconData? icon;

  final bool enableFeedback;

  final FocusNode? focusNode;

  final bool autofocus;

  final String? semanticLabel;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return RemixToggle(
      key: this.key,
      style: fortalToggleStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ),
      selected: this.selected,
      onChanged: this.onChanged,
      enabled: this.enabled,
      label: this.label,
      icon: this.icon,
      enableFeedback: this.enableFeedback,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      semanticLabel: this.semanticLabel,
      mouseCursor: this.mouseCursor,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixToggleStyler extends MixStyler<RemixToggleStyler, RemixToggleSpec>
    with
        RemixBoxStylerMixin<RemixToggleStyler>,
        LabelStyleMixin<RemixToggleStyler>,
        IconStyleMixin<RemixToggleStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const RemixToggleStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon;

  RemixToggleStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixToggleSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixToggleStyler.container(FlexBoxStyler value) =>
      RemixToggleStyler().container(value);
  factory RemixToggleStyler.label(TextStyler value) =>
      RemixToggleStyler().label(value);
  factory RemixToggleStyler.icon(IconStyler value) =>
      RemixToggleStyler().icon(value);
  factory RemixToggleStyler.color(Color value) =>
      RemixToggleStyler().color(value);
  factory RemixToggleStyler.gradient(GradientMix value) =>
      RemixToggleStyler().gradient(value);
  factory RemixToggleStyler.border(BoxBorderMix value) =>
      RemixToggleStyler().border(value);
  factory RemixToggleStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixToggleStyler().borderRadius(value);
  factory RemixToggleStyler.elevation(ElevationShadow value) =>
      RemixToggleStyler().elevation(value);
  factory RemixToggleStyler.shadow(BoxShadowMix value) =>
      RemixToggleStyler().shadow(value);
  factory RemixToggleStyler.shadows(List<BoxShadowMix> value) =>
      RemixToggleStyler().shadows(value);
  factory RemixToggleStyler.width(double value) =>
      RemixToggleStyler().width(value);
  factory RemixToggleStyler.height(double value) =>
      RemixToggleStyler().height(value);
  factory RemixToggleStyler.size(double width, double height) =>
      RemixToggleStyler().size(width, height);
  factory RemixToggleStyler.minWidth(double value) =>
      RemixToggleStyler().minWidth(value);
  factory RemixToggleStyler.maxWidth(double value) =>
      RemixToggleStyler().maxWidth(value);
  factory RemixToggleStyler.minHeight(double value) =>
      RemixToggleStyler().minHeight(value);
  factory RemixToggleStyler.maxHeight(double value) =>
      RemixToggleStyler().maxHeight(value);
  factory RemixToggleStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixToggleStyler().scale(scale, alignment: alignment);
  factory RemixToggleStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixToggleStyler().rotate(radians, alignment: alignment);
  factory RemixToggleStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixToggleStyler().translate(x, y, z);
  factory RemixToggleStyler.skew(double skewX, double skewY) =>
      RemixToggleStyler().skew(skewX, skewY);
  factory RemixToggleStyler.textStyle(TextStyler value) =>
      RemixToggleStyler().textStyle(value);
  factory RemixToggleStyler.image(DecorationImageMix value) =>
      RemixToggleStyler().image(value);
  factory RemixToggleStyler.shape(ShapeBorderMix value) =>
      RemixToggleStyler().shape(value);
  factory RemixToggleStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixToggleStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixToggleStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixToggleStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixToggleStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixToggleStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixToggleStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixToggleStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixToggleStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixToggleStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixToggleStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixToggleStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixToggleStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixToggleStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixToggleStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixToggleStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixToggleStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixToggleStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixToggleStyler.row() => RemixToggleStyler().row();
  factory RemixToggleStyler.column() => RemixToggleStyler().column();
  factory RemixToggleStyler.alignment(AlignmentGeometry value) =>
      RemixToggleStyler().alignment(value);
  factory RemixToggleStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixToggleStyler().padding(value);
  factory RemixToggleStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixToggleStyler().margin(value);
  factory RemixToggleStyler.constraints(BoxConstraintsMix value) =>
      RemixToggleStyler().constraints(value);
  factory RemixToggleStyler.decoration(DecorationMix value) =>
      RemixToggleStyler().decoration(value);
  factory RemixToggleStyler.foregroundDecoration(DecorationMix value) =>
      RemixToggleStyler().foregroundDecoration(value);
  factory RemixToggleStyler.clipBehavior(Clip value) =>
      RemixToggleStyler().clipBehavior(value);
  factory RemixToggleStyler.direction(Axis value) =>
      RemixToggleStyler().direction(value);
  factory RemixToggleStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixToggleStyler().mainAxisAlignment(value);
  factory RemixToggleStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixToggleStyler().crossAxisAlignment(value);
  factory RemixToggleStyler.mainAxisSize(MainAxisSize value) =>
      RemixToggleStyler().mainAxisSize(value);
  factory RemixToggleStyler.spacing(double value) =>
      RemixToggleStyler().spacing(value);
  factory RemixToggleStyler.verticalDirection(VerticalDirection value) =>
      RemixToggleStyler().verticalDirection(value);
  factory RemixToggleStyler.textDirection(TextDirection value) =>
      RemixToggleStyler().textDirection(value);
  factory RemixToggleStyler.textBaseline(TextBaseline value) =>
      RemixToggleStyler().textBaseline(value);
  factory RemixToggleStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixToggleStyler().transform(value, alignment: alignment);

  RemixToggleStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixToggleStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixToggleStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixToggleStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixToggleStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixToggleStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixToggleStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixToggleStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixToggleStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixToggleStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixToggleStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixToggleStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixToggleStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixToggleStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixToggleStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixToggleStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixToggleStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixToggleStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixToggleStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixToggleStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixToggleStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixToggleStyler backgroundImage(
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

  RemixToggleStyler backgroundImageUrl(
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

  RemixToggleStyler backgroundImageAsset(
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

  RemixToggleStyler linearGradient({
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

  RemixToggleStyler radialGradient({
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

  RemixToggleStyler sweepGradient({
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

  RemixToggleStyler foregroundLinearGradient({
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

  RemixToggleStyler foregroundRadialGradient({
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

  RemixToggleStyler foregroundSweepGradient({
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

  RemixToggleStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixToggleStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixToggleStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixToggleStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixToggleStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixToggleStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixToggleStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixToggleStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixToggleStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixToggleStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixToggleStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixToggleStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixToggleStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixToggleStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixToggleStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixToggleStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixToggleStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixToggleStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixToggleStyler container(FlexBoxStyler value) {
    return merge(RemixToggleStyler(container: value));
  }

  /// Sets the label.
  @override
  RemixToggleStyler label(TextStyler value) {
    return merge(RemixToggleStyler(label: value));
  }

  /// Sets the icon.
  @override
  RemixToggleStyler icon(IconStyler value) {
    return merge(RemixToggleStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  RemixToggleStyler animate(AnimationConfig value) {
    return merge(RemixToggleStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixToggleStyler variants(List<VariantStyle<RemixToggleSpec>> value) {
    return merge(RemixToggleStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixToggleStyler wrap(WidgetModifierConfig value) {
    return merge(RemixToggleStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixToggleStyler modifier(WidgetModifierConfig value) {
    return merge(RemixToggleStyler(modifier: value));
  }

  /// Merges with another [RemixToggleStyler].
  @override
  RemixToggleStyler merge(RemixToggleStyler? other) {
    return RemixToggleStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixToggleSpec>] using [context].
  @override
  StyleSpec<RemixToggleSpec> resolve(BuildContext context) {
    final spec = RemixToggleSpec(
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
