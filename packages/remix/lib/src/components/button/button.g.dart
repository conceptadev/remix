// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixButtonSpec implements Spec<RemixButtonSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;
  StyleSpec<RemixSpinnerSpec> get spinner;
  RemixSurfaceLayerSpec? get surface;
  RemixSurfaceLayerSpec? get overlay;

  @override
  Type get type => RemixButtonSpec;

  @override
  RemixButtonSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
    StyleSpec<RemixSpinnerSpec>? spinner,
    RemixSurfaceLayerSpec? surface,
    RemixSurfaceLayerSpec? overlay,
  }) {
    return RemixButtonSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      spinner: spinner ?? this.spinner,
      surface: surface ?? this.surface,
      overlay: overlay ?? this.overlay,
    );
  }

  @override
  RemixButtonSpec lerp(RemixButtonSpec? other, double t) {
    return RemixButtonSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      icon: icon.lerp(other?.icon, t),
      spinner: spinner.lerp(other?.spinner, t),
      surface: MixOps.lerpSnap(surface, other?.surface, t),
      overlay: MixOps.lerpSnap(overlay, other?.overlay, t),
    );
  }

  @override
  List<Object?> get props => [
    container,
    label,
    icon,
    spinner,
    surface,
    overlay,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixButtonSpec &&
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
      ..add(DiagnosticsProperty('surface', surface))
      ..add(DiagnosticsProperty('overlay', overlay));
  }
}

@Deprecated(
  'Rename to `_\$RemixButtonSpec` and migrate the class declaration to `class RemixButtonSpec with _\$RemixButtonSpec`. The `_\$RemixButtonSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixButtonSpecMethods = _$RemixButtonSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixButtonStyler extends MixStyler<RemixButtonStyler, RemixButtonSpec>
    with
        RemixBoxStylerMixin<RemixButtonStyler>,
        LabelStyleMixin<RemixButtonStyler>,
        IconStyleMixin<RemixButtonStyler>,
        SpinnerStyleMixin<RemixButtonStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;
  final Prop<StyleSpec<RemixSpinnerSpec>>? $spinner;
  final Prop<RemixSurfaceLayerSpec>? $surface;
  final Prop<RemixSurfaceLayerSpec>? $overlay;

  const RemixButtonStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    Prop<StyleSpec<RemixSpinnerSpec>>? spinner,
    Prop<RemixSurfaceLayerSpec>? surface,
    Prop<RemixSurfaceLayerSpec>? overlay,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon,
       $spinner = spinner,
       $surface = surface,
       $overlay = overlay;

  RemixButtonStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    RemixSpinnerStyler? spinner,
    RemixSurfaceLayerMix? surface,
    RemixSurfaceLayerMix? overlay,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixButtonSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         spinner: Prop.maybeMix(spinner),
         surface: Prop.maybeMix(surface),
         overlay: Prop.maybeMix(overlay),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixButtonStyler.container(FlexBoxStyler value) =>
      RemixButtonStyler().container(value);
  factory RemixButtonStyler.label(TextStyler value) =>
      RemixButtonStyler().label(value);
  factory RemixButtonStyler.icon(IconStyler value) =>
      RemixButtonStyler().icon(value);
  factory RemixButtonStyler.spinner(RemixSpinnerStyler value) =>
      RemixButtonStyler().spinner(value);
  factory RemixButtonStyler.surface(RemixSurfaceLayerMix value) =>
      RemixButtonStyler().surface(value);
  factory RemixButtonStyler.overlay(RemixSurfaceLayerMix value) =>
      RemixButtonStyler().overlay(value);
  factory RemixButtonStyler.color(Color value) =>
      RemixButtonStyler().color(value);
  factory RemixButtonStyler.gradient(GradientMix value) =>
      RemixButtonStyler().gradient(value);
  factory RemixButtonStyler.border(BoxBorderMix value) =>
      RemixButtonStyler().border(value);
  factory RemixButtonStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixButtonStyler().borderRadius(value);
  factory RemixButtonStyler.elevation(ElevationShadow value) =>
      RemixButtonStyler().elevation(value);
  factory RemixButtonStyler.shadow(BoxShadowMix value) =>
      RemixButtonStyler().shadow(value);
  factory RemixButtonStyler.shadows(List<BoxShadowMix> value) =>
      RemixButtonStyler().shadows(value);
  factory RemixButtonStyler.width(double value) =>
      RemixButtonStyler().width(value);
  factory RemixButtonStyler.height(double value) =>
      RemixButtonStyler().height(value);
  factory RemixButtonStyler.size(double width, double height) =>
      RemixButtonStyler().size(width, height);
  factory RemixButtonStyler.minWidth(double value) =>
      RemixButtonStyler().minWidth(value);
  factory RemixButtonStyler.maxWidth(double value) =>
      RemixButtonStyler().maxWidth(value);
  factory RemixButtonStyler.minHeight(double value) =>
      RemixButtonStyler().minHeight(value);
  factory RemixButtonStyler.maxHeight(double value) =>
      RemixButtonStyler().maxHeight(value);
  factory RemixButtonStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixButtonStyler().scale(scale, alignment: alignment);
  factory RemixButtonStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixButtonStyler().rotate(radians, alignment: alignment);
  factory RemixButtonStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixButtonStyler().translate(x, y, z);
  factory RemixButtonStyler.skew(double skewX, double skewY) =>
      RemixButtonStyler().skew(skewX, skewY);
  factory RemixButtonStyler.textStyle(TextStyler value) =>
      RemixButtonStyler().textStyle(value);
  factory RemixButtonStyler.image(DecorationImageMix value) =>
      RemixButtonStyler().image(value);
  factory RemixButtonStyler.shape(ShapeBorderMix value) =>
      RemixButtonStyler().shape(value);
  factory RemixButtonStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixButtonStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixButtonStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixButtonStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixButtonStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixButtonStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixButtonStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixButtonStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixButtonStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixButtonStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixButtonStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixButtonStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixButtonStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixButtonStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixButtonStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixButtonStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixButtonStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixButtonStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixButtonStyler.row() => RemixButtonStyler().row();
  factory RemixButtonStyler.column() => RemixButtonStyler().column();
  factory RemixButtonStyler.alignment(AlignmentGeometry value) =>
      RemixButtonStyler().alignment(value);
  factory RemixButtonStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixButtonStyler().padding(value);
  factory RemixButtonStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixButtonStyler().margin(value);
  factory RemixButtonStyler.constraints(BoxConstraintsMix value) =>
      RemixButtonStyler().constraints(value);
  factory RemixButtonStyler.decoration(DecorationMix value) =>
      RemixButtonStyler().decoration(value);
  factory RemixButtonStyler.foregroundDecoration(DecorationMix value) =>
      RemixButtonStyler().foregroundDecoration(value);
  factory RemixButtonStyler.clipBehavior(Clip value) =>
      RemixButtonStyler().clipBehavior(value);
  factory RemixButtonStyler.direction(Axis value) =>
      RemixButtonStyler().direction(value);
  factory RemixButtonStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixButtonStyler().mainAxisAlignment(value);
  factory RemixButtonStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixButtonStyler().crossAxisAlignment(value);
  factory RemixButtonStyler.mainAxisSize(MainAxisSize value) =>
      RemixButtonStyler().mainAxisSize(value);
  factory RemixButtonStyler.spacing(double value) =>
      RemixButtonStyler().spacing(value);
  factory RemixButtonStyler.verticalDirection(VerticalDirection value) =>
      RemixButtonStyler().verticalDirection(value);
  factory RemixButtonStyler.textDirection(TextDirection value) =>
      RemixButtonStyler().textDirection(value);
  factory RemixButtonStyler.textBaseline(TextBaseline value) =>
      RemixButtonStyler().textBaseline(value);
  factory RemixButtonStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixButtonStyler().transform(value, alignment: alignment);

  RemixButtonStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixButtonStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixButtonStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixButtonStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixButtonStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixButtonStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixButtonStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixButtonStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixButtonStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixButtonStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixButtonStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixButtonStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixButtonStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixButtonStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixButtonStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixButtonStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixButtonStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixButtonStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixButtonStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixButtonStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixButtonStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixButtonStyler backgroundImage(
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

  RemixButtonStyler backgroundImageUrl(
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

  RemixButtonStyler backgroundImageAsset(
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

  RemixButtonStyler linearGradient({
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

  RemixButtonStyler radialGradient({
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

  RemixButtonStyler sweepGradient({
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

  RemixButtonStyler foregroundLinearGradient({
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

  RemixButtonStyler foregroundRadialGradient({
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

  RemixButtonStyler foregroundSweepGradient({
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

  RemixButtonStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixButtonStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixButtonStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixButtonStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixButtonStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixButtonStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixButtonStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixButtonStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixButtonStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixButtonStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixButtonStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixButtonStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixButtonStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixButtonStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixButtonStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixButtonStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixButtonStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixButtonStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixButtonStyler container(FlexBoxStyler value) {
    return merge(RemixButtonStyler(container: value));
  }

  /// Sets the label.
  @override
  RemixButtonStyler label(TextStyler value) {
    return merge(RemixButtonStyler(label: value));
  }

  /// Sets the icon.
  @override
  RemixButtonStyler icon(IconStyler value) {
    return merge(RemixButtonStyler(icon: value));
  }

  /// Sets the spinner.
  @override
  RemixButtonStyler spinner(RemixSpinnerStyler value) {
    return merge(RemixButtonStyler(spinner: value));
  }

  /// Sets the surface.
  RemixButtonStyler surface(RemixSurfaceLayerMix value) {
    return merge(RemixButtonStyler(surface: value));
  }

  /// Sets the overlay.
  RemixButtonStyler overlay(RemixSurfaceLayerMix value) {
    return merge(RemixButtonStyler(overlay: value));
  }

  /// Sets the animation configuration.
  @override
  RemixButtonStyler animate(AnimationConfig value) {
    return merge(RemixButtonStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixButtonStyler variants(List<VariantStyle<RemixButtonSpec>> value) {
    return merge(RemixButtonStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixButtonStyler wrap(WidgetModifierConfig value) {
    return merge(RemixButtonStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixButtonStyler modifier(WidgetModifierConfig value) {
    return merge(RemixButtonStyler(modifier: value));
  }

  /// Merges with another [RemixButtonStyler].
  @override
  RemixButtonStyler merge(RemixButtonStyler? other) {
    return RemixButtonStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      spinner: MixOps.merge($spinner, other?.$spinner),
      surface: MixOps.merge($surface, other?.$surface),
      overlay: MixOps.merge($overlay, other?.$overlay),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixButtonSpec>] using [context].
  @override
  StyleSpec<RemixButtonSpec> resolve(BuildContext context) {
    final spec = RemixButtonSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      icon: MixOps.resolve(context, $icon),
      spinner: MixOps.resolve(context, $spinner),
      surface: MixOps.resolve(context, $surface),
      overlay: MixOps.resolve(context, $overlay),
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
      ..add(DiagnosticsProperty('surface', $surface))
      ..add(DiagnosticsProperty('overlay', $overlay));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $icon,
    $spinner,
    $surface,
    $overlay,
    $animation,
    $modifier,
    $variants,
  ];
}
