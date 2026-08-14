// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carbon_button.dart';

// **************************************************************************
// MixWidgetGenerator
// **************************************************************************

/// A Carbon button recipe and generated [RemixButton] wrapper.
///
/// Consumes Carbon component and role tokens; resolves inside a `CarbonScope`.
/// Carbon buttons use square corners (radius 0) and the `body-compact-01` label
/// style. When [size] is null, height comes from `CarbonLayoutScope`, falling
/// back to Carbon's `lg` (48px), and is clamped to the supported `sm`–`2xl`
/// range.
///
/// Pass [loading] when the button renders a loading spinner: Remix folds
/// loading into the disabled widget-state, and a loading Carbon button keeps
/// its kind's colors (with a `textOnColor` spinner) instead of the disabled
/// gray treatment.
class CarbonButton extends StatelessWidget {
  const CarbonButton({
    super.key,
    this.kind = .primary,
    this.size,
    this.loading = false,
    required this.label,
    this.trailingIcon,
    this.enabled = true,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.enableFeedback = true,
    this.semanticLabel,
    this.semanticHint,
    this.excludeSemantics = false,
    this.mouseCursor = SystemMouseCursors.click,
  });

  final CarbonButtonKind kind;

  final CarbonSize? size;

  final bool loading;

  final String label;

  final IconData? trailingIcon;

  final bool enabled;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final FocusNode? focusNode;

  final bool autofocus;

  final bool enableFeedback;

  final String? semanticLabel;

  final String? semanticHint;

  final bool excludeSemantics;

  final MouseCursor mouseCursor;

  @override
  Widget build(BuildContext context) {
    return RemixButton(
      key: this.key,
      style: carbonButtonStyle(
        kind: this.kind,
        size: this.size,
        loading: this.loading,
      ),
      label: this.label,
      trailingIcon: this.trailingIcon,
      loading: this.loading,
      enabled: this.enabled,
      onPressed: this.onPressed,
      onLongPress: this.onLongPress,
      focusNode: this.focusNode,
      autofocus: this.autofocus,
      enableFeedback: this.enableFeedback,
      semanticLabel: this.semanticLabel,
      semanticHint: this.semanticHint,
      excludeSemantics: this.excludeSemantics,
      mouseCursor: this.mouseCursor,
    );
  }
}
