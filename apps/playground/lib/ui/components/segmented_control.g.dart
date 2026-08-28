// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'segmented_control.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's SegmentedControl recipe.
///
/// A segmented control is one control divided into parts, which is what
/// separates it from a toggle group: the segments share a track, exactly one
/// is chosen, and the chosen one is *lifted* out of the track rather than
/// tinted on top of it. Remix owns the rendering, the equal-width layout, the
/// roving focus, and the group accessibility semantics.
///
/// One recipe covers the track and the segments, because
/// `SegmentedControlSpec` carries the segment's style as a field: the
/// control's `item` is the default every `RemixSegmentedControlItem` resolves
/// against, so a segment in a loop cannot be left unstyled.
///
/// It takes no variant. The whole point of the component is one shape — a
/// recessed track with a raised current segment — and a second look would be
/// a toggle group wearing the wrong name.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
class PlaygroundSegmentedControl<T extends Object> extends StatelessWidget {
  const PlaygroundSegmentedControl({
    super.key,
    this.style = const SegmentedControlStyler.create(),
    required this.items,
    required this.selectedValue,
    this.onChanged,
    this.enabled = true,
    this.orientation = .horizontal,
    this.loop = true,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final SegmentedControlStyler style;

  final List<RemixSegmentedControlItem<T>> items;

  final T? selectedValue;

  final ValueChanged<T>? onChanged;

  final bool enabled;

  final Axis orientation;

  final bool loop;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixSegmentedControl<T>(
      key: this.key,
      style: playgroundSegmentedControlStyle(style: this.style),
      items: this.items,
      selectedValue: this.selectedValue,
      onChanged: this.onChanged,
      enabled: this.enabled,
      orientation: this.orientation,
      loop: this.loop,
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
