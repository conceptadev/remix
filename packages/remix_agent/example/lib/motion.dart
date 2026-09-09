import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

// Same font-backed Lucide glyph as Agent's default. Importing the generated
// LucideIcons catalog retains thousands of unused font glyphs in a web build.
const _chevronDown = IconData(
  57453,
  fontFamily: 'Lucide',
  fontPackage: 'lucide_icons_flutter',
);

/// Application motion policy. Remix still owns disclosure size/fade behavior.
AnimationConfig? catalogMotion(BuildContext context, {bool quick = false}) =>
    // Mix beta.5 requires positive tween weights. Omit animation entirely
    // when motion is reduced instead of supplying a zero-duration tween.
    MediaQuery.disableAnimationsOf(context)
    ? null
    : AnimationConfig.easeOut(Duration(milliseconds: quick ? 120 : 200));

/// One rotating glyph for all of the catalog's disclosure builders.
Widget catalogChevron(BuildContext context, bool expanded) => ExcludeSemantics(
  child: Box(
    style: BoxStyler(
      animation: catalogMotion(context),
    ).rotate(expanded ? math.pi : 0),
    child: Icon(
      _chevronDown,
      size: 16,
      color: DefaultTextStyle.of(context).style.color,
    ),
  ),
);

/// A small entrance for a newly inserted turn item, without moving its layout.
///
/// Stable request keys keep an existing bubble from replaying on status or
/// theme changes. Reduced motion renders the final state on the first frame.
class CatalogEntrance extends StatefulWidget {
  const CatalogEntrance({super.key, required this.child});

  final Widget child;

  @override
  State<CatalogEntrance> createState() => _CatalogEntranceState();
}

class _CatalogEntranceState extends State<CatalogEntrance> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible || MediaQuery.disableAnimationsOf(context);
    return Box(
      style: BoxStyler(
        animation: catalogMotion(context),
      ).wrap(.opacity(visible ? 1 : 0).translate(x: 0, y: visible ? 0 : 8)),
      child: widget.child,
    );
  }
}
