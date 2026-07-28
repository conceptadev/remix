// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accordion.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixAccordionSpec implements Spec<RemixAccordionSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get trigger;
  StyleSpec<IconSpec> get leadingIcon;
  StyleSpec<TextSpec> get title;
  StyleSpec<IconSpec> get trailingIcon;
  StyleSpec<BoxSpec> get content;

  @override
  Type get type => RemixAccordionSpec;

  @override
  RemixAccordionSpec copyWith({
    StyleSpec<FlexBoxSpec>? trigger,
    StyleSpec<IconSpec>? leadingIcon,
    StyleSpec<TextSpec>? title,
    StyleSpec<IconSpec>? trailingIcon,
    StyleSpec<BoxSpec>? content,
  }) {
    return RemixAccordionSpec(
      trigger: trigger ?? this.trigger,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      title: title ?? this.title,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      content: content ?? this.content,
    );
  }

  @override
  RemixAccordionSpec lerp(RemixAccordionSpec? other, double t) {
    return RemixAccordionSpec(
      trigger: trigger.lerp(other?.trigger, t),
      leadingIcon: leadingIcon.lerp(other?.leadingIcon, t),
      title: title.lerp(other?.title, t),
      trailingIcon: trailingIcon.lerp(other?.trailingIcon, t),
      content: content.lerp(other?.content, t),
    );
  }

  @override
  List<Object?> get props => [
    trigger,
    leadingIcon,
    title,
    trailingIcon,
    content,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixAccordionSpec &&
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
      ..add(DiagnosticsProperty('trigger', trigger))
      ..add(DiagnosticsProperty('leadingIcon', leadingIcon))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('trailingIcon', trailingIcon))
      ..add(DiagnosticsProperty('content', content));
  }
}

@Deprecated(
  'Rename to `_\$RemixAccordionSpec` and migrate the class declaration to `class RemixAccordionSpec with _\$RemixAccordionSpec`. The `_\$RemixAccordionSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixAccordionSpecMethods = _$RemixAccordionSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal-themed preset for [RemixAccordion].
class FortalAccordion<T> extends StatelessWidget {
  const FortalAccordion({
    super.key,
    this.variant = .surface,
    this.size = .size2,
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.builder,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.transitionBuilder = RemixAccordion.defaultAccordionTransitionBuilder,
  });

  const FortalAccordion.surface({
    super.key,
    this.size = .size2,
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.builder,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.transitionBuilder = RemixAccordion.defaultAccordionTransitionBuilder,
  }) : variant = FortalAccordionVariant.surface;

  const FortalAccordion.soft({
    super.key,
    this.size = .size2,
    required this.value,
    required this.child,
    this.title,
    this.leadingIcon,
    this.trailingIcon,
    this.builder,
    this.enabled = true,
    this.mouseCursor = SystemMouseCursors.click,
    this.enableFeedback = true,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
    this.onHoverChange,
    this.onPressChange,
    this.semanticLabel,
    this.transitionBuilder = RemixAccordion.defaultAccordionTransitionBuilder,
  }) : variant = FortalAccordionVariant.soft;

  final FortalAccordionVariant variant;

  final FortalAccordionSize size;

  final T value;

  final Widget child;

  final String? title;

  final IconData? leadingIcon;

  final IconData? trailingIcon;

  final NakedAccordionTriggerBuilder<T>? builder;

  final bool enabled;

  final MouseCursor mouseCursor;

  final bool enableFeedback;

  final bool autofocus;

  final FocusNode? focusNode;

  final ValueChanged<bool>? onFocusChange;

  final ValueChanged<bool>? onHoverChange;

  final ValueChanged<bool>? onPressChange;

  final String? semanticLabel;

  final Widget Function(Widget, Animation<double>) transitionBuilder;

  @override
  Widget build(BuildContext context) {
    return RemixAccordion<T>(
      key: this.key,
      style: fortalAccordionStyle(variant: this.variant, size: this.size),
      value: this.value,
      child: this.child,
      title: this.title,
      leadingIcon: this.leadingIcon,
      trailingIcon: this.trailingIcon,
      builder: this.builder,
      enabled: this.enabled,
      mouseCursor: this.mouseCursor,
      enableFeedback: this.enableFeedback,
      autofocus: this.autofocus,
      focusNode: this.focusNode,
      onFocusChange: this.onFocusChange,
      onHoverChange: this.onHoverChange,
      onPressChange: this.onPressChange,
      semanticLabel: this.semanticLabel,
      transitionBuilder: this.transitionBuilder,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixAccordionStyler
    extends MixStyler<RemixAccordionStyler, RemixAccordionSpec>
    with RemixBoxStylerMixin<RemixAccordionStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $trigger;
  final Prop<StyleSpec<IconSpec>>? $leadingIcon;
  final Prop<StyleSpec<TextSpec>>? $title;
  final Prop<StyleSpec<IconSpec>>? $trailingIcon;
  final Prop<StyleSpec<BoxSpec>>? $content;

  const RemixAccordionStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? trigger,
    Prop<StyleSpec<IconSpec>>? leadingIcon,
    Prop<StyleSpec<TextSpec>>? title,
    Prop<StyleSpec<IconSpec>>? trailingIcon,
    Prop<StyleSpec<BoxSpec>>? content,
    super.variants,
    super.modifier,
    super.animation,
  }) : $trigger = trigger,
       $leadingIcon = leadingIcon,
       $title = title,
       $trailingIcon = trailingIcon,
       $content = content;

  RemixAccordionStyler({
    FlexBoxStyler? trigger,
    IconStyler? leadingIcon,
    TextStyler? title,
    IconStyler? trailingIcon,
    BoxStyler? content,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixAccordionSpec>>? variants,
  }) : this.create(
         trigger: Prop.maybeMix(trigger),
         leadingIcon: Prop.maybeMix(leadingIcon),
         title: Prop.maybeMix(title),
         trailingIcon: Prop.maybeMix(trailingIcon),
         content: Prop.maybeMix(content),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixAccordionStyler.trigger(FlexBoxStyler value) =>
      RemixAccordionStyler().trigger(value);
  factory RemixAccordionStyler.leadingIcon(IconStyler value) =>
      RemixAccordionStyler().leadingIcon(value);
  factory RemixAccordionStyler.title(TextStyler value) =>
      RemixAccordionStyler().title(value);
  factory RemixAccordionStyler.trailingIcon(IconStyler value) =>
      RemixAccordionStyler().trailingIcon(value);
  factory RemixAccordionStyler.content(BoxStyler value) =>
      RemixAccordionStyler().content(value);
  factory RemixAccordionStyler.color(Color value) =>
      RemixAccordionStyler().color(value);
  factory RemixAccordionStyler.gradient(GradientMix value) =>
      RemixAccordionStyler().gradient(value);
  factory RemixAccordionStyler.border(BoxBorderMix value) =>
      RemixAccordionStyler().border(value);
  factory RemixAccordionStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixAccordionStyler().borderRadius(value);
  factory RemixAccordionStyler.elevation(ElevationShadow value) =>
      RemixAccordionStyler().elevation(value);
  factory RemixAccordionStyler.shadow(BoxShadowMix value) =>
      RemixAccordionStyler().shadow(value);
  factory RemixAccordionStyler.shadows(List<BoxShadowMix> value) =>
      RemixAccordionStyler().shadows(value);
  factory RemixAccordionStyler.width(double value) =>
      RemixAccordionStyler().width(value);
  factory RemixAccordionStyler.height(double value) =>
      RemixAccordionStyler().height(value);
  factory RemixAccordionStyler.size(double width, double height) =>
      RemixAccordionStyler().size(width, height);
  factory RemixAccordionStyler.minWidth(double value) =>
      RemixAccordionStyler().minWidth(value);
  factory RemixAccordionStyler.maxWidth(double value) =>
      RemixAccordionStyler().maxWidth(value);
  factory RemixAccordionStyler.minHeight(double value) =>
      RemixAccordionStyler().minHeight(value);
  factory RemixAccordionStyler.maxHeight(double value) =>
      RemixAccordionStyler().maxHeight(value);
  factory RemixAccordionStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixAccordionStyler().scale(scale, alignment: alignment);
  factory RemixAccordionStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixAccordionStyler().rotate(radians, alignment: alignment);
  factory RemixAccordionStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => RemixAccordionStyler().translate(x, y, z);
  factory RemixAccordionStyler.skew(double skewX, double skewY) =>
      RemixAccordionStyler().skew(skewX, skewY);
  factory RemixAccordionStyler.textStyle(TextStyler value) =>
      RemixAccordionStyler().textStyle(value);
  factory RemixAccordionStyler.image(DecorationImageMix value) =>
      RemixAccordionStyler().image(value);
  factory RemixAccordionStyler.shape(ShapeBorderMix value) =>
      RemixAccordionStyler().shape(value);
  factory RemixAccordionStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixAccordionStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixAccordionStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixAccordionStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixAccordionStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixAccordionStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixAccordionStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixAccordionStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixAccordionStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixAccordionStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixAccordionStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixAccordionStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixAccordionStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixAccordionStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixAccordionStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixAccordionStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixAccordionStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixAccordionStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixAccordionStyler.row() => RemixAccordionStyler().row();
  factory RemixAccordionStyler.column() => RemixAccordionStyler().column();
  factory RemixAccordionStyler.alignment(AlignmentGeometry value) =>
      RemixAccordionStyler().alignment(value);
  factory RemixAccordionStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixAccordionStyler().padding(value);
  factory RemixAccordionStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixAccordionStyler().margin(value);
  factory RemixAccordionStyler.constraints(BoxConstraintsMix value) =>
      RemixAccordionStyler().constraints(value);
  factory RemixAccordionStyler.decoration(DecorationMix value) =>
      RemixAccordionStyler().decoration(value);
  factory RemixAccordionStyler.foregroundDecoration(DecorationMix value) =>
      RemixAccordionStyler().foregroundDecoration(value);
  factory RemixAccordionStyler.clipBehavior(Clip value) =>
      RemixAccordionStyler().clipBehavior(value);
  factory RemixAccordionStyler.direction(Axis value) =>
      RemixAccordionStyler().direction(value);
  factory RemixAccordionStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixAccordionStyler().mainAxisAlignment(value);
  factory RemixAccordionStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixAccordionStyler().crossAxisAlignment(value);
  factory RemixAccordionStyler.mainAxisSize(MainAxisSize value) =>
      RemixAccordionStyler().mainAxisSize(value);
  factory RemixAccordionStyler.spacing(double value) =>
      RemixAccordionStyler().spacing(value);
  factory RemixAccordionStyler.verticalDirection(VerticalDirection value) =>
      RemixAccordionStyler().verticalDirection(value);
  factory RemixAccordionStyler.textDirection(TextDirection value) =>
      RemixAccordionStyler().textDirection(value);
  factory RemixAccordionStyler.textBaseline(TextBaseline value) =>
      RemixAccordionStyler().textBaseline(value);
  factory RemixAccordionStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixAccordionStyler().transform(value, alignment: alignment);

  RemixAccordionStyler color(Color value) {
    return trigger(FlexBoxStyler().color(value));
  }

  RemixAccordionStyler gradient(GradientMix value) {
    return trigger(FlexBoxStyler().gradient(value));
  }

  RemixAccordionStyler border(BoxBorderMix value) {
    return trigger(FlexBoxStyler().border(value));
  }

  RemixAccordionStyler borderRadius(BorderRadiusGeometryMix value) {
    return trigger(FlexBoxStyler().borderRadius(value));
  }

  RemixAccordionStyler elevation(ElevationShadow value) {
    return trigger(FlexBoxStyler().elevation(value));
  }

  RemixAccordionStyler shadow(BoxShadowMix value) {
    return trigger(FlexBoxStyler().shadow(value));
  }

  RemixAccordionStyler shadows(List<BoxShadowMix> value) {
    return trigger(FlexBoxStyler().shadows(value));
  }

  RemixAccordionStyler width(double value) {
    return trigger(FlexBoxStyler().width(value));
  }

  RemixAccordionStyler height(double value) {
    return trigger(FlexBoxStyler().height(value));
  }

  RemixAccordionStyler size(double width, double height) {
    return trigger(FlexBoxStyler().size(width, height));
  }

  RemixAccordionStyler minWidth(double value) {
    return trigger(FlexBoxStyler().minWidth(value));
  }

  RemixAccordionStyler maxWidth(double value) {
    return trigger(FlexBoxStyler().maxWidth(value));
  }

  RemixAccordionStyler minHeight(double value) {
    return trigger(FlexBoxStyler().minHeight(value));
  }

  RemixAccordionStyler maxHeight(double value) {
    return trigger(FlexBoxStyler().maxHeight(value));
  }

  RemixAccordionStyler scale(double scale, {Alignment alignment = .center}) {
    return trigger(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixAccordionStyler rotate(double radians, {Alignment alignment = .center}) {
    return trigger(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixAccordionStyler translate(double x, double y, [double z = 0.0]) {
    return trigger(FlexBoxStyler().translate(x, y, z));
  }

  RemixAccordionStyler skew(double skewX, double skewY) {
    return trigger(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixAccordionStyler textStyle(TextStyler value) {
    return trigger(FlexBoxStyler().textStyle(value));
  }

  RemixAccordionStyler image(DecorationImageMix value) {
    return trigger(FlexBoxStyler().image(value));
  }

  RemixAccordionStyler shape(ShapeBorderMix value) {
    return trigger(FlexBoxStyler().shape(value));
  }

  RemixAccordionStyler backgroundImage(
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

  RemixAccordionStyler backgroundImageUrl(
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

  RemixAccordionStyler backgroundImageAsset(
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

  RemixAccordionStyler linearGradient({
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

  RemixAccordionStyler radialGradient({
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

  RemixAccordionStyler sweepGradient({
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

  RemixAccordionStyler foregroundLinearGradient({
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

  RemixAccordionStyler foregroundRadialGradient({
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

  RemixAccordionStyler foregroundSweepGradient({
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

  RemixAccordionStyler row() {
    return trigger(FlexBoxStyler().row());
  }

  RemixAccordionStyler column() {
    return trigger(FlexBoxStyler().column());
  }

  RemixAccordionStyler alignment(AlignmentGeometry value) {
    return trigger(FlexBoxStyler().alignment(value));
  }

  RemixAccordionStyler padding(EdgeInsetsGeometryMix value) {
    return trigger(FlexBoxStyler().padding(value));
  }

  RemixAccordionStyler margin(EdgeInsetsGeometryMix value) {
    return trigger(FlexBoxStyler().margin(value));
  }

  RemixAccordionStyler constraints(BoxConstraintsMix value) {
    return trigger(FlexBoxStyler().constraints(value));
  }

  RemixAccordionStyler decoration(DecorationMix value) {
    return trigger(FlexBoxStyler().decoration(value));
  }

  RemixAccordionStyler foregroundDecoration(DecorationMix value) {
    return trigger(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixAccordionStyler clipBehavior(Clip value) {
    return trigger(FlexBoxStyler().clipBehavior(value));
  }

  RemixAccordionStyler direction(Axis value) {
    return trigger(FlexBoxStyler().direction(value));
  }

  RemixAccordionStyler mainAxisAlignment(MainAxisAlignment value) {
    return trigger(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixAccordionStyler crossAxisAlignment(CrossAxisAlignment value) {
    return trigger(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixAccordionStyler mainAxisSize(MainAxisSize value) {
    return trigger(FlexBoxStyler().mainAxisSize(value));
  }

  RemixAccordionStyler spacing(double value) {
    return trigger(FlexBoxStyler().spacing(value));
  }

  RemixAccordionStyler verticalDirection(VerticalDirection value) {
    return trigger(FlexBoxStyler().verticalDirection(value));
  }

  RemixAccordionStyler textDirection(TextDirection value) {
    return trigger(FlexBoxStyler().textDirection(value));
  }

  RemixAccordionStyler textBaseline(TextBaseline value) {
    return trigger(FlexBoxStyler().textBaseline(value));
  }

  RemixAccordionStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return trigger(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the trigger.
  RemixAccordionStyler trigger(FlexBoxStyler value) {
    return merge(RemixAccordionStyler(trigger: value));
  }

  /// Sets the leadingIcon.
  RemixAccordionStyler leadingIcon(IconStyler value) {
    return merge(RemixAccordionStyler(leadingIcon: value));
  }

  /// Sets the title.
  RemixAccordionStyler title(TextStyler value) {
    return merge(RemixAccordionStyler(title: value));
  }

  /// Sets the trailingIcon.
  RemixAccordionStyler trailingIcon(IconStyler value) {
    return merge(RemixAccordionStyler(trailingIcon: value));
  }

  /// Sets the content.
  RemixAccordionStyler content(BoxStyler value) {
    return merge(RemixAccordionStyler(content: value));
  }

  /// Sets the animation configuration.
  @override
  RemixAccordionStyler animate(AnimationConfig value) {
    return merge(RemixAccordionStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixAccordionStyler variants(List<VariantStyle<RemixAccordionSpec>> value) {
    return merge(RemixAccordionStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixAccordionStyler wrap(WidgetModifierConfig value) {
    return merge(RemixAccordionStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixAccordionStyler modifier(WidgetModifierConfig value) {
    return merge(RemixAccordionStyler(modifier: value));
  }

  /// Merges with another [RemixAccordionStyler].
  @override
  RemixAccordionStyler merge(RemixAccordionStyler? other) {
    return RemixAccordionStyler.create(
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

  /// Resolves to [StyleSpec<RemixAccordionSpec>] using [context].
  @override
  StyleSpec<RemixAccordionSpec> resolve(BuildContext context) {
    final spec = RemixAccordionSpec(
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
      ..add(DiagnosticsProperty('trigger', $trigger))
      ..add(DiagnosticsProperty('leadingIcon', $leadingIcon))
      ..add(DiagnosticsProperty('title', $title))
      ..add(DiagnosticsProperty('trailingIcon', $trailingIcon))
      ..add(DiagnosticsProperty('content', $content));
  }

  @override
  List<Object?> get props => [
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
