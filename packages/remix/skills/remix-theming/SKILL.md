---
name: remix-theming
description: Set up and configure app-wide theming for the Remix Flutter component library — install a RemixTheme / Fortal (Radix) preset scope, define and wire design tokens (colors, spacing, radii, typography), and handle light/dark mode. Use when a developer wants to set up Remix theming, configure global tokens, apply the Fortal or Radix preset, wrap their app in a theme scope, or asks how Remix theming/tokens/dark mode work app-wide. This is the authority on tokens; for styling one individual component use remix-component-styling, and for converting Material widgets use remix-material-migration.
---

# Remix theming

Configures **app-wide** theming for Remix. Scope: the theme scope that wraps the
app and the design tokens every component reads. Individual component styling is
out of scope — that belongs to `remix-component-styling`.

## Before anything: read the real API

Remix theme class and token names differ between versions. Read
[../shared/find-remix-source.md](../shared/find-remix-source.md) and confirm the
resolved names from `<remix-root>/lib/src/fortal/` and `theme/remix_theme.dart`
before writing code. Do not trust the identifiers below without checking.

## Workflow

1. **Detect existing theming.** Search the app for an existing theme scope:
   ```bash
   grep -rnE 'FortalScope|RemixTheme|FortalTokens' lib/
   ```
   - If one exists → report it and only adjust what the dev asked for. Do not
     scaffold a second scope.
   - If none exists → proceed to scaffold.

2. **Choose the foundation.** Ask (or infer from the request):
   - **Fortal preset** (Radix-based, batteries included) — recommended default.
     Wrap the app *inside* `MaterialApp` with the scope builder confirmed from
     `fortal_theme.dart` (e.g. `FortalScope(accent:, gray:, child:)`), picking
     `accent`/`gray` from the confirmed `FortalAccentColor` / `FortalGrayColor`
     enums.
   - **Custom tokens** — only if the dev has an existing design system to map.

3. **Wire the scope** at the app root so every Remix component inherits it:
   ```dart
   MaterialApp(
     home: FortalScope(          // confirm builder name + params from source
       accent: FortalAccentColor.indigo,
       gray: FortalGrayColor.slate,
       child: const HomeScreen(),
     ),
   );
   ```

4. **Map the dev's tokens** (custom path only). Read `FortalTokens` (or the
   confirmed token class) to see the token surface — colors, spacing, radii,
   typography — and populate it from the dev's existing constants. Prefer token
   references over raw values.

5. **Light/dark mode.** Theme resolution reads brightness from
   `MediaQuery` / `Theme.of(context)` (see `theme/remix_theme.dart`). Wire the
   app's `themeMode`/brightness rather than hardcoding a single mode.

6. **Verify (required).** Run analysis on the files you touched and fix every
   error before declaring done:
   ```bash
   dart analyze lib/main.dart   # or the files changed
   ```
   Analysis failures usually mean a hallucinated name — go back to step 0 and
   confirm against source.

## Handoff

Once a scope exists, tell the dev that per-component styling (referencing these
tokens) is handled by `remix-component-styling`.
