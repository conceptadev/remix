import 'dart:convert';
import 'dart:io';

const _radixThemesVersion = '3.3.0';
const _radixThemesIntegrity =
    'sha512-I0/h2CRNTpYNB7Mi3xFIvSsQq5a108d7kK8dTO5zp5b9HR5QJXKag6B8tjpz2ITkVYkFdkGk45doNkSr7OxwNw==';

const _colorNames = [
  'gray',
  'mauve',
  'slate',
  'sage',
  'olive',
  'sand',
  'tomato',
  'red',
  'ruby',
  'crimson',
  'pink',
  'plum',
  'purple',
  'violet',
  'iris',
  'indigo',
  'blue',
  'cyan',
  'teal',
  'jade',
  'green',
  'grass',
  'bronze',
  'gold',
  'brown',
  'orange',
  'amber',
  'yellow',
  'lime',
  'mint',
  'sky',
];

// Chromium 152 sRGB raster values for the dark-mode `color-mix(in oklab, …)`
// track overrides in the pinned 3.3.0 artifact.
const _darkTrackOverrides = {
  'amber': '#e2ac37',
  'lime': '#98c254',
  'mint': '#65c3b0',
  'sky': '#5bbde2',
  'yellow': '#d2b929',
};

void main(List<String> arguments) {
  if (arguments.length != 1) {
    stderr.writeln(
      'Usage: dart run scripts/extract_radix_tokens.dart '
      '<extracted-@radix-ui/themes-package>',
    );
    exitCode = 64;
    return;
  }

  final packageDirectory = Directory(arguments.single);
  final packageJson = File('${packageDirectory.path}/package.json');
  final package = jsonDecode(packageJson.readAsStringSync());
  if (package case {'name': '@radix-ui/themes', 'version': final version}) {
    if (version != _radixThemesVersion) {
      throw StateError(
        'Expected @radix-ui/themes@$_radixThemesVersion, found $version.',
      );
    }
  } else {
    throw StateError('${packageDirectory.path} is not a Radix Themes package.');
  }

  final scales = <String, Object?>{};
  for (final colorName in _colorNames) {
    final source = File(
      '${packageDirectory.path}/tokens/colors/$colorName.css',
    ).readAsStringSync();
    scales[colorName] = _extractScale(colorName, source);
  }

  final baseSource = File(
    '${packageDirectory.path}/tokens/base.css',
  ).readAsStringSync();
  final output = {
    'meta': {
      'description':
          'sRGB fallback tokens extracted from the pinned @radix-ui/themes npm artifact',
      'radix_themes_version': _radixThemesVersion,
      'radix_colors_version': 'bundled with Radix Themes 3.3.0',
      'source_integrity': _radixThemesIntegrity,
    },
    'colors': {
      'scales': scales,
      'neutrals': {
        'blackA': {'alpha': _extractNeutral('black', baseSource)},
        'whiteA': {'alpha': _extractNeutral('white', baseSource)},
      },
    },
  };

  const encoder = JsonEncoder.withIndent('  ');
  File(
    'radix_colors.generated.json',
  ).writeAsStringSync('${encoder.convert(output)}\n');
}

Map<String, Object?> _extractScale(String name, String source) {
  final light = <String, Object?>{
    'solid': <String, String>{},
    'alpha': <String, String>{},
  };
  final dark = <String, Object?>{
    'solid': <String, String>{},
    'alpha': <String, String>{},
  };

  for (var step = 1; step <= 12; step++) {
    final solid = _hexValues(source, '$name-$step');
    final alpha = _hexValues(source, '$name-a$step');
    _expectModes('$name-$step', solid);
    _expectModes('$name-a$step', alpha);
    (light['solid']! as Map<String, String>)['$step'] = solid[0];
    (dark['solid']! as Map<String, String>)['$step'] = solid[1];
    (light['alpha']! as Map<String, String>)['a$step'] = alpha[0];
    (dark['alpha']! as Map<String, String>)['a$step'] = alpha[1];
  }

  final surfaces = _hexValues(source, '$name-surface');
  _expectModes('$name-surface', surfaces);
  final contrastMatch = RegExp(
    '--$name-contrast:\\s*([^;]+);',
  ).firstMatch(source);
  final contrast = switch (contrastMatch?.group(1)?.trim()) {
    'white' => '#ffffff',
    'black' => '#000000',
    final String value when value.startsWith('#') => value,
    final value => throw StateError('Unsupported $name contrast: $value'),
  };

  light
    ..['surface'] = surfaces[0]
    ..['indicator'] = (light['solid']! as Map<String, String>)['9']
    ..['track'] = (light['solid']! as Map<String, String>)['9']
    ..['contrast'] = contrast;
  dark
    ..['surface'] = surfaces[1]
    ..['indicator'] = (dark['solid']! as Map<String, String>)['9']
    ..['track'] =
        _darkTrackOverrides[name] ??
        (dark['solid']! as Map<String, String>)['9']
    ..['contrast'] = contrast;

  return {'light': light, 'dark': dark};
}

Map<String, String> _extractNeutral(String name, String source) {
  final result = <String, String>{};
  for (var step = 1; step <= 12; step++) {
    final match = RegExp(
      '--$name-a$step:\\s*(rgba\\([^;]+\\));',
    ).firstMatch(source);
    result['a$step'] =
        match?.group(1) ??
        (throw StateError('Missing --$name-a$step in tokens/base.css.'));
  }
  return result;
}

List<String> _hexValues(String source, String property) => RegExp(
  '--$property:\\s*(#[0-9a-fA-F]{6,8});',
).allMatches(source).map((match) => match.group(1)!).toList();

void _expectModes(String property, List<String> values) {
  if (values.length != 2) {
    throw StateError(
      'Expected light and dark sRGB values for --$property, found $values.',
    );
  }
}
