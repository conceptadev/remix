import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

/// Builds a rounded panel whose visible frame paints above its children.
///
/// Composite surfaces often contain edge-to-edge child backgrounds. A regular
/// [BoxDecoration] border paints behind those children, so their antialiased
/// rounded edges can partially cover the frame. This keeps the fill and clip on
/// the background decoration, reserves the same inset explicitly, and paints
/// the frame through the container's foreground decoration.
BoxStyler fortalSurfaceFrame({
  required Color fillColor,
  required Color borderColor,
  required double borderWidth,
  required Radius radius,
}) {
  final borderRadius = BorderRadiusMix.all(radius);
  return BoxStyler()
      .color(fillColor)
      .padding(.all(borderWidth))
      .borderRadius(borderRadius)
      .clipBehavior(.antiAlias)
      .foregroundDecoration(
        BoxDecorationMix(
          border: BoxBorderMix.all(
            BorderSideMix(color: borderColor, width: borderWidth),
          ),
          borderRadius: borderRadius,
        ),
      );
}
