import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import '../../ui/ui.dart';

import '../../utils/text.dart';
import '../../widgets/disclosure_trigger.dart';
import '../../widgets/gallery_scaffold.dart';

class GalleryNavigationPage extends StatelessWidget {
  const GalleryNavigationPage({super.key});

  @override
  Widget build(BuildContext context) => GalleryPage(
    title: 'Navigation',
    intro:
        'Sectioned navigation, tabs, disclosures, and accordions for organizing dense interfaces.',
    sections: [
      const GallerySection(
        label: 'Sidebar',
        description:
            'A controlled Fortal sidebar with a fixed header and footer, a scrolling destination region, headings, selected state, and ordinary Tab traversal.',
        child: _SidebarDemo(),
      ),
      GallerySection(
        label: 'Tabs',
        description: 'Both tab sizes with live keyboard and pointer selection.',
        child: GalleryMatrix<String, UiTabsSize>(
          rows: const ['Tabs'],
          columns: UiTabsSize.values,
          rowLabelBuilder: (label) => label,
          columnLabelBuilder: enumLabel,
          cellWidth: 320,
          cellBuilder: (_, _, size) => _TabsDemo(size: size),
        ),
      ),
      GallerySection(
        label: 'Disclosure',
        description:
            'Independent expandable panels in every Fortal variant and size.',
        child: GalleryEnumMatrix(
          rows: UiDisclosureVariant.values,
          columns: UiDisclosureSize.values,
          cellWidth: 300,
          cellBuilder: (_, variant, size) =>
              _DisclosureDemo(variant: variant, size: size),
        ),
      ),
      GallerySection(
        label: 'Accordion',
        description:
            'Coordinated disclosure items where only one panel stays open.',
        child: GalleryEnumMatrix(
          rows: UiAccordionVariant.values,
          columns: UiAccordionSize.values,
          cellWidth: 300,
          cellBuilder: (_, variant, size) =>
              _AccordionDemo(variant: variant, size: size),
        ),
      ),
    ],
  );
}

class _SidebarDemo extends StatefulWidget {
  const _SidebarDemo();

  @override
  State<_SidebarDemo> createState() => _SidebarDemoState();
}

class _SidebarDemoState extends State<_SidebarDemo> {
  static const _sections = <RemixSidebarSection<String>>[
    RemixSidebarSection(
      label: 'Workspace',
      destinations: [
        RemixSidebarDestination(
          value: 'overview',
          label: 'Overview',
          icon: Icons.space_dashboard_outlined,
        ),
        RemixSidebarDestination(
          value: 'activity',
          label: 'Activity',
          icon: Icons.timeline_outlined,
        ),
      ],
    ),
    RemixSidebarSection(
      label: 'Manage',
      destinations: [
        RemixSidebarDestination(
          value: 'settings',
          label: 'Settings',
          icon: Icons.settings_outlined,
        ),
      ],
    ),
  ];

  String _selected = 'overview';

  @override
  // Align loosens the stretched section constraints so the panel keeps the
  // width and height a host would give it. The bounded height shows the
  // destination region scrolling while the header and footer stay put.
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerLeft,
    child: SizedBox(
      width: 280,
      height: 320,
      child: UiSidebar<String>(
        header: const _SidebarDemoHeader(),
        sections: _sections,
        selectedValue: _selected,
        onSelected: (value) => setState(() => _selected = value),
        footer: const _SidebarDemoFooter(),
        semanticLabel: 'Gallery navigation example',
      ),
    ),
  );
}

class _SidebarDemoHeader extends StatelessWidget {
  const _SidebarDemoHeader();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    child: const UiText('Acme', size: .size4, weight: .bold),
  );
}

class _SidebarDemoFooter extends StatelessWidget {
  const _SidebarDemoFooter();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(14),
    child: Row(
      spacing: 10,
      children: [
        const UiAvatar(label: 'AC', size: .size1),
        const UiText('Ada Chen', size: .size2, weight: .medium),
      ],
    ),
  );
}

class _DisclosureDemo extends StatelessWidget {
  const _DisclosureDemo({required this.variant, required this.size});

  final UiDisclosureVariant variant;
  final UiDisclosureSize size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 280,
    child: UiDisclosure(
      key: ValueKey('disclosure-${variant.name}-${size.name}'),
      variant: variant,
      size: size,
      defaultExpanded: true,
      animationStyle: dashboardDisclosureAnimationStyle,
      semanticLabel:
          '${enumLabel(variant)} ${enumLabel(size)} shipping details',
      semanticHint: 'Toggles shipping details',
      trigger: const Text('Shipping details'),
      triggerBuilder: (context, state, child) =>
          DashboardDisclosureTrigger(expanded: state.isExpanded, child: child!),
      content: const Text('Delivery takes 3–5 business days.'),
    ),
  );
}

class _TabsDemo extends StatefulWidget {
  const _TabsDemo({required this.size});
  final UiTabsSize size;

  @override
  State<_TabsDemo> createState() => _TabsDemoState();
}

class _TabsDemoState extends State<_TabsDemo> {
  String _selected = 'overview';

  @override
  Widget build(BuildContext context) => RemixTabs(
    selectedTabId: _selected,
    onChanged: (value) => setState(() => _selected = value),
    child: Column(
      crossAxisAlignment: .stretch,
      spacing: 10,
      children: [
        UiTabBar(
          child: Row(
            children: [
              UiTab(size: widget.size, tabId: 'overview', label: 'Overview'),
              UiTab(size: widget.size, tabId: 'activity', label: 'Activity'),
            ],
          ),
        ),
        UiTabView(
          tabId: 'overview',
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: UiText('Overview content'),
          ),
        ),
        UiTabView(
          tabId: 'activity',
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: UiText('Activity content'),
          ),
        ),
      ],
    ),
  );
}

class _AccordionDemo extends StatefulWidget {
  const _AccordionDemo({required this.variant, required this.size});
  final UiAccordionVariant variant;
  final UiAccordionSize size;

  @override
  State<_AccordionDemo> createState() => _AccordionDemoState();
}

class _AccordionDemoState extends State<_AccordionDemo> {
  final _controller = RemixAccordionController<String>(max: 1);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RemixAccordionGroup<String>(
    controller: _controller,
    initialExpandedValues: const ['details'],
    child: Column(
      spacing: 8,
      children: [
        UiAccordion<String>(
          variant: widget.variant,
          size: widget.size,
          value: 'details',
          title: 'What is Fortal?',
          child: const UiText(
            'A Radix-inspired theme and component system for Flutter.',
          ),
        ),
        UiAccordion<String>(
          variant: widget.variant,
          size: widget.size,
          value: 'tokens',
          title: 'Does it support tokens?',
          child: const UiText(
            'Every recipe resolves through the active Mix scope.',
          ),
        ),
      ],
    ),
  );
}
