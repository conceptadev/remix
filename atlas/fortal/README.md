# Fortal Atlas capture

This directory is a deterministic, inert capture of the Fortal design system.
Repository readers such as Mix Atlas can inspect it without executing or
compiling Remix source code.

## Scope and provenance

The parity source is the exact npm artifact
`@radix-ui/themes@3.3.0`, integrity
`sha512-I0/h2CRNTpYNB7Mi3xFIvSsQq5a108d7kK8dTO5zp5b9HR5QJXKag6B8tjpz2ITkVYkFdkGk45doNkSr7OxwNw==`.
The tracked parity manifest is
`packages/remix/reference/radix_themes_3_3_0/manifest.json`.

The catalog contains 23 Fortal families and 388 cells in each of the light and
dark themes (776 cells total):

- 20 mapped Radix families: Avatar, Badge, Button, Callout, Card, Checkbox,
  Dialog, Divider, Menu, IconButton, Popover, Progress, Radio, Select, Slider,
  Spinner, Switch, Tabs, TextField, and Tooltip.
- 3 Fortal extensions, excluded from the Radix parity score: Accordion,
  Toggle, and ToggleGroup.

Every family has a light and dark contact-sheet PNG plus a structured Atlas
sidecar. The bundle index covers 152 payload files; `capture.json` is the
integrity envelope for those payloads.

## Artifact model

- `catalog.json` indexes every family and theme.
- `light/` and `dark/` contain the 46 contact sheets and their 46 structured
  sidecars.
- `themes/*.mix.json` contain concrete, resolved Mix token values. Token aliases
  are resolved against the captured runtime theme before encoding.
- `themes/*.remix-surfaces.json` preserve Remix surface-token diagnostics that
  the neutral Mix protocol cannot express: solid and multi-stop gradient fills,
  ordered outer and inset paint shadows, overlays, and backdrop blur.
- `components/button.component.json` and `styles/button/` are the only portable
  component/projection artifact currently emitted. This is a deliberate
  protocol boundary, not evidence that the other 22 families lack raster or
  structured Atlas coverage.
- `protocol/coverage.json` records supported probes and every unsupported
  Button slot or value. In particular, a complete `RemixButtonStyler` and its
  spinner are not claimed to be representable by neutral Mix protocol v1.

Fortal shadow-stroke colors use premultiplied-alpha OKLab mixing, matching the
Radix `color-mix(in oklab, ...)` contract. The independently generated Chromium
fixture under `packages/remix/reference/radix_themes_3_3_0/chromium/` is kept
separate from these Flutter-engine goldens. Resolved colors, geometry, surface
layer order, states, and semantics are exact contract values. Browser and
Flutter screenshots are not compared byte-for-byte: platform glyph rendering
and edge anti-aliasing may differ by at most one 8-bit channel at an edge pixel.

The manifest's `approximations` list records one interaction-model boundary:
`RemixDialog` with `modal: false` changes accessibility route scoping, while
the `RawDialogRoute` remains pointer-modal. It has no visual tolerance. Other
Flutter-native API substitutions and their reasons are documented per family
in that manifest. The sole intentional scope-topology exception is the Atlas
builder: `mix_atlas` owns its internal `MaterialApp`, so `AtlasTheme.builder`
must install `FortalScope` below that app. Production, example, preview, and
test app roots put `FortalScope` above `WidgetsApp` or `MaterialApp`.

## Regenerate and verify

Use the repository's Flutter 3.44.0 FVM pin on macOS:

```sh
fvm dart run melos run atlas:fortal
```

Verify committed output without rewriting it:

```sh
fvm dart run melos run atlas:fortal:check
fvm dart run melos run fortal:parity:check
```

The Chromium reference is regenerated separately from the pinned source:

```sh
cd packages/remix/tool/fortal_parity/chromium
npm install
npm run generate
```
