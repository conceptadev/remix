part of 'checkbox.dart';

/// Coordinates a typed set of [RemixCheckboxGroupItem] options.
///
/// The group is a controlled, layout-transparent coordinator: it owns the
/// selected [values] and the group-wide enabled/required configuration, while
/// [child] owns group layout (Row/Column/Grid). Each item renders its visible
/// label inside the composed [RemixCheckbox], so the indicator, gap, label, and
/// minimum target are one pointer, focus, and semantics control. An existing
/// recipe such as `fortalCheckboxStyle()` styles group items without a
/// group-level recipe.
///
/// ## Keyboard
///
/// v1 uses standard Flutter focus traversal: every enabled option is an
/// ordinary Tab stop in widget order and Space/Enter toggle the focused
/// option, exactly as native HTML checkbox groups behave. Radix Themes'
/// one-tab-stop roving model (arrow/Home/End movement, orientation, loop) is a
/// deliberate, documented difference — see `docs/components/checkbox_group.mdx`.
///
/// Disabled options are skipped in the default [NavigationMode.traditional]
/// mode. Under [NavigationMode.directional] (d-pad/TV) Flutter keeps disabled
/// widgets focusable so users can discover them; activation stays suppressed.
///
/// ## Example
///
/// ```dart
/// RemixCheckboxGroup<String>(
///   values: _interests,
///   onChanged: (values) => setState(() => _interests = values),
///   semanticLabel: 'Interests',
///   isRequired: true,
///   child: Column(
///     crossAxisAlignment: CrossAxisAlignment.start,
///     spacing: 8,
///     children: const [
///       _InterestRow(value: 'design', label: 'Design'),
///       _InterestRow(value: 'code', label: 'Code'),
///     ],
///   ),
/// )
/// ```
class RemixCheckboxGroup<T extends Object> extends StatefulWidget {
  const RemixCheckboxGroup({
    super.key,
    required this.values,
    required this.child,
    this.onChanged,
    this.enabled = true,
    this.isRequired = false,
    this.semanticLabel,
    this.excludeSemantics = false,
  }) : assert(
         // A const initializer cannot call trim(); build() rejects
         // whitespace-only labels with the full check.
         semanticLabel != '',
         'Group semantic labels must not be blank when provided',
       ),
       assert(
         !isRequired || excludeSemantics || semanticLabel != null,
         'A required group must have a semanticLabel so assistive technology '
         'can name what is required (unless excludeSemantics is true)',
       );

  /// The currently selected values.
  ///
  /// This is a controlled input: the group never mutates it and never holds
  /// selection state of its own. A `const` widget cannot copy the set in its
  /// initializer, so the group takes one immutable snapshot per build and
  /// compares against that. Callers must not mutate the supplied set during a
  /// build.
  final Set<T> values;

  /// Called with a new unmodifiable set whenever an option is toggled.
  ///
  /// Checking an option emits the current values plus its value; unchecking
  /// emits the current values minus its value. The caller's set is never
  /// mutated. When null, the group is disabled.
  final ValueChanged<Set<T>>? onChanged;

  /// Whether the group is enabled for interaction.
  ///
  /// The effective group enabled state is `enabled && onChanged != null`, and
  /// it combines with each item's own [RemixCheckboxGroupItem.enabled].
  final bool enabled;

  /// Whether the group is required.
  ///
  /// Required state belongs to the group, not to individual options. A
  /// required group must have a nonblank [semanticLabel] (unless
  /// [excludeSemantics] is true), so "required" has an accessible name.
  final bool isRequired;

  /// The accessible name of the group.
  ///
  /// Must not be blank when provided, and must be present when [isRequired]
  /// is true and the group is not excluded from semantics.
  final String? semanticLabel;

  /// Whether to exclude the group container and all options from semantics.
  final bool excludeSemantics;

  /// The subtree that lays out the group's options.
  final Widget child;

  @override
  State<RemixCheckboxGroup<T>> createState() => _RemixCheckboxGroupState<T>();
}

class _RemixCheckboxGroupState<T extends Object>
    extends State<RemixCheckboxGroup<T>> {
  /// Null outside debug builds: the registry only produces diagnostics, so
  /// `kDebugMode` lets release builds drop it and everything it allocates.
  final _RemixCheckboxGroupRegistry<T>? _registry = kDebugMode
      ? _RemixCheckboxGroupRegistry<T>()
      : null;

  @override
  void dispose() {
    _registry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.semanticLabel == null || widget.semanticLabel!.trim().isNotEmpty,
      'Group semantic labels must not be blank when provided',
    );
    assert(
      !widget.isRequired ||
          widget.excludeSemantics ||
          (widget.semanticLabel?.trim().isNotEmpty ?? false),
      'A required group must have a nonblank semanticLabel so assistive '
      'technology can name what is required (unless excludeSemantics is true)',
    );

    final scope = _RemixCheckboxGroupScope<T>(
      // Snapshot once per build: `Set.unmodifiable` already copies, so the
      // caller cannot mutate what items and callbacks observe.
      values: Set<T>.unmodifiable(widget.values),
      // Collapsing `enabled` and a null callback into a single nullable
      // callback keeps "is this group interactive?" derivable in one place
      // instead of being re-combined at every consumer.
      onChanged: widget.enabled ? widget.onChanged : null,
      registry: _registry,
      child: widget.child,
    );

    if (widget.excludeSemantics) {
      return ExcludeSemantics(child: scope);
    }

    // Flutter has no checkbox-group semantics role, so the correct native tree
    // is a labeled container with explicit checkbox children. Each option's
    // checkbox node comes from the composed RemixCheckbox.
    return Semantics(
      container: true,
      explicitChildNodes: true,
      // Only assert the required state when it is true. Passing false would
      // stamp `hasRequiredState` onto an ordinary container, which is a state
      // the caller never asked for.
      isRequired: widget.isRequired ? true : null,
      label: widget.semanticLabel,
      child: scope,
    );
  }
}

/// A single option in a [RemixCheckboxGroup].
///
/// This intentionally composes the bool-based [RemixCheckbox] for every visual
/// and every piece of checkbox semantics. Duplicating the checkbox spec or
/// making [RemixCheckbox] generic over `T` would be wrong: membership in the
/// group's set is already a boolean, and a generic checkbox would break the
/// existing public API for no visual gain.
///
/// [label] is rendered inside the checkbox's interaction target and supplies
/// its accessible name. [semanticLabel] can override that name without
/// changing the visible caller text.
class RemixCheckboxGroupItem<T extends Object> extends StatefulWidget {
  const RemixCheckboxGroupItem({
    super.key,
    required this.value,
    required this.label,
    this.semanticLabel,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.checkedIcon,
    this.uncheckedIcon,
    this.enableFeedback = true,
    this.minimumTapTargetSize = const Size.square(48),
    this.mouseCursor = SystemMouseCursors.click,
    this.style = const CheckboxStyler.create(),
    this.styleSpec,
  }) : assert(
         // A const initializer cannot call trim(); build() rejects
         // whitespace-only labels with the full check.
         label != '',
         'Item labels must not be blank',
       ),
       assert(
         semanticLabel != '',
         'Item semantic labels must not be blank when provided',
       );

  /// The value this option contributes to the group's set.
  ///
  /// Non-null by the `T extends Object` bound. Must be unique among mounted
  /// items of the same group and stable in `==`/`hashCode` while mounted.
  final T value;

  /// The visible label of this option. Must not be blank.
  ///
  /// It is rendered inside the same pointer, focus, and semantics target as
  /// the checkbox indicator and is the accessible name by default.
  final String label;

  /// Optional accessible-name override. Must not be blank when provided.
  ///
  /// The visible [label] is preserved unchanged.
  final String? semanticLabel;

  /// Whether this option is enabled. Combines with the group's enabled state.
  final bool enabled;

  /// A caller-owned focus node. The group never disposes it.
  final FocusNode? focusNode;

  /// Whether this option requests focus on mount.
  ///
  /// At most one mounted item per group may set this.
  final bool autofocus;

  /// The icon shown when this option is selected.
  final IconData? checkedIcon;

  /// The icon shown when this option is not selected.
  final IconData? uncheckedIcon;

  /// Whether to provide haptic feedback when the option is toggled.
  final bool enableFeedback;

  /// Minimum pointer, focus, and semantics target size.
  ///
  /// Forwarded to [RemixCheckbox]. Defaults to 48 logical pixels on each axis;
  /// pass [Size.zero] for an explicit compact opt-out.
  final Size minimumTapTargetSize;

  /// Cursor when hovering over the option.
  final MouseCursor mouseCursor;

  /// The style configuration forwarded to the composed [RemixCheckbox].
  final CheckboxStyler style;

  /// The style spec forwarded to the composed [RemixCheckbox].
  final CheckboxSpec? styleSpec;

  static final styleFrom = CheckboxStyler.new;

  @override
  State<RemixCheckboxGroupItem<T>> createState() =>
      _RemixCheckboxGroupItemState<T>();
}

class _RemixCheckboxGroupItemState<T extends Object>
    extends State<RemixCheckboxGroupItem<T>> {
  /// Only ever assigned from `assert` blocks; null in release builds.
  _RemixCheckboxGroupRegistry<T>? _registry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncDebugRegistration();
  }

  @override
  void didUpdateWidget(covariant RemixCheckboxGroupItem<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value ||
        oldWidget.autofocus != widget.autofocus) {
      _syncDebugRegistration();
    }
  }

  @override
  void dispose() {
    assert(() {
      _registry?.unregister(this);
      return true;
    }());
    super.dispose();
  }

  void _syncDebugRegistration() {
    assert(() {
      // A read-only lookup: the render-relevant dependency is established by
      // build(), so debug bookkeeping must not add one of its own.
      final registry = context
          .getInheritedWidgetOfExactType<_RemixCheckboxGroupScope<T>>()
          ?.registry;

      if (!identical(registry, _registry)) {
        _registry?.unregister(this);
        _registry = registry;
      }
      _registry?.register(
        this,
        value: widget.value,
        autofocus: widget.autofocus,
      );

      return true;
    }());
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.label.trim().isNotEmpty, 'Item labels must not be blank');
    assert(
      widget.semanticLabel == null || widget.semanticLabel!.trim().isNotEmpty,
      'Item semantic labels must not be blank when provided',
    );

    final scope = _RemixCheckboxGroupScope.maybeOf<T>(context);

    if (scope == null) {
      throw FlutterError.fromParts([
        ErrorSummary(
          'RemixCheckboxGroupItem<$T> must be used within a '
          'RemixCheckboxGroup<$T>.',
        ),
        ErrorDescription(
          'No RemixCheckboxGroup<$T> ancestor was found in the widget tree. '
          'The item type argument must match the group type argument exactly.',
        ),
        ErrorHint(
          'Wrap your items with a RemixCheckboxGroup:\n'
          'RemixCheckboxGroup<$T>(\n'
          '  values: selectedValues,\n'
          '  onChanged: (values) { ... },\n'
          '  child: Column(\n'
          '    children: [\n'
          '      RemixCheckboxGroupItem<$T>(value: ..., label: ...),\n'
          '      RemixCheckboxGroupItem<$T>(value: ..., label: ...),\n'
          '    ],\n'
          '  ),\n'
          ')',
        ),
      ]);
    }

    return RemixCheckbox(
      selected: scope.values.contains(widget.value),
      onChanged: (selected) =>
          scope.toggle(widget.value, selected: selected ?? false),
      enabled: widget.enabled && scope.enabled,
      checkedIcon: widget.checkedIcon,
      uncheckedIcon: widget.uncheckedIcon,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enableFeedback: widget.enableFeedback,
      label: widget.label,
      semanticLabel: widget.semanticLabel,
      minimumTapTargetSize: widget.minimumTapTargetSize,
      mouseCursor: widget.mouseCursor,
      style: widget.style,
      styleSpec: widget.styleSpec,
    );
  }
}

/// Carries the group's per-build snapshot down to its items.
class _RemixCheckboxGroupScope<T extends Object> extends InheritedWidget {
  const _RemixCheckboxGroupScope({
    required this.values,
    required this.onChanged,
    required this.registry,
    required super.child,
  });

  static _RemixCheckboxGroupScope<T>? maybeOf<T extends Object>(
    BuildContext context,
  ) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  /// An immutable snapshot of the group's controlled values.
  final Set<T> values;

  /// Null when the group is disabled, so `enabled` needs no second source.
  final ValueChanged<Set<T>>? onChanged;

  /// Null outside debug builds.
  final _RemixCheckboxGroupRegistry<T>? registry;

  bool get enabled => onChanged != null;

  void toggle(T value, {required bool selected}) {
    final callback = onChanged;
    if (callback == null) return;

    final next = Set<T>.of(values);
    if (selected) {
      next.add(value);
    } else {
      next.remove(value);
    }

    callback(Set<T>.unmodifiable(next));
  }

  @override
  bool updateShouldNotify(_RemixCheckboxGroupScope<T> oldWidget) {
    return onChanged != oldWidget.onChanged ||
        !setEquals(values, oldWidget.values);
  }
}

/// Debug-only record of the items currently mounted under one group.
///
/// Entries are keyed by item [State] identity rather than by value, because a
/// value whose `==`/`hashCode` changes while mounted must still be removable.
///
/// Validation is deferred to the end of the frame on purpose: when a list of
/// items shrinks, Flutter updates surviving elements before unmounting the
/// removed one, so a transient duplicate exists mid-build that is not a real
/// caller error.
class _RemixCheckboxGroupRegistry<T extends Object> {
  final Map<State, ({T value, bool autofocus})> _entries = {};

  bool _validationScheduled = false;
  bool _disposed = false;

  void register(State owner, {required T value, required bool autofocus}) {
    _entries[owner] = (value: value, autofocus: autofocus);
    _scheduleValidation();
  }

  /// Removing an entry can only resolve conflicts, so it schedules no check.
  void unregister(State owner) {
    _entries.remove(owner);
  }

  void dispose() {
    _disposed = true;
    _entries.clear();
  }

  void _scheduleValidation() {
    if (_validationScheduled) return;
    _validationScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validationScheduled = false;
      if (_disposed) return;
      _validate();
    });
  }

  void _validate() {
    final seen = <T>{};
    var autofocusCount = 0;

    for (final entry in _entries.values) {
      if (!seen.add(entry.value)) {
        throw FlutterError(
          'RemixCheckboxGroup<$T> item values must be unique. '
          'Duplicate value: ${entry.value}.',
        );
      }
      if (entry.autofocus) autofocusCount += 1;
    }

    if (autofocusCount > 1) {
      throw FlutterError(
        'Only one item may autofocus in a RemixCheckboxGroup<$T>.',
      );
    }
  }
}
