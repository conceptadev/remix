import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by Alignui
// https://www.alignui.com/docs/v1.2/ui/dropdown

void main() {
  // Enable semantics for web testing/automation
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: deprecated_member_use
  WidgetsBinding.instance.ensureSemantics();

  runApp(
    const MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: MenuExample()),
    ),
  );
}

class MenuExample extends StatefulWidget {
  const MenuExample({super.key});

  @override
  State<MenuExample> createState() => _MenuExampleState();
}

class _MenuExampleState extends State<MenuExample> {
  final controller = MenuController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          // RemixMenu
          RemixMenu<String>(
            trigger: Container(
              constraints: const BoxConstraints(minHeight: 40),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blueGrey.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.withValues(alpha: 0.1),
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'Open Remix Menu',
                style: TextStyle(color: Colors.blueGrey.shade700),
              ),
            ),
            entries: [
              RemixMenuAction(
                value: 'History',
                leading: const Icon(Icons.history),
                style: menuItemStyle,
                child: const Text('History'),
              ),
              RemixMenuAction(
                value: 'Settings',
                leading: const Icon(Icons.settings),
                style: menuItemStyle,
                child: const Text('Settings'),
              ),
              const RemixMenuSeparator(),
              RemixMenuAction(
                value: 'Logout',
                leading: const Icon(Icons.logout),
                style: menuItemStyle.onHovered(
                  .color(Colors.redAccent.withValues(alpha: 0.05))
                      .label(.color(Colors.redAccent))
                      .leadingIcon(.color(Colors.redAccent)),
                ),
                child: const Text('Logout'),
              ),
            ],
            positioning: const OverlayPositionConfig(
              side: OverlaySide.bottom,
              alignment: OverlayAlignment.center,
              sideOffset: 8,
            ),
            style: menuStyle,
            onSelected: (value) {
              debugPrint('RemixMenu: $value');
            },
            controller: controller,
          ),
          const SizedBox(height: 40),
          // Material PopupMenuButton for comparison
          PopupMenuButton<String>(
            onSelected: (value) {
              debugPrint('Material Menu: $value');
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'History', child: Text('History')),
              PopupMenuItem(value: 'Settings', child: Text('Settings')),
              PopupMenuDivider(),
              PopupMenuItem(value: 'Logout', child: Text('Logout')),
            ],
            child: const Text('Open Material Menu'),
          ),
        ],
      ),
    );
  }

  RemixMenuStyler get menuStyle {
    return RemixMenuStyler()
        .overlay(
          .new(
            padding: EdgeInsetsMix.all(12),
            decoration: BoxDecorationMix(
              color: Colors.white,
              borderRadius: BorderRadiusMix.all(const Radius.circular(12)),
              border: BorderMix.all(
                BorderSideMix(color: Colors.blueGrey.shade100),
              ),
              boxShadow: [
                BoxShadowMix(
                  color: Colors.blueGrey.withValues(alpha: 0.1),
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        )
        .divider(.color(Colors.blueGrey.shade100).height(1).marginY(6));
  }

  RemixMenuItemStyler get menuItemStyle {
    return RemixMenuItemStyler()
        .leadingInset(6)
        .checkableLeadingInset(24)
        .trailingInset(6)
        .leadingIcon(.size(20).color(Colors.blueGrey.shade800))
        .spacing(8)
        .borderRadiusAll(const Radius.circular(8))
        .label(.color(Colors.blueGrey.shade800))
        .onHovered(.color(Colors.blueGrey.shade50));
  }
}
