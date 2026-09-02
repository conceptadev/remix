// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidebar.dart';

// **************************************************************************
// SpecGenerator
// **************************************************************************

mixin _$SidebarSpec implements Spec<SidebarSpec>, Diagnosticable {
  StyleSpec<FlexBoxSpec> get container;
  StyleSpec<BoxSpec> get header;
  StyleSpec<FlexBoxSpec> get content;
  StyleSpec<BoxSpec> get footer;
  StyleSpec<FlexBoxSpec> get section;
  StyleSpec<TextSpec> get sectionLabel;
  StyleSpec<FlexBoxSpec> get destinations;
  StyleSpec<ToggleSpec> get destination;

  @override
  Type get type => SidebarSpec;

  @override
  SidebarSpec copyWith({
    StyleSpec<FlexBoxSpec>? container,
    StyleSpec<BoxSpec>? header,
    StyleSpec<FlexBoxSpec>? content,
    StyleSpec<BoxSpec>? footer,
    StyleSpec<FlexBoxSpec>? section,
    StyleSpec<TextSpec>? sectionLabel,
    StyleSpec<FlexBoxSpec>? destinations,
    StyleSpec<ToggleSpec>? destination,
  }) {
    return SidebarSpec(
      container: container ?? this.container,
      header: header ?? this.header,
      content: content ?? this.content,
      footer: footer ?? this.footer,
      section: section ?? this.section,
      sectionLabel: sectionLabel ?? this.sectionLabel,
      destinations: destinations ?? this.destinations,
      destination: destination ?? this.destination,
    );
  }

  @override
  SidebarSpec lerp(SidebarSpec? other, double t) {
    return SidebarSpec(
      container: container.lerp(other?.container, t),
      header: header.lerp(other?.header, t),
      content: content.lerp(other?.content, t),
      footer: footer.lerp(other?.footer, t),
      section: section.lerp(other?.section, t),
      sectionLabel: sectionLabel.lerp(other?.sectionLabel, t),
      destinations: destinations.lerp(other?.destinations, t),
      destination: destination.lerp(other?.destination, t),
    );
  }

  @override
  List<Object?> get props => [
    container,
    header,
    content,
    footer,
    section,
    sectionLabel,
    destinations,
    destination,
  ];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SidebarSpec &&
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
      ..add(DiagnosticsProperty('header', header))
      ..add(DiagnosticsProperty('content', content))
      ..add(DiagnosticsProperty('footer', footer))
      ..add(DiagnosticsProperty('section', section))
      ..add(DiagnosticsProperty('sectionLabel', sectionLabel))
      ..add(DiagnosticsProperty('destinations', destinations))
      ..add(DiagnosticsProperty('destination', destination));
  }
}

@Deprecated(
  'Rename to `_\$SidebarSpec` and migrate the class declaration to `class SidebarSpec with _\$SidebarSpec`. The `_\$SidebarSpecMethods` alias will be removed in mix_generator 3.0.',
)
typedef _$SidebarSpecMethods = _$SidebarSpec; // ignore: unused_element

// **************************************************************************
// SpecStylerGenerator
// **************************************************************************

class SidebarStyler extends MixStyler<SidebarStyler, SidebarSpec>
    with RemixBoxStylerMixin<SidebarStyler>
    implements StylerFieldMetadata {
  final Prop<StyleSpec<FlexBoxSpec>>? $container;
  final Prop<StyleSpec<BoxSpec>>? $header;
  final Prop<StyleSpec<FlexBoxSpec>>? $content;
  final Prop<StyleSpec<BoxSpec>>? $footer;
  final Prop<StyleSpec<FlexBoxSpec>>? $section;
  final Prop<StyleSpec<TextSpec>>? $sectionLabel;
  final Prop<StyleSpec<FlexBoxSpec>>? $destinations;
  final Prop<StyleSpec<ToggleSpec>>? $destination;

  const SidebarStyler.create({
    Prop<StyleSpec<FlexBoxSpec>>? container,
    Prop<StyleSpec<BoxSpec>>? header,
    Prop<StyleSpec<FlexBoxSpec>>? content,
    Prop<StyleSpec<BoxSpec>>? footer,
    Prop<StyleSpec<FlexBoxSpec>>? section,
    Prop<StyleSpec<TextSpec>>? sectionLabel,
    Prop<StyleSpec<FlexBoxSpec>>? destinations,
    Prop<StyleSpec<ToggleSpec>>? destination,
    super.variants,
    super.modifier,
    super.animation,
  }) : $container = container,
       $header = header,
       $content = content,
       $footer = footer,
       $section = section,
       $sectionLabel = sectionLabel,
       $destinations = destinations,
       $destination = destination;

  SidebarStyler({
    FlexBoxStyler? container,
    BoxStyler? header,
    FlexBoxStyler? content,
    BoxStyler? footer,
    FlexBoxStyler? section,
    TextStyler? sectionLabel,
    FlexBoxStyler? destinations,
    ToggleStyler? destination,
    AnimationConfig? animation,
    WidgetModifierConfig? modifier,
    List<VariantStyle<SidebarSpec>>? variants,
  }) : this.create(
         container: Prop.maybeMix(container),
         header: Prop.maybeMix(header),
         content: Prop.maybeMix(content),
         footer: Prop.maybeMix(footer),
         section: Prop.maybeMix(section),
         sectionLabel: Prop.maybeMix(sectionLabel),
         destinations: Prop.maybeMix(destinations),
         destination: Prop.maybeMix(destination),
         variants: variants,
         modifier: modifier,
         animation: animation,
       );

  factory SidebarStyler.container(FlexBoxStyler value) =>
      SidebarStyler().container(value);
  factory SidebarStyler.header(BoxStyler value) =>
      SidebarStyler().header(value);
  factory SidebarStyler.content(FlexBoxStyler value) =>
      SidebarStyler().content(value);
  factory SidebarStyler.footer(BoxStyler value) =>
      SidebarStyler().footer(value);
  factory SidebarStyler.section(FlexBoxStyler value) =>
      SidebarStyler().section(value);
  factory SidebarStyler.sectionLabel(TextStyler value) =>
      SidebarStyler().sectionLabel(value);
  factory SidebarStyler.destinations(FlexBoxStyler value) =>
      SidebarStyler().destinations(value);
  factory SidebarStyler.destination(ToggleStyler value) =>
      SidebarStyler().destination(value);
  factory SidebarStyler.color(Color value) => SidebarStyler().color(value);
  factory SidebarStyler.gradient(GradientMix value) =>
      SidebarStyler().gradient(value);
  factory SidebarStyler.border(BoxBorderMix value) =>
      SidebarStyler().border(value);
  factory SidebarStyler.borderRadius(BorderRadiusGeometryMix value) =>
      SidebarStyler().borderRadius(value);
  factory SidebarStyler.elevation(ElevationShadow value) =>
      SidebarStyler().elevation(value);
  factory SidebarStyler.shadow(BoxShadowMix value) =>
      SidebarStyler().shadow(value);
  factory SidebarStyler.shadows(List<BoxShadowMix> value) =>
      SidebarStyler().shadows(value);
  factory SidebarStyler.width(double value) => SidebarStyler().width(value);
  factory SidebarStyler.height(double value) => SidebarStyler().height(value);
  factory SidebarStyler.size(double width, double height) =>
      SidebarStyler().size(width, height);
  factory SidebarStyler.minWidth(double value) =>
      SidebarStyler().minWidth(value);
  factory SidebarStyler.maxWidth(double value) =>
      SidebarStyler().maxWidth(value);
  factory SidebarStyler.minHeight(double value) =>
      SidebarStyler().minHeight(value);
  factory SidebarStyler.maxHeight(double value) =>
      SidebarStyler().maxHeight(value);
  factory SidebarStyler.scale(double scale, {Alignment alignment = .center}) =>
      SidebarStyler().scale(scale, alignment: alignment);
  factory SidebarStyler.rotate(
    double radians, {
    Alignment alignment = .center,
  }) => SidebarStyler().rotate(radians, alignment: alignment);
  factory SidebarStyler.translate(double x, double y, [double z = 0.0]) =>
      SidebarStyler().translate(x, y, z);
  factory SidebarStyler.skew(double skewX, double skewY) =>
      SidebarStyler().skew(skewX, skewY);
  factory SidebarStyler.textStyle(TextStyler value) =>
      SidebarStyler().textStyle(value);
  factory SidebarStyler.image(DecorationImageMix value) =>
      SidebarStyler().image(value);
  factory SidebarStyler.shape(ShapeBorderMix value) =>
      SidebarStyler().shape(value);
  factory SidebarStyler.backgroundImage(
    ImageProvider image, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SidebarStyler().backgroundImage(
    image,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SidebarStyler.backgroundImageUrl(
    String url, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SidebarStyler().backgroundImageUrl(
    url,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SidebarStyler.backgroundImageAsset(
    String path, {
    BoxFit? fit,
    AlignmentGeometry? alignment,
    ImageRepeat repeat = .noRepeat,
  }) => SidebarStyler().backgroundImageAsset(
    path,
    fit: fit,
    alignment: alignment,
    repeat: repeat,
  );
  factory SidebarStyler.linearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SidebarStyler().linearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SidebarStyler.radialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SidebarStyler().radialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SidebarStyler.sweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SidebarStyler().sweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SidebarStyler.foregroundLinearGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    TileMode? tileMode,
  }) => SidebarStyler().foregroundLinearGradient(
    colors: colors,
    stops: stops,
    begin: begin,
    end: end,
    tileMode: tileMode,
  );
  factory SidebarStyler.foregroundRadialGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? radius,
    AlignmentGeometry? focal,
    double? focalRadius,
    TileMode? tileMode,
  }) => SidebarStyler().foregroundRadialGradient(
    colors: colors,
    stops: stops,
    center: center,
    radius: radius,
    focal: focal,
    focalRadius: focalRadius,
    tileMode: tileMode,
  );
  factory SidebarStyler.foregroundSweepGradient({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
  }) => SidebarStyler().foregroundSweepGradient(
    colors: colors,
    stops: stops,
    center: center,
    startAngle: startAngle,
    endAngle: endAngle,
    tileMode: tileMode,
  );
  factory SidebarStyler.row() => SidebarStyler().row();
  factory SidebarStyler.column() => SidebarStyler().column();
  factory SidebarStyler.alignment(AlignmentGeometry value) =>
      SidebarStyler().alignment(value);
  factory SidebarStyler.padding(EdgeInsetsGeometryMix value) =>
      SidebarStyler().padding(value);
  factory SidebarStyler.margin(EdgeInsetsGeometryMix value) =>
      SidebarStyler().margin(value);
  factory SidebarStyler.constraints(BoxConstraintsMix value) =>
      SidebarStyler().constraints(value);
  factory SidebarStyler.decoration(DecorationMix value) =>
      SidebarStyler().decoration(value);
  factory SidebarStyler.foregroundDecoration(DecorationMix value) =>
      SidebarStyler().foregroundDecoration(value);
  factory SidebarStyler.clipBehavior(Clip value) =>
      SidebarStyler().clipBehavior(value);
  factory SidebarStyler.direction(Axis value) =>
      SidebarStyler().direction(value);
  factory SidebarStyler.mainAxisAlignment(MainAxisAlignment value) =>
      SidebarStyler().mainAxisAlignment(value);
  factory SidebarStyler.crossAxisAlignment(CrossAxisAlignment value) =>
      SidebarStyler().crossAxisAlignment(value);
  factory SidebarStyler.mainAxisSize(MainAxisSize value) =>
      SidebarStyler().mainAxisSize(value);
  factory SidebarStyler.spacing(double value) => SidebarStyler().spacing(value);
  factory SidebarStyler.verticalDirection(VerticalDirection value) =>
      SidebarStyler().verticalDirection(value);
  factory SidebarStyler.textDirection(TextDirection value) =>
      SidebarStyler().textDirection(value);
  factory SidebarStyler.textBaseline(TextBaseline value) =>
      SidebarStyler().textBaseline(value);
  factory SidebarStyler.transform(
    Matrix4 value, {
    Alignment alignment = .center,
  }) => SidebarStyler().transform(value, alignment: alignment);

  SidebarStyler color(Color value) {
    return container(FlexBoxStyler().color(value));
  }

  SidebarStyler gradient(GradientMix value) {
    return container(FlexBoxStyler().gradient(value));
  }

  SidebarStyler border(BoxBorderMix value) {
    return container(FlexBoxStyler().border(value));
  }

  SidebarStyler borderRadius(BorderRadiusGeometryMix value) {
    return container(FlexBoxStyler().borderRadius(value));
  }

  SidebarStyler elevation(ElevationShadow value) {
    return container(FlexBoxStyler().elevation(value));
  }

  SidebarStyler shadow(BoxShadowMix value) {
    return container(FlexBoxStyler().shadow(value));
  }

  SidebarStyler shadows(List<BoxShadowMix> value) {
    return container(FlexBoxStyler().shadows(value));
  }

  SidebarStyler width(double value) {
    return container(FlexBoxStyler().width(value));
  }

  SidebarStyler height(double value) {
    return container(FlexBoxStyler().height(value));
  }

  SidebarStyler size(double width, double height) {
    return container(FlexBoxStyler().size(width, height));
  }

  SidebarStyler minWidth(double value) {
    return container(FlexBoxStyler().minWidth(value));
  }

  SidebarStyler maxWidth(double value) {
    return container(FlexBoxStyler().maxWidth(value));
  }

  SidebarStyler minHeight(double value) {
    return container(FlexBoxStyler().minHeight(value));
  }

  SidebarStyler maxHeight(double value) {
    return container(FlexBoxStyler().maxHeight(value));
  }

  SidebarStyler scale(double scale, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().scale(scale, alignment: alignment));
  }

  SidebarStyler rotate(double radians, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().rotate(radians, alignment: alignment));
  }

  SidebarStyler translate(double x, double y, [double z = 0.0]) {
    return container(FlexBoxStyler().translate(x, y, z));
  }

  SidebarStyler skew(double skewX, double skewY) {
    return container(FlexBoxStyler().skew(skewX, skewY));
  }

  SidebarStyler textStyle(TextStyler value) {
    return container(FlexBoxStyler().textStyle(value));
  }

  SidebarStyler image(DecorationImageMix value) {
    return container(FlexBoxStyler().image(value));
  }

  SidebarStyler shape(ShapeBorderMix value) {
    return container(FlexBoxStyler().shape(value));
  }

  SidebarStyler backgroundImage(
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

  SidebarStyler backgroundImageUrl(
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

  SidebarStyler backgroundImageAsset(
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

  SidebarStyler linearGradient({
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

  SidebarStyler radialGradient({
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

  SidebarStyler sweepGradient({
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

  SidebarStyler foregroundLinearGradient({
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

  SidebarStyler foregroundRadialGradient({
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

  SidebarStyler foregroundSweepGradient({
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

  SidebarStyler row() {
    return container(FlexBoxStyler().row());
  }

  SidebarStyler column() {
    return container(FlexBoxStyler().column());
  }

  SidebarStyler alignment(AlignmentGeometry value) {
    return container(FlexBoxStyler().alignment(value));
  }

  SidebarStyler padding(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().padding(value));
  }

  SidebarStyler margin(EdgeInsetsGeometryMix value) {
    return container(FlexBoxStyler().margin(value));
  }

  SidebarStyler constraints(BoxConstraintsMix value) {
    return container(FlexBoxStyler().constraints(value));
  }

  SidebarStyler decoration(DecorationMix value) {
    return container(FlexBoxStyler().decoration(value));
  }

  SidebarStyler foregroundDecoration(DecorationMix value) {
    return container(FlexBoxStyler().foregroundDecoration(value));
  }

  SidebarStyler clipBehavior(Clip value) {
    return container(FlexBoxStyler().clipBehavior(value));
  }

  SidebarStyler direction(Axis value) {
    return container(FlexBoxStyler().direction(value));
  }

  SidebarStyler mainAxisAlignment(MainAxisAlignment value) {
    return container(FlexBoxStyler().mainAxisAlignment(value));
  }

  SidebarStyler crossAxisAlignment(CrossAxisAlignment value) {
    return container(FlexBoxStyler().crossAxisAlignment(value));
  }

  SidebarStyler mainAxisSize(MainAxisSize value) {
    return container(FlexBoxStyler().mainAxisSize(value));
  }

  SidebarStyler spacing(double value) {
    return container(FlexBoxStyler().spacing(value));
  }

  SidebarStyler verticalDirection(VerticalDirection value) {
    return container(FlexBoxStyler().verticalDirection(value));
  }

  SidebarStyler textDirection(TextDirection value) {
    return container(FlexBoxStyler().textDirection(value));
  }

  SidebarStyler textBaseline(TextBaseline value) {
    return container(FlexBoxStyler().textBaseline(value));
  }

  SidebarStyler transform(Matrix4 value, {Alignment alignment = .center}) {
    return container(FlexBoxStyler().transform(value, alignment: alignment));
  }

  @override
  Set<String> get $stylerFieldNames => const {
    'container',
    'header',
    'content',
    'footer',
    'section',
    'sectionLabel',
    'destinations',
    'destination',
    'animation',
    'modifier',
    'variants',
  };

  /// Sets the container.
  SidebarStyler container(FlexBoxStyler value) {
    return merge(SidebarStyler(container: value));
  }

  /// Sets the header.
  SidebarStyler header(BoxStyler value) {
    return merge(SidebarStyler(header: value));
  }

  /// Sets the content.
  SidebarStyler content(FlexBoxStyler value) {
    return merge(SidebarStyler(content: value));
  }

  /// Sets the footer.
  SidebarStyler footer(BoxStyler value) {
    return merge(SidebarStyler(footer: value));
  }

  /// Sets the section.
  SidebarStyler section(FlexBoxStyler value) {
    return merge(SidebarStyler(section: value));
  }

  /// Sets the sectionLabel.
  SidebarStyler sectionLabel(TextStyler value) {
    return merge(SidebarStyler(sectionLabel: value));
  }

  /// Sets the destinations.
  SidebarStyler destinations(FlexBoxStyler value) {
    return merge(SidebarStyler(destinations: value));
  }

  /// Sets the destination.
  SidebarStyler destination(ToggleStyler value) {
    return merge(SidebarStyler(destination: value));
  }

  /// Sets the animation configuration.
  @override
  SidebarStyler animate(AnimationConfig value) {
    return merge(SidebarStyler(animation: value));
  }

  /// Sets the style variants.
  @override
  SidebarStyler variants(List<VariantStyle<SidebarSpec>> value) {
    return merge(SidebarStyler(variants: value));
  }

  /// Wraps with a widget modifier.
  @override
  SidebarStyler wrap(WidgetModifierConfig value) {
    return merge(SidebarStyler(modifier: value));
  }

  /// Sets the widget modifier.
  SidebarStyler modifier(WidgetModifierConfig value) {
    return merge(SidebarStyler(modifier: value));
  }

  RemixSidebar<T> call<T extends Object>({
    Key? key,
    Widget? header,
    required List<RemixSidebarSection<T>> sections,
    required T? selectedValue,
    ValueChanged<T>? onSelected,
    Widget? footer,
    bool enabled = true,
    String? semanticLabel,
    bool excludeSemantics = false,
  }) {
    return RemixSidebar<T>(
      key: key,
      style: this,
      header: header,
      sections: sections,
      selectedValue: selectedValue,
      onSelected: onSelected,
      footer: footer,
      enabled: enabled,
      semanticLabel: semanticLabel,
      excludeSemantics: excludeSemantics,
    );
  }

  /// Merges with another [SidebarStyler].
  @override
  SidebarStyler merge(SidebarStyler? other) {
    return SidebarStyler.create(
      container: MixOps.merge($container, other?.$container),
      header: MixOps.merge($header, other?.$header),
      content: MixOps.merge($content, other?.$content),
      footer: MixOps.merge($footer, other?.$footer),
      section: MixOps.merge($section, other?.$section),
      sectionLabel: MixOps.merge($sectionLabel, other?.$sectionLabel),
      destinations: MixOps.merge($destinations, other?.$destinations),
      destination: MixOps.merge($destination, other?.$destination),
      variants: MixOps.mergeVariants($variants, other?.$variants),
      modifier: MixOps.mergeModifier($modifier, other?.$modifier),
      animation: MixOps.mergeAnimation($animation, other?.$animation),
    );
  }

  /// Resolves to [StyleSpec<SidebarSpec>] using [context].
  @override
  StyleSpec<SidebarSpec> resolve(BuildContext context) {
    final spec = SidebarSpec(
      container: MixOps.resolve(context, $container),
      header: MixOps.resolve(context, $header),
      content: MixOps.resolve(context, $content),
      footer: MixOps.resolve(context, $footer),
      section: MixOps.resolve(context, $section),
      sectionLabel: MixOps.resolve(context, $sectionLabel),
      destinations: MixOps.resolve(context, $destinations),
      destination: MixOps.resolve(context, $destination),
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
      ..add(DiagnosticsProperty('header', $header))
      ..add(DiagnosticsProperty('content', $content))
      ..add(DiagnosticsProperty('footer', $footer))
      ..add(DiagnosticsProperty('section', $section))
      ..add(DiagnosticsProperty('sectionLabel', $sectionLabel))
      ..add(DiagnosticsProperty('destinations', $destinations))
      ..add(DiagnosticsProperty('destination', $destination));
  }

  @override
  List<Object?> get props => [
    $container,
    $header,
    $content,
    $footer,
    $section,
    $sectionLabel,
    $destinations,
    $destination,
    $animation,
    $modifier,
    $variants,
  ];
}
