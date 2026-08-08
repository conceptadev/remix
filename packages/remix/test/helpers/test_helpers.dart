import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';

/// Extension methods for WidgetTester to simplify test setup and interactions
extension WidgetTesterHelpers on WidgetTester {
  /// Pumps a Remix widget in the Material interoperability test harness.
  ///
  /// `MaterialApp` and `Scaffold` are conveniences here, not Remix host
  /// requirements. Host-contract tests should provide only the capability
  /// under test, such as `Overlay.wrap` or a caller-owned `Navigator`.
  ///
  /// The scope is deliberately token-free: Remix's own styles resolve no design
  /// tokens, so this harness must not depend on a theme package. Themed
  /// behavior is covered by `remix_fortal`'s own suite.
  Future<void> pumpRemixApp(
    Widget widget, {
    TextDirection textDirection = TextDirection.ltr,
  }) async {
    await pumpWidget(
      MixScope.empty(
        child: MaterialApp(
          home: Directionality(
            textDirection: textDirection,
            child: Scaffold(body: Center(child: widget)),
          ),
        ),
      ),
    );
  }

  /// Pumps a widget with a caller-provided Scaffold for Material interop tests.
  Future<void> pumpRemixAppWithScaffold(Widget scaffold) async {
    await pumpWidget(MixScope.empty(child: MaterialApp(home: scaffold)));
  }

  /// Finds a widget by its key string
  Finder findByKey(String key) {
    return find.byKey(ValueKey(key));
  }

  /// Taps a RemixButton by key
  Future<void> tapRemixButton(String key) async {
    await tap(findByKey(key));
    await pump();
  }

  /// Enters text into a RemixTextField by key
  Future<void> enterTextInRemixField(String key, String text) async {
    await tap(findByKey(key));
    await pump();
    await enterText(findByKey(key), text);
    await pump();
  }

  /// Toggles a RemixCheckbox by key
  Future<void> toggleRemixCheckbox(String key) async {
    await tap(findByKey(key));
    await pump();
  }

  /// Toggles a RemixSwitch by key
  Future<void> toggleRemixSwitch(String key) async {
    await tap(findByKey(key));
    await pump();
  }

  /// Selects a RemixRadio option by key
  Future<void> selectRemixRadio(String key) async {
    await tap(findByKey(key));
    await pump();
  }

  /// Long presses a widget by key
  Future<void> longPressWidget(String key) async {
    await longPress(findByKey(key));
    await pump();
  }

  /// Changes orientation
  Future<void> changeOrientation(Orientation orientation) async {
    final size = orientation == Orientation.portrait
        ? const Size(400, 800)
        : const Size(800, 400);
    await binding.setSurfaceSize(size);
    await pumpAndSettle();
  }

  /// Checks if a widget is visible by key
  void expectWidgetVisible(String key) {
    expect(findByKey(key), findsOneWidget);
  }

  /// Checks if text is visible
  void expectTextVisible(String text) {
    expect(find.text(text), findsOneWidget);
  }

  /// Checks if an icon is visible
  void expectIconVisible(IconData icon) {
    expect(find.byIcon(icon), findsOneWidget);
  }

  /// Checks if a widget is not visible by key
  void expectWidgetNotVisible(String key) {
    expect(findByKey(key), findsNothing);
  }

  /// Checks if text is not visible
  void expectTextNotVisible(String text) {
    expect(find.text(text), findsNothing);
  }

  /// Scrolls until a widget is visible
  Future<void> scrollUntilWidgetVisible(
    Finder finder, {
    double delta = 300,
    Finder? scrollable,
    int maxScrolls = 20,
  }) async {
    for (int i = 0; i < maxScrolls; i++) {
      if (finder.evaluate().isNotEmpty) break;

      await drag(
        scrollable ?? find.byType(Scrollable).first,
        Offset(0, -delta),
      );
      await pumpAndSettle();
    }
  }
}

/// Test data builder for consistent test data
class TestDataBuilder {
  static const String defaultButtonKey = 'test_button';
  static const String defaultTextFieldKey = 'test_textfield';
  static const String defaultCheckboxKey = 'test_checkbox';
  static const String defaultSwitchKey = 'test_switch';
  static const String defaultRadioKey = 'test_radio';
  static const String defaultSliderKey = 'test_slider';
  static const String defaultSelectKey = 'test_select';

  static const String sampleLabel = 'Test Label';
  static const String sampleText = 'Sample Text';
  static const String sampleError = 'Error Message';
  static const String sampleHint = 'Hint Text';
  static const String sampleHelper = 'Helper Text';
}

/// Performance test helper
class PerformanceTestHelper {
  /// Measures widget build time
  static Future<void> measureWidgetBuildTime(
    WidgetTester tester,
    Widget widget,
    String widgetName,
  ) async {
    final stopwatch = Stopwatch()..start();
    await tester.pumpWidget(
      MixScope.empty(
        child: MaterialApp(
          home: Scaffold(body: Center(child: widget)),
        ),
      ),
    );
    stopwatch.stop();
    print('$widgetName build time: ${stopwatch.elapsedMilliseconds}ms');
  }

  /// Measures interaction response time
  static Future<void> measureInteractionResponseTime(
    WidgetTester tester,
    Future<void> Function() interaction,
    String interactionName,
  ) async {
    final stopwatch = Stopwatch()..start();
    await interaction();
    stopwatch.stop();
    print('$interactionName response time: ${stopwatch.elapsedMilliseconds}ms');
  }
}

class MockBuildContext extends BuildContext {
  final Map<MixToken, Object>? _tokens;
  final List<Type>? _orderOfModifiers;
  final ThemeData? _themeData;
  MixScope? _mixScope;

  MockBuildContext({
    Map<MixToken, Object>? tokens,
    List<Type>? orderOfModifiers,
    ThemeData? themeData,
  }) : _tokens = tokens,
       _orderOfModifiers = orderOfModifiers,
       _themeData = themeData {
    // Create MixScope instance once
    _mixScope = MixScope(
      tokens: _tokens,
      orderOfModifiers: _orderOfModifiers,
      child: const SizedBox(),
    );
  }

  @override
  bool get debugDoingBuild => false;

  @override
  bool get mounted => true;

  /// Inherited widget - supports both InheritedWidget and InheritedModel
  @override
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({
    Object? aspect,
  }) {
    if (T == MixScope) {
      return _mixScope as T?;
    }
    if (T == Theme && _themeData != null) {
      return Theme(data: _themeData, child: const SizedBox()) as T?;
    }
    return null;
  }

  @override
  InheritedElement?
  getElementForInheritedWidgetOfExactType<T extends InheritedWidget>() {
    // For InheritedModel.inheritFrom to work, we need to return a mock element
    if (T == MixScope && _mixScope != null) {
      return _MockInheritedElement(_mixScope!);
    }
    return null;
  }

  @override
  T? getInheritedWidgetOfExactType<T extends InheritedWidget>() {
    if (T == MixScope) {
      return _mixScope as T?;
    }
    if (T == Theme && _themeData != null) {
      return Theme(data: _themeData, child: const SizedBox()) as T?;
    }
    return null;
  }

  @override
  Widget get widget => const SizedBox();

  @override
  BuildOwner? get owner => null;

  @override
  Size? get size => const Size(800, 600);

  @override
  RenderObject? findRenderObject() => null;

  @override
  InheritedWidget dependOnInheritedElement(
    InheritedElement ancestor, {
    Object? aspect,
  }) {
    return ancestor.widget as InheritedWidget;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

/// Mock InheritedElement for testing InheritedModel functionality
class _MockInheritedElement extends InheritedElement {
  _MockInheritedElement(super.widget);

  @override
  MixScope get widget => super.widget as MixScope;

  @override
  void updateDependencies(Element dependent, Object? aspect) {
    // Mock implementation - just track the dependency
  }

  @override
  void notifyDependent(InheritedWidget oldWidget, Element dependent) {
    // Mock implementation
  }
}

// =============================================================================
// ADDITIONAL TEST UTILITIES
// =============================================================================

/// Mock attribute for testing utilities - handles `Prop<T>` values
///
/// This is a universal SpecMix that can wrap any prop type for testing purposes.
/// Used with utilities that expect a SpecMix builder function.
///
/// Usage:
/// ```dart
/// // For PropUtility (takes Prop<T>)
/// final colorUtility = ColorUtility(UtilityTestAttribute.new);
/// final attr = colorUtility(Colors.red);
///
/// // For complex utilities (takes Mix<V>)
/// final gradientUtility = GradientUtility(UtilityTestAttribute.new);
/// final attr = gradientUtility.linear(...);
/// ```
class MockStyle<T> extends Style<MockSpec<T>> {
  final T value;

  const MockStyle(
    this.value, {
    super.variants,
    super.modifier,
    super.animation,
  });

  @override
  MockStyle<T> merge(covariant MockStyle<T>? other) {
    if (other == null) return this;
    // For Prop types, use their merge method
    if (value is Prop && other.value is Prop) {
      final merged = (value as Prop).mergeProp(other.value as Prop);
      return MockStyle(merged as T);
    }
    // For other Mixable types
    if (value is Mixable && other.value is Mixable) {
      final merged = (value as Mixable).merge(other.value as Mixable);
      return MockStyle(merged as T);
    }
    // Default: just return the other value
    return MockStyle(other.value);
  }

  @override
  StyleSpec<MockSpec<T>> resolve(BuildContext context) {
    final mockSpec = MockSpec<T>(resolvedValue: value);

    return StyleSpec(
      spec: mockSpec,
      animation: $animation,
      widgetModifiers: $modifier?.resolve(context),
    );
  }

  @override
  List<Object?> get props => [value];
}

/// Mock spec for testing purposes
///
/// A simple Spec implementation that holds a resolved value.
/// Used as the target spec for mock attributes.
final class MockSpec<T> extends Spec<MockSpec<T>> with Diagnosticable {
  final T? resolvedValue;

  const MockSpec({this.resolvedValue});

  @override
  MockSpec<T> lerp(MockSpec<T>? other, double t) {
    if (other == null) return this;
    // Simple lerp - just return other for testing
    return MockSpec<T>(resolvedValue: other.resolvedValue);
  }

  @override
  MockSpec<T> copyWith({T? resolvedValue}) {
    return MockSpec<T>(resolvedValue: resolvedValue ?? this.resolvedValue);
  }

  @override
  List<Object?> get props => [resolvedValue];

  StyleSpec<MockSpec<T>> toStyleSpec() {
    return StyleSpec(spec: this);
  }
}

// Test-only extension to simplify access to MockSpec.resolvedValue when wrapped
extension WrappedMockResolvedValue<T> on StyleSpec<MockSpec<T>> {
  T? get resolvedValue => spec.resolvedValue;
}

// =============================================================================
// MOCK TESTING UTILITIES
// =============================================================================

/// Mock Mix type for testing
///
/// A generic Mix implementation that can hold any type of value.
/// Supports merge operations by delegating to a custom merge function.
///
/// Usage:
/// ```dart
/// final mixInt = MockMix<int>(42);
/// final mixString = MockMix<String>('hello');
///
/// // With custom merge logic
/// final mixList = MockMix<List<int>>(
///   [1, 2, 3],
///   merger: (a, b) => [...a, ...b],
/// );
/// ```
class MockMix<T> extends Mix<T> {
  final T value;
  final T Function(T a, T b)? merger;

  const MockMix(this.value, {this.merger});

  @override
  MockMix<T> merge(covariant MockMix<T>? other) {
    if (other == null) return this;

    final mergedValue = merger != null
        ? merger!(value, other.value)
        : other.value; // Default: other wins

    return MockMix<T>(mergedValue, merger: merger);
  }

  @override
  T resolve(BuildContext context) => value;

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'MockMix<$T>($value)';
}

/// Mock directive for testing
///
/// A simple directive implementation for testing purposes.
/// By default, applies identity transformation (returns value unchanged).
/// Can optionally provide a custom transformer function.
///
/// Usage:
/// ```dart
/// // Simple directive for testing presence (identity transform)
/// final directive1 = MockDirective<int>('test');
///
/// // With custom transformer
/// final doubleDirective = MockDirective<int>(
///   'double',
///   (value) => value * 2,
/// );
/// ```
class MockDirective<T> extends Directive<T> {
  final String name;
  final T Function(T)? transformer;

  const MockDirective(this.name, [this.transformer]);

  @override
  T apply(T value) => transformer?.call(value) ?? value;

  @override
  String get key => name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MockDirective<T> &&
        other.name == name &&
        other.transformer == transformer;
  }

  @override
  int get hashCode => Object.hash(name, transformer);

  @override
  String toString() => 'MockDirective<$T>($name)';
}

// =============================================================================
// WIDGET TESTER EXTENSIONS
// =============================================================================

/// Extension to add Mix testing utilities to WidgetTester
extension WidgetTesterExtension on WidgetTester {
  /// Pump widget with Mix scope
  Future<void> pumpWithMixScope(
    Widget widget, {
    Map<MixToken, Object>? tokens,
    List<Type>? orderOfModifiers,
    bool withMaterial = false,
  }) async {
    await pumpWidget(
      MaterialApp(
        home: withMaterial
            ? MixScope.withMaterial(
                tokens: tokens,
                orderOfModifiers: orderOfModifiers,
                child: widget,
              )
            : tokens != null || orderOfModifiers != null
            ? MixScope(
                tokens: tokens,
                orderOfModifiers: orderOfModifiers,
                child: widget,
              )
            : MixScope.empty(child: widget),
      ),
    );
  }

  /// Pumps a widget in the Material interoperability test harness.
  Future<void> pumpMaterialApp(Widget widget) async {
    await pumpWidget(MaterialApp(home: Scaffold(body: widget)));
  }
}
