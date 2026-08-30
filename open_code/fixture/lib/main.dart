import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'ui/ui.dart';

/// A host-neutral gallery for the copied `lib/ui/` layer.
///
/// There is no Material or Cupertino widget anywhere below: `WidgetsApp` plus
/// the copied recipe is the entire host contract. Run it from the temporary
/// application the checker retains with `--keep`:
///
/// ```shell
/// flutter run -d chrome
/// ```
void main() => runApp(const AcmeGalleryApp());

/// The gallery's application shell.
class AcmeGalleryApp extends StatelessWidget {
  /// Creates the gallery app.
  const AcmeGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFF0A0A0A),
      debugShowCheckedModeBanner: false,
      // `EditableText` asserts on an `Overlay` ancestor as soon as it takes
      // focus, for its selection handles and magnifier. A real application
      // gets one from its `Navigator`; a `WidgetsApp` built with `builder:`
      // alone does not, so the gallery supplies it rather than pulling in
      // MaterialApp and with it a host framework this layer does not use.
      builder: (_, _) => Overlay(
        initialEntries: [OverlayEntry(builder: (_) => const AcmeGallery())],
      ),
    );
  }
}

/// Theme-wide customization.
///
/// One `copyWith` restyles every button in its section: the recipe reads
/// `AcmeTokens`, and `AcmeThemeScope` decides what those tokens resolve to. No
/// button below it is touched.
final AcmeThemeData brandTheme = const AcmeThemeData.light().copyWith(
  primary: const Color(0xFF4F46E5),
  primaryForeground: const Color(0xFFFFFFFF),
  accent: const Color(0xFFE0E7FF),
  accentForeground: const Color(0xFF312E81),
  border: const Color(0xFFC7D2FE),
  focusRing: const Color(0xFF4F46E5),
  radius: const Radius.circular(999),
);

/// Every theme section, stacked.
class AcmeGallery extends StatelessWidget {
  /// Creates the gallery.
  const AcmeGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFFFFFFF),
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
          color: Color(0xFF171717),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AcmeThemeSection(
                title: 'Light',
                caption: 'AcmeThemeData.light()',
                data: AcmeThemeData.light(),
              ),
              const AcmeThemeSection(
                title: 'Dark',
                caption: 'AcmeThemeData.dark()',
                data: AcmeThemeData.dark(),
              ),
              AcmeThemeSection(
                title: 'Themed',
                caption: 'AcmeThemeData.light().copyWith(...)',
                data: brandTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One `AcmeThemeScope` and everything the Button recipe can do inside it.
class AcmeThemeSection extends StatefulWidget {
  /// Creates a section rendering [data].
  const AcmeThemeSection({
    super.key,
    required this.title,
    required this.caption,
    required this.data,
  });

  /// Human-readable section name.
  final String title;

  /// The expression that produced [data].
  final String caption;

  /// The theme installed for this section.
  final AcmeThemeData data;

  @override
  State<AcmeThemeSection> createState() => _AcmeThemeSectionState();
}

class _AcmeThemeSectionState extends State<AcmeThemeSection> {
  String _lastAction = 'nothing pressed yet';
  bool _subscribed = false;
  bool? _partial;
  Set<String> _interests = const {'design'};
  String _tab = 'account';
  Set<AcmeToggleVariant> _pinned = const {AcmeToggleVariant.outline};
  bool _notifications = true;
  String? _plan = 'pro';
  double _volume = 0.4;
  String? _weight = 'bold';
  String _view = 'list';
  // Row ids are `Object` because `rowId` may return any stable key.
  Set<Object> _members = const {'Ada'};
  // Remix re-exports this as an alias, so the group's controller does not
  // drag `package:naked_ui` into an application that only depends on Remix.
  final RemixAccordionController<String> _sections =
      RemixAccordionController<String>();

  /// Drives the popover from its trigger button. See the popover below for
  /// why `openOnTap` alone does not work when the trigger is a button.
  final MenuController _filters = MenuController();

  void _record(String action) => setState(() => _lastAction = action);

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return AcmeThemeScope(
      data: data,
      child: ColoredBox(
        color: data.background,
        child: DefaultTextStyle(
          style: DefaultTextStyle.of(
            context,
          ).style.copyWith(color: data.foreground),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _Caption(widget.caption, color: data.mutedForeground),
                const SizedBox(height: 16),

                _Label('Variants x sizes', color: data.mutedForeground),
                for (final size in AcmeButtonSize.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final variant in AcmeButtonVariant.values)
                          // The unnamed constructor keeps `variant` and `size`
                          // as ordinary values, which is what a loop needs.
                          AcmeButton(
                            variant: variant,
                            size: size,
                            label: '${variant.name} ${size.name}',
                            onPressed: () =>
                                _record('${variant.name} / ${size.name}'),
                          ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),

                _Label('Named constructors', color: data.mutedForeground),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Generated from the enum, written like any other widget.
                    AcmeButton.primary(
                      label: 'Primary',
                      leadingIcon: AcmeIcons.check,
                      onPressed: () => _record('primary'),
                    ),
                    AcmeButton.secondary(
                      label: 'Secondary',
                      onPressed: () => _record('secondary'),
                    ),
                    AcmeButton.outline(
                      label: 'Outline',
                      onPressed: () => _record('outline'),
                    ),
                    AcmeButton.ghost(
                      label: 'Ghost',
                      onPressed: () => _record('ghost'),
                    ),
                    AcmeButton.destructive(
                      label: 'Delete',
                      trailingIcon: AcmeIcons.cross,
                      onPressed: () => _record('destructive'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('Disabled and loading', color: data.mutedForeground),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const AcmeButton.primary(label: 'Disabled', enabled: false),
                    const AcmeButton.outline(label: 'Disabled', enabled: false),
                    // Same label and size as the row above: Remix keeps the
                    // footprint stable while the spinner is up.
                    AcmeButton.primary(
                      label: 'Loading',
                      loading: true,
                      onPressed: () => _record('unreachable while loading'),
                    ),
                    AcmeButton.outline(
                      label: 'Loading',
                      loading: true,
                      onPressed: () => _record('unreachable while loading'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('One-instance override', color: data.mutedForeground),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AcmeButton.primary(
                      label: 'Just this one',
                      // Merged last, so it beats the resolved recipe. The
                      // hover fill has to be declared as a hover fragment;
                      // a bare `.color(...)` would only replace the idle one.
                      style: ButtonStyler()
                          .color(const Color(0xFF7C3AED))
                          .borderRadius(.all(const Radius.circular(999)))
                          .padding(.horizontal(28))
                          .minHeight(48)
                          .label(
                            .color(
                              const Color(0xFFFFFFFF),
                            ).fontWeight(FontWeight.w700),
                          )
                          .onHovered(
                            ButtonStyler().color(const Color(0xFF5B21B6)),
                          ),
                      onPressed: () => _record('one-instance override'),
                    ),
                    AcmeButton.primary(
                      label: 'Untouched neighbour',
                      onPressed: () => _record('untouched neighbour'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label(
                  'Checkbox sizes and states',
                  color: data.mutedForeground,
                ),
                Wrap(
                  spacing: 20,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AcmeCheckbox(
                      selected: _subscribed,
                      label: 'Subscribed',
                      // `tristate` is false here, so Remix never emits
                      // null; the parameter type stays nullable because the
                      // same callback serves the tristate case below.
                      onChanged: (value) => setState(() {
                        _subscribed = value ?? false;
                        _lastAction = 'checkbox -> $value';
                      }),
                    ),
                    // Tristate: `selected` cycles false -> true -> null, and
                    // Remix swaps the check glyph for the indeterminate one.
                    AcmeCheckbox(
                      selected: _partial,
                      tristate: true,
                      label: 'Indeterminate',
                      onChanged: (value) => setState(() {
                        _partial = value;
                        _lastAction = 'tristate -> $value';
                      }),
                    ),
                    const AcmeCheckbox(
                      selected: true,
                      enabled: false,
                      label: 'Disabled',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('Checkbox group', color: data.mutedForeground),
                // The group owns the selected set; each option is styled by
                // the same recipe through its own generated adapter.
                RemixCheckboxGroup<String>(
                  values: _interests,
                  semanticLabel: 'Interests',
                  onChanged: (values) => setState(() {
                    _interests = values;
                    _lastAction = 'interests -> ${values.join(', ')}';
                  }),
                  child: const Wrap(
                    spacing: 20,
                    runSpacing: 8,
                    children: [
                      AcmeCheckboxGroupItem<String>(
                        value: 'design',
                        label: 'Design',
                      ),
                      AcmeCheckboxGroupItem<String>(
                        value: 'code',
                        label: 'Code',
                      ),
                      AcmeCheckboxGroupItem<String>(
                        value: 'research',
                        label: 'Research',
                        enabled: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _Label('Tabs', color: data.mutedForeground),
                // `RemixTabs` is behavioral and carries no recipe: it owns
                // selection and keyboard traversal while the three generated
                // adapters own everything visible.
                RemixTabs(
                  selectedTabId: _tab,
                  onChanged: (id) => setState(() {
                    _tab = id;
                    _lastAction = 'tab -> $id';
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The scroll view goes outside the bar, never inside
                      // it: Flutter's tab-bar semantics role requires every
                      // direct semantics child to be a tab, and a scroll view
                      // between them adds a node of its own.
                      const SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: AcmeTabBar(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AcmeTab(
                                tabId: 'account',
                                label: 'Account',
                                icon: AcmeIcons.check,
                              ),
                              AcmeTab(tabId: 'billing', label: 'Billing'),
                              AcmeTab(
                                tabId: 'archived',
                                label: 'Archived',
                                enabled: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                      AcmeTabView(
                        tabId: 'account',
                        child: Text(
                          'Account panel',
                          style: TextStyle(color: data.foreground),
                        ),
                      ),
                      AcmeTabView(
                        tabId: 'billing',
                        child: Text(
                          'Billing panel',
                          style: TextStyle(color: data.foreground),
                        ),
                      ),
                      AcmeTabView(
                        tabId: 'archived',
                        child: Text(
                          'Archived panel',
                          style: TextStyle(color: data.foreground),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _Label('Badges', color: data.mutedForeground),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    for (final variant in AcmeBadgeVariant.values)
                      AcmeBadge(variant: variant, label: variant.name),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('Icon buttons', color: data.mutedForeground),
                for (final size in AcmeIconButtonSize.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        for (final variant in AcmeIconButtonVariant.values)
                          AcmeIconButton(
                            variant: variant,
                            size: size,
                            icon: AcmeIcons.check,
                            semanticLabel: '${variant.name} ${size.name}',
                            onPressed: () =>
                                _record('icon ${variant.name} / ${size.name}'),
                          ),
                        const AcmeIconButton(
                          icon: AcmeIcons.cross,
                          semanticLabel: 'Disabled',
                          enabled: false,
                        ),
                        AcmeIconButton(
                          icon: AcmeIcons.check,
                          semanticLabel: 'Loading',
                          loading: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),

                _Label('Toggles', color: data.mutedForeground),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    for (final variant in AcmeToggleVariant.values)
                      AcmeToggle(
                        variant: variant,
                        selected: _pinned.contains(variant),
                        label: variant.name,
                        icon: AcmeIcons.check,
                        onChanged: (value) => setState(() {
                          if (value) {
                            _pinned = {..._pinned, variant};
                          } else {
                            _pinned = {..._pinned}..remove(variant);
                          }
                          _lastAction = 'toggle ${variant.name} -> $value';
                        }),
                      ),
                    const AcmeToggle(
                      selected: true,
                      enabled: false,
                      label: 'Disabled',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('Avatars, spinners, links', color: data.mutedForeground),
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const AcmeAvatar(label: 'AC'),
                    const AcmeAvatar(icon: AcmeIcons.check),
                    const AcmeSpinner(semanticsLabel: 'Loading'),
                    AcmeLink(label: 'A link', onPressed: () => _record('link')),
                    const AcmeLink(label: 'A disabled link'),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('Progress and skeleton', color: data.mutedForeground),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: 240,
                    child: AcmeProgress(value: 0.35, semanticsLabel: 'Upload'),
                  ),
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Label('Loading', color: data.mutedForeground),
                        // The wrapped child keeps sizing the placeholder in
                        // both states, so switching `loading` never reflows.
                        const AcmeSkeleton(
                          child: Text('Placeholder for a name'),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Label('Loaded', color: data.mutedForeground),
                        const AcmeSkeleton(
                          loading: false,
                          child: Text('Placeholder for a name'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('Card, callout, divider', color: data.mutedForeground),
                AcmeCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'A card groups related content.',
                        style: TextStyle(color: data.foreground),
                      ),
                      const SizedBox(height: 12),
                      const AcmeDivider(),
                      const SizedBox(height: 12),
                      const AcmeCallout(
                        icon: AcmeIcons.check,
                        text: 'Everything is in order.',
                      ),
                      const SizedBox(height: 8),
                      const AcmeCallout.destructive(
                        icon: AcmeIcons.cross,
                        text: 'This deletes the workspace for everyone.',
                      ),
                      const SizedBox(height: 12),
                      // A vertical rule needs a bounded height, which is what
                      // an IntrinsicHeight row gives it.
                      IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Left',
                              style: TextStyle(color: data.foreground),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: AcmeDivider(orientation: Axis.vertical),
                            ),
                            Text(
                              'Right',
                              style: TextStyle(color: data.foreground),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _Label('Switches and radios', color: data.mutedForeground),
                Wrap(
                  spacing: 20,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AcmeSwitch(
                      selected: _notifications,
                      semanticLabel: 'Notifications',
                      onChanged: (value) => setState(() {
                        _notifications = value;
                        _lastAction = 'switch -> $value';
                      }),
                    ),
                    const AcmeSwitch(
                      selected: true,
                      enabled: false,
                      semanticLabel: 'Disabled switch',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // `RemixRadioGroup` is behavioral and carries no recipe: it
                // owns the chosen value while the adapters own the circles.
                RemixRadioGroup<String>(
                  groupValue: _plan,
                  semanticLabel: 'Plan',
                  onChanged: (value) => setState(() {
                    _plan = value;
                    _lastAction = 'plan -> $value';
                  }),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (final plan in const ['free', 'pro'])
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AcmeRadio<String>(value: plan, semanticLabel: plan),
                            const SizedBox(width: 8),
                            Text(
                              plan,
                              style: TextStyle(color: data.foreground),
                            ),
                          ],
                        ),
                      const AcmeRadio<String>(
                        value: 'enterprise',
                        semanticLabel: 'Enterprise',
                        enabled: false,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _Label('Sliders', color: data.mutedForeground),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AcmeSlider(
                    value: _volume,
                    semanticLabel: 'Volume',
                    onChanged: (value) => setState(() {
                      _volume = value;
                      _lastAction = 'volume -> ${value.toStringAsFixed(2)}';
                    }),
                  ),
                ),
                const SizedBox(height: 16),

                _Label('Text inputs', color: data.mutedForeground),
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: 220,
                      child: AcmeTextField(
                        label: 'Workspace',
                        hintText: 'acme-inc',
                        helperText: 'Lowercase letters and dashes.',
                        onChanged: (value) => _record('workspace -> $value'),
                      ),
                    ),
                    const SizedBox(
                      width: 220,
                      child: AcmeTextField(
                        label: 'Slug',
                        hintText: 'acme inc',
                        helperText: 'Spaces are not allowed.',
                        error: true,
                      ),
                    ),
                    const SizedBox(
                      width: 220,
                      child: AcmeTextField(
                        label: 'Owner',
                        hintText: 'you@acme.test',
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      width: 220,
                      child: AcmeTextArea(
                        label: 'Description',
                        hintText: 'What is this workspace for?',
                        onChanged: (value) => _record('description'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label(
                  'Toggle group and segmented control',
                  color: data.mutedForeground,
                ),
                Wrap(
                  spacing: 20,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // The group's recipe styles every option: the items are
                    // data, not widgets, so there is no per-item call site to
                    // forget a styler on.
                    AcmeToggleGroup<String>(
                      variant: AcmeToggleGroupVariant.outline,
                      selectedValue: _weight,
                      semanticLabel: 'Weight',
                      onChanged: (value) => setState(() {
                        _weight = value;
                        _lastAction = 'weight -> $value';
                      }),
                      items: const [
                        RemixToggleGroupItem(value: 'bold', label: 'Bold'),
                        RemixToggleGroupItem(value: 'italic', label: 'Italic'),
                        RemixToggleGroupItem(
                          value: 'strike',
                          label: 'Strike',
                          enabled: false,
                        ),
                      ],
                    ),
                    AcmeSegmentedControl<String>(
                      selectedValue: _view,
                      semanticLabel: 'View',
                      onChanged: (value) => setState(() {
                        _view = value;
                        _lastAction = 'view -> $value';
                      }),
                      items: const [
                        RemixSegmentedControlItem(value: 'list', label: 'List'),
                        RemixSegmentedControlItem(
                          value: 'board',
                          label: 'Board',
                        ),
                        RemixSegmentedControlItem(
                          value: 'timeline',
                          label: 'Timeline',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('Overlays', color: data.mutedForeground),
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    AcmeTooltip(
                      tooltipChild: const Text('Adds a new workspace'),
                      child: AcmeButton.secondary(
                        label: 'Hover me',
                        onPressed: () => _record('tooltip anchor'),
                      ),
                    ),
                    // The trigger drives the popover through a controller
                    // rather than relying on `openOnTap`. `RemixPopover`
                    // opens on a tap of its own child, and a button with its
                    // own `onPressed` consumes that tap before the popover
                    // sees it — a trigger built the obvious way never opens.
                    AcmePopover(
                      controller: _filters,
                      popoverChild: Text(
                        'Filters go here.',
                        style: TextStyle(color: data.foreground),
                      ),
                      semanticLabel: 'Filters',
                      child: AcmeButton.outline(
                        label: 'Filter',
                        onPressed: () {
                          _filters.isOpen ? _filters.close() : _filters.open();
                          _record('popover');
                        },
                      ),
                    ),
                    AcmeMenu<String>(
                      trigger: const RemixMenuTrigger(label: 'Actions'),
                      semanticLabel: 'Actions',
                      onSelected: (value) => _record('menu -> $value'),
                      items: const [
                        RemixMenuItem(value: 'rename', label: 'Rename'),
                        RemixMenuItem(value: 'duplicate', label: 'Duplicate'),
                        RemixMenuDivider<String>(),
                        RemixMenuItem(
                          value: 'delete',
                          label: 'Delete',
                          enabled: false,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 200,
                      child: AcmeSelect<String>(
                        trigger: const RemixSelectTrigger(
                          placeholder: 'Choose a plan',
                        ),
                        selectedValue: _plan,
                        semanticLabel: 'Plan',
                        onChanged: (value) => setState(() {
                          _plan = value;
                          _lastAction = 'select -> $value';
                        }),
                        items: const [
                          RemixSelectItem(value: 'free', label: 'Free'),
                          RemixSelectItem(value: 'pro', label: 'Pro'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('Accordion', color: data.mutedForeground),
                // `RemixAccordionGroup` is behavioral and carries no recipe:
                // it owns which sections are open while the adapter owns the
                // rows.
                RemixAccordionGroup<String>(
                  controller: _sections,
                  initialExpandedValues: const ['shipping'],
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AcmeAccordion(
                        value: 'shipping',
                        title: 'Shipping',
                        trailingIcon: AcmeIcons.check,
                        child: Text('Two to four business days.'),
                      ),
                      AcmeAccordion(
                        value: 'returns',
                        title: 'Returns',
                        trailingIcon: AcmeIcons.check,
                        child: Text('Thirty days, unworn.'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                _Label('Disclosure', color: data.mutedForeground),
                // The accordion's standalone sibling: one collapsible
                // section, open by default so the gallery shows the revealed
                // content and the expanded trigger fill.
                const AcmeDisclosure(
                  defaultExpanded: true,
                  trigger: const Text('Show details'),
                  content: const Text('The full breakdown, revealed.'),
                ),
                const SizedBox(height: 16),

                _Label('Dialog', color: data.mutedForeground),
                // Rendered in place rather than over a barrier: the gallery is
                // showing the panel's recipe, and Remix owns the presentation.
                AcmeDialog(
                  title: 'Delete workspace?',
                  description:
                      'This removes every project in it, for everyone.',
                  actions: [
                    AcmeButton.ghost(
                      label: 'Cancel',
                      onPressed: () => _record('dialog cancel'),
                    ),
                    AcmeButton.destructive(
                      label: 'Delete',
                      onPressed: () => _record('dialog delete'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Label('Data', color: data.mutedForeground),
                const AcmeDataList(
                  items: [
                    RemixDataListItem(label: 'Status', value: 'Active'),
                    RemixDataListItem(label: 'Plan', value: 'Pro'),
                    RemixDataListItem(label: 'Seats', value: '12 of 20'),
                  ],
                ),
                const SizedBox(height: 12),
                // The table's checkboxes, pager, and page-size control are the
                // application's own recipes: `data_table` is the one registry
                // item that depends on other items rather than only on theme.
                AcmeDataTable<Map<String, String>>(
                  semanticLabel: 'Members',
                  rows: const [
                    {'name': 'Ada', 'role': 'Owner'},
                    {'name': 'Grace', 'role': 'Admin'},
                  ],
                  rowId: (row) => row['name']!,
                  selectedRowIds: _members,
                  onSelectionChanged: (ids) => setState(() {
                    _members = ids;
                    _lastAction = 'members -> ${ids.join(', ')}';
                  }),
                  columns: [
                    RemixDataTableColumn(
                      id: 'name',
                      label: 'Name',
                      cellBuilder: (context, row) => Text(row['name']!),
                    ),
                    RemixDataTableColumn(
                      id: 'role',
                      label: 'Role',
                      cellBuilder: (context, row) => Text(row['role']!),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _Caption(
                  'Last action: $_lastAction',
                  color: data.mutedForeground,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text, {required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          color: color,
        ),
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text, {required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 12, color: color));
  }
}
