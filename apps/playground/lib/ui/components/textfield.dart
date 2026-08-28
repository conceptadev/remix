// `DragStartBehavior` and `MaxLengthEnforcement` appear in the generated
// constructors below, so they have to be visible from this library even though
// nothing written here names them.
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';

part 'textfield.g.dart';

/// The control densities this application offers for a text input.
///
/// The same 32/36/40px heights the button uses, so a field and the button
/// that submits it line up in a row.
///
/// These are compact, web-oriented defaults. A touch-first application should
/// raise them to meet platform hit-target guidance.
enum PlaygroundTextFieldSize {
  /// 32px minimum height.
  small,

  /// 36px minimum height. The default.
  medium,

  /// 40px minimum height.
  large,
}

/// The application's TextField recipe.
///
/// Remix owns the rendering, the editing behavior, the label/hint/helper
/// composition, focus, selection, and the input accessibility semantics —
/// including announcing the error state. This recipe supplies the surface, the
/// text colors, and the focus/error/disabled fragments.
///
/// There is deliberately no hover fragment, unlike the select trigger this
/// otherwise matches. A select is a button that opens something, so it has to
/// say "I am pressable"; a text field's affordance is the I-beam cursor Remix
/// already sets, and tinting the box on hover would only compete with the
/// focus ring that follows a moment later.
///
/// One host requirement travels with it: `EditableText` asserts on an
/// `Overlay` ancestor the moment the field takes focus, for its selection
/// handles and magnifier. Any application with a `Navigator` — `MaterialApp`,
/// `CupertinoApp`, or a `WidgetsApp` with routes — already has one. A bare
/// `WidgetsApp(builder: ...)` does not, and has to supply an `Overlay` itself.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it. State fragments merge by state, not
/// by depth: an override that must beat the recipe's error outline has to be
/// declared as an error fragment too.
@MixWidget(target: RemixTextField.new)
TextFieldStyler playgroundTextFieldStyle({
  PlaygroundTextFieldSize size = .medium,
  TextFieldStyler style = const TextFieldStyler.create(),
}) {
  final metrics = _metricsFor(size);

  return _base(metrics)
      .minHeight(metrics.minHeight)
      // A single line sits on the field's centre line; the accessories go with
      // it.
      .crossAxisAlignment(.center)
      .merge(style);
}

/// The application's TextArea recipe.
///
/// `RemixTextArea` is `RemixTextField` with multi-line defaults, and it shares
/// the same styler, so this is the field's recipe with two changes: a taller
/// resting box, and accessories pinned to the first line instead of floating
/// in the middle of a growing one.
///
/// [style] is merged **last**, exactly as it is for the single-line field.
@MixWidget(target: RemixTextArea.new)
TextFieldStyler playgroundTextAreaStyle({
  PlaygroundTextFieldSize size = .medium,
  TextFieldStyler style = const TextFieldStyler.create(),
}) {
  final metrics = _metricsFor(size);

  return _base(metrics)
      .minHeight(metrics.minHeight * _textAreaLines)
      .padding(.symmetric(horizontal: _paddingX, vertical: _paddingY))
      .crossAxisAlignment(.start)
      .merge(style);
}

/// Resting height of a text area, as a multiple of one field's height.
///
/// `RemixTextArea` defaults to `minLines: 2`, so anything less would let the
/// box grow the moment a second line arrives.
const _textAreaLines = 2.5;

/// Horizontal inset between the field edge and its content.
///
/// Flat across the sizes, unlike the button's 12/16/20. A button's padding is
/// what gives its label room to breathe, so it grows with the control; a
/// field's is the gutter before the text cursor, and a wider gutter at a
/// larger size just moves the caret away from the edge the reader clicked.
/// The select trigger uses the same value for the same reason.
const _paddingX = 12.0;

/// Vertical inset, used only by the text area: a single-line field centres its
/// content instead.
const _paddingY = 10.0;

/// Gap between the field and its leading or trailing accessory.
const _accessoryGap = 8.0;

/// Gap between the label, the field, and the helper line.
const _stackGap = 6.0;

/// Label size, one step below the value it names.
const _labelSize = 13.0;

/// Width of the field outline.
const _borderWidth = 1.0;

/// Width of the keyboard focus ring.
const _focusRingWidth = 2.0;

/// Distance between the field edge and its focus ring.
const _focusRingOffset = 2.0;

/// Opacity applied to the whole control while disabled.
const _disabledOpacity = 0.5;

/// Geometry and type scale for one [PlaygroundTextFieldSize].
typedef _PlaygroundTextFieldMetrics = ({double minHeight, double textSize});

_PlaygroundTextFieldMetrics _metricsFor(PlaygroundTextFieldSize size) =>
    switch (size) {
      .small => (minHeight: 32.0, textSize: 14.0),
      .medium => (minHeight: 36.0, textSize: 14.0),
      .large => (minHeight: 40.0, textSize: 16.0),
    };

/// The surface, the four text roles, and every state fragment.
///
/// Both recipes share this whole body; only the box's height and the
/// accessory alignment differ between them.
TextFieldStyler _base(_PlaygroundTextFieldMetrics metrics) => TextFieldStyler()
    .color(PlaygroundTokens.background())
    .border(.color(PlaygroundTokens.border()).width(_borderWidth))
    .borderRadius(.all(PlaygroundTokens.radius()))
    .padding(.horizontal(_paddingX))
    .spacing(_accessoryGap)
    .text(.fontSize(metrics.textSize).color(PlaygroundTokens.foreground()))
    // The placeholder is not the value: it has to read as the quieter of the
    // two, or an empty field looks filled in.
    .hintText(
      .fontSize(metrics.textSize).color(PlaygroundTokens.mutedForeground()),
    )
    .cursorColor(PlaygroundTokens.foreground())
    .label(
      .fontSize(
        _labelSize,
      ).fontWeight(FontWeight.w500).color(PlaygroundTokens.foreground()),
    )
    .helperText(.fontSize(_labelSize).color(PlaygroundTokens.mutedForeground()))
    .layout(.direction(.vertical).spacing(_stackGap))
    .onFocusVisible(_focusVisibleStyle())
    .merge(_errorStyle())
    .onDisabled(_disabledStyle());

/// The keyboard focus ring.
///
/// An outline rather than a border: `RemixBoxEffects` paints it outside the
/// box without taking layout space, so focusing a field never reflows the form
/// it sits in — and the field already has a border of its own.
TextFieldStyler _focusVisibleStyle() => TextFieldStyler().containerEffects(
  .outline(
    .color(
      PlaygroundTokens.focusRing(),
    ).width(_focusRingWidth).strokeAlign(BorderSide.strokeAlignInside),
  ).outlineOffset(_focusRingOffset),
);

/// The invalid field: a `destructive` outline and a `destructive` helper line.
///
/// Spelled with `variant` rather than one of the `on…` helpers because Mix
/// ships no `onError`; the state itself is a standard `WidgetState` that
/// `RemixTextField` drives from its own `error` flag.
///
/// The text stays readable. `destructive` is a fill color chosen to sit under
/// `destructiveForeground`, and on the dark theme's page it measures 4.1:1 —
/// under the 4.5:1 WCAG floor for body copy. So the outline carries the tone,
/// where the floor is 3:1, and the message that explains the problem is set in
/// `foreground` and made a little heavier. Remix announces the error to
/// assistive technology either way.
///
/// A theme with a dedicated danger *text* step would put it on the helper
/// line here; this vocabulary has fifteen tokens and no such step.
TextFieldStyler _errorStyle() => TextFieldStyler().variant(
  ContextVariant.widgetState(.error),
  TextFieldStyler()
      .border(.color(PlaygroundTokens.destructive()).width(_borderWidth))
      .helperText(
        .color(PlaygroundTokens.foreground()).fontWeight(FontWeight.w500),
      ),
);

/// Declared last so it wins over every other state fragment.
///
/// A disabled field keeps its surface and simply fades; the focus ring is
/// cleared because a disabled control that still draws a focus ring reads as
/// editable.
TextFieldStyler _disabledStyle() => TextFieldStyler()
    .containerEffects(.outline(.style(.none)))
    .wrap(.opacity(_disabledOpacity));
