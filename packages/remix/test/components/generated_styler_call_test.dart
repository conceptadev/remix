import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  group('generated Styler.call methods', () {
    test('forward the owning style for non-generic widgets', () {
      final avatarStyle = AvatarStyler();
      final badgeStyle = BadgeStyler();
      final calloutStyle = CalloutStyler();
      final cardStyle = CardStyler();
      final dividerStyle = DividerStyler();
      final linkStyle = LinkStyler();
      final popoverStyle = PopoverStyler();

      expect(avatarStyle.call().style, same(avatarStyle));
      expect(badgeStyle.call().style, same(badgeStyle));
      expect(calloutStyle.call(text: 'Notice').style, same(calloutStyle));
      expect(cardStyle.call().style, same(cardStyle));
      expect(dividerStyle.call().style, same(dividerStyle));
      expect(linkStyle.call(label: 'Docs').style, same(linkStyle));
      expect(
        popoverStyle
            .call(
              popoverChild: const SizedBox.shrink(),
              child: const SizedBox.shrink(),
            )
            .style,
        same(popoverStyle),
      );
    });

    test('preserve generic types and forward the owning style', () {
      final dataTableStyle = DataTableStyler();
      final segmentedControlStyle = SegmentedControlStyler();
      final table = dataTableStyle.call<String>(
        rows: const ['Ada'],
        columns: const [
          RemixDataTableColumn<String>(
            id: 'name',
            label: 'Name',
            cellBuilder: _buildCell,
          ),
        ],
      );
      final segmentedControl = segmentedControlStyle.call<String>(
        items: const [RemixSegmentedControlItem(value: 'list', label: 'List')],
        selectedValue: 'list',
      );

      expect(table, isA<RemixDataTable<String>>());
      expect(table.style, same(dataTableStyle));
      expect(segmentedControl, isA<RemixSegmentedControl<String>>());
      expect(segmentedControl.style, same(segmentedControlStyle));
    });
  });
}

Widget _buildCell(BuildContext context, String row) {
  return Text(row);
}
