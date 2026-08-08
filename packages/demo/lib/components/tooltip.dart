import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Tooltip Component', type: RemixTooltip)
Widget buildTooltipUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: Center(
            child: FortalTooltip(
              tooltipChild: const Text('Tooltip content'),
              child: FortalButton(label: 'Hover me', onPressed: () {}),
            ),
          ),
        ),
      ),
    ),
  );
}
