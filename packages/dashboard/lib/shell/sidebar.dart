import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remix/remix.dart';

import '../widgets/toast.dart';
import 'dashboard_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.selected, required this.onSelected});

  final DashboardPage selected;
  final ValueChanged<DashboardPage> onSelected;

  @override
  Widget build(BuildContext context) {
    final panel = MixScope.tokenOf(FortalTokens.colorPanelSolid, context);
    final border = MixScope.tokenOf(FortalTokens.grayA5, context);

    return Container(
      width: 256,
      decoration: BoxDecoration(
        color: panel,
        border: Border(right: BorderSide(color: border)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            const _Brand(),
            Container(height: 1, color: border),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 20),
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    for (final section in DashboardSection.values) ...[
                      _SectionLabel(section.label),
                      for (final page in DashboardPage.values.where(
                        (page) => page.section == section,
                      ))
                        _NavItem(
                          key: ValueKey('nav-${page.name}'),
                          page: page,
                          selected: page == selected,
                          onPressed: () => onSelected(page),
                        ),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),
            ),
            Container(height: 1, color: border),
            const _Profile(),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 12,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: .center,
            decoration: BoxDecoration(
              color: MixScope.tokenOf(FortalTokens.accent9, context),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Colors.white,
              size: 18,
            ),
          ),
          StyledText(
            'Remix',
            style: TextStyler(
              style: FortalTokens.text5.mix(),
            ).fontWeight(.w700).color(FortalTokens.gray12()),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
      child: StyledText(
        label.toUpperCase(),
        style: TextStyler(
          style: FortalTokens.text1.mix(),
        ).fontWeight(.w600).letterSpacing(0.7).color(FortalTokens.gray11()),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    super.key,
    required this.page,
    required this.selected,
    required this.onPressed,
  });

  final DashboardPage page;
  final bool selected;
  final VoidCallback onPressed;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _focused = false;
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final accent = widget.selected
        ? MixScope.tokenOf(
            _pressed ? FortalTokens.accentA5 : FortalTokens.accentA3,
            context,
          )
        : MixScope.tokenOf(
            _pressed
                ? FortalTokens.grayA4
                : _hovered
                ? FortalTokens.grayA3
                : FortalTokens.grayA1,
            context,
          );
    final foreground = MixScope.tokenOf(
      widget.selected ? FortalTokens.accent12 : FortalTokens.gray12,
      context,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Semantics(
        button: true,
        selected: widget.selected,
        label: widget.page.label,
        child: Focus(
          onFocusChange: (value) => setState(() => _focused = value),
          onKeyEvent: (_, event) {
            if (event is KeyDownEvent &&
                (event.logicalKey == LogicalKeyboardKey.enter ||
                    event.logicalKey == LogicalKeyboardKey.space)) {
              widget.onPressed();
              return .handled;
            }
            return .ignored;
          },
          child: Builder(
            builder: (focusContext) => MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _hovered = true),
              onExit: (_) => setState(() => _hovered = false),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (_) => setState(() => _pressed = true),
                onTapCancel: () => setState(() => _pressed = false),
                onTapUp: (_) => setState(() => _pressed = false),
                onTap: () {
                  Focus.of(focusContext).requestFocus();
                  widget.onPressed();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  width: double.infinity,
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    border: _focused
                        ? Border.all(
                            color: MixScope.tokenOf(
                              FortalTokens.focus8,
                              context,
                            ),
                            width: 2,
                          )
                        : null,
                  ),
                  child: Row(
                    spacing: 8,
                    children: [
                      Icon(widget.page.icon, size: 16, color: foreground),
                      Expanded(
                        child: StyledText(
                          widget.page.label,
                          style: TextStyler(style: FortalTokens.text2.mix())
                              .fontWeight(.w500)
                              .color(foreground)
                              .maxLines(1)
                              .overflow(TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: FortalMenu<String>(
        semanticLabel: 'Workspace account menu',
        trigger: Row(
          spacing: 10,
          children: [
            const FortalAvatar(label: 'LF', size: .size2),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  StyledText(
                    'Leo Farias',
                    style: TextStyler(
                      style: FortalTokens.text2.mix(),
                    ).fontWeight(.w600).color(FortalTokens.gray12()),
                  ),
                  StyledText(
                    'leo@remix.dev',
                    style: TextStyler(
                      style: FortalTokens.text1.mix(),
                    ).color(FortalTokens.gray11()),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.more_horiz,
              size: 18,
              color: MixScope.tokenOf(FortalTokens.gray11, context),
            ),
          ],
        ),
        items: const [
          RemixMenuAction(value: 'profile', child: Text('View profile')),
          RemixMenuAction(value: 'preferences', child: Text('Preferences')),
          RemixMenuSeparator(),
          RemixMenuAction(value: 'signout', child: Text('Sign out')),
        ],
        onSelected: (value) => showToast(
          context,
          message: value == 'signout'
              ? 'Signed out of demo'
              : '${value[0].toUpperCase()}${value.substring(1)} opened',
        ),
      ),
    );
  }
}
