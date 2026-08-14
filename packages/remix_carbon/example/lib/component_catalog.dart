import 'package:remix_carbon/remix_carbon.dart';
import 'package:flutter/material.dart';

typedef ComponentExampleBuilder = Widget Function(BuildContext context);

@immutable
class ComponentExample {
  const ComponentExample({
    required this.id,
    required this.label,
    required this.builder,
  });

  final String id;
  final String label;
  final ComponentExampleBuilder builder;
}

@immutable
class ComponentDemo {
  const ComponentDemo({
    required this.id,
    required this.label,
    required this.category,
    required this.summary,
    required this.examples,
  });

  final String id;
  final String label;
  final String category;
  final String summary;
  final List<ComponentExample> examples;
}

/// Lets a live example report an interaction to the catalog status bar.
class CatalogEventScope extends InheritedWidget {
  const CatalogEventScope({
    super.key,
    required this.onEvent,
    required super.child,
  });

  final ValueChanged<String> onEvent;

  static void report(BuildContext context, String event) {
    context.dependOnInheritedWidgetOfExactType<CatalogEventScope>()?.onEvent(
      event,
    );
  }

  @override
  bool updateShouldNotify(CatalogEventScope oldWidget) =>
      oldWidget.onEvent != onEvent;
}

/// Complete Carbon 1.114.0 component catalog used by the live workbench.
final carbonComponentCatalog = <ComponentDemo>[
  _accordionDemo,
  _aiLabelDemo,
  _barChartDemo,
  _breadcrumbDemo,
  _buttonDemo,
  _checkboxDemo,
  _codeSnippetDemo,
  _containedListDemo,
  _contentSwitcherDemo,
  _dataTableDemo,
  _datePickerDemo,
  _dropdownDemo,
  _fileUploaderDemo,
  _formDemo,
  _inlineLoadingDemo,
  _lineChartDemo,
  _linkDemo,
  _listDemo,
  _loadingDemo,
  _menuDemo,
  _menuButtonDemo,
  _modalDemo,
  _multiselectDemo,
  _notificationDemo,
  _numberInputDemo,
  _paginationDemo,
  _pieChartDemo,
  _popoverDemo,
  _progressBarDemo,
  _progressIndicatorDemo,
  _radioButtonDemo,
  _searchDemo,
  _selectDemo,
  _sliderDemo,
  _structuredListDemo,
  _tabsDemo,
  _tagDemo,
  _textInputDemo,
  _tileDemo,
  _toggleDemo,
  _toggletipDemo,
  _tooltipDemo,
  _treeViewDemo,
  _uiShellDemo,
];

ComponentDemo _sample(
  String id,
  String label,
  ComponentExampleBuilder builder,
) => ComponentDemo(
  id: id,
  label: label,
  category: _categoryFor(id),
  summary: _summaryFor(id, label),
  examples: [
    ComponentExample(id: 'example', label: 'Example', builder: builder),
  ],
);

ComponentDemo _samples(
  String id,
  String label,
  List<(String, String, ComponentExampleBuilder)> examples,
) => ComponentDemo(
  id: id,
  label: label,
  category: _categoryFor(id),
  summary: _summaryFor(id, label),
  examples: [
    for (final (exampleId, exampleLabel, builder) in examples)
      ComponentExample(id: exampleId, label: exampleLabel, builder: builder),
  ],
);

Widget _width(double width, Widget child) =>
    SizedBox(width: width, child: child);

final _accordionDemo = _sample(
  'accordion',
  'Accordion',
  (_) => _width(
    420,
    CarbonAccordionGroup<String>(
      controller: CarbonAccordionController<String>(min: 0, max: 1),
      initialExpandedValues: const ['first'],
      child: const Column(
        children: [
          CarbonAccordion<String>(
            value: 'first',
            title: 'What is Carbon?',
            child: Text('IBM’s open-source design system.'),
          ),
          CarbonAccordion<String>(
            value: 'second',
            title: 'How is this implemented?',
            child: Text('Flutter behavior with Mix styling.'),
          ),
        ],
      ),
    ),
  ),
);

final _aiLabelDemo = _samples('ai-label', 'AI label', [
  (
    'standard',
    'Standard',
    (_) => const CarbonAiLabel(
      content: Text('Generated with an AI-assisted workflow.'),
    ),
  ),
  (
    'inline',
    'Inline',
    (_) => const CarbonAiLabel(
      kind: CarbonAiLabelKind.inline,
      textLabel: 'Generated',
      content: Text('Review this content before publishing.'),
    ),
  ),
]);

final _barChartDemo = _sample(
  'bar-chart',
  'Bar chart',
  (_) => SizedBox(
    width: 480,
    height: 240,
    child: CarbonBarChart(
      semanticsLabel: 'Quarterly revenue',
      groups: [
        for (final (id, value) in [('Q1', 42.0), ('Q2', 58.0), ('Q3', 73.0)])
          CarbonBarGroup(
            id: id,
            label: id,
            bars: [CarbonBarValue(id: 'revenue', label: 'Revenue', toY: value)],
          ),
      ],
    ),
  ),
);

final _breadcrumbDemo = _sample(
  'breadcrumb',
  'Breadcrumb',
  (context) => CarbonBreadcrumb(
    items: [
      CarbonBreadcrumbItem(
        label: 'Home',
        onPressed: () => CatalogEventScope.report(context, 'Home selected'),
      ),
      CarbonBreadcrumbItem(
        label: 'Projects',
        onPressed: () => CatalogEventScope.report(context, 'Projects selected'),
      ),
      const CarbonBreadcrumbItem(label: 'Carbon', current: true),
    ],
  ),
);

final _buttonDemo = ComponentDemo(
  id: 'button',
  label: 'Button',
  category: _categoryFor('button'),
  summary: _summaryFor('button', 'Button'),
  examples: [
    for (final kind in CarbonButtonKind.values)
      ComponentExample(
        id: kind.name,
        label: _kindLabel(kind),
        builder: (context) => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final size in CarbonSize.values.skip(1))
              CarbonButton(
                label: _sizeLabel(size),
                kind: kind,
                size: size,
                onPressed: () => CatalogEventScope.report(
                  context,
                  '${_kindLabel(kind)} / ${_sizeLabel(size)} pressed',
                ),
              ),
          ],
        ),
      ),
    ComponentExample(
      id: 'icon-and-states',
      label: 'Icon and states',
      builder: (context) => Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          for (final size in CarbonSize.values.skip(1))
            CarbonIconButton(
              icon: CarbonIcons.add,
              semanticLabel: 'Add (${_sizeLabel(size)})',
              size: size,
              onPressed: () => CatalogEventScope.report(
                context,
                '${_sizeLabel(size)} icon button pressed',
              ),
            ),
          const CarbonButton(label: 'Disabled', enabled: false),
          const CarbonButton(label: 'Loading', loading: true),
        ],
      ),
    ),
  ],
);

final _checkboxDemo = _samples('checkbox', 'Checkbox', [
  (
    'unchecked',
    'Unchecked',
    (_) => _Controlled(
      initialValue: false,
      builder: (context, selected, onChanged) => _width(
        240,
        CarbonCheckbox(
          selected: selected,
          label: 'Email updates',
          onChanged: (next) {
            onChanged(next ?? false);
            CatalogEventScope.report(
              context,
              'Email updates ${next == true ? 'enabled' : 'disabled'}',
            );
          },
        ),
      ),
    ),
  ),
  (
    'checked',
    'Checked',
    (_) => _Controlled(
      initialValue: true,
      builder: (context, selected, onChanged) => _width(
        240,
        CarbonCheckbox(
          selected: selected,
          label: 'Email updates',
          onChanged: (next) {
            onChanged(next ?? false);
            CatalogEventScope.report(
              context,
              'Email updates ${next == true ? 'enabled' : 'disabled'}',
            );
          },
        ),
      ),
    ),
  ),
  (
    'mixed',
    'Indeterminate',
    (_) => _Controlled<bool?>(
      initialValue: null,
      builder: (context, selected, onChanged) => _width(
        240,
        CarbonCheckbox(
          selected: selected,
          tristate: true,
          label: 'Select all',
          onChanged: (next) {
            onChanged(next);
            CatalogEventScope.report(context, 'Select all changed to $next');
          },
        ),
      ),
    ),
  ),
]);

final _codeSnippetDemo = _samples('code-snippet', 'Code snippet', [
  (
    'inline',
    'Inline',
    (_) => const CarbonCodeSnippet(
      code: 'flutter pub add remix_carbon',
      type: CarbonCodeSnippetType.inline,
    ),
  ),
  (
    'multi',
    'Multiline',
    (_) => const CarbonCodeSnippet(
      type: CarbonCodeSnippetType.multi,
      code:
          'CarbonScope(\n  child: CarbonButton(\n    label: \'Save\',\n  ),\n);',
    ),
  ),
]);

final _containedListDemo = _sample(
  'contained-list',
  'Contained list',
  (context) => _width(
    420,
    CarbonContainedList(
      label: 'Repositories',
      items: [
        CarbonContainedListItem(
          label: 'remix',
          description: 'Updated now',
          onPressed: () =>
              CatalogEventScope.report(context, 'remix repository selected'),
        ),
        const CarbonContainedListItem(
          label: 'carbon',
          description: 'Updated yesterday',
        ),
      ],
    ),
  ),
);

final _contentSwitcherDemo = _sample(
  'content-switcher',
  'Content switcher',
  (_) => _Controlled(
    initialValue: 'list',
    builder: (context, selected, onChanged) => _width(
      420,
      CarbonContentSwitcher<String>(
        selectedValue: selected,
        onChanged: (next) {
          onChanged(next);
          CatalogEventScope.report(
            context,
            '${_titleCase(next)} view selected',
          );
        },
        items: const [
          CarbonContentSwitcherItem(value: 'list', label: 'List'),
          CarbonContentSwitcherItem(value: 'grid', label: 'Grid'),
          CarbonContentSwitcherItem(value: 'chart', label: 'Chart'),
        ],
      ),
    ),
  ),
);

final _dataTableDemo = _sample(
  'data-table',
  'Data table',
  (_) => _width(
    600,
    CarbonDataTable<(String, String)>(
      semanticLabel: 'Team members',
      rows: const [('Ada Lovelace', 'Engineer'), ('Grace Hopper', 'Admiral')],
      columns: [
        CarbonDataTableColumn(
          id: 'name',
          label: 'Name',
          cellBuilder: (_, row) => Text(row.$1),
        ),
        CarbonDataTableColumn(
          id: 'role',
          label: 'Role',
          cellBuilder: (_, row) => Text(row.$2),
        ),
      ],
    ),
  ),
);

final _datePickerDemo = _samples('date-picker', 'Date picker', [
  (
    'single',
    'Single',
    (_) => _Controlled<DateTime?>(
      initialValue: DateTime(2026, 8, 13),
      builder: (context, value, onChanged) => _width(
        320,
        CarbonDatePicker(
          label: 'Launch date',
          value: value,
          onChanged: (next) {
            onChanged(next);
            CatalogEventScope.report(context, 'Launch date changed');
          },
        ),
      ),
    ),
  ),
  (
    'range',
    'Range',
    (_) => _Controlled<(DateTime?, DateTime?)>(
      initialValue: (DateTime(2026, 8, 13), DateTime(2026, 8, 20)),
      builder: (context, range, onChanged) => _width(
        640,
        CarbonDateRangePicker(
          startDate: range.$1,
          endDate: range.$2,
          onChanged: (start, end) {
            onChanged((start, end));
            CatalogEventScope.report(context, 'Date range changed');
          },
        ),
      ),
    ),
  ),
]);

final _dropdownDemo = _sample(
  'dropdown',
  'Dropdown',
  (_) => _Controlled<String?>(
    initialValue: 'us-east',
    builder: (context, selected, onChanged) => _width(
      320,
      CarbonDropdown<String>(
        titleText: 'Region',
        label: 'Choose a region',
        selectedItem: selected,
        onChanged: (next) {
          onChanged(next);
          CatalogEventScope.report(context, 'Region changed to $next');
        },
        items: const [
          CarbonSelectItem(value: 'us-east', label: 'US East'),
          CarbonSelectItem(value: 'eu-west', label: 'EU West'),
        ],
      ),
    ),
  ),
);

final _fileUploaderDemo = _sample(
  'file-uploader',
  'File uploader',
  (context) => _width(
    420,
    CarbonFileUploader(
      labelTitle: 'Upload documents',
      labelDescription: 'PDF files up to 5 MB',
      buttonLabel: 'Add files',
      onBrowse: () => CatalogEventScope.report(
        context,
        'Browse requested (demo does not access local files)',
      ),
      items: const [
        CarbonFileUploadItem(
          name: 'design-system.pdf',
          sizeDescription: '2.4 MB',
        ),
      ],
    ),
  ),
);

final _formDemo = _sample(
  'form',
  'Form',
  (_) => _Controlled(
    initialValue: true,
    builder: (context, isPublic, onChanged) => _width(
      420,
      CarbonForm(
        semanticLabel: 'Profile form',
        children: [
          const CarbonTextInput(label: 'Name', hintText: 'Ada Lovelace'),
          CarbonCheckbox(
            selected: isPublic,
            label: 'Public profile',
            onChanged: (next) {
              onChanged(next ?? false);
              CatalogEventScope.report(context, 'Profile visibility changed');
            },
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: CarbonButton(
              label: 'Save',
              onPressed: () =>
                  CatalogEventScope.report(context, 'Profile saved'),
            ),
          ),
        ],
      ),
    ),
  ),
);

final _inlineLoadingDemo = _samples('inline-loading', 'Inline loading', [
  (
    'active',
    'Active',
    (_) => const CarbonInlineLoading(label: 'Saving changes'),
  ),
  (
    'complete',
    'Complete',
    (_) => const CarbonInlineLoading(
      label: 'Changes saved',
      status: CarbonInlineLoadingStatus.finished,
    ),
  ),
  (
    'error',
    'Error',
    (_) => const CarbonInlineLoading(
      label: 'Could not save',
      status: CarbonInlineLoadingStatus.error,
    ),
  ),
]);

final _lineChartDemo = _sample(
  'line-chart',
  'Line chart',
  (_) => SizedBox(
    width: 480,
    height: 240,
    child: CarbonLineChart(
      semanticsLabel: 'Weekly traffic',
      showMarkers: true,
      smooth: true,
      series: [
        CarbonLineSeries(
          id: 'visits',
          label: 'Visits',
          points: [
            CarbonChartPoint(id: 'mon', x: 0, y: 18),
            CarbonChartPoint(id: 'tue', x: 1, y: 31),
            CarbonChartPoint(id: 'wed', x: 2, y: 27),
            CarbonChartPoint(id: 'thu', x: 3, y: 46),
          ],
        ),
      ],
    ),
  ),
);

final _linkDemo = _sample(
  'link',
  'Link',
  (context) => CarbonLink(
    label: 'Read the Carbon guidance',
    onPressed: () => CatalogEventScope.report(context, 'Guidance link pressed'),
  ),
);

final _listDemo = _samples('list', 'List', [
  (
    'unordered',
    'Unordered',
    (_) => const _ListWidth(
      child: CarbonUnorderedList(
        children: [
          CarbonListItem(child: Text('Design')),
          CarbonListItem(child: Text('Build')),
          CarbonListItem(child: Text('Ship')),
        ],
      ),
    ),
  ),
  (
    'ordered',
    'Ordered',
    (_) => const _ListWidth(
      child: CarbonOrderedList(
        children: [
          CarbonListItem(child: Text('Install')),
          CarbonListItem(child: Text('Wrap in CarbonScope')),
          CarbonListItem(child: Text('Compose components')),
        ],
      ),
    ),
  ),
]);

final _loadingDemo = _samples('loading', 'Loading', [
  ('regular', 'Regular', (_) => const CarbonLoading(withOverlay: false)),
  (
    'small',
    'Small',
    (_) => const CarbonLoading(small: true, withOverlay: false),
  ),
]);

List<CarbonMenuItemData<String>> get _menuItems => [
  const CarbonMenuItem(value: 'edit', label: 'Edit'),
  const CarbonMenuItem(value: 'duplicate', label: 'Duplicate'),
  const CarbonMenuDivider(),
  const CarbonMenuItem(value: 'delete', label: 'Delete'),
];

final _menuDemo = _sample(
  'menu',
  'Menu',
  (context) => CarbonMenu<String>(
    trigger: const CarbonMenuTrigger(label: 'Actions'),
    items: _menuItems,
    onSelected: (value) =>
        CatalogEventScope.report(context, '${_titleCase(value)} selected'),
  ),
);

final _menuButtonDemo = _samples('menu-button', 'Menu button', [
  (
    'button',
    'Menu button',
    (context) => CarbonMenuButton<String>(
      label: 'Create',
      items: _menuItems,
      onSelected: (value) =>
          CatalogEventScope.report(context, '${_titleCase(value)} selected'),
    ),
  ),
  (
    'overflow',
    'Overflow',
    (context) => CarbonOverflowMenu<String>(
      items: _menuItems,
      onSelected: (value) =>
          CatalogEventScope.report(context, '${_titleCase(value)} selected'),
    ),
  ),
]);

final _modalDemo = _sample(
  'modal',
  'Modal',
  (context) => CarbonButton(
    label: 'Open modal',
    onPressed: () async {
      final result = await showCarbonModal<String>(
        context: context,
        builder: (modalContext) => CarbonModal(
          size: CarbonModalSize.small,
          title: 'Delete project?',
          description: 'This action cannot be undone.',
          onClose: () => Navigator.pop(modalContext, 'closed'),
          actions: [
            CarbonButton(
              label: 'Cancel',
              kind: CarbonButtonKind.secondary,
              onPressed: () => Navigator.pop(modalContext, 'cancelled'),
            ),
            CarbonButton(
              label: 'Delete',
              kind: CarbonButtonKind.danger,
              onPressed: () => Navigator.pop(modalContext, 'deleted'),
            ),
          ],
        ),
      );
      if (context.mounted) {
        CatalogEventScope.report(context, 'Modal ${result ?? 'dismissed'}');
      }
    },
  ),
);

final _multiselectDemo = _sample(
  'multiselect',
  'Multiselect',
  (_) => _Controlled<Set<String>>(
    initialValue: const {'carbon', 'remix'},
    builder: (context, selected, onChanged) => _width(
      320,
      CarbonMultiselect<String>(
        label: 'Projects',
        placeholder: 'Choose projects',
        selectedValues: selected,
        onChanged: (next) {
          onChanged(next);
          CatalogEventScope.report(context, '${next.length} projects selected');
        },
        items: const [
          CarbonMultiselectItem(value: 'carbon', label: 'Carbon'),
          CarbonMultiselectItem(value: 'remix', label: 'Remix'),
          CarbonMultiselectItem(value: 'fortal', label: 'Fortal'),
        ],
      ),
    ),
  ),
);

final _notificationDemo = _samples('notification', 'Notification', [
  for (final kind in CarbonNotificationKind.values)
    (
      kind.name,
      _titleCase(kind.name),
      (context) => _width(
        520,
        CarbonNotification(
          kind: kind,
          title: '${_titleCase(kind.name)} notification',
          subtitle: 'A concise message with the next useful detail.',
          actionLabel: 'View',
          onAction: () => CatalogEventScope.report(
            context,
            '${_titleCase(kind.name)} notification action pressed',
          ),
          onClose: () => CatalogEventScope.report(
            context,
            '${_titleCase(kind.name)} notification closed',
          ),
        ),
      ),
    ),
]);

final _numberInputDemo = _sample(
  'number-input',
  'Number input',
  (_) => _Controlled<num>(
    initialValue: 3,
    builder: (context, value, onChanged) => _width(
      240,
      CarbonNumberInput(
        value: value,
        min: 0,
        max: 10,
        label: 'Guests',
        onChanged: (next) {
          onChanged(next);
          CatalogEventScope.report(context, 'Guest count changed to $next');
        },
      ),
    ),
  ),
);

final _paginationDemo = _sample(
  'pagination',
  'Pagination',
  (_) => _Controlled<(int, int)>(
    initialValue: (2, 10),
    builder: (context, state, onChanged) => _width(
      680,
      CarbonPagination(
        page: state.$1,
        pageSize: state.$2,
        totalItems: 42,
        onPageChanged: (page) {
          onChanged((page, state.$2));
          CatalogEventScope.report(context, 'Page $page selected');
        },
        onPageSizeChanged: (pageSize) {
          onChanged((1, pageSize));
          CatalogEventScope.report(context, 'Page size changed to $pageSize');
        },
      ),
    ),
  ),
);

final _pieChartDemo = _sample(
  'pie-chart',
  'Pie chart',
  (_) => SizedBox(
    width: 260,
    height: 260,
    child: CarbonPieChart(
      semanticsLabel: 'Device mix',
      centerRadius: 52,
      slices: [
        CarbonPieSlice(id: 'mobile', label: 'Mobile', value: 64),
        CarbonPieSlice(id: 'desktop', label: 'Desktop', value: 28),
        CarbonPieSlice(id: 'tablet', label: 'Tablet', value: 8),
      ],
    ),
  ),
);

final _popoverDemo = _sample(
  'popover',
  'Popover',
  (_) => const CarbonPopover(
    semanticLabel: 'Show deployment details',
    popoverChild: Padding(
      padding: EdgeInsets.all(16),
      child: Text('Deployed 3 minutes ago'),
    ),
    child: Text('Deployment details'),
  ),
);

final _progressBarDemo = _samples('progress-bar', 'Progress bar', [
  (
    'active',
    'Active',
    (_) => _width(
      420,
      const CarbonProgressBar(
        value: 0.64,
        label: 'Uploading',
        helperText: '64%',
      ),
    ),
  ),
  (
    'error',
    'Error',
    (_) => _width(
      420,
      const CarbonProgressBar(
        value: 0.42,
        label: 'Uploading',
        helperText: 'Upload interrupted',
        status: CarbonProgressBarStatus.error,
      ),
    ),
  ),
]);

final _progressIndicatorDemo = _sample(
  'progress-indicator',
  'Progress indicator',
  (_) => _width(
    620,
    const CarbonProgressIndicator(
      currentIndex: 1,
      steps: [
        CarbonProgressStep(label: 'Account'),
        CarbonProgressStep(label: 'Profile'),
        CarbonProgressStep(label: 'Confirm'),
      ],
    ),
  ),
);

final _radioButtonDemo = _sample(
  'radio-button',
  'Radio button',
  (_) => _Controlled<String?>(
    initialValue: 'weekly',
    builder: (context, selected, onChanged) => CarbonRadioButtonGroup<String>(
      groupValue: selected,
      onChanged: (next) {
        onChanged(next);
        CatalogEventScope.report(
          context,
          next == null
              ? 'Digest frequency cleared'
              : '${_titleCase(next)} selected',
        );
      },
      semanticLabel: 'Digest frequency',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarbonRadioButton(value: 'daily', label: 'Daily'),
          CarbonRadioButton(value: 'weekly', label: 'Weekly'),
        ],
      ),
    ),
  ),
);

final _searchDemo = _sample(
  'search',
  'Search',
  (context) => _width(
    360,
    CarbonSearch(
      labelText: 'Search projects',
      onChanged: (value) => CatalogEventScope.report(
        context,
        value.isEmpty ? 'Project search cleared' : 'Searching for “$value”',
      ),
    ),
  ),
);

final _selectDemo = _sample(
  'select',
  'Select',
  (_) => _Controlled<String?>(
    initialValue: 'production',
    builder: (context, selected, onChanged) => _width(
      320,
      CarbonSelect<String>(
        label: 'Environment',
        placeholder: 'Choose environment',
        selectedValue: selected,
        onChanged: (next) {
          onChanged(next);
          CatalogEventScope.report(context, 'Environment changed to $next');
        },
        items: const [
          CarbonSelectItemGroup(
            label: 'Cloud',
            items: [
              CarbonSelectItem(value: 'production', label: 'Production'),
              CarbonSelectItem(value: 'staging', label: 'Staging'),
            ],
          ),
        ],
      ),
    ),
  ),
);

final _sliderDemo = _sample(
  'slider',
  'Slider',
  (_) => _Controlled<double>(
    initialValue: 64,
    builder: (context, value, onChanged) => _width(
      360,
      CarbonSlider(
        value: value,
        min: 0,
        max: 100,
        onChanged: (next) {
          onChanged(next);
          CatalogEventScope.report(
            context,
            'Volume changed to ${next.round()}',
          );
        },
        semanticLabel: 'Volume',
      ),
    ),
  ),
);

final _structuredListDemo = _sample(
  'structured-list',
  'Structured list',
  (context) => _width(
    560,
    CarbonStructuredList(
      semanticLabel: 'Plans',
      rows: [
        const CarbonStructuredListRow(
          header: true,
          cells: [
            CarbonStructuredListCell(header: true, child: Text('Plan')),
            CarbonStructuredListCell(header: true, child: Text('Price')),
          ],
        ),
        CarbonStructuredListRow(
          semanticLabel: 'Starter plan',
          selected: true,
          onPressed: () =>
              CatalogEventScope.report(context, 'Starter plan selected'),
          cells: const [
            CarbonStructuredListCell(child: Text('Starter')),
            CarbonStructuredListCell(child: Text(r'$9 / month')),
          ],
        ),
      ],
    ),
  ),
);

final _tabsDemo = _sample(
  'tabs',
  'Tabs',
  (_) => _Controlled(
    initialValue: 'overview',
    builder: (context, selected, onChanged) => _width(
      520,
      CarbonTabs(
        selectedTabId: selected,
        onChanged: (next) {
          onChanged(next);
          CatalogEventScope.report(context, '${_titleCase(next)} tab selected');
        },
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarbonTabBar(
              child: Row(
                children: [
                  CarbonTab(tabId: 'overview', label: 'Overview'),
                  CarbonTab(tabId: 'activity', label: 'Activity'),
                ],
              ),
            ),
            CarbonTabView(tabId: 'overview', child: Text('Overview content')),
            CarbonTabView(tabId: 'activity', child: Text('Activity content')),
          ],
        ),
      ),
    ),
  ),
);

final _tagDemo = _sample(
  'tag',
  'Tag',
  (_) => _Controlled<Set<CarbonTagKind>>(
    initialValue: CarbonTagKind.values.toSet(),
    builder: (context, visibleKinds, onChanged) => Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final kind in visibleKinds)
          CarbonTag(
            label: _titleCase(kind.name),
            kind: kind,
            onRemove: kind == CarbonTagKind.blue
                ? () {
                    onChanged({...visibleKinds}..remove(kind));
                    CatalogEventScope.report(context, 'Blue tag removed');
                  }
                : null,
          ),
      ],
    ),
  ),
);

final _textInputDemo = _samples('text-input', 'Text input', [
  (
    'input',
    'Text input',
    (_) => _width(
      360,
      const CarbonTextInput(label: 'Email', hintText: 'name@example.com'),
    ),
  ),
  (
    'password',
    'Password',
    (_) => _width(
      360,
      const CarbonPasswordInput(
        label: 'Password',
        hintText: 'At least 12 characters',
      ),
    ),
  ),
  (
    'area',
    'Text area',
    (_) => _width(
      360,
      const CarbonTextArea(label: 'Notes', hintText: 'Add context'),
    ),
  ),
]);

final _tileDemo = _samples('tile', 'Tile', [
  (
    'static',
    'Static',
    (_) => _width(300, const CarbonTile(child: Text('Static content tile'))),
  ),
  (
    'clickable',
    'Clickable',
    (context) => _width(
      300,
      CarbonClickableTile(
        semanticLabel: 'Open analytics',
        onPressed: () =>
            CatalogEventScope.report(context, 'Analytics tile pressed'),
        child: const Text('Analytics'),
      ),
    ),
  ),
  (
    'selectable',
    'Selectable',
    (_) => _Controlled(
      initialValue: true,
      builder: (context, selected, onChanged) => _width(
        300,
        CarbonSelectableTile(
          selected: selected,
          semanticLabel: 'Starter plan',
          onChanged: (next) {
            onChanged(next);
            CatalogEventScope.report(
              context,
              'Starter plan ${next ? 'selected' : 'deselected'}',
            );
          },
          child: const Text('Starter plan'),
        ),
      ),
    ),
  ),
  (
    'expandable',
    'Expandable',
    (_) => _width(
      300,
      const CarbonExpandableTile(
        title: 'Details',
        initiallyExpanded: true,
        child: Text('Expanded tile content'),
      ),
    ),
  ),
]);

final _toggleDemo = _samples('toggle', 'Toggle', [
  (
    'regular',
    'Regular',
    (_) => _Controlled(
      initialValue: true,
      builder: (context, selected, onChanged) => CarbonToggle(
        selected: selected,
        label: 'Notifications',
        onChanged: (next) {
          onChanged(next);
          CatalogEventScope.report(
            context,
            'Notifications ${next ? 'enabled' : 'disabled'}',
          );
        },
      ),
    ),
  ),
  (
    'small',
    'Small',
    (_) => _Controlled(
      initialValue: false,
      builder: (context, selected, onChanged) => CarbonToggle(
        selected: selected,
        label: 'Compact mode',
        size: CarbonToggleSize.small,
        onChanged: (next) {
          onChanged(next);
          CatalogEventScope.report(
            context,
            'Compact mode ${next ? 'enabled' : 'disabled'}',
          );
        },
      ),
    ),
  ),
]);

final _toggletipDemo = _sample(
  'toggletip',
  'Toggletip',
  (_) => const CarbonToggletip(
    content: Text('Interactive help can contain actions.'),
    child: Text('Show help'),
  ),
);

final _tooltipDemo = _sample(
  'tooltip',
  'Tooltip',
  (_) => const CarbonTooltip(
    tooltipSemantics: 'Create a project',
    tooltipChild: Text('Create a project'),
    child: Icon(CarbonIcons.add),
  ),
);

final _treeViewDemo = _sample(
  'tree-view',
  'Tree view',
  (_) => _Controlled<String?>(
    initialValue: 'main',
    builder: (context, selected, onChanged) => _width(
      320,
      CarbonTreeView<String>(
        semanticLabel: 'Project files',
        initialExpandedIds: const {'lib'},
        selectedId: selected,
        onSelected: (next) {
          onChanged(next);
          CatalogEventScope.report(context, '$next selected');
        },
        nodes: const [
          CarbonTreeNode(
            id: 'lib',
            label: 'lib',
            children: [
              CarbonTreeNode(id: 'main', label: 'main.dart'),
              CarbonTreeNode(id: 'theme', label: 'theme.dart'),
            ],
          ),
          CarbonTreeNode(id: 'readme', label: 'README.md'),
        ],
      ),
    ),
  ),
);

final _uiShellDemo = _sample(
  'ui-shell',
  'UI shell',
  (_) => _Controlled(
    initialValue: 'Dashboard',
    builder: (context, selected, onChanged) => SizedBox(
      width: 680,
      height: 300,
      child: CarbonUiShell(
        header: const CarbonHeader(
          companyName: 'IBM',
          productName: 'Carbon Studio',
        ),
        sideNav: CarbonSideNav(
          items: [
            for (final item in ['Dashboard', 'Projects', 'Settings'])
              CarbonSideNavItem(
                label: item,
                selected: selected == item,
                onPressed: () {
                  onChanged(item);
                  CatalogEventScope.report(context, '$item selected');
                },
              ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text('$selected content'),
        ),
      ),
    ),
  ),
);

String _categoryFor(String id) => switch (id) {
  'bar-chart' || 'data-table' || 'line-chart' || 'pie-chart' => 'Data display',
  'breadcrumb' ||
  'content-switcher' ||
  'link' ||
  'menu' ||
  'menu-button' ||
  'pagination' ||
  'tabs' ||
  'tree-view' ||
  'ui-shell' => 'Navigation',
  'checkbox' ||
  'date-picker' ||
  'dropdown' ||
  'file-uploader' ||
  'form' ||
  'multiselect' ||
  'number-input' ||
  'radio-button' ||
  'search' ||
  'select' ||
  'slider' ||
  'text-input' ||
  'toggle' => 'Inputs',
  'inline-loading' ||
  'loading' ||
  'modal' ||
  'notification' ||
  'progress-bar' ||
  'progress-indicator' ||
  'tooltip' ||
  'toggletip' => 'Feedback',
  _ => 'Content',
};

String _summaryFor(String id, String label) => switch (id) {
  'ui-shell' =>
    'Application chrome with a header, side navigation, and content.',
  'data-table' =>
    'Structured tabular data using Carbon spacing and type tokens.',
  'form' =>
    'A composed form that demonstrates Carbon inputs and actions together.',
  'modal' =>
    'A route-backed dialog with accessible dismissal and action handling.',
  'button' =>
    'Action hierarchy, sizes, icon-only controls, and non-interactive states.',
  'loading' || 'inline-loading' =>
    'Progress feedback with Carbon motion, status, and accessibility behavior.',
  'bar-chart' || 'line-chart' || 'pie-chart' =>
    'A token-driven Carbon data visualization with semantic labeling.',
  _ => 'A live $label implementation using the public remix_carbon API.',
};

String _kindLabel(CarbonButtonKind kind) => switch (kind) {
  .primary => 'Primary',
  .secondary => 'Secondary',
  .tertiary => 'Tertiary',
  .ghost => 'Ghost',
  .danger => 'Danger',
  .dangerTertiary => 'Danger tertiary',
  .dangerGhost => 'Danger ghost',
};

String _sizeLabel(CarbonSize size) => switch (size) {
  .xs => 'Extra small',
  .sm => 'Small',
  .md => 'Medium',
  .lg => 'Large',
  .xl => 'Extra large',
  .x2l => '2× large',
};

String _titleCase(String value) =>
    '${value.substring(0, 1).toUpperCase()}${value.substring(1)}';

typedef _ControlledBuilder<T> =
    Widget Function(BuildContext context, T value, ValueChanged<T> onChanged);

class _Controlled<T> extends StatefulWidget {
  const _Controlled({required this.initialValue, required this.builder});

  final T initialValue;
  final _ControlledBuilder<T> builder;

  @override
  State<_Controlled<T>> createState() => _ControlledState<T>();
}

class _ControlledState<T> extends State<_Controlled<T>> {
  late T value = widget.initialValue;

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, value, (next) => setState(() => value = next));
}

class _ListWidth extends StatelessWidget {
  const _ListWidth({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox(width: 320, child: child);
}
