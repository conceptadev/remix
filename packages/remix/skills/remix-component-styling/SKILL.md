---
name: remix-component-styling
description: Build the chainable style for a single Remix Flutter component — the RemixX styler chain (color, padding, border radius), state variants (onHovered/onPressed/onFocused/onDisabled), and animations, referencing the app's existing theme tokens instead of hardcoding values. Use when a developer wants to style or restyle one Remix component instance, make a RemixButton/RemixCard/etc. look a certain way, add hover/pressed/focused/disabled states, or add animation to a component. For app-wide theming and tokens use remix-theming; for converting Material widgets to Remix use remix-material-migration.
---

# Remix component styling

Builds the style chain for **one component instance**. Scope: the per-component
styler class and its chainable methods. App-wide theme setup is out of scope —
that belongs to `remix-theming`.

## Before anything: read the real API

Styler class names are inconsistent (`RemixButtonStyler` vs `RemixCardStyle` vs
the three `RemixSelect*Style` classes) and methods vary per component and version.
Read [../shared/find-remix-source.md](../shared/find-remix-source.md) and confirm
the exact class name and available methods for THIS component from
`<remix-root>/lib/src/components/<name>/` before writing code.

## Workflow

1. **Identify the component and confirm its styler class**
   (find-remix-source §3) and the methods it actually exposes (§4).

2. **Prefer theme tokens over raw values.** Check for an existing theme scope:
   ```bash
   grep -rnE 'FortalScope|RemixTheme|FortalTokens' lib/
   ```
   - If a theme exists → reference its tokens rather than hardcoding colors /
     spacing / radii.
   - If no theme exists → say so and point the dev to the `remix-theming` skill.
     Only hardcode values if the dev explicitly wants a standalone one-off.

3. **Build the chain.** Start from the confirmed empty styler and chain the
   confirmed methods. State variants take **another styler instance**, not a
   callback:
   ```dart
   final style = RemixButtonStyler()   // confirm class name from source
     .paddingX(16)
     .paddingY(10)
     .color(/* theme token */)
     .borderRadiusAll(const Radius.circular(8))
     .onHovered(RemixButtonStyler().color(/* darker token */))
     .animate(AnimationConfig.spring(300.ms));
   ```

4. **Attach to the widget** via its `style:` parameter (confirm the widget's
   constructor args, find-remix-source §5).

5. **Verify (recommended).** Run analysis on the touched files and fix every
   error before finishing:
   ```bash
   dart analyze <changed files>
   ```
   A failure here usually means a hallucinated method — reconfirm from source.

## Notes

- Only use methods you confirmed exist for that specific component; the button's
  helpers are not guaranteed to exist on other components.
- Mix primitives (`AnimationConfig`, `EdgeInsetsGeometryMix`, …) come through
  `package:remix/remix.dart`.
