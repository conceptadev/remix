import 'package:flutter/material.dart';
import 'package:remix_carbon/remix_carbon.dart';

import 'component_catalog.dart';

class CarbonCatalogApp extends StatefulWidget {
  const CarbonCatalogApp({super.key});

  @override
  State<CarbonCatalogApp> createState() => _CarbonCatalogAppState();
}

class _CarbonCatalogAppState extends State<CarbonCatalogApp> {
  CarbonTheme theme = .white;

  @override
  Widget build(BuildContext context) {
    final brightness = theme.brightness;

    return MaterialApp(
      title: 'Remix Carbon component catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: brightness,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F62FE),
          brightness: brightness,
        ),
        scaffoldBackgroundColor: _CatalogPalette.forTheme(theme).background,
        useMaterial3: false,
      ),
      home: CarbonScope(
        theme: theme,
        child: _CatalogWorkbench(
          theme: theme,
          onThemeChanged: (next) => setState(() => theme = next),
        ),
      ),
    );
  }
}

class _CatalogWorkbench extends StatefulWidget {
  const _CatalogWorkbench({required this.theme, required this.onThemeChanged});

  final CarbonTheme theme;
  final ValueChanged<CarbonTheme> onThemeChanged;

  @override
  State<_CatalogWorkbench> createState() => _CatalogWorkbenchState();
}

class _CatalogWorkbenchState extends State<_CatalogWorkbench> {
  static const _wideBreakpoint = 900.0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();
  ComponentDemo selectedDemo = defaultCarbonComponentDemo;
  String query = '';
  String lastEvent = 'Select a component and interact with its live examples.';

  List<ComponentDemo> get filteredComponents {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return carbonComponentCatalog;

    return carbonComponentCatalog
        .where(
          (component) =>
              component.label.toLowerCase().contains(normalized) ||
              component.category.toLowerCase().contains(normalized) ||
              component.summary.toLowerCase().contains(normalized),
        )
        .toList(growable: false);
  }

  void selectComponent(ComponentDemo component, {required bool closeDrawer}) {
    setState(() {
      selectedDemo = component;
      lastEvent = '${component.label} examples loaded.';
    });
    if (closeDrawer) Navigator.of(context).pop();
  }

  Widget _navigation(_CatalogPalette palette, {required bool closeDrawer}) =>
      _CatalogNavigation(
        palette: palette,
        searchController: searchController,
        components: filteredComponents,
        selectedId: selectedDemo.id,
        onQueryChanged: (value) => setState(() => query = value),
        onSelected: (component) =>
            selectComponent(component, closeDrawer: closeDrawer),
      );

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = _CatalogPalette.forTheme(widget.theme);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= _wideBreakpoint;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: palette.background,
          drawer: isWide
              ? null
              : Drawer(
                  width: 292,
                  semanticLabel: 'Component navigation',
                  backgroundColor: palette.layer,
                  child: SafeArea(
                    child: _navigation(palette, closeDrawer: true),
                  ),
                ),
          body: Column(
            children: [
              _CatalogHeader(
                isWide: isWide,
                theme: widget.theme,
                onOpenNavigation: () => scaffoldKey.currentState?.openDrawer(),
                onThemeChanged: widget.onThemeChanged,
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: .stretch,
                  children: [
                    if (isWide)
                      SizedBox(
                        width: 272,
                        child: _navigation(palette, closeDrawer: false),
                      ),
                    Expanded(
                      child: CatalogEventScope(
                        onEvent: (event) => setState(() => lastEvent = event),
                        child: _ComponentPage(
                          key: ValueKey(selectedDemo.id),
                          component: selectedDemo,
                          palette: palette,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _CatalogStatusBar(message: lastEvent, palette: palette),
            ],
          ),
        );
      },
    );
  }
}

class _CatalogHeader extends StatelessWidget {
  const _CatalogHeader({
    required this.isWide,
    required this.theme,
    required this.onOpenNavigation,
    required this.onThemeChanged,
  });

  final bool isWide;
  final CarbonTheme theme;
  final VoidCallback onOpenNavigation;
  final ValueChanged<CarbonTheme> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      color: const Color(0xFF161616),
      child: Row(
        children: [
          if (!isWide)
            IconButton(
              key: const Key('open-navigation'),
              tooltip: 'Open component navigation',
              onPressed: onOpenNavigation,
              color: Colors.white,
              icon: const Icon(Icons.menu, size: 20),
            ),
          Container(width: 4, height: 48, color: const Color(0xFF0F62FE)),
          const SizedBox(width: 16),
          const Text(
            'Remix Carbon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: .w600,
              letterSpacing: .1,
            ),
          ),
          if (isWide) ...[
            const SizedBox(width: 10),
            const Text(
              '/ Component catalog',
              style: TextStyle(color: Color(0xFFC6C6C6), fontSize: 14),
            ),
          ],
          const Spacer(),
          if (isWide)
            Text(
              '${carbonComponentCatalog.length} components',
              style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 12),
            ),
          const SizedBox(width: 8),
          PopupMenuButton<CarbonTheme>(
            key: const Key('theme-menu'),
            tooltip: 'Change Carbon theme',
            initialValue: theme,
            onSelected: onThemeChanged,
            color: const Color(0xFF262626),
            position: .under,
            itemBuilder: (context) => [
              for (final option in CarbonTheme.values)
                PopupMenuItem(
                  value: option,
                  child: Text(
                    _themeName(option),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
            ],
            child: Semantics(
              button: true,
              label: 'Theme: ${_themeName(theme)}',
              child: Container(
                height: 48,
                padding: const .symmetric(horizontal: 16),
                color: const Color(0xFF262626),
                child: Row(
                  children: [
                    const Icon(Icons.contrast, color: Colors.white, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      _themeShortName(theme),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: .w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CatalogNavigation extends StatelessWidget {
  const _CatalogNavigation({
    required this.palette,
    required this.searchController,
    required this.components,
    required this.selectedId,
    required this.onQueryChanged,
    required this.onSelected,
  });

  static const categories = [
    'Content',
    'Inputs',
    'Navigation',
    'Data display',
    'Feedback',
  ];

  final _CatalogPalette palette;
  final TextEditingController searchController;
  final List<ComponentDemo> components;
  final String selectedId;
  final ValueChanged<String> onQueryChanged;
  final ValueChanged<ComponentDemo> onSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.layer,
        border: Border(right: BorderSide(color: palette.border)),
      ),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Padding(
            padding: const .all(16),
            child: CarbonSearch(
              key: const Key('catalog-search'),
              controller: searchController,
              labelText: 'Search components',
              onChanged: onQueryChanged,
            ),
          ),
          Expanded(
            child: components.isEmpty
                ? Padding(
                    padding: const .all(24),
                    child: Text(
                      'No components match this search.',
                      style: TextStyle(color: palette.textSecondary),
                    ),
                  )
                : ListView(
                    padding: const .only(bottom: 24),
                    children: [
                      for (final category in categories)
                        if (components.any(
                          (component) => component.category == category,
                        )) ...[
                          Padding(
                            padding: const .fromLTRB(16, 20, 16, 8),
                            child: Text(
                              category.toUpperCase(),
                              style: TextStyle(
                                color: palette.textSecondary,
                                fontSize: 11,
                                fontWeight: .w600,
                                letterSpacing: .8,
                              ),
                            ),
                          ),
                          for (final component in components.where(
                            (candidate) => candidate.category == category,
                          ))
                            _NavigationItem(
                              component: component,
                              selected: component.id == selectedId,
                              palette: palette,
                              onPressed: () => onSelected(component),
                            ),
                        ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.component,
    required this.selected,
    required this.palette,
    required this.onPressed,
  });

  final ComponentDemo component;
  final bool selected;
  final _CatalogPalette palette;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected ? palette.selected : Colors.transparent,
        child: InkWell(
          key: Key('component-${component.id}'),
          onTap: onPressed,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: selected
                      ? const Color(0xFF0F62FE)
                      : Colors.transparent,
                  width: 4,
                ),
              ),
            ),
            padding: const EdgeInsetsDirectional.only(start: 12, end: 16),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              component.label,
              style: TextStyle(
                color: palette.textPrimary,
                fontSize: 14,
                fontWeight: selected ? .w600 : .w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ComponentPage extends StatelessWidget {
  const _ComponentPage({
    super.key,
    required this.component,
    required this.palette,
  });

  final ComponentDemo component;
  final _CatalogPalette palette;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('component-page-scroll'),
      padding: const .fromLTRB(32, 36, 32, 72),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              Text(
                'COMPONENT  /  ${component.category.toUpperCase()}',
                style: const TextStyle(
                  color: Color(0xFF0F62FE),
                  fontSize: 12,
                  fontWeight: .w600,
                  letterSpacing: .8,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                component.label,
                key: const Key('component-title'),
                style: TextStyle(
                  color: palette.textPrimary,
                  fontSize: 40,
                  height: 1.1,
                  fontWeight: .w300,
                  letterSpacing: -.8,
                ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Text(
                  component.summary,
                  style: TextStyle(
                    color: palette.textSecondary,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Divider(height: 1, color: palette.border),
              for (final example in component.examples)
                _ExamplePanel(
                  key: ValueKey('${component.id}-${example.id}'),
                  example: example,
                  palette: palette,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExamplePanel extends StatelessWidget {
  const _ExamplePanel({
    super.key,
    required this.example,
    required this.palette,
  });

  final ComponentExample example;
  final _CatalogPalette palette;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Padding(
          padding: const .only(top: 28, bottom: 12),
          child: Row(
            children: [
              Container(width: 8, height: 8, color: const Color(0xFF24A148)),
              const SizedBox(width: 10),
              Text(
                example.label,
                style: TextStyle(
                  color: palette.textPrimary,
                  fontSize: 14,
                  fontWeight: .w600,
                ),
              ),
              const Spacer(),
              Text(
                'LIVE',
                style: TextStyle(
                  color: palette.textSecondary,
                  fontSize: 10,
                  fontWeight: .w600,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 152),
          decoration: BoxDecoration(
            color: palette.canvas,
            border: .all(color: palette.border),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              scrollDirection: .horizontal,
              padding: const .all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: (constraints.maxWidth - 48).clamp(
                    0,
                    double.infinity,
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: example.builder(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CatalogStatusBar extends StatelessWidget {
  const _CatalogStatusBar({required this.message, required this.palette});

  final String message;
  final _CatalogPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('catalog-status'),
      height: 32,
      padding: const .symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: palette.layer,
        border: Border(top: BorderSide(color: palette.border)),
      ),
      child: Row(
        spacing: 8,
        children: [
          const Icon(Icons.bolt, color: Color(0xFF0F62FE), size: 14),
          Expanded(
            child: Text(
              message,
              maxLines: 1,
              overflow: .ellipsis,
              style: TextStyle(color: palette.textSecondary, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class _CatalogPalette {
  const _CatalogPalette({
    required this.background,
    required this.layer,
    required this.canvas,
    required this.selected,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
  });

  factory _CatalogPalette.forTheme(CarbonTheme theme) => switch (theme) {
    .white => const _CatalogPalette(
      background: Color(0xFFFFFFFF),
      layer: Color(0xFFF4F4F4),
      canvas: Color(0xFFFFFFFF),
      selected: Color(0xFFE8E8E8),
      border: Color(0xFFE0E0E0),
      textPrimary: Color(0xFF161616),
      textSecondary: Color(0xFF525252),
    ),
    .g10 => const _CatalogPalette(
      background: Color(0xFFF4F4F4),
      layer: Color(0xFFFFFFFF),
      canvas: Color(0xFFF4F4F4),
      selected: Color(0xFFE8E8E8),
      border: Color(0xFFC6C6C6),
      textPrimary: Color(0xFF161616),
      textSecondary: Color(0xFF525252),
    ),
    .g90 => const _CatalogPalette(
      background: Color(0xFF262626),
      layer: Color(0xFF393939),
      canvas: Color(0xFF262626),
      selected: Color(0xFF525252),
      border: Color(0xFF525252),
      textPrimary: Color(0xFFF4F4F4),
      textSecondary: Color(0xFFC6C6C6),
    ),
    .g100 => const _CatalogPalette(
      background: Color(0xFF161616),
      layer: Color(0xFF262626),
      canvas: Color(0xFF161616),
      selected: Color(0xFF393939),
      border: Color(0xFF393939),
      textPrimary: Color(0xFFF4F4F4),
      textSecondary: Color(0xFFC6C6C6),
    ),
  };

  final Color background;
  final Color layer;
  final Color canvas;
  final Color selected;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
}

String _themeName(CarbonTheme theme) => switch (theme) {
  .white => 'White',
  .g10 => 'Gray 10',
  .g90 => 'Gray 90',
  .g100 => 'Gray 100',
};

String _themeShortName(CarbonTheme theme) => switch (theme) {
  .white => 'W',
  .g10 => 'G10',
  .g90 => 'G90',
  .g100 => 'G100',
};
