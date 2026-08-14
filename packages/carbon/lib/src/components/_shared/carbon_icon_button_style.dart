import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

/// Keeps a Carbon icon button's foreground stable across interaction states.
///
/// Carbon uses contextual icon colors for controls embedded in components,
/// while the general ghost-button recipe uses link colors. Component-owned
/// controls call this helper with the contextual token they need.
IconButtonStyler carbonIconButtonForegroundStyle(
  ColorToken foreground, {
  Color? hoveredBackground,
  Color? pressedBackground,
}) {
  final icon = IconStyler().color(foreground());
  final hovered = hoveredBackground == null
      ? IconButtonStyler().icon(icon)
      : IconButtonStyler().color(hoveredBackground).icon(icon);
  final pressed = pressedBackground == null
      ? IconButtonStyler().icon(icon)
      : IconButtonStyler().color(pressedBackground).icon(icon);

  return IconButtonStyler().icon(icon).onHovered(hovered).onPressed(pressed);
}
