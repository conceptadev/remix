import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('RemixDialog exposes opt-in structured scrolling', () {
    const dialog = RemixDialog(title: 'Environment', scrollable: true);

    expect(dialog.scrollable, isTrue);
  });
}
