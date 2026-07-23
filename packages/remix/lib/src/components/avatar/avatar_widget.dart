part of 'avatar.dart';

/// Builder for rendering avatar label content with the resolved text spec.
typedef RemixAvatarLabelBuilder =
    Widget Function(BuildContext context, TextSpec spec, String label);

/// Builder for rendering avatar icon content with the resolved icon spec.
typedef RemixAvatarIconBuilder =
    Widget Function(BuildContext context, IconSpec spec, IconData? icon);

/// A customizable avatar component that can display an image, label, icon, or
/// custom child.
///
/// The [RemixAvatar] widget presents user or entity identity with optional
/// background and foreground images. Text and icon content can use builders to
/// preserve resolved Remix typography or icon styling.
///
/// ## Example
///
/// ```dart
/// RemixAvatar(
///   backgroundImage: NetworkImage('https://example.com/avatar.png'),
///   foregroundImage: NetworkImage('https://example.com/badge.png'),
///   label: 'User',
/// )
/// ```
class RemixAvatar extends StatelessWidget {
  /// Creates a Remix avatar with optional text [label], custom [child], and
  /// background/foreground imagery. When textual content is supplied, it is
  /// styled using the avatar text spec so typography stays consistent.
  const RemixAvatar({
    super.key,
    this.backgroundImage,
    this.foregroundImage,
    this.onBackgroundImageError,
    this.onForegroundImageError,
    this.child,
    this.label,
    this.labelBuilder,
    this.icon,
    this.iconBuilder,
    this.style = const RemixAvatarStyler.create(),
    this.styleSpec,
  });

  static final styleFrom = RemixAvatarStyler.new;

  /// The background image to display in the avatar.
  final ImageProvider? backgroundImage;

  /// The foreground image to display in the avatar.
  final ImageProvider? foregroundImage;

  /// Callback function called when the background image fails to load.
  final ImageErrorListener? onBackgroundImageError;

  /// Callback function called when the foreground image fails to load.
  final ImageErrorListener? onForegroundImageError;

  /// Custom content to display inside the avatar. When provided the caller is
  /// responsible for applying typography.
  final Widget? child;

  /// Optional text rendered within the avatar using the text spec.
  final String? label;

  /// Optional builder that exposes the resolved [TextSpec] for custom label
  /// rendering while keeping the configured typography.
  final RemixAvatarLabelBuilder? labelBuilder;

  /// Optional icon rendered when no [child] or [label] is provided.
  final IconData? icon;

  /// Optional builder that exposes the resolved [IconSpec] for custom icon
  /// rendering while preserving configured icon styling.
  final RemixAvatarIconBuilder? iconBuilder;

  /// The style configuration for the avatar.
  final RemixAvatarStyler style;

  /// Optional raw style spec that bypasses fluent style resolution.
  final RemixAvatarSpec? styleSpec;

  @override
  Widget build(BuildContext context) {
    return RemixStyleSpecBuilder<RemixAvatarSpec>(
      style: style,
      styleSpec: styleSpec,
      builder: (context, spec) {
        Widget? content = child;
        final resolvedLabel = label ?? '';

        if (content == null) {
          if (labelBuilder != null || label != null) {
            content = labelBuilder == null
                ? StyledText(resolvedLabel, styleSpec: spec.label)
                : StyleSpecBuilder<TextSpec>(
                    styleSpec: spec.label,
                    builder: (context, textSpec) =>
                        labelBuilder!(context, textSpec, resolvedLabel),
                  );
          } else if (iconBuilder != null || icon != null) {
            content = iconBuilder == null
                ? StyledIcon(icon: icon, styleSpec: spec.icon)
                : StyleSpecBuilder<IconSpec>(
                    styleSpec: spec.icon,
                    builder: (context, iconSpec) =>
                        iconBuilder!(context, iconSpec, icon),
                  );
          }
        }

        Widget current = content ?? const SizedBox.shrink();
        if (backgroundImage case final image?) {
          current = _RemixAvatarImageLayer(
            image: image,
            onError: onBackgroundImageError,
            fallback: current,
          );
        }
        if (foregroundImage case final image?) {
          current = Stack(
            fit: StackFit.passthrough,
            children: [
              current,
              Positioned.fill(
                child: _RemixAvatarImageLayer(
                  image: image,
                  onError: onForegroundImageError,
                  fallback: const SizedBox.expand(),
                ),
              ),
            ],
          );
        }

        return Box(
          styleSpec: spec.container,
          child: Container(alignment: .center, child: current),
        );
      },
    );
  }
}

/// Replaces [fallback] only after an image frame has decoded successfully.
/// Errors keep the fallback visible and are reported once per provider.
class _RemixAvatarImageLayer extends StatefulWidget {
  const _RemixAvatarImageLayer({
    required this.image,
    required this.fallback,
    this.onError,
  });

  final ImageProvider image;
  final Widget fallback;
  final ImageErrorListener? onError;

  @override
  State<_RemixAvatarImageLayer> createState() => _RemixAvatarImageLayerState();
}

class _RemixAvatarImageLayerState extends State<_RemixAvatarImageLayer> {
  bool _reportedError = false;

  @override
  void didUpdateWidget(_RemixAvatarImageLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image != widget.image) _reportedError = false;
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: widget.image,
      fit: BoxFit.cover,
      excludeFromSemantics: true,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (!wasSynchronouslyLoaded && frame == null) return widget.fallback;
        return Stack(
          fit: StackFit.passthrough,
          children: [
            Opacity(
              opacity: 0,
              alwaysIncludeSemantics: true,
              child: widget.fallback,
            ),
            Positioned.fill(child: child),
          ],
        );
      },
      errorBuilder: (context, error, stackTrace) {
        if (!_reportedError) {
          _reportedError = true;
          final onError = widget.onError;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) onError?.call(error, stackTrace);
          });
        }
        return widget.fallback;
      },
    );
  }
}
