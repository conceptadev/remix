import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  testWidgets('hosted Mix preserves BoxShadow blurStyle end to end', (
    tester,
  ) async {
    const source = BoxShadow(
      color: Colors.black,
      offset: Offset(2, 3),
      blurRadius: 8,
      spreadRadius: 4,
      blurStyle: BlurStyle.inner,
    );
    final fromValue = BoxShadowMix.value(source);
    final equivalent = BoxShadowMix(
      color: Colors.black,
      offset: const Offset(2, 3),
      blurRadius: 8,
      spreadRadius: 4,
      blurStyle: BlurStyle.inner,
    );
    final merged = BoxShadowMix(color: Colors.red).merge(fromValue);

    expect(fromValue, equivalent);
    expect(fromValue.hashCode, equivalent.hashCode);
    expect(merged, isNot(equivalent));

    late BoxShadow resolved;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            resolved = merged.resolve(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(resolved, source);
    expect(resolved.blurStyle, BlurStyle.inner);
  });
}
