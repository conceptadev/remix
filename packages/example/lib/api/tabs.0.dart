import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by Gov UK Design System
// https://design-system.service.gov.uk/components/tabs/

void main() {
  runApp(
    const FortalScope(
      child: MaterialApp(
        home: Scaffold(backgroundColor: Colors.white, body: TabsExample()),
      ),
    ),
  );
}

class TabsExample extends StatefulWidget {
  const TabsExample({super.key});

  @override
  State<TabsExample> createState() => _TabsExampleState();
}

class _TabsExampleState extends State<TabsExample> {
  String _tab = 'tab1';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 320,
        height: 280,
        child: RemixTabs(
          selectedTabId: _tab,
          onChanged: (id) => setState(() => _tab = id),
          child: Column(
            mainAxisSize: .max,
            crossAxisAlignment: .stretch,
            children: [
              RemixTabBar(
                style: tabBarStyle,
                children: [
                  RemixTab(tabId: 'tab1', style: tabStyle, label: 'Tab 1'),
                  const SizedBox(width: 8),
                  RemixTab(tabId: 'tab2', style: tabStyle, label: 'Tab 2'),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: RemixTabView(
                  tabId: 'tab1',
                  style: tabViewStyle,
                  child: const SizedBox.expand(
                    child: Align(
                      alignment: .topLeft,
                      child: Text('Content for Tab 1'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RemixTabView(
                  tabId: 'tab2',
                  style: tabViewStyle,
                  child: const SizedBox.expand(
                    child: Align(
                      alignment: .topLeft,
                      child: Text('Content for Tab 2'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RemixTabBarStyler get tabBarStyle {
    return RemixTabBarStyler()
        .paddingAll(4)
        .borderRounded(12)
        .color(const Color(0xFFF4F6FF))
        .borderAll(color: Colors.indigo.shade100)
        .shadowOnly(
          color: Colors.indigo.withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 12),
        );
  }

  RemixTabStyler get tabStyle {
    return RemixTabStyler()
        .paddingX(18)
        .paddingY(10)
        .borderRounded(10)
        .color(Colors.transparent)
        .labelFontSize(14)
        .labelFontWeight(FontWeight.w600)
        .labelColor(Colors.indigo.shade600)
        .iconColor(Colors.indigo.shade500)
        .onHovered(
          RemixTabStyler()
              .color(Colors.indigo.shade50)
              .labelColor(Colors.indigo.shade700),
        )
        .onPressed(RemixTabStyler().color(Colors.indigo.shade100))
        .onSelected(
          RemixTabStyler()
              .color(Colors.white)
              .borderAll(color: Colors.indigo.shade400, width: 2)
              .shadowOnly(
                color: Colors.indigo.withValues(alpha: 0.16),
                blurRadius: 26,
                offset: const Offset(0, 10),
              )
              .labelColor(Colors.indigo.shade700)
              .iconColor(Colors.indigo.shade600),
        );
  }

  RemixTabViewStyler get tabViewStyle {
    return RemixTabViewStyler()
        .paddingAll(20)
        .borderRounded(14)
        .color(Colors.white)
        .borderAll(color: Colors.indigo.shade100)
        .shadowOnly(
          color: Colors.indigo.withValues(alpha: 0.1),
          blurRadius: 32,
          offset: const Offset(0, 16),
        );
  }
}
