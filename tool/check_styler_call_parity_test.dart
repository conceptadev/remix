import 'dart:io';

import 'check_styler_call_parity.dart';

void main() {
  final fixture = Directory.systemTemp.createTempSync(
    'styler_call_parity_test_',
  );

  try {
    _writeWidget(fixture);
    _writeStyler(
      fixture,
      'transitionBuilder ?? RemixThing.defaultTransitionBuilder',
    );

    final equivalentResult = checkStylerCallParity(fixture);
    if (equivalentResult.callsChecked != 1 ||
        equivalentResult.issues.isNotEmpty) {
      _fail(
        'Expected a nullable parameter forwarded with the constructor '
        'default fallback to satisfy parity.',
        equivalentResult,
      );
      return;
    }

    _writeStyler(
      fixture,
      'transitionBuilder ?? RemixThing.otherTransitionBuilder',
    );
    final wrongFallbackResult = checkStylerCallParity(fixture);
    final reportsType = wrongFallbackResult.issues.any(
      (issue) => issue.contains('parameter `transitionBuilder` has type'),
    );
    final reportsDefault = wrongFallbackResult.issues.any(
      (issue) => issue.contains('parameter `transitionBuilder` has default'),
    );
    if (wrongFallbackResult.callsChecked != 1 ||
        !reportsType ||
        !reportsDefault) {
      _fail(
        'Expected a fallback other than the constructor default to retain '
        'the type and default parity failures.',
        wrongFallbackResult,
      );
      return;
    }

    stdout.writeln(
      'Verified nullable Styler.call() default fallback equivalence.',
    );
  } finally {
    fixture.deleteSync(recursive: true);
  }
}

void _writeStyler(Directory fixture, String forwardedExpression) {
  File('${fixture.path}/thing_style.dart').writeAsStringSync('''
extension RemixThingStylerRemixHelpers on ThingStyler {
  RemixThing call({
    Widget Function(Widget)? transitionBuilder,
  }) {
    return RemixThing(
      transitionBuilder: $forwardedExpression,
      style: this,
    );
  }
}
''');
}

void _writeWidget(Directory fixture) {
  File('${fixture.path}/thing_widget.dart').writeAsStringSync('''
class RemixThing {
  const RemixThing({
    this.transitionBuilder = defaultTransitionBuilder,
    this.style,
  });

  static Widget defaultTransitionBuilder(Widget child) => child;

  final Widget Function(Widget) transitionBuilder;
  final Object? style;
}
''');
}

void _fail(String message, ParityCheckResult result) {
  stderr
    ..writeln(message)
    ..writeln('Calls checked: ${result.callsChecked}')
    ..writeln('Issues:');
  for (final issue in result.issues) {
    stderr.writeln('- $issue');
  }
  exitCode = 1;
}
