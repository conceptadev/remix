import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import 'ui/ui.dart';

/// Every styler one [AgentComposer] needs, in one value.
///
/// `AgentComposer` takes five stylers: its own anatomy through `style`, and
/// four unresolved child stylers for the card, the text area, and the send and
/// stop buttons. A single `@MixWidget` recipe cannot supply the other four,
/// because `AgentComposerSpec` holds only the toolbar. So the application
/// hands over a bundle instead, and the call site spreads it across the
/// parameters the widget already has.
///
/// The child stylers stay **unresolved** on purpose. Resolving a nested
/// `IconButtonSpec` here would freeze the button at one state and lose its own
/// hover, press, focus, and disabled fragments; `RemixIconButton` resolves
/// them against its own controller.
@immutable
class UiAgentComposerRecipe {
  /// Creates a bundle of the five stylers a composer takes.
  const UiAgentComposerRecipe({
    required this.style,
    required this.surfaceStyle,
    required this.fieldStyle,
    required this.submitStyle,
    required this.stopStyle,
  });

  /// The Agent-owned anatomy: the toolbar row under the field.
  final AgentComposerStyler style;

  /// The card the field and the toolbar share.
  final CardStyler surfaceStyle;

  /// The growable prompt field.
  final TextFieldStyler fieldStyle;

  /// The send button, shown while no run is live.
  final IconButtonStyler submitStyle;

  /// The stop button, which replaces send during a run.
  final IconButtonStyler stopStyle;
}

/// This application's Composer recipe.
///
/// It adds only Agent-specific geometry — the toolbar row, the card inset, and
/// the field's missing second box — and takes everything else from the
/// installed [uiCardStyle], [uiTextAreaStyle], and [uiIconButtonStyle]
/// recipes in `lib/ui/components/`. Editing one of those files changes this
/// composer with it, which is the whole point of installing them.
///
/// It is the one demo wired this way. The other seven surfaces still use the
/// local review-only stylers in `demos.dart`, which is the intermediate state
/// the package's ADR describes: prove one surface before converting eight.
///
/// Each parameter is merged **last** into its own styler, so a call site can
/// override any one surface without forking the bundle:
///
/// ```dart
/// final recipe = uiAgentComposerRecipe(
///   submitStyle: IconButtonStyler().color(const Color(0xFF7C3AED)),
/// );
/// ```
UiAgentComposerRecipe uiAgentComposerRecipe({
  AgentComposerStyler style = const AgentComposerStyler.create(),
  CardStyler surfaceStyle = const CardStyler.create(),
  TextFieldStyler fieldStyle = const TextFieldStyler.create(),
  IconButtonStyler submitStyle = const IconButtonStyler.create(),
  IconButtonStyler stopStyle = const IconButtonStyler.create(),
}) => UiAgentComposerRecipe(
  style: _toolbarStyle().merge(style),
  surfaceStyle: uiCardStyle(style: _surfaceStyle().merge(surfaceStyle)),
  fieldStyle: uiTextAreaStyle(style: _fieldStyle().merge(fieldStyle)),
  // Small, because the toolbar is a strip under the field rather than a row of
  // primary page actions.
  submitStyle: uiIconButtonStyle(size: .small, style: submitStyle),
  // `destructive` is the vocabulary's interrupt colour, and stop interrupts a
  // run. Reusing it keeps the composer inside the fifteen theme tokens.
  stopStyle: uiIconButtonStyle(
    variant: .destructive,
    size: .small,
    style: stopStyle,
  ),
);

/// Gap between the toolbar's controls, and between the toolbar and the field.
const _toolbarGap = 8.0;

/// Inset between the card edge and the field or toolbar.
///
/// Tighter than the card recipe's own 24: a composer is an input frame, and
/// the field inside it already carries the reading gutter.
const _surfacePadding = 8.0;

/// A fill that paints nothing.
const _transparent = Color(0x00000000);

/// The toolbar row: full width, controls pushed to the trailing edge.
///
/// `AgentComposer` puts a `Spacer` before the trailing slot, so the row has to
/// take the full main axis for that spacer to have anything to distribute.
AgentComposerStyler _toolbarStyle() => AgentComposerStyler(
  toolbar: FlexBoxStyler()
      .direction(.horizontal)
      .mainAxisSize(.max)
      .crossAxisAlignment(.center)
      .spacing(_toolbarGap)
      .padding(.only(top: _toolbarGap)),
);

/// The card, at the composer's tighter inset.
CardStyler _surfaceStyle() => CardStyler().padding(.all(_surfacePadding));

/// The field, with its own surface removed.
///
/// The card is already the frame, so the text area drops its fill, its border,
/// and its gutter rather than drawing a second box inside the first. Its
/// typography, hint colour, cursor colour, focus ring, and disabled fragment
/// all stay, which is what keeps this a recipe edit rather than a fork.
TextFieldStyler _fieldStyle() => TextFieldStyler()
    .color(_transparent)
    .border(.style(.none))
    .padding(.all(0));
