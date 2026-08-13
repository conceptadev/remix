import 'package:carbon/carbon.dart';
import 'package:flutter/material.dart';
import 'package:mix_atlas/mix_atlas.dart';

/// Carbon components and states available to the live atlas and golden tests.
final carbonAtlasCatalog = AtlasCatalog(
  id: 'carbon',
  label: 'Carbon for Flutter',
  themes: [for (final theme in CarbonTheme.values) _atlasTheme(theme)],
  atlases: [_buttonAtlas, _buttonIconAtlas],
);

const _buttonScenarios = [
  ...AtlasScenarios.interactive,
  AtlasScenario(
    'loading',
    label: 'Loading',
    states: {WidgetState.disabled},
    props: {'loading': true},
  ),
];

final _buttonAtlas = ComponentAtlas(
  id: 'button',
  label: 'Button',
  rowAxes: const [AtlasAxis('kind', 'Kind'), AtlasAxis('size', 'Size')],
  scenarios: _buttonScenarios,
  rows: _buttonRows(CarbonSize.values.skip(1)),
);

final _buttonIconAtlas = ComponentAtlas(
  id: 'button-icons',
  label: 'Button with icon',
  rowAxes: const [AtlasAxis('kind', 'Kind'), AtlasAxis('size', 'Size')],
  scenarios: _buttonScenarios,
  rows: _buttonRows(const [CarbonSize.md, CarbonSize.xl], icon: Icons.add),
);

List<AtlasRow> _buttonRows(Iterable<CarbonSize> sizes, {IconData? icon}) {
  return [
    for (final kind in CarbonButtonKind.values)
      for (final size in sizes)
        AtlasRow(
          '${kind.name}-${size.name}',
          (_, cell) {
            final loading = cell.propOr('loading', false);
            final enabled = !cell.disabled && !loading;

            return SizedBox(
              width: 192,
              child: CarbonButton(
                label: icon == null ? _kindLabel(kind) : 'Action',
                kind: kind,
                size: size,
                icon: icon,
                loading: loading,
                enabled: enabled,
                onPressed: enabled ? () {} : null,
              ),
            );
          },
          values: {
            'kind': AtlasAxisValue(kind.name, _kindLabel(kind)),
            'size': AtlasAxisValue(size.name, _sizeLabel(size)),
          },
        ),
  ];
}

AtlasTheme _atlasTheme(CarbonTheme theme) {
  return AtlasTheme(
    theme.name,
    label: _themeLabel(theme),
    brightness: theme.brightness,
    background: _themeBackground(theme),
    builder: (_, child) => CarbonScope(theme: theme, child: child),
  );
}

String _kindLabel(CarbonButtonKind kind) => switch (kind) {
  CarbonButtonKind.primary => 'Primary',
  CarbonButtonKind.secondary => 'Secondary',
  CarbonButtonKind.tertiary => 'Tertiary',
  CarbonButtonKind.ghost => 'Ghost',
  CarbonButtonKind.danger => 'Danger',
  CarbonButtonKind.dangerTertiary => 'Danger tertiary',
  CarbonButtonKind.dangerGhost => 'Danger ghost',
};

String _sizeLabel(CarbonSize size) => switch (size) {
  CarbonSize.xs => 'Extra small',
  CarbonSize.sm => 'Small',
  CarbonSize.md => 'Medium',
  CarbonSize.lg => 'Large',
  CarbonSize.xl => 'Extra large',
  CarbonSize.x2l => '2× large',
};

String _themeLabel(CarbonTheme theme) => switch (theme) {
  CarbonTheme.white => 'White',
  CarbonTheme.g10 => 'Gray 10',
  CarbonTheme.g90 => 'Gray 90',
  CarbonTheme.g100 => 'Gray 100',
};

Color _themeBackground(CarbonTheme theme) => switch (theme) {
  CarbonTheme.white => const Color(0xFFFFFFFF),
  CarbonTheme.g10 => const Color(0xFFF4F4F4),
  CarbonTheme.g90 => const Color(0xFF262626),
  CarbonTheme.g100 => const Color(0xFF161616),
};
