import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

part 'carbon_modal.g.dart';

enum CarbonModalSize { small, medium, large }

const _carbonModalLayer = ContextToken(_resolveCarbonModalLayer);

Color _resolveCarbonModalLayer(BuildContext context) =>
    CarbonLayer.of(context).color(.layer).resolve(context);

/// Carbon modal recipe generated over [RemixDialog].
@MixWidget(target: _CarbonModalBase.new)
DialogStyler carbonModalStyle({CarbonModalSize size = .medium}) {
  final width = switch (size) {
    .small => 320.0,
    .medium => 480.0,
    .large => 640.0,
  };

  return DialogStyler()
      .width(width)
      .maxWidth(width)
      .maxHeight(720)
      .padding(.all(CarbonTokens.spacing07()))
      .color(_carbonModalLayer())
      .title(
        .style(CarbonTokens.heading03.mix())
            .color(CarbonTokens.textPrimary())
            .wrap(
              WidgetModifierConfig.padding(.bottom(CarbonTokens.spacing05())),
            ),
      )
      .description(
        .style(CarbonTokens.body01.mix()).color(CarbonTokens.textSecondary()),
      )
      .actions(
        .mainAxisAlignment(.end)
            .crossAxisAlignment(.center)
            .spacing(CarbonTokens.spacing03())
            .margin(.top(CarbonTokens.spacing07())),
      )
      .decoration(
        BoxDecorationMix.boxShadow([
          BoxShadowMix(
            color: CarbonTokens.shadow(),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ]),
      );
}

class _CarbonModalBase extends StatelessWidget {
  const _CarbonModalBase({
    super.key,
    this.child,
    this.title,
    this.description,
    this.actions,
    this.scrollable = false,
    this.modal = true,
    this.semanticLabel,
    this.style = const DialogStyler.create(),
  });

  final Widget? child;
  final String? title;
  final String? description;
  final List<Widget>? actions;
  final bool scrollable;
  final bool modal;
  final String? semanticLabel;
  final DialogStyler style;

  @override
  Widget build(BuildContext context) => Semantics(
    role: .dialog,
    label: semanticLabel ?? title,
    container: true,
    explicitChildNodes: true,
    child: RemixDialog(
      child: child,
      title: title,
      description: description,
      actions: actions,
      scrollable: scrollable,
      modal: modal,
      semanticLabel: semanticLabel,
      style: style,
    ),
  );
}

/// Shows a Carbon modal while preserving the active token scope.
Future<T?> showCarbonModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? barrierColor,
  bool barrierDismissible = true,
  String? barrierLabel,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  Duration transitionDuration = const Duration(milliseconds: 240),
  RouteTransitionsBuilder? transitionBuilder,
  bool requestFocus = true,
  TraversalEdgeBehavior? traversalEdgeBehavior,
}) => showRemixDialog(
  context: context,
  builder: builder,
  barrierColor: barrierColor,
  barrierDismissible: barrierDismissible,
  barrierLabel: barrierLabel,
  useRootNavigator: useRootNavigator,
  routeSettings: routeSettings,
  anchorPoint: anchorPoint,
  transitionDuration: transitionDuration,
  transitionBuilder: transitionBuilder,
  requestFocus: requestFocus,
  traversalEdgeBehavior: traversalEdgeBehavior,
);

/// Shows an urgent Carbon alert modal with a required accessible name.
Future<T?> showCarbonAlertModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required String semanticLabel,
  Color? barrierColor,
  String? barrierLabel,
  bool barrierDismissible = false,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  Duration transitionDuration = const Duration(milliseconds: 240),
  RouteTransitionsBuilder? transitionBuilder,
  FocusNode? initialFocusNode,
}) => showRemixAlertDialog(
  context: context,
  builder: builder,
  semanticLabel: semanticLabel,
  barrierColor: barrierColor,
  barrierLabel: barrierLabel,
  barrierDismissible: barrierDismissible,
  useRootNavigator: useRootNavigator,
  routeSettings: routeSettings,
  anchorPoint: anchorPoint,
  transitionDuration: transitionDuration,
  transitionBuilder: transitionBuilder,
  initialFocusNode: initialFocusNode,
);
