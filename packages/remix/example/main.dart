import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

void main() {
  runApp(const RemixExampleApp());
}

/// Remix ships no theme: every visual decision below is a styler you author.
///
/// If you would rather start from a ready-made Radix Themes-inspired palette,
/// add the companion `remix_fortal` package and wrap your app in `FortalScope`.
class RemixExampleApp extends StatelessWidget {
  const RemixExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: _surface,
      debugShowCheckedModeBanner: false,
      builder: (_, _) => Overlay.wrap(child: const RemixExampleScreen()),
    );
  }
}

const _surface = Color(0xFFF8FAFC);
const _accent = Color(0xFF3E63DD);
const _ink = Color(0xFF1C2024);
const _border = Color(0xFFDDE1E6);

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
      color: _surface,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: RemixCard(
                style: _cardStyle,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RemixBadge(label: 'Remix 1.0', style: _badgeStyle),
                    const SizedBox(height: 16),
                    const Text(
                      'Build Flutter interfaces with Remix widgets and styles '
                      'you author yourself.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: _ink,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        RemixToggle(
                          style: _toggleStyle,
                          selected: notificationsEnabled,
                          onChanged: (value) {
                            setState(() => notificationsEnabled = value);
                          },
                          icon: Icons.notifications_active_outlined,
                          label: 'Notifications',
                        ),
                        RemixButton(
                          style: _buttonStyle,
                          label: 'Continue',
                          trailingIcon: Icons.arrow_forward_rounded,
                          onPressed: () {
                            debugPrint('Continue pressed');
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

final _cardStyle = CardStyler()
    .color(Colors.white)
    .paddingAll(24)
    .borderRadiusAll(const Radius.circular(12))
    .borderAll(color: _border);

final _badgeStyle = BadgeStyler()
    .color(_accent.withValues(alpha: 0.12))
    .paddingX(8)
    .paddingY(2)
    .borderRadiusAll(const Radius.circular(999))
    .label(TextStyler().color(_accent).fontSize(12));

final _buttonStyle = ButtonStyler()
    .color(_accent)
    .paddingX(16)
    .paddingY(10)
    .borderRadiusAll(const Radius.circular(6))
    .label(TextStyler().color(Colors.white).fontWeight(FontWeight.w500))
    .icon(IconStyler().color(Colors.white).size(16))
    .animate(AnimationConfig.spring(const Duration(milliseconds: 200)))
    .onHovered(.color(const Color(0xFF3358D4)))
    .onPressed(.scale(0.98));

final _toggleStyle = ToggleStyler()
    .paddingX(12)
    .paddingY(8)
    .borderRadiusAll(const Radius.circular(6))
    .borderAll(color: _border)
    .label(TextStyler().color(_ink).fontSize(14))
    .icon(IconStyler().color(_ink).size(16))
    .onSelected(
      ToggleStyler()
          .color(_accent.withValues(alpha: 0.12))
          .label(TextStyler().color(_accent))
          .icon(IconStyler().color(_accent)),
    );
