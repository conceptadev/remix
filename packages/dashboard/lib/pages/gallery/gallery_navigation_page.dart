import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/gallery_scaffold.dart';

class GalleryNavigationPage extends StatelessWidget {
  const GalleryNavigationPage({super.key});

  @override
  Widget build(BuildContext context) => GalleryPage(
    title: 'Navigation',
    intro: 'Tabs and disclosure patterns for organizing dense interfaces.',
    sections: [
      GallerySection(
        label: 'Tabs',
        description: 'Both tab sizes with live keyboard and pointer selection.',
        child: GalleryMatrix(
          rows: const ['Tabs'],
          columns: FortalTabsSize.values.map(galleryLabel).toList(),
          cellWidth: 320,
          cellBuilder: (_, _, column) =>
              _TabsDemo(size: FortalTabsSize.values[column]),
        ),
      ),
      GallerySection(
        label: 'Accordion',
        description: 'Surface and soft disclosure items across three sizes.',
        child: GalleryMatrix(
          rows: FortalAccordionVariant.values.map(galleryLabel).toList(),
          columns: FortalAccordionSize.values.map(galleryLabel).toList(),
          cellWidth: 300,
          cellBuilder: (_, row, column) => _AccordionDemo(
            variant: FortalAccordionVariant.values[row],
            size: FortalAccordionSize.values[column],
          ),
        ),
      ),
    ],
  );
}

class _TabsDemo extends StatefulWidget {
  const _TabsDemo({required this.size});
  final FortalTabsSize size;

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
        FortalTabBar(
          size: widget.size,
          children: const [
            FortalTab(tabId: 'overview', label: 'Overview'),
            FortalTab(tabId: 'activity', label: 'Activity'),
          ],
        ),
        FortalTabView(
          tabId: 'overview',
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Overview content'),
          ),
        ),
        FortalTabView(
          tabId: 'activity',
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Text('Activity content'),
          ),
        ),
      ],
    ),
  );
}

class _AccordionDemo extends StatefulWidget {
  const _AccordionDemo({required this.variant, required this.size});
  final FortalAccordionVariant variant;
  final FortalAccordionSize size;

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
      children: [
        FortalAccordion<String>(
          variant: widget.variant,
          size: widget.size,
          value: 'details',
          title: 'What is Fortal?',
          child: const Text(
            'A Radix-inspired theme and component system for Flutter.',
          ),
        ),
        FortalAccordion<String>(
          variant: widget.variant,
          size: widget.size,
          value: 'tokens',
          title: 'Does it support tokens?',
          child: const Text(
            'Every recipe resolves through the active Mix scope.',
          ),
        ),
      ],
    ),
  );
}
