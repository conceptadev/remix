import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import 'demos.dart';
import 'host.dart';
import 'ui/ui.dart';

class CatalogEntry {
  const CatalogEntry({
    required this.id,
    required this.title,
    required this.lede,
    required this.builder,
  });

  final String id;
  final String title;
  final String lede;
  final WidgetBuilder builder;
}

final catalogEntries = <CatalogEntry>[
  CatalogEntry(
    id: 'run',
    title: 'A full turn',
    lede:
        'A mock run: allow or deny checks, finish or stop the run, then submit another message.',
    builder: (_) => const ComposedRunDemo(),
  ),
  CatalogEntry(
    id: 'composer',
    title: 'Composer',
    lede:
        'Enter sends. Shift+Enter is a newline. IME composition is ignored. Send becomes Stop while a run is live.',
    builder: (_) => const ComposerDemo(),
  ),
  CatalogEntry(
    id: 'message',
    title: 'Message',
    lede:
        'Sender-aware rows. User aligns to the end, assistant to the start. Grouped turns keep a placeholder avatar.',
    builder: (_) => const MessageDemo(),
  ),
  CatalogEntry(
    id: 'transcript',
    title: 'Transcript',
    lede:
        'Follows growth at the live edge. Scroll away to read history. Return to the edge to follow again.',
    builder: (_) => const TranscriptDemo(),
  ),
  CatalogEntry(
    id: 'permission',
    title: 'Permission',
    lede:
        'Allow once, always allow, or deny. The card stays in the transcript after the decision.',
    builder: (_) => const PermissionDemo(),
  ),
  CatalogEntry(
    id: 'execution',
    title: 'Execution',
    lede:
        'Open while the tool runs. Collapses when it settles. Reopen to read the output.',
    builder: (_) => const ExecutionDemo(),
  ),
  CatalogEntry(
    id: 'plan',
    title: 'Plan',
    lede: 'Advance through three tasks, then replay the plan.',
    builder: (_) => const PlanDemo(),
  ),
  CatalogEntry(
    id: 'activity',
    title: 'Activity',
    lede:
        'A slim ledger. Each row is a title, a status, and an optional host-rendered child.',
    builder: (_) => const ActivityDemo(),
  ),
  CatalogEntry(
    id: 'answer',
    title: 'Answer',
    lede:
        'Host-rendered body. Copy, retry, and sources appear only when the stream settles.',
    builder: (_) => const AnswerDemo(),
  ),
];

class AgentCatalog extends StatefulWidget {
  const AgentCatalog({super.key});

  @override
  State<AgentCatalog> createState() => _AgentCatalogState();
}

class _AgentCatalogState extends State<AgentCatalog> {
  final _keys = {for (final entry in catalogEntries) entry.id: GlobalKey()};
  var _active = catalogEntries.first.id;
  late final ScrollController _scroll;
  var _jumpInProgress = 0;

  @override
  void initState() {
    super.initState();
    _scroll = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_jumpInProgress > 0) return;
    CatalogEntry? current;
    for (final entry in catalogEntries) {
      final box =
          _keys[entry.id]?.currentContext?.findRenderObject() as RenderBox?;
      if (box == null || !box.hasSize) continue;
      final offset = box.localToGlobal(Offset.zero).dy;
      if (offset < 160) current = entry;
    }
    if (current != null && current.id != _active) {
      setState(() => _active = current!.id);
    }
  }

  Future<void> _jump(String id) async {
    final context = _keys[id]?.currentContext;
    if (context == null) return;
    setState(() => _active = id);
    _jumpInProgress++;
    try {
      await Scrollable.ensureVisible(
        context,
        alignment: 0,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 220),
      );
    } finally {
      _jumpInProgress--;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = HostTheme.of(context);
    final wide = MediaQuery.sizeOf(context).width >= 880;

    final rail = _Rail(active: _active, onSelect: _jump, vertical: wide);

    final body = SingleChildScrollView(
      controller: _scroll,
      padding: EdgeInsets.fromLTRB(wide ? 36 : 20, 28, wide ? 48 : 20, 80),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Remix Agent', style: theme.display),
              const SizedBox(height: 8),
              Text(
                'Surfaces for a long-running run. No theme. No model SDK. '
                'Compose them in the host.',
                style: theme.body.copyWith(
                  color: theme.ink.withValues(alpha: 0.72),
                ),
              ),
              const SizedBox(height: 8),
              Text('UNPUBLISHED REVIEW CATALOG', style: theme.meta),
              for (final entry in catalogEntries)
                KeyedSubtree(
                  key: _keys[entry.id],
                  child: _Section(entry: entry, wide: wide),
                ),
            ],
          ),
        ),
      ),
    );

    if (!wide) {
      return Column(
        children: [
          _TopBar(onToggleDark: _toggleDark),
          rail,
          Expanded(child: body),
        ],
      );
    }

    return Column(
      children: [
        _TopBar(onToggleDark: _toggleDark),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(width: 220, child: rail),
              ColoredBox(
                color: theme.hairline,
                child: const SizedBox(width: 1),
              ),
              Expanded(child: body),
            ],
          ),
        ),
      ],
    );
  }

  void _toggleDark() {
    final host = context.findAncestorStateOfType<_DarkHostState>();
    host?.toggle();
  }
}

/// The installed theme, bridged onto this application's palette.
///
/// The registry ships a neutral scale; this catalog is a workshop ledger. Only
/// the surface, text, hairline, radius and accent tokens move, and they move
/// through the installed theme's own [UiThemeData.copyWith] — so `lib/ui/`
/// stays byte-identical to the registry and every recipe recomputes its hover,
/// focus and disabled fragments from these values for free.
///
/// `primary` becomes copper, which keeps the accent on exactly two things: a
/// live run, and the one primary action on a surface. `destructive` stays the
/// registry red, because stopping a run is an interrupt, not the accent.
UiThemeData _bridgedTheme(HostTheme theme) {
  final base = theme.dark
      ? const UiThemeData.dark()
      : const UiThemeData.light();
  return base.copyWith(
    background: theme.surface,
    foreground: theme.ink,
    primary: theme.live,
    primaryForeground: const Color(0xFFF7F9FB),
    muted: theme.ink.withValues(alpha: 0.05),
    mutedForeground: theme.ink.withValues(alpha: 0.62),
    accent: theme.ink.withValues(alpha: 0.08),
    accentForeground: theme.ink,
    border: theme.hairline,
    focusRing: theme.live,
    radius: const Radius.circular(12),
  );
}

/// Lets the catalog flip the ancestor [HostTheme].
class DarkHost extends StatefulWidget {
  const DarkHost({super.key, required this.child});

  final Widget child;

  @override
  State<DarkHost> createState() => _DarkHostState();
}

class _DarkHostState extends State<DarkHost> {
  var dark = false;

  void toggle() => setState(() => dark = !dark);

  @override
  Widget build(BuildContext context) {
    final theme = HostTheme(dark: dark, child: widget.child);
    return HostTheme(
      dark: dark,
      // The installed recipes resolve `UiTokens` through the `MixScope` this
      // scope installs, so the composer follows the same light/dark switch the
      // rest of the catalog does. The other seven demos use plain colours and
      // do not read tokens, so nesting this over `MixScope.empty` changes
      // nothing for them.
      child: UiThemeScope(
        data: _bridgedTheme(theme),
        child: DefaultTextStyle(
          style: theme.body,
          child: ColoredBox(color: theme.paper, child: widget.child),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onToggleDark});

  final VoidCallback onToggleDark;

  @override
  Widget build(BuildContext context) {
    final theme = HostTheme.of(context);
    return ColoredBox(
      color: theme.rail,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Semantics(
              container: true,
              explicitChildNodes: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ExcludeSemantics(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.live,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Remix Agent',
                    style: theme.body.copyWith(fontWeight: FontWeight.w600),
                  ),
                  if (MediaQuery.sizeOf(context).width >= 480) ...[
                    const SizedBox(width: 12),
                    Text('review catalog', style: theme.meta),
                  ],
                ],
              ),
            ),
            const Spacer(),
            Semantics(
              container: true,
              explicitChildNodes: true,
              child: RemixButton(
                label: theme.dark ? 'Day' : 'Night',
                onPressed: onToggleDark,
                style: ButtonStyler()
                    .minWidth(48)
                    .minHeight(48)
                    .padding(.symmetric(horizontal: 8))
                    .label(
                      TextStyler()
                          .color(theme.ink)
                          .fontSize(theme.meta.fontSize ?? 12),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Rail extends StatefulWidget {
  const _Rail({
    required this.active,
    required this.onSelect,
    required this.vertical,
  });

  final String active;
  final ValueChanged<String> onSelect;
  final bool vertical;

  @override
  State<_Rail> createState() => _RailState();
}

class _RailState extends State<_Rail> {
  final _keys = {for (final entry in catalogEntries) entry.id: GlobalKey()};

  @override
  void didUpdateWidget(_Rail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active != widget.active ||
        oldWidget.vertical != widget.vertical) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final target = _keys[widget.active]?.currentContext;
        if (target == null) return;
        // Reveal only within the rail; do not move the page's content scroll.
        Scrollable.of(
          target,
        ).position.ensureVisible(target.findRenderObject()!, alignment: 0.5);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = HostTheme.of(context);
    final items = [
      for (final entry in catalogEntries)
        _RailItem(
          key: _keys[entry.id],
          label: entry.title,
          selected: entry.id == widget.active,
          onTap: () => widget.onSelect(entry.id),
        ),
    ];

    if (!widget.vertical) {
      return ColoredBox(
        color: theme.rail,
        // The strip scrolls, so its edges fade into the rail instead of
        // cutting a label mid-word. The scrollbar is dropped with it: a
        // hairline of chrome under the chips read as a stray rule.
        child: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0x00000000),
              Color(0xFF000000),
              Color(0xFF000000),
              Color(0x00000000),
            ],
            stops: [0, 0.04, 0.96, 1],
          ).createShader(bounds),
          blendMode: BlendMode.dstIn,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // 8 here plus the toggle's own 12 puts a chip's label on the
              // same left edge as the page content below it.
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(children: items),
            ),
          ),
        ),
      );
    }

    return ColoredBox(
      color: theme.rail,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 12, 20),
        children: [
          // The pills start at the list's own 16; their labels sit 12 further
          // in. The caption follows the labels, so the column reads as one
          // left edge rather than two.
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: _RailCaption(),
          ),
          const SizedBox(height: 12),
          ...items,
        ],
      ),
    );
  }
}

class _RailCaption extends StatelessWidget {
  const _RailCaption();

  @override
  Widget build(BuildContext context) =>
      Text('Surfaces', style: HostTheme.of(context).meta);
}

class _RailItem extends StatelessWidget {
  const _RailItem({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = HostTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, right: 8),
      child: RemixToggle(
        selected: selected,
        label: label,
        onChanged: (_) => onTap(),
        style: ToggleStyler()
            .minHeight(48)
            .padding(.symmetric(horizontal: 12))
            .borderRadius(.circular(8))
            .color(
              selected
                  ? theme.live.withValues(alpha: 0.14)
                  : const Color(0x00000000),
            )
            .label(
              TextStyler()
                  .color(theme.ink)
                  .fontSize(theme.body.fontSize ?? 14)
                  .fontWeight(selected ? FontWeight.w600 : FontWeight.w400),
            ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.entry, required this.wide});

  final CatalogEntry entry;

  final bool wide;

  double get _sectionGap => wide ? 48 : 32;

  @override
  Widget build(BuildContext context) {
    final theme = HostTheme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: _sectionGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            entry.title,
            style: theme.body.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            entry.lede,
            style: theme.body.copyWith(color: theme.ink.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 16),
          entry.builder(context),
        ],
      ),
    );
  }
}
