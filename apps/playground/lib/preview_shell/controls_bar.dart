import 'package:flutter/widgets.dart';
import 'package:remix_fortal/remix_fortal.dart';
import 'package:flutter/services.dart';

import 'presets.dart';

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
    return ColoredBox(
      color: const Color(0xFFFAFAFA),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            FortalButton(
              label: brightness == .light ? 'Dark theme' : 'Light theme',
              onPressed: () =>
                  onChange(brightness: brightness == .light ? .dark : .light),
            ),
            const SizedBox(width: 16),
            _PresetChip(
              label: 'Mobile',
              onTap: () => onChange(size: ViewportPresets.mobile),
            ),
            const SizedBox(width: 8),
            _PresetChip(
              label: 'Tablet',
              onTap: () => onChange(size: ViewportPresets.tablet),
            ),
            const SizedBox(width: 8),
            _PresetChip(
              label: 'Desktop',
              onTap: () => onChange(size: ViewportPresets.desktop),
            ),
            const Spacer(),
            const FortalText('W'),
            const SizedBox(width: 6),
            _SizeField(
              initial: size.width.round(),
              onSubmitted: (w) => onChange(
                size: Size(w.toDouble().clamp(200, 3000), size.height),
              ),
            ),
            const SizedBox(width: 12),
            const FortalText('H'),
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
    return FortalButton(label: label, onPressed: onTap);
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
    return SizedBox(
      width: 80,
      child: FortalTextField(
        controller: controller,
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
