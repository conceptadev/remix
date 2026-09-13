import 'package:flutter/material.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

void main() {
  runApp(const FortalButtonExampleApp());
}

class FortalButtonExampleApp extends StatelessWidget {
  const FortalButtonExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFFF8FAFC),
      pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
      ),
      builder: (context, child) => FortalScope(
        accent: FortalAccentColor.indigo,
        gray: FortalGrayColor.slate,
        mode: .light,
        child: Overlay.wrap(
          child: RemixToastScope(style: fortalToastStyle(), child: child!),
        ),
      ),
      home: const FortalButtonExampleScreen(),
      title: 'Fortal Button Example',
    );
  }
}

class FortalButtonExampleScreen extends StatelessWidget {
  const FortalButtonExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: const FortalHeading('Fortal Button Variants & Sizes'),
        ),
        Expanded(
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Button Variants',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _VariantSection(),
                SizedBox(height: 32),
                Text(
                  'Button Sizes',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _SizeSection(),
                SizedBox(height: 32),
                Text(
                  'Button States',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _StateSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _VariantSection extends StatelessWidget {
  const _VariantSection();

  void _showToast(BuildContext context, String message) {
    showRemixToast(context, RemixToastData(title: message));
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        fortalButtonStyle(variant: .solid).call(
          label: 'Solid',
          onPressed: () => _showToast(context, 'Solid button pressed'),
        ),
        fortalButtonStyle(variant: .soft).call(
          label: 'Soft',
          onPressed: () => _showToast(context, 'Soft button pressed'),
        ),
        fortalButtonStyle(variant: .surface).call(
          label: 'Surface',
          onPressed: () => _showToast(context, 'Surface button pressed'),
        ),
        fortalButtonStyle(variant: .outline).call(
          label: 'Outline',
          onPressed: () => _showToast(context, 'Outline button pressed'),
        ),
        fortalButtonStyle(variant: .ghost).call(
          label: 'Ghost',
          onPressed: () => _showToast(context, 'Ghost button pressed'),
        ),
        fortalButtonStyle(variant: .surface).call(
          label: 'Surface',
          onPressed: () => _showToast(context, 'Surface button pressed'),
        ),
      ],
    );
  }
}

class _SizeSection extends StatelessWidget {
  const _SizeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const Text('Size 1 (Small)'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            fortalButtonStyle(
              variant: .solid,
              size: FortalButtonSize.size1,
            ).call(
              label: 'Solid',
              leadingIcon: Icons.check,
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyle(
              variant: .soft,
              size: FortalButtonSize.size1,
            ).call(
              label: 'Soft',
              leadingIcon: Icons.star,
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyle(
              variant: .outline,
              size: FortalButtonSize.size1,
            ).call(
              label: 'Outline',
              leadingIcon: Icons.favorite,
              onPressed: () => debugPrint('Button pressed'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Size 2 (Medium - Default)'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            fortalButtonStyle(
              variant: .solid,
              size: FortalButtonSize.size2,
            ).call(
              label: 'Solid',
              leadingIcon: Icons.check,
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyle(
              variant: .soft,
              size: FortalButtonSize.size2,
            ).call(
              label: 'Soft',
              leadingIcon: Icons.star,
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyle(
              variant: .outline,
              size: FortalButtonSize.size2,
            ).call(
              label: 'Outline',
              leadingIcon: Icons.favorite,
              onPressed: () => debugPrint('Button pressed'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Size 3 (Large)'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            fortalButtonStyle(
              variant: .solid,
              size: FortalButtonSize.size3,
            ).call(
              label: 'Solid',
              leadingIcon: Icons.check,
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyle(
              variant: .soft,
              size: FortalButtonSize.size3,
            ).call(
              label: 'Soft',
              leadingIcon: Icons.star,
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyle(
              variant: .outline,
              size: FortalButtonSize.size3,
            ).call(
              label: 'Outline',
              leadingIcon: Icons.favorite,
              onPressed: () => debugPrint('Button pressed'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Size 4 (Extra Large)'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            fortalButtonStyle(
              variant: .solid,
              size: FortalButtonSize.size4,
            ).call(
              label: 'Solid',
              leadingIcon: Icons.check,
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyle(
              variant: .soft,
              size: FortalButtonSize.size4,
            ).call(
              label: 'Soft',
              leadingIcon: Icons.star,
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyle(
              variant: .outline,
              size: FortalButtonSize.size4,
            ).call(
              label: 'Outline',
              leadingIcon: Icons.favorite,
              onPressed: () => debugPrint('Button pressed'),
            ),
          ],
        ),
      ],
    );
  }
}

class _StateSection extends StatelessWidget {
  const _StateSection();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        fortalButtonStyle(
          variant: .solid,
        ).call(label: 'Normal', onPressed: () {}),
        fortalButtonStyle(variant: .solid).call(
          label: 'Loading',
          loading: true,
          onPressed: () => debugPrint('Button pressed'),
        ),
        fortalButtonStyle(
          variant: .solid,
        ).call(label: 'Disabled', enabled: false, onPressed: null),
        fortalButtonStyle(variant: .solid).call(
          label: 'With Icon',
          leadingIcon: Icons.download,
          onPressed: () => debugPrint('Button pressed'),
        ),
      ],
    );
  }
}
