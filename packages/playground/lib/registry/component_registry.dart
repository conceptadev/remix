import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../preview_shell/preview_shell.dart';
import '../routes/all_components.dart';
import 'entries/avatar_entry.dart';
import 'entries/badge_entry.dart';
import 'entries/button_entry.dart';
import 'entries/callout_entry.dart';
import 'entries/card_entry.dart';
import 'entries/checkbox_entry.dart';
import 'entries/divider_entry.dart';
import 'entries/progress_entry.dart';
import 'entries/radio_entry.dart';
import 'entries/segmented_control_entry.dart';
import 'entries/select_entry.dart';
import 'entries/slider_entry.dart';
import 'entries/spinner_entry.dart';
import 'entries/switch_entry.dart';
import 'entries/textfield_entry.dart';
import 'entries/tooltip_entry.dart';

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
  'checkbox': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildCheckboxExample()),
  ),
  'radio': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildRadioExample()),
  ),
  'select': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildSelectExample()),
  ),
  'segmented-control': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildSegmentedControlExample()),
  ),
  'switch': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildSwitchExample()),
  ),
  'slider': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildSliderExample()),
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
  'card': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildCardExample()),
  ),
  'callout': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildCalloutExample()),
  ),
  'divider': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildDividerExample()),
  ),
  'progress': (context) => FortalScope(
    brightness: Theme.of(context).brightness,
    child: PreviewShell(child: buildProgressExample()),
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
