// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_list.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// The application's DataList recipe.
///
/// A data list is a set of label/value pairs — the "Status: Active" block on a
/// detail page. Remix owns the rendering, the two layout orientations, the
/// label-column alignment, and the accessibility semantics; this recipe
/// supplies the two text roles and the spacing between them.
///
/// The label is `mutedForeground` and the value is `foreground`, which is the
/// pairing that makes a list scannable: the eye lands on the answers, and the
/// questions stay legible without competing.
///
/// It takes no size and no variant. A data list is typography and spacing, and
/// both are decided by the page it sits on — a caller who wants a denser block
/// overrides the spacings through [style].
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it:
///
/// ```dart
/// PlaygroundDataList(
///   items: const [
///     RemixDataListItem(label: 'Status', value: 'Active'),
///     RemixDataListItem(label: 'Plan', value: 'Pro'),
///   ],
/// )
/// ```
class PlaygroundDataList extends StatelessWidget {
  const PlaygroundDataList({
    super.key,
    this.style = const DataListStyler.create(),
    required this.items,
    this.orientation = Axis.horizontal,
    this.semanticLabel,
    this.excludeSemantics = false,
  });

  final DataListStyler style;

  final List<RemixDataListItem> items;

  final Axis orientation;

  final String? semanticLabel;

  final bool excludeSemantics;

  @override
  Widget build(BuildContext context) {
    return RemixDataList(
      key: this.key,
      style: playgroundDataListStyle(style: this.style),
      items: this.items,
      orientation: this.orientation,
      semanticLabel: this.semanticLabel,
      excludeSemantics: this.excludeSemantics,
    );
  }
}
