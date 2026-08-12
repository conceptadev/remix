import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

final _key = GlobalKey();

@widgetbook.UseCase(name: 'Accordion Component', type: RemixAccordion)
Widget buildAvatarUseCase(BuildContext context) {
  return KeyedSubtree(
    key: _key,
    child: Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: RemixAccordionGroup(
            controller: RemixAccordionController<String>(min: 0, max: 1),
            child: const Column(
              spacing: 8,
              children: [
                FortalAccordion(
                  value: 'accordion1',
                  title: 'Is it accessible?',
                  child: Text('Yes, it is accessible.'),
                ),
                FortalAccordion(
                  value: 'accordion2',
                  title: 'What payment methods are accepted?',
                  child: Text(
                    'Major credit and debit cards like Visa, MasterCard, and American Express, as well as digital payment options like PayPal and Apple Pay.',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
