part of 'switch.dart';

/// Style builder for [RemixSwitch].
///
/// Use this class to style the switch track and thumb, including selected,
/// focused, disabled, hovered, and pressed state variants.
extension RemixSwitchStylerRemixHelpers on SwitchStyler {
  /// Sets thumb color
  SwitchStyler thumbColor(Color value) {
    return merge(
      SwitchStyler(
        thumb: BoxStyler(decoration: BoxDecorationMix(color: value)),
      ),
    );
  }

  /// Sets the track/rail background color.
  SwitchStyler trackColor(Color value) {
    return color(value);
  }
}
