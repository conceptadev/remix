/// Resolves whether a working disclosure should be expanded.
///
/// Working surfaces stay open so the operator can watch them. After the run
/// settles, [collapseOnComplete] (default true) hides the body unless the
/// host controls [open] or the last user toggle left it open. If work
/// resumes, the disclosure opens again.
bool resolveCollapseWhenComplete({
  required bool working,
  bool collapseOnComplete = true,
  bool? open,
  bool defaultOpen = false,
  bool userExpanded = false,
}) {
  if (open != null) {
    return open;
  }
  if (working) {
    return true;
  }
  if (!collapseOnComplete) {
    return true;
  }
  if (userExpanded) {
    return true;
  }
  return defaultOpen;
}
