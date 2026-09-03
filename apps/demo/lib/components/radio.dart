import 'package:demo/helpers/catalog.dart';
import 'package:demo/helpers/string.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

enum Theme { dark, light, system }

@widgetbook.UseCase(name: 'Radio Component', type: RemixRadio)
Widget buildRadioUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: ListenableBuilder(
          listenable: _state,
          builder: (context, child) {
            return RemixRadioGroup<Theme>(
              groupValue: _state.value,
              onChanged: (value) {
                _state.update(value!);
              },
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: Theme.values
                    .map(
                      (theme) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisSize: .min,
                          children: [
                            FortalRadio(
                              semanticLabel: 'Option',
                              variant: context.knobs.object.dropdown(
                                label: 'variant',
                                options: FortalRadioVariant.values,
                                labelBuilder: (variant) => variant.name,
                              ),
                              size: context.knobs.object.dropdown(
                                label: 'size',
                                options: FortalRadioSize.values,
                                labelBuilder: (size) => size.name,
                                initialOption: FortalRadioSize.size2,
                              ),
                              value: theme,
                              enabled: context.knobs.boolean(
                                label: 'Enabled',
                                initialValue: true,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(theme.name.capitalize()),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    ),
  );
}

class _ThemeState extends ValueNotifier<Theme> {
  _ThemeState(super.value);

  void update(Theme value) {
    this.value = value;
    notifyListeners();
  }
}

_ThemeState _state = _ThemeState(Theme.dark);

@widgetbook.UseCase(name: 'Catalog', type: RemixRadio)
Widget buildRadioCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    columns: labelsOf(FortalRadioSize.values),
    rows: labelsOf(FortalRadioVariant.values),
    // A radio reads its selected state from the group above it, so each cell
    // carries its own group with that cell's value already selected.
    cell: (row, column) => RemixRadioGroup<String>(
      groupValue: 'on',
      child: FortalRadio<String>(
        semanticLabel: 'Option',
        value: 'on',
        size: FortalRadioSize.values[column],
        variant: FortalRadioVariant.values[row],
      ),
    ),
  );
}
