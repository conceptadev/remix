import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('mode-aware Fortal filters are constructible from the public API', () {
    final modifier = fortalModeAwareFilter(
      light: const [RemixCssColorFilterOperation.brightness(1.1)],
      dark: const [RemixCssColorFilterOperation.contrast(0.9)],
    );

    expect(modifier, isNotNull);
  });

  test('compound menu item types are exported from remix.dart', () {
    const checkbox = RemixMenuCheckboxItem<String>(
      value: 'notifications',
      label: 'Notifications',
      checked: true,
    );
    const radioGroup = RemixMenuRadioGroup<String>(
      value: 'compact',
      items: [
        RemixMenuRadioItem(value: 'compact', label: 'Compact'),
        RemixMenuRadioItem(value: 'comfortable', label: 'Comfortable'),
      ],
    );
    const submenu = RemixMenuSubmenu<String>(
      label: 'More',
      items: [RemixMenuItem(value: 'archive', label: 'Archive')],
    );

    expect(checkbox, isA<RemixMenuItemData<String>>());
    expect(radioGroup, isA<RemixMenuItemData<String>>());
    expect(submenu, isA<RemixMenuItemData<String>>());
  });
}
