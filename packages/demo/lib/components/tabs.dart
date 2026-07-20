import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();
final _tabState = _TabState('tab1');

@widgetbook.UseCase(name: 'Tabs Component', type: RemixTabs)
Widget buildTabsUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: ListenableBuilder(
              listenable: _tabState,
              builder: (context, child) {
                return RemixTabs(
                  selectedTabId: _tabState.value,
                  onChanged: (id) {
                    _tabState.update(id);
                  },
                  child: ColumnBox(
                    style: FlexBoxStyler().spacing(12),
                    children: [
                      FortalTabBar(
                        children: [
                          FortalTab(tabId: 'tab1', label: 'Tab 1'),
                          FortalTab(tabId: 'tab2', label: 'Tab 2'),
                        ],
                      ),
                      const RowBox(
                        children: [
                          FortalTabView(
                            tabId: 'tab1',
                            child: Text('Content of tab 1'),
                          ),
                          FortalTabView(
                            tabId: 'tab2',
                            child: Text('Content of tab 2'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}

class _TabState extends ValueNotifier<String> {
  _TabState(super.value);

  void update(String value) {
    this.value = value;
    notifyListeners();
  }
}
