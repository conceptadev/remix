# Dashboard

A reference product-style dashboard demonstrating Remix's Fortal theme,
components, Mix layouts, and chart recipes built on `mix_chart`.

## Showcase role

This app demonstrates how Fortal components compose into realistic product
flows, with reusable dashboard-owned patterns and focused variant/size
matrices. The [component catalog](../demo/) remains the exhaustive source for
every API state and preview knob; the dashboard is the copyable product
implementation.

## Reference rules

- Gallery axes pass typed values from the Fortal enums that label them. A new
  variant or size therefore becomes a rendered cell instead of silently
  drifting from a parallel label list.
- Variants describe visual treatment. Product intent such as success or danger
  is expressed with a local `AppAccentScope`, which overrides only the
  accent and inherits the active brightness, gray, radius, scaling, and panel
  settings.
- Meaningful product and interactive badge labels opt into high contrast
  because the selectable light accent scales do not all guarantee WCAG AA for
  the default soft label. Variant matrices preserve the component defaults.
- Product card layouts and gallery matrices use Mix `GridBox`. Matrices combine
  fixed-width columns with implicit content-sized rows so each recipe sample
  determines its row height.

## Live demo

[Open the Fortal dashboard](https://conceptadev.github.io/remix/dashboard/).

## Preview

### Desktop

![Fortal dashboard overview on desktop](screenshots/overview-desktop.png)

### Compact

![Fortal dashboard overview at the compact breakpoint](screenshots/overview-compact.png)

From the repository root:

```sh
fvm dart run melos bootstrap
cd apps/dashboard
fvm flutter run -d macos
# or: fvm flutter run -d chrome
```
