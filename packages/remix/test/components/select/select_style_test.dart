import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

import '../../helpers/test_helpers.dart';

void main() {
  testWidgets('select styler resolves every structural slot', (tester) async {
    late StyleSpec<RemixSelectSpec> resolved;
    await tester.pumpRemixApp(
      Builder(
        builder: (context) {
          resolved = RemixSelectStyler(
            trigger: RemixSelectTriggerStyler(
              label: TextStyler().color(Colors.red),
              placeholder: TextStyler().color(Colors.orange),
              effects: RemixSurfaceEffectsMix(
                background: RemixSurfaceLayerMix(
                  shadows: [RemixPaintShadowMix(color: Colors.pink)],
                ),
                foreground: RemixSurfaceLayerMix(
                  shadows: [RemixPaintShadowMix(color: Colors.purple)],
                ),
              ),
            ),
            content: RemixSelectContentStyler(
              container: BoxStyler().paddingAll(12),
              effects: RemixSurfaceEffectsMix(
                background: RemixSurfaceLayerMix(
                  shadows: [RemixPaintShadowMix(color: Colors.blue)],
                ),
              ),
            ),
            item: RemixSelectMenuItemStyler(
              text: TextStyler().color(Colors.green),
              indicator: BoxStyler().width(20),
              icon: IconStyler(color: Colors.yellow),
            ),
            label: RemixSelectLabelStyler(
              text: TextStyler().color(Colors.cyan),
              adjacentItemSpacing: 8,
            ),
            separator: BoxStyler().height(1).color(Colors.grey),
          ).resolve(context);
          return const SizedBox.shrink();
        },
      ),
    );

    final spec = resolved.spec;
    expect(spec.trigger.spec.label.spec.style?.color, Colors.red);
    expect(spec.trigger.spec.placeholder.spec.style?.color, Colors.orange);
    expect(
      spec.trigger.spec.effects?.background?.shadows.first.color,
      Colors.pink,
    );
    expect(
      spec.trigger.spec.effects?.foreground?.shadows.first.color,
      Colors.purple,
    );
    expect(
      spec.content.spec.effects?.background?.shadows.first.color,
      Colors.blue,
    );
    expect(spec.item.spec.text.spec.style?.color, Colors.green);
    expect(spec.item.spec.icon.spec.color, Colors.yellow);
    expect(spec.label.spec.text.spec.style?.color, Colors.cyan);
    expect(spec.label.spec.adjacentItemSpacing, 8);
    expect(
      (spec.separator.spec.decoration as BoxDecoration?)?.color,
      Colors.grey,
    );
  });

  test('merge is immutable and preserves unrelated slots', () {
    final base = RemixSelectStyler(
      trigger: RemixSelectTriggerStyler().label(TextStyler().color(Colors.red)),
    );
    final merged = base.merge(
      RemixSelectStyler(content: RemixSelectContentStyler().color(Colors.blue)),
    );

    expect(base.$content, isNull);
    expect(merged.$trigger, base.$trigger);
    expect(merged.$content, isNotNull);
  });

  test('styler call forwards behavior and structural inputs', () {
    final triggerWrapper = (BuildContext context, Widget child) => child;
    final contentWrapper = (BuildContext context, Widget child) => child;
    final chevronBuilder =
        (BuildContext context, StyleSpec<IconSpec> styleSpec) =>
            const SizedBox.shrink();
    final indicatorBuilder =
        (BuildContext context, StyleSpec<IconSpec> styleSpec) =>
            const SizedBox.shrink();
    const entries = <RemixSelectEntry<String>>[
      RemixSelectItem(value: 'a', label: 'A'),
    ];
    final styler = RemixSelectStyler();

    final select = styler.call<String>(
      trigger: const RemixSelectTrigger(placeholder: 'Choose'),
      entries: entries,
      enabled: false,
      closeOnSelect: false,
      triggerWrapper: triggerWrapper,
      contentWrapper: contentWrapper,
      triggerChevronBuilder: chevronBuilder,
      itemIndicatorBuilder: indicatorBuilder,
    );

    expect(select.style, same(styler));
    expect(select.entries, same(entries));
    expect(select.enabled, isFalse);
    expect(select.closeOnSelect, isFalse);
    expect(select.triggerWrapper, same(triggerWrapper));
    expect(select.contentWrapper, same(contentWrapper));
    expect(select.triggerChevronBuilder, same(chevronBuilder));
    expect(select.itemIndicatorBuilder, same(indicatorBuilder));
    expect(select.positioning.sideOffset, 4);
  });

  test('part conveniences target the intended nested slot', () {
    expect(
      RemixSelectTriggerStyler().flex(FlexStyler(spacing: 6)),
      RemixSelectTriggerStyler(
        container: FlexBoxStyler().flex(FlexStyler(spacing: 6)),
      ),
    );
    expect(
      RemixSelectLabelStyler().labelColor(Colors.red),
      RemixSelectLabelStyler().text(TextStyler().color(Colors.red)),
    );
  });
}
