import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  test('assigned Fortal recipe composes semantic styles before call', () {
    final radioItemStyle = MenuItemStyler().indicator(IconStyler().size(13));
    final menuStyle = fortalMenuStyle(variant: .soft).radioItem(radioItemStyle);

    final menu = menuStyle.call<String>(
      trigger: const RemixMenuTrigger(label: 'Options'),
      items: const [
        RemixMenuRadioGroup(
          value: 'compact',
          items: [RemixMenuRadioItem(value: 'compact', label: 'Compact')],
        ),
      ],
      onSelected: (_) {},
    );

    expect(menu, isA<RemixMenu<String>>());
    expect(menu.style.$radioItem, Prop.maybeMix(radioItemStyle));
  });
  test('RemixMenu composes a Fortal recipe with custom styling', () {
    final choiceItemStyle = MenuItemStyler().indicator(IconStyler().size(13));
    final customStyle = MenuStyler()
        .checkboxItem(choiceItemStyle)
        .radioItem(choiceItemStyle);
    final menu = RemixMenu<String>(
      style: fortalMenuStyle(
        variant: .soft,
        size: .size1,
        highContrast: true,
      ).merge(customStyle),
      trigger: const RemixMenuTrigger(label: 'Options'),
      items: const [
        RemixMenuCheckboxItem(
          value: 'checked',
          label: 'Checked',
          checked: true,
        ),
      ],
    );

    expect(menu.style.$checkboxItem, Prop.maybeMix(choiceItemStyle));
    expect(menu.style.$radioItem, Prop.maybeMix(choiceItemStyle));
  });
}
