import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

part 'carbon_tabs.g.dart';

/// Sizes supported by Carbon line tabs.
enum CarbonTabSize { small, medium }

const _carbonTabBorder = ContextToken(_resolveCarbonTabBorder);
const _carbonTabHoverBorder = ContextToken(_resolveCarbonTabHoverBorder);

Color _resolveCarbonTabBorder(BuildContext context) =>
    CarbonLayer.of(context).color(.borderSubtle).resolve(context);

Color _resolveCarbonTabHoverBorder(BuildContext context) =>
    CarbonLayer.of(context).color(.borderStrong).resolve(context);

/// Carbon tab-list recipe.
@MixWidget(target: RemixTabBar.new, widgetParameters: .only({'child'}))
TabBarStyler carbonTabBarStyle({Axis orientation = .horizontal}) =>
    .new().width(.infinity).direction(orientation).crossAxisAlignment(.center);

/// Carbon line-tab recipe.
@MixWidget(
  target: RemixTab.new,
  widgetParameters: .only({
    'tabId',
    'child',
    'label',
    'icon',
    'enabled',
    'mouseCursor',
    'enableFeedback',
    'focusNode',
    'autofocus',
    'onFocusChange',
    'onHoverChange',
    'onPressChange',
    'semanticLabel',
  }),
)
TabStyler carbonTabStyle({CarbonTabSize size = .medium}) {
  final height = switch (size) {
    .small => CarbonTokens.sizeSmall(),
    .medium => CarbonTokens.sizeMedium(),
  };
  final border = (Color color) =>
      BoxBorderMix.bottom(BorderSideMix(color: color, width: 2));

  return TabStyler()
      .container(
        FlexBoxStyler()
            .height(height)
            .padding(.horizontal(CarbonTokens.spacing05()))
            .direction(.horizontal)
            .crossAxisAlignment(.center)
            .spacing(CarbonTokens.spacing03())
            .border(border(_carbonTabBorder())),
      )
      .label(
        TextStyler()
            .style(CarbonTokens.bodyCompact01.mix())
            .color(CarbonTokens.textSecondary()),
      )
      .icon(
        IconStyler()
            .size(CarbonTokens.iconSize01())
            .color(CarbonTokens.iconSecondary()),
      )
      .onHovered(
        TabStyler()
            .container(.border(border(_carbonTabHoverBorder())))
            .label(.color(CarbonTokens.textPrimary()))
            .icon(.color(CarbonTokens.iconPrimary())),
      )
      .onSelected(
        TabStyler()
            .container(.border(border(CarbonTokens.borderInteractive())))
            .label(
              .style(
                CarbonTokens.headingCompact01.mix(),
              ).color(CarbonTokens.textPrimary()),
            )
            .icon(.color(CarbonTokens.iconPrimary())),
      )
      .onFocusVisible(
        TabStyler().container(
          .foregroundDecoration(
            BoxDecorationMix(
              border: BoxBorderMix.all(
                BorderSideMix(color: CarbonTokens.focus(), width: 2),
              ),
            ),
          ),
        ),
      )
      .onDisabled(
        TabStyler()
            .container(.border(border(CarbonTokens.borderDisabled())))
            .label(.color(CarbonTokens.textDisabled()))
            .icon(.color(CarbonTokens.iconDisabled())),
      );
}

/// Carbon tab-panel recipe.
@MixWidget(
  target: RemixTabView.new,
  widgetParameters: .only({'tabId', 'child', 'maintainState'}),
)
TabViewStyler carbonTabViewStyle() =>
    .new().padding(.all(CarbonTokens.spacing05()));

/// Coordinates Carbon tab triggers and panels using stable string ids.
class CarbonTabs extends StatelessWidget {
  const CarbonTabs({
    super.key,
    required this.child,
    required this.selectedTabId,
    this.onChanged,
    this.orientation = .horizontal,
    this.enabled = true,
    this.onEscapePressed,
  });

  final Widget child;
  final String selectedTabId;
  final ValueChanged<String>? onChanged;
  final Axis orientation;
  final bool enabled;
  final VoidCallback? onEscapePressed;

  @override
  Widget build(BuildContext context) => RemixTabs(
    selectedTabId: selectedTabId,
    onChanged: onChanged,
    orientation: orientation,
    enabled: enabled,
    onEscapePressed: onEscapePressed,
    child: child,
  );
}
