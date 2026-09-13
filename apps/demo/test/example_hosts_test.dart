import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../packages/remix/example/api/progress.0.dart'
    as progress_example;
import '../../../packages/remix/example/api/card.0.dart' as card_example;
import '../../../packages/remix/example/api/switch.0.dart' as switch_example;
import '../../../packages/remix/example/api/checkbox.0.dart'
    as checkbox_example;
import '../../../packages/remix/example/api/radio.0.dart' as radio_example;
import '../../../packages/remix/example/api/badge.0.dart' as badge_example;
import '../../../packages/remix/example/api/slider.0.dart' as slider_example;
import '../../../packages/remix/example/api/accordion.0.dart'
    as accordion_example;
import '../../../packages/remix/example/api/callout.0.dart' as callout_example;
import '../../../packages/remix/example/api/avatar.0.dart' as avatar_example;
import '../../../packages/remix/example/api/tooltip.0.dart' as tooltip_example;
import '../../../packages/remix/example/api/icon_button.0.dart'
    as icon_button_example;
import '../../../packages/remix/example/api/toggle.0.dart' as toggle_example;
import '../../../packages/remix/example/api/divider.0.dart' as divider_example;
import '../../../packages/remix/example/api/button.0.dart' as button_example;
import '../../../packages/remix/example/api/menu.0.dart' as menu_example;
import '../../../packages/remix/example/api/textfield.0.dart'
    as textfield_example;
import '../../../packages/remix/example/api/spinner.0.dart' as spinner_example;
import '../../../packages/remix/example/api/select.0.dart' as select_example;
import '../../../packages/remix/example/api/tabs.0.dart' as tabs_example;
import '../../../packages/remix_fortal/example/misc/radix_button_example.dart'
    as basic;
import '../../../packages/remix_fortal/example/misc/radix_button_comprehensive.dart'
    as comprehensive;

void main() {
  final examples = <String, VoidCallback>{
    'progress': progress_example.main,
    'card': card_example.main,
    'switch': switch_example.main,
    'checkbox': checkbox_example.main,
    'radio': radio_example.main,
    'badge': badge_example.main,
    'slider': slider_example.main,
    'accordion': accordion_example.main,
    'callout': callout_example.main,
    'avatar': avatar_example.main,
    'tooltip': tooltip_example.main,
    'icon_button': icon_button_example.main,
    'toggle': toggle_example.main,
    'divider': divider_example.main,
    'button': button_example.main,
    'menu': menu_example.main,
    'textfield': textfield_example.main,
    'spinner': spinner_example.main,
    'select': select_example.main,
    'tabs': tabs_example.main,
    'Fortal buttons': basic.main,
    'Fortal comprehensive': comprehensive.main,
  };
  for (final example in examples.entries) {
    testWidgets('${example.key} runs with a neutral host', (tester) async {
      tester.view.physicalSize = const Size(2400, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      // The avatar sample deliberately uses a remote image. Seed the image
      // cache so the host test stays deterministic and offline.
      if (example.key == 'avatar') {
        final recorder = ui.PictureRecorder();
        Canvas(recorder).drawRect(const Rect.fromLTWH(0, 0, 1, 1), Paint());
        final picture = recorder.endRecording();
        final image = await tester.runAsync(() => picture.toImage(1, 1));
        picture.dispose();
        PaintingBinding.instance.imageCache.putIfAbsent(
          const NetworkImage('https://i.pravatar.cc/150?img=48'),
          () => OneFrameImageStreamCompleter(
            Future.value(ImageInfo(image: image!)),
          ),
        );
        addTearDown(PaintingBinding.instance.imageCache.clear);
      }
      tester.binding.resetEpoch();
      example.value();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.byType(WidgetsApp), findsWidgets);
      expect(find.byType(MaterialApp), findsNothing);
      expect(find.byType(Navigator), findsWidgets);
      expect(find.byType(Overlay), findsWidgets);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }
}
