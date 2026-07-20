import 'package:flutter/material.dart';
import 'package:mix_atlas/mix_atlas.dart';
import 'package:remix/remix.dart';

const _staticScenarios = [AtlasScenarios.base];
const _contrastScenarios = [
  AtlasScenarios.base,
  AtlasScenario(
    'high-contrast',
    label: 'High contrast',
    props: {'highContrast': true},
  ),
];
const _enabledScenarios = [AtlasScenarios.base, AtlasScenarios.disabled];
const _selectableScenarios = [
  AtlasScenarios.base,
  AtlasScenarios.selected,
  AtlasScenarios.disabled,
];
const _variantAxis = AtlasAxis('variant', 'Variant');
const _sizeAxis = AtlasAxis('size', 'Size');

final fortalAtlasCatalog = AtlasCatalog(
  id: 'fortal',
  label: 'Fortal Design System',
  themes: [
    AtlasTheme(
      'light',
      label: 'Light',
      background: Colors.white,
      builder: (_, child) => FortalScope(child: child),
    ),
    AtlasTheme(
      'dark',
      label: 'Dark',
      brightness: Brightness.dark,
      background: const Color(0xFF111111),
      builder: (_, child) => FortalScope(appearance: .dark, child: child),
    ),
  ],
  atlases: [
    _avatarAtlas,
    _badgeAtlas,
    _buttonAtlas,
    _calloutAtlas,
    _cardAtlas,
    _checkboxAtlas,
    _dialogAtlas,
    _dividerAtlas,
    _menuAtlas,
    _iconButtonAtlas,
    _popoverAtlas,
    _progressAtlas,
    _radioAtlas,
    _selectAtlas,
    _sliderAtlas,
    _spinnerAtlas,
    _switchAtlas,
    _tabsAtlas,
    _textFieldAtlas,
    _tooltipAtlas,
    _accordionAtlas,
    _toggleAtlas,
    _toggleGroupAtlas,
  ],
);

final _avatarAtlas = ComponentAtlas(
  id: 'avatar',
  label: 'Avatar',
  rowAxes: const [_variantAxis, _sizeAxis],
  scenarios: _contrastScenarios,
  rows: [
    for (final variant in FortalAvatarVariant.values)
      for (final size in const [
        FortalAvatarSize.size1,
        FortalAvatarSize.size5,
        FortalAvatarSize.size9,
      ])
        AtlasRow(
          '${variant.name}-${size.name}',
          (context, cell) => FortalAvatar(
            variant: variant,
            size: size,
            highContrast: cell.propOr('highContrast', false),
            label: 'RF',
          ),
          values: _variantSizeValues(variant, size),
        ),
  ],
);

final _badgeAtlas = ComponentAtlas(
  id: 'badge',
  label: 'Badge',
  rowAxes: const [_variantAxis],
  scenarios: _contrastScenarios,
  rows: [
    for (final variant in FortalBadgeVariant.values)
      AtlasRow(
        variant.name,
        (context, cell) => FortalBadge(
          variant: variant,
          size: .size2,
          highContrast: cell.propOr('highContrast', false),
          child: const Text('Badge'),
        ),
        values: _variantValues(variant),
      ),
  ],
);

final _buttonAtlas = ComponentAtlas(
  id: 'button',
  label: 'Button',
  rowAxes: const [_variantAxis, _sizeAxis],
  scenarios: const [
    ...AtlasScenarios.interactive,
    AtlasScenario('loading', label: 'Loading', props: {'loading': true}),
  ],
  rows: [
    for (final variant in FortalButtonVariant.values)
      for (final size in FortalButtonSize.values) _buttonRow(variant, size),
  ],
);

AtlasRow _buttonRow(FortalButtonVariant variant, FortalButtonSize size) {
  return AtlasRow(
    '${variant.name}-${size.name}',
    (context, cell) => FortalButton(
      variant: variant,
      size: size,
      enabled: !cell.disabled,
      loading: cell.propOr('loading', false),
      onPressed: () {},
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(Icons.add), Text('Button')],
      ),
    ),
    values: _variantSizeValues(variant, size),
  );
}

final _calloutAtlas = ComponentAtlas(
  id: 'callout',
  label: 'Callout',
  rowAxes: const [_variantAxis],
  scenarios: _contrastScenarios,
  rows: [
    for (final variant in FortalCalloutVariant.values)
      AtlasRow(
        variant.name,
        (context, cell) => SizedBox(
          width: 220,
          child: FortalCallout(
            variant: variant,
            highContrast: cell.propOr('highContrast', false),
            icon: const Icon(Icons.info_outline),
            child: const Text('Callout message.'),
          ),
        ),
        values: _variantValues(variant),
      ),
  ],
);

final _cardAtlas = ComponentAtlas(
  id: 'card',
  label: 'Card',
  rowAxes: const [_variantAxis],
  scenarios: _enabledScenarios,
  rows: [
    for (final variant in FortalCardVariant.values)
      AtlasRow(
        variant.name,
        (context, cell) => SizedBox(
          width: 160,
          child: FortalCard(
            variant: variant,
            size: .size2,
            enabled: !cell.disabled,
            onTap: () {},
            child: const Text('Card content'),
          ),
        ),
        values: _variantValues(variant),
      ),
  ],
);

final _checkboxAtlas = ComponentAtlas(
  id: 'checkbox',
  label: 'Checkbox',
  rowAxes: const [_variantAxis],
  scenarios: _selectableScenarios,
  rows: [
    for (final variant in FortalCheckboxVariant.values)
      AtlasRow(
        variant.name,
        (context, cell) => FortalCheckbox(
          variant: variant,
          size: .size2,
          selected: cell.selected,
          enabled: !cell.disabled,
          onChanged: (_) {},
          semanticLabel: 'Atlas checkbox',
        ),
        values: _variantValues(variant),
      ),
  ],
);

final _dialogAtlas = ComponentAtlas(
  id: 'dialog',
  label: 'Dialog',
  rowAxes: const [_sizeAxis],
  scenarios: _staticScenarios,
  rows: [
    for (final size in FortalDialogSize.values)
      AtlasRow(
        size.name,
        (context, cell) => SizedBox(
          width: 280,
          height: 240,
          child: FortalDialog(
            size: size,
            modal: false,
            width: 240,
            maxWidth: 240,
            title: 'Dialog title',
            description: 'A short dialog description.',
            actions: [
              FortalButton(
                size: .size1,
                variant: .soft,
                onPressed: () {},
                child: const Text('Done'),
              ),
            ],
          ),
        ),
        values: _sizeValues(size),
      ),
  ],
);

final _dividerAtlas = ComponentAtlas(
  id: 'divider',
  label: 'Divider',
  rowAxes: const [_sizeAxis],
  scenarios: _staticScenarios,
  rows: [
    for (final size in FortalDividerSize.values)
      AtlasRow(
        size.name,
        (context, cell) =>
            SizedBox(width: 160, child: FortalDivider(size: size)),
        values: _sizeValues(size),
      ),
  ],
);

final _menuAtlas = ComponentAtlas(
  id: 'menu',
  label: 'Menu',
  rowAxes: const [_variantAxis, _sizeAxis],
  scenarios: _contrastScenarios,
  rows: [
    for (final variant in FortalMenuVariant.values)
      for (final size in FortalMenuSize.values)
        AtlasRow(
          '${variant.name}-${size.name}',
          (context, cell) => _AtlasOpenedMenuCell(
            childBuilder: (controller) => FortalMenu<String>(
              variant: variant,
              size: size,
              highContrast: cell.propOr('highContrast', false),
              controller: controller,
              trigger: const Text('Open menu'),
              entries: const [
                RemixMenuLabel(child: Text('Actions')),
                RemixMenuAction(value: 'edit', child: Text('Edit')),
                RemixMenuCheckboxItem(
                  value: 'pin',
                  checked: true,
                  child: Text('Pinned'),
                ),
              ],
              onSelected: (_) {},
            ),
          ),
          values: _variantSizeValues(variant, size),
        ),
  ],
);

final _iconButtonAtlas = ComponentAtlas(
  id: 'icon_button',
  label: 'Icon Button',
  rowAxes: const [_variantAxis],
  scenarios: AtlasScenarios.interactive,
  rows: [
    for (final variant in FortalIconButtonVariant.values)
      AtlasRow(
        variant.name,
        (context, cell) => FortalIconButton(
          variant: variant,
          size: .size2,
          enabled: !cell.disabled,
          semanticLabel: 'Add item',
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        values: _variantValues(variant),
      ),
  ],
);

final _popoverAtlas = ComponentAtlas(
  id: 'popover',
  label: 'Popover',
  rowAxes: const [_sizeAxis],
  scenarios: _staticScenarios,
  rows: [
    for (final size in FortalPopoverSize.values)
      AtlasRow(
        size.name,
        (context, cell) => _AtlasOpenedMenuCell(
          height: 120,
          childBuilder: (controller) => FortalPopover(
            size: size,
            controller: controller,
            openOnTap: false,
            matchTriggerWidth: false,
            popoverChild: const Text('Popover content'),
            child: const Text('Popover trigger'),
          ),
        ),
        values: _sizeValues(size),
      ),
  ],
);

final _progressAtlas = ComponentAtlas(
  id: 'progress',
  label: 'Progress',
  rowAxes: const [_variantAxis, _sizeAxis],
  scenarios: const [
    AtlasScenario('quarter', label: '25%', props: {'value': 25.0}),
    AtlasScenario('three-quarters', label: '75%', props: {'value': 75.0}),
  ],
  rows: [
    for (final variant in FortalProgressVariant.values)
      for (final size in FortalProgressSize.values)
        AtlasRow(
          '${variant.name}-${size.name}',
          (context, cell) => SizedBox(
            width: 160,
            child: FortalProgress(
              variant: variant,
              size: size,
              value: cell.propOr('value', 25.0),
              semanticLabel: 'Atlas progress',
            ),
          ),
          values: _variantSizeValues(variant, size),
        ),
  ],
);

final _radioAtlas = ComponentAtlas(
  id: 'radio',
  label: 'Radio',
  rowAxes: const [_variantAxis],
  scenarios: _selectableScenarios,
  rows: [
    for (final variant in FortalRadioVariant.values)
      AtlasRow(
        variant.name,
        (context, cell) => FortalRadioGroup<String>(
          value: cell.selected ? 'option' : 'other',
          onChanged: cell.disabled ? null : (_) {},
          child: FortalRadio<String>(
            variant: variant,
            size: .size2,
            value: 'option',
            enabled: !cell.disabled,
          ),
        ),
        values: _variantValues(variant),
      ),
  ],
);

final _selectAtlas = ComponentAtlas(
  id: 'select',
  label: 'Select',
  rowAxes: const [
    AtlasAxis('triggerVariant', 'Trigger variant'),
    AtlasAxis('contentVariant', 'Content variant'),
  ],
  scenarios: _enabledScenarios,
  rows: [
    for (final triggerVariant in FortalSelectTriggerVariant.values)
      for (final contentVariant in FortalSelectContentVariant.values)
        AtlasRow(
          '${triggerVariant.name}-${contentVariant.name}',
          (context, cell) => _AtlasOverlayCell(
            height: 132,
            child: FortalSelect<String>(
              triggerVariant: triggerVariant,
              contentVariant: contentVariant,
              size: .size2,
              trigger: const RemixSelectTrigger(placeholder: 'Choose'),
              entries: const [
                RemixSelectItem(value: 'one', label: 'Option one'),
                RemixSelectItem(value: 'two', label: 'Option two'),
              ],
              selectedValue: 'one',
              open: !cell.disabled,
              enabled: !cell.disabled,
              onChanged: (_) {},
            ),
          ),
          values: {
            'triggerVariant': _axisValue(triggerVariant),
            'contentVariant': _axisValue(contentVariant),
          },
        ),
  ],
);

final _sliderAtlas = ComponentAtlas(
  id: 'slider',
  label: 'Slider',
  rowAxes: const [_variantAxis, _sizeAxis],
  scenarios: const [
    AtlasScenarios.base,
    AtlasScenario(
      'high-contrast',
      label: 'High contrast',
      props: {'highContrast': true},
    ),
    AtlasScenarios.disabled,
  ],
  rows: [
    for (final variant in FortalSliderVariant.values)
      for (final size in FortalSliderSize.values)
        AtlasRow(
          '${variant.name}-${size.name}',
          (context, cell) => SizedBox(
            width: 160,
            child: FortalSlider(
              variant: variant,
              size: size,
              highContrast: cell.propOr('highContrast', false),
              values: const [25, 75],
              enabled: !cell.disabled,
              onChanged: (_) {},
              semanticLabels: const ['Minimum', 'Maximum'],
            ),
          ),
          values: _variantSizeValues(variant, size),
        ),
  ],
);

final _spinnerAtlas = ComponentAtlas(
  id: 'spinner',
  label: 'Spinner',
  rowAxes: const [_sizeAxis],
  scenarios: const [
    AtlasScenario('loading', label: 'Loading', props: {'loading': true}),
    AtlasScenario('ready', label: 'Ready', props: {'loading': false}),
  ],
  rows: [
    for (final size in FortalSpinnerSize.values)
      AtlasRow(
        size.name,
        (context, cell) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: FortalSpinner(
            size: size,
            loading: cell.propOr('loading', true),
            semanticLabel: 'Loading',
            child: const Text('Ready'),
          ),
        ),
        values: _sizeValues(size),
      ),
  ],
);

final _switchAtlas = ComponentAtlas(
  id: 'switch',
  label: 'Switch',
  rowAxes: const [_variantAxis],
  scenarios: _selectableScenarios,
  rows: [
    for (final variant in FortalSwitchVariant.values)
      AtlasRow(
        variant.name,
        (context, cell) => FortalSwitch(
          variant: variant,
          size: .size2,
          selected: cell.selected,
          enabled: !cell.disabled,
          onChanged: (_) {},
          semanticLabel: 'Atlas switch',
        ),
        values: _variantValues(variant),
      ),
  ],
);

final _tabsAtlas = ComponentAtlas(
  id: 'tabs',
  label: 'Tabs',
  rowAxes: const [_sizeAxis],
  scenarios: _selectableScenarios,
  rows: [
    for (final size in FortalTabsSize.values)
      AtlasRow(
        size.name,
        (context, cell) => SizedBox(
          width: 180,
          height: 50,
          child: RemixTabs(
            selectedTabId: cell.selected ? 'second' : 'first',
            enabled: !cell.disabled,
            onChanged: (_) {},
            child: FortalTabBar(
              size: size,
              children: const [
                FortalTab(tabId: 'first', label: 'First'),
                FortalTab(tabId: 'second', label: 'Second'),
              ],
            ),
          ),
        ),
        values: _sizeValues(size),
      ),
  ],
);

final _textFieldAtlas = ComponentAtlas(
  id: 'text_field',
  label: 'Text Field',
  rowAxes: const [_variantAxis],
  scenarios: const [
    AtlasScenarios.base,
    AtlasScenarios.focused,
    AtlasScenarios.error,
    AtlasScenarios.disabled,
  ],
  rows: [
    for (final variant in FortalTextFieldVariant.values)
      AtlasRow(
        variant.name,
        (context, cell) => SizedBox(
          width: 220,
          child: FortalTextField(
            variant: variant,
            size: .size2,
            label: 'Email',
            hintText: 'you@example.com',
            helperText: cell.error ? 'Enter a valid address' : 'Work email',
            error: cell.error,
            enabled: !cell.disabled,
            leading: const Icon(Icons.email_outlined),
          ),
        ),
        values: _variantValues(variant),
      ),
  ],
);

final _tooltipAtlas = ComponentAtlas(
  id: 'tooltip',
  label: 'Tooltip',
  scenarios: const [
    AtlasScenario('closed', label: 'Closed', props: {'open': false}),
    AtlasScenario('open', label: 'Open', props: {'open': true}),
  ],
  rows: [
    AtlasRow(
      'default',
      (context, cell) => _AtlasOverlayCell(
        height: 72,
        alignment: Alignment.bottomCenter,
        child: FortalTooltip(
          open: cell.propOr('open', false),
          onOpenChanged: (_) {},
          tooltipChild: const Text('Helpful context'),
          tooltipSemantics: 'Helpful context',
          child: const Icon(Icons.info_outline),
        ),
      ),
    ),
  ],
);

final _accordionAtlas = ComponentAtlas(
  id: 'accordion',
  label: 'Accordion',
  rowAxes: const [_variantAxis, _sizeAxis],
  scenarios: const [
    AtlasScenario('collapsed', label: 'Collapsed'),
    AtlasScenario('expanded', label: 'Expanded', props: {'expanded': true}),
    AtlasScenarios.disabled,
  ],
  rows: [
    for (final variant in FortalAccordionVariant.values)
      for (final size in FortalAccordionSize.values)
        AtlasRow(
          '${variant.name}-${size.name}',
          (context, cell) => SizedBox(
            width: 240,
            child: _AtlasAccordionCell(
              variant: variant,
              size: size,
              expanded: cell.propOr('expanded', false),
              enabled: !cell.disabled,
            ),
          ),
          values: _variantSizeValues(variant, size),
        ),
  ],
);

final _toggleAtlas = ComponentAtlas(
  id: 'toggle',
  label: 'Toggle',
  rowAxes: const [_variantAxis, _sizeAxis],
  scenarios: _selectableScenarios,
  rows: [
    for (final variant in FortalToggleVariant.values)
      for (final size in FortalToggleSize.values)
        AtlasRow(
          '${variant.name}-${size.name}',
          (context, cell) => FortalToggle(
            variant: variant,
            size: size,
            selected: cell.selected,
            enabled: !cell.disabled,
            onChanged: (_) {},
            icon: Icons.format_bold,
            semanticLabel: 'Bold',
          ),
          values: _variantSizeValues(variant, size),
        ),
  ],
);

final _toggleGroupAtlas = ComponentAtlas(
  id: 'toggle_group',
  label: 'Toggle Group',
  rowAxes: const [_variantAxis, _sizeAxis],
  scenarios: _enabledScenarios,
  rows: [
    for (final variant in FortalToggleGroupVariant.values)
      for (final size in FortalToggleGroupSize.values)
        AtlasRow(
          '${variant.name}-${size.name}',
          (context, cell) => FortalToggleGroup<String>(
            variant: variant,
            size: size,
            selectedValue: 'center',
            enabled: !cell.disabled,
            onChanged: (_) {},
            semanticLabel: 'Text alignment',
            items: const [
              RemixToggleGroupItem(
                value: 'left',
                icon: Icons.format_align_left,
                semanticLabel: 'Align left',
              ),
              RemixToggleGroupItem(
                value: 'center',
                icon: Icons.format_align_center,
                semanticLabel: 'Align center',
              ),
              RemixToggleGroupItem(
                value: 'right',
                icon: Icons.format_align_right,
                semanticLabel: 'Align right',
              ),
            ],
          ),
          values: _variantSizeValues(variant, size),
        ),
  ],
);

Map<String, AtlasAxisValue> _variantValues(Enum variant) => {
  'variant': _axisValue(variant),
};

Map<String, AtlasAxisValue> _sizeValues(Enum size) => {
  'size': _axisValue(size),
};

Map<String, AtlasAxisValue> _variantSizeValues(Enum variant, Enum size) => {
  'variant': _axisValue(variant),
  'size': _axisValue(size),
};

AtlasAxisValue _axisValue(Enum value) =>
    AtlasAxisValue(value.name, _enumLabel(value.name));

String _enumLabel(String value) {
  if (value.startsWith('size')) return 'Size ${value.substring(4)}';
  final spaced = value.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (match) => '${match[1]} ${match[2]}',
  );

  return '${spaced[0].toUpperCase()}${spaced.substring(1)}';
}

class _AtlasOverlayCell extends StatelessWidget {
  const _AtlasOverlayCell({
    required this.child,
    this.height = 144,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final double height;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 176,
    height: height,
    child: AtlasOverlayHost(
      child: Align(alignment: alignment, child: child),
    ),
  );
}

class _AtlasOpenedMenuCell extends StatefulWidget {
  const _AtlasOpenedMenuCell({required this.childBuilder, this.height = 144});

  final Widget Function(MenuController controller) childBuilder;
  final double height;

  @override
  State<_AtlasOpenedMenuCell> createState() => _AtlasOpenedMenuCellState();
}

class _AtlasOpenedMenuCellState extends State<_AtlasOpenedMenuCell> {
  final MenuController _controller = MenuController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_controller.isOpen) _controller.open();
    });
  }

  @override
  Widget build(BuildContext context) => _AtlasOverlayCell(
    height: widget.height,
    child: widget.childBuilder(_controller),
  );
}

class _AtlasAccordionCell extends StatefulWidget {
  const _AtlasAccordionCell({
    required this.variant,
    required this.size,
    required this.expanded,
    required this.enabled,
  });

  final FortalAccordionVariant variant;
  final FortalAccordionSize size;
  final bool expanded;
  final bool enabled;

  @override
  State<_AtlasAccordionCell> createState() => _AtlasAccordionCellState();
}

class _AtlasAccordionCellState extends State<_AtlasAccordionCell> {
  late final RemixAccordionController<String> _controller;

  @override
  void initState() {
    super.initState();
    _controller = RemixAccordionController<String>(max: 1);
    if (widget.expanded) _controller.open('item');
  }

  @override
  void didUpdateWidget(_AtlasAccordionCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expanded == oldWidget.expanded) return;
    if (widget.expanded) {
      _controller.open('item');
    } else {
      _controller.close('item');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RemixAccordionGroup<String>(
    controller: _controller,
    child: FortalAccordion<String>(
      variant: widget.variant,
      size: widget.size,
      value: 'item',
      title: 'Is it accessible?',
      enabled: widget.enabled,
      child: const Text('Yes. Keyboard and semantics behavior are covered.'),
    ),
  );
}
