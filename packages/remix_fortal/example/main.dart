import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  runApp(const FortalExampleApp());
}

class FortalExampleApp extends StatelessWidget {
  const FortalExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FortalScope(
      accent: .blue,
      gray: .slate,
      brightness: .light,
      child: WidgetsApp(
        color: const Color(0xFFF8FAFC),
        debugShowCheckedModeBanner: false,
        builder: (_, _) => Overlay.wrap(child: const FortalExampleScreen()),
      ),
    );
  }
}

class FortalExampleScreen extends StatefulWidget {
  const FortalExampleScreen({super.key});

  @override
  State<FortalExampleScreen> createState() => _FortalExampleScreenState();
}

class _FortalExampleScreenState extends State<FortalExampleScreen> {
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
                    // FortalHeading carries the visual size and the native
                    // heading level independently, so a card title can stay
                    // small and still announce as a level-2 heading.
                    const FortalHeading(
                      'Build themed Flutter interfaces with Remix widgets and Fortal recipes.',
                      headingLevel: 2,
                      size: .size5,
                    ),
                    const SizedBox(height: 12),
                    const FortalText(
                      'Every recipe resolves through the active Fortal scope.',
                      size: .size2,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const FortalCode.soft(
                          'FortalScope',
                          size: FortalTextSize.size2,
                        ),
                        const FortalKbd.classic(
                          '⌘K',
                          size: FortalTextSize.size2,
                          semanticLabel: 'Command K',
                        ),
                        FortalLink(
                          'Read the docs',
                          size: FortalTextSize.size2,
                          linkUrl: Uri.parse(
                            'https://docs.page/btwld/remix/fortal',
                          ),
                          // FortalLink never launches linkUrl; navigation
                          // stays the caller's job.
                          onPressed: () => debugPrint('Docs pressed'),
                        ),
                      ],
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
