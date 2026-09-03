import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_action_surface.dart';

const _carbonExpandableTileLayer = ContextToken(
  _resolveCarbonExpandableTileLayer,
);
const _carbonExpandableTileHover = ContextToken(
  _resolveCarbonExpandableTileHover,
);
const _carbonExpandableTileActive = ContextToken(
  _resolveCarbonExpandableTileActive,
);
const _carbonExpandableTileBorder = ContextToken(
  _resolveCarbonExpandableTileBorder,
);

Color _resolveCarbonExpandableTileLayer(BuildContext context) =>
    CarbonLayer.of(context).color(.layer).resolve(context);

Color _resolveCarbonExpandableTileHover(BuildContext context) =>
    CarbonLayer.of(context).color(.layerHover).resolve(context);

Color _resolveCarbonExpandableTileActive(BuildContext context) =>
    CarbonLayer.of(context).color(.layerActive).resolve(context);

Color _resolveCarbonExpandableTileBorder(BuildContext context) =>
    CarbonLayer.of(context).color(.borderSubtle).resolve(context);

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
    final tile = _carbonTileStyle(context)(child: child);
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
    builder: (context, focused, hovered, pressed) => _carbonTileStyle(
      context,
      focused: focused,
      hovered: hovered,
      pressed: pressed,
    )(child: child),
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
    builder: (context, focused, hovered, pressed) =>
        _carbonTileStyle(
          context,
          focused: focused,
          hovered: hovered,
          pressed: pressed,
          selected: selected,
        )(
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
class CarbonExpandableTile extends StatelessWidget {
  const CarbonExpandableTile({
    super.key,
    required this.title,
    required this.child,
    this.expanded,
    this.initiallyExpanded = false,
    this.onExpandedChanged,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  });

  final String title;
  final Widget child;
  final bool? expanded;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpandedChanged;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => RemixDisclosure(
    trigger: ExcludeSemantics(
      child: StyledText(
        title,
        style: TextStyler()
            .style(CarbonTokens.headingCompact01.mix())
            .color(CarbonTokens.textPrimary()),
      ),
    ),
    triggerBuilder: (context, state, triggerChild) => Row(
      children: [
        Expanded(child: triggerChild!),
        ExcludeSemantics(
          child: StyledIcon(
            icon: state.isExpanded
                ? CarbonIcons.chevronUp
                : CarbonIcons.chevronDown,
            style: IconStyler()
                .size(CarbonTokens.iconSize01())
                .color(CarbonTokens.iconPrimary()),
          ),
        ),
      ],
    ),
    content: child,
    expanded: expanded,
    defaultExpanded: initiallyExpanded,
    onExpandedChanged: onExpandedChanged,
    enabled: enabled,
    focusNode: focusNode,
    autofocus: autofocus,
    semanticLabel: semanticLabel ?? title,
    style: carbonExpandableTileStyle(),
  );
}

final DisclosureStyler _carbonExpandableTileStyle = DisclosureStyler()
    .container(
      BoxStyler()
          .minHeight(64)
          .color(_carbonExpandableTileLayer())
          .border(
            BoxBorderMix.all(
              BorderSideMix(color: _carbonExpandableTileBorder(), width: 1),
            ),
          ),
    )
    .trigger(BoxStyler().minHeight(64).padding(.all(CarbonTokens.spacing05())))
    .content(
      BoxStyler().padding(
        EdgeInsetsGeometryMix.fromLTRB(
          CarbonTokens.spacing05(),
          0,
          CarbonTokens.spacing05(),
          CarbonTokens.spacing05(),
        ),
      ),
    )
    .onHovered(
      DisclosureStyler().trigger(
        BoxStyler().color(_carbonExpandableTileHover()),
      ),
    )
    .onPressed(
      DisclosureStyler().trigger(
        BoxStyler().color(_carbonExpandableTileActive()),
      ),
    )
    .onFocusVisible(
      DisclosureStyler().trigger(
        BoxStyler().foregroundDecoration(
          BoxDecorationMix(
            border: BoxBorderMix.all(
              BorderSideMix(color: CarbonTokens.focus(), width: 2),
            ),
          ),
        ),
      ),
    );

/// Carbon's token-backed visual recipe for [RemixDisclosure].
DisclosureStyler carbonExpandableTileStyle() => _carbonExpandableTileStyle;
