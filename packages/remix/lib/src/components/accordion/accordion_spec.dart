part of 'accordion.dart';

/// Resolved visual properties for a [RemixAccordion].
@MixableSpec(extraStylerMixins: [RemixBoxStylerMixin])
class AccordionSpec with _$AccordionSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<FlexBoxSpec> trigger;
  @override
  final StyleSpec<IconSpec> leadingIcon;
  @override
  final StyleSpec<TextSpec> title;
  @override
  final StyleSpec<IconSpec> trailingIcon;
  @override
  final StyleSpec<BoxSpec> content;

  const AccordionSpec({
    StyleSpec<FlexBoxSpec>? trigger,
    StyleSpec<IconSpec>? leadingIcon,
    StyleSpec<TextSpec>? title,
    StyleSpec<IconSpec>? trailingIcon,
    StyleSpec<BoxSpec>? content,
  }) : trigger = trigger ?? const StyleSpec(spec: FlexBoxSpec()),
       leadingIcon = leadingIcon ?? const StyleSpec(spec: IconSpec()),
       title = title ?? const StyleSpec(spec: TextSpec()),
       trailingIcon = trailingIcon ?? const StyleSpec(spec: IconSpec()),
       content = content ?? const StyleSpec(spec: BoxSpec());
}

/// Backward-compatible name for [AccordionSpec].
///
/// The generated style API is based on [AccordionSpec], so resolved values use
/// `AccordionSpec` as their runtime type.
typedef RemixAccordionSpec = AccordionSpec;
