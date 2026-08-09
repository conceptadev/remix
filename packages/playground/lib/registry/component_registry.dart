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
  'button': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildButtonExample()),
  ),
  'textfield': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildTextFieldExample()),
  ),
  'textarea': (context) => PreviewShell(
    child: Builder(
      builder: (context) => FortalScope(
        brightness: Theme.of(context).brightness,
        hasBackground: false,
        child: buildTextAreaExample(),
      ),
    ),
  ),
  'checkbox': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildCheckboxExample()),
  ),
  'checkbox_group': (context) => PreviewShell(
    child: Builder(
      builder: (context) => FortalScope(
        brightness: Theme.of(context).brightness,
        hasBackground: false,
        child: buildCheckboxGroupExample(),
      ),
    ),
  ),
  'radio': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildRadioExample()),
  ),
  'select': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildSelectExample()),
  ),
  'segmented-control': (context) => PreviewShell(
    child: Builder(
      builder: (context) => FortalScope(
        brightness: Theme.of(context).brightness,
        hasBackground: false,
        child: buildSegmentedControlExample(),
      ),
    ),
  ),
  'switch': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildSwitchExample()),
  ),
  'slider': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildSliderExample()),
  ),
  // Resolve Fortal inside PreviewShell so its light/dark control owns tokens.
  'menu': (context) => PreviewShell(
    child: Builder(
      builder: (context) => FortalScope(
        brightness: Theme.of(context).brightness,
        hasBackground: false,
        child: buildMenuExample(),
      ),
    ),
  ),
  // A consolidated page to preview all components together
  'all': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: const PreviewShell(child: AllComponentsPage()),
  ),
  'avatar': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildAvatarExample()),
  ),
  'badge': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildBadgeExample()),
  ),
  // Resolve Fortal *inside* PreviewShell so the shell's light/dark control owns
  // the tokens; reading Theme.of above the shell leaves them stuck on light.
  'typography': (context) => PreviewShell(
    initialSize: const Size(900, 1180),
    child: Builder(
      builder: (context) => FortalScope(
        brightness: Theme.of(context).brightness,
        hasBackground: false,
        child: buildTypographyExample(),
      ),
    ),
  ),
  'card': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildCardExample()),
  ),
  'callout': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildCalloutExample()),
  ),
  'data_list': (context) => PreviewShell(
    child: Builder(
      builder: (context) => FortalScope(
        brightness: Theme.of(context).brightness,
        hasBackground: false,
        child: buildDataListExample(),
      ),
    ),
  ),
  'data_table': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildDataTableExample()),
  ),
  'divider': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildDividerExample()),
  ),
  'progress': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildProgressExample()),
  ),
  'skeleton': (context) => PreviewShell(
    child: Builder(
      builder: (context) => FortalScope(
        brightness: Theme.of(context).brightness,
        hasBackground: false,
        child: buildSkeletonExample(),
      ),
    ),
  ),
  'spinner': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildSpinnerExample()),
  ),
  'tooltip': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildTooltipExample()),
  ),
};

List<String> get availableComponents => components.keys.toList()..sort();
