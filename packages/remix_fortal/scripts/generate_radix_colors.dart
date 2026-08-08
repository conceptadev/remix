import 'dart:convert';
import 'dart:io';

void main() async {
  final generator = RadixColorGenerator();
  await generator.generate();
}

class RadixColorGenerator {
  static const String jsonPath = 'radix_colors.generated.json';
  static const String outputPath = 'lib/src/radix/colors/colors_generated.dart';
  const RadixColorGenerator();
  void _generateColorInstance(
    StringBuffer buffer,
    String colorName,
    Map<String, dynamic> colorData,
  ) {
    final dartName = _toDartName(colorName);
    final light = colorData['light'] as Map<String, dynamic>;
    final dark = colorData['dark'] as Map<String, dynamic>;

    // Generate light instance
    buffer.writeln('const _${dartName}Light = RadixColor(');
    buffer.writeln('  RadixColorScale(');
    _generateColorSwatch(buffer, light, 'solid');
    buffer.writeln(',');
    _generateColorSwatch(buffer, light, 'alpha');
    buffer.writeln(',');
    buffer.writeln('  ),');
    _generateSingleColor(buffer, light['surface'] as String);
    buffer.writeln(',');
    _generateSingleColor(buffer, light['indicator'] as String);
    buffer.writeln(',');
    _generateSingleColor(buffer, light['track'] as String);
    buffer.writeln(',');
    _generateSingleColor(buffer, light['contrast'] as String);
    buffer.writeln(');');
    buffer.writeln();

    // Generate dark instance
    buffer.writeln('const _${dartName}Dark = RadixColor(');
    buffer.writeln('  RadixColorScale(');
    _generateColorSwatch(buffer, dark, 'solid');
    buffer.writeln(',');
    _generateColorSwatch(buffer, dark, 'alpha');
    buffer.writeln(',');
    buffer.writeln('  ),');
    _generateSingleColor(buffer, dark['surface'] as String);
    buffer.writeln(',');
    _generateSingleColor(buffer, dark['indicator'] as String);
    buffer.writeln(',');
    _generateSingleColor(buffer, dark['track'] as String);
    buffer.writeln(',');
    _generateSingleColor(buffer, dark['contrast'] as String);
    buffer.writeln(');');
  }

  void _generateNeutralInstance(
    StringBuffer buffer,
    String colorName,
    Map<String, dynamic> colorData,
  ) {
    final dartName = _toDartName(colorName);
    final alpha = colorData['alpha'] as Map<String, dynamic>;

    // For neutrals, we only generate the alpha ColorSwatch
    buffer.writeln('const _${dartName}Alpha = ColorSwatch(');
    buffer.write('  ${_hexToIntValue(alpha['a9'] as String)}, {');

    for (int i = 1; i <= 12; i++) {
      final key = 'a$i';
      final hexValue = alpha[key] as String;
      buffer.write('\n    $i: ${_hexToFlutterColor(hexValue)},');
    }
    buffer.writeln('\n  },');
    buffer.writeln(');');
  }

  void _generateColorSwatch(
    StringBuffer buffer,
    Map<String, dynamic> themeData,
    String type,
  ) {
    final colorMap = themeData[type] as Map<String, dynamic>;
    final primaryKey = type == 'solid' ? '9' : 'a9';
    final primaryColor = colorMap[primaryKey] as String;

    buffer.write('    ColorSwatch(');
    buffer.write('${_hexToIntValue(primaryColor)}, {');

    if (type == 'solid') {
      for (int i = 1; i <= 12; i++) {
        final hexValue = colorMap[i.toString()] as String;
        buffer.write('\n      $i: ${_hexToFlutterColor(hexValue)},');
      }
    } else {
      for (int i = 1; i <= 12; i++) {
        final key = 'a$i';
        final hexValue = colorMap[key] as String;
        buffer.write('\n      $i: ${_hexToFlutterColor(hexValue)},');
      }
    }
    buffer.write('\n    })');
  }

  void _generateSingleColor(StringBuffer buffer, String hexValue) {
    buffer.write('  ${_hexToFlutterColor(hexValue)}');
  }

  String _hexToFlutterColor(String colorValue) {
    // Handle RGBA format
    if (colorValue.startsWith('rgba(')) {
      final rgba = colorValue.substring(5, colorValue.length - 1);
      final parts = rgba.split(', ');
      final r = int.parse(parts[0]);
      final g = int.parse(parts[1]);
      final b = int.parse(parts[2]);
      final a = (double.parse(parts[3]) * 255).round();

      return 'Color(0x${a.toRadixString(16).padLeft(2, '0')}${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')})';
    }

    // Handle hex format
    String hex = colorValue.replaceFirst('#', '');

    if (hex.length == 6) {
      // Standard 6-digit hex, add FF for full opacity
      return 'Color(0xff$hex)';
    } else if (hex.length == 8) {
      // 8-digit hex with alpha channel
      // Need to move alpha from end to front for Flutter
      final rgb = hex.substring(0, 6);
      final alpha = hex.substring(6, 8);

      return 'Color(0x$alpha$rgb)';
    }

    throw Exception('Unsupported color format: $colorValue');
  }

  String _hexToIntValue(String colorValue) {
    // Handle RGBA format - convert to hex first
    if (colorValue.startsWith('rgba(')) {
      final rgba = colorValue.substring(5, colorValue.length - 1);
      final parts = rgba.split(', ');
      final r = int.parse(parts[0]);
      final g = int.parse(parts[1]);
      final b = int.parse(parts[2]);
      final a = (double.parse(parts[3]) * 255).round();

      return '0x${a.toRadixString(16).padLeft(2, '0')}${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';
    }

    // Handle hex format
    String hex = colorValue.replaceFirst('#', '');

    if (hex.length == 6) {
      // Standard 6-digit hex, add FF for full opacity
      return '0xff$hex';
    } else if (hex.length == 8) {
      // 8-digit hex with alpha channel
      // Need to move alpha from end to front for Flutter
      final rgb = hex.substring(0, 6);
      final alpha = hex.substring(6, 8);

      return '0x$alpha$rgb';
    }

    throw Exception('Unsupported color format: $colorValue');
  }

  String _toDartName(String colorName) {
    if (colorName == 'blackA') return 'blackAlpha';
    if (colorName == 'whiteA') return 'whiteAlpha';

    return colorName;
  }

  Future<void> generate() async {
    print('🎨 Generating Radix colors from JSON...');

    // Read and parse JSON
    final jsonFile = File(jsonPath);
    if (!jsonFile.existsSync()) {
      throw Exception('JSON file not found: $jsonPath');
    }

    final jsonContent = await jsonFile.readAsString();
    final data = jsonDecode(jsonContent) as Map<String, dynamic>;

    final colors = data['colors'] as Map<String, dynamic>;
    final scales = colors['scales'] as Map<String, dynamic>;
    final neutrals = colors['neutrals'] as Map<String, dynamic>;
    final meta = data['meta'] as Map<String, dynamic>;

    // Generate Dart code
    final buffer = StringBuffer();

    // File header
    buffer.writeln('// GENERATED CODE - DO NOT EDIT');
    buffer.writeln('// Generated from: ${meta['description']}');
    buffer.writeln('// Radix Themes version: ${meta['radix_themes_version']}');
    buffer.writeln('// Radix Colors version: ${meta['radix_colors_version']}');
    buffer.writeln('// Source integrity: ${meta['source_integrity']}');
    buffer.writeln();
    buffer.writeln('part of \'colors.dart\';');
    buffer.writeln();

    // Generate color scale instances
    for (final entry in scales.entries) {
      final colorName = entry.key;
      final colorData = entry.value as Map<String, dynamic>;

      buffer.writeln('// $colorName color scale');
      _generateColorInstance(buffer, colorName, colorData);
      buffer.writeln();
    }

    // Generate neutral instances (blackA, whiteA)
    for (final entry in neutrals.entries) {
      final colorName = entry.key;
      final colorData = entry.value as Map<String, dynamic>;

      buffer.writeln('// $colorName neutral');
      _generateNeutralInstance(buffer, colorName, colorData);
      buffer.writeln();
    }

    // Generate RadixColorTheme instances
    buffer.writeln('// Color theme instances');
    for (final colorName in scales.keys) {
      final dartName = _toDartName(colorName);
      buffer.writeln(
        'const $dartName = RadixColorTheme(_${dartName}Light, _${dartName}Dark);',
      );
    }

    // Generate neutral instances
    buffer.writeln();
    buffer.writeln('// Neutral instances');
    for (final colorName in neutrals.keys) {
      final dartName = _toDartName(colorName);
      buffer.writeln('const $dartName = _${dartName}Alpha;');
    }

    // Write to file
    final outputFile = File(outputPath);
    await outputFile.writeAsString(buffer.toString());

    print('✅ Generated $outputPath');
    print('   - ${scales.length} color scales');
    print('   - ${neutrals.length} neutral colors');
  }
}
