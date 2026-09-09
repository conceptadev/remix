import 'package:flutter/widgets.dart';
import 'package:remix_agent/remix_agent.dart';

import 'agent/composer.dart';
import 'ui/ui.dart';

/// A host-neutral page for one Agent surface styled by installed recipes.
///
/// There is no Material or Cupertino widget below: `WidgetsApp`, the installed
/// `lib/ui/` layer, and `remix_agent` are the whole host contract. Run it from
/// the temporary application the checker retains with `--keep`:
///
/// ```shell
/// flutter run -d chrome
/// ```
void main() => runApp(const UiAgentApp());

/// The page's application shell.
class UiAgentApp extends StatelessWidget {
  /// Creates the app.
  const UiAgentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFF0A0A0A),
      debugShowCheckedModeBanner: false,
      // A composer is a focused text area, and `EditableText` asserts on an
      // `Overlay` ancestor the moment it takes focus, for its selection
      // handles and magnifier. A `WidgetsApp` built with `builder:` alone has
      // no `Navigator` and therefore no `Overlay`, so the host supplies one.
      // This is the installed text field's requirement, inherited unchanged;
      // Agent adds none of its own.
      builder: (_, _) => UiThemeScope(
        data: const UiThemeData.light(),
        child: Overlay.wrap(child: const UiAgentPage()),
      ),
    );
  }
}

/// The composer, on the theme's own page colour.
class UiAgentPage extends StatefulWidget {
  /// Creates the page.
  const UiAgentPage({super.key});

  @override
  State<UiAgentPage> createState() => _UiAgentPageState();
}

class _UiAgentPageState extends State<UiAgentPage> {
  final _sent = <String>[];
  var _running = false;

  @override
  Widget build(BuildContext context) {
    final theme = UiTheme.of(context);
    final recipe = uiAgentComposerRecipe();

    return ColoredBox(
      color: theme.background,
      child: DefaultTextStyle(
        style: TextStyle(color: theme.foreground, fontSize: 14),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final prompt in _sent) Text(prompt),
              const Spacer(),
              AgentComposer(
                style: recipe.style,
                surfaceStyle: recipe.surfaceStyle,
                fieldStyle: recipe.fieldStyle,
                submitStyle: recipe.submitStyle,
                stopStyle: recipe.stopStyle,
                running: _running,
                onSubmit: (prompt) => setState(() {
                  _sent.add(prompt);
                  _running = true;
                }),
                onStop: () => setState(() => _running = false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
