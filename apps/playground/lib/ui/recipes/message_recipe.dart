import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/button.dart';
import '../components/card.dart';
import '../components/message.dart';

@immutable
final class PlaygroundAgentMessageRecipe {
  const PlaygroundAgentMessageRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.collapsibleStyle,
    required this.toggleStyle,
  });
  final PlaygroundMessageStyler style;
  final CardStyler surfaceStyle;
  final PlaygroundMessageCollapsibleStyler collapsibleStyle;
  final ButtonStyler toggleStyle;
}

PlaygroundAgentMessageRecipe playgroundAgentMessageRecipe({
  PlaygroundMessageStyler style = const PlaygroundMessageStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  PlaygroundMessageCollapsibleStyler collapsibleStyle =
      const PlaygroundMessageCollapsibleStyler.create(),
  ButtonStyler toggleStyle = const ButtonStyler.create(),
}) => PlaygroundAgentMessageRecipe(
  style: PlaygroundMessageStyler(
    row: FlexBoxStyler().mainAxisSize(.max).spacing(8),
    avatar: BoxStyler().size(28, 28),
    header: BoxStyler().padding(.only(bottom: 6)),
    body: BoxStyler(),
    footer: BoxStyler().padding(.only(top: 4)),
    maxWidth: 640,
  ).merge(style),
  surfaceStyle: playgroundCardStyle(style: surfaceStyle),
  collapsibleStyle: PlaygroundMessageCollapsibleStyler(
    collapsedHeight: 72,
    container: BoxStyler(),
    clipped: BoxStyler(),
  ).merge(collapsibleStyle),
  toggleStyle: playgroundButtonStyle(
    variant: .ghost,
    size: .small,
    style: toggleStyle,
  ),
);
