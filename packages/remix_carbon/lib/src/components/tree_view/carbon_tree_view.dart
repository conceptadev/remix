import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../foundation/carbon_layout_scope.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_action_surface.dart';
import '../_shared/carbon_icon_button_style.dart';
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
                _disclosureButton(node, expanded: expanded),
                Expanded(child: _selectableNode(node, selected: selected)),
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

  Widget _disclosureButton(CarbonTreeNode<T> node, {required bool expanded}) =>
      SizedBox.square(
        dimension: CarbonSize.sm.height,
        child: node.children.isEmpty
            ? const SizedBox.shrink()
            : CarbonIconButton(
                icon: expanded ? CarbonIcons.caretDown : CarbonIcons.caretRight,
                semanticLabel: expanded
                    ? 'Collapse ${node.label}'
                    : 'Expand ${node.label}',
                kind: .ghost,
                size: .sm,
                enabled: node.enabled,
                onPressed: node.enabled ? () => _toggleExpanded(node.id) : null,
                style: carbonIconButtonForegroundStyle(
                  CarbonTokens.iconPrimary,
                ),
              ),
      );

  Widget _selectableNode(CarbonTreeNode<T> node, {required bool selected}) =>
      CarbonActionSurface(
        semanticLabel: node.semanticLabel ?? node.label,
        selected: selected,
        enabled: node.enabled,
        onPressed: widget.onSelected == null
            ? null
            : () => widget.onSelected!(node.id),
        excludeChildSemantics: true,
        builder: (context, focused, hovered, pressed) => Box(
          style: _nodeActionStyle(
            context,
            focused: focused,
            hovered: hovered,
            pressed: pressed,
          ),
          child: _nodeContent(context, node),
        ),
      );

  BoxStyler _nodeActionStyle(
    BuildContext context, {
    required bool focused,
    required bool hovered,
    required bool pressed,
  }) {
    final layer = CarbonLayer.of(context);
    final background = pressed
        ? layer.color(.layerActive).resolve(context)
        : hovered
        ? layer.color(.layerHover).resolve(context)
        : const Color(0x00000000);

    return BoxStyler()
        .minHeight(CarbonSize.sm.height)
        .padding(.horizontal(CarbonTokens.spacing03()))
        .color(background)
        .border(
          BoxBorderMix.all(
            BorderSideMix(
              color: focused ? CarbonTokens.focus() : const Color(0x00000000),
              width: 2,
            ),
          ),
        )
        .alignment(.centerLeft);
  }

  Widget _nodeContent(BuildContext context, CarbonTreeNode<T> node) => Row(
    children: [
      if (node.leading != null) ...[
        node.leading!,
        SizedBox(width: CarbonTokens.spacing03.resolve(context)),
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
  );

  void _toggleExpanded(T id) {
    final next = <T>{..._expanded};
    next.contains(id) ? next.remove(id) : next.add(id);
    if (widget.expandedIds == null) setState(() => _ownedExpanded = next);
    widget.onExpandedChanged?.call(UnmodifiableSetView(next));
  }
}
