import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../theme/theme_scope.dart';
import '../theme/theme_settings.dart';
import '../utils/text.dart';
import 'typography.dart';

class ThemePanel extends StatelessWidget {
  const ThemePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = ThemeScope.of(context);
    final settings = scope.settings;

    /// Every discrete theme parameter is an exclusive choice from a short list,
    /// so they all render as one labelled segmented control over the setting.
    Widget choice<T extends Object>({
      required String label,
      required T selectedValue,
      required List<RemixSegmentedControlItem<T>> items,
      required ThemeSettings Function(T value) apply,
    }) => _Control(
      label: label,
      child: FortalSegmentedControl<T>(
        size: .size1,
        selectedValue: selectedValue,
        semanticLabel: label,
        items: items,
        onChanged: (value) => scope.onChanged(apply(value)),
      ),
    );

    return SizedBox(
      key: const ValueKey('theme-panel'),
      width: 360,
      child: Column(
        crossAxisAlignment: .stretch,
        spacing: 18,
        children: [
          choice<ThemeMode>(
            label: 'Appearance',
            selectedValue: settings.appearance,
            items: const [
              RemixSegmentedControlItem(value: .system, label: 'System'),
              RemixSegmentedControlItem(value: .light, label: 'Light'),
              RemixSegmentedControlItem(value: .dark, label: 'Dark'),
            ],
            apply: (value) => settings.copyWith(appearance: value),
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
              items: [
                for (final gray in FortalGrayColor.values)
                  RemixSelectItem(value: gray, label: capitalize(gray.name)),
              ],
              onChanged: (value) {
                if (value != null) {
                  scope.onChanged(settings.copyWith(grayColor: value));
                }
              },
            ),
          ),
          choice<FortalPanelBackground>(
            label: 'Panel background',
            selectedValue: settings.panelBackground,
            items: const [
              RemixSegmentedControlItem(value: .solid, label: 'Solid'),
              RemixSegmentedControlItem(
                value: .translucent,
                label: 'Translucent',
              ),
            ],
            apply: (value) => settings.copyWith(panelBackground: value),
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: choice<FortalRadius>(
                  label: 'Radius',
                  selectedValue: settings.radius,
                  items: const [
                    RemixSegmentedControlItem(value: .none, label: 'None'),
                    RemixSegmentedControlItem(value: .small, label: 'S'),
                    RemixSegmentedControlItem(value: .medium, label: 'M'),
                    RemixSegmentedControlItem(value: .large, label: 'L'),
                    RemixSegmentedControlItem(value: .full, label: 'Full'),
                  ],
                  apply: (value) => settings.copyWith(radius: value),
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
          SingleChildScrollView(
            scrollDirection: .horizontal,
            child: choice<FortalScaling>(
              label: 'Scaling',
              selectedValue: settings.scaling,
              items: const [
                RemixSegmentedControlItem(value: .percent90, label: '90%'),
                RemixSegmentedControlItem(value: .percent95, label: '95%'),
                RemixSegmentedControlItem(value: .percent100, label: '100%'),
                RemixSegmentedControlItem(value: .percent105, label: '105%'),
                RemixSegmentedControlItem(value: .percent110, label: '110%'),
              ],
              apply: (value) => settings.copyWith(scaling: value),
            ),
          ),
          Align(
            alignment: .centerLeft,
            child: FortalButton.ghost(
              key: const ValueKey('theme-reset'),
              size: .size1,
              onPressed: () => scope.onChanged(const ThemeSettings()),
              label: 'Reset theme',
              leadingIcon: Icons.restart_alt,
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
    crossAxisAlignment: .start,
    spacing: 8,
    children: [
      DashboardTextTone(
        child: FortalText(label, size: .size2, weight: .medium),
      ),
      child,
    ],
  );
}

/// One selectable accent in the theme panel.
///
/// The swatch paints the accent itself, so it takes its interaction, focus
/// ring, keyboard activation, and selected semantics from [RemixToggle] and
/// supplies only the visual. Re-scoping to [accent] lets the fill come from
/// the same `accent-9`/`accent-10` steps every other component reads, which is
/// also why the style below is shared: it names tokens, never a colour.
class _AccentSwatch extends StatelessWidget {
  const _AccentSwatch({
    super.key,
    required this.accent,
    required this.selected,
    required this.onPressed,
  });

  static final _ring = ToggleStyler().borderAll(
    color: FortalTokens.focus8(),
    width: FortalTokens.focusRingWidth(),
    strokeAlign: BorderSide.strokeAlignOutside,
  );

  static final _style =
      ToggleStyler(
            container: FlexBoxStyler()
                .size(30, 30)
                .alignment(.center)
                .borderRadiusAll(const Radius.circular(15)),
            icon: .size(15),
          )
          .backgroundColor(FortalTokens.accent9())
          .iconColor(Colors.transparent)
          .onHovered(ToggleStyler().backgroundColor(FortalTokens.accent10()))
          .onPressed(ToggleStyler().backgroundColor(FortalTokens.accent10()))
          .onSelected(
            ToggleStyler()
                .iconColor(FortalTokens.accentContrast())
                .merge(_ring),
          )
          .onFocusVisible(_ring);

  final FortalAccentColor accent;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => FortalScope(
    accent: accent,
    hasBackground: false,
    child: RemixToggle(
      selected: selected,
      onChanged: (_) => onPressed(),
      // RemixToggle requires a label or an icon, so the check is always
      // mounted and the selected state reveals it.
      icon: Icons.check,
      semanticLabel: '${capitalize(accent.name)} accent',
      style: _style,
    ),
  );
}
