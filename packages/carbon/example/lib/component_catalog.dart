import 'package:carbon/carbon.dart';
import 'package:flutter/material.dart';
import 'package:mix_atlas/mix_atlas.dart';

/// Complete Carbon 1.114.0 component catalog used by the live atlas and tests.
final carbonAtlasCatalog = AtlasCatalog(
  id: 'carbon',
  label: 'Carbon for Flutter',
  themes: [for (final theme in CarbonTheme.values) _atlasTheme(theme)],
  atlases: [
    _accordionAtlas,
    _aiLabelAtlas,
    _barChartAtlas,
    _breadcrumbAtlas,
    _buttonAtlas,
    _checkboxAtlas,
    _codeSnippetAtlas,
    _containedListAtlas,
    _contentSwitcherAtlas,
    _dataTableAtlas,
    _datePickerAtlas,
    _dropdownAtlas,
    _fileUploaderAtlas,
    _formAtlas,
    _inlineLoadingAtlas,
    _lineChartAtlas,
    _linkAtlas,
    _listAtlas,
    _loadingAtlas,
    _menuAtlas,
    _menuButtonAtlas,
    _modalAtlas,
    _multiselectAtlas,
    _notificationAtlas,
    _numberInputAtlas,
    _paginationAtlas,
    _pieChartAtlas,
    _popoverAtlas,
    _progressBarAtlas,
    _progressIndicatorAtlas,
    _radioButtonAtlas,
    _searchAtlas,
    _selectAtlas,
    _sliderAtlas,
    _structuredListAtlas,
    _tabsAtlas,
    _tagAtlas,
    _textInputAtlas,
    _tileAtlas,
    _toggleAtlas,
    _toggletipAtlas,
    _tooltipAtlas,
    _treeViewAtlas,
    _uiShellAtlas,
  ],
);

ComponentAtlas _sample(
  String id,
  String label,
  Widget Function(BuildContext context) builder,
) => ComponentAtlas(
  id: id,
  label: label,
  scenarios: const [AtlasScenarios.base],
  rows: [AtlasRow('example', (context, _) => builder(context))],
);

ComponentAtlas _samples(
  String id,
  String label,
  List<(String, String, Widget Function(BuildContext))> rows,
) => ComponentAtlas(
  id: id,
  label: label,
  rowAxes: const [AtlasAxis('variant', 'Variant')],
  scenarios: const [AtlasScenarios.base],
  rows: [
    for (final (rowId, rowLabel, builder) in rows)
      AtlasRow(
        rowId,
        (context, _) => builder(context),
        values: {'variant': AtlasAxisValue(rowId, rowLabel)},
      ),
  ],
);

Widget _width(double width, Widget child) =>
    SizedBox(width: width, child: child);

final _accordionAtlas = _sample(
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

final _aiLabelAtlas = _samples('ai-label', 'AI label', [
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

final _barChartAtlas = _sample(
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

final _breadcrumbAtlas = _sample(
  'breadcrumb',
  'Breadcrumb',
  (_) => CarbonBreadcrumb(
    items: [
      CarbonBreadcrumbItem(label: 'Home', onPressed: () {}),
      CarbonBreadcrumbItem(label: 'Projects', onPressed: () {}),
      const CarbonBreadcrumbItem(label: 'Carbon', current: true),
    ],
  ),
);

const _buttonScenarios = [
  ...AtlasScenarios.interactive,
  AtlasScenario(
    'loading',
    label: 'Loading',
    states: {WidgetState.disabled},
    props: {'loading': true},
  ),
];

final _buttonAtlas = ComponentAtlas(
  id: 'button',
  label: 'Button',
  rowAxes: const [AtlasAxis('kind', 'Kind'), AtlasAxis('size', 'Size')],
  scenarios: _buttonScenarios,
  rows: [
    for (final kind in CarbonButtonKind.values)
      for (final size in CarbonSize.values.skip(1))
        AtlasRow(
          '${kind.name}-${size.name}',
          (_, cell) {
            final loading = cell.propOr('loading', false);
            final enabled = !cell.disabled && !loading;
            return SizedBox(
              width: 272,
              child: CarbonButton(
                label: _kindLabel(kind),
                kind: kind,
                size: size,
                loading: loading,
                enabled: enabled,
                onPressed: enabled ? () {} : null,
              ),
            );
          },
          values: {
            'kind': AtlasAxisValue(kind.name, _kindLabel(kind)),
            'size': AtlasAxisValue(size.name, _sizeLabel(size)),
          },
        ),
  ],
);

final _checkboxAtlas = _samples('checkbox', 'Checkbox', [
  (
    'unchecked',
    'Unchecked',
    (_) => _width(
      240,
      CarbonCheckbox(
        selected: false,
        label: 'Email updates',
        onChanged: (_) {},
      ),
    ),
  ),
  (
    'checked',
    'Checked',
    (_) => _width(
      240,
      CarbonCheckbox(selected: true, label: 'Email updates', onChanged: (_) {}),
    ),
  ),
  (
    'mixed',
    'Indeterminate',
    (_) => _width(
      240,
      CarbonCheckbox(
        selected: null,
        tristate: true,
        label: 'Select all',
        onChanged: (_) {},
      ),
    ),
  ),
]);

final _codeSnippetAtlas = _samples('code-snippet', 'Code snippet', [
  (
    'inline',
    'Inline',
    (_) => const CarbonCodeSnippet(
      code: 'flutter pub add carbon',
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

final _containedListAtlas = _sample(
  'contained-list',
  'Contained list',
  (_) => _width(
    420,
    CarbonContainedList(
      label: 'Repositories',
      items: [
        CarbonContainedListItem(
          label: 'remix',
          description: 'Updated now',
          onPressed: () {},
        ),
        const CarbonContainedListItem(
          label: 'carbon',
          description: 'Updated yesterday',
        ),
      ],
    ),
  ),
);

final _contentSwitcherAtlas = _sample(
  'content-switcher',
  'Content switcher',
  (_) => _width(
    420,
    CarbonContentSwitcher<String>(
      selectedValue: 'list',
      onChanged: (_) {},
      items: const [
        CarbonContentSwitcherItem(value: 'list', label: 'List'),
        CarbonContentSwitcherItem(value: 'grid', label: 'Grid'),
        CarbonContentSwitcherItem(value: 'chart', label: 'Chart'),
      ],
    ),
  ),
);

final _dataTableAtlas = _sample(
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

final _datePickerAtlas = _samples('date-picker', 'Date picker', [
  (
    'single',
    'Single',
    (_) => _width(
      320,
      CarbonDatePicker(
        label: 'Launch date',
        value: DateTime(2026, 8, 13),
        onChanged: (_) {},
      ),
    ),
  ),
  (
    'range',
    'Range',
    (_) => _width(
      640,
      CarbonDateRangePicker(
        startDate: DateTime(2026, 8, 13),
        endDate: DateTime(2026, 8, 20),
        onChanged: (_, _) {},
      ),
    ),
  ),
]);

final _dropdownAtlas = _sample(
  'dropdown',
  'Dropdown',
  (_) => _width(
    320,
    CarbonDropdown<String>(
      titleText: 'Region',
      label: 'Choose a region',
      selectedItem: 'us-east',
      onChanged: (_) {},
      items: const [
        CarbonSelectItem(value: 'us-east', label: 'US East'),
        CarbonSelectItem(value: 'eu-west', label: 'EU West'),
      ],
    ),
  ),
);

final _fileUploaderAtlas = _sample(
  'file-uploader',
  'File uploader',
  (_) => _width(
    420,
    CarbonFileUploader(
      labelTitle: 'Upload documents',
      labelDescription: 'PDF files up to 5 MB',
      buttonLabel: 'Add files',
      onBrowse: () {},
      items: const [
        CarbonFileUploadItem(
          name: 'design-system.pdf',
          sizeDescription: '2.4 MB',
        ),
      ],
    ),
  ),
);

final _formAtlas = _sample(
  'form',
  'Form',
  (_) => _width(
    420,
    CarbonForm(
      semanticLabel: 'Profile form',
      children: [
        const CarbonTextInput(label: 'Name', hintText: 'Ada Lovelace'),
        CarbonCheckbox(
          selected: true,
          label: 'Public profile',
          onChanged: (_) {},
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: CarbonButton(label: 'Save', onPressed: () {}),
        ),
      ],
    ),
  ),
);

final _inlineLoadingAtlas = _samples('inline-loading', 'Inline loading', [
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

final _lineChartAtlas = _sample(
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

final _linkAtlas = _sample(
  'link',
  'Link',
  (_) => CarbonLink(label: 'Read the Carbon guidance', onPressed: () {}),
);

final _listAtlas = _samples('list', 'List', [
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

final _loadingAtlas = _samples('loading', 'Loading', [
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

final _menuAtlas = _sample(
  'menu',
  'Menu',
  (_) => CarbonMenu<String>(
    trigger: const CarbonMenuTrigger(label: 'Actions'),
    items: _menuItems,
    onSelected: (_) {},
  ),
);

final _menuButtonAtlas = _samples('menu-button', 'Menu button', [
  (
    'button',
    'Menu button',
    (_) => CarbonMenuButton<String>(
      label: 'Create',
      items: _menuItems,
      onSelected: (_) {},
    ),
  ),
  (
    'overflow',
    'Overflow',
    (_) => CarbonOverflowMenu<String>(items: _menuItems, onSelected: (_) {}),
  ),
]);

final _modalAtlas = _sample(
  'modal',
  'Modal',
  (_) => CarbonModal(
    size: CarbonModalSize.small,
    title: 'Delete project?',
    description: 'This action cannot be undone.',
    actions: [
      CarbonButton(
        label: 'Cancel',
        kind: CarbonButtonKind.secondary,
        onPressed: () {},
      ),
      CarbonButton(
        label: 'Delete',
        kind: CarbonButtonKind.danger,
        onPressed: () {},
      ),
    ],
  ),
);

final _multiselectAtlas = _sample(
  'multiselect',
  'Multiselect',
  (_) => _width(
    320,
    CarbonMultiselect<String>(
      label: 'Projects',
      placeholder: 'Choose projects',
      selectedValues: const {'carbon', 'remix'},
      onChanged: (_) {},
      items: const [
        CarbonMultiselectItem(value: 'carbon', label: 'Carbon'),
        CarbonMultiselectItem(value: 'remix', label: 'Remix'),
        CarbonMultiselectItem(value: 'fortal', label: 'Fortal'),
      ],
    ),
  ),
);

final _notificationAtlas = _samples('notification', 'Notification', [
  for (final kind in CarbonNotificationKind.values)
    (
      kind.name,
      _titleCase(kind.name),
      (_) => _width(
        520,
        CarbonNotification(
          kind: kind,
          title: '${_titleCase(kind.name)} notification',
          subtitle: 'A concise message with the next useful detail.',
          actionLabel: 'View',
          onAction: () {},
          onClose: () {},
        ),
      ),
    ),
]);

final _numberInputAtlas = _sample(
  'number-input',
  'Number input',
  (_) => _width(
    240,
    CarbonNumberInput(
      value: 3,
      min: 0,
      max: 10,
      label: 'Guests',
      onChanged: (_) {},
    ),
  ),
);

final _paginationAtlas = _sample(
  'pagination',
  'Pagination',
  (_) => _width(
    680,
    CarbonPagination(
      page: 2,
      pageSize: 10,
      totalItems: 42,
      onPageChanged: (_) {},
      onPageSizeChanged: (_) {},
    ),
  ),
);

final _pieChartAtlas = _sample(
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

final _popoverAtlas = _sample(
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

final _progressBarAtlas = _samples('progress-bar', 'Progress bar', [
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

final _progressIndicatorAtlas = _sample(
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

final _radioButtonAtlas = _sample(
  'radio-button',
  'Radio button',
  (_) => CarbonRadioButtonGroup<String>(
    groupValue: 'weekly',
    onChanged: (_) {},
    semanticLabel: 'Digest frequency',
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarbonRadioButton(value: 'daily', label: 'Daily'),
        CarbonRadioButton(value: 'weekly', label: 'Weekly'),
      ],
    ),
  ),
);

final _searchAtlas = _sample(
  'search',
  'Search',
  (_) => _width(
    360,
    CarbonSearch(labelText: 'Search projects', onChanged: (_) {}),
  ),
);

final _selectAtlas = _sample(
  'select',
  'Select',
  (_) => _width(
    320,
    CarbonSelect<String>(
      label: 'Environment',
      placeholder: 'Choose environment',
      selectedValue: 'production',
      onChanged: (_) {},
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
);

final _sliderAtlas = _sample(
  'slider',
  'Slider',
  (_) => _width(
    360,
    CarbonSlider(
      value: 64,
      min: 0,
      max: 100,
      onChanged: (_) {},
      semanticLabel: 'Volume',
    ),
  ),
);

final _structuredListAtlas = _sample(
  'structured-list',
  'Structured list',
  (_) => _width(
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
          onPressed: () {},
          cells: const [
            CarbonStructuredListCell(child: Text('Starter')),
            CarbonStructuredListCell(child: Text(r'$9 / month')),
          ],
        ),
      ],
    ),
  ),
);

final _tabsAtlas = _sample(
  'tabs',
  'Tabs',
  (_) => _width(
    520,
    CarbonTabs(
      selectedTabId: 'overview',
      onChanged: (_) {},
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
);

final _tagAtlas = _sample(
  'tag',
  'Tag',
  (_) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (final kind in CarbonTagKind.values)
        CarbonTag(
          label: _titleCase(kind.name),
          kind: kind,
          onRemove: kind == CarbonTagKind.blue ? () {} : null,
        ),
    ],
  ),
);

final _textInputAtlas = _samples('text-input', 'Text input', [
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

final _tileAtlas = _samples('tile', 'Tile', [
  (
    'static',
    'Static',
    (_) => _width(300, const CarbonTile(child: Text('Static content tile'))),
  ),
  (
    'clickable',
    'Clickable',
    (_) => _width(
      300,
      CarbonClickableTile(
        semanticLabel: 'Open analytics',
        onPressed: () {},
        child: const Text('Analytics'),
      ),
    ),
  ),
  (
    'selectable',
    'Selectable',
    (_) => _width(
      300,
      CarbonSelectableTile(
        selected: true,
        semanticLabel: 'Starter plan',
        onChanged: (_) {},
        child: const Text('Starter plan'),
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

final _toggleAtlas = _samples('toggle', 'Toggle', [
  (
    'regular',
    'Regular',
    (_) =>
        CarbonToggle(selected: true, label: 'Notifications', onChanged: (_) {}),
  ),
  (
    'small',
    'Small',
    (_) => CarbonToggle(
      selected: false,
      label: 'Compact mode',
      size: CarbonToggleSize.small,
      onChanged: (_) {},
    ),
  ),
]);

final _toggletipAtlas = _sample(
  'toggletip',
  'Toggletip',
  (_) => const CarbonToggletip(
    content: Text('Interactive help can contain actions.'),
    child: Text('Show help'),
  ),
);

final _tooltipAtlas = _sample(
  'tooltip',
  'Tooltip',
  (_) => const CarbonTooltip(
    tooltipSemantics: 'Create a project',
    tooltipChild: Text('Create a project'),
    child: Icon(Icons.add),
  ),
);

final _treeViewAtlas = _sample(
  'tree-view',
  'Tree view',
  (_) => _width(
    320,
    CarbonTreeView<String>(
      semanticLabel: 'Project files',
      initialExpandedIds: const {'lib'},
      selectedId: 'main',
      onSelected: (_) {},
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
);

final _uiShellAtlas = _sample(
  'ui-shell',
  'UI shell',
  (_) => SizedBox(
    width: 680,
    height: 300,
    child: CarbonUiShell(
      header: const CarbonHeader(
        companyName: 'IBM',
        productName: 'Carbon Studio',
      ),
      sideNav: CarbonSideNav(
        items: [
          CarbonSideNavItem(
            label: 'Dashboard',
            selected: true,
            onPressed: () {},
          ),
          CarbonSideNavItem(label: 'Projects', onPressed: () {}),
          CarbonSideNavItem(label: 'Settings', onPressed: () {}),
        ],
      ),
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Text('Application content'),
      ),
    ),
  ),
);

AtlasTheme _atlasTheme(CarbonTheme theme) => AtlasTheme(
  theme.name,
  label: _themeLabel(theme),
  brightness: theme.brightness,
  background: _themeBackground(theme),
  builder: (_, child) => CarbonScope(theme: theme, child: child),
);

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

String _themeLabel(CarbonTheme theme) => switch (theme) {
  .white => 'W',
  .g10 => '10',
  .g90 => '90',
  .g100 => '100',
};

Color _themeBackground(CarbonTheme theme) => switch (theme) {
  .white => const Color(0xFFFFFFFF),
  .g10 => const Color(0xFFF4F4F4),
  .g90 => const Color(0xFF262626),
  .g100 => const Color(0xFF161616),
};

String _titleCase(String value) =>
    '${value.substring(0, 1).toUpperCase()}${value.substring(1)}';

class _ListWidth extends StatelessWidget {
  const _ListWidth({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox(width: 320, child: child);
}
