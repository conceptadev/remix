import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildTextFieldExample() {
  return const SizedBox(
    width: 320,
    child: ComparisonView(
      remix: [
        RemixTextField(label: 'Label', hintText: 'Type something…'),
        RemixTextField(
          label: 'With helper',
          hintText: 'Email',
          helperText: 'We will not share your email',
        ),
        RemixTextField(label: 'Error', hintText: 'Invalid input', error: true),
      ],
      material: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Label',
            hintText: 'Type something…',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'With helper',
            hintText: 'Email',
            helperText: 'We will not share your email',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Error',
            hintText: 'Invalid input',
            errorText: 'This field has an error',
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MixColors.red),
            ),
          ),
        ),
      ],
    ),
  );
}
