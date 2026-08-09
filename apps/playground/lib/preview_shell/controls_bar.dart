import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ControlsBar extends StatelessWidget {
  const ControlsBar({
    super.key,
    required this.brightness,
    required this.size,
    required this.onChange,
  });

  final Brightness brightness;
  final Size size;

  final void Function({Brightness? brightness, Size? size}) onChange;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      elevation: 1,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            SegmentedButton<Brightness>(
              segments: const [
                ButtonSegment(value: .light, label: Text('Light')),
                ButtonSegment(value: .dark, label: Text('Dark')),
              ],
              selected: {brightness},
              onSelectionChanged: (selection) {
                if (selection.isNotEmpty) {
                  onChange(brightness: selection.first);
                }
              },
            ),
            const SizedBox(width: 16),
            _PresetChip(
              label: 'Mobile',
              onTap: () => onChange(size: const Size(375, 812)),
            ),
            const SizedBox(width: 8),
            _PresetChip(
              label: 'Tablet',
              onTap: () => onChange(size: const Size(768, 1024)),
            ),
            const SizedBox(width: 8),
            _PresetChip(
              label: 'Desktop',
              onTap: () => onChange(size: const Size(1280, 800)),
            ),
            const Spacer(),
            Text('W', style: textTheme.labelMedium),
            const SizedBox(width: 6),
            _SizeField(
              initial: size.width.round(),
              onSubmitted: (w) => onChange(
                size: Size(w.toDouble().clamp(200, 3000), size.height),
              ),
            ),
            const SizedBox(width: 12),
            Text('H', style: textTheme.labelMedium),
            const SizedBox(width: 6),
            _SizeField(
              initial: size.height.round(),
              onSubmitted: (h) => onChange(
                size: Size(size.width, h.toDouble().clamp(200, 3000)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
    );
  }
}

class _SizeField extends StatefulWidget {
  const _SizeField({required this.initial, required this.onSubmitted});

  final int initial;
  final ValueChanged<int> onSubmitted;

  @override
  State<_SizeField> createState() => _SizeFieldState();
}

class _SizeFieldState extends State<_SizeField> {
  late final controller = TextEditingController(
    text: widget.initial.toString(),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).dividerColor),
      borderRadius: BorderRadius.circular(6),
    );

    return SizedBox(
      width: 80,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
          focusedBorder: border,
          enabledBorder: border,
          border: border,
        ),
        keyboardType: TextInputType.number,
        onSubmitted: (text) {
          final value = int.tryParse(text);
          if (value != null) {
            widget.onSubmitted(value);
          }
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }
}
