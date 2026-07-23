// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixMenuTriggerSpec
    implements Spec<RemixMenuTriggerSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => RemixMenuTriggerSpec;

  @override
  RemixMenuTriggerSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) {
    return RemixMenuTriggerSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  @override
  RemixMenuTriggerSpec lerp(RemixMenuTriggerSpec? other, double t) {
    return RemixMenuTriggerSpec(
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
        other is RemixMenuTriggerSpec &&
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
  'Rename to `_\$RemixMenuTriggerSpec` and migrate the class declaration to `class RemixMenuTriggerSpec with _\$RemixMenuTriggerSpec`. The `_\$RemixMenuTriggerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixMenuTriggerSpecMethods = _$RemixMenuTriggerSpec; // ignore: unused_element

mixin _$RemixMenuSpec implements Spec<RemixMenuSpec>, Diagnosticable {
  StyleSpec<RemixMenuTriggerSpec> get trigger;
  StyleSpec<FlexBoxSpec> get overlay;
  RemixBoxEffectsSpec? get containerEffects;
  StyleSpec<RemixMenuItemSpec> get item;
  StyleSpec<RemixMenuItemSpec> get label;
  StyleSpec<RemixDividerSpec> get divider;

  @override
  Type get type => RemixMenuSpec;

  @override
  RemixMenuSpec copyWith({
    StyleSpec<RemixMenuTriggerSpec>? trigger,
    StyleSpec<FlexBoxSpec>? overlay,
    RemixBoxEffectsSpec? containerEffects,
    StyleSpec<RemixMenuItemSpec>? item,
    StyleSpec<RemixMenuItemSpec>? label,
    StyleSpec<RemixDividerSpec>? divider,
  }) {
    return RemixMenuSpec(
      trigger: trigger ?? this.trigger,
      overlay: overlay ?? this.overlay,
      containerEffects: containerEffects ?? this.containerEffects,
      item: item ?? this.item,
      label: label ?? this.label,
      divider: divider ?? this.divider,
    );
  }

  @override
  RemixMenuSpec lerp(RemixMenuSpec? other, double t) {
    return RemixMenuSpec(
      trigger: trigger.lerp(other?.trigger, t),
      overlay: overlay.lerp(other?.overlay, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
      item: item.lerp(other?.item, t),
      label: label.lerp(other?.label, t),
      divider: divider.lerp(other?.divider, t),
    );
  }

  @override
  List<Object?> get props => [
    trigger,
    overlay,
    containerEffects,
    item,
    label,
    divider,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixMenuSpec &&
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
      ..add(DiagnosticsProperty('overlay', overlay))
      ..add(DiagnosticsProperty('containerEffects', containerEffects))
      ..add(DiagnosticsProperty('item', item))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('divider', divider));
  }
}

@Deprecated(
  'Rename to `_\$RemixMenuSpec` and migrate the class declaration to `class RemixMenuSpec with _\$RemixMenuSpec`. The `_\$RemixMenuSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixMenuSpecMethods = _$RemixMenuSpec; // ignore: unused_element

mixin _$RemixMenuItemSpec implements Spec<RemixMenuItemSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get leadingIcon;
  StyleSpec<IconSpec> get trailingIcon;
  StyleSpec<BoxSpec> get indicator;
  StyleSpec<IconSpec> get indicatorIcon;
  double? get leadingInset;
  double? get checkableLeadingInset;
  double? get trailingInset;
  double? get adjacentItemSpacing;

  @override
  Type get type => RemixMenuItemSpec;

  @override
  RemixMenuItemSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? leadingIcon,
    StyleSpec<IconSpec>? trailingIcon,
    StyleSpec<BoxSpec>? indicator,
    StyleSpec<IconSpec>? indicatorIcon,
    double? leadingInset,
    double? checkableLeadingInset,
    double? trailingInset,
    double? adjacentItemSpacing,
  }) {
    return RemixMenuItemSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      indicator: indicator ?? this.indicator,
      indicatorIcon: indicatorIcon ?? this.indicatorIcon,
      leadingInset: leadingInset ?? this.leadingInset,
      checkableLeadingInset:
          checkableLeadingInset ?? this.checkableLeadingInset,
      trailingInset: trailingInset ?? this.trailingInset,
      adjacentItemSpacing: adjacentItemSpacing ?? this.adjacentItemSpacing,
    );
  }

  @override
  RemixMenuItemSpec lerp(RemixMenuItemSpec? other, double t) {
    return RemixMenuItemSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      leadingIcon: leadingIcon.lerp(other?.leadingIcon, t),
      trailingIcon: trailingIcon.lerp(other?.trailingIcon, t),
      indicator: indicator.lerp(other?.indicator, t),
      indicatorIcon: indicatorIcon.lerp(other?.indicatorIcon, t),
      leadingInset: MixOps.lerp(leadingInset, other?.leadingInset, t),
      checkableLeadingInset: MixOps.lerp(
        checkableLeadingInset,
        other?.checkableLeadingInset,
        t,
      ),
      trailingInset: MixOps.lerp(trailingInset, other?.trailingInset, t),
      adjacentItemSpacing: MixOps.lerp(
        adjacentItemSpacing,
        other?.adjacentItemSpacing,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [
    container,
    label,
    leadingIcon,
    trailingIcon,
    indicator,
    indicatorIcon,
    leadingInset,
    checkableLeadingInset,
    trailingInset,
    adjacentItemSpacing,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixMenuItemSpec &&
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
      ..add(DiagnosticsProperty('leadingIcon', leadingIcon))
      ..add(DiagnosticsProperty('trailingIcon', trailingIcon))
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DiagnosticsProperty('indicatorIcon', indicatorIcon))
      ..add(DoubleProperty('leadingInset', leadingInset))
      ..add(DoubleProperty('checkableLeadingInset', checkableLeadingInset))
      ..add(DoubleProperty('trailingInset', trailingInset))
      ..add(DoubleProperty('adjacentItemSpacing', adjacentItemSpacing));
  }
}

@Deprecated(
  'Rename to `_\$RemixMenuItemSpec` and migrate the class declaration to `class RemixMenuItemSpec with _\$RemixMenuItemSpec`. The `_\$RemixMenuItemSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixMenuItemSpecMethods = _$RemixMenuItemSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixMenuTriggerStyler
    extends MixStyler<RemixMenuTriggerStyler, RemixMenuTriggerSpec>
    with
        RemixBoxStylerMixin<RemixMenuTriggerStyler>,
        LabelStyleMixin<RemixMenuTriggerStyler>,
        IconStyleMixin<RemixMenuTriggerStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const RemixMenuTriggerStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon;

  RemixMenuTriggerStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixMenuTriggerSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixMenuTriggerStyler.container(FlexBoxStyler value) =>
      RemixMenuTriggerStyler().container(value);
  factory RemixMenuTriggerStyler.label(TextStyler value) =>
      RemixMenuTriggerStyler().label(value);
  factory RemixMenuTriggerStyler.icon(IconStyler value) =>
      RemixMenuTriggerStyler().icon(value);
  factory RemixMenuTriggerStyler.color(Color value) =>
      RemixMenuTriggerStyler().color(value);
  factory RemixMenuTriggerStyler.gradient(GradientMix value) =>
      RemixMenuTriggerStyler().gradient(value);
  factory RemixMenuTriggerStyler.border(BoxBorderMix value) =>
      RemixMenuTriggerStyler().border(value);
  factory RemixMenuTriggerStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixMenuTriggerStyler().borderRadius(value);
  factory RemixMenuTriggerStyler.elevation(ElevationShadow value) =>
      RemixMenuTriggerStyler().elevation(value);
  factory RemixMenuTriggerStyler.shadow(BoxShadowMix value) =>
      RemixMenuTriggerStyler().shadow(value);
  factory RemixMenuTriggerStyler.shadows(List<BoxShadowMix> value) =>
      RemixMenuTriggerStyler().shadows(value);
  factory RemixMenuTriggerStyler.width(double value) =>
      RemixMenuTriggerStyler().width(value);
  factory RemixMenuTriggerStyler.height(double value) =>
      RemixMenuTriggerStyler().height(value);
  factory RemixMenuTriggerStyler.size(double width, double height) =>
      RemixMenuTriggerStyler().size(width, height);
  factory RemixMenuTriggerStyler.minWidth(double value) =>
      RemixMenuTriggerStyler().minWidth(value);
  factory RemixMenuTriggerStyler.maxWidth(double value) =>
      RemixMenuTriggerStyler().maxWidth(value);
  factory RemixMenuTriggerStyler.minHeight(double value) =>
      RemixMenuTriggerStyler().minHeight(value);
  factory RemixMenuTriggerStyler.maxHeight(double value) =>
      RemixMenuTriggerStyler().maxHeight(value);
  factory RemixMenuTriggerStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixMenuTriggerStyler().scale(scale, alignment: alignment);
  factory RemixMenuTriggerStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixMenuTriggerStyler().rotate(radians, alignment: alignment);
  factory RemixMenuTriggerStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => RemixMenuTriggerStyler().translate(x, y, z);
  factory RemixMenuTriggerStyler.skew(double skewX, double skewY) =>
      RemixMenuTriggerStyler().skew(skewX, skewY);
  factory RemixMenuTriggerStyler.textStyle(TextStyler value) =>
      RemixMenuTriggerStyler().textStyle(value);
  factory RemixMenuTriggerStyler.image(DecorationImageMix value) =>
      RemixMenuTriggerStyler().image(value);
  factory RemixMenuTriggerStyler.shape(ShapeBorderMix value) =>
      RemixMenuTriggerStyler().shape(value);
  factory RemixMenuTriggerStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixMenuTriggerStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixMenuTriggerStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixMenuTriggerStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixMenuTriggerStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixMenuTriggerStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixMenuTriggerStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixMenuTriggerStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixMenuTriggerStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixMenuTriggerStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixMenuTriggerStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixMenuTriggerStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixMenuTriggerStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixMenuTriggerStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixMenuTriggerStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixMenuTriggerStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixMenuTriggerStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixMenuTriggerStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixMenuTriggerStyler.row() => RemixMenuTriggerStyler().row();
  factory RemixMenuTriggerStyler.column() => RemixMenuTriggerStyler().column();
  factory RemixMenuTriggerStyler.alignment(AlignmentGeometry value) =>
      RemixMenuTriggerStyler().alignment(value);
  factory RemixMenuTriggerStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixMenuTriggerStyler().padding(value);
  factory RemixMenuTriggerStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixMenuTriggerStyler().margin(value);
  factory RemixMenuTriggerStyler.constraints(BoxConstraintsMix value) =>
      RemixMenuTriggerStyler().constraints(value);
  factory RemixMenuTriggerStyler.decoration(DecorationMix value) =>
      RemixMenuTriggerStyler().decoration(value);
  factory RemixMenuTriggerStyler.foregroundDecoration(DecorationMix value) =>
      RemixMenuTriggerStyler().foregroundDecoration(value);
  factory RemixMenuTriggerStyler.clipBehavior(Clip value) =>
      RemixMenuTriggerStyler().clipBehavior(value);
  factory RemixMenuTriggerStyler.direction(Axis value) =>
      RemixMenuTriggerStyler().direction(value);
  factory RemixMenuTriggerStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixMenuTriggerStyler().mainAxisAlignment(value);
  factory RemixMenuTriggerStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixMenuTriggerStyler().crossAxisAlignment(value);
  factory RemixMenuTriggerStyler.mainAxisSize(MainAxisSize value) =>
      RemixMenuTriggerStyler().mainAxisSize(value);
  factory RemixMenuTriggerStyler.spacing(double value) =>
      RemixMenuTriggerStyler().spacing(value);
  factory RemixMenuTriggerStyler.verticalDirection(VerticalDirection value) =>
      RemixMenuTriggerStyler().verticalDirection(value);
  factory RemixMenuTriggerStyler.textDirection(TextDirection value) =>
      RemixMenuTriggerStyler().textDirection(value);
  factory RemixMenuTriggerStyler.textBaseline(TextBaseline value) =>
      RemixMenuTriggerStyler().textBaseline(value);
  factory RemixMenuTriggerStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixMenuTriggerStyler().transform(value, alignment: alignment);

  RemixMenuTriggerStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixMenuTriggerStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixMenuTriggerStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixMenuTriggerStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixMenuTriggerStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixMenuTriggerStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixMenuTriggerStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixMenuTriggerStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixMenuTriggerStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixMenuTriggerStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixMenuTriggerStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixMenuTriggerStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixMenuTriggerStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixMenuTriggerStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixMenuTriggerStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixMenuTriggerStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixMenuTriggerStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixMenuTriggerStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixMenuTriggerStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixMenuTriggerStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixMenuTriggerStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixMenuTriggerStyler backgroundImage(
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

  RemixMenuTriggerStyler backgroundImageUrl(
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

  RemixMenuTriggerStyler backgroundImageAsset(
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

  RemixMenuTriggerStyler linearGradient({
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

  RemixMenuTriggerStyler radialGradient({
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

  RemixMenuTriggerStyler sweepGradient({
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

  RemixMenuTriggerStyler foregroundLinearGradient({
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

  RemixMenuTriggerStyler foregroundRadialGradient({
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

  RemixMenuTriggerStyler foregroundSweepGradient({
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

  RemixMenuTriggerStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixMenuTriggerStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixMenuTriggerStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixMenuTriggerStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixMenuTriggerStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixMenuTriggerStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixMenuTriggerStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixMenuTriggerStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixMenuTriggerStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixMenuTriggerStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixMenuTriggerStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixMenuTriggerStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixMenuTriggerStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixMenuTriggerStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixMenuTriggerStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixMenuTriggerStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixMenuTriggerStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixMenuTriggerStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixMenuTriggerStyler container(FlexBoxStyler value) {
    return merge(RemixMenuTriggerStyler(container: value));
  }

  /// Sets the label.
  @override
  RemixMenuTriggerStyler label(TextStyler value) {
    return merge(RemixMenuTriggerStyler(label: value));
  }

  /// Sets the icon.
  @override
  RemixMenuTriggerStyler icon(IconStyler value) {
    return merge(RemixMenuTriggerStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  RemixMenuTriggerStyler animate(AnimationConfig value) {
    return merge(RemixMenuTriggerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixMenuTriggerStyler variants(
    List<VariantStyle<RemixMenuTriggerSpec>> value,
  ) {
    return merge(RemixMenuTriggerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixMenuTriggerStyler wrap(WidgetModifierConfig value) {
    return merge(RemixMenuTriggerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixMenuTriggerStyler modifier(WidgetModifierConfig value) {
    return merge(RemixMenuTriggerStyler(modifier: value));
  }

  /// Merges with another [RemixMenuTriggerStyler].
  @override
  RemixMenuTriggerStyler merge(RemixMenuTriggerStyler? other) {
    return RemixMenuTriggerStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixMenuTriggerSpec>] using [context].
  @override
  StyleSpec<RemixMenuTriggerSpec> resolve(BuildContext context) {
    final spec = RemixMenuTriggerSpec(
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

class RemixMenuStyler extends MixStyler<RemixMenuStyler, RemixMenuSpec> {
  final Prop<StyleSpec<RemixMenuTriggerSpec>>? $trigger;
  final Prop<StyleSpec<FlexBoxSpec>>? $overlay;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;
  final Prop<StyleSpec<RemixMenuItemSpec>>? $item;
  final Prop<StyleSpec<RemixMenuItemSpec>>? $label;
  final Prop<StyleSpec<RemixDividerSpec>>? $divider;

  const RemixMenuStyler.create({
    Prop<StyleSpec<RemixMenuTriggerSpec>>? trigger,
    Prop<StyleSpec<FlexBoxSpec>>? overlay,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    Prop<StyleSpec<RemixMenuItemSpec>>? item,
    Prop<StyleSpec<RemixMenuItemSpec>>? label,
    Prop<StyleSpec<RemixDividerSpec>>? divider,
    super.variants,
    super.modifier,
    super.animation,
  }) : $trigger = trigger,
       $overlay = overlay,
       $containerEffects = containerEffects,
       $item = item,
       $label = label,
       $divider = divider;

  RemixMenuStyler({
    RemixMenuTriggerStyler? trigger,
    FlexBoxStyler? overlay,
    RemixBoxEffectsMix? containerEffects,
    RemixMenuItemStyler? item,
    RemixMenuItemStyler? label,
    RemixDividerStyler? divider,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixMenuSpec>>? variants,
  }) : this.create(
         trigger: Prop.maybeMix(trigger),
         overlay: Prop.maybeMix(overlay),
         containerEffects: Prop.maybeMix(containerEffects),
         item: Prop.maybeMix(item),
         label: Prop.maybeMix(label),
         divider: Prop.maybeMix(divider),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixMenuStyler.trigger(RemixMenuTriggerStyler value) =>
      RemixMenuStyler().trigger(value);
  factory RemixMenuStyler.overlay(FlexBoxStyler value) =>
      RemixMenuStyler().overlay(value);
  factory RemixMenuStyler.containerEffects(RemixBoxEffectsMix value) =>
      RemixMenuStyler().containerEffects(value);
  factory RemixMenuStyler.item(RemixMenuItemStyler value) =>
      RemixMenuStyler().item(value);
  factory RemixMenuStyler.label(RemixMenuItemStyler value) =>
      RemixMenuStyler().label(value);
  factory RemixMenuStyler.divider(RemixDividerStyler value) =>
      RemixMenuStyler().divider(value);

  /// Sets the trigger.
  RemixMenuStyler trigger(RemixMenuTriggerStyler value) {
    return merge(RemixMenuStyler(trigger: value));
  }

  /// Sets the overlay.
  RemixMenuStyler overlay(FlexBoxStyler value) {
    return merge(RemixMenuStyler(overlay: value));
  }

  /// Sets the containerEffects.
  RemixMenuStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(RemixMenuStyler(containerEffects: value));
  }

  /// Sets the item.
  RemixMenuStyler item(RemixMenuItemStyler value) {
    return merge(RemixMenuStyler(item: value));
  }

  /// Sets the label.
  RemixMenuStyler label(RemixMenuItemStyler value) {
    return merge(RemixMenuStyler(label: value));
  }

  /// Sets the divider.
  RemixMenuStyler divider(RemixDividerStyler value) {
    return merge(RemixMenuStyler(divider: value));
  }

  /// Sets the animation configuration.
  @override
  RemixMenuStyler animate(AnimationConfig value) {
    return merge(RemixMenuStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixMenuStyler variants(List<VariantStyle<RemixMenuSpec>> value) {
    return merge(RemixMenuStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixMenuStyler wrap(WidgetModifierConfig value) {
    return merge(RemixMenuStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixMenuStyler modifier(WidgetModifierConfig value) {
    return merge(RemixMenuStyler(modifier: value));
  }

  /// Merges with another [RemixMenuStyler].
  @override
  RemixMenuStyler merge(RemixMenuStyler? other) {
    return RemixMenuStyler.create(
      trigger: MixOps.merge($trigger, other?.$trigger),
      overlay: MixOps.merge($overlay, other?.$overlay),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      item: MixOps.merge($item, other?.$item),
      label: MixOps.merge($label, other?.$label),
      divider: MixOps.merge($divider, other?.$divider),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixMenuSpec>] using [context].
  @override
  StyleSpec<RemixMenuSpec> resolve(BuildContext context) {
    final spec = RemixMenuSpec(
      trigger: MixOps.resolve(context, $trigger),
      overlay: MixOps.resolve(context, $overlay),
      containerEffects: MixOps.resolve(context, $containerEffects),
      item: MixOps.resolve(context, $item),
      label: MixOps.resolve(context, $label),
      divider: MixOps.resolve(context, $divider),
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
      ..add(DiagnosticsProperty('overlay', $overlay))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects))
      ..add(DiagnosticsProperty('item', $item))
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('divider', $divider));
  }

  @override
  List<Object?> get props => [
    $trigger,
    $overlay,
    $containerEffects,
    $item,
    $label,
    $divider,
    $animation,
    $modifier,
    $variants,
  ];
}

class RemixMenuItemStyler
    extends MixStyler<RemixMenuItemStyler, RemixMenuItemSpec>
    with RemixBoxStylerMixin<RemixMenuItemStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $leadingIcon;
  final Prop<StyleSpec<IconSpec>>? $trailingIcon;
  final Prop<StyleSpec<BoxSpec>>? $indicator;
  final Prop<StyleSpec<IconSpec>>? $indicatorIcon;
  final Prop<double>? $leadingInset;
  final Prop<double>? $checkableLeadingInset;
  final Prop<double>? $trailingInset;
  final Prop<double>? $adjacentItemSpacing;

  const RemixMenuItemStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? leadingIcon,
    Prop<StyleSpec<IconSpec>>? trailingIcon,
    Prop<StyleSpec<BoxSpec>>? indicator,
    Prop<StyleSpec<IconSpec>>? indicatorIcon,
    Prop<double>? leadingInset,
    Prop<double>? checkableLeadingInset,
    Prop<double>? trailingInset,
    Prop<double>? adjacentItemSpacing,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $leadingIcon = leadingIcon,
       $trailingIcon = trailingIcon,
       $indicator = indicator,
       $indicatorIcon = indicatorIcon,
       $leadingInset = leadingInset,
       $checkableLeadingInset = checkableLeadingInset,
       $trailingInset = trailingInset,
       $adjacentItemSpacing = adjacentItemSpacing;

  RemixMenuItemStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? leadingIcon,
    IconStyler? trailingIcon,
    BoxStyler? indicator,
    IconStyler? indicatorIcon,
    double? leadingInset,
    double? checkableLeadingInset,
    double? trailingInset,
    double? adjacentItemSpacing,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixMenuItemSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         leadingIcon: Prop.maybeMix(leadingIcon),
         trailingIcon: Prop.maybeMix(trailingIcon),
         indicator: Prop.maybeMix(indicator),
         indicatorIcon: Prop.maybeMix(indicatorIcon),
         leadingInset: Prop.maybe(leadingInset),
         checkableLeadingInset: Prop.maybe(checkableLeadingInset),
         trailingInset: Prop.maybe(trailingInset),
         adjacentItemSpacing: Prop.maybe(adjacentItemSpacing),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixMenuItemStyler.container(FlexBoxStyler value) =>
      RemixMenuItemStyler().container(value);
  factory RemixMenuItemStyler.label(TextStyler value) =>
      RemixMenuItemStyler().label(value);
  factory RemixMenuItemStyler.leadingIcon(IconStyler value) =>
      RemixMenuItemStyler().leadingIcon(value);
  factory RemixMenuItemStyler.trailingIcon(IconStyler value) =>
      RemixMenuItemStyler().trailingIcon(value);
  factory RemixMenuItemStyler.indicator(BoxStyler value) =>
      RemixMenuItemStyler().indicator(value);
  factory RemixMenuItemStyler.indicatorIcon(IconStyler value) =>
      RemixMenuItemStyler().indicatorIcon(value);
  factory RemixMenuItemStyler.leadingInset(double value) =>
      RemixMenuItemStyler().leadingInset(value);
  factory RemixMenuItemStyler.checkableLeadingInset(double value) =>
      RemixMenuItemStyler().checkableLeadingInset(value);
  factory RemixMenuItemStyler.trailingInset(double value) =>
      RemixMenuItemStyler().trailingInset(value);
  factory RemixMenuItemStyler.adjacentItemSpacing(double value) =>
      RemixMenuItemStyler().adjacentItemSpacing(value);
  factory RemixMenuItemStyler.color(Color value) =>
      RemixMenuItemStyler().color(value);
  factory RemixMenuItemStyler.gradient(GradientMix value) =>
      RemixMenuItemStyler().gradient(value);
  factory RemixMenuItemStyler.border(BoxBorderMix value) =>
      RemixMenuItemStyler().border(value);
  factory RemixMenuItemStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixMenuItemStyler().borderRadius(value);
  factory RemixMenuItemStyler.elevation(ElevationShadow value) =>
      RemixMenuItemStyler().elevation(value);
  factory RemixMenuItemStyler.shadow(BoxShadowMix value) =>
      RemixMenuItemStyler().shadow(value);
  factory RemixMenuItemStyler.shadows(List<BoxShadowMix> value) =>
      RemixMenuItemStyler().shadows(value);
  factory RemixMenuItemStyler.width(double value) =>
      RemixMenuItemStyler().width(value);
  factory RemixMenuItemStyler.height(double value) =>
      RemixMenuItemStyler().height(value);
  factory RemixMenuItemStyler.size(double width, double height) =>
      RemixMenuItemStyler().size(width, height);
  factory RemixMenuItemStyler.minWidth(double value) =>
      RemixMenuItemStyler().minWidth(value);
  factory RemixMenuItemStyler.maxWidth(double value) =>
      RemixMenuItemStyler().maxWidth(value);
  factory RemixMenuItemStyler.minHeight(double value) =>
      RemixMenuItemStyler().minHeight(value);
  factory RemixMenuItemStyler.maxHeight(double value) =>
      RemixMenuItemStyler().maxHeight(value);
  factory RemixMenuItemStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixMenuItemStyler().scale(scale, alignment: alignment);
  factory RemixMenuItemStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixMenuItemStyler().rotate(radians, alignment: alignment);
  factory RemixMenuItemStyler.translate(double x, double y, [double z = 0.0]) =>
      RemixMenuItemStyler().translate(x, y, z);
  factory RemixMenuItemStyler.skew(double skewX, double skewY) =>
      RemixMenuItemStyler().skew(skewX, skewY);
  factory RemixMenuItemStyler.textStyle(TextStyler value) =>
      RemixMenuItemStyler().textStyle(value);
  factory RemixMenuItemStyler.image(DecorationImageMix value) =>
      RemixMenuItemStyler().image(value);
  factory RemixMenuItemStyler.shape(ShapeBorderMix value) =>
      RemixMenuItemStyler().shape(value);
  factory RemixMenuItemStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixMenuItemStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixMenuItemStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixMenuItemStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixMenuItemStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixMenuItemStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixMenuItemStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixMenuItemStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixMenuItemStyler.row() => RemixMenuItemStyler().row();
  factory RemixMenuItemStyler.column() => RemixMenuItemStyler().column();
  factory RemixMenuItemStyler.alignment(AlignmentGeometry value) =>
      RemixMenuItemStyler().alignment(value);
  factory RemixMenuItemStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixMenuItemStyler().padding(value);
  factory RemixMenuItemStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixMenuItemStyler().margin(value);
  factory RemixMenuItemStyler.constraints(BoxConstraintsMix value) =>
      RemixMenuItemStyler().constraints(value);
  factory RemixMenuItemStyler.decoration(DecorationMix value) =>
      RemixMenuItemStyler().decoration(value);
  factory RemixMenuItemStyler.foregroundDecoration(DecorationMix value) =>
      RemixMenuItemStyler().foregroundDecoration(value);
  factory RemixMenuItemStyler.clipBehavior(Clip value) =>
      RemixMenuItemStyler().clipBehavior(value);
  factory RemixMenuItemStyler.direction(Axis value) =>
      RemixMenuItemStyler().direction(value);
  factory RemixMenuItemStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixMenuItemStyler().mainAxisAlignment(value);
  factory RemixMenuItemStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixMenuItemStyler().crossAxisAlignment(value);
  factory RemixMenuItemStyler.mainAxisSize(MainAxisSize value) =>
      RemixMenuItemStyler().mainAxisSize(value);
  factory RemixMenuItemStyler.spacing(double value) =>
      RemixMenuItemStyler().spacing(value);
  factory RemixMenuItemStyler.verticalDirection(VerticalDirection value) =>
      RemixMenuItemStyler().verticalDirection(value);
  factory RemixMenuItemStyler.textDirection(TextDirection value) =>
      RemixMenuItemStyler().textDirection(value);
  factory RemixMenuItemStyler.textBaseline(TextBaseline value) =>
      RemixMenuItemStyler().textBaseline(value);
  factory RemixMenuItemStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixMenuItemStyler().transform(value, alignment: alignment);

  RemixMenuItemStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixMenuItemStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixMenuItemStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixMenuItemStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixMenuItemStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixMenuItemStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixMenuItemStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixMenuItemStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixMenuItemStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixMenuItemStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixMenuItemStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixMenuItemStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixMenuItemStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixMenuItemStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixMenuItemStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixMenuItemStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixMenuItemStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixMenuItemStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixMenuItemStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixMenuItemStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixMenuItemStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixMenuItemStyler backgroundImage(
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

  RemixMenuItemStyler backgroundImageUrl(
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

  RemixMenuItemStyler backgroundImageAsset(
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

  RemixMenuItemStyler linearGradient({
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

  RemixMenuItemStyler radialGradient({
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

  RemixMenuItemStyler sweepGradient({
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

  RemixMenuItemStyler foregroundLinearGradient({
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

  RemixMenuItemStyler foregroundRadialGradient({
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

  RemixMenuItemStyler foregroundSweepGradient({
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

  RemixMenuItemStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixMenuItemStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixMenuItemStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixMenuItemStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixMenuItemStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixMenuItemStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixMenuItemStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixMenuItemStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixMenuItemStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixMenuItemStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixMenuItemStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixMenuItemStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixMenuItemStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixMenuItemStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixMenuItemStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixMenuItemStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixMenuItemStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixMenuItemStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixMenuItemStyler container(FlexBoxStyler value) {
    return merge(RemixMenuItemStyler(container: value));
  }

  /// Sets the label.
  RemixMenuItemStyler label(TextStyler value) {
    return merge(RemixMenuItemStyler(label: value));
  }

  /// Sets the leadingIcon.
  RemixMenuItemStyler leadingIcon(IconStyler value) {
    return merge(RemixMenuItemStyler(leadingIcon: value));
  }

  /// Sets the trailingIcon.
  RemixMenuItemStyler trailingIcon(IconStyler value) {
    return merge(RemixMenuItemStyler(trailingIcon: value));
  }

  /// Sets the indicator.
  RemixMenuItemStyler indicator(BoxStyler value) {
    return merge(RemixMenuItemStyler(indicator: value));
  }

  /// Sets the indicatorIcon.
  RemixMenuItemStyler indicatorIcon(IconStyler value) {
    return merge(RemixMenuItemStyler(indicatorIcon: value));
  }

  /// Sets the leadingInset.
  RemixMenuItemStyler leadingInset(double value) {
    return merge(RemixMenuItemStyler(leadingInset: value));
  }

  /// Sets the checkableLeadingInset.
  RemixMenuItemStyler checkableLeadingInset(double value) {
    return merge(RemixMenuItemStyler(checkableLeadingInset: value));
  }

  /// Sets the trailingInset.
  RemixMenuItemStyler trailingInset(double value) {
    return merge(RemixMenuItemStyler(trailingInset: value));
  }

  /// Sets the adjacentItemSpacing.
  RemixMenuItemStyler adjacentItemSpacing(double value) {
    return merge(RemixMenuItemStyler(adjacentItemSpacing: value));
  }

  /// Sets the animation configuration.
  @override
  RemixMenuItemStyler animate(AnimationConfig value) {
    return merge(RemixMenuItemStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixMenuItemStyler variants(List<VariantStyle<RemixMenuItemSpec>> value) {
    return merge(RemixMenuItemStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixMenuItemStyler wrap(WidgetModifierConfig value) {
    return merge(RemixMenuItemStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixMenuItemStyler modifier(WidgetModifierConfig value) {
    return merge(RemixMenuItemStyler(modifier: value));
  }

  /// Merges with another [RemixMenuItemStyler].
  @override
  RemixMenuItemStyler merge(RemixMenuItemStyler? other) {
    return RemixMenuItemStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      leadingIcon: MixOps.merge($leadingIcon, other?.$leadingIcon),
      trailingIcon: MixOps.merge($trailingIcon, other?.$trailingIcon),
      indicator: MixOps.merge($indicator, other?.$indicator),
      indicatorIcon: MixOps.merge($indicatorIcon, other?.$indicatorIcon),
      leadingInset: MixOps.merge($leadingInset, other?.$leadingInset),
      checkableLeadingInset: MixOps.merge(
        $checkableLeadingInset,
        other?.$checkableLeadingInset,
      ),
      trailingInset: MixOps.merge($trailingInset, other?.$trailingInset),
      adjacentItemSpacing: MixOps.merge(
        $adjacentItemSpacing,
        other?.$adjacentItemSpacing,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixMenuItemSpec>] using [context].
  @override
  StyleSpec<RemixMenuItemSpec> resolve(BuildContext context) {
    final spec = RemixMenuItemSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      leadingIcon: MixOps.resolve(context, $leadingIcon),
      trailingIcon: MixOps.resolve(context, $trailingIcon),
      indicator: MixOps.resolve(context, $indicator),
      indicatorIcon: MixOps.resolve(context, $indicatorIcon),
      leadingInset: MixOps.resolve(context, $leadingInset),
      checkableLeadingInset: MixOps.resolve(context, $checkableLeadingInset),
      trailingInset: MixOps.resolve(context, $trailingInset),
      adjacentItemSpacing: MixOps.resolve(context, $adjacentItemSpacing),
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
      ..add(DiagnosticsProperty('leadingIcon', $leadingIcon))
      ..add(DiagnosticsProperty('trailingIcon', $trailingIcon))
      ..add(DiagnosticsProperty('indicator', $indicator))
      ..add(DiagnosticsProperty('indicatorIcon', $indicatorIcon))
      ..add(DiagnosticsProperty('leadingInset', $leadingInset))
      ..add(
        DiagnosticsProperty('checkableLeadingInset', $checkableLeadingInset),
      )
      ..add(DiagnosticsProperty('trailingInset', $trailingInset))
      ..add(DiagnosticsProperty('adjacentItemSpacing', $adjacentItemSpacing));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $leadingIcon,
    $trailingIcon,
    $indicator,
    $indicatorIcon,
    $leadingInset,
    $checkableLeadingInset,
    $trailingInset,
    $adjacentItemSpacing,
    $animation,
    $modifier,
    $variants,
  ];
}
