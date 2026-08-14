import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../foundation/carbon_layout_scope.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_action_surface.dart';
import '../button/carbon_button.dart';

/// Immutable node data consumed by [CarbonTreeView].
@immutable
final class CarbonTreeNode<T extends Object> {
  const CarbonTreeNode({
    required this.id,
    required this.label,
    this.children = const [],
    this.enabled = true,
    this.leading,
    this.trailing,
    this.semanticLabel,
  }) : assert(label != '');

  final T id;
  final String label;
  final List<CarbonTreeNode<T>> children;
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final String? semanticLabel;
}

/// Hierarchical Carbon navigation with controlled-or-owned expansion.
class CarbonTreeView<T extends Object> extends StatefulWidget {
  const CarbonTreeView({
    super.key,
    required this.nodes,
    this.selectedId,
    this.onSelected,
    this.expandedIds,
    this.initialExpandedIds = const {},
    this.onExpandedChanged,
    this.semanticLabel = 'Tree view',
  });

  final List<CarbonTreeNode<T>> nodes;
  final T? selectedId;
  final ValueChanged<T>? onSelected;
  final Set<T>? expandedIds;
  final Set<T> initialExpandedIds;
  final ValueChanged<Set<T>>? onExpandedChanged;
  final String semanticLabel;

  @override
  State<CarbonTreeView<T>> createState() => _CarbonTreeViewState<T>();
}

class _CarbonTreeViewState<T extends Object> extends State<CarbonTreeView<T>> {
  late Set<T> _ownedExpanded;

  Set<T> get _expanded => widget.expandedIds ?? _ownedExpanded;

  @override
  void initState() {
    super.initState();
    _ownedExpanded = {...widget.initialExpandedIds};
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      final ids = <T>{};
      void visit(Iterable<CarbonTreeNode<T>> nodes) {
        for (final node in nodes) {
          assert(ids.add(node.id), 'CarbonTreeView node ids must be unique.');
          visit(node.children);
        }
      }

      visit(widget.nodes);

      return true;
    }());

    return Semantics(
      role: .list,
      label: widget.semanticLabel,
      container: true,
      explicitChildNodes: true,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          for (final node in widget.nodes) _buildNode(context, node, 0),
        ],
      ),
    );
  }

  Widget _buildNode(BuildContext context, CarbonTreeNode<T> node, int depth) {
    final hasChildren = node.children.isNotEmpty;
    final expanded = hasChildren && _expanded.contains(node.id);
    final selected = widget.selectedId == node.id;
    final buttonStyle = carbonButtonStyle(
      kind: .ghost,
      size: .sm,
    ).padding(.all(0)).spacing(0).mainAxisAlignment(.center);

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        Semantics(
          role: .listItem,
          container: true,
          explicitChildNodes: true,
          child: Box(
            style: BoxStyler()
                .padding(.left(depth * 24.0))
                .color(
                  selected
                      ? CarbonLayer.of(
                          context,
                        ).color(.layerSelected).resolve(context)
                      : const Color(0x00000000),
                ),
            child: Row(
              children: [
                SizedBox.square(
                  dimension: CarbonSize.sm.height,
                  child: hasChildren
                      ? RemixButton(
                          label: expanded ? '−' : '+',
                          semanticLabel: expanded
                              ? 'Collapse ${node.label}'
                              : 'Expand ${node.label}',
                          enabled: node.enabled,
                          onPressed: node.enabled
                              ? () => _toggleExpanded(node.id)
                              : null,
                          style: buttonStyle,
                        )
                      : const SizedBox.shrink(),
                ),
                Expanded(
                  child: CarbonActionSurface(
                    semanticLabel: node.semanticLabel ?? node.label,
                    selected: selected,
                    enabled: node.enabled,
                    onPressed: widget.onSelected == null
                        ? null
                        : () => widget.onSelected!(node.id),
                    excludeChildSemantics: true,
                    builder: (context, focused, hovered, pressed) => Box(
                      style: BoxStyler()
                          .minHeight(CarbonSize.sm.height)
                          .padding(.horizontal(CarbonTokens.spacing03()))
                          .color(
                            pressed
                                ? CarbonLayer.of(
                                    context,
                                  ).color(.layerActive).resolve(context)
                                : hovered
                                ? CarbonLayer.of(
                                    context,
                                  ).color(.layerHover).resolve(context)
                                : const Color(0x00000000),
                          )
                          .border(
                            BoxBorderMix.all(
                              BorderSideMix(
                                color: focused
                                    ? CarbonTokens.focus()
                                    : const Color(0x00000000),
                                width: 2,
                              ),
                            ),
                          )
                          .alignment(.centerLeft),
                      child: Row(
                        children: [
                          if (node.leading != null) ...[
                            node.leading!,
                            SizedBox(
                              width: CarbonTokens.spacing03.resolve(context),
                            ),
                          ],
                          Expanded(
                            child: StyledText(
                              node.label,
                              style: TextStyler()
                                  .style(CarbonTokens.bodyCompact01.mix())
                                  .color(
                                    node.enabled
                                        ? CarbonTokens.textPrimary()
                                        : CarbonTokens.textDisabled(),
                                  ),
                            ),
                          ),
                          ?node.trailing,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (expanded)
          for (final child in node.children)
            _buildNode(context, child, depth + 1),
      ],
    );
  }

  void _toggleExpanded(T id) {
    final next = <T>{..._expanded};
    next.contains(id) ? next.remove(id) : next.add(id);
    if (widget.expandedIds == null) setState(() => _ownedExpanded = next);
    widget.onExpandedChanged?.call(UnmodifiableSetView(next));
  }
}
