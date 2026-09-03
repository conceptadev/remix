import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_action_surface.dart';
import '../_shared/carbon_icon_button_style.dart';
import '../button/carbon_button.dart';

/// Carbon application shell that fixes the header above navigation/content.
class CarbonUiShell extends StatelessWidget {
  const CarbonUiShell({
    super.key,
    required this.header,
    required this.child,
    this.sideNav,
    this.background,
  });

  final CarbonHeader header;
  final CarbonSideNav? sideNav;
  final Widget child;
  final Color? background;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: background ?? CarbonTokens.background.resolve(context),
    child: Column(
      crossAxisAlignment: .stretch,
      children: [
        header,
        Expanded(
          child: Row(
            crossAxisAlignment: .stretch,
            children: [
              ?sideNav,
              Expanded(
                child: Semantics(role: .main, container: true, child: child),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Carbon's 48px global header.
class CarbonHeader extends StatelessWidget {
  const CarbonHeader({
    super.key,
    required this.productName,
    this.companyName,
    this.onProductPressed,
    this.onMenuPressed,
    this.navigation = const [],
    this.actions = const [],
    this.semanticLabel = 'Header',
  });

  final String productName;
  final String? companyName;
  final VoidCallback? onProductPressed;
  final VoidCallback? onMenuPressed;
  final List<Widget> navigation;
  final List<Widget> actions;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) => Semantics(
    role: .navigation,
    label: semanticLabel,
    container: true,
    explicitChildNodes: true,
    child: Box(
      style: BoxStyler()
          .height(48)
          .color(CarbonTokens.backgroundInverse())
          .border(
            BoxBorderMix.bottom(
              BorderSideMix(color: CarbonTokens.borderInverse(), width: 1),
            ),
          ),
      child: Row(
        children: [
          if (onMenuPressed != null)
            SizedBox.square(
              dimension: 48,
              child: CarbonIconButton(
                icon: CarbonIcons.menu,
                semanticLabel: 'Open navigation',
                kind: .ghost,
                size: .lg,
                onPressed: onMenuPressed,
                style: carbonIconButtonForegroundStyle(
                  CarbonTokens.textInverse,
                ),
              ),
            ),
          Expanded(
            child: CarbonActionSurface(
              semanticLabel: [companyName, productName].nonNulls.join(' '),
              onPressed: onProductPressed,
              excludeChildSemantics: true,
              builder: (context, focused, hovered, pressed) => Box(
                style: BoxStyler()
                    .height(48)
                    .padding(.horizontal(CarbonTokens.spacing05()))
                    .color(
                      hovered || pressed
                          ? CarbonTokens.backgroundInverseHover()
                          : const Color(0x00000000),
                    )
                    .border(
                      BoxBorderMix.all(
                        BorderSideMix(
                          color: focused
                              ? CarbonTokens.focusInverse()
                              : const Color(0x00000000),
                          width: 2,
                        ),
                      ),
                    )
                    .alignment(.centerLeft),
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    if (companyName != null) ...[
                      StyledText(
                        companyName!,
                        style: TextStyler()
                            .style(CarbonTokens.headingCompact01.mix())
                            .color(CarbonTokens.textInverse()),
                      ),
                      SizedBox(width: CarbonTokens.spacing02.resolve(context)),
                    ],
                    StyledText(
                      productName,
                      style: TextStyler()
                          .style(CarbonTokens.bodyCompact01.mix())
                          .color(CarbonTokens.textInverse()),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ...navigation,
          ...actions,
        ],
      ),
    ),
  );
}

const _carbonSideNavLayer = ContextToken(_resolveCarbonSideNavLayer);
const _carbonSideNavSelected = ContextToken(_resolveCarbonSideNavSelected);
const _carbonSideNavHover = ContextToken(_resolveCarbonSideNavHover);
const _carbonSideNavActive = ContextToken(_resolveCarbonSideNavActive);

Color _resolveCarbonSideNavLayer(BuildContext context) =>
    CarbonLayer.of(context).color(.layer).resolve(context);

Color _resolveCarbonSideNavSelected(BuildContext context) =>
    CarbonLayer.of(context).color(.layerSelected).resolve(context);

Color _resolveCarbonSideNavHover(BuildContext context) =>
    CarbonLayer.of(context).color(.layerHover).resolve(context);

Color _resolveCarbonSideNavActive(BuildContext context) =>
    CarbonLayer.of(context).color(.layerActive).resolve(context);

final Map<bool, SidebarStyler> _carbonSideNavStyles = {};

/// Carbon's token-backed visual recipe for [RemixSidebar].
SidebarStyler carbonSideNavStyle({bool expanded = true}) {
  return _carbonSideNavStyles.putIfAbsent(expanded, () {
    final destination = ToggleStyler()
        .height(48)
        .padding(.horizontal(CarbonTokens.spacing05()))
        .mainAxisSize(.max)
        .mainAxisAlignment(expanded ? .start : .center)
        .crossAxisAlignment(.center)
        .spacing(expanded ? CarbonTokens.spacing05() : 0)
        .color(const Color(0x00000000))
        .label(
          TextStyler()
              .style(CarbonTokens.bodyCompact01.mix())
              .color(CarbonTokens.textPrimary())
              .wrap(WidgetModifierConfig.visibility(expanded)),
        )
        .icon(
          IconStyler()
              .size(CarbonTokens.iconSize01())
              .color(CarbonTokens.iconPrimary()),
        )
        .onHovered(ToggleStyler().color(_carbonSideNavHover()))
        .onPressed(ToggleStyler().color(_carbonSideNavActive()))
        .onSelected(
          ToggleStyler()
              .color(_carbonSideNavSelected())
              .foregroundDecoration(
                BoxDecorationMix(
                  border: BoxBorderMix.left(
                    BorderSideMix(
                      color: CarbonTokens.borderInteractive(),
                      width: 4,
                    ),
                  ),
                ),
              ),
        )
        .onFocusVisible(
          ToggleStyler().foregroundDecoration(
            BoxDecorationMix(
              border: BoxBorderMix.all(
                BorderSideMix(color: CarbonTokens.focus(), width: 2),
              ),
            ),
          ),
        )
        .onDisabled(
          ToggleStyler()
              .label(TextStyler().color(CarbonTokens.textDisabled()))
              .icon(IconStyler().color(CarbonTokens.iconDisabled())),
        );

    return SidebarStyler(
      container: FlexBoxStyler()
          .width(expanded ? 256 : 48)
          .color(_carbonSideNavLayer()),
      destination: destination,
    );
  });
}

/// Carbon side-navigation landmark backed by [RemixSidebar].
class CarbonSideNav extends StatelessWidget {
  const CarbonSideNav({
    super.key,
    required this.items,
    this.expanded = true,
    this.footer,
    this.semanticLabel = 'Primary navigation',
  });

  final List<CarbonSideNavItem> items;
  final bool expanded;
  final Widget? footer;
  final String semanticLabel;

  int? get _selectedIndex {
    for (final (index, item) in items.indexed) {
      if (item.selected) return index;
    }

    return null;
  }

  bool _debugSelectionIsValid() {
    assert(
      items.where((item) => item.selected).length <= 1,
      'CarbonSideNav supports at most one selected item.',
    );

    return true;
  }

  @override
  Widget build(BuildContext context) {
    assert(_debugSelectionIsValid());

    return RemixSidebar<int>(
      sections: [
        RemixSidebarSection(
          destinations: [
            for (final (index, item) in items.indexed)
              RemixSidebarDestination(
                value: index,
                label: item.label,
                icon: item.icon,
                semanticLabel: item.semanticLabel,
                enabled: item.enabled && item.onPressed != null,
                focusNode: item.focusNode,
                autofocus: item.autofocus,
              ),
          ],
        ),
      ],
      selectedValue: _selectedIndex,
      onSelected: (index) => items.elementAtOrNull(index)?.onPressed?.call(),
      footer: footer,
      semanticLabel: semanticLabel,
      style: carbonSideNavStyle(expanded: expanded),
    );
  }
}

/// Declarative data for one destination in [CarbonSideNav].
@immutable
final class CarbonSideNavItem {
  const CarbonSideNavItem({
    required this.label,
    this.icon,
    this.selected = false,
    this.enabled = true,
    this.onPressed,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final bool enabled;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;
}
