import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Progress Component', type: RemixProgress)
Widget buildProgressUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          child: FortalProgress(
            variant: context.knobs.object.dropdown(
              label: 'variant',
              options: FortalProgressVariant.values,
              labelBuilder: (variant) => variant.name,
            ),
            size: context.knobs.object.dropdown(
              label: 'size',
              options: FortalProgressSize.values,
              labelBuilder: (size) => size.name,
              initialOption: FortalProgressSize.size2,
            ),
            value: context.knobs.double.slider(
              label: 'value',
              min: 0,
              max: 1,
              initialValue: 0.5,
            ),
          ),
        ),
      ),
    ),
  );
}
