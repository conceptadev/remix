import 'package:remix/remix.dart';

final class ButtonProjectionDiagnostic {
  const ButtonProjectionDiagnostic({
    required this.code,
    required this.severity,
    required this.path,
    required this.message,
  });

  final String code;
  final String severity;
  final String path;
  final String message;

  Map<String, Object?> toJson() => {
    'code': code,
    'severity': severity,
    'path': path,
    'message': message,
  };
}

final class RemixButtonProtocolProjection {
  RemixButtonProtocolProjection({
    required this.container,
    required this.label,
    required this.icon,
    required List<ButtonProjectionDiagnostic> diagnostics,
  }) : diagnostics = List.unmodifiable(diagnostics);

  final FlexBoxStyler? container;
  final TextStyler? label;
  final IconStyler? icon;
  final List<ButtonProjectionDiagnostic> diagnostics;

  bool get spinnerSupported => false;

  ButtonProjectionDiagnostic get spinnerDiagnostic =>
      const ButtonProjectionDiagnostic(
        code: 'unsupported_slot_primitive',
        severity: 'error',
        path: 'spinner',
        message: 'RemixSpinner has no neutral Mix protocol primitive.',
      );
}

/// Projects a real Remix Button style into protocol-supported leaf stylers.
///
/// It reads the composite style's existing sources and variants, then combines
/// leaf stylers through their generated `merge` implementations. It does not
/// resolve a widget, inspect private fields, or restate the Fortal recipe.
RemixButtonProtocolProjection projectButtonStyler(ButtonStyler style) {
  final effectiveStyle = RemixButton.composeStyle(style);
  final container = _projectContainer(effectiveStyle, depth: 0);
  final label = _projectLabel(effectiveStyle, depth: 0);
  final icon = _projectIcon(effectiveStyle, depth: 0);
  final diagnostics = <ButtonProjectionDiagnostic>[
    ...container.diagnostics,
    ...label.diagnostics,
    ...icon.diagnostics,
  ];
  if (effectiveStyle.$modifier != null) {
    diagnostics.add(
      const ButtonProjectionDiagnostic(
        code: 'unsupported_component_modifier',
        severity: 'error',
        path: 'modifier',
        message: 'Button-level widget modifiers cannot be projected to a slot.',
      ),
    );
  }
  if (effectiveStyle.$animation != null) {
    diagnostics.add(
      const ButtonProjectionDiagnostic(
        code: 'unsupported_component_animation',
        severity: 'error',
        path: 'animation',
        message: 'Button-level animation cannot be projected to a single slot.',
      ),
    );
  }
  return RemixButtonProtocolProjection(
    container: container.value,
    label: label.value,
    icon: icon.value,
    diagnostics: diagnostics,
  );
}

final class _Projection<T extends Object> {
  const _Projection({required this.value, required this.diagnostics});

  final T? value;
  final List<ButtonProjectionDiagnostic> diagnostics;
}

_Projection<FlexBoxStyler> _projectContainer(
  ButtonStyler style, {
  required int depth,
}) {
  if (depth > 16) return _depthFailure('container');
  final diagnostics = <ButtonProjectionDiagnostic>[];
  FlexBoxStyler? result;
  final property = style.$container;
  if (property != null) {
    if (property.$directives?.isNotEmpty ?? false) {
      diagnostics.add(_unsupportedSource('container', 'directives'));
    }
    for (final source in property.sources) {
      if (source is MixSource<StyleSpec<FlexBoxSpec>> &&
          source.mix is FlexBoxStyler) {
        final leaf = source.mix as FlexBoxStyler;
        result = result == null ? leaf : result.merge(leaf);
      } else {
        diagnostics.add(
          _unsupportedSource('container', source.runtimeType.toString()),
        );
      }
    }
  }
  final variants = <VariantStyle<FlexBoxSpec>>[];
  for (final variant
      in style.$variants ?? const <VariantStyle<RemixButtonSpec>>[]) {
    final nested = variant.value;
    if (nested is! ButtonStyler) {
      diagnostics.add(
        _unsupportedSource('container', nested.runtimeType.toString()),
      );
      continue;
    }
    final projected = _projectContainer(nested, depth: depth + 1);
    diagnostics.addAll(projected.diagnostics);
    if (projected.value != null) {
      variants.add(VariantStyle(variant.variant, projected.value!));
    }
  }
  if (variants.isNotEmpty) {
    result = (result ?? FlexBoxStyler()).variants(variants);
  }

  return _Projection(value: result, diagnostics: diagnostics);
}

_Projection<TextStyler> _projectLabel(
  ButtonStyler style, {
  required int depth,
}) {
  if (depth > 16) return _depthFailure('label');
  final diagnostics = <ButtonProjectionDiagnostic>[];
  TextStyler? result;
  final property = style.$label;
  if (property != null) {
    if (property.$directives?.isNotEmpty ?? false) {
      diagnostics.add(_unsupportedSource('label', 'directives'));
    }
    for (final source in property.sources) {
      if (source is MixSource<StyleSpec<TextSpec>> &&
          source.mix is TextStyler) {
        final leaf = source.mix as TextStyler;
        result = result == null ? leaf : result.merge(leaf);
      } else {
        diagnostics.add(
          _unsupportedSource('label', source.runtimeType.toString()),
        );
      }
    }
  }
  final variants = <VariantStyle<TextSpec>>[];
  for (final variant
      in style.$variants ?? const <VariantStyle<RemixButtonSpec>>[]) {
    final nested = variant.value;
    if (nested is! ButtonStyler) {
      diagnostics.add(
        _unsupportedSource('label', nested.runtimeType.toString()),
      );
      continue;
    }
    final projected = _projectLabel(nested, depth: depth + 1);
    diagnostics.addAll(projected.diagnostics);
    if (projected.value != null) {
      variants.add(VariantStyle(variant.variant, projected.value!));
    }
  }
  if (variants.isNotEmpty) {
    result = (result ?? TextStyler()).variants(variants);
  }

  return _Projection(value: result, diagnostics: diagnostics);
}

_Projection<IconStyler> _projectIcon(ButtonStyler style, {required int depth}) {
  if (depth > 16) return _depthFailure('icon');
  final diagnostics = <ButtonProjectionDiagnostic>[];
  IconStyler? result;
  final property = style.$icon;
  if (property != null) {
    if (property.$directives?.isNotEmpty ?? false) {
      diagnostics.add(_unsupportedSource('icon', 'directives'));
    }
    for (final source in property.sources) {
      if (source is MixSource<StyleSpec<IconSpec>> &&
          source.mix is IconStyler) {
        final leaf = source.mix as IconStyler;
        result = result == null ? leaf : result.merge(leaf);
      } else {
        diagnostics.add(
          _unsupportedSource('icon', source.runtimeType.toString()),
        );
      }
    }
  }
  final variants = <VariantStyle<IconSpec>>[];
  for (final variant
      in style.$variants ?? const <VariantStyle<RemixButtonSpec>>[]) {
    final nested = variant.value;
    if (nested is! ButtonStyler) {
      diagnostics.add(
        _unsupportedSource('icon', nested.runtimeType.toString()),
      );
      continue;
    }
    final projected = _projectIcon(nested, depth: depth + 1);
    diagnostics.addAll(projected.diagnostics);
    if (projected.value != null) {
      variants.add(VariantStyle(variant.variant, projected.value!));
    }
  }
  if (variants.isNotEmpty) {
    result = (result ?? IconStyler()).variants(variants);
  }

  return _Projection(value: result, diagnostics: diagnostics);
}

_Projection<T> _depthFailure<T extends Object>(String path) => _Projection(
  value: null,
  diagnostics: [
    ButtonProjectionDiagnostic(
      code: 'component_projection_limit',
      severity: 'error',
      path: path,
      message: 'Button variant nesting exceeds the projection limit.',
    ),
  ],
);

ButtonProjectionDiagnostic _unsupportedSource(String path, String source) =>
    ButtonProjectionDiagnostic(
      code: 'unsupported_component_source',
      severity: 'error',
      path: path,
      message: 'Cannot project $source into a built-in $path styler.',
    );
