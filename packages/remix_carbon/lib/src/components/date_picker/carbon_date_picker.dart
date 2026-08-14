import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../foundation/carbon_layout_scope.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../_shared/carbon_field_frame.dart';
import '../button/carbon_button.dart';
import '../popover/carbon_popover.dart';

/// Formats the value shown by [CarbonDatePicker].
typedef CarbonDateFormatter = String Function(DateTime date);

/// Reports the two controlled endpoints of [CarbonDateRangePicker].
typedef CarbonDateRangeChanged =
    void Function(DateTime? startDate, DateTime? endDate);

const _weekdayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

String _monthName(int month) => switch (month) {
  1 => 'January',
  2 => 'February',
  3 => 'March',
  4 => 'April',
  5 => 'May',
  6 => 'June',
  7 => 'July',
  8 => 'August',
  9 => 'September',
  10 => 'October',
  11 => 'November',
  12 => 'December',
  _ => throw RangeError.range(month, 1, 12, 'month'),
};

String carbonIsoDateFormatter(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

/// Controlled Carbon date field with an anchored, keyboard-accessible calendar.
class CarbonDatePicker extends StatefulWidget {
  const CarbonDatePicker({
    super.key,
    this.value,
    this.onChanged,
    this.label,
    this.helperText,
    this.errorText,
    this.placeholder = 'yyyy-mm-dd',
    this.minDate,
    this.maxDate,
    this.enabled = true,
    this.readOnly = false,
    this.size = .md,
    this.initialMonth,
    this.dateLabelBuilder = carbonIsoDateFormatter,
    this.semanticLabel,
    this.controller,
  });

  final DateTime? value;
  final ValueChanged<DateTime?>? onChanged;
  final String? label;
  final String? helperText;
  final String? errorText;
  final String placeholder;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool enabled;
  final bool readOnly;
  final CarbonSize size;
  final DateTime? initialMonth;
  final CarbonDateFormatter dateLabelBuilder;
  final String? semanticLabel;
  final MenuController? controller;

  @override
  State<CarbonDatePicker> createState() => _CarbonDatePickerState();
}

class _CarbonDatePickerState extends State<CarbonDatePicker> {
  // Flutter's MenuController has no dispose method or owned resources.
  // ignore: dispose-fields
  late final MenuController _ownedController;
  late DateTime _visibleMonth;

  MenuController get _controller => widget.controller ?? _ownedController;

  @override
  void initState() {
    super.initState();
    _ownedController = MenuController();
    final anchor = widget.value ?? widget.initialMonth ?? DateTime.now();
    _visibleMonth = DateTime(anchor.year, anchor.month);
  }

  @override
  void didUpdateWidget(CarbonDatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null && !_sameDay(widget.value, oldWidget.value)) {
      _visibleMonth = DateTime(widget.value!.year, widget.value!.month);
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.minDate == null ||
          widget.maxDate == null ||
          !widget.minDate!.isAfter(widget.maxDate!),
      'CarbonDatePicker.minDate must not be after maxDate.',
    );
    final interactive =
        widget.enabled && !widget.readOnly && widget.onChanged != null;
    final fieldLabel = widget.semanticLabel ?? widget.label ?? 'date';
    final displayValue = widget.value == null
        ? widget.placeholder
        : widget.dateLabelBuilder(widget.value!);
    final fieldColor = CarbonLayer.of(context).color(.field).resolve(context);
    final borderColor = widget.errorText == null
        ? CarbonLayer.of(context).color(.borderStrong).resolve(context)
        : CarbonTokens.supportError.resolve(context);
    final trigger = Box(
      style: BoxStyler()
          .height(widget.size.clampTo(.xs, .lg).height)
          .padding(.horizontal(CarbonTokens.spacing05()))
          .color(widget.readOnly ? const Color(0x00000000) : fieldColor)
          .border(
            BoxBorderMix.bottom(
              BorderSideMix(
                color: borderColor,
                width: widget.errorText == null ? 1 : 2,
              ),
            ),
          )
          .alignment(.centerLeft),
      child: Row(
        children: [
          Expanded(
            child: StyledText(
              displayValue,
              style: TextStyler()
                  .style(CarbonTokens.bodyCompact01.mix())
                  .color(
                    !widget.enabled
                        ? CarbonTokens.textDisabled()
                        : widget.value == null
                        ? CarbonTokens.textPlaceholder()
                        : CarbonTokens.textPrimary(),
                  ),
            ),
          ),
          ExcludeSemantics(
            child: Icon(
              CarbonIcons.calendar,
              size: CarbonTokens.iconSize01.resolve(context),
              color:
                  (widget.enabled
                          ? CarbonTokens.iconPrimary
                          : CarbonTokens.iconDisabled)
                      .resolve(context),
            ),
          ),
        ],
      ),
    );
    final semanticTrigger = Semantics(
      excludeSemantics: true,
      label: 'Choose $fieldLabel',
      value: widget.value == null ? null : displayValue,
      child: trigger,
    );
    final picker = CarbonPopover(
      controller: _controller,
      border: true,
      positioning: const OverlayPositionConfig(
        side: .bottom,
        alignment: .start,
      ),
      popoverChild: _calendar(context),
      child: semanticTrigger,
    );

    return CarbonFieldFrame(
      label: widget.label,
      helperText: widget.helperText,
      errorText: widget.errorText,
      enabled: widget.enabled,
      child: IgnorePointer(ignoring: !interactive, child: picker),
    );
  }

  Widget _calendar(BuildContext context) {
    final firstDay = DateTime(_visibleMonth.year, _visibleMonth.month);
    final leading = firstDay.weekday - DateTime.monday;
    final dayCount = DateTime(
      _visibleMonth.year,
      _visibleMonth.month + 1,
      0,
    ).day;
    final previous = DateTime(_visibleMonth.year, _visibleMonth.month - 1);
    final next = DateTime(_visibleMonth.year, _visibleMonth.month + 1);

    return SizedBox(
      width: 320,
      child: Padding(
        padding: .all(CarbonTokens.spacing05.resolve(context)),
        child: Column(
          mainAxisSize: .min,
          children: [
            Row(
              children: [
                Expanded(
                  child: StyledText(
                    '${_monthName(_visibleMonth.month)} ${_visibleMonth.year}',
                    style: TextStyler()
                        .style(CarbonTokens.headingCompact01.mix())
                        .color(CarbonTokens.textPrimary()),
                  ),
                ),
                _monthButton(
                  label: 'Previous month',
                  icon: CarbonIcons.caretLeft,
                  month: previous,
                ),
                _monthButton(
                  label: 'Next month',
                  icon: CarbonIcons.caretRight,
                  month: next,
                ),
              ],
            ),
            SizedBox(height: CarbonTokens.spacing03.resolve(context)),
            Row(
              children: [
                for (final label in _weekdayLabels)
                  Expanded(
                    child: Center(
                      child: ExcludeSemantics(
                        child: StyledText(
                          label,
                          style: TextStyler()
                              .style(CarbonTokens.label01.mix())
                              .color(CarbonTokens.textSecondary()),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: CarbonTokens.spacing02.resolve(context)),
            for (var week = 0; week < 6; week++)
              Row(
                children: [
                  for (var weekday = 0; weekday < 7; weekday++)
                    Expanded(
                      child: _dayCell(
                        week * 7 + weekday - leading + 1,
                        dayCount,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _monthButton({
    required String label,
    required IconData icon,
    required DateTime month,
  }) {
    final enabled = _monthHasSelectableDate(month);

    return SizedBox.square(
      dimension: CarbonSize.sm.height,
      child: CarbonIconButton(
        icon: icon,
        semanticLabel: label,
        kind: .ghost,
        size: .sm,
        enabled: enabled,
        onPressed: enabled ? () => setState(() => _visibleMonth = month) : null,
      ),
    );
  }

  Widget _dayCell(int day, int dayCount) {
    if (day < 1 || day > dayCount) {
      return SizedBox.square(dimension: CarbonSize.sm.height);
    }
    final date = DateTime(_visibleMonth.year, _visibleMonth.month, day);
    final enabled = _isSelectable(date);
    final selected = _sameDay(date, widget.value);
    final label = '${_monthName(date.month)} ${date.day}, ${date.year}';
    final button = RemixButton(
      label: '$day',
      semanticLabel: label,
      style: carbonButtonStyle(
        kind: selected ? .primary : .ghost,
        size: .sm,
      ).padding(.all(0)).spacing(0).mainAxisAlignment(.center),
      enabled: enabled,
      onPressed: enabled ? () => _select(date) : null,
    );

    return SizedBox.square(
      dimension: CarbonSize.sm.height,
      child: Semantics(selected: selected, child: button),
    );
  }

  void _select(DateTime date) {
    widget.onChanged?.call(date);
    _controller.close();
  }

  bool _isSelectable(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    final min = widget.minDate;
    final max = widget.maxDate;

    return (min == null || !normalized.isBefore(_dateOnly(min))) &&
        (max == null || !normalized.isAfter(_dateOnly(max)));
  }

  bool _monthHasSelectableDate(DateTime month) {
    final first = DateTime(month.year, month.month);
    final last = DateTime(month.year, month.month + 1, 0);
    final min = widget.minDate;
    final max = widget.maxDate;

    return (max == null || !first.isAfter(_dateOnly(max))) &&
        (min == null || !last.isBefore(_dateOnly(min)));
  }
}

/// Two coordinated Carbon date fields that always emit an ordered range.
class CarbonDateRangePicker extends StatelessWidget {
  const CarbonDateRangePicker({
    super.key,
    this.startDate,
    this.endDate,
    this.onChanged,
    this.startLabel = 'Start date',
    this.endLabel = 'End date',
    this.minDate,
    this.maxDate,
    this.enabled = true,
    this.readOnly = false,
    this.size = .md,
    this.dateLabelBuilder = carbonIsoDateFormatter,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final CarbonDateRangeChanged? onChanged;
  final String startLabel;
  final String endLabel;
  final DateTime? minDate;
  final DateTime? maxDate;
  final bool enabled;
  final bool readOnly;
  final CarbonSize size;
  final CarbonDateFormatter dateLabelBuilder;

  @override
  Widget build(BuildContext context) {
    assert(
      startDate == null || endDate == null || !startDate!.isAfter(endDate!),
      'CarbonDateRangePicker.startDate must not be after endDate.',
    );
    assert(
      minDate == null || maxDate == null || !minDate!.isAfter(maxDate!),
      'CarbonDateRangePicker.minDate must not be after maxDate.',
    );
    final start = CarbonDatePicker(
      value: startDate,
      label: startLabel,
      minDate: minDate,
      maxDate: maxDate,
      enabled: enabled,
      readOnly: readOnly,
      size: size,
      dateLabelBuilder: dateLabelBuilder,
      onChanged: onChanged == null
          ? null
          : (next) => onChanged!(
              next,
              next != null && endDate != null && next.isAfter(endDate!)
                  ? null
                  : endDate,
            ),
    );
    final end = CarbonDatePicker(
      value: endDate,
      label: endLabel,
      minDate: startDate ?? minDate,
      maxDate: maxDate,
      enabled: enabled,
      readOnly: readOnly,
      size: size,
      initialMonth: startDate,
      dateLabelBuilder: dateLabelBuilder,
      onChanged: onChanged == null
          ? null
          : (next) => onChanged!(startDate, next),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 560) {
          return Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            spacing: CarbonTokens.spacing05.resolve(context),
            children: [start, end],
          );
        }

        return Row(
          crossAxisAlignment: .start,
          spacing: CarbonTokens.spacing05.resolve(context),
          children: [
            Expanded(child: start),
            Expanded(child: end),
          ],
        );
      },
    );
  }
}

DateTime _dateOnly(DateTime date) => .new(date.year, date.month, date.day);

bool _sameDay(DateTime? a, DateTime? b) =>
    a != null &&
    b != null &&
    a.year == b.year &&
    a.month == b.month &&
    a.day == b.day;
