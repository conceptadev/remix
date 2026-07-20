import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

void main() {
  runApp(const FortalButtonExampleApp());
}

class FortalButtonExampleApp extends StatelessWidget {
  const FortalButtonExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FortalScope(
      appearance: .light,
      accentColor: .indigo,
      grayColor: .slate,
      child: MaterialApp(
        home: const FortalButtonExampleScreen(),
        title: 'Fortal Button Example',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        ),
      ),
    );
  }
}

class FortalButtonExampleScreen extends StatelessWidget {
  const FortalButtonExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fortal Button Variants & Sizes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const SingleChildScrollView(
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
    );
  }
}

class _VariantSection extends StatelessWidget {
  const _VariantSection();

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Solid variant
        fortalButtonStyler(variant: .solid).call(
          child: const Text('Solid'),
          onPressed: () => _showSnackBar(context, 'Solid button pressed'),
        ),

        // Soft variant
        fortalButtonStyler(variant: .soft).call(
          child: const Text('Soft'),
          onPressed: () => _showSnackBar(context, 'Soft button pressed'),
        ),

        // Surface variant
        fortalButtonStyler(variant: .surface).call(
          child: const Text('Surface'),
          onPressed: () => _showSnackBar(context, 'Surface button pressed'),
        ),

        // Outline variant
        fortalButtonStyler(variant: .outline).call(
          child: const Text('Outline'),
          onPressed: () => _showSnackBar(context, 'Outline button pressed'),
        ),

        // Ghost variant
        fortalButtonStyler(variant: .ghost).call(
          child: const Text('Ghost'),
          onPressed: () => _showSnackBar(context, 'Ghost button pressed'),
        ),

        // Classic variant
        fortalButtonStyler(variant: .classic).call(
          child: const Text('Classic'),
          onPressed: () => _showSnackBar(context, 'Classic button pressed'),
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
            fortalButtonStyler(
              variant: .solid,
              size: FortalButtonSize.size1,
            ).call(
              child: _buttonContent('Solid', icon: Icons.check),
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyler(
              variant: .soft,
              size: FortalButtonSize.size1,
            ).call(
              child: _buttonContent('Soft', icon: Icons.star),
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyler(
              variant: .outline,
              size: FortalButtonSize.size1,
            ).call(
              child: _buttonContent('Outline', icon: Icons.favorite),
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
            fortalButtonStyler(
              variant: .solid,
              size: FortalButtonSize.size2,
            ).call(
              child: _buttonContent('Solid', icon: Icons.check),
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyler(
              variant: .soft,
              size: FortalButtonSize.size2,
            ).call(
              child: _buttonContent('Soft', icon: Icons.star),
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyler(
              variant: .outline,
              size: FortalButtonSize.size2,
            ).call(
              child: _buttonContent('Outline', icon: Icons.favorite),
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
            fortalButtonStyler(
              variant: .solid,
              size: FortalButtonSize.size3,
            ).call(
              child: _buttonContent('Solid', icon: Icons.check),
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyler(
              variant: .soft,
              size: FortalButtonSize.size3,
            ).call(
              child: _buttonContent('Soft', icon: Icons.star),
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyler(
              variant: .outline,
              size: FortalButtonSize.size3,
            ).call(
              child: _buttonContent('Outline', icon: Icons.favorite),
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
            fortalButtonStyler(
              variant: .solid,
              size: FortalButtonSize.size4,
            ).call(
              child: _buttonContent('Solid', icon: Icons.check),
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyler(
              variant: .soft,
              size: FortalButtonSize.size4,
            ).call(
              child: _buttonContent('Soft', icon: Icons.star),
              onPressed: () => debugPrint('Button pressed'),
            ),
            fortalButtonStyler(
              variant: .outline,
              size: FortalButtonSize.size4,
            ).call(
              child: _buttonContent('Outline', icon: Icons.favorite),
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
        // Normal state
        fortalButtonStyler(
          variant: .solid,
        ).call(child: const Text('Normal'), onPressed: () {}),

        // Loading state
        fortalButtonStyler(variant: .solid).call(
          child: const Text('Loading'),
          loading: true,
          onPressed: () => debugPrint('Button pressed'),
        ),

        // Disabled state
        fortalButtonStyler(
          variant: .solid,
        ).call(child: const Text('Disabled'), enabled: false, onPressed: null),

        // With icon
        fortalButtonStyler(variant: .solid).call(
          child: _buttonContent('With Icon', icon: Icons.download),
          onPressed: () => debugPrint('Button pressed'),
        ),
      ],
    );
  }
}

Widget _buttonContent(String label, {IconData? icon}) => Row(
  mainAxisSize: MainAxisSize.min,
  children: [if (icon != null) Icon(icon), Text(label)],
);
