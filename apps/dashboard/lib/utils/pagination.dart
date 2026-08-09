/// Slices [items] into one page of [rowsPerPage] items.
///
/// The returned page is [page] clamped to the last valid page, so a filter
/// that shrinks the result set never asks for a page past the end.
///
/// [rowsPerPage] must be positive, matching `RemixDataTable.pageSize`'s own
/// precondition; a zero page size has no meaningful page count.
({int page, List<T> items}) paginate<T>(
  List<T> items, {
  required int page,
  required int rowsPerPage,
}) {
  assert(rowsPerPage > 0, 'paginate requires a positive rowsPerPage.');
  final maxPage = items.isEmpty ? 0 : (items.length - 1) ~/ rowsPerPage;
  final safePage = page.clamp(0, maxPage);
  final visible = items.skip(safePage * rowsPerPage).take(rowsPerPage).toList();

  return (page: safePage, items: visible);
}
