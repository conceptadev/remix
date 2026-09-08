// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$AgentMessageSpec implements Spec<AgentMessageSpec>, Diagnosticable {
  double? get maxWidth;
  StyleSpec<FlexBoxSpec> get row;
  StyleSpec<BoxSpec> get avatar;
  StyleSpec<BoxSpec> get header;
  StyleSpec<BoxSpec> get body;
  StyleSpec<BoxSpec> get footer;

  @override
  Type get type => AgentMessageSpec;

  @override
  AgentMessageSpec copyWith({
    double? maxWidth,
    StyleSpec<FlexBoxSpec>? row,
    StyleSpec<BoxSpec>? avatar,
    StyleSpec<BoxSpec>? header,
    StyleSpec<BoxSpec>? body,
    StyleSpec<BoxSpec>? footer,
  }) {
    return AgentMessageSpec(
      maxWidth: maxWidth ?? this.maxWidth,
      row: row ?? this.row,
      avatar: avatar ?? this.avatar,
      header: header ?? this.header,
      body: body ?? this.body,
      footer: footer ?? this.footer,
    );
  }

  @override
  AgentMessageSpec lerp(AgentMessageSpec? other, double t) {
    return AgentMessageSpec(
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
        other is AgentMessageSpec &&
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
  'Rename to `_\$AgentMessageSpec` and migrate the class declaration to `class AgentMessageSpec with _\$AgentMessageSpec`. The `_\$AgentMessageSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$AgentMessageSpecMethods = _$AgentMessageSpec; // ignore: unused_element

mixin _$AgentMessageCollapsibleSpec
    implements Spec<AgentMessageCollapsibleSpec>, Diagnosticable {
  double? get collapsedHeight;
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get clipped;

  @override
  Type get type => AgentMessageCollapsibleSpec;

  @override
  AgentMessageCollapsibleSpec copyWith({
    double? collapsedHeight,
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? clipped,
  }) {
    return AgentMessageCollapsibleSpec(
      collapsedHeight: collapsedHeight ?? this.collapsedHeight,
      container: container ?? this.container,
      clipped: clipped ?? this.clipped,
    );
  }

  @override
  AgentMessageCollapsibleSpec lerp(
    AgentMessageCollapsibleSpec? other,
    double t,
  ) {
    return AgentMessageCollapsibleSpec(
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
        other is AgentMessageCollapsibleSpec &&
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
  'Rename to `_\$AgentMessageCollapsibleSpec` and migrate the class declaration to `class AgentMessageCollapsibleSpec with _\$AgentMessageCollapsibleSpec`. The `_\$AgentMessageCollapsibleSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$AgentMessageCollapsibleSpecMethods = _$AgentMessageCollapsibleSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class AgentMessageStyler
    extends MixStyler<AgentMessageStyler, AgentMessageSpec> {
  final Prop<double>? $maxWidth;
  final Prop<StyleSpec<FlexBoxSpec>>? $row;
  final Prop<StyleSpec<BoxSpec>>? $avatar;
  final Prop<StyleSpec<BoxSpec>>? $header;
  final Prop<StyleSpec<BoxSpec>>? $body;
  final Prop<StyleSpec<BoxSpec>>? $footer;

  const AgentMessageStyler.create({
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

  AgentMessageStyler({
    double? maxWidth,
    FlexBoxStyler? row,
    BoxStyler? avatar,
    BoxStyler? header,
    BoxStyler? body,
    BoxStyler? footer,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<AgentMessageSpec>>? variants,
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

  factory AgentMessageStyler.maxWidth(double value) =>
      AgentMessageStyler().maxWidth(value);
  factory AgentMessageStyler.row(FlexBoxStyler value) =>
      AgentMessageStyler().row(value);
  factory AgentMessageStyler.avatar(BoxStyler value) =>
      AgentMessageStyler().avatar(value);
  factory AgentMessageStyler.header(BoxStyler value) =>
      AgentMessageStyler().header(value);
  factory AgentMessageStyler.body(BoxStyler value) =>
      AgentMessageStyler().body(value);
  factory AgentMessageStyler.footer(BoxStyler value) =>
      AgentMessageStyler().footer(value);

  /// Sets the maxWidth.
  AgentMessageStyler maxWidth(double value) {
    return merge(AgentMessageStyler(maxWidth: value));
  }

  /// Sets the row.
  AgentMessageStyler row(FlexBoxStyler value) {
    return merge(AgentMessageStyler(row: value));
  }

  /// Sets the avatar.
  AgentMessageStyler avatar(BoxStyler value) {
    return merge(AgentMessageStyler(avatar: value));
  }

  /// Sets the header.
  AgentMessageStyler header(BoxStyler value) {
    return merge(AgentMessageStyler(header: value));
  }

  /// Sets the body.
  AgentMessageStyler body(BoxStyler value) {
    return merge(AgentMessageStyler(body: value));
  }

  /// Sets the footer.
  AgentMessageStyler footer(BoxStyler value) {
    return merge(AgentMessageStyler(footer: value));
  }

  /// Sets the animation configuration.
  @override
  AgentMessageStyler animate(AnimationConfig value) {
    return merge(AgentMessageStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  AgentMessageStyler variants(List<VariantStyle<AgentMessageSpec>> value) {
    return merge(AgentMessageStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  AgentMessageStyler wrap(WidgetModifierConfig value) {
    return merge(AgentMessageStyler(modifier: value));
  }

  /// Sets the widget modifier.
  AgentMessageStyler modifier(WidgetModifierConfig value) {
    return merge(AgentMessageStyler(modifier: value));
  }

  AgentMessage call({
    Key? key,
    required AgentRole role,
    required Widget child,
    AgentMessageAlign? align,
    Widget? avatar,
    bool showAvatar = false,
    bool placeholderAvatar = false,
    double? maxWidth,
    Widget? header,
    Widget? footer,
    String? semanticLabel,
    CardStyler surfaceStyle = const CardStyler.create(),
  }) {
    return AgentMessage(
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

  /// Merges with another [AgentMessageStyler].
  @override
  AgentMessageStyler merge(AgentMessageStyler? other) {
    return AgentMessageStyler.create(
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

  /// Resolves to [StyleSpec<AgentMessageSpec>] using [context].
  @override
  StyleSpec<AgentMessageSpec> resolve(BuildContext context) {
    final spec = AgentMessageSpec(
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

class AgentMessageCollapsibleStyler
    extends
        MixStyler<AgentMessageCollapsibleStyler, AgentMessageCollapsibleSpec> {
  final Prop<double>? $collapsedHeight;
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $clipped;

  const AgentMessageCollapsibleStyler.create({
    Prop<double>? collapsedHeight,
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? clipped,
    super.variants,
    super.modifier,
    super.animation,
  }) : $collapsedHeight = collapsedHeight,
       $container = container,
       $clipped = clipped;

  AgentMessageCollapsibleStyler({
    double? collapsedHeight,
    BoxStyler? container,
    BoxStyler? clipped,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<AgentMessageCollapsibleSpec>>? variants,
  }) : this.create(
         collapsedHeight: Prop.maybe(collapsedHeight),
         container: Prop.maybeMix(container),
         clipped: Prop.maybeMix(clipped),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory AgentMessageCollapsibleStyler.collapsedHeight(double value) =>
      AgentMessageCollapsibleStyler().collapsedHeight(value);
  factory AgentMessageCollapsibleStyler.container(BoxStyler value) =>
      AgentMessageCollapsibleStyler().container(value);
  factory AgentMessageCollapsibleStyler.clipped(BoxStyler value) =>
      AgentMessageCollapsibleStyler().clipped(value);

  /// Sets the collapsedHeight.
  AgentMessageCollapsibleStyler collapsedHeight(double value) {
    return merge(AgentMessageCollapsibleStyler(collapsedHeight: value));
  }

  /// Sets the container.
  AgentMessageCollapsibleStyler container(BoxStyler value) {
    return merge(AgentMessageCollapsibleStyler(container: value));
  }

  /// Sets the clipped.
  AgentMessageCollapsibleStyler clipped(BoxStyler value) {
    return merge(AgentMessageCollapsibleStyler(clipped: value));
  }

  /// Sets the animation configuration.
  @override
  AgentMessageCollapsibleStyler animate(AnimationConfig value) {
    return merge(AgentMessageCollapsibleStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  AgentMessageCollapsibleStyler variants(
    List<VariantStyle<AgentMessageCollapsibleSpec>> value,
  ) {
    return merge(AgentMessageCollapsibleStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  AgentMessageCollapsibleStyler wrap(WidgetModifierConfig value) {
    return merge(AgentMessageCollapsibleStyler(modifier: value));
  }

  /// Sets the widget modifier.
  AgentMessageCollapsibleStyler modifier(WidgetModifierConfig value) {
    return merge(AgentMessageCollapsibleStyler(modifier: value));
  }

  AgentMessageCollapsible call({
    Key? key,
    required Widget child,
    bool? expanded,
    bool defaultExpanded = false,
    ValueChanged<bool>? onExpandedChanged,
    String showMoreLabel = 'Show more',
    String showLessLabel = 'Show less',
    ButtonStyler toggleStyle = const ButtonStyler.create(),
  }) {
    return AgentMessageCollapsible(
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

  /// Merges with another [AgentMessageCollapsibleStyler].
  @override
  AgentMessageCollapsibleStyler merge(AgentMessageCollapsibleStyler? other) {
    return AgentMessageCollapsibleStyler.create(
      collapsedHeight: MixOps.merge($collapsedHeight, other?.$collapsedHeight),
      container: MixOps.merge($container, other?.$container),
      clipped: MixOps.merge($clipped, other?.$clipped),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<AgentMessageCollapsibleSpec>] using [context].
  @override
  StyleSpec<AgentMessageCollapsibleSpec> resolve(BuildContext context) {
    final spec = AgentMessageCollapsibleSpec(
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
