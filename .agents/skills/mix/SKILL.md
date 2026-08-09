---
name: mix
description: Use when working with the Mix Flutter styling framework in this repository, including specs, stylers, Prop values, Mix annotations and code generation, fluent APIs, variants, animations, tokens, modifiers, or directives.
---

# Mix Framework

Type-safe styling system for Flutter that separates style semantics from widgets.

Confirm the actual Mix version before applying patterns. In this repository,
read `packages/remix/pubspec.yaml` and `packages/remix_fortal/pubspec.yaml`.

## Source of Truth

When working on Mix code, resolve ambiguity in this order:

1. **Local source code** — always highest priority when the repo is present
2. **Dart MCP tools** (`hover`, `signature_help`, `resolve_workspace_symbol`) — if connected and dependencies resolved
3. **Version-pinned docs** — [Mix website](https://fluttermix.com), [pub.dev/packages/mix](https://pub.dev/packages/mix)
4. **This skill** — patterns, invariants, and workflows documented here
5. **If still unclear** — state uncertainty and ask the user to confirm

## Core Mental Model

```
Spec (immutable resolved data) ← Styler (fluent builder with Prop<V>) → Widget (renders Spec)
```

Resolution pipeline: `StyleWidget` → `StyleBuilder` → merge active variants → resolve `Prop<V>` fields (tokens, Mix types, directives) → produce `StyleSpec<S>` → animate → `widget.build(context, spec)` → provide `StyleSpec` → apply widget modifiers.

## Widget Reference

| Styler | Spec | Widget | Flutter Equivalent |
|--------|------|--------|--------------------|
| `BoxStyler` | `BoxSpec` | `Box` | `Container` |
| `TextStyler` | `TextSpec` | `StyledText` | `Text` |
| `FlexStyler` | `FlexSpec` | — (layout) | `Flex`/`Row`/`Column` |
| `FlexBoxStyler` | `FlexBoxSpec` | `FlexBox`/`RowBox`/`ColumnBox` | `Column`/`Row` + `Container` |
| `StackStyler` | `StackSpec` | — (layout) | `Stack` |
| `StackBoxStyler` | `StackBoxSpec` | `StackBox` | `Stack` + `Container` |
| `IconStyler` | `IconSpec` | `StyledIcon` | `Icon` |
| `ImageStyler` | `ImageSpec` | `StyledImage` | `Image` |

Interactive: `Pressable` (gesture + focus + mouse), `PressableBox` (Pressable + Box).

## Key Patterns

### Write Mix, Not Raw Flutter

When styling a Mix surface, keep visual semantics in Stylers instead of nesting raw Flutter widgets for styling concerns.

| Instead of | Write |
|------------|-------|
| `Container(color: ..., padding: ..., child: ...)` | `Box(style: BoxStyler().color(...).paddingAll(...), child: ...)` |
| `Text('Label', style: TextStyle(...))` | `StyledText('Label', style: TextStyler().fontSize(...).color(...))` |
| `Icon(Icons.star, color: ..., size: ...)` | `StyledIcon(icon: Icons.star, style: IconStyler().color(...).size(...))` |
| `Theme.of(context).colorScheme.primary` in styles | `ColorToken` values from `MixScope`, then `BoxStyler().color($primary())` |
| `Theme.of(context).textTheme.bodyMedium` in styles | `TextStyleToken` values from `MixScope`, then `TextStyler().style($body.mix())` |
| Nested `Padding` / `Align` for a styled widget | Styler methods such as `.paddingAll(16)` and `.alignment(Alignment.center)` |

### Top-Level Rule

Start top-level declarations with the relevant concrete Styler constructor (`BoxStyler()`, `TextStyler()`, `IconStyler()`, etc.), then chain. Static factories are valid API but discouraged for top-level declarations; bare dot-shorthand is only for typed nested contexts. In nested typed contexts (variants, state callbacks), use bare shorthand `.method()` instead. See `references/styler-api-policy.md` for the complete policy.

### Fluent Chaining (recommended)

```dart
final style = BoxStyler()
    .color(Colors.blue)
    .size(100, 100)
    .padding(.all(16))
    .borderRadius(.circular(8));

Box(style: style, child: child)
```

### Variants (context-aware styling)

```dart
// Bare shorthand in nested typed contexts
final style = BoxStyler()
    .color(Colors.white)
    .onDark(.color(Colors.black))
    .onHovered(.color(Colors.blue));
```

### Implicit Animation

```dart
final style = BoxStyler()
    .color(Colors.black)
    .onHovered(.color(Colors.blue).scale(1.2))
    .animate(.easeInOut(300.ms));
```

### Composition via Merge

```dart
final base = BoxStyler().padding(.all(16)).borderRadius(.circular(8));
final elevated = BoxStyler().elevation(ElevationShadow(4));
final combined = base.merge(elevated);
```

## Critical Rules

- **Specs are immutable** — always `@immutable final class`, use `copyWith()` for changes
- **Styler value fields generally use `$` prefix** — `$padding`, `$alignment`, etc. with `Prop<V>?`; exceptions include directives, variants, modifier, and animation metadata
- **Generated Stylers have `.create()` and default constructors** — many also expose generated factory constructors
- **Prefer `@MixableSpec(target: Widget.new)`** — `@MixableStyler` is legacy/deprecated
- **Use `@MixWidget` for generated widgets from style factories** — it wraps top-level `Style<S>` variables or functions
- **Use `@MixableModifier` for generated modifiers** — it emits the modifier contract mixin and `ModifierMix` class
- **Run codegen after annotated API or recipe changes** — `melos run generate`
- **Prop merge semantics** — regular values: last wins (replacement); Mix values: accumulated merge
- **Variant priority** — ContextVariant/NamedVariant first → StyleVariation second → WidgetStateVariant last (highest)

## Repository Commands

```bash
melos bootstrap                    # Install workspace dependencies
melos run generate                 # Regenerate Remix and Fortal sources
melos run generate:check           # Fail on generated-source drift
melos run test:flutter             # Run package Flutter tests
melos run fortal:parity:check      # Verify the Fortal/Radix contract
melos run docs:check               # Validate documentation and examples
melos run ci                       # Run the complete workspace gate
```

**Pre-commit verification:**
```bash
melos run ci
```

## Related Packages

| Package | Purpose |
|---------|---------|
| `mix` | Core framework |
| `mix_annotations` | `@MixableSpec`, `@MixWidget`, `@MixableModifier`, `@MixableStyler`, `@Mixable`, `@MixableField` |
| `mix_generator` | `build_runner` generator producing `*.g.dart` mixins |
| `mix_lint` | Analysis server plugin with Mix-specific lint rules |
| `mix_tailwinds` | Tailwind-style utility layer (experimental) |
| `remix` | Theme-free components built with Mix and Naked UI |
| `remix_fortal` | Radix Themes-inspired tokens, recipes, and generated Remix wrappers |

## References

Consult these for detailed guidance:

- **[`references/architecture.md`](references/architecture.md)** — Spec, Styler, Prop<V>, resolution pipeline, StyleWidget
- **[`references/styler-api-policy.md`](references/styler-api-policy.md)** — Top-level rule, dot-shorthand policy, factory constructor table, chain-only methods
- **[`references/fluent-api.md`](references/fluent-api.md)** — Chaining, style mixins, sizing decision tree, composition
- **[`references/code-generation.md`](references/code-generation.md)** — Annotations, generated output, BoxSpec reference impl
- **[`references/examples.md`](references/examples.md)** — Worked end-to-end examples
- **[`references/variants.md`](references/variants.md)** — NamedVariant, ContextVariant, WidgetStateVariant, built-in methods
- **[`references/animations.md`](references/animations.md)** — Implicit, Phase, Keyframe animations
- **[`references/design-tokens.md`](references/design-tokens.md)** — MixScope, token types, theming
- **[`references/widget-modifiers-directives.md`](references/widget-modifiers-directives.md)** — .wrap(), modifiers, directives
- **[`references/development-workflow.md`](references/development-workflow.md)** — Creating specs, codegen workflow, monorepo
- **[`references/testing.md`](references/testing.md)** — resolvesTo matcher, MockBuildContext, merge testing
