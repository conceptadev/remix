import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('RemixSpinnerStyler', () {
    testWidgets('resolves every leaf-spinner visual field', (tester) async {
      final style = RemixSpinnerStyler(
        size: 24,
        color: Colors.red,
        opacity: 0.65,
        leafRadius: const Radius.circular(3),
        duration: const Duration(milliseconds: 800),
      );

      late RemixSpinnerSpec resolved;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              resolved = style.resolve(context).spec;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(resolved.size, 24);
      expect(resolved.color, Colors.red);
      expect(resolved.opacity, 0.65);
      expect(resolved.leafRadius, const Radius.circular(3));
      expect(resolved.duration, const Duration(milliseconds: 800));
    });

    test('merge is immutable and preserves unrelated fields', () {
      final base = RemixSpinnerStyler(size: 24, opacity: 0.65);
      final merged = base.merge(RemixSpinnerStyler(color: Colors.red));

      expect(base.$color, isNull);
      expect(merged.$size, base.$size);
      expect(merged.$opacity, base.$opacity);
      expect(merged.$color, isNotNull);
    });

    test('call forwards loading, child, and semantic fields', () {
      final styler = RemixSpinnerStyler(size: 24);
      const child = Text('Save');
      final spinner = styler(
        loading: false,
        child: child,
        semanticLabel: 'Saving',
        excludeSemantics: true,
      );

      expect(spinner.loading, isFalse);
      expect(spinner.child, same(child));
      expect(spinner.semanticLabel, 'Saving');
      expect(spinner.excludeSemantics, isTrue);
      expect(spinner.style, same(styler));
    });
  });
}
