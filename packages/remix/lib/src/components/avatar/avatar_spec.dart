part of 'avatar.dart';

/// Resolved visual properties for a [RemixAvatar].
@MixableSpec(
  extraStylerMixins: [RemixBoxStylerMixin, LabelStyleMixin, IconStyleMixin],
)
class AvatarSpec with _$AvatarSpec {
  @override
  @MixableField(forwardStyler: true)
  final StyleSpec<BoxSpec> container;
  @override
  final StyleSpec<TextSpec> label;
  @override
  final StyleSpec<IconSpec> icon;

  const AvatarSpec({
    StyleSpec<BoxSpec>? container,
    StyleSpec<TextSpec>? label,
    StyleSpec<IconSpec>? icon,
  }) : container = container ?? const StyleSpec(spec: BoxSpec()),
       label = label ?? const StyleSpec(spec: TextSpec()),
       icon = icon ?? const StyleSpec(spec: IconSpec());
}

/// Backward-compatible name for [AvatarSpec].
///
/// The generated style API is based on [AvatarSpec], so resolved values use
/// `AvatarSpec` as their runtime type.
typedef RemixAvatarSpec = AvatarSpec;
