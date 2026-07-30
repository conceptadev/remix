import 'dart:convert';
import 'dart:io';

import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart' as remix;

const _themes = <String, remix.RadixColorTheme>{
  'gray': remix.gray,
  'mauve': remix.mauve,
  'slate': remix.slate,
  'sage': remix.sage,
  'olive': remix.olive,
  'sand': remix.sand,
  'tomato': remix.tomato,
  'red': remix.red,
  'ruby': remix.ruby,
  'crimson': remix.crimson,
  'pink': remix.pink,
  'plum': remix.plum,
  'purple': remix.purple,
  'violet': remix.violet,
  'iris': remix.iris,
  'indigo': remix.indigo,
  'blue': remix.blue,
  'cyan': remix.cyan,
  'teal': remix.teal,
  'jade': remix.jade,
  'green': remix.green,
  'grass': remix.grass,
  'bronze': remix.bronze,
  'gold': remix.gold,
  'brown': remix.brown,
  'orange': remix.orange,
  'amber': remix.amber,
  'yellow': remix.yellow,
  'lime': remix.lime,
  'mint': remix.mint,
  'sky': remix.sky,
};

void main() {
  final fixture =
      jsonDecode(File('radix_colors.generated.json').readAsStringSync())
          as Map<String, Object?>;

  test('fixture is pinned to the approved Radix Themes artifact', () {
    final meta = fixture['meta']! as Map<String, Object?>;
    expect(meta['radix_themes_version'], '3.3.0');
    expect(
      meta['source_integrity'],
      'sha512-I0/h2CRNTpYNB7Mi3xFIvSsQq5a108d7kK8dTO5zp5b9HR5QJXKag6B8tjpz2ITkVYkFdkGk45doNkSr7OxwNw==',
    );
  });

  test('all generated scales and semantic roles match the pinned fixture', () {
    final colors = fixture['colors']! as Map<String, Object?>;
    final scales = colors['scales']! as Map<String, Object?>;
    expect(scales.keys, orderedEquals(_themes.keys));

    for (final entry in _themes.entries) {
      final expectedTheme = scales[entry.key]! as Map<String, Object?>;
      _expectMode(
        '${entry.key}.light',
        entry.value.light,
        expectedTheme['light']! as Map<String, Object?>,
      );
      _expectMode(
        '${entry.key}.dark',
        entry.value.dark,
        expectedTheme['dark']! as Map<String, Object?>,
      );
    }
  });

  test('neutral alpha scales match the pinned fixture', () {
    final colors = fixture['colors']! as Map<String, Object?>;
    final neutrals = colors['neutrals']! as Map<String, Object?>;

    for (final entry in <String, ColorSwatch<int>>{
      'blackA': remix.blackAlpha,
      'whiteA': remix.whiteAlpha,
    }.entries) {
      final neutral = neutrals[entry.key]! as Map<String, Object?>;
      final alpha = neutral['alpha']! as Map<String, Object?>;
      for (var step = 1; step <= 12; step++) {
        expect(
          entry.value[step],
          _parseColor(alpha['a$step']! as String),
          reason: '${entry.key}.a$step',
        );
      }
    }
  });
}

void _expectMode(
  String name,
  remix.RadixColor actual,
  Map<String, Object?> expected,
) {
  final solid = expected['solid']! as Map<String, Object?>;
  final alpha = expected['alpha']! as Map<String, Object?>;
  for (var step = 1; step <= 12; step++) {
    expect(
      actual.scale.step(step),
      _parseColor(solid['$step']! as String),
      reason: '$name.$step',
    );
    expect(
      actual.scale.alphaStep(step),
      _parseColor(alpha['a$step']! as String),
      reason: '$name.a$step',
    );
  }

  expect(actual.surface, _parseColor(expected['surface']! as String));
  expect(actual.indicator, _parseColor(expected['indicator']! as String));
  expect(actual.track, _parseColor(expected['track']! as String));
  expect(actual.contrast, _parseColor(expected['contrast']! as String));
}

Color _parseColor(String source) {
  if (source.startsWith('#')) {
    final hex = source.substring(1);
    if (hex.length == 6) {
      return Color(0xFF000000 | int.parse(hex, radix: 16));
    }
    if (hex.length == 8) {
      final rgb = int.parse(hex.substring(0, 6), radix: 16);
      final alpha = int.parse(hex.substring(6), radix: 16);
      return Color(alpha << 24 | rgb);
    }
  }

  final rgba = RegExp(
    r'^rgba\((\d+), (\d+), (\d+), ([\d.]+)\)$',
  ).firstMatch(source);
  if (rgba != null) {
    final red = int.parse(rgba.group(1)!);
    final green = int.parse(rgba.group(2)!);
    final blue = int.parse(rgba.group(3)!);
    final alpha = (double.parse(rgba.group(4)!) * 255).round();
    return Color(alpha << 24 | red << 16 | green << 8 | blue);
  }

  throw FormatException('Unsupported fixture color: $source');
}
