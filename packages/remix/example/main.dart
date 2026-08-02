import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

void main() {
  runApp(const RemixExampleApp());
}

class RemixExampleApp extends StatelessWidget {
  const RemixExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FortalScope(
      accent: .blue,
      gray: .slate,
      brightness: .light,
      child: WidgetsApp(
        color: const Color(0xFFF8FAFC),
        debugShowCheckedModeBanner: false,
        builder: (_, _) => Overlay.wrap(child: const RemixExampleScreen()),
      ),
    );
  }
}

class RemixExampleScreen extends StatefulWidget {
  const RemixExampleScreen({super.key});

  @override
  State<RemixExampleScreen> createState() => _RemixExampleScreenState();
}

class _RemixExampleScreenState extends State<RemixExampleScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF8FAFC),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: FortalCard.classic(
                size: .size3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FortalBadge.soft(label: 'Remix 1.0'),
                    const SizedBox(height: 16),
                    const Text(
                      'Build themed Flutter interfaces with Remix widgets and Fortal recipes.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        FortalToggle.outline(
                          selected: notificationsEnabled,
                          onChanged: (value) {
                            setState(() => notificationsEnabled = value);
                          },
                          icon: Icons.notifications_active_outlined,
                          label: 'Notifications',
                        ),
                        FortalButton(
                          label: 'Continue',
                          trailingIcon: Icons.arrow_forward_rounded,
                          onPressed: () {
                            debugPrint('Continue pressed');
                          },
                        ),
                        FortalMenu<String>.soft(
                          trigger: const RemixMenuTrigger(label: 'Actions'),
                          items: const [
                            RemixMenuItem(value: 'preview', label: 'Preview'),
                            RemixMenuItem(value: 'share', label: 'Share'),
                          ],
                          onSelected: (value) {
                            debugPrint('Selected $value');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
