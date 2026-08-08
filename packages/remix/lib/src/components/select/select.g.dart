// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$SelectSpec implements Spec<SelectSpec>, Diagnosticable {
  StyleSpec<SelectTriggerSpec> get trigger;
  StyleSpec<SelectContentSpec> get content;
  StyleSpec<FlexBoxSpec> get menuContainer;
  StyleSpec<SelectMenuItemSpec> get item;

  @override
  Type get type => SelectSpec;

  @override
  SelectSpec copyWith({
    StyleSpec<SelectTriggerSpec>? trigger,
    StyleSpec<SelectContentSpec>? content,
    StyleSpec<FlexBoxSpec>? menuContainer,
    StyleSpec<SelectMenuItemSpec>? item,
  }) {
    return SelectSpec(
      trigger: trigger ?? this.trigger,
      content: content ?? this.content,
      menuContainer: menuContainer ?? this.menuContainer,
      item: item ?? this.item,
    );
  }

  @override
  SelectSpec lerp(SelectSpec? other, double t) {
    return SelectSpec(
      trigger: trigger.lerp(other?.trigger, t),
      content: content.lerp(other?.content, t),
      menuContainer: menuContainer.lerp(other?.menuContainer, t),
      item: item.lerp(other?.item, t),
    );
  }

  @override
  List<Object?> get props => [trigger, content, menuContainer, item];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SelectSpec &&
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
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('menuContainer', menuContainer))
      ..add(DiagnosticsProperty('item', item));
  }
}

@Deprecated(
  'Rename to `_\$SelectSpec` and migrate the class declaration to `class SelectSpec with _\$SelectSpec`. The `_\$SelectSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SelectSpecMethods = _$SelectSpec; // ignore: unused_element

mixin _$SelectTriggerSpec implements Spec<SelectTriggerSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<TextSpec> get placeholder;
  StyleSpec<IconSpec> get icon;
  StyleSpec<IconSpec> get chevron;
  RemixBoxEffectsSpec? get containerEffects;
  double? get chevronOpacity;
  double? get placeholderOpacity;

  @override
  Type get type => SelectTriggerSpec;

  @override
  SelectTriggerSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<TextSpec>? placeholder,
    StyleSpec<IconSpec>? icon,
    StyleSpec<IconSpec>? chevron,
    RemixBoxEffectsSpec? containerEffects,
    double? chevronOpacity,
    double? placeholderOpacity,
  }) {
    return SelectTriggerSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      placeholder: placeholder ?? this.placeholder,
      icon: icon ?? this.icon,
      chevron: chevron ?? this.chevron,
      containerEffects: containerEffects ?? this.containerEffects,
      chevronOpacity: chevronOpacity ?? this.chevronOpacity,
      placeholderOpacity: placeholderOpacity ?? this.placeholderOpacity,
    );
  }

  @override
  SelectTriggerSpec lerp(SelectTriggerSpec? other, double t) {
    return SelectTriggerSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      placeholder: placeholder.lerp(other?.placeholder, t),
      icon: icon.lerp(other?.icon, t),
      chevron: chevron.lerp(other?.chevron, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
      chevronOpacity: MixOps.lerp(chevronOpacity, other?.chevronOpacity, t),
      placeholderOpacity: MixOps.lerp(
        placeholderOpacity,
        other?.placeholderOpacity,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [
    container,
    label,
    placeholder,
    icon,
    chevron,
    containerEffects,
    chevronOpacity,
    placeholderOpacity,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SelectTriggerSpec &&
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
      ..add(DiagnosticsProperty('placeholder', placeholder))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('chevron', chevron))
      ..add(DiagnosticsProperty('containerEffects', containerEffects))
      ..add(DoubleProperty('chevronOpacity', chevronOpacity))
      ..add(DoubleProperty('placeholderOpacity', placeholderOpacity));
  }
}

@Deprecated(
  'Rename to `_\$SelectTriggerSpec` and migrate the class declaration to `class SelectTriggerSpec with _\$SelectTriggerSpec`. The `_\$SelectTriggerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SelectTriggerSpecMethods = _$SelectTriggerSpec; // ignore: unused_element

mixin _$SelectContentSpec implements Spec<SelectContentSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  RemixBoxEffectsSpec? get containerEffects;

  @override
  Type get type => SelectContentSpec;

  @override
  SelectContentSpec copyWith({
    StyleSpec<BoxSpec>? container,
    RemixBoxEffectsSpec? containerEffects,
  }) {
    return SelectContentSpec(
      container: container ?? this.container,
      containerEffects: containerEffects ?? this.containerEffects,
    );
  }

  @override
  SelectContentSpec lerp(SelectContentSpec? other, double t) {
    return SelectContentSpec(
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
        other is SelectContentSpec &&
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
  'Rename to `_\$SelectContentSpec` and migrate the class declaration to `class SelectContentSpec with _\$SelectContentSpec`. The `_\$SelectContentSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SelectContentSpecMethods = _$SelectContentSpec; // ignore: unused_element

mixin _$SelectMenuItemSpec implements Spec<SelectMenuItemSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get text;
  StyleSpec<BoxSpec> get indicator;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => SelectMenuItemSpec;

  @override
  SelectMenuItemSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    StyleSpec<BoxSpec>? indicator,
    StyleSpec<IconSpec>? icon,
  }) {
    return SelectMenuItemSpec(
      container: container ?? this.container,
      text: text ?? this.text,
      indicator: indicator ?? this.indicator,
      icon: icon ?? this.icon,
    );
  }

  @override
  SelectMenuItemSpec lerp(SelectMenuItemSpec? other, double t) {
    return SelectMenuItemSpec(
      container: container.lerp(other?.container, t),
      text: text.lerp(other?.text, t),
      indicator: indicator.lerp(other?.indicator, t),
      icon: icon.lerp(other?.icon, t),
    );
  }

  @override
  List<Object?> get props => [container, text, indicator, icon];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SelectMenuItemSpec &&
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
      ..add(DiagnosticsProperty('text', text))
      ..add(DiagnosticsProperty('indicator', indicator))
      ..add(DiagnosticsProperty('icon', icon));
  }
}

@Deprecated(
  'Rename to `_\$SelectMenuItemSpec` and migrate the class declaration to `class SelectMenuItemSpec with _\$SelectMenuItemSpec`. The `_\$SelectMenuItemSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SelectMenuItemSpecMethods = _$SelectMenuItemSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class SelectStyler extends MixStyler<SelectStyler, SelectSpec>
    with RemixBoxStylerMixin<SelectStyler> {
  final Prop<StyleSpec<SelectTriggerSpec>>? $trigger;
  final Prop<StyleSpec<SelectContentSpec>>? $content;
  final Prop<StyleSpec<FlexBoxSpec>>? $menuContainer;
  final Prop<StyleSpec<SelectMenuItemSpec>>? $item;

  const SelectStyler.create({
    Prop<StyleSpec<SelectTriggerSpec>>? trigger,
    Prop<StyleSpec<SelectContentSpec>>? content,
    Prop<StyleSpec<FlexBoxSpec>>? menuContainer,
    Prop<StyleSpec<SelectMenuItemSpec>>? item,
    super.variants,
    super.modifier,
    super.animation,
  }) : $trigger = trigger,
       $content = content,
       $menuContainer = menuContainer,
       $item = item;

  SelectStyler({
    SelectTriggerStyler? trigger,
    SelectContentStyler? content,
    FlexBoxStyler? menuContainer,
    SelectMenuItemStyler? item,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SelectSpec>>? variants,
  }) : this.create(
         trigger: Prop.maybeMix(trigger),
         content: Prop.maybeMix(content),
         menuContainer: Prop.maybeMix(menuContainer),
         item: Prop.maybeMix(item),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SelectStyler.trigger(SelectTriggerStyler value) =>
      SelectStyler().trigger(value);
  factory SelectStyler.content(SelectContentStyler value) =>
      SelectStyler().content(value);
  factory SelectStyler.menuContainer(FlexBoxStyler value) =>
      SelectStyler().menuContainer(value);
  factory SelectStyler.item(SelectMenuItemStyler value) =>
      SelectStyler().item(value);
  factory SelectStyler.alignment(AlignmentGeometry value) =>
      SelectStyler().alignment(value);
  factory SelectStyler.padding(EdgeInsetsGeometryMix value) =>
      SelectStyler().padding(value);
  factory SelectStyler.margin(EdgeInsetsGeometryMix value) =>
      SelectStyler().margin(value);
  factory SelectStyler.constraints(BoxConstraintsMix value) =>
      SelectStyler().constraints(value);
  factory SelectStyler.decoration(DecorationMix value) =>
      SelectStyler().decoration(value);
  factory SelectStyler.foregroundDecoration(DecorationMix value) =>
      SelectStyler().foregroundDecoration(value);
  factory SelectStyler.clipBehavior(Clip value) =>
      SelectStyler().clipBehavior(value);
  factory SelectStyler.color(Color value) => SelectStyler().color(value);
  factory SelectStyler.gradient(GradientMix value) =>
      SelectStyler().gradient(value);
  factory SelectStyler.border(BoxBorderMix value) =>
      SelectStyler().border(value);
  factory SelectStyler.borderRadius(BorderRadiusGeometryMix value) =>
      SelectStyler().borderRadius(value);
  factory SelectStyler.elevation(ElevationShadow value) =>
      SelectStyler().elevation(value);
  factory SelectStyler.shadow(BoxShadowMix value) =>
      SelectStyler().shadow(value);
  factory SelectStyler.shadows(List<BoxShadowMix> value) =>
      SelectStyler().shadows(value);
  factory SelectStyler.width(double value) => SelectStyler().width(value);
  factory SelectStyler.height(double value) => SelectStyler().height(value);
  factory SelectStyler.size(double width, double height) =>
      SelectStyler().size(width, height);
  factory SelectStyler.minWidth(double value) => SelectStyler().minWidth(value);
  factory SelectStyler.maxWidth(double value) => SelectStyler().maxWidth(value);
  factory SelectStyler.minHeight(double value) =>
      SelectStyler().minHeight(value);
  factory SelectStyler.maxHeight(double value) =>
      SelectStyler().maxHeight(value);
  factory SelectStyler.scale(double scale, {Alignment alignment = .center}) =>
      SelectStyler().scale(scale, alignment: alignment);
  factory SelectStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => SelectStyler().rotate(radians, alignment: alignment);
  factory SelectStyler.translate(double x, double y, [double z = 0.0]) =>
      SelectStyler().translate(x, y, z);
  factory SelectStyler.skew(double skewX, double skewY) =>
      SelectStyler().skew(skewX, skewY);
  factory SelectStyler.textStyle(TextStyler value) =>
      SelectStyler().textStyle(value);
  factory SelectStyler.image(DecorationImageMix value) =>
      SelectStyler().image(value);
  factory SelectStyler.shape(ShapeBorderMix value) =>
      SelectStyler().shape(value);
  factory SelectStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SelectStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SelectStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SelectStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SelectStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SelectStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SelectStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SelectStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SelectStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SelectStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SelectStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SelectStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SelectStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => SelectStyler().transform(value, alignment: alignment);

  SelectStyler alignment(AlignmentGeometry value) {
    return menuContainer(FlexBoxStyler().alignment(value));
  }

  SelectStyler padding(EdgeInsetsGeometryMix value) {
    return menuContainer(FlexBoxStyler().padding(value));
  }

  SelectStyler margin(EdgeInsetsGeometryMix value) {
    return menuContainer(FlexBoxStyler().margin(value));
  }

  SelectStyler constraints(BoxConstraintsMix value) {
    return menuContainer(FlexBoxStyler().constraints(value));
  }

  SelectStyler decoration(DecorationMix value) {
    return menuContainer(FlexBoxStyler().decoration(value));
  }

  SelectStyler foregroundDecoration(DecorationMix value) {
    return menuContainer(FlexBoxStyler().foregroundDecoration(value));
  }

  SelectStyler clipBehavior(Clip value) {
    return menuContainer(FlexBoxStyler().clipBehavior(value));
  }

  SelectStyler color(Color value) {
    return menuContainer(FlexBoxStyler().color(value));
  }

  SelectStyler gradient(GradientMix value) {
    return menuContainer(FlexBoxStyler().gradient(value));
  }

  SelectStyler border(BoxBorderMix value) {
    return menuContainer(FlexBoxStyler().border(value));
  }

  SelectStyler borderRadius(BorderRadiusGeometryMix value) {
    return menuContainer(FlexBoxStyler().borderRadius(value));
  }

  SelectStyler elevation(ElevationShadow value) {
    return menuContainer(FlexBoxStyler().elevation(value));
  }

  SelectStyler shadow(BoxShadowMix value) {
    return menuContainer(FlexBoxStyler().shadow(value));
  }

  SelectStyler shadows(List<BoxShadowMix> value) {
    return menuContainer(FlexBoxStyler().shadows(value));
  }

  SelectStyler width(double value) {
    return menuContainer(FlexBoxStyler().width(value));
  }

  SelectStyler height(double value) {
    return menuContainer(FlexBoxStyler().height(value));
  }

  SelectStyler size(double width, double height) {
    return menuContainer(FlexBoxStyler().size(width, height));
  }

  SelectStyler minWidth(double value) {
    return menuContainer(FlexBoxStyler().minWidth(value));
  }

  SelectStyler maxWidth(double value) {
    return menuContainer(FlexBoxStyler().maxWidth(value));
  }

  SelectStyler minHeight(double value) {
    return menuContainer(FlexBoxStyler().minHeight(value));
  }

  SelectStyler maxHeight(double value) {
    return menuContainer(FlexBoxStyler().maxHeight(value));
  }

  SelectStyler scale(double scale, {Alignment alignment = .center}) {
    return menuContainer(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  SelectStyler rotate(double radians, {Alignment alignment = .center}) {
    return menuContainer(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  SelectStyler translate(double x, double y, [double z = 0.0]) {
    return menuContainer(FlexBoxStyler().translate(x, y, z));
  }

  SelectStyler skew(double skewX, double skewY) {
    return menuContainer(FlexBoxStyler().skew(skewX, skewY));
  }

  SelectStyler textStyle(TextStyler value) {
    return menuContainer(FlexBoxStyler().textStyle(value));
  }

  SelectStyler image(DecorationImageMix value) {
    return menuContainer(FlexBoxStyler().image(value));
  }

  SelectStyler shape(ShapeBorderMix value) {
    return menuContainer(FlexBoxStyler().shape(value));
  }

  SelectStyler backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return menuContainer(
      FlexBoxStyler().backgroundImage(
        image,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  SelectStyler backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return menuContainer(
      FlexBoxStyler().backgroundImageUrl(
        url,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  SelectStyler backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) {
    return menuContainer(
      FlexBoxStyler().backgroundImageAsset(
        path,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
      ),
    );
  }

  SelectStyler linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return menuContainer(
      FlexBoxStyler().linearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  SelectStyler radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return menuContainer(
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

  SelectStyler sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return menuContainer(
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

  SelectStyler foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) {
    return menuContainer(
      FlexBoxStyler().foregroundLinearGradient(
        colors: colors,
        stops: stops,
        begin: begin,
        end: end,
        tileMode: tileMode,
      ),
    );
  }

  SelectStyler foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) {
    return menuContainer(
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

  SelectStyler foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) {
    return menuContainer(
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

  SelectStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return menuContainer(
      FlexBoxStyler().transform(value, alignment: alignment),
    );
  }

  /// Sets the trigger.
  SelectStyler trigger(SelectTriggerStyler value) {
    return merge(SelectStyler(trigger: value));
  }

  /// Sets the content.
  SelectStyler content(SelectContentStyler value) {
    return merge(SelectStyler(content: value));
  }

  /// Sets the menuContainer.
  SelectStyler menuContainer(FlexBoxStyler value) {
    return merge(SelectStyler(menuContainer: value));
  }

  /// Sets the item.
  SelectStyler item(SelectMenuItemStyler value) {
    return merge(SelectStyler(item: value));
  }

  /// Sets the animation configuration.
  @override
  SelectStyler animate(AnimationConfig value) {
    return merge(SelectStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SelectStyler variants(List<VariantStyle<SelectSpec>> value) {
    return merge(SelectStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SelectStyler wrap(WidgetModifierConfig value) {
    return merge(SelectStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SelectStyler modifier(WidgetModifierConfig value) {
    return merge(SelectStyler(modifier: value));
  }

  /// Merges with another [SelectStyler].
  @override
  SelectStyler merge(SelectStyler? other) {
    return SelectStyler.create(
      trigger: MixOps.merge($trigger, other?.$trigger),
      content: MixOps.merge($content, other?.$content),
      menuContainer: MixOps.merge($menuContainer, other?.$menuContainer),
      item: MixOps.merge($item, other?.$item),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SelectSpec>] using [context].
  @override
  StyleSpec<SelectSpec> resolve(BuildContext context) {
    final spec = SelectSpec(
      trigger: MixOps.resolve(context, $trigger),
      content: MixOps.resolve(context, $content),
      menuContainer: MixOps.resolve(context, $menuContainer),
      item: MixOps.resolve(context, $item),
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
      ..add(DiagnosticsProperty('content', $content))
      ..add(DiagnosticsProperty('menuContainer', $menuContainer))
      ..add(DiagnosticsProperty('item', $item));
  }

  @override
  List<Object?> get props => [
    $trigger,
    $content,
    $menuContainer,
    $item,
    $animation,
    $modifier,
    $variants,
  ];
}

class SelectTriggerStyler
    extends MixStyler<SelectTriggerStyler, SelectTriggerSpec>
    with
        RemixBoxStylerMixin<SelectTriggerStyler>,
        LabelStyleMixin<SelectTriggerStyler>,
        IconStyleMixin<SelectTriggerStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<TextSpec>>? $placeholder;
  final Prop<StyleSpec<IconSpec>>? $icon;
  final Prop<StyleSpec<IconSpec>>? $chevron;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;
  final Prop<double>? $chevronOpacity;
  final Prop<double>? $placeholderOpacity;

  const SelectTriggerStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<TextSpec>>? placeholder,
    Prop<StyleSpec<IconSpec>>? icon,
    Prop<StyleSpec<IconSpec>>? chevron,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    Prop<double>? chevronOpacity,
    Prop<double>? placeholderOpacity,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $placeholder = placeholder,
       $icon = icon,
       $chevron = chevron,
       $containerEffects = containerEffects,
       $chevronOpacity = chevronOpacity,
       $placeholderOpacity = placeholderOpacity;

  SelectTriggerStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    TextStyler? placeholder,
    IconStyler? icon,
    IconStyler? chevron,
    RemixBoxEffectsMix? containerEffects,
    double? chevronOpacity,
    double? placeholderOpacity,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SelectTriggerSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         placeholder: Prop.maybeMix(placeholder),
         icon: Prop.maybeMix(icon),
         chevron: Prop.maybeMix(chevron),
         containerEffects: Prop.maybeMix(containerEffects),
         chevronOpacity: Prop.maybe(chevronOpacity),
         placeholderOpacity: Prop.maybe(placeholderOpacity),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SelectTriggerStyler.container(FlexBoxStyler value) =>
      SelectTriggerStyler().container(value);
  factory SelectTriggerStyler.label(TextStyler value) =>
      SelectTriggerStyler().label(value);
  factory SelectTriggerStyler.placeholder(TextStyler value) =>
      SelectTriggerStyler().placeholder(value);
  factory SelectTriggerStyler.icon(IconStyler value) =>
      SelectTriggerStyler().icon(value);
  factory SelectTriggerStyler.chevron(IconStyler value) =>
      SelectTriggerStyler().chevron(value);
  factory SelectTriggerStyler.containerEffects(RemixBoxEffectsMix value) =>
      SelectTriggerStyler().containerEffects(value);
  factory SelectTriggerStyler.chevronOpacity(double value) =>
      SelectTriggerStyler().chevronOpacity(value);
  factory SelectTriggerStyler.placeholderOpacity(double value) =>
      SelectTriggerStyler().placeholderOpacity(value);
  factory SelectTriggerStyler.color(Color value) =>
      SelectTriggerStyler().color(value);
  factory SelectTriggerStyler.gradient(GradientMix value) =>
      SelectTriggerStyler().gradient(value);
  factory SelectTriggerStyler.border(BoxBorderMix value) =>
      SelectTriggerStyler().border(value);
  factory SelectTriggerStyler.borderRadius(BorderRadiusGeometryMix value) =>
      SelectTriggerStyler().borderRadius(value);
  factory SelectTriggerStyler.elevation(ElevationShadow value) =>
      SelectTriggerStyler().elevation(value);
  factory SelectTriggerStyler.shadow(BoxShadowMix value) =>
      SelectTriggerStyler().shadow(value);
  factory SelectTriggerStyler.shadows(List<BoxShadowMix> value) =>
      SelectTriggerStyler().shadows(value);
  factory SelectTriggerStyler.width(double value) =>
      SelectTriggerStyler().width(value);
  factory SelectTriggerStyler.height(double value) =>
      SelectTriggerStyler().height(value);
  factory SelectTriggerStyler.size(double width, double height) =>
      SelectTriggerStyler().size(width, height);
  factory SelectTriggerStyler.minWidth(double value) =>
      SelectTriggerStyler().minWidth(value);
  factory SelectTriggerStyler.maxWidth(double value) =>
      SelectTriggerStyler().maxWidth(value);
  factory SelectTriggerStyler.minHeight(double value) =>
      SelectTriggerStyler().minHeight(value);
  factory SelectTriggerStyler.maxHeight(double value) =>
      SelectTriggerStyler().maxHeight(value);
  factory SelectTriggerStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => SelectTriggerStyler().scale(scale, alignment: alignment);
  factory SelectTriggerStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => SelectTriggerStyler().rotate(radians, alignment: alignment);
  factory SelectTriggerStyler.translate(double x, double y, [double z = 0.0]) =>
      SelectTriggerStyler().translate(x, y, z);
  factory SelectTriggerStyler.skew(double skewX, double skewY) =>
      SelectTriggerStyler().skew(skewX, skewY);
  factory SelectTriggerStyler.textStyle(TextStyler value) =>
      SelectTriggerStyler().textStyle(value);
  factory SelectTriggerStyler.image(DecorationImageMix value) =>
      SelectTriggerStyler().image(value);
  factory SelectTriggerStyler.shape(ShapeBorderMix value) =>
      SelectTriggerStyler().shape(value);
  factory SelectTriggerStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectTriggerStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectTriggerStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectTriggerStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectTriggerStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectTriggerStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectTriggerStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SelectTriggerStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SelectTriggerStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SelectTriggerStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SelectTriggerStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SelectTriggerStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SelectTriggerStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SelectTriggerStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SelectTriggerStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SelectTriggerStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SelectTriggerStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SelectTriggerStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SelectTriggerStyler.row() => SelectTriggerStyler().row();
  factory SelectTriggerStyler.column() => SelectTriggerStyler().column();
  factory SelectTriggerStyler.alignment(AlignmentGeometry value) =>
      SelectTriggerStyler().alignment(value);
  factory SelectTriggerStyler.padding(EdgeInsetsGeometryMix value) =>
      SelectTriggerStyler().padding(value);
  factory SelectTriggerStyler.margin(EdgeInsetsGeometryMix value) =>
      SelectTriggerStyler().margin(value);
  factory SelectTriggerStyler.constraints(BoxConstraintsMix value) =>
      SelectTriggerStyler().constraints(value);
  factory SelectTriggerStyler.decoration(DecorationMix value) =>
      SelectTriggerStyler().decoration(value);
  factory SelectTriggerStyler.foregroundDecoration(DecorationMix value) =>
      SelectTriggerStyler().foregroundDecoration(value);
  factory SelectTriggerStyler.clipBehavior(Clip value) =>
      SelectTriggerStyler().clipBehavior(value);
  factory SelectTriggerStyler.direction(Axis value) =>
      SelectTriggerStyler().direction(value);
  factory SelectTriggerStyler.mainAxisAlignment(MainAxisAlignment value) =>
      SelectTriggerStyler().mainAxisAlignment(value);
  factory SelectTriggerStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      SelectTriggerStyler().crossAxisAlignment(value);
  factory SelectTriggerStyler.mainAxisSize(MainAxisSize value) =>
      SelectTriggerStyler().mainAxisSize(value);
  factory SelectTriggerStyler.spacing(double value) =>
      SelectTriggerStyler().spacing(value);
  factory SelectTriggerStyler.verticalDirection(VerticalDirection value) =>
      SelectTriggerStyler().verticalDirection(value);
  factory SelectTriggerStyler.textDirection(TextDirection value) =>
      SelectTriggerStyler().textDirection(value);
  factory SelectTriggerStyler.textBaseline(TextBaseline value) =>
      SelectTriggerStyler().textBaseline(value);
  factory SelectTriggerStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => SelectTriggerStyler().transform(value, alignment: alignment);

  SelectTriggerStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  SelectTriggerStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  SelectTriggerStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  SelectTriggerStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  SelectTriggerStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  SelectTriggerStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  SelectTriggerStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  SelectTriggerStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  SelectTriggerStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  SelectTriggerStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  SelectTriggerStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  SelectTriggerStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  SelectTriggerStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  SelectTriggerStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  SelectTriggerStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  SelectTriggerStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  SelectTriggerStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  SelectTriggerStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  SelectTriggerStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  SelectTriggerStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  SelectTriggerStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  SelectTriggerStyler backgroundImage(
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

  SelectTriggerStyler backgroundImageUrl(
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

  SelectTriggerStyler backgroundImageAsset(
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

  SelectTriggerStyler linearGradient({
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

  SelectTriggerStyler radialGradient({
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

  SelectTriggerStyler sweepGradient({
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

  SelectTriggerStyler foregroundLinearGradient({
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

  SelectTriggerStyler foregroundRadialGradient({
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

  SelectTriggerStyler foregroundSweepGradient({
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

  SelectTriggerStyler row() {
    return container(FlexBoxStyler().row());
  }

  SelectTriggerStyler column() {
    return container(FlexBoxStyler().column());
  }

  SelectTriggerStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  SelectTriggerStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  SelectTriggerStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  SelectTriggerStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  SelectTriggerStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  SelectTriggerStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  SelectTriggerStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  SelectTriggerStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  SelectTriggerStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  SelectTriggerStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  SelectTriggerStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  SelectTriggerStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  SelectTriggerStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  SelectTriggerStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  SelectTriggerStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  SelectTriggerStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  SelectTriggerStyler container(FlexBoxStyler value) {
    return merge(SelectTriggerStyler(container: value));
  }

  /// Sets the label.
  @override
  SelectTriggerStyler label(TextStyler value) {
    return merge(SelectTriggerStyler(label: value));
  }

  /// Sets the placeholder.
  SelectTriggerStyler placeholder(TextStyler value) {
    return merge(SelectTriggerStyler(placeholder: value));
  }

  /// Sets the icon.
  @override
  SelectTriggerStyler icon(IconStyler value) {
    return merge(SelectTriggerStyler(icon: value));
  }

  /// Sets the chevron.
  SelectTriggerStyler chevron(IconStyler value) {
    return merge(SelectTriggerStyler(chevron: value));
  }

  /// Sets the containerEffects.
  SelectTriggerStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(SelectTriggerStyler(containerEffects: value));
  }

  /// Sets the chevronOpacity.
  SelectTriggerStyler chevronOpacity(double value) {
    return merge(SelectTriggerStyler(chevronOpacity: value));
  }

  /// Sets the placeholderOpacity.
  SelectTriggerStyler placeholderOpacity(double value) {
    return merge(SelectTriggerStyler(placeholderOpacity: value));
  }

  /// Sets the animation configuration.
  @override
  SelectTriggerStyler animate(AnimationConfig value) {
    return merge(SelectTriggerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SelectTriggerStyler variants(List<VariantStyle<SelectTriggerSpec>> value) {
    return merge(SelectTriggerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SelectTriggerStyler wrap(WidgetModifierConfig value) {
    return merge(SelectTriggerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SelectTriggerStyler modifier(WidgetModifierConfig value) {
    return merge(SelectTriggerStyler(modifier: value));
  }

  /// Merges with another [SelectTriggerStyler].
  @override
  SelectTriggerStyler merge(SelectTriggerStyler? other) {
    return SelectTriggerStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      placeholder: MixOps.merge($placeholder, other?.$placeholder),
      icon: MixOps.merge($icon, other?.$icon),
      chevron: MixOps.merge($chevron, other?.$chevron),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      chevronOpacity: MixOps.merge($chevronOpacity, other?.$chevronOpacity),
      placeholderOpacity: MixOps.merge(
        $placeholderOpacity,
        other?.$placeholderOpacity,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SelectTriggerSpec>] using [context].
  @override
  StyleSpec<SelectTriggerSpec> resolve(BuildContext context) {
    final spec = SelectTriggerSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      placeholder: MixOps.resolve(context, $placeholder),
      icon: MixOps.resolve(context, $icon),
      chevron: MixOps.resolve(context, $chevron),
      containerEffects: MixOps.resolve(context, $containerEffects),
      chevronOpacity: MixOps.resolve(context, $chevronOpacity),
      placeholderOpacity: MixOps.resolve(context, $placeholderOpacity),
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
      ..add(DiagnosticsProperty('placeholder', $placeholder))
      ..add(DiagnosticsProperty('icon', $icon))
      ..add(DiagnosticsProperty('chevron', $chevron))
      ..add(DiagnosticsProperty('containerEffects', $containerEffects))
      ..add(DiagnosticsProperty('chevronOpacity', $chevronOpacity))
      ..add(DiagnosticsProperty('placeholderOpacity', $placeholderOpacity));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $placeholder,
    $icon,
    $chevron,
    $containerEffects,
    $chevronOpacity,
    $placeholderOpacity,
    $animation,
    $modifier,
    $variants,
  ];
}

class SelectContentStyler
    extends MixStyler<SelectContentStyler, SelectContentSpec>
    with RemixBoxStylerMixin<SelectContentStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;

  const SelectContentStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $containerEffects = containerEffects;

  SelectContentStyler({
    BoxStyler? container,
    RemixBoxEffectsMix? containerEffects,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SelectContentSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         containerEffects: Prop.maybeMix(containerEffects),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SelectContentStyler.container(BoxStyler value) =>
      SelectContentStyler().container(value);
  factory SelectContentStyler.containerEffects(RemixBoxEffectsMix value) =>
      SelectContentStyler().containerEffects(value);
  factory SelectContentStyler.alignment(AlignmentGeometry value) =>
      SelectContentStyler().alignment(value);
  factory SelectContentStyler.padding(EdgeInsetsGeometryMix value) =>
      SelectContentStyler().padding(value);
  factory SelectContentStyler.margin(EdgeInsetsGeometryMix value) =>
      SelectContentStyler().margin(value);
  factory SelectContentStyler.constraints(BoxConstraintsMix value) =>
      SelectContentStyler().constraints(value);
  factory SelectContentStyler.decoration(DecorationMix value) =>
      SelectContentStyler().decoration(value);
  factory SelectContentStyler.foregroundDecoration(DecorationMix value) =>
      SelectContentStyler().foregroundDecoration(value);
  factory SelectContentStyler.clipBehavior(Clip value) =>
      SelectContentStyler().clipBehavior(value);
  factory SelectContentStyler.color(Color value) =>
      SelectContentStyler().color(value);
  factory SelectContentStyler.gradient(GradientMix value) =>
      SelectContentStyler().gradient(value);
  factory SelectContentStyler.border(BoxBorderMix value) =>
      SelectContentStyler().border(value);
  factory SelectContentStyler.borderRadius(BorderRadiusGeometryMix value) =>
      SelectContentStyler().borderRadius(value);
  factory SelectContentStyler.elevation(ElevationShadow value) =>
      SelectContentStyler().elevation(value);
  factory SelectContentStyler.shadow(BoxShadowMix value) =>
      SelectContentStyler().shadow(value);
  factory SelectContentStyler.shadows(List<BoxShadowMix> value) =>
      SelectContentStyler().shadows(value);
  factory SelectContentStyler.width(double value) =>
      SelectContentStyler().width(value);
  factory SelectContentStyler.height(double value) =>
      SelectContentStyler().height(value);
  factory SelectContentStyler.size(double width, double height) =>
      SelectContentStyler().size(width, height);
  factory SelectContentStyler.minWidth(double value) =>
      SelectContentStyler().minWidth(value);
  factory SelectContentStyler.maxWidth(double value) =>
      SelectContentStyler().maxWidth(value);
  factory SelectContentStyler.minHeight(double value) =>
      SelectContentStyler().minHeight(value);
  factory SelectContentStyler.maxHeight(double value) =>
      SelectContentStyler().maxHeight(value);
  factory SelectContentStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => SelectContentStyler().scale(scale, alignment: alignment);
  factory SelectContentStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => SelectContentStyler().rotate(radians, alignment: alignment);
  factory SelectContentStyler.translate(double x, double y, [double z = 0.0]) =>
      SelectContentStyler().translate(x, y, z);
  factory SelectContentStyler.skew(double skewX, double skewY) =>
      SelectContentStyler().skew(skewX, skewY);
  factory SelectContentStyler.textStyle(TextStyler value) =>
      SelectContentStyler().textStyle(value);
  factory SelectContentStyler.image(DecorationImageMix value) =>
      SelectContentStyler().image(value);
  factory SelectContentStyler.shape(ShapeBorderMix value) =>
      SelectContentStyler().shape(value);
  factory SelectContentStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectContentStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectContentStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectContentStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectContentStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectContentStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectContentStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SelectContentStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SelectContentStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SelectContentStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SelectContentStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SelectContentStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SelectContentStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SelectContentStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SelectContentStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SelectContentStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SelectContentStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SelectContentStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SelectContentStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => SelectContentStyler().transform(value, alignment: alignment);

  SelectContentStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  SelectContentStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  SelectContentStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  SelectContentStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  SelectContentStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  SelectContentStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  SelectContentStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  SelectContentStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  SelectContentStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  SelectContentStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  SelectContentStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  SelectContentStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  SelectContentStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  SelectContentStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  SelectContentStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  SelectContentStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  SelectContentStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  SelectContentStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  SelectContentStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  SelectContentStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  SelectContentStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  SelectContentStyler scale(double scale, {Alignment alignment = .center}) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  SelectContentStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  SelectContentStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  SelectContentStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  SelectContentStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  SelectContentStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  SelectContentStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  SelectContentStyler backgroundImage(
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

  SelectContentStyler backgroundImageUrl(
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

  SelectContentStyler backgroundImageAsset(
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

  SelectContentStyler linearGradient({
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

  SelectContentStyler radialGradient({
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

  SelectContentStyler sweepGradient({
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

  SelectContentStyler foregroundLinearGradient({
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

  SelectContentStyler foregroundRadialGradient({
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

  SelectContentStyler foregroundSweepGradient({
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

  SelectContentStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  SelectContentStyler container(BoxStyler value) {
    return merge(SelectContentStyler(container: value));
  }

  /// Sets the containerEffects.
  SelectContentStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(SelectContentStyler(containerEffects: value));
  }

  /// Sets the animation configuration.
  @override
  SelectContentStyler animate(AnimationConfig value) {
    return merge(SelectContentStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SelectContentStyler variants(List<VariantStyle<SelectContentSpec>> value) {
    return merge(SelectContentStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SelectContentStyler wrap(WidgetModifierConfig value) {
    return merge(SelectContentStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SelectContentStyler modifier(WidgetModifierConfig value) {
    return merge(SelectContentStyler(modifier: value));
  }

  /// Merges with another [SelectContentStyler].
  @override
  SelectContentStyler merge(SelectContentStyler? other) {
    return SelectContentStyler.create(
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

  /// Resolves to [StyleSpec<SelectContentSpec>] using [context].
  @override
  StyleSpec<SelectContentSpec> resolve(BuildContext context) {
    final spec = SelectContentSpec(
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

class SelectMenuItemStyler
    extends MixStyler<SelectMenuItemStyler, SelectMenuItemSpec>
    with
        RemixBoxStylerMixin<SelectMenuItemStyler>,
        IconStyleMixin<SelectMenuItemStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $text;
  final Prop<StyleSpec<BoxSpec>>? $indicator;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const SelectMenuItemStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? text,
    Prop<StyleSpec<BoxSpec>>? indicator,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $text = text,
       $indicator = indicator,
       $icon = icon;

  SelectMenuItemStyler({
    FlexBoxStyler? container,
    TextStyler? text,
    BoxStyler? indicator,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SelectMenuItemSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         text: Prop.maybeMix(text),
         indicator: Prop.maybeMix(indicator),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SelectMenuItemStyler.container(FlexBoxStyler value) =>
      SelectMenuItemStyler().container(value);
  factory SelectMenuItemStyler.text(TextStyler value) =>
      SelectMenuItemStyler().text(value);
  factory SelectMenuItemStyler.indicator(BoxStyler value) =>
      SelectMenuItemStyler().indicator(value);
  factory SelectMenuItemStyler.icon(IconStyler value) =>
      SelectMenuItemStyler().icon(value);
  factory SelectMenuItemStyler.color(Color value) =>
      SelectMenuItemStyler().color(value);
  factory SelectMenuItemStyler.gradient(GradientMix value) =>
      SelectMenuItemStyler().gradient(value);
  factory SelectMenuItemStyler.border(BoxBorderMix value) =>
      SelectMenuItemStyler().border(value);
  factory SelectMenuItemStyler.borderRadius(BorderRadiusGeometryMix value) =>
      SelectMenuItemStyler().borderRadius(value);
  factory SelectMenuItemStyler.elevation(ElevationShadow value) =>
      SelectMenuItemStyler().elevation(value);
  factory SelectMenuItemStyler.shadow(BoxShadowMix value) =>
      SelectMenuItemStyler().shadow(value);
  factory SelectMenuItemStyler.shadows(List<BoxShadowMix> value) =>
      SelectMenuItemStyler().shadows(value);
  factory SelectMenuItemStyler.width(double value) =>
      SelectMenuItemStyler().width(value);
  factory SelectMenuItemStyler.height(double value) =>
      SelectMenuItemStyler().height(value);
  factory SelectMenuItemStyler.size(double width, double height) =>
      SelectMenuItemStyler().size(width, height);
  factory SelectMenuItemStyler.minWidth(double value) =>
      SelectMenuItemStyler().minWidth(value);
  factory SelectMenuItemStyler.maxWidth(double value) =>
      SelectMenuItemStyler().maxWidth(value);
  factory SelectMenuItemStyler.minHeight(double value) =>
      SelectMenuItemStyler().minHeight(value);
  factory SelectMenuItemStyler.maxHeight(double value) =>
      SelectMenuItemStyler().maxHeight(value);
  factory SelectMenuItemStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => SelectMenuItemStyler().scale(scale, alignment: alignment);
  factory SelectMenuItemStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => SelectMenuItemStyler().rotate(radians, alignment: alignment);
  factory SelectMenuItemStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => SelectMenuItemStyler().translate(x, y, z);
  factory SelectMenuItemStyler.skew(double skewX, double skewY) =>
      SelectMenuItemStyler().skew(skewX, skewY);
  factory SelectMenuItemStyler.textStyle(TextStyler value) =>
      SelectMenuItemStyler().textStyle(value);
  factory SelectMenuItemStyler.image(DecorationImageMix value) =>
      SelectMenuItemStyler().image(value);
  factory SelectMenuItemStyler.shape(ShapeBorderMix value) =>
      SelectMenuItemStyler().shape(value);
  factory SelectMenuItemStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectMenuItemStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectMenuItemStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectMenuItemStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectMenuItemStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SelectMenuItemStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SelectMenuItemStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SelectMenuItemStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SelectMenuItemStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SelectMenuItemStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SelectMenuItemStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SelectMenuItemStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SelectMenuItemStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SelectMenuItemStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SelectMenuItemStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SelectMenuItemStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SelectMenuItemStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SelectMenuItemStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SelectMenuItemStyler.row() => SelectMenuItemStyler().row();
  factory SelectMenuItemStyler.column() => SelectMenuItemStyler().column();
  factory SelectMenuItemStyler.alignment(AlignmentGeometry value) =>
      SelectMenuItemStyler().alignment(value);
  factory SelectMenuItemStyler.padding(EdgeInsetsGeometryMix value) =>
      SelectMenuItemStyler().padding(value);
  factory SelectMenuItemStyler.margin(EdgeInsetsGeometryMix value) =>
      SelectMenuItemStyler().margin(value);
  factory SelectMenuItemStyler.constraints(BoxConstraintsMix value) =>
      SelectMenuItemStyler().constraints(value);
  factory SelectMenuItemStyler.decoration(DecorationMix value) =>
      SelectMenuItemStyler().decoration(value);
  factory SelectMenuItemStyler.foregroundDecoration(DecorationMix value) =>
      SelectMenuItemStyler().foregroundDecoration(value);
  factory SelectMenuItemStyler.clipBehavior(Clip value) =>
      SelectMenuItemStyler().clipBehavior(value);
  factory SelectMenuItemStyler.direction(Axis value) =>
      SelectMenuItemStyler().direction(value);
  factory SelectMenuItemStyler.mainAxisAlignment(MainAxisAlignment value) =>
      SelectMenuItemStyler().mainAxisAlignment(value);
  factory SelectMenuItemStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      SelectMenuItemStyler().crossAxisAlignment(value);
  factory SelectMenuItemStyler.mainAxisSize(MainAxisSize value) =>
      SelectMenuItemStyler().mainAxisSize(value);
  factory SelectMenuItemStyler.spacing(double value) =>
      SelectMenuItemStyler().spacing(value);
  factory SelectMenuItemStyler.verticalDirection(VerticalDirection value) =>
      SelectMenuItemStyler().verticalDirection(value);
  factory SelectMenuItemStyler.textDirection(TextDirection value) =>
      SelectMenuItemStyler().textDirection(value);
  factory SelectMenuItemStyler.textBaseline(TextBaseline value) =>
      SelectMenuItemStyler().textBaseline(value);
  factory SelectMenuItemStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => SelectMenuItemStyler().transform(value, alignment: alignment);

  SelectMenuItemStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  SelectMenuItemStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  SelectMenuItemStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  SelectMenuItemStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  SelectMenuItemStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  SelectMenuItemStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  SelectMenuItemStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  SelectMenuItemStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  SelectMenuItemStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  SelectMenuItemStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  SelectMenuItemStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  SelectMenuItemStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  SelectMenuItemStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  SelectMenuItemStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  SelectMenuItemStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  SelectMenuItemStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  SelectMenuItemStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  SelectMenuItemStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  SelectMenuItemStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  SelectMenuItemStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  SelectMenuItemStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  SelectMenuItemStyler backgroundImage(
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

  SelectMenuItemStyler backgroundImageUrl(
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

  SelectMenuItemStyler backgroundImageAsset(
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

  SelectMenuItemStyler linearGradient({
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

  SelectMenuItemStyler radialGradient({
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

  SelectMenuItemStyler sweepGradient({
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

  SelectMenuItemStyler foregroundLinearGradient({
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

  SelectMenuItemStyler foregroundRadialGradient({
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

  SelectMenuItemStyler foregroundSweepGradient({
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

  SelectMenuItemStyler row() {
    return container(FlexBoxStyler().row());
  }

  SelectMenuItemStyler column() {
    return container(FlexBoxStyler().column());
  }

  SelectMenuItemStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  SelectMenuItemStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  SelectMenuItemStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  SelectMenuItemStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  SelectMenuItemStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  SelectMenuItemStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  SelectMenuItemStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  SelectMenuItemStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  SelectMenuItemStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  SelectMenuItemStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  SelectMenuItemStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  SelectMenuItemStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  SelectMenuItemStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  SelectMenuItemStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  SelectMenuItemStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  SelectMenuItemStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  SelectMenuItemStyler container(FlexBoxStyler value) {
    return merge(SelectMenuItemStyler(container: value));
  }

  /// Sets the text.
  SelectMenuItemStyler text(TextStyler value) {
    return merge(SelectMenuItemStyler(text: value));
  }

  /// Sets the indicator.
  SelectMenuItemStyler indicator(BoxStyler value) {
    return merge(SelectMenuItemStyler(indicator: value));
  }

  /// Sets the icon.
  @override
  SelectMenuItemStyler icon(IconStyler value) {
    return merge(SelectMenuItemStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  SelectMenuItemStyler animate(AnimationConfig value) {
    return merge(SelectMenuItemStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SelectMenuItemStyler variants(List<VariantStyle<SelectMenuItemSpec>> value) {
    return merge(SelectMenuItemStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SelectMenuItemStyler wrap(WidgetModifierConfig value) {
    return merge(SelectMenuItemStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SelectMenuItemStyler modifier(WidgetModifierConfig value) {
    return merge(SelectMenuItemStyler(modifier: value));
  }

  /// Merges with another [SelectMenuItemStyler].
  @override
  SelectMenuItemStyler merge(SelectMenuItemStyler? other) {
    return SelectMenuItemStyler.create(
      container: MixOps.merge($container, other?.$container),
      text: MixOps.merge($text, other?.$text),
      indicator: MixOps.merge($indicator, other?.$indicator),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SelectMenuItemSpec>] using [context].
  @override
  StyleSpec<SelectMenuItemSpec> resolve(BuildContext context) {
    final spec = SelectMenuItemSpec(
      container: MixOps.resolve(context, $container),
      text: MixOps.resolve(context, $text),
      indicator: MixOps.resolve(context, $indicator),
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
      ..add(DiagnosticsProperty('text', $text))
      ..add(DiagnosticsProperty('indicator', $indicator))
      ..add(DiagnosticsProperty('icon', $icon));
  }

  @override
  List<Object?> get props => [
    $container,
    $text,
    $indicator,
    $icon,
    $animation,
    $modifier,
    $variants,
  ];
}
