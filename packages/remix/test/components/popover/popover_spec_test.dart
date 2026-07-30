import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixPopoverSpec', () {
    test('provides an empty container spec by default', () {
      const spec = RemixPopoverSpec();

      expect(spec.container, isA<StyleSpec<BoxSpec>>());
      expect(spec.props, [spec.container, spec.containerEffects]);
    });

    test('accepts and copies a custom container spec', () {
      const container = StyleSpec(
        spec: BoxSpec(
          constraints: BoxConstraints(minWidth: 240, maxWidth: 240),
        ),
      );
      const spec = RemixPopoverSpec(container: container);

      final copy = spec.copyWith();

      expect(spec.container, same(container));
      expect(copy, equals(spec));
      expect(copy, isNot(same(spec)));
    });

    test('interpolates container specs', () {
      const start = RemixPopoverSpec(
        container: StyleSpec(
          spec: BoxSpec(
            constraints: BoxConstraints(minWidth: 100, maxWidth: 100),
          ),
        ),
      );
      const end = RemixPopoverSpec(
        container: StyleSpec(
          spec: BoxSpec(
            constraints: BoxConstraints(minWidth: 200, maxWidth: 200),
          ),
        ),
      );

      expect(start.lerp(end, 0), equals(start));
      expect(start.lerp(end, 1), equals(end));
    });

    test('supports diagnostics', () {
      const spec = RemixPopoverSpec();

      expect(
        () => spec.debugFillProperties(DiagnosticPropertiesBuilder()),
        returnsNormally,
      );
      expect(spec.toString(), contains('container'));
    });
  });
}
