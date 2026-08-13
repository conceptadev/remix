import 'dart:io';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

final class ParityCheckResult {
  const ParityCheckResult({required this.callsChecked, required this.issues});

  final int callsChecked;
  final List<String> issues;
}

ParityCheckResult checkStylerCallParity(Directory componentsRoot) {
  final files =
      componentsRoot
          .listSync(recursive: true, followLinks: false)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'))
          .toList()
        ..sort((left, right) => left.path.compareTo(right.path));
  final parsedFiles = <_ParsedFile>[];
  final issues = <String>[];

  for (final file in files) {
    final result = parseString(
      content: file.readAsStringSync(),
      path: file.path,
      throwIfDiagnostics: false,
    );
    parsedFiles.add(_ParsedFile(file: file, result: result));
    for (final error in result.errors) {
      final location = result.lineInfo.getLocation(error.offset);
      issues.add(
        '${_displayPath(file)}:${location.lineNumber}:'
        '${location.columnNumber}: parse error: ${error.message}',
      );
    }
  }

  final widgets = <_DirectoryAndName, List<_WidgetDeclaration>>{};
  for (final parsed in parsedFiles.where(
    (parsed) => parsed.file.path.endsWith('_widget.dart'),
  )) {
    for (final declaration
        in parsed.result.unit.declarations.whereType<ClassDeclaration>()) {
      final key = (
        directory: parsed.file.parent.path,
        name: declaration.namePart.typeName.lexeme,
      );
      widgets
          .putIfAbsent(key, () => [])
          .add(_WidgetDeclaration(parsed: parsed, declaration: declaration));
    }
  }

  var callsChecked = 0;
  for (final parsed in parsedFiles) {
    for (final stylerCall in _stylerCalls(parsed)) {
      final stylerName = stylerCall.stylerName;
      final method = stylerCall.method;
      callsChecked += 1;

      final widgetName = _namedTypeName(method.returnType);
      final methodLocation = _location(parsed, method);
      if (widgetName == null || !widgetName.startsWith('Remix')) {
        issues.add(
          '$methodLocation: $stylerName.call() must declare a Remix widget '
          'return type.',
        );
        continue;
      }

      final matches =
          widgets[(directory: parsed.file.parent.path, name: widgetName)] ??
          const [];
      if (matches.length != 1) {
        issues.add(
          '$methodLocation: $stylerName.call() -> $widgetName expected '
          'exactly one sibling *_widget.dart declaration; found '
          '${matches.length}.',
        );
        continue;
      }

      final widget = matches.single;
      final widgetBody = widget.declaration.body;
      if (widgetBody is! BlockClassBody) {
        issues.add(
          '$methodLocation: $stylerName.call() -> $widgetName has an '
          'unsupported class body.',
        );
        continue;
      }
      final constructors = widgetBody.members
          .whereType<ConstructorDeclaration>()
          .where((constructor) => constructor.name == null)
          .toList();
      if (constructors.length != 1) {
        issues.add(
          '$methodLocation: $stylerName.call() -> $widgetName expected '
          'exactly one unnamed constructor; found ${constructors.length}.',
        );
        continue;
      }

      final callParameters = _namedParameters(
        method.parameters,
        parsed,
        '$stylerName.call()',
        issues,
      );
      final constructorParameters = _namedParameters(
        constructors.single.parameters,
        widget.parsed,
        '$widgetName()',
        issues,
        fieldTypes: _fieldTypes(widget.declaration),
        excludedNames: const {'style', 'styleSpec'},
      );
      final callNames = callParameters.keys.toSet();
      final constructorNames = constructorParameters.keys.toSet();
      final missingNames = constructorNames.difference(callNames).toList()
        ..sort();
      for (final name in missingNames) {
        issues.add(
          '$methodLocation: $stylerName.call() -> $widgetName is missing '
          'constructor parameter `$name`.',
        );
      }
      final staleNames = callNames.difference(constructorNames).toList()
        ..sort();
      for (final name in staleNames) {
        issues.add(
          '$methodLocation: $stylerName.call() parameter `$name` is absent '
          'from the $widgetName constructor.',
        );
      }
      final sharedNames = callNames.intersection(constructorNames).toList()
        ..sort();
      for (final name in sharedNames) {
        final callParameter = callParameters[name]!;
        final constructorParameter = constructorParameters[name]!;
        if (callParameter.type.key != constructorParameter.type.key) {
          issues.add(
            '$methodLocation: $stylerName.call() parameter `$name` has type '
            '`${callParameter.type.display}`; the $widgetName constructor '
            'declares `${constructorParameter.type.display}`.',
          );
        }
        if (callParameter.defaultValue?.key !=
            constructorParameter.defaultValue?.key) {
          issues.add(
            '$methodLocation: $stylerName.call() parameter `$name` has '
            'default ${_displayDefault(callParameter.defaultValue)}; the '
            '$widgetName constructor declares '
            '${_displayDefault(constructorParameter.defaultValue)}.',
          );
        }
        if (callParameter.isRequired != constructorParameter.isRequired) {
          issues.add(
            '$methodLocation: $stylerName.call() parameter `$name` is '
            '${callParameter.isRequired ? 'required' : 'optional'}; the '
            '$widgetName constructor declares it '
            '${constructorParameter.isRequired ? 'required' : 'optional'}.',
          );
        }
      }
    }
  }

  return ParityCheckResult(callsChecked: callsChecked, issues: issues);
}

typedef _DirectoryAndName = ({String directory, String name});

final class _ParsedFile {
  const _ParsedFile({required this.file, required this.result});

  final File file;
  final ParseStringResult result;
}

final class _WidgetDeclaration {
  const _WidgetDeclaration({required this.parsed, required this.declaration});

  final _ParsedFile parsed;
  final ClassDeclaration declaration;
}

final class _StylerCall {
  const _StylerCall({required this.stylerName, required this.method});

  final String stylerName;
  final MethodDeclaration method;
}

Iterable<_StylerCall> _stylerCalls(_ParsedFile parsed) sync* {
  final declarations = parsed.result.unit.declarations;
  // Hand-written helpers live in extensions; mix_generator emits call()
  // directly on the generated Styler class.
  for (final extension in declarations.whereType<ExtensionDeclaration>()) {
    final extensionName = extension.name?.lexeme;
    if (extensionName == null ||
        !extensionName.startsWith('Remix') ||
        !extensionName.endsWith('StylerRemixHelpers')) {
      continue;
    }
    final stylerName = _namedTypeName(extension.onClause?.extendedType);
    if (stylerName == null || !stylerName.endsWith('Styler')) continue;
    for (final method
        in extension.body.members.whereType<MethodDeclaration>()) {
      if (method.name.lexeme == 'call') {
        yield _StylerCall(stylerName: stylerName, method: method);
      }
    }
  }

  if (!parsed.file.path.endsWith('.g.dart')) return;
  for (final declaration in declarations.whereType<ClassDeclaration>()) {
    final stylerName = declaration.namePart.typeName.lexeme;
    final body = declaration.body;
    if (!stylerName.endsWith('Styler') || body is! BlockClassBody) continue;
    for (final method in body.members.whereType<MethodDeclaration>()) {
      if (method.name.lexeme == 'call') {
        yield _StylerCall(stylerName: stylerName, method: method);
      }
    }
  }
}

final class _ParameterShape {
  const _ParameterShape({
    required this.type,
    required this.defaultValue,
    required this.isRequired,
  });

  final _DeclaredSource type;
  final _DeclaredSource? defaultValue;
  final bool isRequired;
}

final class _DeclaredSource {
  const _DeclaredSource({required this.display, required this.key});

  factory _DeclaredSource.fromNode(AstNode node) {
    final tokens = <String>[];
    var token = node.beginToken;
    while (true) {
      tokens.add(token.lexeme);
      if (identical(token, node.endToken)) break;
      token = token.next!;
    }
    return _DeclaredSource(display: node.toSource(), key: tokens.join());
  }

  factory _DeclaredSource.literal(String source) {
    return _DeclaredSource(display: source, key: source);
  }

  final String display;
  final String key;
}

String? _namedTypeName(TypeAnnotation? type) {
  return switch (type) {
    NamedType(:final name) => name.lexeme,
    _ => null,
  };
}

Map<String, _ParameterShape> _namedParameters(
  FormalParameterList? parameters,
  _ParsedFile parsed,
  String owner,
  List<String> issues, {
  Map<String, _DeclaredSource> fieldTypes = const {},
  Set<String> excludedNames = const {},
}) {
  if (parameters == null) return const {};
  final shapes = <String, _ParameterShape>{};
  for (final parameter in parameters.parameters) {
    final name = parameter.name?.lexeme;
    if (!parameter.isNamed || name == null) {
      issues.add(
        '${_location(parsed, parameter)}: $owner contains an unsupported '
        'non-named or unnamed parameter `${parameter.toSource()}`.',
      );
      continue;
    }
    if (excludedNames.contains(name)) continue;
    final normal = switch (parameter) {
      DefaultFormalParameter(:final parameter) => parameter,
      NormalFormalParameter normal => normal,
    };
    final type = _parameterType(normal, fieldTypes);
    if (type == null) {
      issues.add(
        '${_location(parsed, parameter)}: cannot determine the declared type '
        'of $owner parameter `$name` from syntax.',
      );
      continue;
    }
    final defaultValue = switch (parameter) {
      DefaultFormalParameter(:final defaultValue?) => _DeclaredSource.fromNode(
        defaultValue,
      ),
      _ => null,
    };
    if (shapes.containsKey(name)) {
      issues.add(
        '${_location(parsed, parameter)}: $owner declares duplicate named '
        'parameter `$name`.',
      );
      continue;
    }
    shapes[name] = _ParameterShape(
      type: type,
      defaultValue: defaultValue,
      isRequired: parameter.isRequiredNamed,
    );
  }
  return shapes;
}

Map<String, _DeclaredSource> _fieldTypes(ClassDeclaration declaration) {
  final body = declaration.body;
  if (body is! BlockClassBody) return const {};
  final fields = <String, _DeclaredSource>{};
  for (final field in body.members.whereType<FieldDeclaration>()) {
    if (field.isStatic) continue;
    final type = field.fields.type;
    if (type == null) continue;
    final source = _DeclaredSource.fromNode(type);
    for (final variable in field.fields.variables) {
      fields[variable.name.lexeme] = source;
    }
  }
  return fields;
}

_DeclaredSource? _parameterType(
  NormalFormalParameter parameter,
  Map<String, _DeclaredSource> fieldTypes,
) {
  return switch (parameter) {
    SimpleFormalParameter(:final type?) => _DeclaredSource.fromNode(type),
    FieldFormalParameter(:final type?) => _DeclaredSource.fromNode(type),
    FieldFormalParameter(:final name) => fieldTypes[name.lexeme],
    SuperFormalParameter(:final type?) => _DeclaredSource.fromNode(type),
    SuperFormalParameter(:final name) when name.lexeme == 'key' =>
      _DeclaredSource.literal('Key?'),
    FunctionTypedFormalParameter function => _DeclaredSource.literal(
      _functionTypeSource(function),
    ),
    _ => null,
  };
}

String _functionTypeSource(FunctionTypedFormalParameter parameter) {
  final returnType = parameter.returnType?.toSource() ?? 'dynamic';
  final typeParameters = parameter.typeParameters?.toSource() ?? '';
  final nullable = parameter.question == null ? '' : '?';
  return '$returnType Function$typeParameters'
      '${parameter.parameters.toSource()}$nullable';
}

String _displayDefault(_DeclaredSource? source) {
  return source == null ? '<none>' : '`${source.display}`';
}

String _location(_ParsedFile parsed, AstNode node) {
  final location = parsed.result.lineInfo.getLocation(node.offset);
  return '${_displayPath(parsed.file)}:${location.lineNumber}:'
      '${location.columnNumber}';
}

String _displayPath(File file) {
  final current = Directory.current.absolute.path;
  final absolute = file.absolute.path;
  final prefix = '$current${Platform.pathSeparator}';
  return absolute.startsWith(prefix)
      ? absolute.substring(prefix.length)
      : absolute;
}

void main() {
  final componentsRoot = Directory(
    'packages/remix/lib/src/components',
  ).absolute;
  if (!componentsRoot.existsSync()) {
    stderr.writeln(
      'Run this checker from the Remix workspace root; '
      '${componentsRoot.path} does not exist.',
    );
    exitCode = 64;
    return;
  }

  final result = checkStylerCallParity(componentsRoot);
  if (result.issues.isNotEmpty) {
    stderr.writeln(
      'Styler.call() parity failed with ${result.issues.length} issue(s):',
    );
    for (final issue in result.issues) {
      stderr.writeln('- $issue');
    }
    exitCode = 1;
    return;
  }

  stdout.writeln(
    'Verified ${result.callsChecked} Styler.call() method(s) against their '
    'widget constructors.',
  );
}
