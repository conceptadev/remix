// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toast.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$ToastSpec implements Spec<ToastSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<FlexBoxSpec> get content;
  StyleSpec<TextSpec> get title;
  StyleSpec<TextSpec> get description;
  StyleSpec<IconSpec> get icon;
  Style<ButtonSpec>? get action;
  Style<IconButtonSpec>? get closeButton;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => ToastSpec;

  @override
  ToastSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<FlexBoxSpec>? content,
    StyleSpec<TextSpec>? title,
    StyleSpec<TextSpec>? description,
    StyleSpec<IconSpec>? icon,
    Style<ButtonSpec>? action,
    Style<IconButtonSpec>? closeButton,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return ToastSpec(
      container: container ?? this.container,
      content: content ?? this.content,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      action: action ?? this.action,
      closeButton: closeButton ?? this.closeButton,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  ToastSpec lerp(ToastSpec? other, double t) {
    return ToastSpec(
      container: container.lerp(other?.container, t),
      content: content.lerp(other?.content, t),
      title: title.lerp(other?.title, t),
      description: description.lerp(other?.description, t),
      icon: icon.lerp(other?.icon, t),
      action: MixOps.lerpSnap(action, other?.action, t),
      closeButton: MixOps.lerpSnap(closeButton, other?.closeButton, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [
    container,
    content,
    title,
    description,
    icon,
    action,
    closeButton,
    containerEffects,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ToastSpec &&
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
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('action', action))
      ..add(DiagnosticsProperty('closeButton', closeButton))
      ..add(DiagnosticsProperty('containerEffects', containerEffects));
  }
}

@Deprecated(
  'Rename to `_\$ToastSpec` and migrate the class declaration to `class ToastSpec with _\$ToastSpec`. The `_\$ToastSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$ToastSpecMethods = _$ToastSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class ToastStyler extends MixStyler<ToastStyler, ToastSpec>
    with RemixBoxStylerMixin<ToastStyler>, IconStyleMixin<ToastStyler>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<FlexBoxSpec>>? $content;
  final Prop<StyleSpec<TextSpec>>? $title;
  final Prop<StyleSpec<TextSpec>>? $description;
  final Prop<StyleSpec<IconSpec>>? $icon;
  final Prop<Style<ButtonSpec>>? $action;
  final Prop<Style<IconButtonSpec>>? $closeButton;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const ToastStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<FlexBoxSpec>>? content,
    Prop<StyleSpec<TextSpec>>? title,
    Prop<StyleSpec<TextSpec>>? description,
    Prop<StyleSpec<IconSpec>>? icon,
    Prop<Style<ButtonSpec>>? action,
    Prop<Style<IconButtonSpec>>? closeButton,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $content = content,
       $title = title,
       $description = description,
       $icon = icon,
       $action = action,
       $closeButton = closeButton,
       $containerEffects = containerEffects;

  ToastStyler({
    FlexBoxStyler? container,
    FlexBoxStyler? content,
    TextStyler? title,
    TextStyler? description,
    IconStyler? icon,
    Style<ButtonSpec>? action,
    Style<IconButtonSpec>? closeButton,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<ToastSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         content: Prop.maybeMix(content),
         title: Prop.maybeMix(title),
         description: Prop.maybeMix(description),
         icon: Prop.maybeMix(icon),
         action: Prop.maybe(action),
         closeButton: Prop.maybe(closeButton),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory ToastStyler.container(FlexBoxStyler value) =>
      ToastStyler().container(value);
  factory ToastStyler.content(FlexBoxStyler value) =>
      ToastStyler().content(value);
  factory ToastStyler.title(TextStyler value) => ToastStyler().title(value);
  factory ToastStyler.description(TextStyler value) =>
      ToastStyler().description(value);
  factory ToastStyler.icon(IconStyler value) => ToastStyler().icon(value);
  factory ToastStyler.action(Style<ButtonSpec> value) =>
      ToastStyler().action(value);
  factory ToastStyler.closeButton(Style<IconButtonSpec> value) =>
      ToastStyler().closeButton(value);
  factory ToastStyler.containerEffects(RemixBoxEffectsMix value) =>
      ToastStyler().containerEffects(value);
  factory ToastStyler.color(Color value) => ToastStyler().color(value);
  factory ToastStyler.gradient(GradientMix value) =>
      ToastStyler().gradient(value);
  factory ToastStyler.border(BoxBorderMix value) => ToastStyler().border(value);
  factory ToastStyler.borderRadius(BorderRadiusGeometryMix value) =>
      ToastStyler().borderRadius(value);
  factory ToastStyler.elevation(ElevationShadow value) =>
      ToastStyler().elevation(value);
  factory ToastStyler.shadow(BoxShadowMix value) => ToastStyler().shadow(value);
  factory ToastStyler.shadows(List<BoxShadowMix> value) =>
      ToastStyler().shadows(value);
  factory ToastStyler.width(double value) => ToastStyler().width(value);
  factory ToastStyler.height(double value) => ToastStyler().height(value);
  factory ToastStyler.size(double width, double height) =>
      ToastStyler().size(width, height);
  factory ToastStyler.minWidth(double value) => ToastStyler().minWidth(value);
  factory ToastStyler.maxWidth(double value) => ToastStyler().maxWidth(value);
  factory ToastStyler.minHeight(double value) => ToastStyler().minHeight(value);
  factory ToastStyler.maxHeight(double value) => ToastStyler().maxHeight(value);
  factory ToastStyler.scale(double scale, {Alignment alignment = .center}) =>
      ToastStyler().scale(scale, alignment: alignment);
  factory ToastStyler.rotate(double radians, {Alignment alignment = .center}) =>
      ToastStyler().rotate(radians, alignment: alignment);
  factory ToastStyler.translate(double x, double y, [double z = 0.0]) =>
      ToastStyler().translate(x, y, z);
  factory ToastStyler.skew(double skewX, double skewY) =>
      ToastStyler().skew(skewX, skewY);
  factory ToastStyler.textStyle(TextStyler value) =>
      ToastStyler().textStyle(value);
  factory ToastStyler.image(DecorationImageMix value) =>
      ToastStyler().image(value);
  factory ToastStyler.shape(ShapeBorderMix value) => ToastStyler().shape(value);
  factory ToastStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToastStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToastStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToastStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToastStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => ToastStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory ToastStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ToastStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ToastStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ToastStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ToastStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ToastStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ToastStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => ToastStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory ToastStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => ToastStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory ToastStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => ToastStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory ToastStyler.row() => ToastStyler().row();
  factory ToastStyler.column() => ToastStyler().column();
  factory ToastStyler.alignment(AlignmentGeometry value) =>
      ToastStyler().alignment(value);
  factory ToastStyler.padding(EdgeInsetsGeometryMix value) =>
      ToastStyler().padding(value);
  factory ToastStyler.margin(EdgeInsetsGeometryMix value) =>
      ToastStyler().margin(value);
  factory ToastStyler.constraints(BoxConstraintsMix value) =>
      ToastStyler().constraints(value);
  factory ToastStyler.decoration(DecorationMix value) =>
      ToastStyler().decoration(value);
  factory ToastStyler.foregroundDecoration(DecorationMix value) =>
      ToastStyler().foregroundDecoration(value);
  factory ToastStyler.clipBehavior(Clip value) =>
      ToastStyler().clipBehavior(value);
  factory ToastStyler.direction(Axis value) => ToastStyler().direction(value);
  factory ToastStyler.mainAxisAlignment(MainAxisAlignment value) =>
      ToastStyler().mainAxisAlignment(value);
  factory ToastStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      ToastStyler().crossAxisAlignment(value);
  factory ToastStyler.mainAxisSize(MainAxisSize value) =>
      ToastStyler().mainAxisSize(value);
  factory ToastStyler.spacing(double value) => ToastStyler().spacing(value);
  factory ToastStyler.verticalDirection(VerticalDirection value) =>
      ToastStyler().verticalDirection(value);
  factory ToastStyler.textDirection(TextDirection value) =>
      ToastStyler().textDirection(value);
  factory ToastStyler.textBaseline(TextBaseline value) =>
      ToastStyler().textBaseline(value);
  factory ToastStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => ToastStyler().transform(value, alignment: alignment);

  ToastStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  ToastStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  ToastStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  ToastStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  ToastStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  ToastStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  ToastStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  ToastStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  ToastStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  ToastStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  ToastStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  ToastStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  ToastStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  ToastStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  ToastStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  ToastStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  ToastStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  ToastStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  ToastStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  ToastStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  ToastStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  ToastStyler backgroundImage(
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

  ToastStyler backgroundImageUrl(
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

  ToastStyler backgroundImageAsset(
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

  ToastStyler linearGradient({
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

  ToastStyler radialGradient({
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

  ToastStyler sweepGradient({
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

  ToastStyler foregroundLinearGradient({
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

  ToastStyler foregroundRadialGradient({
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

  ToastStyler foregroundSweepGradient({
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

  ToastStyler row() {
    return container(FlexBoxStyler().row());
  }

  ToastStyler column() {
    return container(FlexBoxStyler().column());
  }

  ToastStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  ToastStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  ToastStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  ToastStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  ToastStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  ToastStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  ToastStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  ToastStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  ToastStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  ToastStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  ToastStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  ToastStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  ToastStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  ToastStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  ToastStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  ToastStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  @override
  Set<String> get $stylerFieldNames => const {
    'container',
    'content',
    'title',
    'description',
    'icon',
    'action',
    'closeButton',
    'containerEffects',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the container.
  ToastStyler container(FlexBoxStyler value) {
    return merge(ToastStyler(container: value));
  }

  /// Sets the content.
  ToastStyler content(FlexBoxStyler value) {
    return merge(ToastStyler(content: value));
  }

  /// Sets the title.
  ToastStyler title(TextStyler value) {
    return merge(ToastStyler(title: value));
  }

  /// Sets the description.
  ToastStyler description(TextStyler value) {
    return merge(ToastStyler(description: value));
  }

  /// Sets the icon.
  @override
  ToastStyler icon(IconStyler value) {
    return merge(ToastStyler(icon: value));
  }

  /// Sets the action.
  ToastStyler action(Style<ButtonSpec> value) {
    return merge(ToastStyler(action: value));
  }

  /// Sets the closeButton.
  ToastStyler closeButton(Style<IconButtonSpec> value) {
    return merge(ToastStyler(closeButton: value));
  }

  /// Sets the containerEffects.
  ToastStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(ToastStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  ToastStyler animate(AnimationConfig value) {
    return merge(ToastStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  ToastStyler variants(List<VariantStyle<ToastSpec>> value) {
    return merge(ToastStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  ToastStyler wrap(WidgetModifierConfig value) {
    return merge(ToastStyler(modifier: value));
  }

  /// Sets the widget modifier.
  ToastStyler modifier(WidgetModifierConfig value) {
    return merge(ToastStyler(modifier: value));
  }

  RemixToast call({
    Key? key,
    required String title,
    String? description,
    IconData? icon,
    RemixToastAction? action,
    VoidCallback? onDismiss,
    String? dismissLabel,
    bool excludeMessageSemantics = false,
  }) {
    return RemixToast(
      key: key,
      style: this,
      title: title,
      description: description,
      icon: icon,
      action: action,
      onDismiss: onDismiss,
      dismissLabel: dismissLabel,
      excludeMessageSemantics: excludeMessageSemantics,
    );
  }

  /// Merges with another [ToastStyler].
  @override
  ToastStyler merge(ToastStyler? other) {
    return ToastStyler.create(
      container: MixOps.merge($container, other?.$container),
      content: MixOps.merge($content, other?.$content),
      title: MixOps.merge($title, other?.$title),
      description: MixOps.merge($description, other?.$description),
      icon: MixOps.merge($icon, other?.$icon),
      action: MixOps.merge($action, other?.$action),
      closeButton: MixOps.merge($closeButton, other?.$closeButton),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<ToastSpec>] using [context].
  @override
  StyleSpec<ToastSpec> resolve(BuildContext context) {
    final spec = ToastSpec(
      container: MixOps.resolve(context, $container),
      content: MixOps.resolve(context, $content),
      title: MixOps.resolve(context, $title),
      description: MixOps.resolve(context, $description),
      icon: MixOps.resolve(context, $icon),
      action: MixOps.resolve(context, $action),
      closeButton: MixOps.resolve(context, $closeButton),
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
      ..add(DiagnosticsProperty('content', $content))
      ..add(DiagnosticsProperty('title', $title))
      ..add(DiagnosticsProperty('description', $description))
      ..add(DiagnosticsProperty('icon', $icon))
      ..add(DiagnosticsProperty('action', $action))
      ..add(DiagnosticsProperty('closeButton', $closeButton))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects));
  }

  @override
  List<Object?> get props => [
    $container,
    $content,
    $title,
    $description,
    $icon,
    $action,
    $closeButton,
    $containerEffects,
    $animation,
    $modifier,
    $variants,
  ];
}
