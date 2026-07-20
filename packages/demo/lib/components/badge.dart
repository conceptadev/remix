import 'package:flutter/material.dart' hide Badge;
import 'package:remix/remix.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Badge Component', type: RemixBadge)
Widget buildBadgeUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: FortalBadge(
          variant: context.knobs.object.dropdown(
            label: 'variant',
            options: FortalBadgeVariant.values,
            labelBuilder: (variant) => variant.name,
          ),
          size: context.knobs.object.dropdown(
            label: 'size',
            options: FortalBadgeSize.values,
            labelBuilder: (size) => size.name,
            initialOption: FortalBadgeSize.size2,
          ),
          child: Text(
            context.knobs.string(label: 'Label', initialValue: 'New'),
          ),
        ),
      ),
    ),
  );
}
