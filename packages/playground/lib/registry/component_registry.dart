import 'package:flutter/material.dart';

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
import 'entries/select_entry.dart';
import 'entries/slider_entry.dart';
import 'entries/spinner_entry.dart';
import 'entries/switch_entry.dart';
import 'entries/textfield_entry.dart';
import 'entries/tooltip_entry.dart';

// The preview shell owns the single FortalScope around its preview app.
final Map<String, WidgetBuilder> components = {
  'button': (_) => PreviewShell(child: buildButtonExample()),
  'textfield': (_) => PreviewShell(child: buildTextFieldExample()),
  'checkbox': (_) => PreviewShell(child: buildCheckboxExample()),
  'radio': (_) => PreviewShell(child: buildRadioExample()),
  'select': (_) => PreviewShell(child: buildSelectExample()),
  'switch': (_) => PreviewShell(child: buildSwitchExample()),
  'slider': (_) => PreviewShell(child: buildSliderExample()),
  // A consolidated page to preview all components together
  'all': (_) => const PreviewShell(child: AllComponentsPage()),
  'avatar': (_) => PreviewShell(child: buildAvatarExample()),
  'badge': (_) => PreviewShell(child: buildBadgeExample()),
  'card': (_) => PreviewShell(child: buildCardExample()),
  'callout': (_) => PreviewShell(child: buildCalloutExample()),
  'divider': (_) => PreviewShell(child: buildDividerExample()),
  'progress': (_) => PreviewShell(child: buildProgressExample()),
  'spinner': (_) => PreviewShell(child: buildSpinnerExample()),
  'tooltip': (_) => PreviewShell(child: buildTooltipExample()),
};

List<String> get availableComponents => components.keys.toList()..sort();
