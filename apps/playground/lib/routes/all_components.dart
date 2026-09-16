import 'package:flutter/material.dart';

import '../registry/entries/avatar_entry.dart';
import '../registry/entries/badge_entry.dart';
import '../registry/entries/button_entry.dart';
import '../registry/entries/card_entry.dart';
import '../registry/entries/callout_entry.dart';
import '../registry/entries/checkbox_entry.dart';
import '../registry/entries/divider_entry.dart';
import '../registry/entries/progress_entry.dart';
import '../registry/entries/radio_entry.dart';
import '../registry/entries/select_entry.dart';
import '../registry/entries/slider_entry.dart';
import '../registry/entries/spinner_entry.dart';
import '../registry/entries/switch_entry.dart';
import '../registry/entries/tooltip_entry.dart';

class AllComponentsPage extends StatelessWidget {
  const AllComponentsPage({super.key});

  Widget _section(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _section('Avatar', buildAvatarExample()),
        _section('Badge', buildBadgeExample()),
        _section('Button', buildButtonExample()),
        _section('Card', buildCardExample()),
        _section('Callout', buildCalloutExample()),
        _section('Checkbox', buildCheckboxExample()),
        _section('Divider', buildDividerExample()),
        _section('Progress', buildProgressExample()),
        _section('Radio', buildRadioExample()),
        _section('Select', buildSelectExample()),
        _section('Slider', buildSliderExample()),
        _section('Spinner', buildSpinnerExample()),
        _section('Switch', buildSwitchExample()),
        _section('Tooltip', buildTooltipExample()),
      ],
    );
  }
}
