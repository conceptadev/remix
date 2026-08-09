const _shortMonths = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// Formats [value] as e.g. `Jan 5, 2026` for compact table cells.
String formatShortDate(DateTime value) =>
    '${_shortMonths[value.month - 1]} ${value.day}, ${value.year}';
