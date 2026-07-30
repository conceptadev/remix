import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Menu Component', type: RemixMenu)
Widget buildMenuUseCase(BuildContext context) {
  final variant = context.knobs.object.dropdown(
    label: 'Variant',
    options: FortalMenuVariant.values,
    initialOption: FortalMenuVariant.solid,
    labelBuilder: (value) => value.name,
  );

  final size = context.knobs.object.dropdown(
    label: 'Size',
    options: FortalMenuSize.values,
    initialOption: FortalMenuSize.size2,
    labelBuilder: (value) => value.name,
  );

  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: FortalMenu(
              positioning: const OverlayPositionConfig(
                side: .bottom,
                alignment: .center,
              ),
              trigger: const RemixMenuTrigger(
                label: 'Menu',
                icon: Icons.keyboard_arrow_down,
              ),
              variant: variant,
              size: size,
              items: [
                const RemixMenuItem(label: 'Item 1', value: 'item1'),
                const RemixMenuItem(label: 'Item 2', value: 'item2'),
                const RemixMenuItem(label: 'Item 3', value: 'item3'),
              ],
              onSelected: (value) {},
            ),
          ),
        ),
      ),
    ),
  );
}
