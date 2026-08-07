import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

void main() {
  test('core constructors retain the origin/main data-driven surface', () {
    const button = RemixButton(label: 'Save');
    const card = RemixCard(child: Text('Passive'));
    const checkbox = RemixCheckbox(
      selected: false,
      label: 'Receive updates',
      minimumTapTargetSize: Size.zero,
    );
    const menu = RemixMenu<String>(
      trigger: RemixMenuTrigger(label: 'Actions'),
      items: [
        RemixMenuItem(value: 'save', label: 'Save'),
        RemixMenuCheckboxItem(
          value: 'notifications',
          label: 'Notifications',
          checked: true,
        ),
        RemixMenuRadioGroup(
          value: 'compact',
          items: [
            RemixMenuRadioItem(value: 'compact', label: 'Compact'),
            RemixMenuRadioItem(value: 'comfortable', label: 'Comfortable'),
          ],
        ),
        RemixMenuSubmenu(
          label: 'More',
          items: [RemixMenuItem(value: 'archive', label: 'Archive')],
        ),
      ],
    );
    const select = RemixSelect<String>(
      trigger: RemixSelectTrigger(placeholder: 'Choose'),
      items: [RemixSelectItem(value: 'one', label: 'One')],
    );
    const slider = RemixSlider(value: 0.5);
    const progress = RemixProgress(value: 0.5);
    const tabBar = RemixTabBar(child: Text('Tabs'));
    const spinner = RemixSpinner();
    const segmentedItem = RemixSegmentedControlItem<String>(
      value: 'list',
      label: 'List',
    );
    const segmentedControl = RemixSegmentedControl<String>(
      items: [segmentedItem],
      selectedValue: 'list',
    );
    const textArea = RemixTextArea(label: 'Notes');
    const checkboxGroup = RemixCheckboxGroup<String>(
      values: {'one'},
      child: RemixCheckboxGroupItem<String>(
        value: 'one',
        label: 'One',
        semanticLabel: 'Option one',
        minimumTapTargetSize: Size.zero,
      ),
    );
    const skeleton = RemixSkeleton(child: Text('Jane Appleseed'));
    const dataList = RemixDataList(
      items: [RemixDataListItem(label: 'Status', value: 'Active')],
    );
    const dataTable = RemixDataTable<String>(rows: [], columns: []);

    expect(button.label, 'Save');
    expect(card.child, isA<Text>());
    expect(checkbox.label, 'Receive updates');
    expect(checkbox.minimumTapTargetSize, Size.zero);
    expect(menu.trigger, isA<RemixMenuTrigger>());
    expect(menu.items, hasLength(4));
    expect(menu.items[0], isA<RemixMenuItem<String>>());
    expect(menu.items[1], isA<RemixMenuCheckboxItem<String>>());
    expect(menu.items[2], isA<RemixMenuRadioGroup<String>>());
    expect(menu.items[3], isA<RemixMenuSubmenu<String>>());
    expect(select.items.single, isA<RemixSelectItem<String>>());
    expect(slider.value, 0.5);
    expect(progress.value, 0.5);
    expect(tabBar.child, isA<Text>());
    expect(spinner, isA<RemixSpinner>());
    expect(segmentedControl.items.single, segmentedItem);
    expect(segmentedControl.items.single.value, 'list');
    expect(textArea, isA<RemixTextField>());
    expect(textArea.label, 'Notes');
    expect(checkbox.selected, isFalse);
    expect(checkboxGroup.values.single, 'one');
    expect(checkboxGroup.child, isA<RemixCheckboxGroupItem<String>>());
    final checkboxGroupItem =
        checkboxGroup.child as RemixCheckboxGroupItem<String>;
    expect(checkboxGroupItem.label, 'One');
    expect(checkboxGroupItem.semanticLabel, 'Option one');
    expect(checkboxGroupItem.minimumTapTargetSize, Size.zero);
    expect(skeleton.child, isA<Text>());
    expect(skeleton.loading, isTrue);
    expect(dataList.items.single, isA<RemixDataListItem>());
    expect(dataList.items.single.label, 'Status');
    expect(dataList.items.single.value, 'Active');
    expect(
      dataList.items.single.alignment,
      RemixDataListItemAlignment.baseline,
    );
    expect(dataList.orientation, Axis.horizontal);
    expect(dataList.style, isA<DataListStyler>());
    expect(dataList.styleSpec, isNull);
    expect(dataTable.pageIndex, 0);
    expect(dataTable.pageSize, 10);
    expect(dataTable.pageSizeOptions, const [10, 20, 50]);
    expect(dataTable.minimumWidth, 0);
    expect(dataTable.selectedRowIds, isEmpty);
    expect(dataTable.labels.rowsPerPage, 'Rows per page');
    expect(
      dataTable.pageRangeFormatter,
      same(remixDefaultDataTablePageRangeFormatter),
    );
    expect(dataTable.style, isA<DataTableStyler>());
    expect(dataTable.styleSpec, isNull);
  });

  test('menu data retains caller-owned identity', () {
    const ordinaryKey = ValueKey<String>('ordinary');
    const checkboxKey = ValueKey<String>('checkbox');
    const radioGroupKey = ValueKey<String>('radio-group');
    const radioItemKey = ValueKey<String>('radio-item');
    const submenuKey = ValueKey<String>('submenu');
    const dividerKey = ValueKey<String>('divider');
    const items = <RemixMenuItemData<String>>[
      RemixMenuItem(key: ordinaryKey, value: 'ordinary', label: 'Ordinary'),
      RemixMenuCheckboxItem(
        key: checkboxKey,
        value: 'checkbox',
        label: 'Checkbox',
        checked: true,
      ),
      RemixMenuRadioGroup(
        key: radioGroupKey,
        value: 'radio',
        items: [
          RemixMenuRadioItem(key: radioItemKey, value: 'radio', label: 'Radio'),
        ],
      ),
      RemixMenuSubmenu(
        key: submenuKey,
        label: 'Submenu',
        items: [RemixMenuItem(value: 'nested', label: 'Nested')],
      ),
      RemixMenuDivider(key: dividerKey),
    ];

    expect(items.map((item) => item.key), [
      ordinaryKey,
      checkboxKey,
      radioGroupKey,
      submenuKey,
      dividerKey,
    ]);
    expect(
      (items[2] as RemixMenuRadioGroup<String>).items.single.key,
      radioItemKey,
    );
  });

  testWidgets('ordinary menu items remain accessible when icon-only', (
    tester,
  ) async {
    final controller = MenuController();
    final item = RemixMenuItem<String>(
      value: 'favorite',
      label: '',
      leadingIcon: Icons.star,
      semanticLabel: 'Favorite item',
    );
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      FortalScope(
        child: MaterialApp(
          home: Scaffold(
            body: RemixMenu<String>(
              controller: controller,
              trigger: const RemixMenuTrigger(label: 'Actions'),
              items: [item],
            ),
          ),
        ),
      ),
    );
    controller.open();
    await tester.pump();

    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.bySemanticsLabel('Favorite item'), findsOneWidget);
    semantics.dispose();
  });

  test('generated wrappers preserve generic and named constructors', () {
    const menu = FortalMenu<String>.soft(
      trigger: RemixMenuTrigger(label: 'Actions'),
      items: [RemixMenuItem(value: 'save', label: 'Save')],
    );
    const select = FortalSelect<String>.ghost(
      trigger: RemixSelectTrigger(placeholder: 'Choose'),
      items: [RemixSelectItem(value: 'one', label: 'One')],
    );
    const radio = FortalRadio<String>.soft(value: 'one');
    const button = FortalButton.soft(label: 'Save');
    const checkbox = FortalCheckbox.soft(
      selected: false,
      label: 'Receive updates',
      minimumTapTargetSize: Size.zero,
    );
    const segmented = FortalSegmentedControl.classic(
      items: [RemixSegmentedControlItem(value: 'list', label: 'List')],
      selectedValue: 'list',
    );
    const textArea = FortalTextArea.classic();

    expect(menu.variant, FortalMenuVariant.soft);
    expect(select.variant, FortalSelectVariant.ghost);
    expect(radio.variant, FortalRadioVariant.soft);
    expect(button.variant, FortalButtonVariant.soft);
    expect(checkbox.label, 'Receive updates');
    expect(checkbox.minimumTapTargetSize, Size.zero);
    expect(segmented, isA<FortalSegmentedControl<String>>());
    expect(segmented.variant, FortalSegmentedControlVariant.classic);
    expect(textArea.variant, FortalTextAreaVariant.classic);
  });

  test('segmented control accepts a non-nullable value callback', () {
    final changes = <String>[];
    final control = RemixSegmentedControl<String>(
      items: const [RemixSegmentedControlItem(value: 'list', label: 'List')],
      selectedValue: null,
      onChanged: changes.add,
    );

    control.onChanged?.call('list');

    expect(control.selectedValue, isNull);
    expect(changes, ['list']);
  });

  test('theme configuration exposes only canonical names', () {
    const config = FortalThemeConfig(
      accent: .red,
      gray: .mauve,
      brightness: .dark,
      panelBackground: .solid,
      radius: .large,
      scaling: .percent105,
      hasBackground: false,
    );

    expect(config.accent, FortalAccentColor.red);
    expect(config.gray, FortalGrayColor.mauve);
    expect(config.brightness, Brightness.dark);
  });
}
