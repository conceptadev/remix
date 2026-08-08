import 'package:flutter/material.dart' hide Scaffold;
import 'package:remix_fortal/remix_fortal.dart';
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
    return Widgetbook.material(
      addons: [FortalThemeAddon()],
      appBuilder: (context, child) => child,
      directories: directories,
    );
  }
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
        themeBuilder: (context, theme, child) {
          return Theme(
            data: theme,
            child: FortalScope(
              brightness: theme.brightness,
              child: ColoredBox(
                color: theme.scaffoldBackgroundColor,
                child: DefaultTextStyle(
                  style: theme.textTheme.bodyMedium!,
                  child: child,
                ),
              ),
            ),
          );
        },
      );
}
