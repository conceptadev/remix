import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mix_protocol/mix_protocol.dart';
import 'package:remix/remix.dart';

import 'support/fortal_button_protocol_adapter.dart';
import 'support/fortal_button_component_artifact.dart';

void main() {
  group('Fortal Button protocol adapter', () {
    test('projects real composite sources without restating the recipe', () {
      final projection = projectButtonStyler(
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

    test('encodes every recipe without resolving constraint tokens', () {
      for (final variant in FortalButtonVariant.values) {
        for (final size in FortalButtonSize.values) {
          final projection = projectButtonStyler(
            fortalButtonStyler(variant: variant, size: size),
          );

          final container = mixProtocol.encodeStyle(projection.container!);
          expect(
            container,
            isA<MixProtocolSuccess<Map<String, Object?>>>(),
            reason: '${variant.name}-${size.name} container',
          );
          final document =
              (container as MixProtocolSuccess<Map<String, Object?>>).value;
          if (variant != FortalButtonVariant.ghost) {
            final constraints =
                document['constraints']! as Map<String, Object?>;
            final minHeight = constraints['minHeight']! as Map<String, Object?>;
            final expectedToken = switch (size) {
              FortalButtonSize.size1 => 'fortal.space.5',
              FortalButtonSize.size2 => 'fortal.space.6',
              FortalButtonSize.size3 => 'fortal.space.7',
              FortalButtonSize.size4 => 'fortal.space.8',
            };
            expect(minHeight, {r'$token': expectedToken, 'kind': 'space'});
            expect(constraints['maxHeight'], minHeight);
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
        final projection = projectButtonStyler(fortalButtonStyler());

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
      expect(first.styleDocuments, hasLength(72));
      expect(first.supportedContainerRecipes, 24);
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
        expect(container['status'], 'supported');
        expect(container['document'], endsWith('/container.mix.json'));
      }
    });
  });
}
