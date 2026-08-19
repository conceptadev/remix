import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

void main() {
  group('LiveEdgePolicy', () {
    test('isNearEnd uses the threshold', () {
      final policy = LiveEdgePolicy(threshold: 56);
      expect(
        policy.isNearEnd(
          FixedScrollMetrics(
            pixels: 944,
            minScrollExtent: 0,
            maxScrollExtent: 1000,
            viewportDimension: 200,
            axisDirection: AxisDirection.down,
            devicePixelRatio: 1,
          ),
        ),
        isTrue,
      );
      expect(
        policy.isNearEnd(
          FixedScrollMetrics(
            pixels: 800,
            minScrollExtent: 0,
            maxScrollExtent: 1000,
            viewportDimension: 200,
            axisDirection: AxisDirection.down,
            devicePixelRatio: 1,
          ),
        ),
        isFalse,
      );
    });

    test('user scroll away releases follow and return re-attaches', () {
      final flips = <bool>[];
      final policy = LiveEdgePolicy(onFollowChange: flips.add);
      final away = FixedScrollMetrics(
        pixels: 200,
        minScrollExtent: 0,
        maxScrollExtent: 1000,
        viewportDimension: 200,
        axisDirection: AxisDirection.down,
        devicePixelRatio: 1,
      );
      final edge = FixedScrollMetrics(
        pixels: 980,
        minScrollExtent: 0,
        maxScrollExtent: 1000,
        viewportDimension: 200,
        axisDirection: AxisDirection.down,
        devicePixelRatio: 1,
      );

      policy.handleUserScroll(away);
      expect(policy.following, isFalse);
      policy.handleUserScroll(edge);
      expect(policy.following, isTrue);
      expect(flips, [false, true]);
    });

    test('programmatic latch ignores user-scroll handling', () {
      final policy = LiveEdgePolicy();
      policy.beginProgrammatic();
      policy.handleUserScroll(
        FixedScrollMetrics(
          pixels: 0,
          minScrollExtent: 0,
          maxScrollExtent: 1000,
          viewportDimension: 200,
          axisDirection: AxisDirection.down,
          devicePixelRatio: 1,
        ),
      );
      expect(policy.following, isTrue);
      policy.endProgrammatic();
    });

    test('disabled policy never follows', () {
      final policy = LiveEdgePolicy(enabled: false);
      expect(policy.following, isFalse);
    });
  });
}
