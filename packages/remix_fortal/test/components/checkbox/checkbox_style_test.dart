import 'package:flutter_test/flutter_test.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  test('same arguments produce equal styles', () {
    final first = fortalCheckboxStyle();
    final second = fortalCheckboxStyle();

    expect(first, equals(second));
    expect(first.hashCode, equals(second.hashCode));
  });
}
