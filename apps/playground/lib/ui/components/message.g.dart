// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$PlaygroundMessageSpec
    implements Spec<PlaygroundMessageSpec>, Diagnosticable {
  double? get maxWidth;
  StyleSpec<FlexBoxSpec> get row;
  StyleSpec<BoxSpec> get avatar;
  StyleSpec<BoxSpec> get header;
  StyleSpec<BoxSpec> get body;
  StyleSpec<BoxSpec> get footer;

  @override
  Type get type => PlaygroundMessageSpec;

  @override
  PlaygroundMessageSpec copyWith({
    double? maxWidth,
    StyleSpec<FlexBoxSpec>? row,
    StyleSpec<BoxSpec>? avatar,
    StyleSpec<BoxSpec>? header,
    StyleSpec<BoxSpec>? body,
    StyleSpec<BoxSpec>? footer,
  }) {
    return PlaygroundMessageSpec(
      maxWidth: maxWidth ?? this.maxWidth,
      row: row ?? this.row,
      avatar: avatar ?? this.avatar,
      header: header ?? this.header,
      body: body ?? this.body,
      footer: footer ?? this.footer,
    );
  }

  @override
  PlaygroundMessageSpec lerp(PlaygroundMessageSpec? other, double t) {
    return PlaygroundMessageSpec(
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
        other is PlaygroundMessageSpec &&
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
  'Rename to `_\$PlaygroundMessageSpec` and migrate the class declaration to `class PlaygroundMessageSpec with _\$PlaygroundMessageSpec`. The `_\$PlaygroundMessageSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$PlaygroundMessageSpecMethods = _$PlaygroundMessageSpec; // ignore: unused_element

mixin _$PlaygroundMessageCollapsibleSpec
    implements Spec<PlaygroundMessageCollapsibleSpec>, Diagnosticable {
  double? get collapsedHeight;
  StyleSpec<BoxSpec> get container;
  StyleSpec<BoxSpec> get clipped;

  @override
  Type get type => PlaygroundMessageCollapsibleSpec;

  @override
  PlaygroundMessageCollapsibleSpec copyWith({
    double? collapsedHeight,
    StyleSpec<BoxSpec>? container,
    StyleSpec<BoxSpec>? clipped,
  }) {
    return PlaygroundMessageCollapsibleSpec(
      collapsedHeight: collapsedHeight ?? this.collapsedHeight,
      container: container ?? this.container,
      clipped: clipped ?? this.clipped,
    );
  }

  @override
  PlaygroundMessageCollapsibleSpec lerp(
    PlaygroundMessageCollapsibleSpec? other,
    double t,
  ) {
    return PlaygroundMessageCollapsibleSpec(
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
        other is PlaygroundMessageCollapsibleSpec &&
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
  'Rename to `_\$PlaygroundMessageCollapsibleSpec` and migrate the class declaration to `class PlaygroundMessageCollapsibleSpec with _\$PlaygroundMessageCollapsibleSpec`. The `_\$PlaygroundMessageCollapsibleSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$PlaygroundMessageCollapsibleSpecMethods =
    _$PlaygroundMessageCollapsibleSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class PlaygroundMessageStyler
    extends MixStyler<PlaygroundMessageStyler, PlaygroundMessageSpec>
    implements StylerFieldMetadata {
  final Prop<double>? $maxWidth;
  final Prop<StyleSpec<FlexBoxSpec>>? $row;
  final Prop<StyleSpec<BoxSpec>>? $avatar;
  final Prop<StyleSpec<BoxSpec>>? $header;
  final Prop<StyleSpec<BoxSpec>>? $body;
  final Prop<StyleSpec<BoxSpec>>? $footer;

  const PlaygroundMessageStyler.create({
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

  PlaygroundMessageStyler({
    double? maxWidth,
    FlexBoxStyler? row,
    BoxStyler? avatar,
    BoxStyler? header,
    BoxStyler? body,
    BoxStyler? footer,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<PlaygroundMessageSpec>>? variants,
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

  factory PlaygroundMessageStyler.maxWidth(double value) =>
      PlaygroundMessageStyler().maxWidth(value);
  factory PlaygroundMessageStyler.row(FlexBoxStyler value) =>
      PlaygroundMessageStyler().row(value);
  factory PlaygroundMessageStyler.avatar(BoxStyler value) =>
      PlaygroundMessageStyler().avatar(value);
  factory PlaygroundMessageStyler.header(BoxStyler value) =>
      PlaygroundMessageStyler().header(value);
  factory PlaygroundMessageStyler.body(BoxStyler value) =>
      PlaygroundMessageStyler().body(value);
  factory PlaygroundMessageStyler.footer(BoxStyler value) =>
      PlaygroundMessageStyler().footer(value);

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
  PlaygroundMessageStyler maxWidth(double value) {
    return merge(PlaygroundMessageStyler(maxWidth: value));
  }

  /// Sets the row.
  PlaygroundMessageStyler row(FlexBoxStyler value) {
    return merge(PlaygroundMessageStyler(row: value));
  }

  /// Sets the avatar.
  PlaygroundMessageStyler avatar(BoxStyler value) {
    return merge(PlaygroundMessageStyler(avatar: value));
  }

  /// Sets the header.
  PlaygroundMessageStyler header(BoxStyler value) {
    return merge(PlaygroundMessageStyler(header: value));
  }

  /// Sets the body.
  PlaygroundMessageStyler body(BoxStyler value) {
    return merge(PlaygroundMessageStyler(body: value));
  }

  /// Sets the footer.
  PlaygroundMessageStyler footer(BoxStyler value) {
    return merge(PlaygroundMessageStyler(footer: value));
  }

  /// Sets the animation configuration.
  @override
  PlaygroundMessageStyler animate(AnimationConfig value) {
    return merge(PlaygroundMessageStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  PlaygroundMessageStyler variants(
    List<VariantStyle<PlaygroundMessageSpec>> value,
  ) {
    return merge(PlaygroundMessageStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  PlaygroundMessageStyler wrap(WidgetModifierConfig value) {
    return merge(PlaygroundMessageStyler(modifier: value));
  }

  /// Sets the widget modifier.
  PlaygroundMessageStyler modifier(WidgetModifierConfig value) {
    return merge(PlaygroundMessageStyler(modifier: value));
  }

  PlaygroundMessage call({
    Key? key,
    required PlaygroundRole role,
    required Widget child,
    PlaygroundMessageAlign? align,
    Widget? avatar,
    bool showAvatar = false,
    bool placeholderAvatar = false,
    double? maxWidth,
    Widget? header,
    Widget? footer,
    String? semanticLabel,
    CardStyler surfaceStyle = const CardStyler.create(),
  }) {
    return PlaygroundMessage(
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

  /// Merges with another [PlaygroundMessageStyler].
  @override
  PlaygroundMessageStyler merge(PlaygroundMessageStyler? other) {
    return PlaygroundMessageStyler.create(
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

  /// Resolves to [StyleSpec<PlaygroundMessageSpec>] using [context].
  @override
  StyleSpec<PlaygroundMessageSpec> resolve(BuildContext context) {
    final spec = PlaygroundMessageSpec(
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

class PlaygroundMessageCollapsibleStyler
    extends
        MixStyler<
          PlaygroundMessageCollapsibleStyler,
          PlaygroundMessageCollapsibleSpec
        >
    implements StylerFieldMetadata {
  final Prop<double>? $collapsedHeight;
  final Prop<StyleSpec<BoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $clipped;

  const PlaygroundMessageCollapsibleStyler.create({
    Prop<double>? collapsedHeight,
    Prop<StyleSpec<BoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? clipped,
    super.variants,
    super.modifier,
    super.animation,
  }) : $collapsedHeight = collapsedHeight,
       $container = container,
       $clipped = clipped;

  PlaygroundMessageCollapsibleStyler({
    double? collapsedHeight,
    BoxStyler? container,
    BoxStyler? clipped,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<PlaygroundMessageCollapsibleSpec>>? variants,
  }) : this.create(
         collapsedHeight: Prop.maybe(collapsedHeight),
         container: Prop.maybeMix(container),
         clipped: Prop.maybeMix(clipped),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory PlaygroundMessageCollapsibleStyler.collapsedHeight(double value) =>
      PlaygroundMessageCollapsibleStyler().collapsedHeight(value);
  factory PlaygroundMessageCollapsibleStyler.container(BoxStyler value) =>
      PlaygroundMessageCollapsibleStyler().container(value);
  factory PlaygroundMessageCollapsibleStyler.clipped(BoxStyler value) =>
      PlaygroundMessageCollapsibleStyler().clipped(value);

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
  PlaygroundMessageCollapsibleStyler collapsedHeight(double value) {
    return merge(PlaygroundMessageCollapsibleStyler(collapsedHeight: value));
  }

  /// Sets the container.
  PlaygroundMessageCollapsibleStyler container(BoxStyler value) {
    return merge(PlaygroundMessageCollapsibleStyler(container: value));
  }

  /// Sets the clipped.
  PlaygroundMessageCollapsibleStyler clipped(BoxStyler value) {
    return merge(PlaygroundMessageCollapsibleStyler(clipped: value));
  }

  /// Sets the animation configuration.
  @override
  PlaygroundMessageCollapsibleStyler animate(AnimationConfig value) {
    return merge(PlaygroundMessageCollapsibleStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  PlaygroundMessageCollapsibleStyler variants(
    List<VariantStyle<PlaygroundMessageCollapsibleSpec>> value,
  ) {
    return merge(PlaygroundMessageCollapsibleStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  PlaygroundMessageCollapsibleStyler wrap(WidgetModifierConfig value) {
    return merge(PlaygroundMessageCollapsibleStyler(modifier: value));
  }

  /// Sets the widget modifier.
  PlaygroundMessageCollapsibleStyler modifier(WidgetModifierConfig value) {
    return merge(PlaygroundMessageCollapsibleStyler(modifier: value));
  }

  PlaygroundMessageCollapsible call({
    Key? key,
    required Widget child,
    bool? expanded,
    bool defaultExpanded = false,
    ValueChanged<bool>? onExpandedChanged,
    String showMoreLabel = 'Show more',
    String showLessLabel = 'Show less',
    ButtonStyler toggleStyle = const ButtonStyler.create(),
  }) {
    return PlaygroundMessageCollapsible(
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

  /// Merges with another [PlaygroundMessageCollapsibleStyler].
  @override
  PlaygroundMessageCollapsibleStyler merge(
    PlaygroundMessageCollapsibleStyler? other,
  ) {
    return PlaygroundMessageCollapsibleStyler.create(
      collapsedHeight: MixOps.merge($collapsedHeight, other?.$collapsedHeight),
      container: MixOps.merge($container, other?.$container),
      clipped: MixOps.merge($clipped, other?.$clipped),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<PlaygroundMessageCollapsibleSpec>] using [context].
  @override
  StyleSpec<PlaygroundMessageCollapsibleSpec> resolve(BuildContext context) {
    final spec = PlaygroundMessageCollapsibleSpec(
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
