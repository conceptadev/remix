import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Popover Component', type: RemixPopover)
Widget buildPopoverUseCase(BuildContext context) {
  final consumeOutsideTaps = context.knobs.boolean(
    label: 'Consume outside taps',
    initialValue: true,
  );

  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: FortalPopover(
          consumeOutsideTaps: consumeOutsideTaps,
          semanticLabel: 'Show collaboration details',
          positioning: const OverlayPositionConfig(
            side: .bottom,
            alignment: .center,
          ),
          popoverChild: SizedBox(
            width: 280,
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              spacing: 12,
              children: [
                StyledText(
                  'Invite teammates',
                  style: TextStyler()
                      .fontSize(16)
                      .fontWeight(.w600)
                      .color(FortalTokens.gray12()),
                ),
                StyledText(
                  'Share this project with teammates and choose what they can access.',
                  style: TextStyler().fontSize(14).color(FortalTokens.gray11()),
                ),
                FortalButton.soft(
                  label: 'Copy invite link',
                  leadingIcon: Icons.link,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                Icon(Icons.group_add_outlined, size: 18),
                Text('Invite'),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
