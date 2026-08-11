import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

enum Interest { design, code }

void main() {
  test('segmented control API is constructible from the package barrel', () {
    const item = RemixSegmentedControlItem<String>(
      value: 'list',
      label: 'List',
    );
    const control = RemixSegmentedControl<String>(
      items: [item],
      selectedValue: 'list',
    );
    const unselectedControl = RemixSegmentedControl<int>(
      items: [RemixSegmentedControlItem<int>(value: 1, label: 'One')],
      selectedValue: null,
    );

    expect(control.items.single, item);
    expect(unselectedControl.items.single.value, 1);
    expect(unselectedControl.selectedValue, isNull);
    expect(control.style, isA<SegmentedControlStyler>());
    expect(const SegmentedControlSpec(), isA<SegmentedControlSpec>());
    expect(const SegmentedControlItemSpec(), isA<SegmentedControlItemSpec>());
  });

  test('segmented control styleFrom builds the widget in one step', () {
    final SegmentedControlStyler styler = RemixSegmentedControl.styleFrom(
      spacing: 4,
      mainAxisSize: MainAxisSize.max,
    );
    const forwardedKey = ValueKey<String>('forwarded');
    const items = [RemixSegmentedControlItem<String>(value: 'a', label: 'A')];

    final called = styler<String>(
      key: forwardedKey,
      items: items,
      selectedValue: 'a',
      orientation: Axis.vertical,
      loop: false,
      semanticLabel: 'Forwarded',
      excludeSemantics: true,
    );

    expect(called, isA<RemixSegmentedControl<String>>());
    expect(called.key, forwardedKey);
    expect(called.items, items);
    expect(called.selectedValue, 'a');
    expect(called.orientation, Axis.vertical);
    expect(called.loop, isFalse);
    expect(called.semanticLabel, 'Forwarded');
    expect(called.excludeSemantics, isTrue);
    expect(called.style, same(styler));
  });

  test(
    'segmented callback receives T while selectedValue remains nullable',
    () {
      final changes = <String>[];

      final control = RemixSegmentedControl<String>(
        items: const [RemixSegmentedControlItem(value: 'grid', label: 'Grid')],
        selectedValue: null,
        onChanged: changes.add,
      );

      control.onChanged?.call('grid');

      expect(control.selectedValue, isNull);
      expect(changes, ['grid']);
    },
  );

  test('RemixTextArea is exported as the multiline TextField facade', () {
    const textArea = RemixTextArea();

    expect(textArea, isA<RemixTextField>());
    expect(textArea.minLines, 2);
    expect(textArea.maxLines, isNull);
  });

  test('the skeleton family is constructible from the public API', () {
    const spec = SkeletonSpec(
      container: StyleSpec(spec: BoxSpec()),
      pulseColor: Color(0xFFCCCCCC),
      duration: Duration(milliseconds: 1000),
    );
    final style = SkeletonStyler()
        .container(
          BoxStyler()
              .size(120, 24)
              .color(const Color(0xFFEEEEEE))
              .borderRadius(.circular(4)),
        )
        .pulseColor(const Color(0xFFCCCCCC))
        .duration(const Duration(milliseconds: 1000));

    expect(
      RemixSkeleton(style: style, child: const Text('Jane')),
      isA<RemixSkeleton>(),
    );
    const raw = RemixSkeleton(styleSpec: StyleSpec(spec: spec));
    expect(raw, isA<RemixSkeleton>());
    expect(raw.styleSpec?.spec, spec);
    expect(
      style(child: const Text('Jane'), loading: false),
      isA<RemixSkeleton>(),
    );
    expect(
      RemixSkeleton.styleFrom(pulseColor: const Color(0xFFCCCCCC)),
      isA<SkeletonStyler>(),
    );
  });

  test('the data list family is constructible from the public API', () {
    const item = RemixDataListItem(
      key: ValueKey<String>('status'),
      label: 'Status',
      value: 'Active',
      alignment: RemixDataListItemAlignment.center,
    );
    const rawStyleSpec = StyleSpec<DataListSpec>(
      spec: DataListSpec(
        rowSpacing: 8,
        columnSpacing: 16,
        labelValueSpacing: 4,
        minLabelWidth: 120,
      ),
    );
    const raw = RemixDataList(
      key: ValueKey<String>('raw'),
      items: [item],
      orientation: Axis.vertical,
      semanticLabel: 'Account details',
      excludeSemantics: true,
      styleSpec: rawStyleSpec,
    );
    final Style<DataListSpec> style = raw.style;
    final StyleSpec<DataListSpec>? styleSpec = raw.styleSpec;

    final DataListStyler styler = RemixDataList.styleFrom(
      rowSpacing: 12,
      columnSpacing: 20,
      labelValueSpacing: 6,
      minLabelWidth: 144,
    );
    final items = <RemixDataListItem>[item];
    const forwardedKey = ValueKey<String>('forwarded');
    final called = styler(
      key: forwardedKey,
      items: items,
      orientation: Axis.vertical,
      semanticLabel: 'Forwarded account details',
      excludeSemantics: true,
    );

    expect(raw, isA<RemixDataList>());
    expect(raw.items.single, same(item));
    expect(style, isA<DataListStyler>());
    expect(styleSpec, same(rawStyleSpec));
    expect(styleSpec?.spec, isA<DataListSpec>());
    expect(styler, isA<DataListStyler>());
    expect(called, isA<RemixDataList>());
    expect(called.key, forwardedKey);
    expect(called.style, same(styler));
    expect(called.items, same(items));
    expect(called.orientation, Axis.vertical);
    expect(called.semanticLabel, 'Forwarded account details');
    expect(called.excludeSemantics, isTrue);
  });

  test('the data table family is constructible from the public API', () {
    final columns = <RemixDataTableColumn<String>>[
      RemixDataTableColumn(
        id: 'value',
        label: 'Value',
        sortable: true,
        width: const FixedColumnWidth(120),
        alignment: RemixDataTableCellAlignment.end,
        cellBuilder: (context, row) => Text(row),
      ),
    ];
    const spec = DataTableSpec(
      headerMinHeight: 36,
      rowMinHeight: 44,
      selectionColumnWidth: 48,
      sortIconSpacing: 4,
    );
    final raw = RemixDataTable<String>(
      key: const ValueKey<String>('raw'),
      rows: const ['one'],
      columns: columns,
      semanticLabel: 'Values',
      sort: const RemixDataTableSort(
        columnId: 'value',
        direction: RemixDataTableSortDirection.ascending,
      ),
      onSortChanged: (_) {},
      rowId: (row) => row,
      selectedRowIds: const {'one'},
      onSelectionChanged: (_) {},
      totalRows: 1,
      pageSizeOptions: const [10, 20, 50],
      onPageChanged: (_) {},
      onPageSizeChanged: (_) {},
      minimumWidth: 640,
      emptyBuilder: (context) => const Text('Empty'),
      labels: const RemixDataTableLabels(rowsPerPage: 'Per page'),
      pageRangeFormatter: remixDefaultDataTablePageRangeFormatter,
      styleSpec: spec,
    );
    final DataTableStyler style = raw.style;
    final DataTableSpec? styleSpec = raw.styleSpec;
    final DataTableStyler styler = RemixDataTable.styleFrom(rowMinHeight: 44);

    expect(raw, isA<RemixDataTable<String>>());
    expect(raw.columns, same(columns));
    expect(style, isA<DataTableStyler>());
    expect(styleSpec, same(spec));
    expect(styler, isA<DataTableStyler>());
  });

  test('checkbox groups are const-constructible over any value type', () {
    const stringGroup = RemixCheckboxGroup<String>(
      values: {'design'},
      child: RemixCheckboxGroupItem<String>(value: 'design', label: 'Design'),
    );
    const enumGroup = RemixCheckboxGroup<Interest>(
      values: {Interest.code},
      child: RemixCheckboxGroupItem<Interest>(
        value: Interest.code,
        label: 'Code',
      ),
    );

    expect(stringGroup.values, equals({'design'}));
    expect(stringGroup.child, isA<RemixCheckboxGroupItem<String>>());
    expect(enumGroup.values, equals({Interest.code}));
    expect(enumGroup.child, isA<RemixCheckboxGroupItem<Interest>>());
  });

  test('checkbox group flags and item passthrough stay on the public API', () {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);

    final group = RemixCheckboxGroup<Interest>(
      values: const {Interest.design},
      onChanged: (Set<Interest> values) {},
      enabled: false,
      isRequired: true,
      semanticLabel: 'Interests',
      excludeSemantics: true,
      child: RemixCheckboxGroupItem<Interest>(
        value: Interest.design,
        label: 'Design',
        semanticLabel: 'Design interest',
        enabled: false,
        focusNode: focusNode,
        autofocus: true,
        checkedIcon: Icons.done,
        uncheckedIcon: Icons.close,
        enableFeedback: false,
        minimumTapTargetSize: Size.zero,
        mouseCursor: SystemMouseCursors.basic,
        style: CheckboxStyler(),
        styleSpec: const CheckboxSpec(),
      ),
    );

    final item = group.child as RemixCheckboxGroupItem<Interest>;

    expect(group.onChanged, isA<ValueChanged<Set<Interest>>>());
    expect(group.enabled, isFalse);
    expect(group.isRequired, isTrue);
    expect(group.semanticLabel, 'Interests');
    expect(group.excludeSemantics, isTrue);
    expect(item.label, 'Design');
    expect(item.semanticLabel, 'Design interest');
    expect(item.focusNode, same(focusNode));
    expect(item.autofocus, isTrue);
    expect(item.minimumTapTargetSize, Size.zero);
    expect(item.style, isA<CheckboxStyler>());
    expect(item.styleSpec, isA<CheckboxSpec>());
    expect(RemixCheckboxGroupItem.styleFrom, isNotNull);
  });
}
