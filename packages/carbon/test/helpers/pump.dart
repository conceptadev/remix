import 'package:carbon/carbon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [widget] inside a [CarbonScope] and a minimal MaterialApp/Scaffold so
/// Carbon tokens resolve and interaction widgets have the ancestors they need.
extension PumpCarbon on WidgetTester {
  Future<void> pumpCarbonApp(
    Widget widget, {
    CarbonTheme theme = CarbonTheme.white,
    CarbonThemeOverrides overrides = const CarbonThemeOverrides(),
  }) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: CarbonScope(
              theme: theme,
              overrides: overrides,
              child: widget,
            ),
          ),
        ),
      ),
    );
  }
}
