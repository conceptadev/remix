import 'package:flutter/material.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../preview_shell/preview_shell.dart';
import '../routes/all_components.dart';
import 'entries/avatar_entry.dart';
import 'entries/badge_entry.dart';
import 'entries/button_entry.dart';
import 'entries/callout_entry.dart';
import 'entries/card_entry.dart';
import 'entries/checkbox_entry.dart';
import 'entries/checkbox_group_entry.dart';
import 'entries/data_list_entry.dart';
import 'entries/data_table_entry.dart';
import 'entries/divider_entry.dart';
import 'entries/menu_entry.dart';
import 'entries/progress_entry.dart';
import 'entries/radio_entry.dart';
import 'entries/segmented_control_entry.dart';
import 'entries/select_entry.dart';
import 'entries/skeleton_entry.dart';
import 'entries/slider_entry.dart';
import 'entries/spinner_entry.dart';
import 'entries/switch_entry.dart';
import 'entries/textfield_entry.dart';
import 'entries/textarea_entry.dart';
import 'entries/tooltip_entry.dart';
import 'entries/typography_entry.dart';

// Map component slugs to a builder that returns the component inside FortalScope.
final Map<String, WidgetBuilder> components = {
  'button': (context) =>
      FortalScope(child: PreviewShell(child: buildButtonExample())),
  'textfield': (context) =>
      FortalScope(child: PreviewShell(child: buildTextFieldExample())),
  'textarea': (context) => PreviewShell(
    child: Builder(
      builder: (context) =>
          FortalScope(hasBackground: false, child: buildTextAreaExample()),
    ),
  ),
  'checkbox': (context) =>
      FortalScope(child: PreviewShell(child: buildCheckboxExample())),
  'checkbox_group': (context) => PreviewShell(
    child: Builder(
      builder: (context) =>
          FortalScope(hasBackground: false, child: buildCheckboxGroupExample()),
    ),
  ),
  'radio': (context) =>
      FortalScope(child: PreviewShell(child: buildRadioExample())),
  'select': (context) =>
      FortalScope(child: PreviewShell(child: buildSelectExample())),
  'segmented-control': (context) => PreviewShell(
    child: Builder(
      builder: (context) => FortalScope(
        hasBackground: false,
        child: buildSegmentedControlExample(),
      ),
    ),
  ),
  'switch': (context) =>
      FortalScope(child: PreviewShell(child: buildSwitchExample())),
  'slider': (context) =>
      FortalScope(child: PreviewShell(child: buildSliderExample())),
  // Resolve Fortal inside PreviewShell so its light/dark control owns tokens.
  'menu': (context) => PreviewShell(
    child: Builder(
      builder: (context) =>
          FortalScope(hasBackground: false, child: buildMenuExample()),
    ),
  ),
  'all': (context) =>
      FortalScope(child: const PreviewShell(child: AllComponentsPage())),
  'avatar': (context) =>
      FortalScope(child: PreviewShell(child: buildAvatarExample())),
  'badge': (context) =>
      FortalScope(child: PreviewShell(child: buildBadgeExample())),
  // Resolve Fortal *inside* PreviewShell so the shell's light/dark control owns
  // the tokens; reading Theme.of above the shell leaves them stuck on light.
  'typography': (context) => PreviewShell(
    initialSize: const Size(900, 1180),
    child: Builder(
      builder: (context) =>
          FortalScope(hasBackground: false, child: buildTypographyExample()),
    ),
  ),
  'card': (context) =>
      FortalScope(child: PreviewShell(child: buildCardExample())),
  'callout': (context) =>
      FortalScope(child: PreviewShell(child: buildCalloutExample())),
  'data_list': (context) => PreviewShell(
    child: Builder(
      builder: (context) =>
          FortalScope(hasBackground: false, child: buildDataListExample()),
    ),
  ),
  'data_table': (context) =>
      FortalScope(child: PreviewShell(child: buildDataTableExample())),
  'divider': (context) =>
      FortalScope(child: PreviewShell(child: buildDividerExample())),
  'progress': (context) =>
      FortalScope(child: PreviewShell(child: buildProgressExample())),
  'skeleton': (context) => PreviewShell(
    child: Builder(
      builder: (context) =>
          FortalScope(hasBackground: false, child: buildSkeletonExample()),
    ),
  ),
  'spinner': (context) =>
      FortalScope(child: PreviewShell(child: buildSpinnerExample())),
  'tooltip': (context) =>
      FortalScope(child: PreviewShell(child: buildTooltipExample())),
};

List<String> get availableComponents => components.keys.toList()..sort();
