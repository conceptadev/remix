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

/// Carbon side-navigation landmark.
///
/// This remains Carbon-native because the declared hosted Remix floor does
/// not yet include `RemixSidebar`.
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

  @override
  Widget build(BuildContext context) => Semantics(
    role: .navigation,
    label: semanticLabel,
    container: true,
    explicitChildNodes: true,
    child: SizedBox(
      width: expanded ? 256 : 48,
      child: Box(
        style: BoxStyler().color(
          CarbonLayer.of(context).color(.layer).resolve(context),
        ),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: _CarbonSideNavScope(
                  expanded: expanded,
                  child: Column(crossAxisAlignment: .stretch, children: items),
                ),
              ),
            ),
            ?footer,
          ],
        ),
      ),
    ),
  );
}

class _CarbonSideNavScope extends InheritedWidget {
  const _CarbonSideNavScope({required this.expanded, required super.child});

  final bool expanded;

  static bool expandedOf(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<_CarbonSideNavScope>()
          ?.expanded ??
      true;

  @override
  bool updateShouldNotify(_CarbonSideNavScope oldWidget) =>
      expanded != oldWidget.expanded;
}

/// One destination in [CarbonSideNav].
class CarbonSideNavItem extends StatelessWidget {
  const CarbonSideNavItem({
    super.key,
    required this.label,
    this.leading,
    this.trailing,
    this.selected = false,
    this.enabled = true,
    this.onPressed,
    this.semanticLabel,
  });

  final String label;
  final Widget? leading;
  final Widget? trailing;
  final bool selected;
  final bool enabled;
  final VoidCallback? onPressed;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final expanded = _CarbonSideNavScope.expandedOf(context);

    return CarbonActionSurface(
      semanticLabel: semanticLabel ?? label,
      selected: selected,
      enabled: enabled,
      onPressed: onPressed,
      excludeChildSemantics: true,
      builder: (context, focused, hovered, pressed) => Box(
        style: BoxStyler()
            .height(48)
            .padding(.horizontal(CarbonTokens.spacing05()))
            .color(
              selected
                  ? CarbonLayer.of(
                      context,
                    ).color(.layerSelected).resolve(context)
                  : hovered || pressed
                  ? CarbonLayer.of(context).color(.layerHover).resolve(context)
                  : const Color(0x00000000),
            )
            .border(
              selected
                  ? BoxBorderMix.start(
                      BorderSideMix(
                        color: CarbonTokens.borderInteractive(),
                        width: 3,
                      ),
                    )
                  : BoxBorderMix.all(
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
            if (leading != null)
              SizedBox(width: 16, height: 16, child: leading),
            if (expanded) ...[
              if (leading != null)
                SizedBox(width: CarbonTokens.spacing05.resolve(context)),
              Expanded(
                child: StyledText(
                  label,
                  style: TextStyler()
                      .style(CarbonTokens.bodyCompact01.mix())
                      .color(
                        enabled
                            ? CarbonTokens.textPrimary()
                            : CarbonTokens.textDisabled(),
                      ),
                ),
              ),
              ?trailing,
            ],
          ],
        ),
      ),
    );
  }
}
