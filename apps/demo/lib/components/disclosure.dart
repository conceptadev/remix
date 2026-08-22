import 'package:demo/helpers/catalog.dart';
import 'package:demo/helpers/use_case_state.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _remixKey = GlobalKey();
final _fortalKey = GlobalKey();

@widgetbook.UseCase(name: 'Remix', type: RemixDisclosure)
Widget buildRemixDisclosureUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _remixKey,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: RemixDisclosure(
            defaultExpanded: true,
            trigger: const Text('When will my order arrive?'),
            content: const Text(
              'Standard delivery takes 3–5 business days. Tracking is sent '
              'as soon as your order leaves the warehouse.',
            ),
            triggerBuilder: (context, state, child) =>
                _DisclosureTrigger(expanded: state.isExpanded, child: child!),
            style: _remixDisclosureStyle(Theme.of(context).colorScheme),
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Fortal', type: RemixDisclosure)
Widget buildFortalDisclosureUseCase(BuildContext context) {
  final knobState = WidgetbookState.of(context);
  final expanded = context.knobs.boolean(label: 'Expanded', initialValue: true);

  return KeyedSubtree(
    key: _fortalKey,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: FortalDisclosure(
            expanded: expanded,
            onExpandedChanged: (value) {
              knobState.updateKnob('Expanded', value);
            },
            enabled: context.knobs.boolean(
              label: 'Enabled',
              initialValue: true,
            ),
            variant: context.knobs.object.dropdown(
              label: 'Variant',
              options: FortalDisclosureVariant.values,
              labelBuilder: (variant) => variant.name,
              initialOption: FortalDisclosureVariant.surface,
            ),
            size: context.knobs.object.dropdown(
              label: 'Size',
              options: FortalDisclosureSize.values,
              labelBuilder: (size) => size.name,
              initialOption: FortalDisclosureSize.size2,
            ),
            trigger: const Text('Account details'),
            content: const Text(
              'Your profile, contact information, and preferences are kept '
              'together in this section.',
            ),
            triggerBuilder: (context, state, child) =>
                _DisclosureTrigger(expanded: state.isExpanded, child: child!),
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Catalog', type: RemixDisclosure)
Widget buildDisclosureCatalogUseCase(BuildContext context) {
  return CatalogMatrix(
    cellWidth: 300,
    columns: labelsOf(FortalDisclosureSize.values),
    rows: labelsOf(FortalDisclosureVariant.values),
    cell: (row, column) => SizedBox(
      width: 280,
      child: FortalDisclosure(
        defaultExpanded: true,
        variant: FortalDisclosureVariant.values[row],
        size: FortalDisclosureSize.values[column],
        trigger: const Text('Shipping details'),
        content: const Text('Delivery takes 3–5 business days.'),
        triggerBuilder: (context, state, child) =>
            _DisclosureTrigger(expanded: state.isExpanded, child: child!),
      ),
    ),
  );
}

DisclosureStyler _remixDisclosureStyle(ColorScheme colors) {
  final border = BorderSideMix(color: colors.outlineVariant, width: 1);

  return DisclosureStyler()
      .container(
        BoxStyler()
            .clipBehavior(.antiAlias)
            .borderRadius(.circular(12))
            .border(.all(border))
            .color(colors.surface),
      )
      .trigger(
        BoxStyler()
            .width(.infinity)
            .alignment(.centerLeft)
            .padding(.all(16))
            .color(colors.surfaceContainerLow),
      )
      .content(
        BoxStyler()
            .width(.infinity)
            .padding(.all(16))
            .foregroundDecoration(
              BoxDecorationMix(border: BoxBorderMix.top(border)),
            ),
      )
      .onHovered(
        DisclosureStyler().trigger(
          BoxStyler().color(colors.surfaceContainerHighest),
        ),
      )
      .onPressed(
        DisclosureStyler().trigger(
          BoxStyler().color(colors.secondaryContainer),
        ),
      )
      .onFocusVisible(
        DisclosureStyler().trigger(
          BoxStyler().border(
            .all(BorderSideMix(color: colors.primary, width: 2)),
          ),
        ),
      )
      .onDisabled(
        DisclosureStyler().trigger(BoxStyler().color(colors.surfaceContainer)),
      );
}

class _DisclosureTrigger extends StatelessWidget {
  const _DisclosureTrigger({required this.expanded, required this.child});

  final bool expanded;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
        AnimatedRotation(
          turns: expanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 200),
          child: const Icon(Icons.keyboard_arrow_down_rounded),
        ),
      ],
    );
  }
}
