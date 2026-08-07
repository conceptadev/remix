import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../../widgets/comparison_view.dart';

Widget buildTextAreaExample() => const _TextAreaExample();

class _TextAreaExample extends StatefulWidget {
  const _TextAreaExample();

  @override
  State<_TextAreaExample> createState() => _TextAreaExampleState();
}

class _TextAreaExampleState extends State<_TextAreaExample> {
  final _remixController = TextEditingController(
    text: 'First paragraph.\nSecond paragraph.',
  );
  final _materialController = TextEditingController(
    text: 'First paragraph.\nSecond paragraph.',
  );
  final _remixReadOnlyController = TextEditingController(
    text: 'This content can be selected but not changed.',
  );
  final _materialReadOnlyController = TextEditingController(
    text: 'This content can be selected but not changed.',
  );

  @override
  void dispose() {
    _remixController.dispose();
    _materialController.dispose();
    _remixReadOnlyController.dispose();
    _materialReadOnlyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? const Color(0xFF202124) : const Color(0xFFF8FAFC);
    final foreground = isDark ? Colors.white : const Color(0xFF172033);
    final muted = isDark ? const Color(0xFFB8BDC7) : const Color(0xFF667085);

    final customStyle = TextFieldStyler()
        .backgroundColor(surface)
        .textColor(foreground)
        .hintColor(muted)
        .paddingAll(14)
        .borderRadiusAll(const Radius.circular(12))
        .border(
          BoxBorderMix.all(
            BorderSideMix(color: const Color(0xFF7C3AED), width: 1.5),
          ),
        )
        .label(TextStyler().color(foreground).fontWeight(FontWeight.w600))
        .helperText(TextStyler().color(muted))
        .onFocused(
          TextFieldStyler().border(
            BoxBorderMix.all(
              BorderSideMix(color: const Color(0xFF8B5CF6), width: 2.5),
            ),
          ),
        );

    Widget field(Widget child) => SizedBox(width: 320, child: child);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ComparisonView(
          remix: [
            field(
              const FortalTextArea.surface(
                key: ValueKey('textarea-empty'),
                label: 'Empty',
                hintText: 'Start typing at the top…',
              ),
            ),
            field(
              FortalTextArea.classic(
                key: const ValueKey('textarea-filled'),
                controller: _remixController,
                label: 'Controlled value',
                helperText: 'Line breaks are preserved',
              ),
            ),
            field(
              const FortalTextArea.surface(
                key: ValueKey('textarea-error'),
                label: 'Project summary',
                hintText: 'Describe the project',
                helperText: 'A summary is required',
                error: true,
              ),
            ),
            field(
              const FortalTextArea.soft(
                label: 'Limited feedback',
                hintText: 'Up to 120 characters',
                maxLength: 120,
                maxLines: 4,
              ),
            ),
            field(
              const FortalTextArea.surface(
                key: ValueKey('textarea-disabled'),
                label: 'Disabled',
                hintText: 'Editing unavailable',
                enabled: false,
              ),
            ),
            field(
              FortalTextArea.classic(
                controller: _remixReadOnlyController,
                label: 'Read only',
                readOnly: true,
              ),
            ),
            field(
              RemixTextArea(
                label: 'Custom Remix styling',
                hintText: 'Same TextFieldStyler anatomy',
                helperText: 'Grows within its parent constraints',
                style: customStyle,
              ),
            ),
          ],
          material: [
            field(
              const TextField(
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Empty',
                  hintText: 'Start typing at the top…',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            field(
              TextField(
                controller: _materialController,
                minLines: 2,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Controlled value',
                  helperText: 'Line breaks are preserved',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            field(
              const TextField(
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Project summary',
                  hintText: 'Describe the project',
                  errorText: 'A summary is required',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            field(
              const TextField(
                minLines: 2,
                maxLines: 4,
                maxLength: 120,
                decoration: InputDecoration(
                  labelText: 'Limited feedback',
                  hintText: 'Up to 120 characters',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            field(
              const TextField(
                minLines: 2,
                maxLines: null,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Disabled',
                  hintText: 'Editing unavailable',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            field(
              TextField(
                controller: _materialReadOnlyController,
                minLines: 2,
                maxLines: null,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Read only',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            field(
              const TextField(
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Custom styling',
                  hintText: 'Material comparison',
                  helperText: 'Grows within its parent constraints',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
