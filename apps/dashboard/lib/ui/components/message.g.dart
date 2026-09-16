// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$UiMessageSpec implements Spec<UiMessageSpec>, Diagnosticable {
  double? get maxWidth;
  StyleSpec<FlexBoxSpec> get row;
  StyleSpec<BoxSpec> get avatar;
  StyleSpec<BoxSpec> get header;
  StyleSpec<BoxSpec> get body;
  StyleSpec<BoxSpec> get footer;

  @override
  Type get type => UiMessageSpec;

  @override
  UiMessageSpec copyWith({
    double? maxWidth,
    StyleSpec<FlexBoxSpec>? row,
    StyleSpec<BoxSpec>? avatar,
    StyleSpec<BoxSpec>? header,
    StyleSpec<BoxSpec>? body,
    StyleSpec<BoxSpec>? footer,
  }) {
    return UiMessageSpec(
      maxWidth: maxWidth ?? this.maxWidth,
      row: row ?? this.row,
      avatar: avatar ?? this.avatar,
      header: header ?? this.header,
      body: body ?? this.body,
      footer: footer ?? this.footer,
    );
  }

  @override
  UiMessageSpec lerp(UiMessageSpec? other, double t) {
    return UiMessageSpec(
      maxWidth: MixOps.lerp(maxWidth, other?.maxWidth, t),
      row: row.lerp(other?.row, t),
      avatar: avatar.lerp(other?.avatar, t),
      header: header.lerp(other?.header, t),
      body: body.lerp(other?.body, t),
      footer: footer.lerp(other?.footer, t),
    );
  }

  @override
  List<Object?> get props => [maxWidth, row, avatar, header, body, footer];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UiMessageSpec &&
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
      ..add(DoubleProperty('maxWidth', maxWidth))
      ..add(DiagnosticsProperty('row', row))
      ..add(DiagnosticsProperty('avatar', avatar))
      ..add(DiagnosticsProperty('header', header))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('footer', footer));
  }
}

@Deprecated(
  'Rename to `_\$UiMessageSpec` and migrate the class declaration to `class UiMessageSpec with _\$UiMessageSpec`. The `_\$UiMessageSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$UiMessageSpecMethods = _$UiMessageSpec; // ignore: unused_element

mixin _$UiMessageCollapsibleSpec
    implements Spec<UiMessageCollapsibleSpec>, Diagnosticable {
  double? get collapsedHeight;
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get clipped;

  @override
  Type get type => UiMessageCollapsibleSpec;

  @override
  UiMessageCollapsibleSpec copyWith({
    double? collapsedHeight,
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? clipped,
  }) {
    return UiMessageCollapsibleSpec(
      collapsedHeight: collapsedHeight ?? this.collapsedHeight,
      container: container ?? this.container,
      clipped: clipped ?? this.clipped,
    );
  }

  @override
  UiMessageCollapsibleSpec lerp(UiMessageCollapsibleSpec? other, double t) {
    return UiMessageCollapsibleSpec(
      collapsedHeight: MixOps.lerp(collapsedHeight, other?.collapsedHeight, t),
      container: container.lerp(other?.container, t),
      clipped: clipped.lerp(other?.clipped, t),
    );
  }

  @override
  List<Object?> get props => [collapsedHeight, container, clipped];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UiMessageCollapsibleSpec &&
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
      ..add(DoubleProperty('collapsedHeight', collapsedHeight))
      ..add(DiagnosticsProperty('container', container))
      ..add(DiagnosticsProperty('clipped', clipped));
  }
}

@Deprecated(
  'Rename to `_\$UiMessageCollapsibleSpec` and migrate the class declaration to `class UiMessageCollapsibleSpec with _\$UiMessageCollapsibleSpec`. The `_\$UiMessageCollapsibleSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$UiMessageCollapsibleSpecMethods = _$UiMessageCollapsibleSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class UiMessageStyler extends MixStyler<UiMessageStyler, UiMessageSpec>
    implements StylerFieldMetadata {
  final Prop<double>? $maxWidth;
  final Prop<StyleSpec<FlexBoxSpec>>? $row;
  final Prop<StyleSpec<BoxSpec>>? $avatar;
  final Prop<StyleSpec<BoxSpec>>? $header;
  final Prop<StyleSpec<BoxSpec>>? $body;
  final Prop<StyleSpec<BoxSpec>>? $footer;

  const UiMessageStyler.create({
    Prop<double>? maxWidth,
    Prop<StyleSpec<FlexBoxSpec>>? row,
    Prop<StyleSpec<BoxSpec>>? avatar,
    Prop<StyleSpec<BoxSpec>>? header,
    Prop<StyleSpec<BoxSpec>>? body,
    Prop<StyleSpec<BoxSpec>>? footer,
    super.variants,
    super.modifier,
    super.animation,
  }) : $maxWidth = maxWidth,
       $row = row,
       $avatar = avatar,
       $header = header,
       $body = body,
       $footer = footer;

  UiMessageStyler({
    double? maxWidth,
    FlexBoxStyler? row,
    BoxStyler? avatar,
    BoxStyler? header,
    BoxStyler? body,
    BoxStyler? footer,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<UiMessageSpec>>? variants,
  }) : this.create(
         maxWidth: Prop.maybe(maxWidth),
         row: Prop.maybeMix(row),
         avatar: Prop.maybeMix(avatar),
         header: Prop.maybeMix(header),
         body: Prop.maybeMix(body),
         footer: Prop.maybeMix(footer),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory UiMessageStyler.maxWidth(double value) =>
      UiMessageStyler().maxWidth(value);
  factory UiMessageStyler.row(FlexBoxStyler value) =>
      UiMessageStyler().row(value);
  factory UiMessageStyler.avatar(BoxStyler value) =>
      UiMessageStyler().avatar(value);
  factory UiMessageStyler.header(BoxStyler value) =>
      UiMessageStyler().header(value);
  factory UiMessageStyler.body(BoxStyler value) =>
      UiMessageStyler().body(value);
  factory UiMessageStyler.footer(BoxStyler value) =>
      UiMessageStyler().footer(value);

  @override
  Set<String> get $stylerFieldNames => const {
    'maxWidth',
    'row',
    'avatar',
    'header',
    'body',
    'footer',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the maxWidth.
  UiMessageStyler maxWidth(double value) {
    return merge(UiMessageStyler(maxWidth: value));
  }

  /// Sets the row.
  UiMessageStyler row(FlexBoxStyler value) {
    return merge(UiMessageStyler(row: value));
  }

  /// Sets the avatar.
  UiMessageStyler avatar(BoxStyler value) {
    return merge(UiMessageStyler(avatar: value));
  }

  /// Sets the header.
  UiMessageStyler header(BoxStyler value) {
    return merge(UiMessageStyler(header: value));
  }

  /// Sets the body.
  UiMessageStyler body(BoxStyler value) {
    return merge(UiMessageStyler(body: value));
  }

  /// Sets the footer.
  UiMessageStyler footer(BoxStyler value) {
    return merge(UiMessageStyler(footer: value));
  }

  /// Sets the animation configuration.
  @override
  UiMessageStyler animate(AnimationConfig value) {
    return merge(UiMessageStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  UiMessageStyler variants(List<VariantStyle<UiMessageSpec>> value) {
    return merge(UiMessageStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  UiMessageStyler wrap(WidgetModifierConfig value) {
    return merge(UiMessageStyler(modifier: value));
  }

  /// Sets the widget modifier.
  UiMessageStyler modifier(WidgetModifierConfig value) {
    return merge(UiMessageStyler(modifier: value));
  }

  UiMessage call({
    Key? key,
    required UiRole role,
    required Widget child,
    UiMessageAlign? align,
    Widget? avatar,
    bool showAvatar = false,
    bool placeholderAvatar = false,
    double? maxWidth,
    Widget? header,
    Widget? footer,
    String? semanticLabel,
    CardStyler surfaceStyle = const CardStyler.create(),
  }) {
    return UiMessage(
      key: key,
      style: this,
      role: role,
      child: child,
      align: align,
      avatar: avatar,
      showAvatar: showAvatar,
      placeholderAvatar: placeholderAvatar,
      maxWidth: maxWidth,
      header: header,
      footer: footer,
      semanticLabel: semanticLabel,
      surfaceStyle: surfaceStyle,
    );
  }

  /// Merges with another [UiMessageStyler].
  @override
  UiMessageStyler merge(UiMessageStyler? other) {
    return UiMessageStyler.create(
      maxWidth: MixOps.merge($maxWidth, other?.$maxWidth),
      row: MixOps.merge($row, other?.$row),
      avatar: MixOps.merge($avatar, other?.$avatar),
      header: MixOps.merge($header, other?.$header),
      body: MixOps.merge($body, other?.$body),
      footer: MixOps.merge($footer, other?.$footer),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<UiMessageSpec>] using [context].
  @override
  StyleSpec<UiMessageSpec> resolve(BuildContext context) {
    final spec = UiMessageSpec(
      maxWidth: MixOps.resolve(context, $maxWidth),
      row: MixOps.resolve(context, $row),
      avatar: MixOps.resolve(context, $avatar),
      header: MixOps.resolve(context, $header),
      body: MixOps.resolve(context, $body),
      footer: MixOps.resolve(context, $footer),
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
      ..add(DiagnosticsProperty('maxWidth', $maxWidth))
      ..add(DiagnosticsProperty('row', $row))
      ..add(DiagnosticsProperty('avatar', $avatar))
      ..add(DiagnosticsProperty('header', $header))
      ..add(DiagnosticsProperty('body', $body))
      ..add(DiagnosticsProperty('footer', $footer));
  }

  @override
  List<Object?> get props => [
    $maxWidth,
    $row,
    $avatar,
    $header,
    $body,
    $footer,
    $animation,
    $modifier,
    $variants,
  ];
}

class UiMessageCollapsibleStyler
    extends MixStyler<UiMessageCollapsibleStyler, UiMessageCollapsibleSpec>
    implements StylerFieldMetadata {
  final Prop<double>? $collapsedHeight;
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $clipped;

  const UiMessageCollapsibleStyler.create({
    Prop<double>? collapsedHeight,
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? clipped,
    super.variants,
    super.modifier,
    super.animation,
  }) : $collapsedHeight = collapsedHeight,
       $container = container,
       $clipped = clipped;

  UiMessageCollapsibleStyler({
    double? collapsedHeight,
    BoxStyler? container,
    BoxStyler? clipped,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<UiMessageCollapsibleSpec>>? variants,
  }) : this.create(
         collapsedHeight: Prop.maybe(collapsedHeight),
         container: Prop.maybeMix(container),
         clipped: Prop.maybeMix(clipped),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory UiMessageCollapsibleStyler.collapsedHeight(double value) =>
      UiMessageCollapsibleStyler().collapsedHeight(value);
  factory UiMessageCollapsibleStyler.container(BoxStyler value) =>
      UiMessageCollapsibleStyler().container(value);
  factory UiMessageCollapsibleStyler.clipped(BoxStyler value) =>
      UiMessageCollapsibleStyler().clipped(value);

  @override
  Set<String> get $stylerFieldNames => const {
    'collapsedHeight',
    'container',
    'clipped',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the collapsedHeight.
  UiMessageCollapsibleStyler collapsedHeight(double value) {
    return merge(UiMessageCollapsibleStyler(collapsedHeight: value));
  }

  /// Sets the container.
  UiMessageCollapsibleStyler container(BoxStyler value) {
    return merge(UiMessageCollapsibleStyler(container: value));
  }

  /// Sets the clipped.
  UiMessageCollapsibleStyler clipped(BoxStyler value) {
    return merge(UiMessageCollapsibleStyler(clipped: value));
  }

  /// Sets the animation configuration.
  @override
  UiMessageCollapsibleStyler animate(AnimationConfig value) {
    return merge(UiMessageCollapsibleStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  UiMessageCollapsibleStyler variants(
    List<VariantStyle<UiMessageCollapsibleSpec>> value,
  ) {
    return merge(UiMessageCollapsibleStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  UiMessageCollapsibleStyler wrap(WidgetModifierConfig value) {
    return merge(UiMessageCollapsibleStyler(modifier: value));
  }

  /// Sets the widget modifier.
  UiMessageCollapsibleStyler modifier(WidgetModifierConfig value) {
    return merge(UiMessageCollapsibleStyler(modifier: value));
  }

  UiMessageCollapsible call({
    Key? key,
    required Widget child,
    bool? expanded,
    bool defaultExpanded = false,
    ValueChanged<bool>? onExpandedChanged,
    String showMoreLabel = 'Show more',
    String showLessLabel = 'Show less',
    ButtonStyler toggleStyle = const ButtonStyler.create(),
  }) {
    return UiMessageCollapsible(
      key: key,
      style: this,
      child: child,
      expanded: expanded,
      defaultExpanded: defaultExpanded,
      onExpandedChanged: onExpandedChanged,
      showMoreLabel: showMoreLabel,
      showLessLabel: showLessLabel,
      toggleStyle: toggleStyle,
    );
  }

  /// Merges with another [UiMessageCollapsibleStyler].
  @override
  UiMessageCollapsibleStyler merge(UiMessageCollapsibleStyler? other) {
    return UiMessageCollapsibleStyler.create(
      collapsedHeight: MixOps.merge($collapsedHeight, other?.$collapsedHeight),
      container: MixOps.merge($container, other?.$container),
      clipped: MixOps.merge($clipped, other?.$clipped),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<UiMessageCollapsibleSpec>] using [context].
  @override
  StyleSpec<UiMessageCollapsibleSpec> resolve(BuildContext context) {
    final spec = UiMessageCollapsibleSpec(
      collapsedHeight: MixOps.resolve(context, $collapsedHeight),
      container: MixOps.resolve(context, $container),
      clipped: MixOps.resolve(context, $clipped),
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
      ..add(DiagnosticsProperty('collapsedHeight', $collapsedHeight))
      ..add(DiagnosticsProperty('container', $container))
      ..add(DiagnosticsProperty('clipped', $clipped));
  }

  @override
  List<Object?> get props => [
    $collapsedHeight,
    $container,
    $clipped,
    $animation,
    $modifier,
    $variants,
  ];
}
