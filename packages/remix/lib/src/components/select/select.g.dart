// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$RemixSelectSpec implements Spec<RemixSelectSpec>, Diagnosticable {
  StyleSpec<RemixSelectTriggerSpec> get trigger;
  StyleSpec<RemixSelectContentSpec> get content;
  StyleSpec<RemixSelectMenuItemSpec> get item;
  StyleSpec<RemixSelectLabelSpec> get label;
  StyleSpec<BoxSpec> get separator;

  @override
  Type get type => RemixSelectSpec;

  @override
  RemixSelectSpec copyWith({
    StyleSpec<RemixSelectTriggerSpec>? trigger,
    StyleSpec<RemixSelectContentSpec>? content,
    StyleSpec<RemixSelectMenuItemSpec>? item,
    StyleSpec<RemixSelectLabelSpec>? label,
    StyleSpec<BoxSpec>? separator,
  }) {
    return RemixSelectSpec(
      trigger: trigger ?? this.trigger,
      content: content ?? this.content,
      item: item ?? this.item,
      label: label ?? this.label,
      separator: separator ?? this.separator,
    );
  }

  @override
  RemixSelectSpec lerp(RemixSelectSpec? other, double t) {
    return RemixSelectSpec(
      trigger: trigger.lerp(other?.trigger, t),
      content: content.lerp(other?.content, t),
      item: item.lerp(other?.item, t),
      label: label.lerp(other?.label, t),
      separator: separator.lerp(other?.separator, t),
    );
  }

  @override
  List<Object?> get props => [trigger, content, item, label, separator];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixSelectSpec &&
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
      ..add(DiagnosticsProperty('item', item))
      ..add(DiagnosticsProperty('label', label))
      ..add(DiagnosticsProperty('separator', separator));
  }
}

@Deprecated(
  'Rename to `_\$RemixSelectSpec` and migrate the class declaration to `class RemixSelectSpec with _\$RemixSelectSpec`. The `_\$RemixSelectSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixSelectSpecMethods = _$RemixSelectSpec; // ignore: unused_element

mixin _$RemixSelectTriggerSpec
    implements Spec<RemixSelectTriggerSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<TextSpec> get placeholder;
  StyleSpec<IconSpec> get icon;
  StyleSpec<IconSpec> get chevron;
  RemixSurfaceLayerSpec? get surface;
  RemixSurfaceLayerSpec? get overlay;
  double? get chevronOpacity;
  double? get placeholderOpacity;

  @override
  Type get type => RemixSelectTriggerSpec;

  @override
  RemixSelectTriggerSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<TextSpec>? placeholder,
    StyleSpec<IconSpec>? icon,
    StyleSpec<IconSpec>? chevron,
    RemixSurfaceLayerSpec? surface,
    RemixSurfaceLayerSpec? overlay,
    double? chevronOpacity,
    double? placeholderOpacity,
  }) {
    return RemixSelectTriggerSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      placeholder: placeholder ?? this.placeholder,
      icon: icon ?? this.icon,
      chevron: chevron ?? this.chevron,
      surface: surface ?? this.surface,
      overlay: overlay ?? this.overlay,
      chevronOpacity: chevronOpacity ?? this.chevronOpacity,
      placeholderOpacity: placeholderOpacity ?? this.placeholderOpacity,
    );
  }

  @override
  RemixSelectTriggerSpec lerp(RemixSelectTriggerSpec? other, double t) {
    return RemixSelectTriggerSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      placeholder: placeholder.lerp(other?.placeholder, t),
      icon: icon.lerp(other?.icon, t),
      chevron: chevron.lerp(other?.chevron, t),
      surface: MixOps.lerpSnap(surface, other?.surface, t),
      overlay: MixOps.lerpSnap(overlay, other?.overlay, t),
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
    surface,
    overlay,
    chevronOpacity,
    placeholderOpacity,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixSelectTriggerSpec &&
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
      ..add(DiagnosticsProperty('surface', surface))
      ..add(DiagnosticsProperty('overlay', overlay))
      ..add(DoubleProperty('chevronOpacity', chevronOpacity))
      ..add(DoubleProperty('placeholderOpacity', placeholderOpacity));
  }
}

@Deprecated(
  'Rename to `_\$RemixSelectTriggerSpec` and migrate the class declaration to `class RemixSelectTriggerSpec with _\$RemixSelectTriggerSpec`. The `_\$RemixSelectTriggerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixSelectTriggerSpecMethods = _$RemixSelectTriggerSpec; // ignore: unused_element

mixin _$RemixSelectContentSpec
    implements Spec<RemixSelectContentSpec>, Diagnosticable {
  StyleSpec<BoxSpec> get container;
  RemixSurfaceLayerSpec? get surface;

  @override
  Type get type => RemixSelectContentSpec;

  @override
  RemixSelectContentSpec copyWith({
    StyleSpec<BoxSpec>? container,
    RemixSurfaceLayerSpec? surface,
  }) {
    return RemixSelectContentSpec(
      container: container ?? this.container,
      surface: surface ?? this.surface,
    );
  }

  @override
  RemixSelectContentSpec lerp(RemixSelectContentSpec? other, double t) {
    return RemixSelectContentSpec(
      container: container.lerp(other?.container, t),
      surface: MixOps.lerpSnap(surface, other?.surface, t),
    );
  }

  @override
  List<Object?> get props => [container, surface];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixSelectContentSpec &&
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
      ..add(DiagnosticsProperty('surface', surface));
  }
}

@Deprecated(
  'Rename to `_\$RemixSelectContentSpec` and migrate the class declaration to `class RemixSelectContentSpec with _\$RemixSelectContentSpec`. The `_\$RemixSelectContentSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixSelectContentSpecMethods = _$RemixSelectContentSpec; // ignore: unused_element

mixin _$RemixSelectMenuItemSpec
    implements Spec<RemixSelectMenuItemSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get text;
  StyleSpec<BoxSpec> get indicator;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => RemixSelectMenuItemSpec;

  @override
  RemixSelectMenuItemSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    StyleSpec<BoxSpec>? indicator,
    StyleSpec<IconSpec>? icon,
  }) {
    return RemixSelectMenuItemSpec(
      container: container ?? this.container,
      text: text ?? this.text,
      indicator: indicator ?? this.indicator,
      icon: icon ?? this.icon,
    );
  }

  @override
  RemixSelectMenuItemSpec lerp(RemixSelectMenuItemSpec? other, double t) {
    return RemixSelectMenuItemSpec(
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
        other is RemixSelectMenuItemSpec &&
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
  'Rename to `_\$RemixSelectMenuItemSpec` and migrate the class declaration to `class RemixSelectMenuItemSpec with _\$RemixSelectMenuItemSpec`. The `_\$RemixSelectMenuItemSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixSelectMenuItemSpecMethods = _$RemixSelectMenuItemSpec; // ignore: unused_element

mixin _$RemixSelectLabelSpec
    implements Spec<RemixSelectLabelSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get text;
  double? get adjacentItemSpacing;

  @override
  Type get type => RemixSelectLabelSpec;

  @override
  RemixSelectLabelSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? text,
    double? adjacentItemSpacing,
  }) {
    return RemixSelectLabelSpec(
      container: container ?? this.container,
      text: text ?? this.text,
      adjacentItemSpacing: adjacentItemSpacing ?? this.adjacentItemSpacing,
    );
  }

  @override
  RemixSelectLabelSpec lerp(RemixSelectLabelSpec? other, double t) {
    return RemixSelectLabelSpec(
      container: container.lerp(other?.container, t),
      text: text.lerp(other?.text, t),
      adjacentItemSpacing: MixOps.lerp(
        adjacentItemSpacing,
        other?.adjacentItemSpacing,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [container, text, adjacentItemSpacing];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is RemixSelectLabelSpec &&
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
      ..add(DoubleProperty('adjacentItemSpacing', adjacentItemSpacing));
  }
}

@Deprecated(
  'Rename to `_\$RemixSelectLabelSpec` and migrate the class declaration to `class RemixSelectLabelSpec with _\$RemixSelectLabelSpec`. The `_\$RemixSelectLabelSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$RemixSelectLabelSpecMethods = _$RemixSelectLabelSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class RemixSelectStyler extends MixStyler<RemixSelectStyler, RemixSelectSpec> {
  final Prop<StyleSpec<RemixSelectTriggerSpec>>? $trigger;
  final Prop<StyleSpec<RemixSelectContentSpec>>? $content;
  final Prop<StyleSpec<RemixSelectMenuItemSpec>>? $item;
  final Prop<StyleSpec<RemixSelectLabelSpec>>? $label;
  final Prop<StyleSpec<BoxSpec>>? $separator;

  const RemixSelectStyler.create({
    Prop<StyleSpec<RemixSelectTriggerSpec>>? trigger,
    Prop<StyleSpec<RemixSelectContentSpec>>? content,
    Prop<StyleSpec<RemixSelectMenuItemSpec>>? item,
    Prop<StyleSpec<RemixSelectLabelSpec>>? label,
    Prop<StyleSpec<BoxSpec>>? separator,
    super.variants,
    super.modifier,
    super.animation,
  }) : $trigger = trigger,
       $content = content,
       $item = item,
       $label = label,
       $separator = separator;

  RemixSelectStyler({
    RemixSelectTriggerStyler? trigger,
    RemixSelectContentStyler? content,
    RemixSelectMenuItemStyler? item,
    RemixSelectLabelStyler? label,
    BoxStyler? separator,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixSelectSpec>>? variants,
  }) : this.create(
         trigger: Prop.maybeMix(trigger),
         content: Prop.maybeMix(content),
         item: Prop.maybeMix(item),
         label: Prop.maybeMix(label),
         separator: Prop.maybeMix(separator),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixSelectStyler.trigger(RemixSelectTriggerStyler value) =>
      RemixSelectStyler().trigger(value);
  factory RemixSelectStyler.content(RemixSelectContentStyler value) =>
      RemixSelectStyler().content(value);
  factory RemixSelectStyler.item(RemixSelectMenuItemStyler value) =>
      RemixSelectStyler().item(value);
  factory RemixSelectStyler.label(RemixSelectLabelStyler value) =>
      RemixSelectStyler().label(value);
  factory RemixSelectStyler.separator(BoxStyler value) =>
      RemixSelectStyler().separator(value);

  /// Sets the trigger.
  RemixSelectStyler trigger(RemixSelectTriggerStyler value) {
    return merge(RemixSelectStyler(trigger: value));
  }

  /// Sets the content.
  RemixSelectStyler content(RemixSelectContentStyler value) {
    return merge(RemixSelectStyler(content: value));
  }

  /// Sets the item.
  RemixSelectStyler item(RemixSelectMenuItemStyler value) {
    return merge(RemixSelectStyler(item: value));
  }

  /// Sets the label.
  RemixSelectStyler label(RemixSelectLabelStyler value) {
    return merge(RemixSelectStyler(label: value));
  }

  /// Sets the separator.
  RemixSelectStyler separator(BoxStyler value) {
    return merge(RemixSelectStyler(separator: value));
  }

  /// Sets the animation configuration.
  @override
  RemixSelectStyler animate(AnimationConfig value) {
    return merge(RemixSelectStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixSelectStyler variants(List<VariantStyle<RemixSelectSpec>> value) {
    return merge(RemixSelectStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixSelectStyler wrap(WidgetModifierConfig value) {
    return merge(RemixSelectStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixSelectStyler modifier(WidgetModifierConfig value) {
    return merge(RemixSelectStyler(modifier: value));
  }

  /// Merges with another [RemixSelectStyler].
  @override
  RemixSelectStyler merge(RemixSelectStyler? other) {
    return RemixSelectStyler.create(
      trigger: MixOps.merge($trigger, other?.$trigger),
      content: MixOps.merge($content, other?.$content),
      item: MixOps.merge($item, other?.$item),
      label: MixOps.merge($label, other?.$label),
      separator: MixOps.merge($separator, other?.$separator),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixSelectSpec>] using [context].
  @override
  StyleSpec<RemixSelectSpec> resolve(BuildContext context) {
    final spec = RemixSelectSpec(
      trigger: MixOps.resolve(context, $trigger),
      content: MixOps.resolve(context, $content),
      item: MixOps.resolve(context, $item),
      label: MixOps.resolve(context, $label),
      separator: MixOps.resolve(context, $separator),
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
      ..add(DiagnosticsProperty('item', $item))
      ..add(DiagnosticsProperty('label', $label))
      ..add(DiagnosticsProperty('separator', $separator));
  }

  @override
  List<Object?> get props => [
    $trigger,
    $content,
    $item,
    $label,
    $separator,
    $animation,
    $modifier,
    $variants,
  ];
}

class RemixSelectTriggerStyler
    extends MixStyler<RemixSelectTriggerStyler, RemixSelectTriggerSpec>
    with
        RemixBoxStylerMixin<RemixSelectTriggerStyler>,
        LabelStyleMixin<RemixSelectTriggerStyler>,
        IconStyleMixin<RemixSelectTriggerStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<TextSpec>>? $placeholder;
  final Prop<StyleSpec<IconSpec>>? $icon;
  final Prop<StyleSpec<IconSpec>>? $chevron;
  final Prop<RemixSurfaceLayerSpec>? $surface;
  final Prop<RemixSurfaceLayerSpec>? $overlay;
  final Prop<double>? $chevronOpacity;
  final Prop<double>? $placeholderOpacity;

  const RemixSelectTriggerStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<TextSpec>>? placeholder,
    Prop<StyleSpec<IconSpec>>? icon,
    Prop<StyleSpec<IconSpec>>? chevron,
    Prop<RemixSurfaceLayerSpec>? surface,
    Prop<RemixSurfaceLayerSpec>? overlay,
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
       $surface = surface,
       $overlay = overlay,
       $chevronOpacity = chevronOpacity,
       $placeholderOpacity = placeholderOpacity;

  RemixSelectTriggerStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    TextStyler? placeholder,
    IconStyler? icon,
    IconStyler? chevron,
    RemixSurfaceLayerMix? surface,
    RemixSurfaceLayerMix? overlay,
    double? chevronOpacity,
    double? placeholderOpacity,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixSelectTriggerSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         placeholder: Prop.maybeMix(placeholder),
         icon: Prop.maybeMix(icon),
         chevron: Prop.maybeMix(chevron),
         surface: Prop.maybeMix(surface),
         overlay: Prop.maybeMix(overlay),
         chevronOpacity: Prop.maybe(chevronOpacity),
         placeholderOpacity: Prop.maybe(placeholderOpacity),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixSelectTriggerStyler.container(FlexBoxStyler value) =>
      RemixSelectTriggerStyler().container(value);
  factory RemixSelectTriggerStyler.label(TextStyler value) =>
      RemixSelectTriggerStyler().label(value);
  factory RemixSelectTriggerStyler.placeholder(TextStyler value) =>
      RemixSelectTriggerStyler().placeholder(value);
  factory RemixSelectTriggerStyler.icon(IconStyler value) =>
      RemixSelectTriggerStyler().icon(value);
  factory RemixSelectTriggerStyler.chevron(IconStyler value) =>
      RemixSelectTriggerStyler().chevron(value);
  factory RemixSelectTriggerStyler.surface(RemixSurfaceLayerMix value) =>
      RemixSelectTriggerStyler().surface(value);
  factory RemixSelectTriggerStyler.overlay(RemixSurfaceLayerMix value) =>
      RemixSelectTriggerStyler().overlay(value);
  factory RemixSelectTriggerStyler.chevronOpacity(double value) =>
      RemixSelectTriggerStyler().chevronOpacity(value);
  factory RemixSelectTriggerStyler.placeholderOpacity(double value) =>
      RemixSelectTriggerStyler().placeholderOpacity(value);
  factory RemixSelectTriggerStyler.color(Color value) =>
      RemixSelectTriggerStyler().color(value);
  factory RemixSelectTriggerStyler.gradient(GradientMix value) =>
      RemixSelectTriggerStyler().gradient(value);
  factory RemixSelectTriggerStyler.border(BoxBorderMix value) =>
      RemixSelectTriggerStyler().border(value);
  factory RemixSelectTriggerStyler.borderRadius(
    BorderRadiusGeometryMix value,
  ) => RemixSelectTriggerStyler().borderRadius(value);
  factory RemixSelectTriggerStyler.elevation(ElevationShadow value) =>
      RemixSelectTriggerStyler().elevation(value);
  factory RemixSelectTriggerStyler.shadow(BoxShadowMix value) =>
      RemixSelectTriggerStyler().shadow(value);
  factory RemixSelectTriggerStyler.shadows(List<BoxShadowMix> value) =>
      RemixSelectTriggerStyler().shadows(value);
  factory RemixSelectTriggerStyler.width(double value) =>
      RemixSelectTriggerStyler().width(value);
  factory RemixSelectTriggerStyler.height(double value) =>
      RemixSelectTriggerStyler().height(value);
  factory RemixSelectTriggerStyler.size(double width, double height) =>
      RemixSelectTriggerStyler().size(width, height);
  factory RemixSelectTriggerStyler.minWidth(double value) =>
      RemixSelectTriggerStyler().minWidth(value);
  factory RemixSelectTriggerStyler.maxWidth(double value) =>
      RemixSelectTriggerStyler().maxWidth(value);
  factory RemixSelectTriggerStyler.minHeight(double value) =>
      RemixSelectTriggerStyler().minHeight(value);
  factory RemixSelectTriggerStyler.maxHeight(double value) =>
      RemixSelectTriggerStyler().maxHeight(value);
  factory RemixSelectTriggerStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixSelectTriggerStyler().scale(scale, alignment: alignment);
  factory RemixSelectTriggerStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixSelectTriggerStyler().rotate(radians, alignment: alignment);
  factory RemixSelectTriggerStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => RemixSelectTriggerStyler().translate(x, y, z);
  factory RemixSelectTriggerStyler.skew(double skewX, double skewY) =>
      RemixSelectTriggerStyler().skew(skewX, skewY);
  factory RemixSelectTriggerStyler.textStyle(TextStyler value) =>
      RemixSelectTriggerStyler().textStyle(value);
  factory RemixSelectTriggerStyler.image(DecorationImageMix value) =>
      RemixSelectTriggerStyler().image(value);
  factory RemixSelectTriggerStyler.shape(ShapeBorderMix value) =>
      RemixSelectTriggerStyler().shape(value);
  factory RemixSelectTriggerStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectTriggerStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectTriggerStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectTriggerStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectTriggerStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectTriggerStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectTriggerStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSelectTriggerStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSelectTriggerStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSelectTriggerStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSelectTriggerStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSelectTriggerStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSelectTriggerStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSelectTriggerStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSelectTriggerStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSelectTriggerStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSelectTriggerStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSelectTriggerStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSelectTriggerStyler.row() => RemixSelectTriggerStyler().row();
  factory RemixSelectTriggerStyler.column() =>
      RemixSelectTriggerStyler().column();
  factory RemixSelectTriggerStyler.alignment(AlignmentGeometry value) =>
      RemixSelectTriggerStyler().alignment(value);
  factory RemixSelectTriggerStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixSelectTriggerStyler().padding(value);
  factory RemixSelectTriggerStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixSelectTriggerStyler().margin(value);
  factory RemixSelectTriggerStyler.constraints(BoxConstraintsMix value) =>
      RemixSelectTriggerStyler().constraints(value);
  factory RemixSelectTriggerStyler.decoration(DecorationMix value) =>
      RemixSelectTriggerStyler().decoration(value);
  factory RemixSelectTriggerStyler.foregroundDecoration(DecorationMix value) =>
      RemixSelectTriggerStyler().foregroundDecoration(value);
  factory RemixSelectTriggerStyler.clipBehavior(Clip value) =>
      RemixSelectTriggerStyler().clipBehavior(value);
  factory RemixSelectTriggerStyler.direction(Axis value) =>
      RemixSelectTriggerStyler().direction(value);
  factory RemixSelectTriggerStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixSelectTriggerStyler().mainAxisAlignment(value);
  factory RemixSelectTriggerStyler.crossAxisAlignment(
    CrossAxisAlignment value,
  ) => RemixSelectTriggerStyler().crossAxisAlignment(value);
  factory RemixSelectTriggerStyler.mainAxisSize(MainAxisSize value) =>
      RemixSelectTriggerStyler().mainAxisSize(value);
  factory RemixSelectTriggerStyler.spacing(double value) =>
      RemixSelectTriggerStyler().spacing(value);
  factory RemixSelectTriggerStyler.verticalDirection(VerticalDirection value) =>
      RemixSelectTriggerStyler().verticalDirection(value);
  factory RemixSelectTriggerStyler.textDirection(TextDirection value) =>
      RemixSelectTriggerStyler().textDirection(value);
  factory RemixSelectTriggerStyler.textBaseline(TextBaseline value) =>
      RemixSelectTriggerStyler().textBaseline(value);
  factory RemixSelectTriggerStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixSelectTriggerStyler().transform(value, alignment: alignment);

  RemixSelectTriggerStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixSelectTriggerStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixSelectTriggerStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixSelectTriggerStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixSelectTriggerStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixSelectTriggerStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixSelectTriggerStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixSelectTriggerStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixSelectTriggerStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixSelectTriggerStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixSelectTriggerStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixSelectTriggerStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixSelectTriggerStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixSelectTriggerStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixSelectTriggerStyler scale(
    double scale, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixSelectTriggerStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixSelectTriggerStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixSelectTriggerStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixSelectTriggerStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixSelectTriggerStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixSelectTriggerStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixSelectTriggerStyler backgroundImage(
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

  RemixSelectTriggerStyler backgroundImageUrl(
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

  RemixSelectTriggerStyler backgroundImageAsset(
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

  RemixSelectTriggerStyler linearGradient({
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

  RemixSelectTriggerStyler radialGradient({
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

  RemixSelectTriggerStyler sweepGradient({
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

  RemixSelectTriggerStyler foregroundLinearGradient({
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

  RemixSelectTriggerStyler foregroundRadialGradient({
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

  RemixSelectTriggerStyler foregroundSweepGradient({
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

  RemixSelectTriggerStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixSelectTriggerStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixSelectTriggerStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixSelectTriggerStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixSelectTriggerStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixSelectTriggerStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixSelectTriggerStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixSelectTriggerStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixSelectTriggerStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixSelectTriggerStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixSelectTriggerStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixSelectTriggerStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixSelectTriggerStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixSelectTriggerStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixSelectTriggerStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixSelectTriggerStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixSelectTriggerStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixSelectTriggerStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixSelectTriggerStyler container(FlexBoxStyler value) {
    return merge(RemixSelectTriggerStyler(container: value));
  }

  /// Sets the label.
  @override
  RemixSelectTriggerStyler label(TextStyler value) {
    return merge(RemixSelectTriggerStyler(label: value));
  }

  /// Sets the placeholder.
  RemixSelectTriggerStyler placeholder(TextStyler value) {
    return merge(RemixSelectTriggerStyler(placeholder: value));
  }

  /// Sets the icon.
  @override
  RemixSelectTriggerStyler icon(IconStyler value) {
    return merge(RemixSelectTriggerStyler(icon: value));
  }

  /// Sets the chevron.
  RemixSelectTriggerStyler chevron(IconStyler value) {
    return merge(RemixSelectTriggerStyler(chevron: value));
  }

  /// Sets the surface.
  RemixSelectTriggerStyler surface(RemixSurfaceLayerMix value) {
    return merge(RemixSelectTriggerStyler(surface: value));
  }

  /// Sets the overlay.
  RemixSelectTriggerStyler overlay(RemixSurfaceLayerMix value) {
    return merge(RemixSelectTriggerStyler(overlay: value));
  }

  /// Sets the chevronOpacity.
  RemixSelectTriggerStyler chevronOpacity(double value) {
    return merge(RemixSelectTriggerStyler(chevronOpacity: value));
  }

  /// Sets the placeholderOpacity.
  RemixSelectTriggerStyler placeholderOpacity(double value) {
    return merge(RemixSelectTriggerStyler(placeholderOpacity: value));
  }

  /// Sets the animation configuration.
  @override
  RemixSelectTriggerStyler animate(AnimationConfig value) {
    return merge(RemixSelectTriggerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixSelectTriggerStyler variants(
    List<VariantStyle<RemixSelectTriggerSpec>> value,
  ) {
    return merge(RemixSelectTriggerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixSelectTriggerStyler wrap(WidgetModifierConfig value) {
    return merge(RemixSelectTriggerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixSelectTriggerStyler modifier(WidgetModifierConfig value) {
    return merge(RemixSelectTriggerStyler(modifier: value));
  }

  /// Merges with another [RemixSelectTriggerStyler].
  @override
  RemixSelectTriggerStyler merge(RemixSelectTriggerStyler? other) {
    return RemixSelectTriggerStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      placeholder: MixOps.merge($placeholder, other?.$placeholder),
      icon: MixOps.merge($icon, other?.$icon),
      chevron: MixOps.merge($chevron, other?.$chevron),
      surface: MixOps.merge($surface, other?.$surface),
      overlay: MixOps.merge($overlay, other?.$overlay),
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

  /// Resolves to [StyleSpec<RemixSelectTriggerSpec>] using [context].
  @override
  StyleSpec<RemixSelectTriggerSpec> resolve(BuildContext context) {
    final spec = RemixSelectTriggerSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      placeholder: MixOps.resolve(context, $placeholder),
      icon: MixOps.resolve(context, $icon),
      chevron: MixOps.resolve(context, $chevron),
      surface: MixOps.resolve(context, $surface),
      overlay: MixOps.resolve(context, $overlay),
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
      ..add(DiagnosticsProperty('surface', $surface))
      ..add(DiagnosticsProperty('overlay', $overlay))
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
    $surface,
    $overlay,
    $chevronOpacity,
    $placeholderOpacity,
    $animation,
    $modifier,
    $variants,
  ];
}

class RemixSelectContentStyler
    extends MixStyler<RemixSelectContentStyler, RemixSelectContentSpec>
    with RemixBoxStylerMixin<RemixSelectContentStyler> {
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<RemixSurfaceLayerSpec>? $surface;

  const RemixSelectContentStyler.create({
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<RemixSurfaceLayerSpec>? surface,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $surface = surface;

  RemixSelectContentStyler({
    BoxStyler? container,
    RemixSurfaceLayerMix? surface,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixSelectContentSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         surface: Prop.maybeMix(surface),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixSelectContentStyler.container(BoxStyler value) =>
      RemixSelectContentStyler().container(value);
  factory RemixSelectContentStyler.surface(RemixSurfaceLayerMix value) =>
      RemixSelectContentStyler().surface(value);
  factory RemixSelectContentStyler.alignment(AlignmentGeometry value) =>
      RemixSelectContentStyler().alignment(value);
  factory RemixSelectContentStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixSelectContentStyler().padding(value);
  factory RemixSelectContentStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixSelectContentStyler().margin(value);
  factory RemixSelectContentStyler.constraints(BoxConstraintsMix value) =>
      RemixSelectContentStyler().constraints(value);
  factory RemixSelectContentStyler.decoration(DecorationMix value) =>
      RemixSelectContentStyler().decoration(value);
  factory RemixSelectContentStyler.foregroundDecoration(DecorationMix value) =>
      RemixSelectContentStyler().foregroundDecoration(value);
  factory RemixSelectContentStyler.clipBehavior(Clip value) =>
      RemixSelectContentStyler().clipBehavior(value);
  factory RemixSelectContentStyler.color(Color value) =>
      RemixSelectContentStyler().color(value);
  factory RemixSelectContentStyler.gradient(GradientMix value) =>
      RemixSelectContentStyler().gradient(value);
  factory RemixSelectContentStyler.border(BoxBorderMix value) =>
      RemixSelectContentStyler().border(value);
  factory RemixSelectContentStyler.borderRadius(
    BorderRadiusGeometryMix value,
  ) => RemixSelectContentStyler().borderRadius(value);
  factory RemixSelectContentStyler.elevation(ElevationShadow value) =>
      RemixSelectContentStyler().elevation(value);
  factory RemixSelectContentStyler.shadow(BoxShadowMix value) =>
      RemixSelectContentStyler().shadow(value);
  factory RemixSelectContentStyler.shadows(List<BoxShadowMix> value) =>
      RemixSelectContentStyler().shadows(value);
  factory RemixSelectContentStyler.width(double value) =>
      RemixSelectContentStyler().width(value);
  factory RemixSelectContentStyler.height(double value) =>
      RemixSelectContentStyler().height(value);
  factory RemixSelectContentStyler.size(double width, double height) =>
      RemixSelectContentStyler().size(width, height);
  factory RemixSelectContentStyler.minWidth(double value) =>
      RemixSelectContentStyler().minWidth(value);
  factory RemixSelectContentStyler.maxWidth(double value) =>
      RemixSelectContentStyler().maxWidth(value);
  factory RemixSelectContentStyler.minHeight(double value) =>
      RemixSelectContentStyler().minHeight(value);
  factory RemixSelectContentStyler.maxHeight(double value) =>
      RemixSelectContentStyler().maxHeight(value);
  factory RemixSelectContentStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixSelectContentStyler().scale(scale, alignment: alignment);
  factory RemixSelectContentStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixSelectContentStyler().rotate(radians, alignment: alignment);
  factory RemixSelectContentStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => RemixSelectContentStyler().translate(x, y, z);
  factory RemixSelectContentStyler.skew(double skewX, double skewY) =>
      RemixSelectContentStyler().skew(skewX, skewY);
  factory RemixSelectContentStyler.textStyle(TextStyler value) =>
      RemixSelectContentStyler().textStyle(value);
  factory RemixSelectContentStyler.image(DecorationImageMix value) =>
      RemixSelectContentStyler().image(value);
  factory RemixSelectContentStyler.shape(ShapeBorderMix value) =>
      RemixSelectContentStyler().shape(value);
  factory RemixSelectContentStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectContentStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectContentStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectContentStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectContentStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectContentStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectContentStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSelectContentStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSelectContentStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSelectContentStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSelectContentStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSelectContentStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSelectContentStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSelectContentStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSelectContentStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSelectContentStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSelectContentStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSelectContentStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSelectContentStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixSelectContentStyler().transform(value, alignment: alignment);

  RemixSelectContentStyler alignment(AlignmentGeometry value) {
    return container(BoxStyler().alignment(value));
  }

  RemixSelectContentStyler padding(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().padding(value));
  }

  RemixSelectContentStyler margin(EdgeInsetsGeometryMix value) {
    return container(BoxStyler().margin(value));
  }

  RemixSelectContentStyler constraints(BoxConstraintsMix value) {
    return container(BoxStyler().constraints(value));
  }

  RemixSelectContentStyler decoration(DecorationMix value) {
    return container(BoxStyler().decoration(value));
  }

  RemixSelectContentStyler foregroundDecoration(DecorationMix value) {
    return container(BoxStyler().foregroundDecoration(value));
  }

  RemixSelectContentStyler clipBehavior(Clip value) {
    return container(BoxStyler().clipBehavior(value));
  }

  RemixSelectContentStyler color(Color value) {
    return container(BoxStyler().color(value));
  }

  RemixSelectContentStyler gradient(GradientMix value) {
    return container(BoxStyler().gradient(value));
  }

  RemixSelectContentStyler border(BoxBorderMix value) {
    return container(BoxStyler().border(value));
  }

  RemixSelectContentStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(BoxStyler().borderRadius(value));
  }

  RemixSelectContentStyler elevation(ElevationShadow value) {
    return container(BoxStyler().elevation(value));
  }

  RemixSelectContentStyler shadow(BoxShadowMix value) {
    return container(BoxStyler().shadow(value));
  }

  RemixSelectContentStyler shadows(List<BoxShadowMix> value) {
    return container(BoxStyler().shadows(value));
  }

  RemixSelectContentStyler width(double value) {
    return container(BoxStyler().width(value));
  }

  RemixSelectContentStyler height(double value) {
    return container(BoxStyler().height(value));
  }

  RemixSelectContentStyler size(double width, double height) {
    return container(BoxStyler().size(width, height));
  }

  RemixSelectContentStyler minWidth(double value) {
    return container(BoxStyler().minWidth(value));
  }

  RemixSelectContentStyler maxWidth(double value) {
    return container(BoxStyler().maxWidth(value));
  }

  RemixSelectContentStyler minHeight(double value) {
    return container(BoxStyler().minHeight(value));
  }

  RemixSelectContentStyler maxHeight(double value) {
    return container(BoxStyler().maxHeight(value));
  }

  RemixSelectContentStyler scale(
    double scale, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().scale(scale, alignment: alignment));
  }

  RemixSelectContentStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().rotate(radians, alignment: alignment));
  }

  RemixSelectContentStyler translate(double x, double y, [double z = 0.0]) {
    return container(BoxStyler().translate(x, y, z));
  }

  RemixSelectContentStyler skew(double skewX, double skewY) {
    return container(BoxStyler().skew(skewX, skewY));
  }

  RemixSelectContentStyler textStyle(TextStyler value) {
    return container(BoxStyler().textStyle(value));
  }

  RemixSelectContentStyler image(DecorationImageMix value) {
    return container(BoxStyler().image(value));
  }

  RemixSelectContentStyler shape(ShapeBorderMix value) {
    return container(BoxStyler().shape(value));
  }

  RemixSelectContentStyler backgroundImage(
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

  RemixSelectContentStyler backgroundImageUrl(
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

  RemixSelectContentStyler backgroundImageAsset(
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

  RemixSelectContentStyler linearGradient({
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

  RemixSelectContentStyler radialGradient({
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

  RemixSelectContentStyler sweepGradient({
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

  RemixSelectContentStyler foregroundLinearGradient({
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

  RemixSelectContentStyler foregroundRadialGradient({
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

  RemixSelectContentStyler foregroundSweepGradient({
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

  RemixSelectContentStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(BoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixSelectContentStyler container(BoxStyler value) {
    return merge(RemixSelectContentStyler(container: value));
  }

  /// Sets the surface.
  RemixSelectContentStyler surface(RemixSurfaceLayerMix value) {
    return merge(RemixSelectContentStyler(surface: value));
  }

  /// Sets the animation configuration.
  @override
  RemixSelectContentStyler animate(AnimationConfig value) {
    return merge(RemixSelectContentStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixSelectContentStyler variants(
    List<VariantStyle<RemixSelectContentSpec>> value,
  ) {
    return merge(RemixSelectContentStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixSelectContentStyler wrap(WidgetModifierConfig value) {
    return merge(RemixSelectContentStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixSelectContentStyler modifier(WidgetModifierConfig value) {
    return merge(RemixSelectContentStyler(modifier: value));
  }

  /// Merges with another [RemixSelectContentStyler].
  @override
  RemixSelectContentStyler merge(RemixSelectContentStyler? other) {
    return RemixSelectContentStyler.create(
      container: MixOps.merge($container, other?.$container),
      surface: MixOps.merge($surface, other?.$surface),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixSelectContentSpec>] using [context].
  @override
  StyleSpec<RemixSelectContentSpec> resolve(BuildContext context) {
    final spec = RemixSelectContentSpec(
      container: MixOps.resolve(context, $container),
      surface: MixOps.resolve(context, $surface),
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
      ..add(DiagnosticsProperty('surface', $surface));
  }

  @override
  List<Object?> get props => [
    $container,
    $surface,
    $animation,
    $modifier,
    $variants,
  ];
}

class RemixSelectMenuItemStyler
    extends MixStyler<RemixSelectMenuItemStyler, RemixSelectMenuItemSpec>
    with
        RemixBoxStylerMixin<RemixSelectMenuItemStyler>,
        IconStyleMixin<RemixSelectMenuItemStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $text;
  final Prop<StyleSpec<BoxSpec>>? $indicator;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const RemixSelectMenuItemStyler.create({
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

  RemixSelectMenuItemStyler({
    FlexBoxStyler? container,
    TextStyler? text,
    BoxStyler? indicator,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixSelectMenuItemSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         text: Prop.maybeMix(text),
         indicator: Prop.maybeMix(indicator),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixSelectMenuItemStyler.container(FlexBoxStyler value) =>
      RemixSelectMenuItemStyler().container(value);
  factory RemixSelectMenuItemStyler.text(TextStyler value) =>
      RemixSelectMenuItemStyler().text(value);
  factory RemixSelectMenuItemStyler.indicator(BoxStyler value) =>
      RemixSelectMenuItemStyler().indicator(value);
  factory RemixSelectMenuItemStyler.icon(IconStyler value) =>
      RemixSelectMenuItemStyler().icon(value);
  factory RemixSelectMenuItemStyler.color(Color value) =>
      RemixSelectMenuItemStyler().color(value);
  factory RemixSelectMenuItemStyler.gradient(GradientMix value) =>
      RemixSelectMenuItemStyler().gradient(value);
  factory RemixSelectMenuItemStyler.border(BoxBorderMix value) =>
      RemixSelectMenuItemStyler().border(value);
  factory RemixSelectMenuItemStyler.borderRadius(
    BorderRadiusGeometryMix value,
  ) => RemixSelectMenuItemStyler().borderRadius(value);
  factory RemixSelectMenuItemStyler.elevation(ElevationShadow value) =>
      RemixSelectMenuItemStyler().elevation(value);
  factory RemixSelectMenuItemStyler.shadow(BoxShadowMix value) =>
      RemixSelectMenuItemStyler().shadow(value);
  factory RemixSelectMenuItemStyler.shadows(List<BoxShadowMix> value) =>
      RemixSelectMenuItemStyler().shadows(value);
  factory RemixSelectMenuItemStyler.width(double value) =>
      RemixSelectMenuItemStyler().width(value);
  factory RemixSelectMenuItemStyler.height(double value) =>
      RemixSelectMenuItemStyler().height(value);
  factory RemixSelectMenuItemStyler.size(double width, double height) =>
      RemixSelectMenuItemStyler().size(width, height);
  factory RemixSelectMenuItemStyler.minWidth(double value) =>
      RemixSelectMenuItemStyler().minWidth(value);
  factory RemixSelectMenuItemStyler.maxWidth(double value) =>
      RemixSelectMenuItemStyler().maxWidth(value);
  factory RemixSelectMenuItemStyler.minHeight(double value) =>
      RemixSelectMenuItemStyler().minHeight(value);
  factory RemixSelectMenuItemStyler.maxHeight(double value) =>
      RemixSelectMenuItemStyler().maxHeight(value);
  factory RemixSelectMenuItemStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixSelectMenuItemStyler().scale(scale, alignment: alignment);
  factory RemixSelectMenuItemStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixSelectMenuItemStyler().rotate(radians, alignment: alignment);
  factory RemixSelectMenuItemStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => RemixSelectMenuItemStyler().translate(x, y, z);
  factory RemixSelectMenuItemStyler.skew(double skewX, double skewY) =>
      RemixSelectMenuItemStyler().skew(skewX, skewY);
  factory RemixSelectMenuItemStyler.textStyle(TextStyler value) =>
      RemixSelectMenuItemStyler().textStyle(value);
  factory RemixSelectMenuItemStyler.image(DecorationImageMix value) =>
      RemixSelectMenuItemStyler().image(value);
  factory RemixSelectMenuItemStyler.shape(ShapeBorderMix value) =>
      RemixSelectMenuItemStyler().shape(value);
  factory RemixSelectMenuItemStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectMenuItemStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectMenuItemStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectMenuItemStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectMenuItemStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectMenuItemStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectMenuItemStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSelectMenuItemStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSelectMenuItemStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSelectMenuItemStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSelectMenuItemStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSelectMenuItemStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSelectMenuItemStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSelectMenuItemStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSelectMenuItemStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSelectMenuItemStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSelectMenuItemStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSelectMenuItemStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSelectMenuItemStyler.row() => RemixSelectMenuItemStyler().row();
  factory RemixSelectMenuItemStyler.column() =>
      RemixSelectMenuItemStyler().column();
  factory RemixSelectMenuItemStyler.alignment(AlignmentGeometry value) =>
      RemixSelectMenuItemStyler().alignment(value);
  factory RemixSelectMenuItemStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixSelectMenuItemStyler().padding(value);
  factory RemixSelectMenuItemStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixSelectMenuItemStyler().margin(value);
  factory RemixSelectMenuItemStyler.constraints(BoxConstraintsMix value) =>
      RemixSelectMenuItemStyler().constraints(value);
  factory RemixSelectMenuItemStyler.decoration(DecorationMix value) =>
      RemixSelectMenuItemStyler().decoration(value);
  factory RemixSelectMenuItemStyler.foregroundDecoration(DecorationMix value) =>
      RemixSelectMenuItemStyler().foregroundDecoration(value);
  factory RemixSelectMenuItemStyler.clipBehavior(Clip value) =>
      RemixSelectMenuItemStyler().clipBehavior(value);
  factory RemixSelectMenuItemStyler.direction(Axis value) =>
      RemixSelectMenuItemStyler().direction(value);
  factory RemixSelectMenuItemStyler.mainAxisAlignment(
    MainAxisAlignment value,
  ) => RemixSelectMenuItemStyler().mainAxisAlignment(value);
  factory RemixSelectMenuItemStyler.crossAxisAlignment(
    CrossAxisAlignment value,
  ) => RemixSelectMenuItemStyler().crossAxisAlignment(value);
  factory RemixSelectMenuItemStyler.mainAxisSize(MainAxisSize value) =>
      RemixSelectMenuItemStyler().mainAxisSize(value);
  factory RemixSelectMenuItemStyler.spacing(double value) =>
      RemixSelectMenuItemStyler().spacing(value);
  factory RemixSelectMenuItemStyler.verticalDirection(
    VerticalDirection value,
  ) => RemixSelectMenuItemStyler().verticalDirection(value);
  factory RemixSelectMenuItemStyler.textDirection(TextDirection value) =>
      RemixSelectMenuItemStyler().textDirection(value);
  factory RemixSelectMenuItemStyler.textBaseline(TextBaseline value) =>
      RemixSelectMenuItemStyler().textBaseline(value);
  factory RemixSelectMenuItemStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixSelectMenuItemStyler().transform(value, alignment: alignment);

  RemixSelectMenuItemStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixSelectMenuItemStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixSelectMenuItemStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixSelectMenuItemStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixSelectMenuItemStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixSelectMenuItemStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixSelectMenuItemStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixSelectMenuItemStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixSelectMenuItemStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixSelectMenuItemStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixSelectMenuItemStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixSelectMenuItemStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixSelectMenuItemStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixSelectMenuItemStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixSelectMenuItemStyler scale(
    double scale, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixSelectMenuItemStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixSelectMenuItemStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixSelectMenuItemStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixSelectMenuItemStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixSelectMenuItemStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixSelectMenuItemStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixSelectMenuItemStyler backgroundImage(
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

  RemixSelectMenuItemStyler backgroundImageUrl(
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

  RemixSelectMenuItemStyler backgroundImageAsset(
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

  RemixSelectMenuItemStyler linearGradient({
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

  RemixSelectMenuItemStyler radialGradient({
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

  RemixSelectMenuItemStyler sweepGradient({
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

  RemixSelectMenuItemStyler foregroundLinearGradient({
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

  RemixSelectMenuItemStyler foregroundRadialGradient({
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

  RemixSelectMenuItemStyler foregroundSweepGradient({
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

  RemixSelectMenuItemStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixSelectMenuItemStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixSelectMenuItemStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixSelectMenuItemStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixSelectMenuItemStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixSelectMenuItemStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixSelectMenuItemStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixSelectMenuItemStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixSelectMenuItemStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixSelectMenuItemStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixSelectMenuItemStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixSelectMenuItemStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixSelectMenuItemStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixSelectMenuItemStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixSelectMenuItemStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixSelectMenuItemStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixSelectMenuItemStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixSelectMenuItemStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixSelectMenuItemStyler container(FlexBoxStyler value) {
    return merge(RemixSelectMenuItemStyler(container: value));
  }

  /// Sets the text.
  RemixSelectMenuItemStyler text(TextStyler value) {
    return merge(RemixSelectMenuItemStyler(text: value));
  }

  /// Sets the indicator.
  RemixSelectMenuItemStyler indicator(BoxStyler value) {
    return merge(RemixSelectMenuItemStyler(indicator: value));
  }

  /// Sets the icon.
  @override
  RemixSelectMenuItemStyler icon(IconStyler value) {
    return merge(RemixSelectMenuItemStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  RemixSelectMenuItemStyler animate(AnimationConfig value) {
    return merge(RemixSelectMenuItemStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixSelectMenuItemStyler variants(
    List<VariantStyle<RemixSelectMenuItemSpec>> value,
  ) {
    return merge(RemixSelectMenuItemStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixSelectMenuItemStyler wrap(WidgetModifierConfig value) {
    return merge(RemixSelectMenuItemStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixSelectMenuItemStyler modifier(WidgetModifierConfig value) {
    return merge(RemixSelectMenuItemStyler(modifier: value));
  }

  /// Merges with another [RemixSelectMenuItemStyler].
  @override
  RemixSelectMenuItemStyler merge(RemixSelectMenuItemStyler? other) {
    return RemixSelectMenuItemStyler.create(
      container: MixOps.merge($container, other?.$container),
      text: MixOps.merge($text, other?.$text),
      indicator: MixOps.merge($indicator, other?.$indicator),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixSelectMenuItemSpec>] using [context].
  @override
  StyleSpec<RemixSelectMenuItemSpec> resolve(BuildContext context) {
    final spec = RemixSelectMenuItemSpec(
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

class RemixSelectLabelStyler
    extends MixStyler<RemixSelectLabelStyler, RemixSelectLabelSpec>
    with RemixBoxStylerMixin<RemixSelectLabelStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $text;
  final Prop<double>? $adjacentItemSpacing;

  const RemixSelectLabelStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? text,
    Prop<double>? adjacentItemSpacing,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $text = text,
       $adjacentItemSpacing = adjacentItemSpacing;

  RemixSelectLabelStyler({
    FlexBoxStyler? container,
    TextStyler? text,
    double? adjacentItemSpacing,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<RemixSelectLabelSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         text: Prop.maybeMix(text),
         adjacentItemSpacing: Prop.maybe(adjacentItemSpacing),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory RemixSelectLabelStyler.container(FlexBoxStyler value) =>
      RemixSelectLabelStyler().container(value);
  factory RemixSelectLabelStyler.text(TextStyler value) =>
      RemixSelectLabelStyler().text(value);
  factory RemixSelectLabelStyler.adjacentItemSpacing(double value) =>
      RemixSelectLabelStyler().adjacentItemSpacing(value);
  factory RemixSelectLabelStyler.color(Color value) =>
      RemixSelectLabelStyler().color(value);
  factory RemixSelectLabelStyler.gradient(GradientMix value) =>
      RemixSelectLabelStyler().gradient(value);
  factory RemixSelectLabelStyler.border(BoxBorderMix value) =>
      RemixSelectLabelStyler().border(value);
  factory RemixSelectLabelStyler.borderRadius(BorderRadiusGeometryMix value) =>
      RemixSelectLabelStyler().borderRadius(value);
  factory RemixSelectLabelStyler.elevation(ElevationShadow value) =>
      RemixSelectLabelStyler().elevation(value);
  factory RemixSelectLabelStyler.shadow(BoxShadowMix value) =>
      RemixSelectLabelStyler().shadow(value);
  factory RemixSelectLabelStyler.shadows(List<BoxShadowMix> value) =>
      RemixSelectLabelStyler().shadows(value);
  factory RemixSelectLabelStyler.width(double value) =>
      RemixSelectLabelStyler().width(value);
  factory RemixSelectLabelStyler.height(double value) =>
      RemixSelectLabelStyler().height(value);
  factory RemixSelectLabelStyler.size(double width, double height) =>
      RemixSelectLabelStyler().size(width, height);
  factory RemixSelectLabelStyler.minWidth(double value) =>
      RemixSelectLabelStyler().minWidth(value);
  factory RemixSelectLabelStyler.maxWidth(double value) =>
      RemixSelectLabelStyler().maxWidth(value);
  factory RemixSelectLabelStyler.minHeight(double value) =>
      RemixSelectLabelStyler().minHeight(value);
  factory RemixSelectLabelStyler.maxHeight(double value) =>
      RemixSelectLabelStyler().maxHeight(value);
  factory RemixSelectLabelStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => RemixSelectLabelStyler().scale(scale, alignment: alignment);
  factory RemixSelectLabelStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => RemixSelectLabelStyler().rotate(radians, alignment: alignment);
  factory RemixSelectLabelStyler.translate(
    double x,
    double y, [
    double z = 0.0,
  ]) => RemixSelectLabelStyler().translate(x, y, z);
  factory RemixSelectLabelStyler.skew(double skewX, double skewY) =>
      RemixSelectLabelStyler().skew(skewX, skewY);
  factory RemixSelectLabelStyler.textStyle(TextStyler value) =>
      RemixSelectLabelStyler().textStyle(value);
  factory RemixSelectLabelStyler.image(DecorationImageMix value) =>
      RemixSelectLabelStyler().image(value);
  factory RemixSelectLabelStyler.shape(ShapeBorderMix value) =>
      RemixSelectLabelStyler().shape(value);
  factory RemixSelectLabelStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectLabelStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectLabelStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectLabelStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectLabelStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => RemixSelectLabelStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory RemixSelectLabelStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSelectLabelStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSelectLabelStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSelectLabelStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSelectLabelStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSelectLabelStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSelectLabelStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => RemixSelectLabelStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory RemixSelectLabelStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => RemixSelectLabelStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory RemixSelectLabelStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => RemixSelectLabelStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory RemixSelectLabelStyler.row() => RemixSelectLabelStyler().row();
  factory RemixSelectLabelStyler.column() => RemixSelectLabelStyler().column();
  factory RemixSelectLabelStyler.alignment(AlignmentGeometry value) =>
      RemixSelectLabelStyler().alignment(value);
  factory RemixSelectLabelStyler.padding(EdgeInsetsGeometryMix value) =>
      RemixSelectLabelStyler().padding(value);
  factory RemixSelectLabelStyler.margin(EdgeInsetsGeometryMix value) =>
      RemixSelectLabelStyler().margin(value);
  factory RemixSelectLabelStyler.constraints(BoxConstraintsMix value) =>
      RemixSelectLabelStyler().constraints(value);
  factory RemixSelectLabelStyler.decoration(DecorationMix value) =>
      RemixSelectLabelStyler().decoration(value);
  factory RemixSelectLabelStyler.foregroundDecoration(DecorationMix value) =>
      RemixSelectLabelStyler().foregroundDecoration(value);
  factory RemixSelectLabelStyler.clipBehavior(Clip value) =>
      RemixSelectLabelStyler().clipBehavior(value);
  factory RemixSelectLabelStyler.direction(Axis value) =>
      RemixSelectLabelStyler().direction(value);
  factory RemixSelectLabelStyler.mainAxisAlignment(MainAxisAlignment value) =>
      RemixSelectLabelStyler().mainAxisAlignment(value);
  factory RemixSelectLabelStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      RemixSelectLabelStyler().crossAxisAlignment(value);
  factory RemixSelectLabelStyler.mainAxisSize(MainAxisSize value) =>
      RemixSelectLabelStyler().mainAxisSize(value);
  factory RemixSelectLabelStyler.spacing(double value) =>
      RemixSelectLabelStyler().spacing(value);
  factory RemixSelectLabelStyler.verticalDirection(VerticalDirection value) =>
      RemixSelectLabelStyler().verticalDirection(value);
  factory RemixSelectLabelStyler.textDirection(TextDirection value) =>
      RemixSelectLabelStyler().textDirection(value);
  factory RemixSelectLabelStyler.textBaseline(TextBaseline value) =>
      RemixSelectLabelStyler().textBaseline(value);
  factory RemixSelectLabelStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => RemixSelectLabelStyler().transform(value, alignment: alignment);

  RemixSelectLabelStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  RemixSelectLabelStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  RemixSelectLabelStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  RemixSelectLabelStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  RemixSelectLabelStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  RemixSelectLabelStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  RemixSelectLabelStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  RemixSelectLabelStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  RemixSelectLabelStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  RemixSelectLabelStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  RemixSelectLabelStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  RemixSelectLabelStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  RemixSelectLabelStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  RemixSelectLabelStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  RemixSelectLabelStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  RemixSelectLabelStyler rotate(
    double radians, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  RemixSelectLabelStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  RemixSelectLabelStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  RemixSelectLabelStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  RemixSelectLabelStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  RemixSelectLabelStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  RemixSelectLabelStyler backgroundImage(
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

  RemixSelectLabelStyler backgroundImageUrl(
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

  RemixSelectLabelStyler backgroundImageAsset(
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

  RemixSelectLabelStyler linearGradient({
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

  RemixSelectLabelStyler radialGradient({
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

  RemixSelectLabelStyler sweepGradient({
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

  RemixSelectLabelStyler foregroundLinearGradient({
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

  RemixSelectLabelStyler foregroundRadialGradient({
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

  RemixSelectLabelStyler foregroundSweepGradient({
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

  RemixSelectLabelStyler row() {
    return container(FlexBoxStyler().row());
  }

  RemixSelectLabelStyler column() {
    return container(FlexBoxStyler().column());
  }

  RemixSelectLabelStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  RemixSelectLabelStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  RemixSelectLabelStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  RemixSelectLabelStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  RemixSelectLabelStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  RemixSelectLabelStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  RemixSelectLabelStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  RemixSelectLabelStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  RemixSelectLabelStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  RemixSelectLabelStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  RemixSelectLabelStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  RemixSelectLabelStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  RemixSelectLabelStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  RemixSelectLabelStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  RemixSelectLabelStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  RemixSelectLabelStyler transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  RemixSelectLabelStyler container(FlexBoxStyler value) {
    return merge(RemixSelectLabelStyler(container: value));
  }

  /// Sets the text.
  RemixSelectLabelStyler text(TextStyler value) {
    return merge(RemixSelectLabelStyler(text: value));
  }

  /// Sets the adjacentItemSpacing.
  RemixSelectLabelStyler adjacentItemSpacing(double value) {
    return merge(RemixSelectLabelStyler(adjacentItemSpacing: value));
  }

  /// Sets the animation configuration.
  @override
  RemixSelectLabelStyler animate(AnimationConfig value) {
    return merge(RemixSelectLabelStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  RemixSelectLabelStyler variants(
    List<VariantStyle<RemixSelectLabelSpec>> value,
  ) {
    return merge(RemixSelectLabelStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  RemixSelectLabelStyler wrap(WidgetModifierConfig value) {
    return merge(RemixSelectLabelStyler(modifier: value));
  }

  /// Sets the widget modifier.
  RemixSelectLabelStyler modifier(WidgetModifierConfig value) {
    return merge(RemixSelectLabelStyler(modifier: value));
  }

  /// Merges with another [RemixSelectLabelStyler].
  @override
  RemixSelectLabelStyler merge(RemixSelectLabelStyler? other) {
    return RemixSelectLabelStyler.create(
      container: MixOps.merge($container, other?.$container),
      text: MixOps.merge($text, other?.$text),
      adjacentItemSpacing: MixOps.merge(
        $adjacentItemSpacing,
        other?.$adjacentItemSpacing,
      ),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<RemixSelectLabelSpec>] using [context].
  @override
  StyleSpec<RemixSelectLabelSpec> resolve(BuildContext context) {
    final spec = RemixSelectLabelSpec(
      container: MixOps.resolve(context, $container),
      text: MixOps.resolve(context, $text),
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
      ..add(DiagnosticsProperty('text', $text))
      ..add(DiagnosticsProperty('adjacentItemSpacing', $adjacentItemSpacing));
  }

  @override
  List<Object?> get props => [
    $container,
    $text,
    $adjacentItemSpacing,
    $animation,
    $modifier,
    $variants,
  ];
}
