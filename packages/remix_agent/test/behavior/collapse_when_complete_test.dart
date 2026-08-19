import 'package:flutter_test/flutter_test.dart';
import 'package:remix_agent/remix_agent.dart';

void main() {
  group('resolveCollapseWhenComplete', () {
    test('working stays open even when collapse is requested', () {
      expect(
        resolveCollapseWhenComplete(working: true, collapseOnComplete: true),
        isTrue,
      );
    });

    test('settled work collapses by default', () {
      expect(
        resolveCollapseWhenComplete(working: false, collapseOnComplete: true),
        isFalse,
      );
    });

    test('settled work stays open when collapse is disabled', () {
      expect(
        resolveCollapseWhenComplete(working: false, collapseOnComplete: false),
        isTrue,
      );
    });

    test('controlled open wins', () {
      expect(
        resolveCollapseWhenComplete(
          working: true,
          collapseOnComplete: true,
          open: false,
        ),
        isFalse,
      );
      expect(
        resolveCollapseWhenComplete(
          working: false,
          collapseOnComplete: true,
          open: true,
        ),
        isTrue,
      );
    });

    test('userExpanded reopens a settled disclosure', () {
      expect(
        resolveCollapseWhenComplete(
          working: false,
          collapseOnComplete: true,
          userExpanded: true,
        ),
        isTrue,
      );
    });

    test('defaultOpen applies after settle when the user has not toggled', () {
      expect(
        resolveCollapseWhenComplete(
          working: false,
          collapseOnComplete: true,
          defaultOpen: true,
        ),
        isTrue,
      );
    });
  });
}
