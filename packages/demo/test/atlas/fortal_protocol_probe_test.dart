import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mix_protocol/mix_protocol.dart';
import 'package:remix/remix.dart';

import 'support/fortal_button_component_artifact.dart';

void main() {
  group('Fortal protocol probe', () {
    for (final brightness in Brightness.values) {
      testWidgets('${brightness.name} theme round-trips canonically', (
        tester,
      ) async {
        final tokens = await _captureFortalTokens(tester, brightness);
        final protocolTokens = _protocolTokens(tokens);

        final encoded = _expectSuccess(
          mixProtocol.encodeTheme(MixProtocolTheme(tokens: protocolTokens)),
        );
        final decoded = _expectSuccess(mixProtocol.decodeTheme(encoded));
        final reencoded = _expectSuccess(mixProtocol.encodeTheme(decoded));

        expect(reencoded, encoded);
        expect(decoded.tokens, hasLength(protocolTokens.length));

        final surfaceDocument = _surfaceTokenDocument(tokens);
        expect(surfaceDocument['schema'], 'remix/surface-tokens/v1');
        expect(
          surfaceDocument['tokens'],
          hasLength(tokens.length - protocolTokens.length),
        );
      });
    }

    test('built-in Fortal-tokenized style round-trips', () {
      final style = FlexBoxStyler(
        decoration: BoxDecorationMix(color: FortalTokens.accent9()),
        padding: EdgeInsetsMix.all(FortalTokens.space3()),
        spacing: FortalTokens.space2(),
      );

      final encoded = _expectSuccess(mixProtocol.encodeStyle(style));
      final decoded = _expectSuccess(
        mixProtocol.decodeStyle<FlexBoxStyler>(encoded),
      );
      final reencoded = _expectSuccess(mixProtocol.encodeStyle(decoded));
      final references = tokenReferencesOf(
        decoded,
      ).map((reference) => '${reference.kind}:${reference.name}').toSet();

      expect(reencoded, encoded);
      expect(references, {
        'colors:fortal.accent.9',
        'spaces:fortal.space.2',
        'spaces:fortal.space.3',
      });
    });

    test('fluent multi-source built-in style round-trips canonically', () {
      final style = FlexBoxStyler()
          .color(FortalTokens.accent9())
          .paddingAll(FortalTokens.space3())
          .spacing(FortalTokens.space2());

      final encoded = _expectSuccess(mixProtocol.encodeStyle(style));
      final decoded = _expectSuccess(
        mixProtocol.decodeStyle<FlexBoxStyler>(encoded),
      );
      final reencoded = _expectSuccess(mixProtocol.encodeStyle(decoded));
      final references = tokenReferencesOf(
        decoded,
      ).map((reference) => '${reference.kind}:${reference.name}').toSet();

      expect(reencoded, encoded);
      expect(references, {
        'colors:fortal.accent.9',
        'spaces:fortal.space.2',
        'spaces:fortal.space.3',
      });
    });

    test('custom ButtonStyler fails with a structured diagnostic', () {
      final errors = _expectFailure(
        mixProtocol.encodeStyle(fortalButtonStyler()),
      );

      expect(
        errors.map((error) => error.code),
        contains(MixProtocolErrorCode.unsupportedEncodeValue),
      );
      expect(errors, everyElement(isA<MixProtocolError>()));
    });

    test('strict theme decode rejects unknown fields', () {
      final errors = _expectFailure(
        mixProtocol.decodeTheme({
          'v': mixProtocolFormatVersion,
          'type': 'theme',
          'unexpected': true,
        }),
      );

      expect(errors.single.code, MixProtocolErrorCode.unknownField);
      expect(errors.single.path, '/unexpected');
    });

    test('theme decode rejects unsupported versions', () {
      final errors = _expectFailure(
        mixProtocol.decodeTheme({'v': 999, 'type': 'theme'}),
      );

      expect(errors.single.code, MixProtocolErrorCode.unsupportedVersion);
      expect(errors.single.path, '/v');
    });

    testWidgets('canonical protocol artifacts match', (tester) async {
      if (autoUpdateGoldenFiles) _resetGeneratedButtonArtifacts();
      final themeCoverage = <Map<String, Object?>>[];

      for (final brightness in Brightness.values) {
        final tokens = await _captureFortalTokens(tester, brightness);
        final protocolTokens = _protocolTokens(tokens);
        final surfaceDocument = _surfaceTokenDocument(tokens);
        final themeDocument = _expectSuccess(
          mixProtocol.encodeTheme(MixProtocolTheme(tokens: protocolTokens)),
        );

        _expectJsonArtifact(
          'goldens/protocol/themes/${brightness.name}.mix.json',
          themeDocument,
        );
        _expectJsonArtifact(
          'goldens/protocol/themes/${brightness.name}.remix-surfaces.json',
          surfaceDocument,
        );
        final surfaceTokens = surfaceDocument['tokens']! as List<Object?>;
        themeCoverage.add({
          'id': brightness.name,
          'status': 'supported-with-remix-extension',
          'tokenCount': tokens.length,
          'mixProtocolTokenCount': protocolTokens.length,
          'remixSurfaceTokenCount': surfaceTokens.length,
          'surfaceDocument': 'themes/${brightness.name}.remix-surfaces.json',
        });
      }

      final builtInStyle = FlexBoxStyler(
        decoration: BoxDecorationMix(color: FortalTokens.accent9()),
        padding: EdgeInsetsMix.all(FortalTokens.space3()),
        spacing: FortalTokens.space2(),
      );
      final builtInDocument = _expectSuccess(
        mixProtocol.encodeStyle(builtInStyle),
      );
      final builtInReferences = tokenReferencesOf(builtInStyle).toList()
        ..sort(
          (a, b) => '${a.kind}:${a.name}'.compareTo('${b.kind}:${b.name}'),
        );
      _expectJsonArtifact(
        'goldens/protocol/fixtures/fortal-tokenized-flex-box.mix.json',
        builtInDocument,
      );

      final componentArtifacts = buildFortalButtonComponentArtifacts();
      _expectJsonArtifact(
        'goldens/components/button.component.json',
        componentArtifacts.document,
      );
      final componentStyleEntries =
          componentArtifacts.styleDocuments.entries.toList()
            ..sort((left, right) => left.key.compareTo(right.key));
      for (final entry in componentStyleEntries) {
        _expectJsonArtifact('goldens/${entry.key}', entry.value);
      }
      final componentRecipes =
          componentArtifacts.document['recipes']! as List<Object?>;
      final firstRecipe = componentRecipes.first! as Map<String, Object?>;
      final firstStyles = firstRecipe['styles']! as Map<String, Object?>;
      final firstContainer = firstStyles['container']! as Map<String, Object?>;
      final firstSpinner = firstStyles['spinner']! as Map<String, Object?>;
      final componentDiagnostics = <Object?>[
        ...(firstSpinner['diagnostics']! as List<Object?>),
        if (firstContainer['status'] == 'unsupported')
          ...(firstContainer['diagnostics']! as List<Object?>),
      ];

      final fluentStyle = FlexBoxStyler()
          .color(FortalTokens.accent9())
          .paddingAll(FortalTokens.space3())
          .spacing(FortalTokens.space2());
      final fluentDocument = _expectSuccess(
        mixProtocol.encodeStyle(fluentStyle),
      );
      final fluentRoundTrip = _expectSuccess(
        mixProtocol.decodeStyle<FlexBoxStyler>(fluentDocument),
      );
      final fluentReferences = tokenReferencesOf(fluentRoundTrip).toList()
        ..sort(
          (a, b) => '${a.kind}:${a.name}'.compareTo('${b.kind}:${b.name}'),
        );
      final customErrors = _expectFailure(
        mixProtocol.encodeStyle(fortalButtonStyler()),
      );
      final coverage = <String, Object?>{
        'schema': 'mix_atlas/protocol-coverage/v1',
        'mixProtocolVersion': mixProtocolVersion,
        'mixProtocolFormat': mixProtocolFormatVersion,
        'themes': themeCoverage,
        'styles': [
          {
            'id': 'fortal-tokenized-flex-box-fixture',
            'runtimeType': 'FlexBoxStyler',
            'status': 'supported',
            'tokenReferences': [
              for (final reference in builtInReferences)
                {'kind': reference.kind, 'name': reference.name},
            ],
          },
          {
            'id': 'fortal-tokenized-flex-box-fluent',
            'runtimeType': 'FlexBoxStyler',
            'status': 'supported',
            'tokenReferences': [
              for (final reference in fluentReferences)
                {'kind': reference.kind, 'name': reference.name},
            ],
          },
          {
            'id': 'fortal-button-portable',
            'runtimeType': 'ButtonStyler projection',
            'status':
                componentArtifacts.supportedContainerRecipes ==
                    componentArtifacts.recipeCount
                ? 'partial'
                : 'unsupported',
            'recipeCount': componentRecipes.length,
            'totalMatrixCells': componentArtifacts.totalMatrixCells,
            'nonLoadingCells': componentArtifacts.nonLoadingCells,
            'loadingUnsupportedCells':
                componentArtifacts.loadingUnsupportedCells,
            'supportedContainerRecipes':
                componentArtifacts.supportedContainerRecipes,
            'diagnostics': componentDiagnostics,
          },
          {
            'id': 'fortal-button',
            'runtimeType': 'ButtonStyler',
            'status': 'unsupported',
            'diagnostics': [for (final error in customErrors) error.toJson()],
          },
        ],
      };
      _expectJsonArtifact('goldens/protocol/coverage.json', coverage);
    });
  });
}

void _resetGeneratedButtonArtifacts() {
  final comparator = goldenFileComparator;
  if (comparator is! LocalFileComparator) {
    fail('Protocol artifacts require Flutter LocalFileComparator.');
  }
  for (final path in ['goldens/components', 'goldens/styles']) {
    final directory = Directory.fromUri(comparator.basedir.resolve(path));
    if (directory.existsSync()) directory.deleteSync(recursive: true);
  }
}

Future<Map<MixToken, Object>> _captureFortalTokens(
  WidgetTester tester,
  Brightness brightness,
) async {
  Map<MixToken, Object>? captured;

  await tester.pumpWidget(
    FortalScope(
      appearance: brightness == .dark ? .dark : .light,
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            captured = Map.unmodifiable(MixScope.of(context).tokens!);

            return const SizedBox.shrink();
          },
        ),
      ),
    ),
  );

  return captured!;
}

Map<MixToken, Object> _protocolTokens(Map<MixToken, Object> tokens) {
  return Map.unmodifiable({
    for (final entry in tokens.entries)
      if (entry.key is! RemixPaintShadowListToken) entry.key: entry.value,
  });
}

Map<String, Object?> _surfaceTokenDocument(Map<MixToken, Object> tokens) {
  final entries =
      tokens.entries
          .where((entry) => entry.key is RemixPaintShadowListToken)
          .toList(growable: false)
        ..sort((left, right) => left.key.name.compareTo(right.key.name));

  return {
    'schema': 'remix/surface-tokens/v1',
    'colorFormat': 'AARRGGBB',
    'tokens': [
      for (final entry in entries)
        {
          'name': entry.key.name,
          'layers': [
            for (final shadow in entry.value as List<RemixPaintShadow>)
              {
                'kind': shadow.kind.name,
                'color': _colorHex(shadow.color),
                'offset': {'x': shadow.offset.dx, 'y': shadow.offset.dy},
                'blurRadius': shadow.blurRadius,
                'spreadRadius': shadow.spreadRadius,
              },
          ],
        },
    ],
  };
}

String _colorHex(Color color) =>
    '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';

T _expectSuccess<T extends Object>(MixProtocolResult<T> result) {
  return switch (result) {
    MixProtocolSuccess<T>(:final value) => value,
    MixProtocolFailure<T>(:final errors) => fail('Expected success: $errors'),
  };
}

List<MixProtocolError> _expectFailure<T extends Object>(
  MixProtocolResult<T> result,
) {
  return switch (result) {
    MixProtocolFailure<T>(:final errors) => errors,
    MixProtocolSuccess<T>() => fail('Expected protocol failure.'),
  };
}

void _expectJsonArtifact(String path, Map<String, Object?> payload) {
  final canonical = '${const JsonEncoder.withIndent('  ').convert(payload)}\n';
  final comparator = goldenFileComparator;
  if (comparator is! LocalFileComparator) {
    fail('Protocol artifacts require Flutter LocalFileComparator.');
  }
  final file = File.fromUri(comparator.basedir.resolve(path));

  if (autoUpdateGoldenFiles) {
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(canonical);

    return;
  }

  expect(file.existsSync(), isTrue, reason: 'Missing protocol artifact: $path');
  if (!file.existsSync()) return;
  expect(
    file.readAsStringSync(),
    canonical,
    reason: 'Stale protocol artifact: $path',
  );
}
