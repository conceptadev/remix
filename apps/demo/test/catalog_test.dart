import 'package:demo/components/accordion.dart' as accordion;
import 'package:demo/components/avatar.dart' as avatar;
import 'package:demo/components/badge.dart' as badge;
import 'package:demo/components/button.dart' as button;
import 'package:demo/components/callout.dart' as callout;
import 'package:demo/components/card.dart' as card;
import 'package:demo/components/checkbox.dart' as checkbox;
import 'package:demo/components/code.dart' as code;
import 'package:demo/components/data_list.dart' as data_list;
import 'package:demo/components/data_table.dart' as data_table;
import 'package:demo/components/dialog.dart' as dialog;
import 'package:demo/components/disclosure.dart' as disclosure;
import 'package:demo/components/divider.dart' as divider;
import 'package:demo/components/heading.dart' as heading;
import 'package:demo/components/icon_button.dart' as icon_button;
import 'package:demo/components/kbd.dart' as kbd;
import 'package:demo/components/link.dart' as link;
import 'package:demo/components/progress.dart' as progress;
import 'package:demo/components/radio.dart' as radio;
import 'package:demo/components/segmented_control.dart' as segmented_control;
import 'package:demo/components/select.dart' as select;
import 'package:demo/components/slider.dart' as slider;
import 'package:demo/components/spinner.dart' as spinner;
import 'package:demo/components/switch.dart' as switch_;
import 'package:demo/components/tabs.dart' as tabs;
import 'package:demo/components/text.dart' as text;
import 'package:demo/components/textarea.dart' as textarea;
import 'package:demo/components/textfield.dart' as textfield;
import 'package:demo/components/toggle.dart' as toggle;
import 'package:demo/components/toggle_group.dart' as toggle_group;
import 'package:demo/helpers/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix_fortal/remix_fortal.dart';

/// Every catalog use case, by the component it reviews.
///
/// A catalog builds one cell per enum combination, so a preset that throws for
/// exactly one size or variant still renders everywhere else. Pumping each one
/// is what turns "it analyzes" into "it draws".
///
/// Four of the 34 manifest families have no catalog on purpose. Tooltip and
/// Skeleton publish no size or variant at all, so a matrix would have nothing
/// to vary. Menu and Popover paint only their overlay surface — their trigger
/// is a caller-supplied widget that neither enum touches — so a grid of closed
/// triggers would show the same cell N times and imply the enums do nothing.
final catalogs = <String, WidgetBuilder>{
  'accordion': accordion.buildAccordionCatalogUseCase,
  'avatar': avatar.buildAvatarCatalogUseCase,
  'badge': badge.buildBadgeCatalogUseCase,
  'button': button.buildButtonCatalogUseCase,
  'callout': callout.buildCalloutCatalogUseCase,
  'card': card.buildCardCatalogUseCase,
  'checkbox': checkbox.buildCheckboxCatalogUseCase,
  'code': code.buildCodeCatalogUseCase,
  'data list': data_list.buildDataListCatalogUseCase,
  'data table': data_table.buildDataTableCatalogUseCase,
  'dialog': dialog.buildDialogCatalogUseCase,
  'disclosure': disclosure.buildDisclosureCatalogUseCase,
  'divider': divider.buildDividerCatalogUseCase,
  'heading': heading.buildHeadingCatalogUseCase,
  'icon button': icon_button.buildIconButtonCatalogUseCase,
  'kbd': kbd.buildKbdCatalogUseCase,
  'link': link.buildLinkCatalogUseCase,
  'progress': progress.buildProgressCatalogUseCase,
  'radio': radio.buildRadioCatalogUseCase,
  'segmented control': segmented_control.buildSegmentedControlCatalogUseCase,
  'select': select.buildSelectCatalogUseCase,
  'slider': slider.buildSliderCatalogUseCase,
  'spinner': spinner.buildSpinnerCatalogUseCase,
  'switch': switch_.buildSwitchCatalogUseCase,
  'tabs': tabs.buildTabsCatalogUseCase,
  'text': text.buildTextCatalogUseCase,
  'text area': textarea.buildTextAreaCatalogUseCase,
  'text field': textfield.buildTextFieldCatalogUseCase,
  'toggle': toggle.buildToggleCatalogUseCase,
  'toggle group': toggle_group.buildToggleGroupCatalogUseCase,
};

/// Code and Link are the only catalogs with three Fortal enum axes. Keep their
/// expected cell counts independent from the matrix construction so dropping
/// an axis cannot leave the smoke test green.
final threeAxisCatalogCellCounts = <String, int>{
  'code':
      FortalTextSize.values.length *
      FortalCodeVariant.values.length *
      FortalTextWeight.values.length,
  'link':
      FortalTextSize.values.length *
      FortalLinkUnderline.values.length *
      FortalTextWeight.values.length,
};

void main() {
  for (final entry in catalogs.entries) {
    testWidgets('${entry.key} catalog renders every combination', (
      tester,
    ) async {
      // Wide enough that the matrix lays out without the horizontal scroll
      // view clipping cells the test would then never build.
      tester.view.physicalSize = const Size(4000, 3000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          home: FortalScope(child: Builder(builder: entry.value)),
        ),
      );
      // Not pumpAndSettle: Spinner and Skeleton animate indefinitely, so a
      // settle would time out rather than report a rendering failure.
      await tester.pump(const Duration(milliseconds: 100));

      expect(tester.takeException(), isNull);
      if (threeAxisCatalogCellCounts[entry.key] case final expected?) {
        final matrix = tester.widget<CatalogMatrix>(find.byType(CatalogMatrix));
        expect(
          matrix.columns.length * matrix.rows.length,
          expected,
          reason: '${entry.key} must render every Fortal enum combination',
        );
      }
    });
  }
}
