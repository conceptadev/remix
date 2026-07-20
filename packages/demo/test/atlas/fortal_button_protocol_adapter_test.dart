import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mix_protocol/mix_protocol.dart';
import 'package:remix/remix.dart';

import 'support/fortal_button_protocol_adapter.dart';
import 'support/fortal_button_component_artifact.dart';

void main() {
  group('Fortal Button protocol adapter', () {
    test('projects real composite sources without restating the recipe', () {
      final projection = projectRemixButtonStyler(
        fortalButtonStyler(
          variant: FortalButtonVariant.surface,
          size: FortalButtonSize.size3,
        ),
      );

      expect(projection.container, isNotNull);
      expect(projection.label, isNotNull);
      expect(projection.icon, isNotNull);
      expect(projection.diagnostics, isEmpty);
      expect(
        mixProtocol.encodeStyle(projection.label!),
        isA<MixProtocolSuccess<Map<String, Object?>>>(),
      );
      expect(
        mixProtocol.encodeStyle(projection.icon!),
        isA<MixProtocolSuccess<Map<String, Object?>>>(),
      );
    });

    test('records the exact neutral-protocol boundary for every recipe', () {
      for (final variant in FortalButtonVariant.values) {
        for (final size in FortalButtonSize.values) {
          final projection = projectRemixButtonStyler(
            fortalButtonStyler(variant: variant, size: size),
          );

          final container = mixProtocol.encodeStyle(projection.container!);
          if (variant == FortalButtonVariant.ghost) {
            expect(
              container,
              isA<MixProtocolSuccess<Map<String, Object?>>>(),
              reason: '${variant.name}-${size.name} container',
            );
          } else {
            expect(
              container,
              isA<MixProtocolFailure<Map<String, Object?>>>(),
              reason: '${variant.name}-${size.name} container',
            );
            final failure =
                container as MixProtocolFailure<Map<String, Object?>>;
            expect(
              failure.errors.map((error) => error.toJson()),
              contains(containsPair('path', '/constraints')),
              reason: '${variant.name}-${size.name} diagnostic',
            );
          }
          expect(
            mixProtocol.encodeStyle(projection.label!),
            isA<MixProtocolSuccess<Map<String, Object?>>>(),
            reason: '${variant.name}-${size.name} label',
          );
          expect(
            mixProtocol.encodeStyle(projection.icon!),
            isA<MixProtocolSuccess<Map<String, Object?>>>(),
            reason: '${variant.name}-${size.name} icon',
          );
        }
      }
    });

    test(
      'keeps spinner support explicit instead of projecting custom code',
      () {
        final projection = projectRemixButtonStyler(fortalButtonStyler());

        expect(projection.spinnerSupported, isFalse);
        expect(projection.spinnerDiagnostic.code, 'unsupported_slot_primitive');
        expect(projection.spinnerDiagnostic.path, 'spinner');
      },
    );

    test('builds a deterministic 288-cell portable Button contract', () {
      final first = buildFortalButtonComponentArtifacts();
      final second = buildFortalButtonComponentArtifacts();
      final recipes = first.document['recipes']! as List<Object?>;
      final states = first.document['states']! as List<Object?>;
      final oracles = first.document['oracles']! as List<Object?>;

      expect(recipes, hasLength(24));
      expect(first.recipeCount, 24);
      expect(states, hasLength(6));
      expect(oracles, hasLength(2));
      expect(first.totalMatrixCells, 288);
      expect(first.nonLoadingCells, 240);
      expect(first.loadingUnsupportedCells, 48);
      expect(first.styleDocuments, hasLength(52));
      expect(first.supportedContainerRecipes, 4);
      expect(jsonEncode(first.document), jsonEncode(second.document));
      expect(
        jsonEncode(first.styleDocuments),
        jsonEncode(second.styleDocuments),
      );
      for (final recipeValue in recipes) {
        final recipe = recipeValue! as Map<String, Object?>;
        final styles = recipe['styles']! as Map<String, Object?>;
        expect(styles.keys, {
          'container',
          'label',
          'leadingIcon',
          'trailingIcon',
          'spinner',
        });
        final spinner = styles['spinner']! as Map<String, Object?>;
        expect(spinner['status'], 'unsupported');
        final container = styles['container']! as Map<String, Object?>;
        final properties = recipe['properties']! as Map<String, Object?>;
        if (properties['variant'] == FortalButtonVariant.ghost.name) {
          expect(container['status'], 'supported');
          expect(container['document'], endsWith('/container.mix.json'));
        } else {
          expect(container['status'], 'unsupported');
          final diagnostics = container['diagnostics']! as List<Object?>;
          expect(
            diagnostics.cast<Map<String, Object?>>(),
            contains(containsPair('path', '/constraints')),
          );
        }
      }
    });
  });
}
