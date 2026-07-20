import 'package:flutter/material.dart' hide Scaffold;
import 'package:remix/remix.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

@widgetbook.App()
void main() {
  runApp(const HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    final themeAddon = FortalThemeAddon();

    return Widgetbook.material(
      addons: [themeAddon],
      appBuilder: (context, child) =>
          buildFortalWidgetbookApp(context, child, themeAddon),
      directories: directories,
    );
  }
}

/// Builds the Widgetbook preview app from its query-selected Material theme.
///
/// This is public only so the app-shell contract can be verified without
/// launching Widgetbook's navigation UI; it is not part of Remix's API.
@visibleForTesting
Widget buildFortalWidgetbookApp(
  BuildContext context,
  Widget child,
  FortalThemeAddon themeAddon,
) {
  final state = WidgetbookState.of(context);
  final setting = themeAddon.valueFromQueryGroup(
    FieldCodec.decodeQueryGroup(state.queryParams[themeAddon.groupName]),
  );
  final theme = setting.data;

  return FortalScope(
    appearance: theme.brightness == .dark ? .dark : .light,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Material(color: theme.scaffoldBackgroundColor, child: child),
    ),
  );
}

class FortalThemeAddon extends ThemeAddon<ThemeData> {
  /// Creates a new instance of [MaterialThemeAddon].
  FortalThemeAddon()
    : super(
        themes: [
          WidgetbookTheme(
            name: 'light',
            data: ThemeData(
              brightness: .light,
              scaffoldBackgroundColor: Colors.white,
            ),
          ),
          WidgetbookTheme(
            name: 'dark',
            data: ThemeData(
              brightness: .dark,
              scaffoldBackgroundColor: const Color(0xFF111111),
            ),
          ),
        ],
        // The selected setting is resolved by the custom appBuilder so the
        // FortalScope can wrap the MaterialApp rather than sit below it.
        themeBuilder: (context, theme, child) => child,
      );
}
