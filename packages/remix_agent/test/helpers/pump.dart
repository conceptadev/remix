import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

const _textStyle = TextStyle(
  color: Color(0xFF18181B),
  fontSize: 14,
  height: 1.4,
);

/// Pumps [child] under WidgetsApp.
///
/// [overlay] is off by default so host-capability tests can prove ordinary
/// surfaces build without one. Turn it on when a test focuses a text field;
/// Flutter's [EditableText] requires an Overlay for selection handles.
Future<void> pumpAgent(
  WidgetTester tester,
  Widget child, {
  Size surface = const Size(800, 600),
  bool disableAnimations = false,
  bool overlay = false,
}) async {
  await tester.binding.setSurfaceSize(surface);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  Widget hosted = DefaultTextStyle(
    style: _textStyle,
    child: ColoredBox(
      color: const Color(0xFFFFFFFF),
      child: Align(alignment: Alignment.topLeft, child: child),
    ),
  );
  if (overlay) {
    hosted = Overlay.wrap(child: hosted);
  }
  await tester.pumpWidget(
    MixScope.empty(
      child: MediaQuery(
        data: MediaQueryData(
          size: surface,
          disableAnimations: disableAnimations,
        ),
        child: WidgetsApp(
          color: const Color(0xFFFFFFFF),
          builder: (_, _) => hosted,
        ),
      ),
    ),
  );
}
