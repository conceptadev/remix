import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remix/remix.dart';

import '../theme/theme_scope.dart';
import '../theme/theme_settings.dart';

const _accentThemes = <FortalAccentColor, RadixColorTheme>{
  .gray: gray,
  .gold: gold,
  .bronze: bronze,
  .brown: brown,
  .yellow: yellow,
  .amber: amber,
  .orange: orange,
  .tomato: tomato,
  .red: red,
  .ruby: ruby,
  .crimson: crimson,
  .pink: pink,
  .plum: plum,
  .purple: purple,
  .violet: violet,
  .iris: iris,
  .indigo: indigo,
  .blue: blue,
  .cyan: cyan,
  .teal: teal,
  .jade: jade,
  .green: green,
  .grass: grass,
  .lime: lime,
  .mint: mint,
  .sky: sky,
};

class ThemePanel extends StatelessWidget {
  const ThemePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = ThemeScope.of(context);
    final settings = scope.settings;
    return SizedBox(
      key: const ValueKey('theme-panel'),
      width: 360,
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 18,
        children: [
          _Control(
            label: 'Appearance',
            child: Align(
              alignment: .centerLeft,
              child: FortalToggleGroup<FortalAppearance>(
                size: .size1,
                selectedValue: settings.appearance,
                semanticLabel: 'Theme appearance',
                items: const [
                  RemixToggleGroupItem(value: .inherit, label: 'System'),
                  RemixToggleGroupItem(value: .light, label: 'Light'),
                  RemixToggleGroupItem(value: .dark, label: 'Dark'),
                ],
                onChanged: (value) {
                  if (value != null) {
                    scope.onChanged(settings.copyWith(appearance: value));
                  }
                },
              ),
            ),
          ),
          _Control(
            label: 'Accent color',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final accent in FortalAccentColor.values)
                  _AccentSwatch(
                    key: ValueKey('accent-${accent.name}'),
                    accent: accent,
                    selected: accent == settings.accentColor,
                    onPressed: () =>
                        scope.onChanged(settings.copyWith(accentColor: accent)),
                  ),
              ],
            ),
          ),
          _Control(
            label: 'Gray color',
            child: FortalSelect<FortalGrayColor>(
              trigger: const RemixSelectTrigger(placeholder: 'Choose gray'),
              selectedValue: settings.grayColor,
              entries: [
                for (final gray in FortalGrayColor.values)
                  RemixSelectItem(value: gray, label: _label(gray.name)),
              ],
              onChanged: (value) {
                if (value != null) {
                  scope.onChanged(settings.copyWith(grayColor: value));
                }
              },
            ),
          ),
          _Control(
            label: 'Radius',
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                  child: FortalToggleGroup<FortalRadius>(
                    size: .size1,
                    selectedValue: settings.radius,
                    semanticLabel: 'Theme radius',
                    items: const [
                      RemixToggleGroupItem(value: .none, label: 'None'),
                      RemixToggleGroupItem(value: .small, label: 'S'),
                      RemixToggleGroupItem(value: .medium, label: 'M'),
                      RemixToggleGroupItem(value: .large, label: 'L'),
                      RemixToggleGroupItem(value: .full, label: 'Full'),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        scope.onChanged(settings.copyWith(radius: value));
                      }
                    },
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: MixScope.tokenOf(FortalTokens.accent9, context),
                    borderRadius: BorderRadius.all(
                      MixScope.tokenOf(FortalTokens.radius3, context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _Control(
            label: 'Scaling',
            child: Align(
              alignment: .centerLeft,
              child: FortalToggleGroup<FortalScaling>(
                size: .size1,
                selectedValue: settings.scaling,
                semanticLabel: 'Theme scaling',
                items: const [
                  RemixToggleGroupItem(value: .percent90, label: '90%'),
                  RemixToggleGroupItem(value: .percent95, label: '95%'),
                  RemixToggleGroupItem(value: .percent100, label: '100%'),
                  RemixToggleGroupItem(value: .percent105, label: '105%'),
                  RemixToggleGroupItem(value: .percent110, label: '110%'),
                ],
                onChanged: (value) {
                  if (value != null) {
                    scope.onChanged(settings.copyWith(scaling: value));
                  }
                },
              ),
            ),
          ),
          Align(
            alignment: .centerLeft,
            child: FortalButton(
              key: const ValueKey('theme-reset'),
              variant: .ghost,
              size: .size1,
              onPressed: () => scope.onChanged(const ThemeSettings()),
              child: const Row(
                mainAxisSize: .min,
                spacing: 5,
                children: [
                  Icon(Icons.restart_alt, size: 15),
                  Text('Reset theme'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Control extends StatelessWidget {
  const _Control({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .stretch,
    spacing: 8,
    children: [
      StyledText(
        label,
        style: TextStyler(
          style: FortalTokens.text2.mix(),
        ).fontWeight(.w600).color(FortalTokens.gray12()),
      ),
      child,
    ],
  );
}

class _AccentSwatch extends StatefulWidget {
  const _AccentSwatch({
    super.key,
    required this.accent,
    required this.selected,
    required this.onPressed,
  });

  final FortalAccentColor accent;
  final bool selected;
  final VoidCallback onPressed;

  @override
  State<_AccentSwatch> createState() => _AccentSwatchState();
}

class _AccentSwatchState extends State<_AccentSwatch> {
  bool _focused = false;
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = _accentThemes[widget.accent]!;
    final radix = FortalTheme.of(context).isDark ? theme.dark : theme.light;
    final ring = MixScope.tokenOf(FortalTokens.focus8, context);
    return Semantics(
      button: true,
      selected: widget.selected,
      label: '${_label(widget.accent.name)} accent',
      child: Focus(
        onFocusChange: (value) => setState(() => _focused = value),
        onKeyEvent: (_, event) {
          if (event is KeyDownEvent &&
              (event.logicalKey == LogicalKeyboardKey.enter ||
                  event.logicalKey == LogicalKeyboardKey.space)) {
            widget.onPressed();
            return .handled;
          }
          return .ignored;
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: widget.onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 30,
              height: 30,
              alignment: .center,
              decoration: BoxDecoration(
                color: radix.scale.step(_hovered ? 10 : 9),
                shape: .circle,
                border: widget.selected || _focused
                    ? Border.all(color: ring, width: 2)
                    : null,
              ),
              child: widget.selected
                  ? Icon(Icons.check, size: 15, color: radix.contrast)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

String _label(String name) => '${name[0].toUpperCase()}${name.substring(1)}';
