# Reference showcases

Use this reference when a Remix/Fortal app must be a canonical example rather
than only a visually convincing demo. A strong showcase proves two different
things without confusing them:

- **Product examples** show realistic composition, reuse, semantics, and
  interaction.
- **Coverage galleries** expose the supported component variants, sizes, and
  exceptional states without hiding defaults.

One app can contain both, but each section keeps its own contract.

## Product examples

Prefer Fortal presets and ordinary composition. Add an app-owned wrapper only
when it names a repeated product concept or centralizes a real policy, such as
a status badge, action menu, or disclosure affordance. A wrapper that merely
renames one Fortal constructor makes the example harder to learn from.

Use the extension points owned by the component:

- Build rich menu visuals with `RemixMenuTrigger.builder`, even when the menu
  is `FortalMenu`. The trigger is a configuration object, not a widget, and
  there is no separate `FortalMenuTrigger`.
- Build a disclosure indicator with `FortalDisclosure.triggerBuilder` and
  `state.isExpanded`. Return visual content, not another button; the
  disclosure keeps the interaction and semantics.
- Preserve Remix behavioral roots such as `RemixTabs` and
  `RemixAccordionGroup` around Fortal-styled children.

Keep repeated policy in the smallest app-owned component. Do not create a
parallel component library inside the example.

## Theme and contrast

Keep one correctly placed outer `FortalScope` around the showcase's Navigator
and Overlay, following the host-specific placement in the main skill. Resolve
showcase chrome from `FortalTokens` or other active Mix tokens rather than
choosing parallel hard-coded palette values.

Use a nested `FortalScope(accent: ..., hasBackground: false)` when a product
concept carries a semantic accent. Let it inherit brightness, gray, radius,
scaling, and panel settings from the outer scope. Do not encode semantic
meaning by inventing component variants or hard-coding palette values.

`highContrast` is a content decision, not an app-wide default:

- Enable it for meaningful product labels when the selected soft accent scale
  would otherwise be too weak, especially status or interactive badges.
- Preserve the component default in variant matrices. A gallery should reveal
  the real default rather than silently changing every specimen.
- If contrast itself is under review, display default and high-contrast states
  as an explicit comparison axis.

## Coverage galleries

Derive axes from the public enum values whenever the gallery promises complete
coverage. Keep values, labels, and cells connected through typed data instead
of parallel lists:

```dart
GalleryMatrix<FortalButtonVariant, FortalButtonSize>(
  rows: FortalButtonVariant.values,
  columns: FortalButtonSize.values,
  rowLabelBuilder: (value) => value.name,
  columnLabelBuilder: (value) => value.name,
  cellBuilder: (context, variant, size) => FortalButton(
    variant: variant,
    size: size,
    onPressed: () {},
    label: 'Button',
  ),
)
```

This keeps newly added enum values visible and prevents labels from drifting
away from the specimens. Use named Fortal constructors in product code when a
variant is fixed; the unnamed constructor is appropriate here because a
matrix deliberately selects variants at runtime.

A two-dimensional comparison is a good use of Mix `GridBox`: declare the
label column and specimen columns explicitly and allow implicit rows to size
to their content. Use the project's Mix skill or installed Mix source for the
exact `GridBox` API. A `Wrap` remains better for a simple one-dimensional set.

Render the underlying `Fortal*` widget directly in coverage cells. Product
wrappers belong in a separate section so they do not obscure the component's
actual constructor, defaults, or public axes.

## Verification

- Assert or test that a matrix builds `rows.length * columns.length` specimen
  cells and derives its axes from the intended public enums.
- Exercise disabled, loading, validation, indeterminate, expanded, and
  interactive states separately when they are not enum axes.
- Give icon-only controls, menus, grouped choices, progress, and charts
  meaningful semantics; do not count visible text elsewhere as their label.
- Test custom menu and disclosure visuals through the supported builder APIs
  so a nested interactive trigger cannot regress in later refactors.
- Run the showcase in each supported brightness and with representative accent,
  gray, radius, and scaling settings. Nested accent scopes must inherit all
  unrelated settings.
- Confirm overlay and route content remains below the outer `FortalScope` and
  has the required caller-owned `Overlay` or `Navigator`.

The app is reference-quality when readers can distinguish library API,
product-owned policy, and gallery infrastructure by looking at the code.
