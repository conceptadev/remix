import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naked_ui/naked_ui.dart';
import 'package:remix/remix.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('semantic and behavioral parameter forwarding', () {
    test('ProgressStyler.call forwards semantic inputs and defaults', () {
      final style = ProgressStyler();
      final defaultProgress = style.call(value: 0.25);
      final labeledProgress = style.call(
        value: 0.5,
        semanticsLabel: 'Upload progress',
        semanticsValue: '50%',
      );

      expect(defaultProgress.semanticsLabel, isNull);
      expect(defaultProgress.semanticsValue, isNull);
      expect(labeledProgress.semanticsLabel, 'Upload progress');
      expect(labeledProgress.semanticsValue, '50%');
      expect(labeledProgress.style, same(style));
    });

    test('SpinnerStyler.call forwards semantic inputs and defaults', () {
      final style = SpinnerStyler();
      final defaultSpinner = style.call();
      final labeledSpinner = style.call(
        semanticsLabel: 'Loading account',
        semanticsValue: 'Connecting',
      );

      expect(defaultSpinner.semanticsLabel, isNull);
      expect(defaultSpinner.semanticsValue, isNull);
      expect(labeledSpinner.semanticsLabel, 'Loading account');
      expect(labeledSpinner.semanticsValue, 'Connecting');
      expect(labeledSpinner.style, same(style));
    });

    testWidgets('RemixRadio and RadioStyler.call forward semantics', (
      tester,
    ) async {
      final defaultRadio = RadioStyler().call<String>(
        value: 'default',
        semanticLabel: 'Default option',
      );

      expect(defaultRadio.semanticLabel, 'Default option');
      expect(defaultRadio.excludeSemantics, isFalse);

      await tester.pumpRemixApp(
        RemixRadioGroup<String>(
          groupValue: 'default',
          onChanged: (_) {},
          child: defaultRadio,
        ),
      );

      var nakedRadio = tester.widget<NakedRadio<String>>(
        find.byType(NakedRadio<String>),
      );
      expect(nakedRadio.semanticLabel, 'Default option');
      expect(nakedRadio.excludeSemantics, isFalse);

      final labeledRadio = RadioStyler().call<String>(
        value: 'labeled',
        semanticLabel: 'Preferred option',
        excludeSemantics: true,
      );

      expect(labeledRadio.semanticLabel, 'Preferred option');
      expect(labeledRadio.excludeSemantics, isTrue);

      await tester.pumpRemixApp(
        RemixRadioGroup<String>(
          groupValue: 'labeled',
          onChanged: (_) {},
          child: labeledRadio,
        ),
      );

      nakedRadio = tester.widget<NakedRadio<String>>(
        find.byType(NakedRadio<String>),
      );
      expect(nakedRadio.semanticLabel, 'Preferred option');
      expect(nakedRadio.excludeSemantics, isTrue);
    });

    testWidgets(
      'RemixSlider and SliderStyler.call map scalar semantics to one thumb',
      (tester) async {
        final defaultSlider = SliderStyler().call(value: 0.25);

        expect(defaultSlider.semanticLabel, isNull);
        expect(defaultSlider.semanticFormatterCallback, isNull);
        expect(defaultSlider.excludeSemantics, isFalse);

        await tester.pumpRemixApp(defaultSlider);

        var nakedSlider = tester.widget<NakedSlider>(find.byType(NakedSlider));
        expect(nakedSlider.semanticLabels, isNull);
        expect(nakedSlider.semanticFormatterCallbacks, isNull);
        expect(nakedSlider.excludeSemantics, isFalse);

        String formatter(double value) => '${value.round()} percent';

        final labeledSlider = SliderStyler().call(
          value: 0.5,
          semanticLabel: 'Volume',
          semanticFormatterCallback: formatter,
          excludeSemantics: true,
        );

        expect(labeledSlider.semanticLabel, 'Volume');
        expect(labeledSlider.semanticFormatterCallback, same(formatter));
        expect(labeledSlider.excludeSemantics, isTrue);

        await tester.pumpRemixApp(labeledSlider);

        nakedSlider = tester.widget<NakedSlider>(find.byType(NakedSlider));
        expect(nakedSlider.semanticLabels, <String?>['Volume']);
        expect(nakedSlider.semanticFormatterCallbacks, hasLength(1));
        expect(nakedSlider.semanticFormatterCallbacks!.single, same(formatter));
        expect(
          nakedSlider.semanticFormatterCallbacks!.single!(42),
          '42 percent',
        );
        expect(nakedSlider.excludeSemantics, isTrue);
      },
    );

    testWidgets('RemixTabs forwards activation mode and its default', (
      tester,
    ) async {
      await tester.pumpRemixApp(
        const RemixTabs(selectedTabId: 'one', child: SizedBox()),
      );

      var nakedTabs = tester.widget<NakedTabs>(find.byType(NakedTabs));
      expect(nakedTabs.activationMode, NakedTabActivationMode.automatic);

      await tester.pumpRemixApp(
        const RemixTabs(
          selectedTabId: 'one',
          activationMode: NakedTabActivationMode.manual,
          child: SizedBox(),
        ),
      );

      nakedTabs = tester.widget<NakedTabs>(find.byType(NakedTabs));
      expect(nakedTabs.activationMode, NakedTabActivationMode.manual);
    });

    testWidgets('RemixTabView and TabViewStyler.call forward maintainState', (
      tester,
    ) async {
      final defaultView = TabViewStyler().call(
        tabId: 'one',
        child: const SizedBox(),
      );

      expect(defaultView.maintainState, isTrue);

      await tester.pumpRemixApp(
        RemixTabs(selectedTabId: 'one', child: defaultView),
      );

      var nakedView = tester.widget<NakedTabView>(find.byType(NakedTabView));
      expect(nakedView.maintainState, isTrue);

      final disposableView = TabViewStyler().call(
        tabId: 'one',
        maintainState: false,
        child: const SizedBox(),
      );

      expect(disposableView.maintainState, isFalse);

      await tester.pumpRemixApp(
        RemixTabs(selectedTabId: 'one', child: disposableView),
      );

      nakedView = tester.widget<NakedTabView>(find.byType(NakedTabView));
      expect(nakedView.maintainState, isFalse);
    });

    testWidgets('RemixMenu and MenuStyler.call forward semantics', (
      tester,
    ) async {
      final defaultMenu = MenuStyler().call<String>(
        trigger: const RemixMenuTrigger(label: 'Open'),
        items: const [RemixMenuItem(value: 'item', label: 'Item')],
      );

      expect(defaultMenu.semanticLabel, isNull);
      expect(defaultMenu.excludeSemantics, isFalse);

      await tester.pumpRemixApp(defaultMenu);

      var nakedMenu = tester.widget<NakedMenu<String>>(
        find.byType(NakedMenu<String>),
      );
      expect(nakedMenu.semanticLabel, isNull);
      expect(nakedMenu.excludeSemantics, isFalse);

      final labeledMenu = MenuStyler().call<String>(
        trigger: const RemixMenuTrigger(label: 'Open'),
        items: const [RemixMenuItem(value: 'item', label: 'Item')],
        semanticLabel: 'Account actions',
        excludeSemantics: true,
      );

      expect(labeledMenu.semanticLabel, 'Account actions');
      expect(labeledMenu.excludeSemantics, isTrue);

      await tester.pumpRemixApp(labeledMenu);

      nakedMenu = tester.widget<NakedMenu<String>>(
        find.byType(NakedMenu<String>),
      );
      expect(nakedMenu.semanticLabel, 'Account actions');
      expect(nakedMenu.excludeSemantics, isTrue);
    });

    // Pins the documented scope of RemixMenu.excludeSemantics. Naked wraps only
    // the trigger in ExcludeSemantics; the overlay is mounted into the ambient
    // Overlay, so item semantics survive. Without this, the doc comment on
    // RemixMenu.excludeSemantics is an unverifiable claim.
    testWidgets(
      'RemixMenu excludeSemantics covers the trigger, not the items',
      (tester) async {
        final semantics = tester.ensureSemantics();
        final controller = MenuController();

        await tester.pumpRemixApp(
          RemixMenu<String>(
            trigger: const RemixMenuTrigger(label: 'Options'),
            items: const [RemixMenuItem(value: 'copy', label: 'Copy')],
            controller: controller,
            semanticLabel: 'Account actions',
            excludeSemantics: true,
          ),
        );
        await tester.pumpAndSettle();

        controller.open();
        await tester.pumpAndSettle();

        final triggerCount = find
            .bySemanticsLabel('Account actions')
            .evaluate()
            .length;
        final itemCount = find.bySemanticsLabel('Copy').evaluate().length;
        semantics.dispose();

        expect(triggerCount, 0, reason: 'trigger semantics are excluded');
        expect(
          itemCount,
          1,
          reason: 'overlay items stay in the semantics tree',
        );
      },
    );

    testWidgets('RemixSwitch and SwitchStyler.call forward excludeSemantics', (
      tester,
    ) async {
      final defaultSwitch = SwitchStyler().call(
        selected: false,
        semanticLabel: 'Notifications',
      );

      expect(defaultSwitch.excludeSemantics, isFalse);

      await tester.pumpRemixApp(defaultSwitch);

      var nakedToggle = tester.widget<NakedToggle>(find.byType(NakedToggle));
      expect(nakedToggle.excludeSemantics, isFalse);

      final excludedSwitch = SwitchStyler().call(
        selected: true,
        semanticLabel: 'Notifications',
        excludeSemantics: true,
      );

      expect(excludedSwitch.excludeSemantics, isTrue);

      await tester.pumpRemixApp(excludedSwitch);

      nakedToggle = tester.widget<NakedToggle>(find.byType(NakedToggle));
      expect(nakedToggle.excludeSemantics, isTrue);
    });
  });
}
