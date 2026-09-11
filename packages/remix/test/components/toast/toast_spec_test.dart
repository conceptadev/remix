import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('ToastSpec', () {
    test('defaults every region to an empty spec', () {
      const spec = ToastSpec();

      expect(spec.container.spec, const FlexBoxSpec());
      expect(spec.content.spec, const FlexBoxSpec());
      expect(spec.title.spec, const TextSpec());
      expect(spec.description.spec, const TextSpec());
      expect(spec.icon.spec, const IconSpec());
      expect(spec.action, isNull);
      expect(spec.closeButton, isNull);
      expect(spec.containerEffects, isNull);
      expect(spec, const ToastSpec());
    });

    test('copyWith replaces composed control styles', () {
      final action = ButtonStyler().height(8);
      final closeButton = IconButtonStyler().size(20, 20);

      final spec = const ToastSpec().copyWith(
        action: action,
        closeButton: closeButton,
      );

      expect(spec.action, same(action));
      expect(spec.closeButton, same(closeButton));
    });

    test('lerp snaps composed styles and interpolates effects', () {
      final start = ToastSpec(
        action: ButtonStyler().height(4),
        containerEffects: const RemixBoxEffectsSpec(backdropBlur: 0),
      );
      final end = ToastSpec(
        action: ButtonStyler().height(12),
        containerEffects: const RemixBoxEffectsSpec(backdropBlur: 10),
      );

      expect(start.lerp(end, 0.25).action, same(start.action));
      expect(start.lerp(end, 0.75).action, same(end.action));
      expect(start.lerp(end, 0.5).containerEffects?.backdropBlur, 5);
    });
  });
}
