import 'package:flutter/widgets.dart';

import '../../tokens/generated/carbon_tokens.g.dart';

/// One Carbon list item.
class CarbonListItem extends StatelessWidget {
  const CarbonListItem({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Semantics(
    role: .listItem,
    container: true,
    child: DefaultTextStyle.merge(
      style: CarbonTokens.body01
          .resolve(context)
          .copyWith(color: CarbonTokens.textPrimary.resolve(context)),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            width: CarbonTokens.spacing05.resolve(context),
            child: Text(_CarbonListMarker.maybeOf(context) ?? '•'),
          ),
          Expanded(child: child),
        ],
      ),
    ),
  );
}

/// Carbon unordered list.
class CarbonUnorderedList extends StatelessWidget {
  const CarbonUnorderedList({
    super.key,
    required this.children,
    this.condensed = false,
  });

  final List<CarbonListItem> children;
  final bool condensed;

  @override
  Widget build(BuildContext context) => _CarbonListBody(
    spacing: condensed ? 0 : CarbonTokens.spacing02.resolve(context),
    children: [
      for (final item in children) _CarbonListMarker(marker: '•', child: item),
    ],
  );
}

/// Carbon ordered list.
class CarbonOrderedList extends StatelessWidget {
  const CarbonOrderedList({
    super.key,
    required this.children,
    this.start = 1,
    this.condensed = false,
  });

  final List<CarbonListItem> children;
  final int start;
  final bool condensed;

  @override
  Widget build(BuildContext context) => _CarbonListBody(
    spacing: condensed ? 0 : CarbonTokens.spacing02.resolve(context),
    children: [
      for (var index = 0; index < children.length; index++)
        _CarbonListMarker(marker: '${start + index}.', child: children[index]),
    ],
  );
}

class _CarbonListBody extends StatelessWidget {
  const _CarbonListBody({required this.spacing, required this.children});

  final double spacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Semantics(
    role: .list,
    container: true,
    explicitChildNodes: true,
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      spacing: spacing,
      children: children,
    ),
  );
}

class _CarbonListMarker extends InheritedWidget {
  const _CarbonListMarker({required this.marker, required super.child});

  final String marker;

  static String? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_CarbonListMarker>()?.marker;

  @override
  bool updateShouldNotify(_CarbonListMarker oldWidget) =>
      marker != oldWidget.marker;
}
