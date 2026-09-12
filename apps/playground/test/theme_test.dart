import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:playground/ui/ui.dart';
import 'package:remix/remix.dart';

/// Covers the application-owned theme this app installs from the default
/// registry preset.
///
/// Nothing outside `lib/ui/` imports that source: the playground's own previews
/// render `remix_fortal`, so the installed mirror was only ever analyzed, never
/// built. `dart analyze` proves it compiles and
/// `tool/check_open_code_dogfood.dart` proves it still matches the templates,
/// but neither one runs it.
void main() {
  test('every declared token has a value in both brightnesses', () {
    for (final data in const [
      PlaygroundThemeData.light(),
      PlaygroundThemeData.dark(),
    ]) {
      final tokens = data.tokens;

      // Deliberately no token count here. `open_code/fixture` owns that pin for
      // a freshly generated consumer; duplicating the number would mean two
      // places to edit for one added token.
      expect(tokens.keys.toSet(), <MixToken<Object?>>{
        ...PlaygroundTokens.colors,
        PlaygroundTokens.radius,
      });
      for (final token in PlaygroundTokens.colors) {
        expect(tokens[token], isA<Color>(), reason: token.name);
      }
      expect(tokens[PlaygroundTokens.radius], data.radius);
    }
  });

  test('the declared indigo customization is still here', () {
    // `tool/check_open_code_dogfood.dart` records this app's indigo primary and
    // matching focus ring as a deliberate edit, and it does fail if the theme
    // ever matches the template again, so a plain reinstall is already caught.
    // What it cannot see is *which* edit: any custom color satisfies it. These
    // are the values themselves, and the tie between the ring and the primary.
    const light = PlaygroundThemeData.light();

    expect(light.primary, const Color(0xFF4F46E5));
    expect(light.focusRing, light.primary);
  });

  testWidgets('the scope resolves tokens for stylers below it', (tester) async {
    late BuildContext inner;
    await tester.pumpWidget(
      PlaygroundThemeScope(
        data: const PlaygroundThemeData.light(),
        child: Builder(
          builder: (context) {
            inner = context;
            return const SizedBox();
          },
        ),
      ),
    );

    // Both halves of the scope, because the two are installed together and a
    // styler that resolves below it reads the Mix side, not the inherited one.
    expect(
      MixScope.tokenOf(PlaygroundTokens.primary, inner),
      const Color(0xFF4F46E5),
    );
    expect(PlaygroundTheme.of(inner).primary, const Color(0xFF4F46E5));
  });
}
