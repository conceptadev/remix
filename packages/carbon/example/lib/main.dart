import 'package:carbon/carbon.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CarbonGalleryApp());

class CarbonGalleryApp extends StatelessWidget {
  const CarbonGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Carbon for Flutter',
      debugShowCheckedModeBanner: false,
      home: CarbonGalleryPage(),
    );
  }
}

class CarbonGalleryPage extends StatefulWidget {
  const CarbonGalleryPage({super.key});

  @override
  State<CarbonGalleryPage> createState() => _CarbonGalleryPageState();
}

class _CarbonGalleryPageState extends State<CarbonGalleryPage> {
  CarbonTheme _theme = CarbonTheme.white;
  CarbonSize _size = CarbonSize.lg;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    // The scope sits above everything so the page chrome itself resolves
    // Carbon role tokens — the same path components use.
    return CarbonScope(
      theme: _theme,
      child: Builder(
        builder: (context) {
          final background = CarbonTokens.background.resolve(context);
          final textPrimary = CarbonTokens.textPrimary.resolve(context);
          final textSecondary = CarbonTokens.textSecondary.resolve(context);

          return Scaffold(
            backgroundColor: background,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Carbon for Flutter',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Foundation + Button vertical slice',
                      style: TextStyle(fontSize: 14, color: textSecondary),
                    ),
                    const SizedBox(height: 24),
                    _controls(background, textPrimary),
                    const SizedBox(height: 24),
                    _sectionTitle('Button kinds', textPrimary),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        for (final kind in CarbonButtonKind.values)
                          CarbonButton(
                            label: _kindLabel(kind),
                            kind: kind,
                            size: _size,
                            loading: _loading,
                            onPressed: () {},
                          ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _sectionTitle('Disabled', textPrimary),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        for (final kind in [
                          CarbonButtonKind.primary,
                          CarbonButtonKind.secondary,
                          CarbonButtonKind.tertiary,
                          CarbonButtonKind.ghost,
                        ])
                          CarbonButton(
                            label: _kindLabel(kind),
                            kind: kind,
                            size: _size,
                            onPressed: null,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _controls(Color background, Color onBackground) {
    return Wrap(
      spacing: 24,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _labeled(
          'Theme',
          onBackground,
          DropdownButton<CarbonTheme>(
            value: _theme,
            dropdownColor: background,
            style: TextStyle(color: onBackground),
            onChanged: (v) => setState(() => _theme = v ?? _theme),
            items: [
              for (final t in CarbonTheme.values)
                DropdownMenuItem(value: t, child: Text(t.name)),
            ],
          ),
        ),
        _labeled(
          'Size',
          onBackground,
          DropdownButton<CarbonSize>(
            value: _size,
            dropdownColor: background,
            style: TextStyle(color: onBackground),
            onChanged: (v) => setState(() => _size = v ?? _size),
            items: [
              for (final s in CarbonSize.values)
                DropdownMenuItem(value: s, child: Text(s.name)),
            ],
          ),
        ),
        _labeled(
          'Loading',
          onBackground,
          Switch(
            value: _loading,
            onChanged: (v) => setState(() => _loading = v),
          ),
        ),
      ],
    );
  }

  Widget _labeled(String label, Color color, Widget child) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: ', style: TextStyle(color: color)),
        child,
      ],
    );
  }

  Widget _sectionTitle(String text, Color color) => Text(
    text,
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: color),
  );

  String _kindLabel(CarbonButtonKind kind) => switch (kind) {
    CarbonButtonKind.primary => 'Primary',
    CarbonButtonKind.secondary => 'Secondary',
    CarbonButtonKind.tertiary => 'Tertiary',
    CarbonButtonKind.ghost => 'Ghost',
    CarbonButtonKind.danger => 'Danger',
    CarbonButtonKind.dangerTertiary => 'Danger tertiary',
    CarbonButtonKind.dangerGhost => 'Danger ghost',
  };
}
