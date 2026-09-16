import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/card.dart';
import '../components/composer.dart';
import '../components/icon_button.dart';
import '../components/textfield.dart';

@immutable
final class PlaygroundAgentComposerRecipe {
  const PlaygroundAgentComposerRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.fieldStyle,
    required this.submitStyle,
    required this.stopStyle,
  });
  final PlaygroundComposerStyler style;
  final CardStyler surfaceStyle;
  final TextFieldStyler fieldStyle;
  final IconButtonStyler submitStyle;
  final IconButtonStyler stopStyle;
}

PlaygroundAgentComposerRecipe playgroundAgentComposerRecipe({
  PlaygroundComposerStyler style = const PlaygroundComposerStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  TextFieldStyler fieldStyle = const TextFieldStyler.create(),
  IconButtonStyler submitStyle = const IconButtonStyler.create(),
  IconButtonStyler stopStyle = const IconButtonStyler.create(),
}) => PlaygroundAgentComposerRecipe(
  style: PlaygroundComposerStyler(
    toolbar: FlexBoxStyler()
        .direction(.horizontal)
        .mainAxisSize(.max)
        .crossAxisAlignment(.center)
        .spacing(8)
        .padding(.only(top: 8)),
  ).merge(style),
  surfaceStyle: playgroundCardStyle(
    style: CardStyler().padding(.all(12)).merge(surfaceStyle),
  ),
  fieldStyle: playgroundTextAreaStyle(
    style: TextFieldStyler()
        .color(const Color(0x00000000))
        .border(.style(.none))
        .minHeight(56)
        .padding(.all(4))
        .merge(fieldStyle),
  ),
  submitStyle: playgroundIconButtonStyle(
    size: .small,
    style: IconButtonStyler().size(48, 48).merge(submitStyle),
  ),
  stopStyle: playgroundIconButtonStyle(
    variant: .destructive,
    size: .small,
    style: IconButtonStyler().size(48, 48).merge(stopStyle),
  ),
);
