/// Title-cases a single lower-camel or lowercase identifier for display.
String capitalize(String value) =>
    value.isEmpty ? value : '${value[0].toUpperCase()}${value.substring(1)}';

final _wordBoundary = RegExp('([A-Z])');

/// Turns an enum name into a display label: `size1` stays `Size1`, while
/// `percent100` becomes `Percent100` and `formatAlignLeft` becomes
/// `Format align left`.
String enumLabel(Enum value) => capitalize(
  value.name.replaceAllMapped(
    _wordBoundary,
    (match) => ' ${match.group(1)!.toLowerCase()}',
  ),
);
