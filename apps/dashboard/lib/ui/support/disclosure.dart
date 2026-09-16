/// Controlled/uncontrolled storage shared by collapsible surfaces.
///
/// Widgets own lifecycle policy, rebuilding, and request callbacks. In
/// particular, a request that does not change storage may still notify a host.
class UiDisclosureEngine {
  UiDisclosureEngine({required bool? value, required bool defaultValue})
    : _controlled = value,
      _uncontrolled = value ?? defaultValue;

  bool? _controlled;
  bool _uncontrolled;

  bool get value => _controlled ?? _uncontrolled;

  /// Adopt the last controlled value when the host releases control.
  void reconcile(bool? value) {
    if (_controlled != null && value == null) {
      _uncontrolled = _controlled!;
    }
    _controlled = value;
  }

  /// Returns whether local storage changed and the widget needs a rebuild.
  bool request(bool next) {
    if (_controlled != null || next == _uncontrolled) return false;
    _uncontrolled = next;
    return true;
  }
}
