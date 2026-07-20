# Component playbook

How to implement one design-system component on Remix, and the Remix/Mix
behaviors that have produced real bugs in first reviews of packages built
this way. Code sketches use a placeholder system named "Acme".

## 1. Worksheet first

Create `specs/components/<component>.yaml` before writing code:

```yaml
component: <Source name>              # e.g. Button
flutter_name: <Sys><Name>             # e.g. AcmeButton
status: planned | implemented (vertical slice) | complete

source:
  ref: <pinned commit / doc version / brief section>
  files: [<source style/behavior files, pages, or frames>]
  docs: <official component page, if any>

anatomy:            # slots, child structure
kinds:              # the system's variants — NEVER Fortal/Remix names
sizes:              # supported range + default + contextual inheritance
states:             # rest/hover/active/focus/disabled/loading/…
tokens:
  role: [...]       # semantic tokens consumed
  component: [...]  # component-scoped tokens consumed
  type: [...]
  layout: [...]
non_token_measurements:   # each with its source — keep this list short
behavior:           # keyboard, focus, pointer, screen reader, RTL
approximations:     # every deviation from the source, honestly stated
```

The worksheet is the review artifact: a reviewer checks the code against the
worksheet and the worksheet against the design source.

## 2. Wrapper decision rule

Use a generated `@MixWidget` wrapper **only if all of**:

- the source anatomy matches the Remix component's anatomy;
- the generated constructor reads in the target system's vocabulary;
- no Remix-only public types leak;
- required states already exist in the underlying widget;
- semantics/keyboard behavior match.

Otherwise write a **hand-written facade**: a `StatelessWidget` in the target
vocabulary that builds a `*Styler` recipe and invokes its `.call(...)`.

With `mix_generator` 2.1.2 or newer, a generic `call<T>()` target is not by
itself a reason to hand-write the facade. `@MixWidget` copies the styler
`call<T>()` type parameters onto the generated widget, so callers normally
infer `T` from items, values, and callbacks. The annotated recipe function
itself must remain non-generic.

The generator contract is intentionally convention-based:

- annotate a top-level styler variable or a non-generic top-level function
  returning `Style<S>`;
- factory parameters become constructor parameters, followed by the styler's
  `call()` parameters; `Key? key` is forwarded when `call()` exposes it;
- factory and `call()` parameter names must not collide. State-dependent
  recipes often collide on names such as `loading`; use a hand-written facade
  when the public widget needs that same input for both styling and behavior;
- to generate `Widget.solid(...)`, `Widget.soft(...)`, and similar named
  constructors, use a **named, non-nullable enum parameter named exactly
  `variant`** on a function recipe. Required positional parameters, other
  parameter names, nullable enums, and non-enum types do not produce named
  variant constructors. Optional positional factory parameters are rejected
  entirely;
- each visible enum value becomes a named constructor and carries its
  dartdoc/deprecation metadata into generated code. If an enum value has the
  same name as a generated widget type parameter, the generator suppresses
  all named variant constructors to keep the output valid;
- use a lower-camel recipe name ending in `Style`, or pass
  `@MixWidget(name: '<System><Component>')` explicitly.

```dart
enum AcmeSelectVariant { surface, soft, ghost }

@MixWidget(name: 'AcmeSelect')
RemixSelectStyler acmeSelectStyle({
  AcmeSelectVariant variant = .surface,
}) => switch (variant) {
  .surface => _surfaceSelectStyle(),
  .soft => _softSelectStyle(),
  .ghost => _ghostSelectStyle(),
};
```

Generation from a standalone package that returns Remix stylers should still
be proven with a package-local spike before committing to the public API.

For that spike, add the generator surface explicitly:

```yaml
dependencies:
  remix: ^1.0.0
  mix_annotations: ^2.1.2

dev_dependencies:
  build_runner: ^2.10.1
  mix_generator: ^2.1.2
```

Import `mix_annotations`, add a `part '<component>.g.dart';` directive to the
library containing the annotated styler recipe, then run:

```bash
dart run build_runner build
```

Commit the generated part and prove regeneration is a no-op before relying on
the wrapper in the public API.

## 3. Recipe shape

This Button recipe is for a hand-written facade: its `loading` styling input
collides with `ButtonStyler.call(loading: ...)`, so it cannot be exposed
unchanged through `@MixWidget`.

```dart
// Pure function of a few enums → memoize; stylers are immutable value objects.
final Map<(Kind, Size, bool), ButtonStyler> _styleCache = {};

ButtonStyler acmeButtonStyle({Kind kind, Size size, bool loading = false}) {
  final clamped = size.clampTo(Size.sm, Size.x2l);   // worksheet's supported range
  return _styleCache.putIfAbsent((kind, clamped, loading), () {
    final base = _baseStyle(clamped);                 // shared height/padding/label/focus
    return switch (kind) { ... };                     // per-kind fills/borders/states
  });
}
```

- Base style: geometry (height from the size scale, paddings from spacing
  tokens), label typography **via the type token** —
  `TextStyler().style(AcmeTokens.bodyCompact01.mix())` — never hand-copied
  font metrics "kept in sync" with a token.
- States as variants: `.onHovered(...)`, `.onPressed(...)`, `.onFocused(...)`,
  `.onDisabled(...)`, each a small styler merged over the base.
- The widget resolves contextual size with the three-level fallback:
  `explicit ?? LayoutScope.maybeOf(context)?.size ?? <system default>`.

## 4. Remix/Mix gotchas (each has caused a real bug)

### Loading is the disabled state

`RemixButton._isEnabled => enabled && !loading && onPressed != null`. Passing
`loading: true` forces `WidgetState.disabled`, so **the `.onDisabled` variant
styles the loading appearance**. If the design system's loading button keeps
its kind colors (many do), parameterize the recipe on `loading` and build
the disabled variant accordingly:

```dart
final disabledStyle = loading
    ? ButtonStyler().color(fill()).spinner(...)   // keep kind visuals
    : _disabledTreatment();                            // real disabled gray
```

Also: pass `enabled: enabled` through untouched — Remix already folds in the
null-`onPressed` case; duplicating the rule in the facade drifts.

### Focus rings: use foregroundDecoration

`onFocused(borderAll(...))` *replaces* the kind's base border and, because
Flutter containers pad by border width, **shifts layout on focus**. Paint the
ring over the content instead — no layout change, base border intact:

```dart
.onFocused(ButtonStyler().foregroundDecoration(BoxDecorationMix(
  border: BoxBorderMix.all(BorderSideMix(color: AcmeTokens.focus(), width: 2.0)),
)))
```

### Per-state foreground pairs

When hover/active change the fill, set the matching foreground **in the same
variant**. A classic bug: a pressed fill hardcoded to a neutral token while
hover had already set a white foreground — illegible text on press.
Parameterize shared state helpers on `(hoverFill, hoverText, activeFill,
activeText)` rather than sharing one hardcoded pressed treatment.

### Layout prepends outside the recipe's control

`RemixButton` prepends `mainAxisSize(.min)` to the styler. Shrink-wrapped
buttons ignore `mainAxisAlignment`; it only matters when the parent forces a
width. Set alignment for the width-constrained case if the source system
specifies it, and don't fight the min-size default.

### One-icon alignment is style-driven

`ButtonStyler.iconAlignment(IconAlignment.start|end)` controls which
side of the label a **single** icon occupies. It applies regardless of whether
the caller supplied `leadingIcon` or `trailingIcon`. When both icons are
present, Remix deliberately preserves leading → label → trailing order. Test
both the one-icon override and the two-icon stability if the target system
exposes this behavior.

### Misc

- `num.clamp()` returns `num` — `.toInt()` before using as an index.
- Widgets that must work without `MaterialApp` ancestors: check what the
  test harness provides vs. what the example provides.
- Radius/elevation: if the system doesn't define a scale (some systems use
  square corners throughout), **don't invent one** — `Radius.zero` is a
  legitimate design value.

## 5. Component tests

Minimum per component:

```dart
// Rendering + interaction
'renders its label / fires onPressed / disabled when onPressed null'

// The kind × theme matrix builds
'every kind builds across all themes'

// Measured geometry — catches default-size regressions
expect(tester.getSize(find.byType(AcmeButton)).height, 48.0);

// Contextual size inheritance AND the no-scope default (different values!)

// Loading visuals — container fill is the kind color, not disabled gray
// (find the DecoratedBox with a colored BoxDecoration and assert its color)
```

Test harness notes:

- Pump inside the system scope: `AcmeScope(child: MaterialApp(...))` or
  vice versa — put the scope where the example puts it.
- **`pumpAndSettle` hangs forever with an animating spinner** — use
  `tester.pump(const Duration(milliseconds: 100))` in loading tests.
- Prefer asserting on token-derived expected values (a `const Color(...)`
  documented with its token name) so a token regeneration that changes values
  fails visibly with a reviewable diff.
