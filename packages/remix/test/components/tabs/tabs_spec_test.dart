import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('tab specs provide the expected typed slots', () {
    const bar = RemixTabBarSpec();
    const tab = RemixTabSpec();
    const view = RemixTabViewSpec();

    expect(bar.container, const StyleSpec(spec: BoxSpec()));
    expect(tab.container, const StyleSpec(spec: FlexBoxSpec()));
    expect(tab.label, const StyleSpec(spec: TextSpec()));
    expect(tab.icon, const StyleSpec(spec: IconSpec()));
    expect(view.container, const StyleSpec(spec: BoxSpec()));
  });

  test('copyWith updates one slot without mutating the source', () {
    const original = RemixTabSpec();
    final label = StyleSpec(
      spec: const TextSpec(),
      animation: AnimationConfig.linear(const Duration(milliseconds: 100)),
    );

    final copy = original.copyWith(label: label);

    expect(copy.label, same(label));
    expect(copy.container, same(original.container));
    expect(copy.icon, same(original.icon));
    expect(original.label, isNot(same(label)));
  });

  test('lerp and value equality cover every slot', () {
    const first = RemixTabSpec();
    const second = RemixTabSpec();
    final result = first.lerp(second, 0.5);

    expect(first, second);
    expect(first.hashCode, second.hashCode);
    expect(result.props, [result.container, result.label, result.icon]);
  });

  test('all specs expose diagnostics', () {
    for (final spec in <Diagnosticable>[
      const RemixTabBarSpec(),
      const RemixTabSpec(),
      const RemixTabViewSpec(),
    ]) {
      expect(spec.toDiagnosticsNode().getProperties(), isNotEmpty);
    }
  });
}
