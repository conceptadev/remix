import 'package:demo/addons/icon_data_knob.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

void _showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1200),
    ),
  );
}

@widgetbook.UseCase(name: 'Icon Button Component', type: RemixIconButton)
Widget buildIconButtonUseCase(BuildContext context) {
  final icon = context.knobs.iconData(label: 'Icon', initialValue: Icons.add)!;
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: FortalIconButton(
          onPressed: () {
            _showToast(context, 'RemixIconButton pressed');
          },
          enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
          loading: context.knobs.boolean(label: 'Loading', initialValue: false),
          semanticLabel: 'Activate ${icon.codePoint}',
          size: context.knobs.object.dropdown(
            label: 'size',
            options: FortalIconButtonSize.values,
            labelBuilder: (size) => size.name,
            initialOption: FortalIconButtonSize.size2,
          ),
          variant: context.knobs.object.dropdown(
            label: 'variant',
            options: FortalIconButtonVariant.values,
            labelBuilder: (variant) => variant.name,
          ),
          child: Icon(icon),
        ),
      ),
    ),
  );
}
