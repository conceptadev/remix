import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_action_surface.dart';

CardStyler _carbonTileStyle(
  BuildContext context, {
  bool focused = false,
  bool hovered = false,
  bool pressed = false,
  bool selected = false,
}) {
  final layer = CarbonLayer.of(context);

  return CardStyler()
      .minHeight(64)
      .padding(.all(CarbonTokens.spacing05()))
      .color(
        pressed
            ? layer.color(.layerActive).resolve(context)
            : hovered
            ? layer.color(.layerHover).resolve(context)
            : layer.color(.layer).resolve(context),
      )
      .border(
        BoxBorderMix.all(
          BorderSideMix(
            color: focused
                ? CarbonTokens.focus.resolve(context)
                : selected
                ? CarbonTokens.borderInteractive.resolve(context)
                : layer.color(.borderSubtle).resolve(context),
            width: focused || selected ? 2 : 1,
          ),
        ),
      );
}

/// Static Carbon content tile.
class CarbonTile extends StatelessWidget {
  const CarbonTile({super.key, required this.child, this.semanticLabel});

  final Widget child;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tile = RemixCard(style: _carbonTileStyle(context), child: child);
    if (semanticLabel == null) return tile;

    return Semantics(label: semanticLabel, container: true, child: tile);
  }
}

/// Keyboard- and pointer-activatable Carbon tile.
class CarbonClickableTile extends StatelessWidget {
  const CarbonClickableTile({
    super.key,
    required this.child,
    required this.semanticLabel,
    this.onPressed,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
  });

  final Widget child;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) => CarbonActionSurface(
    semanticLabel: semanticLabel,
    onPressed: onPressed,
    enabled: enabled,
    focusNode: focusNode,
    autofocus: autofocus,
    excludeChildSemantics: true,
    builder: (context, focused, hovered, pressed) => RemixCard(
      style: _carbonTileStyle(
        context,
        focused: focused,
        hovered: hovered,
        pressed: pressed,
      ),
      child: child,
    ),
  );
}

/// Controlled single selectable Carbon tile.
class CarbonSelectableTile extends StatelessWidget {
  const CarbonSelectableTile({
    super.key,
    required this.child,
    required this.selected,
    required this.semanticLabel,
    this.onChanged,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
  });

  final Widget child;
  final bool selected;
  final String semanticLabel;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) => CarbonActionSurface(
    semanticLabel: semanticLabel,
    selected: selected,
    onPressed: onChanged == null ? null : () => onChanged!(!selected),
    enabled: enabled,
    focusNode: focusNode,
    autofocus: autofocus,
    excludeChildSemantics: true,
    builder: (context, focused, hovered, pressed) => RemixCard(
      style: _carbonTileStyle(
        context,
        focused: focused,
        hovered: hovered,
        pressed: pressed,
        selected: selected,
      ),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(child: child),
          SizedBox(width: CarbonTokens.spacing05.resolve(context)),
          ExcludeSemantics(
            child: Icon(
              selected
                  ? CarbonIcons.checkboxCheckedFilled
                  : CarbonIcons.checkbox,
              size: CarbonTokens.iconSize01.resolve(context),
              color:
                  (selected
                          ? CarbonTokens.iconInteractive
                          : CarbonTokens.iconSecondary)
                      .resolve(context),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Carbon tile whose disclosure can be controlled or internally owned.
class CarbonExpandableTile extends StatefulWidget {
  const CarbonExpandableTile({
    super.key,
    required this.title,
    required this.child,
    this.expanded,
    this.initiallyExpanded = false,
    this.onExpandedChanged,
    this.enabled = true,
    this.semanticLabel,
  });

  final String title;
  final Widget child;
  final bool? expanded;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final bool enabled;
  final String? semanticLabel;

  @override
  State<CarbonExpandableTile> createState() => _CarbonExpandableTileState();
}

class _CarbonExpandableTileState extends State<CarbonExpandableTile> {
  late bool _internalExpanded;

  bool get _expanded => widget.expanded ?? _internalExpanded;

  @override
  void initState() {
    super.initState();
    _internalExpanded = widget.initiallyExpanded;
  }

  void _toggle() {
    final next = !_expanded;
    if (widget.expanded == null) setState(() => _internalExpanded = next);
    widget.onExpandedChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) => RemixCard(
    style: _carbonTileStyle(context).padding(.all(0)),
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        CarbonActionSurface(
          semanticLabel: widget.semanticLabel ?? widget.title,
          expanded: _expanded,
          enabled: widget.enabled,
          onPressed: _toggle,
          builder: (context, focused, hovered, pressed) => Box(
            style: BoxStyler()
                .minHeight(64)
                .padding(.all(CarbonTokens.spacing05()))
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
                ),
            child: Row(
              children: [
                Expanded(
                  child: ExcludeSemantics(
                    child: StyledText(
                      widget.title,
                      style: TextStyler()
                          .style(CarbonTokens.headingCompact01.mix())
                          .color(CarbonTokens.textPrimary()),
                    ),
                  ),
                ),
                ExcludeSemantics(
                  child: Icon(
                    _expanded ? CarbonIcons.chevronUp : CarbonIcons.chevronDown,
                    size: CarbonTokens.iconSize01.resolve(context),
                    color: CarbonTokens.iconPrimary.resolve(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_expanded)
          Padding(
            padding: .fromLTRB(
              CarbonTokens.spacing05.resolve(context),
              0,
              CarbonTokens.spacing05.resolve(context),
              CarbonTokens.spacing05.resolve(context),
            ),
            child: widget.child,
          ),
      ],
    ),
  );
}
