import 'package:flutter/widgets.dart';

import '../behavior/collapse_when_complete.dart';
import '../style/defaults.dart';
import 'marks.dart';

/// Expand / collapse for a working surface that should close when the run
/// settles. Not an accordion group.
class AgentDisclosure extends StatefulWidget {
  /// Creates a working-then-collapse disclosure.
  const AgentDisclosure({
    super.key,
    required this.working,
    required this.summary,
    required this.child,
    this.collapseOnComplete = true,
    this.open,
    this.defaultOpen = false,
    this.onOpenChange,
    this.semanticLabel,
  });

  /// True while the run is active. Active runs stay expanded.
  final bool working;

  /// Header shown always. Tapping it toggles after the run settles.
  final Widget summary;

  /// Body shown while expanded.
  final Widget child;

  /// When true, the body hides after [working] becomes false.
  final bool collapseOnComplete;

  /// Controlled expanded state. Null means the widget owns the state.
  final bool? open;

  /// Initial expanded state used after the run settles.
  final bool defaultOpen;

  /// Called when the operator toggles the disclosure.
  final ValueChanged<bool>? onOpenChange;

  /// Accessible name for the toggle.
  final String? semanticLabel;

  @override
  State<AgentDisclosure> createState() => _AgentDisclosureState();
}

class _AgentDisclosureState extends State<AgentDisclosure> {
  late var _userExpanded = widget.defaultOpen;

  bool get _expanded {
    return resolveCollapseWhenComplete(
      working: widget.working,
      collapseOnComplete: widget.collapseOnComplete,
      open: widget.open,
      defaultOpen: widget.defaultOpen,
      userExpanded: _userExpanded,
    );
  }

  void _toggle() {
    if (widget.working && widget.open == null) {
      return;
    }
    final next = !_expanded;
    if (widget.open == null) {
      setState(() => _userExpanded = next);
    }
    widget.onOpenChange?.call(next);
  }

  @override
  void didUpdateWidget(AgentDisclosure oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.working && !widget.working && widget.collapseOnComplete) {
      _userExpanded = widget.defaultOpen;
    }
    if (!oldWidget.working && widget.working) {
      _userExpanded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final expanded = _expanded;
    return _DisclosureExpanded(
      expanded: expanded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          FocusableActionDetector(
            enabled: !widget.working || widget.open != null,
            actions: <Type, Action<Intent>>{
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (_) {
                  _toggle();
                  return null;
                },
              ),
            },
            child: Semantics(
              button: !widget.working || widget.open != null,
              expanded: expanded,
              label: widget.semanticLabel,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _toggle,
                child: widget.summary,
              ),
            ),
          ),
          if (expanded) widget.child,
        ],
      ),
    );
  }
}

/// Resolved expand state for summaries that live inside [AgentDisclosure].
class _DisclosureExpanded extends InheritedWidget {
  const _DisclosureExpanded({required this.expanded, required super.child});

  final bool expanded;

  static bool? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_DisclosureExpanded>()
        ?.expanded;
  }

  @override
  bool updateShouldNotify(_DisclosureExpanded oldWidget) {
    return expanded != oldWidget.expanded;
  }
}

/// Compact one-line summary used by plan, activity, and execution.
class AgentDisclosureSummary extends StatelessWidget {
  /// Creates a summary row.
  const AgentDisclosureSummary({
    super.key,
    required this.title,
    this.meta,
    this.expanded = true,
  });

  final String title;
  final String? meta;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final shown = _DisclosureExpanded.maybeOf(context) ?? expanded;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          AgentChevron(expanded: shown),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: agentTitleOf(context))),
          if (meta != null) Text(meta!, style: agentMetaOf(context)),
        ],
      ),
    );
  }
}
