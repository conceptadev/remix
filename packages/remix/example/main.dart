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
      appearance: .light,
      accentColor: .blue,
      grayColor: .slate,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RemixExampleScreen(),
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: FortalCard(
                variant: .classic,
                size: .size3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FortalBadge(child: Text('Remix 1.0')),
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
                        FortalToggle(
                          variant: .outline,
                          selected: notificationsEnabled,
                          onChanged: (value) {
                            setState(() => notificationsEnabled = value);
                          },
                          icon: Icons.notifications_active_outlined,
                          label: 'Notifications',
                        ),
                        FortalButton(
                          onPressed: () {
                            debugPrint('Continue pressed');
                          },
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Continue'),
                              Icon(Icons.arrow_forward_rounded),
                            ],
                          ),
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
