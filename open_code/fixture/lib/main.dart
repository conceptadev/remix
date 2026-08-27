import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'ui/ui.dart';

/// A host-neutral gallery for the copied `lib/ui/` layer.
///
/// There is no Material or Cupertino widget anywhere below: `WidgetsApp` plus
/// the copied recipe is the entire host contract. Run it from the temporary
/// application the checker retains with `--keep`:
///
/// ```shell
/// flutter run -d chrome
/// ```
void main() => runApp(const AcmeGalleryApp());

/// The gallery's application shell.
class AcmeGalleryApp extends StatelessWidget {
  /// Creates the gallery app.
  const AcmeGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFF0A0A0A),
      debugShowCheckedModeBanner: false,
      builder: (_, _) => const AcmeGallery(),
    );
  }
}

/// Host-neutral glyphs.
///
/// Plain Unicode code points drawn with the default text font, so the gallery
/// depends on no icon set of its own. Any `IconData` an application already
/// ships works the same way.
const IconData checkGlyph = IconData(0x2713);

/// See [checkGlyph].
const IconData crossGlyph = IconData(0x2715);

/// Theme-wide customization.
///
/// One `copyWith` restyles every button in its section: the recipe reads
/// `AcmeTokens`, and `AcmeThemeScope` decides what those tokens resolve to. No
/// button below it is touched.
final AcmeThemeData brandTheme = const AcmeThemeData.light().copyWith(
  primary: const Color(0xFF4F46E5),
  primaryForeground: const Color(0xFFFFFFFF),
  accent: const Color(0xFFE0E7FF),
  accentForeground: const Color(0xFF312E81),
  border: const Color(0xFFC7D2FE),
  focusRing: const Color(0xFF4F46E5),
  radius: const Radius.circular(999),
);

/// Every theme section, stacked.
class AcmeGallery extends StatelessWidget {
  /// Creates the gallery.
  const AcmeGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFFFFFFF),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
          color: Color(0xFF171717),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AcmeThemeSection(
                title: 'Light',
                caption: 'AcmeThemeData.light()',
                data: AcmeThemeData.light(),
              ),
              const AcmeThemeSection(
                title: 'Dark',
                caption: 'AcmeThemeData.dark()',
                data: AcmeThemeData.dark(),
              ),
              AcmeThemeSection(
                title: 'Themed',
                caption: 'AcmeThemeData.light().copyWith(...)',
                data: brandTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One `AcmeThemeScope` and everything the Button recipe can do inside it.
class AcmeThemeSection extends StatefulWidget {
  /// Creates a section rendering [data].
  const AcmeThemeSection({
    super.key,
    required this.title,
    required this.caption,
    required this.data,
  });

  /// Human-readable section name.
  final String title;

  /// The expression that produced [data].
  final String caption;

  /// The theme installed for this section.
  final AcmeThemeData data;

  @override
  State<AcmeThemeSection> createState() => _AcmeThemeSectionState();
}

class _AcmeThemeSectionState extends State<AcmeThemeSection> {
  String _lastAction = 'nothing pressed yet';

  void _record(String action) => setState(() => _lastAction = action);

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return AcmeThemeScope(
      data: data,
      child: ColoredBox(
        color: data.background,
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(
            context,
          ).style.copyWith(color: data.foreground),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _Caption(widget.caption, color: data.mutedForeground),
                const SizedBox(height: 16),

                _Label('Variants x sizes', color: data.mutedForeground),
                for (final size in AcmeButtonSize.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final variant in AcmeButtonVariant.values)
                          // The unnamed constructor keeps `variant` and `size`
                          // as ordinary values, which is what a loop needs.
                          AcmeButton(
                            variant: variant,
                            size: size,
                            label: '${variant.name} ${size.name}',
                            onPressed: () =>
                                _record('${variant.name} / ${size.name}'),
                          ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),

                _Label('Named constructors', color: data.mutedForeground),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Generated from the enum, written like any other widget.
                    AcmeButton.primary(
                      label: 'Primary',
                      leadingIcon: checkGlyph,
                      onPressed: () => _record('primary'),
                    ),
                    AcmeButton.secondary(
                      label: 'Secondary',
                      onPressed: () => _record('secondary'),
                    ),
                    AcmeButton.outline(
                      label: 'Outline',
                      onPressed: () => _record('outline'),
                    ),
                    AcmeButton.ghost(
                      label: 'Ghost',
                      onPressed: () => _record('ghost'),
                    ),
                    AcmeButton.destructive(
                      label: 'Delete',
                      trailingIcon: crossGlyph,
                      onPressed: () => _record('destructive'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('Disabled and loading', color: data.mutedForeground),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const AcmeButton.primary(label: 'Disabled', enabled: false),
                    const AcmeButton.outline(label: 'Disabled', enabled: false),
                    // Same label and size as the row above: Remix keeps the
                    // footprint stable while the spinner is up.
                    AcmeButton.primary(
                      label: 'Loading',
                      loading: true,
                      onPressed: () => _record('unreachable while loading'),
                    ),
                    AcmeButton.outline(
                      label: 'Loading',
                      loading: true,
                      onPressed: () => _record('unreachable while loading'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('One-instance override', color: data.mutedForeground),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AcmeButton.primary(
                      label: 'Just this one',
                      // Merged last, so it beats the resolved recipe. The
                      // hover fill has to be declared as a hover fragment;
                      // a bare `.color(...)` would only replace the idle one.
                      style: ButtonStyler()
                          .color(const Color(0xFF7C3AED))
                          .borderRadius(.all(const Radius.circular(999)))
                          .padding(.horizontal(28))
                          .minHeight(48)
                          .label(
                            .color(
                              const Color(0xFFFFFFFF),
                            ).fontWeight(FontWeight.w700),
                          )
                          .onHovered(
                            ButtonStyler().color(const Color(0xFF5B21B6)),
                          ),
                      onPressed: () => _record('one-instance override'),
                    ),
                    AcmeButton.primary(
                      label: 'Untouched neighbour',
                      onPressed: () => _record('untouched neighbour'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Caption(
                  'Last action: $_lastAction',
                  color: data.mutedForeground,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text, {required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          color: color,
        ),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text, {required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 12, color: color));
  }
}
