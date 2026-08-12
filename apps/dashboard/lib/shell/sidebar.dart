import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

import '../utils/text.dart';
import '../widgets/action_popover.dart';
import '../widgets/toast.dart';
import '../widgets/typography.dart';
import 'dashboard_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.selected, required this.onSelected});

  final DashboardPage selected;
  final ValueChanged<DashboardPage> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      decoration: BoxDecoration(
        color: MixScope.tokenOf(FortalTokens.colorPanelSolid, context),
        border: Border(
          right: BorderSide(
            color: MixScope.tokenOf(FortalTokens.grayA5, context),
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            const _Brand(),
            const FortalDivider(size: .size4),
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
            const FortalDivider(size: .size4),
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
    return Box(
      key: const ValueKey('dashboard-brand'),
      style: BoxStyler().paddingAll(FortalTokens.space4()),
      child: const DashboardTextTone(
        child: FortalText('Dashboard', size: .size5, weight: .bold),
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
        style: dashboardText(
          .size1,
          weight: .medium,
          tone: .muted,
        ).letterSpacing(0.7),
      ),
    );
  }
}

/// A sidebar destination.
///
/// The Fortal ghost toggle already carries this exact treatment — `gray-12`
/// when idle, `accent-3`/`accent-11` when selected, plus hover, press, focus
/// ring and keyboard activation — so the destination only has to stretch it
/// across the rail.
///
/// It does own its semantics, though. `RemixToggle` announces a *toggled*
/// on/off state and offers no way to opt out, but a rail destination is one of
/// a mutually exclusive set: `selected` is the contract assistive technology
/// expects. Excluding the toggle's node and naming the destination here keeps
/// that, and keeps the rendered label from being announced twice.
class _NavItem extends StatelessWidget {
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
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Semantics(
      button: true,
      selected: selected,
      label: page.label,
      excludeSemantics: true,
      onTap: onPressed,
      child: RemixToggle(
        selected: selected,
        onChanged: (_) => onPressed(),
        label: page.label,
        icon: page.icon,
        style: fortalToggleStyle(
          variant: .ghost,
        ).container(.mainAxisSize(.max).mainAxisAlignment(.start)),
      ),
    ),
  );
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: DashboardActionPopover(
        key: const ValueKey('sidebar-account-trigger'),
        semanticLabel: 'Workspace account menu',
        trigger: Row(
          spacing: 10,
          children: [
            const FortalAvatar(label: 'LF', size: .size2),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  const DashboardTextTone(
                    child: FortalText(
                      'Leo Farias',
                      size: .size2,
                      weight: .medium,
                    ),
                  ),
                  StyledText(
                    'leo@remix.dev',
                    style: dashboardText(.size1, tone: .muted),
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
        actions: const [
          DashboardAction(value: 'profile', label: 'View profile'),
          DashboardAction(value: 'preferences', label: 'Preferences'),
          DashboardAction(
            value: 'signout',
            label: 'Sign out',
            dividerBefore: true,
          ),
        ],
        onSelected: (value) => showToast(
          context,
          message: value == 'signout'
              ? 'Signed out of demo'
              : '${capitalize(value)} opened',
        ),
      ),
    );
  }
}
