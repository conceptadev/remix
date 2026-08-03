// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$MenuTriggerSpec implements Spec<MenuTriggerSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get icon;

  @override
  Type get type => MenuTriggerSpec;

  @override
  MenuTriggerSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) {
    return MenuTriggerSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      icon: icon ?? this.icon,
    );
  }

  @override
  MenuTriggerSpec lerp(MenuTriggerSpec? other, double t) {
    return MenuTriggerSpec(
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
        other is MenuTriggerSpec &&
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
  'Rename to `_\$MenuTriggerSpec` and migrate the class declaration to `class MenuTriggerSpec with _\$MenuTriggerSpec`. The `_\$MenuTriggerSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$MenuTriggerSpecMethods = _$MenuTriggerSpec; // ignore: unused_element

mixin _$MenuSpec implements Spec<MenuSpec>, Diagnosticable {
  StyleSpec<MenuTriggerSpec> get trigger;
  StyleSpec<FlexBoxSpec> get overlay;
  RemixBoxEffectsSpec? get containerEffects;
  StyleSpec<MenuItemSpec> get item;
  StyleSpec<DividerSpec> get divider;

  @override
  Type get type => MenuSpec;

  @override
  MenuSpec copyWith({
    StyleSpec<MenuTriggerSpec>? trigger,
    StyleSpec<FlexBoxSpec>? overlay,
    RemixBoxEffectsSpec? containerEffects,
    StyleSpec<MenuItemSpec>? item,
    StyleSpec<DividerSpec>? divider,
  }) {
    return MenuSpec(
      trigger: trigger ?? this.trigger,
      overlay: overlay ?? this.overlay,
      containerEffects: containerEffects ?? this.containerEffects,
      item: item ?? this.item,
      divider: divider ?? this.divider,
    );
  }

  @override
  MenuSpec lerp(MenuSpec? other, double t) {
    return MenuSpec(
      trigger: trigger.lerp(other?.trigger, t),
      overlay: overlay.lerp(other?.overlay, t),
      containerEffects: MixOps.lerpSnap(
        containerEffects,
        other?.containerEffects,
        t,
      ),
      item: item.lerp(other?.item, t),
      divider: divider.lerp(other?.divider, t),
    );
  }

  @override
  List<Object?> get props => [
    trigger,
    overlay,
    containerEffects,
    item,
    divider,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MenuSpec &&
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
      ..add(DiagnosticsProperty('divider', divider));
  }
}

@Deprecated(
  'Rename to `_\$MenuSpec` and migrate the class declaration to `class MenuSpec with _\$MenuSpec`. The `_\$MenuSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$MenuSpecMethods = _$MenuSpec; // ignore: unused_element

mixin _$MenuItemSpec implements Spec<MenuItemSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<TextSpec> get label;
  StyleSpec<IconSpec> get leadingIcon;
  StyleSpec<IconSpec> get trailingIcon;

  @override
  Type get type => MenuItemSpec;

  @override
  MenuItemSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? leadingIcon,
    StyleSpec<IconSpec>? trailingIcon,
  }) {
    return MenuItemSpec(
      container: container ?? this.container,
      label: label ?? this.label,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
    );
  }

  @override
  MenuItemSpec lerp(MenuItemSpec? other, double t) {
    return MenuItemSpec(
      container: container.lerp(other?.container, t),
      label: label.lerp(other?.label, t),
      leadingIcon: leadingIcon.lerp(other?.leadingIcon, t),
      trailingIcon: trailingIcon.lerp(other?.trailingIcon, t),
    );
  }

  @override
  List<Object?> get props => [container, label, leadingIcon, trailingIcon];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MenuItemSpec &&
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
      ..add(DiagnosticsProperty('trailingIcon', trailingIcon));
  }
}

@Deprecated(
  'Rename to `_\$MenuItemSpec` and migrate the class declaration to `class MenuItemSpec with _\$MenuItemSpec`. The `_\$MenuItemSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$MenuItemSpecMethods = _$MenuItemSpec; // ignore: unused_element

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// Fortal menu content with Radix-owned size, variant, and contrast behavior.
class FortalMenu<T> extends StatelessWidget {
  const FortalMenu({
    super.key,
    this.variant = .solid,
    this.size = .size2,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.controller,
    this.onSelected,
    this.onOpen,
    this.onClose,
    this.onCanceled,
    this.onOpenRequested,
    this.onCloseRequested,
    this.consumeOutsideTaps = true,
    this.useRootOverlay = false,
    this.closeOnClickOutside = true,
    this.triggerFocusNode,
    this.positioning = const OverlayPositionConfig(),
  });

  const FortalMenu.solid({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.controller,
    this.onSelected,
    this.onOpen,
    this.onClose,
    this.onCanceled,
    this.onOpenRequested,
    this.onCloseRequested,
    this.consumeOutsideTaps = true,
    this.useRootOverlay = false,
    this.closeOnClickOutside = true,
    this.triggerFocusNode,
    this.positioning = const OverlayPositionConfig(),
  }) : variant = FortalMenuVariant.solid;

  const FortalMenu.soft({
    super.key,
    this.size = .size2,
    this.highContrast = false,
    required this.trigger,
    required this.items,
    this.controller,
    this.onSelected,
    this.onOpen,
    this.onClose,
    this.onCanceled,
    this.onOpenRequested,
    this.onCloseRequested,
    this.consumeOutsideTaps = true,
    this.useRootOverlay = false,
    this.closeOnClickOutside = true,
    this.triggerFocusNode,
    this.positioning = const OverlayPositionConfig(),
  }) : variant = FortalMenuVariant.soft;

  final FortalMenuVariant variant;

  final FortalMenuSize size;

  final bool highContrast;

  final RemixMenuTrigger trigger;

  final List<RemixMenuItemData<T>> items;

  final MenuController? controller;

  final ValueChanged<T>? onSelected;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;

  final VoidCallback? onCanceled;

  final RawMenuAnchorOpenRequestedCallback? onOpenRequested;

  final RawMenuAnchorCloseRequestedCallback? onCloseRequested;

  final bool consumeOutsideTaps;

  final bool useRootOverlay;

  final bool closeOnClickOutside;

  final FocusNode? triggerFocusNode;

  final OverlayPositionConfig positioning;

  @override
  Widget build(BuildContext context) {
    return RemixMenu<T>(
      key: this.key,
      style: fortalMenuStyle(
        variant: this.variant,
        size: this.size,
        highContrast: this.highContrast,
      ),
      trigger: this.trigger,
      items: this.items,
      controller: this.controller,
      onSelected: this.onSelected,
      onOpen: this.onOpen,
      onClose: this.onClose,
      onCanceled: this.onCanceled,
      onOpenRequested: this.onOpenRequested,
      onCloseRequested: this.onCloseRequested,
      consumeOutsideTaps: this.consumeOutsideTaps,
      useRootOverlay: this.useRootOverlay,
      closeOnClickOutside: this.closeOnClickOutside,
      triggerFocusNode: this.triggerFocusNode,
      positioning: this.positioning,
    );
  }
}

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class MenuTriggerStyler extends MixStyler<MenuTriggerStyler, MenuTriggerSpec>
    with
        RemixBoxStylerMixin<MenuTriggerStyler>,
        LabelStyleMixin<MenuTriggerStyler>,
        IconStyleMixin<MenuTriggerStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $icon;

  const MenuTriggerStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? icon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $icon = icon;

  MenuTriggerStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? icon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<MenuTriggerSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         icon: Prop.maybeMix(icon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory MenuTriggerStyler.container(FlexBoxStyler value) =>
      MenuTriggerStyler().container(value);
  factory MenuTriggerStyler.label(TextStyler value) =>
      MenuTriggerStyler().label(value);
  factory MenuTriggerStyler.icon(IconStyler value) =>
      MenuTriggerStyler().icon(value);
  factory MenuTriggerStyler.color(Color value) =>
      MenuTriggerStyler().color(value);
  factory MenuTriggerStyler.gradient(GradientMix value) =>
      MenuTriggerStyler().gradient(value);
  factory MenuTriggerStyler.border(BoxBorderMix value) =>
      MenuTriggerStyler().border(value);
  factory MenuTriggerStyler.borderRadius(BorderRadiusGeometryMix value) =>
      MenuTriggerStyler().borderRadius(value);
  factory MenuTriggerStyler.elevation(ElevationShadow value) =>
      MenuTriggerStyler().elevation(value);
  factory MenuTriggerStyler.shadow(BoxShadowMix value) =>
      MenuTriggerStyler().shadow(value);
  factory MenuTriggerStyler.shadows(List<BoxShadowMix> value) =>
      MenuTriggerStyler().shadows(value);
  factory MenuTriggerStyler.width(double value) =>
      MenuTriggerStyler().width(value);
  factory MenuTriggerStyler.height(double value) =>
      MenuTriggerStyler().height(value);
  factory MenuTriggerStyler.size(double width, double height) =>
      MenuTriggerStyler().size(width, height);
  factory MenuTriggerStyler.minWidth(double value) =>
      MenuTriggerStyler().minWidth(value);
  factory MenuTriggerStyler.maxWidth(double value) =>
      MenuTriggerStyler().maxWidth(value);
  factory MenuTriggerStyler.minHeight(double value) =>
      MenuTriggerStyler().minHeight(value);
  factory MenuTriggerStyler.maxHeight(double value) =>
      MenuTriggerStyler().maxHeight(value);
  factory MenuTriggerStyler.scale(
    double scale, {
    Alignment alignment = .center,
  }) => MenuTriggerStyler().scale(scale, alignment: alignment);
  factory MenuTriggerStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => MenuTriggerStyler().rotate(radians, alignment: alignment);
  factory MenuTriggerStyler.translate(double x, double y, [double z = 0.0]) =>
      MenuTriggerStyler().translate(x, y, z);
  factory MenuTriggerStyler.skew(double skewX, double skewY) =>
      MenuTriggerStyler().skew(skewX, skewY);
  factory MenuTriggerStyler.textStyle(TextStyler value) =>
      MenuTriggerStyler().textStyle(value);
  factory MenuTriggerStyler.image(DecorationImageMix value) =>
      MenuTriggerStyler().image(value);
  factory MenuTriggerStyler.shape(ShapeBorderMix value) =>
      MenuTriggerStyler().shape(value);
  factory MenuTriggerStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => MenuTriggerStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory MenuTriggerStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => MenuTriggerStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory MenuTriggerStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => MenuTriggerStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory MenuTriggerStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => MenuTriggerStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory MenuTriggerStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => MenuTriggerStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory MenuTriggerStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => MenuTriggerStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory MenuTriggerStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => MenuTriggerStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory MenuTriggerStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => MenuTriggerStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory MenuTriggerStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => MenuTriggerStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory MenuTriggerStyler.row() => MenuTriggerStyler().row();
  factory MenuTriggerStyler.column() => MenuTriggerStyler().column();
  factory MenuTriggerStyler.alignment(AlignmentGeometry value) =>
      MenuTriggerStyler().alignment(value);
  factory MenuTriggerStyler.padding(EdgeInsetsGeometryMix value) =>
      MenuTriggerStyler().padding(value);
  factory MenuTriggerStyler.margin(EdgeInsetsGeometryMix value) =>
      MenuTriggerStyler().margin(value);
  factory MenuTriggerStyler.constraints(BoxConstraintsMix value) =>
      MenuTriggerStyler().constraints(value);
  factory MenuTriggerStyler.decoration(DecorationMix value) =>
      MenuTriggerStyler().decoration(value);
  factory MenuTriggerStyler.foregroundDecoration(DecorationMix value) =>
      MenuTriggerStyler().foregroundDecoration(value);
  factory MenuTriggerStyler.clipBehavior(Clip value) =>
      MenuTriggerStyler().clipBehavior(value);
  factory MenuTriggerStyler.direction(Axis value) =>
      MenuTriggerStyler().direction(value);
  factory MenuTriggerStyler.mainAxisAlignment(MainAxisAlignment value) =>
      MenuTriggerStyler().mainAxisAlignment(value);
  factory MenuTriggerStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      MenuTriggerStyler().crossAxisAlignment(value);
  factory MenuTriggerStyler.mainAxisSize(MainAxisSize value) =>
      MenuTriggerStyler().mainAxisSize(value);
  factory MenuTriggerStyler.spacing(double value) =>
      MenuTriggerStyler().spacing(value);
  factory MenuTriggerStyler.verticalDirection(VerticalDirection value) =>
      MenuTriggerStyler().verticalDirection(value);
  factory MenuTriggerStyler.textDirection(TextDirection value) =>
      MenuTriggerStyler().textDirection(value);
  factory MenuTriggerStyler.textBaseline(TextBaseline value) =>
      MenuTriggerStyler().textBaseline(value);
  factory MenuTriggerStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => MenuTriggerStyler().transform(value, alignment: alignment);

  MenuTriggerStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  MenuTriggerStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  MenuTriggerStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  MenuTriggerStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  MenuTriggerStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  MenuTriggerStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  MenuTriggerStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  MenuTriggerStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  MenuTriggerStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  MenuTriggerStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  MenuTriggerStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  MenuTriggerStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  MenuTriggerStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  MenuTriggerStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  MenuTriggerStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  MenuTriggerStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  MenuTriggerStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  MenuTriggerStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  MenuTriggerStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  MenuTriggerStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  MenuTriggerStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  MenuTriggerStyler backgroundImage(
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

  MenuTriggerStyler backgroundImageUrl(
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

  MenuTriggerStyler backgroundImageAsset(
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

  MenuTriggerStyler linearGradient({
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

  MenuTriggerStyler radialGradient({
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

  MenuTriggerStyler sweepGradient({
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

  MenuTriggerStyler foregroundLinearGradient({
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

  MenuTriggerStyler foregroundRadialGradient({
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

  MenuTriggerStyler foregroundSweepGradient({
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

  MenuTriggerStyler row() {
    return container(FlexBoxStyler().row());
  }

  MenuTriggerStyler column() {
    return container(FlexBoxStyler().column());
  }

  MenuTriggerStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  MenuTriggerStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  MenuTriggerStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  MenuTriggerStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  MenuTriggerStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  MenuTriggerStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  MenuTriggerStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  MenuTriggerStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  MenuTriggerStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  MenuTriggerStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  MenuTriggerStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  MenuTriggerStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  MenuTriggerStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  MenuTriggerStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  MenuTriggerStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  MenuTriggerStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  MenuTriggerStyler container(FlexBoxStyler value) {
    return merge(MenuTriggerStyler(container: value));
  }

  /// Sets the label.
  @override
  MenuTriggerStyler label(TextStyler value) {
    return merge(MenuTriggerStyler(label: value));
  }

  /// Sets the icon.
  @override
  MenuTriggerStyler icon(IconStyler value) {
    return merge(MenuTriggerStyler(icon: value));
  }

  /// Sets the animation configuration.
  @override
  MenuTriggerStyler animate(AnimationConfig value) {
    return merge(MenuTriggerStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  MenuTriggerStyler variants(List<VariantStyle<MenuTriggerSpec>> value) {
    return merge(MenuTriggerStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  MenuTriggerStyler wrap(WidgetModifierConfig value) {
    return merge(MenuTriggerStyler(modifier: value));
  }

  /// Sets the widget modifier.
  MenuTriggerStyler modifier(WidgetModifierConfig value) {
    return merge(MenuTriggerStyler(modifier: value));
  }

  /// Merges with another [MenuTriggerStyler].
  @override
  MenuTriggerStyler merge(MenuTriggerStyler? other) {
    return MenuTriggerStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      icon: MixOps.merge($icon, other?.$icon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<MenuTriggerSpec>] using [context].
  @override
  StyleSpec<MenuTriggerSpec> resolve(BuildContext context) {
    final spec = MenuTriggerSpec(
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

class MenuStyler extends MixStyler<MenuStyler, MenuSpec> {
  final Prop<StyleSpec<MenuTriggerSpec>>? $trigger;
  final Prop<StyleSpec<FlexBoxSpec>>? $overlay;
  final Prop<RemixBoxEffectsSpec>? $containerEffects;
  final Prop<StyleSpec<MenuItemSpec>>? $item;
  final Prop<StyleSpec<DividerSpec>>? $divider;

  const MenuStyler.create({
    Prop<StyleSpec<MenuTriggerSpec>>? trigger,
    Prop<StyleSpec<FlexBoxSpec>>? overlay,
    Prop<RemixBoxEffectsSpec>? containerEffects,
    Prop<StyleSpec<MenuItemSpec>>? item,
    Prop<StyleSpec<DividerSpec>>? divider,
    super.variants,
    super.modifier,
    super.animation,
  }) : $trigger = trigger,
       $overlay = overlay,
       $containerEffects = containerEffects,
       $item = item,
       $divider = divider;

  MenuStyler({
    MenuTriggerStyler? trigger,
    FlexBoxStyler? overlay,
    RemixBoxEffectsMix? containerEffects,
    MenuItemStyler? item,
    DividerStyler? divider,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<MenuSpec>>? variants,
  }) : this.create(
         trigger: Prop.maybeMix(trigger),
         overlay: Prop.maybeMix(overlay),
         containerEffects: Prop.maybeMix(containerEffects),
         item: Prop.maybeMix(item),
         divider: Prop.maybeMix(divider),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory MenuStyler.trigger(MenuTriggerStyler value) =>
      MenuStyler().trigger(value);
  factory MenuStyler.overlay(FlexBoxStyler value) =>
      MenuStyler().overlay(value);
  factory MenuStyler.containerEffects(RemixBoxEffectsMix value) =>
      MenuStyler().containerEffects(value);
  factory MenuStyler.item(MenuItemStyler value) => MenuStyler().item(value);
  factory MenuStyler.divider(DividerStyler value) =>
      MenuStyler().divider(value);

  /// Sets the trigger.
  MenuStyler trigger(MenuTriggerStyler value) {
    return merge(MenuStyler(trigger: value));
  }

  /// Sets the overlay.
  MenuStyler overlay(FlexBoxStyler value) {
    return merge(MenuStyler(overlay: value));
  }

  /// Sets the containerEffects.
  MenuStyler containerEffects(RemixBoxEffectsMix value) {
    return merge(MenuStyler(containerEffects: value));
  }

  /// Sets the item.
  MenuStyler item(MenuItemStyler value) {
    return merge(MenuStyler(item: value));
  }

  /// Sets the divider.
  MenuStyler divider(DividerStyler value) {
    return merge(MenuStyler(divider: value));
  }

  /// Sets the animation configuration.
  @override
  MenuStyler animate(AnimationConfig value) {
    return merge(MenuStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  MenuStyler variants(List<VariantStyle<MenuSpec>> value) {
    return merge(MenuStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  MenuStyler wrap(WidgetModifierConfig value) {
    return merge(MenuStyler(modifier: value));
  }

  /// Sets the widget modifier.
  MenuStyler modifier(WidgetModifierConfig value) {
    return merge(MenuStyler(modifier: value));
  }

  /// Merges with another [MenuStyler].
  @override
  MenuStyler merge(MenuStyler? other) {
    return MenuStyler.create(
      trigger: MixOps.merge($trigger, other?.$trigger),
      overlay: MixOps.merge($overlay, other?.$overlay),
      containerEffects: MixOps.merge(
        $containerEffects,
        other?.$containerEffects,
      ),
      item: MixOps.merge($item, other?.$item),
      divider: MixOps.merge($divider, other?.$divider),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<MenuSpec>] using [context].
  @override
  StyleSpec<MenuSpec> resolve(BuildContext context) {
    final spec = MenuSpec(
      trigger: MixOps.resolve(context, $trigger),
      overlay: MixOps.resolve(context, $overlay),
      containerEffects: MixOps.resolve(context, $containerEffects),
      item: MixOps.resolve(context, $item),
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
      ..add(DiagnosticsProperty('divider', $divider));
  }

  @override
  List<Object?> get props => [
    $trigger,
    $overlay,
    $containerEffects,
    $item,
    $divider,
    $animation,
    $modifier,
    $variants,
  ];
}

class MenuItemStyler extends MixStyler<MenuItemStyler, MenuItemSpec>
    with RemixBoxStylerMixin<MenuItemStyler> {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<TextSpec>>? $label;
  final Prop<StyleSpec<IconSpec>>? $leadingIcon;
  final Prop<StyleSpec<IconSpec>>? $trailingIcon;

  const MenuItemStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<TextSpec>>? label,
    Prop<StyleSpec<IconSpec>>? leadingIcon,
    Prop<StyleSpec<IconSpec>>? trailingIcon,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $label = label,
       $leadingIcon = leadingIcon,
       $trailingIcon = trailingIcon;

  MenuItemStyler({
    FlexBoxStyler? container,
    TextStyler? label,
    IconStyler? leadingIcon,
    IconStyler? trailingIcon,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<MenuItemSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         label: Prop.maybeMix(label),
         leadingIcon: Prop.maybeMix(leadingIcon),
         trailingIcon: Prop.maybeMix(trailingIcon),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory MenuItemStyler.container(FlexBoxStyler value) =>
      MenuItemStyler().container(value);
  factory MenuItemStyler.label(TextStyler value) =>
      MenuItemStyler().label(value);
  factory MenuItemStyler.leadingIcon(IconStyler value) =>
      MenuItemStyler().leadingIcon(value);
  factory MenuItemStyler.trailingIcon(IconStyler value) =>
      MenuItemStyler().trailingIcon(value);
  factory MenuItemStyler.color(Color value) => MenuItemStyler().color(value);
  factory MenuItemStyler.gradient(GradientMix value) =>
      MenuItemStyler().gradient(value);
  factory MenuItemStyler.border(BoxBorderMix value) =>
      MenuItemStyler().border(value);
  factory MenuItemStyler.borderRadius(BorderRadiusGeometryMix value) =>
      MenuItemStyler().borderRadius(value);
  factory MenuItemStyler.elevation(ElevationShadow value) =>
      MenuItemStyler().elevation(value);
  factory MenuItemStyler.shadow(BoxShadowMix value) =>
      MenuItemStyler().shadow(value);
  factory MenuItemStyler.shadows(List<BoxShadowMix> value) =>
      MenuItemStyler().shadows(value);
  factory MenuItemStyler.width(double value) => MenuItemStyler().width(value);
  factory MenuItemStyler.height(double value) => MenuItemStyler().height(value);
  factory MenuItemStyler.size(double width, double height) =>
      MenuItemStyler().size(width, height);
  factory MenuItemStyler.minWidth(double value) =>
      MenuItemStyler().minWidth(value);
  factory MenuItemStyler.maxWidth(double value) =>
      MenuItemStyler().maxWidth(value);
  factory MenuItemStyler.minHeight(double value) =>
      MenuItemStyler().minHeight(value);
  factory MenuItemStyler.maxHeight(double value) =>
      MenuItemStyler().maxHeight(value);
  factory MenuItemStyler.scale(double scale, {Alignment alignment = .center}) =>
      MenuItemStyler().scale(scale, alignment: alignment);
  factory MenuItemStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => MenuItemStyler().rotate(radians, alignment: alignment);
  factory MenuItemStyler.translate(double x, double y, [double z = 0.0]) =>
      MenuItemStyler().translate(x, y, z);
  factory MenuItemStyler.skew(double skewX, double skewY) =>
      MenuItemStyler().skew(skewX, skewY);
  factory MenuItemStyler.textStyle(TextStyler value) =>
      MenuItemStyler().textStyle(value);
  factory MenuItemStyler.image(DecorationImageMix value) =>
      MenuItemStyler().image(value);
  factory MenuItemStyler.shape(ShapeBorderMix value) =>
      MenuItemStyler().shape(value);
  factory MenuItemStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => MenuItemStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory MenuItemStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => MenuItemStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory MenuItemStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => MenuItemStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory MenuItemStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => MenuItemStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory MenuItemStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => MenuItemStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory MenuItemStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => MenuItemStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory MenuItemStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => MenuItemStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory MenuItemStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => MenuItemStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory MenuItemStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => MenuItemStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory MenuItemStyler.row() => MenuItemStyler().row();
  factory MenuItemStyler.column() => MenuItemStyler().column();
  factory MenuItemStyler.alignment(AlignmentGeometry value) =>
      MenuItemStyler().alignment(value);
  factory MenuItemStyler.padding(EdgeInsetsGeometryMix value) =>
      MenuItemStyler().padding(value);
  factory MenuItemStyler.margin(EdgeInsetsGeometryMix value) =>
      MenuItemStyler().margin(value);
  factory MenuItemStyler.constraints(BoxConstraintsMix value) =>
      MenuItemStyler().constraints(value);
  factory MenuItemStyler.decoration(DecorationMix value) =>
      MenuItemStyler().decoration(value);
  factory MenuItemStyler.foregroundDecoration(DecorationMix value) =>
      MenuItemStyler().foregroundDecoration(value);
  factory MenuItemStyler.clipBehavior(Clip value) =>
      MenuItemStyler().clipBehavior(value);
  factory MenuItemStyler.direction(Axis value) =>
      MenuItemStyler().direction(value);
  factory MenuItemStyler.mainAxisAlignment(MainAxisAlignment value) =>
      MenuItemStyler().mainAxisAlignment(value);
  factory MenuItemStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      MenuItemStyler().crossAxisAlignment(value);
  factory MenuItemStyler.mainAxisSize(MainAxisSize value) =>
      MenuItemStyler().mainAxisSize(value);
  factory MenuItemStyler.spacing(double value) =>
      MenuItemStyler().spacing(value);
  factory MenuItemStyler.verticalDirection(VerticalDirection value) =>
      MenuItemStyler().verticalDirection(value);
  factory MenuItemStyler.textDirection(TextDirection value) =>
      MenuItemStyler().textDirection(value);
  factory MenuItemStyler.textBaseline(TextBaseline value) =>
      MenuItemStyler().textBaseline(value);
  factory MenuItemStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => MenuItemStyler().transform(value, alignment: alignment);

  MenuItemStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  MenuItemStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  MenuItemStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  MenuItemStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  MenuItemStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  MenuItemStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  MenuItemStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  MenuItemStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  MenuItemStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  MenuItemStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  MenuItemStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  MenuItemStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  MenuItemStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  MenuItemStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  MenuItemStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  MenuItemStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  MenuItemStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  MenuItemStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  MenuItemStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  MenuItemStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  MenuItemStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  MenuItemStyler backgroundImage(
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

  MenuItemStyler backgroundImageUrl(
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

  MenuItemStyler backgroundImageAsset(
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

  MenuItemStyler linearGradient({
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

  MenuItemStyler radialGradient({
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

  MenuItemStyler sweepGradient({
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

  MenuItemStyler foregroundLinearGradient({
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

  MenuItemStyler foregroundRadialGradient({
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

  MenuItemStyler foregroundSweepGradient({
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

  MenuItemStyler row() {
    return container(FlexBoxStyler().row());
  }

  MenuItemStyler column() {
    return container(FlexBoxStyler().column());
  }

  MenuItemStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  MenuItemStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  MenuItemStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  MenuItemStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  MenuItemStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  MenuItemStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  MenuItemStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  MenuItemStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  MenuItemStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  MenuItemStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  MenuItemStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  MenuItemStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  MenuItemStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  MenuItemStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  MenuItemStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  MenuItemStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  /// Sets the container.
  MenuItemStyler container(FlexBoxStyler value) {
    return merge(MenuItemStyler(container: value));
  }

  /// Sets the label.
  MenuItemStyler label(TextStyler value) {
    return merge(MenuItemStyler(label: value));
  }

  /// Sets the leadingIcon.
  MenuItemStyler leadingIcon(IconStyler value) {
    return merge(MenuItemStyler(leadingIcon: value));
  }

  /// Sets the trailingIcon.
  MenuItemStyler trailingIcon(IconStyler value) {
    return merge(MenuItemStyler(trailingIcon: value));
  }

  /// Sets the animation configuration.
  @override
  MenuItemStyler animate(AnimationConfig value) {
    return merge(MenuItemStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  MenuItemStyler variants(List<VariantStyle<MenuItemSpec>> value) {
    return merge(MenuItemStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  MenuItemStyler wrap(WidgetModifierConfig value) {
    return merge(MenuItemStyler(modifier: value));
  }

  /// Sets the widget modifier.
  MenuItemStyler modifier(WidgetModifierConfig value) {
    return merge(MenuItemStyler(modifier: value));
  }

  /// Merges with another [MenuItemStyler].
  @override
  MenuItemStyler merge(MenuItemStyler? other) {
    return MenuItemStyler.create(
      container: MixOps.merge($container, other?.$container),
      label: MixOps.merge($label, other?.$label),
      leadingIcon: MixOps.merge($leadingIcon, other?.$leadingIcon),
      trailingIcon: MixOps.merge($trailingIcon, other?.$trailingIcon),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<MenuItemSpec>] using [context].
  @override
  StyleSpec<MenuItemSpec> resolve(BuildContext context) {
    final spec = MenuItemSpec(
      container: MixOps.resolve(context, $container),
      label: MixOps.resolve(context, $label),
      leadingIcon: MixOps.resolve(context, $leadingIcon),
      trailingIcon: MixOps.resolve(context, $trailingIcon),
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
      ..add(DiagnosticsProperty('trailingIcon', $trailingIcon));
  }

  @override
  List<Object?> get props => [
    $container,
    $label,
    $leadingIcon,
    $trailingIcon,
    $animation,
    $modifier,
    $variants,
  ];
}
