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

@widgetbook.UseCase(name: 'Button Component', type: RemixButton)
Widget buildButtonUseCase(BuildContext context) {
  final label = context.knobs.string(label: 'label', initialValue: 'Press Me');
  final leadingIcon = context.knobs.iconData(
    label: 'Leading Icon',
    initialValue: null,
  );
  final trailingIcon = context.knobs.iconData(
    label: 'Trailing Icon',
    initialValue: null,
  );
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: FortalButton(
          onPressed: () {
            _showToast(context, 'RemixButton pressed');
          },
          onLongPress:
              context.knobs.boolean(
                label: 'Enable Long Press',
                initialValue: true,
              )
              ? () {
                  _showToast(context, 'RemixButton long pressed');
                }
              : null,
          enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
          loading: context.knobs.boolean(label: 'Loading', initialValue: false),
          variant: context.knobs.object.dropdown(
            label: 'variant',
            options: FortalButtonVariant.values,
            labelBuilder: (variant) => variant.name,
          ),
          size: context.knobs.object.dropdown(
            label: 'size',
            options: FortalButtonSize.values,
            labelBuilder: (size) => size.name,
            initialOption: FortalButtonSize.size2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (leadingIcon != null) Icon(leadingIcon),
              Text(label),
              if (trailingIcon != null) Icon(trailingIcon),
            ],
          ),
        ),
      ),
    ),
  );
}
