import 'package:flutter/widgets.dart';
import 'package:mix_annotations/mix_annotations.dart';
import 'package:remix/remix.dart';

import '../theme/tokens.dart';
import 'button.dart';
import 'icon_button.dart';

part 'toast.g.dart';

/// The tones this application offers for a toast.
enum PlaygroundToastVariant {
  /// An ordinary confirmation or notice.
  neutral,

  /// A failure the reader should notice.
  ///
  /// Visual only. Pair it with `RemixToastPriority.assertive` when the message
  /// must interrupt a screen reader; a red outline alone announces nothing.
  destructive,
}

/// The application's Toast recipe.
///
/// Remix owns the queue, the timers, focus, and the announcement through
/// `RemixToastScope`; this recipe owns the surface, the type, and the colors.
/// Hand it to the scope once, below the app's `Overlay`:
///
/// ```dart
/// MaterialApp(
///   home: RemixToastScope(style: playgroundToastStyle(), child: const Shell()),
/// )
/// ```
///
/// One toast can switch tone through `RemixToastData.style`, which merges over
/// the scope's style:
///
/// ```dart
/// showRemixToast(
///   context,
///   RemixToastData(
///     title: 'Upload failed',
///     priority: RemixToastPriority.assertive,
///     style: playgroundToastStyle(variant: .destructive),
///   ),
/// );
/// ```
///
/// The action and the close button reuse this application's Button and
/// IconButton recipes, so they keep their own hover, focus, and press states.
///
/// [style] is merged **last**, so a single call site can override any part of
/// the resolved recipe without forking it.
@MixWidget(target: RemixToast.new)
ToastStyler playgroundToastStyle({
  PlaygroundToastVariant variant = .neutral,
  ToastStyler style = const ToastStyler.create(),
}) => _base().merge(_variantStyle(variant)).merge(style);

/// Inset between the toast edge and its content.
const _padding = 16.0;

/// Gap between the icon, the message, and the controls.
const _gap = 12.0;

/// Gap between the title and the description.
const _textGap = 4.0;

/// Widest a toast grows. Narrow screens shrink it further.
const _maxWidth = 360.0;

const _titleSize = 14.0;

const _descriptionSize = 13.0;

const _iconSize = 16.0;

const _borderWidth = 1.0;

/// A toast floats over content that keeps scrolling beneath it, so it gets
/// the same lift as a dialog.
final _shadow = BoxShadowMix(
  color: const Color(0x26000000),
  offset: const Offset(0, 8),
  blurRadius: 24,
);

/// Surface, layout, and typography shared by both tones.
ToastStyler _base() => ToastStyler()
    .color(PlaygroundTokens.background())
    .border(.color(PlaygroundTokens.border()).width(_borderWidth))
    .borderRadius(.all(PlaygroundTokens.radius()))
    .padding(.all(_padding))
    .maxWidth(_maxWidth)
    .shadow(_shadow)
    .spacing(_gap)
    .content(FlexBoxStyler().spacing(_textGap))
    .title(
      .fontSize(
        _titleSize,
      ).fontWeight(FontWeight.w600).color(PlaygroundTokens.foreground()),
    )
    .description(
      .fontSize(_descriptionSize).color(PlaygroundTokens.mutedForeground()),
    )
    .icon(.size(_iconSize))
    .action(playgroundButtonStyle(variant: .outline, size: .small))
    .closeButton(playgroundIconButtonStyle(variant: .ghost, size: .small));

/// The tone shows in the glyph and, for `destructive`, the outline. The
/// sentence stays in `foreground` for contrast.
ToastStyler _variantStyle(PlaygroundToastVariant variant) => switch (variant) {
  .neutral => ToastStyler().icon(.color(PlaygroundTokens.mutedForeground())),
  .destructive =>
    ToastStyler()
        .border(.color(PlaygroundTokens.destructive()))
        .icon(.color(PlaygroundTokens.destructive())),
};
