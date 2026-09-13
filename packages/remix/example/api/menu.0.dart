import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

// Inspired by Alignui
// https://www.alignui.com/docs/v1.2/ui/dropdown

void main() {
  // Enable semantics for web testing/automation
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: deprecated_member_use
  if (kIsWeb) WidgetsBinding.instance.ensureSemantics();

  runApp(
    WidgetsApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      textStyle: const TextStyle(color: Color(0xFF202020), fontSize: 16),
      pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
      ),
      home: const ColoredBox(color: Colors.white, child: MenuExample()),
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
            trigger: const RemixMenuTrigger(label: 'Open Remix Menu'),
            items: [
              RemixMenuItem(
                value: 'History',
                leadingIcon: Icons.history,
                label: 'History',
                style: menuItemStyle,
              ),
              RemixMenuItem(
                value: 'Settings',
                leadingIcon: Icons.settings,
                label: 'Settings',
                style: menuItemStyle,
              ),
              const RemixMenuDivider(),
              RemixMenuItem(
                value: 'Logout',
                leadingIcon: Icons.logout,
                label: 'Logout',
                style: menuItemStyle.onHovered(
                  MenuItemStyler()
                      .color(Colors.redAccent.withValues(alpha: 0.05))
                      .label(TextStyler().color(Colors.redAccent))
                      .leadingIcon(IconStyler().color(Colors.redAccent)),
                ),
              ),
            ],
            positioning: const OverlayPositionConfig(
              side: .bottom,
              alignment: .center,
              sideOffset: 8,
            ),
            style: menuStyle,
            onSelected: (value) {
              debugPrint('RemixMenu: $value');
            },
            controller: controller,
          ),
        ],
      ),
    );
  }

  MenuStyler get menuStyle {
    return MenuStyler()
        .trigger(
          MenuTriggerStyler()
              .padding(EdgeInsetsMix.symmetric(horizontal: 14))
              .decoration(
                BoxDecorationMix()
                    .color(Colors.white)
                    .borderRadius(
                      BorderRadiusMix.all(const Radius.circular(12)),
                    )
                    .border(
                      BorderMix.all(
                        BorderSideMix(color: Colors.blueGrey.shade100),
                      ),
                    )
                    .boxShadow([
                      BoxShadowMix(
                        color: Colors.blueGrey.withValues(alpha: 0.1),
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ]),
              )
              .constraints(BoxConstraintsMix(minHeight: 40))
              .label(
                TextStyler()
                    .color(Colors.blueGrey.shade700)
                    .fontWeight(FontWeight.w400),
              )
              .onHovered(MenuTriggerStyler().color(Colors.red)),
        )
        .overlay(
          FlexBoxStyler(
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
        .divider(
          DividerStyler()
              .color(Colors.blueGrey.shade100)
              .height(1)
              .margin(.vertical(6)),
        );
  }

  MenuItemStyler get menuItemStyle {
    return MenuItemStyler()
        .padding(.all(6))
        .leadingIcon(IconStyler().size(20).color(Colors.blueGrey.shade800))
        .spacing(8)
        .borderRadius(.all(const Radius.circular(8)))
        .label(TextStyler().color(Colors.blueGrey.shade800))
        .onHovered(MenuItemStyler().color(Colors.blueGrey.shade50));
  }
}
