# Radix Themes reference captures — component-gap plan comparison log

Captured 2026-08-03 with Chrome DevTools MCP, full-page PNG, 1280 px viewport,
site dark appearance. One capture per Radix Themes docs page relevant to the
planned PRs, for later feature/visual comparison against the Flutter
implementations.

## Authority caveat (important)

These are captures of the **live radix-ui.com site**, which tracks the latest
Radix Themes release. The repository's parity authority remains the pinned
`@radix-ui/themes@3.3.0` artifact
(`packages/remix/reference/radix_themes_3_3_0/manifest.json`, integrity-hashed)
and its committed Chromium fixture (`families-light.png`, computed styles).
Use these captures to compare feature coverage and overall look; use the
pinned artifact for any exact value dispute. If a capture disagrees with the
pinned CSS, the pinned CSS wins.

## Fidelity stance

The implementation goal recorded across the plans is: **match Radix closely
with the simplest implementation; do not over-engineer for pixel-perfection.**
Exact where cheap (tokens, metrics, the two vector glyph paths), recorded
approximation where exactness would cost real machinery. The "recorded
deltas" column below lists the deliberate deviations already written into the
plans — when comparing screenshots later, these are expected differences, not
bugs.

## Capture index

| Capture | Radix Themes component? | Plan(s) | Key features shown on the page | Recorded deltas (deliberate, keep simple) |
| --- | --- | --- | --- | --- |
| `dropdown-menu.png` | Yes | pr-01, pr-07 | Checkbox items, radio groups, nested submenus, shortcuts in the trailing slot, size 1–2, solid/soft, colors | None for glyphs — check/chevron use the exact pinned nine-unit paths. PR 1 ships a neutral indicator (temporary recorded approximation); PR 7 applies exact Fortal color/gutter geometry. |
| `skeleton.png` | Yes | pr-02, pr-07 | Loading default, text/child-shaped placeholders, 1000 ms pulse | Reduced-motion honoring is a Flutter adaptation (upstream has none). No shimmer, no progress semantics — same as upstream. |
| `checkbox-group.png` | Yes | pr-03, pr-07 | Controlled values, sizes/variants/colors, label rows, one-tab-stop keyboard model | Behavior is mapped; **visuals intentionally unmapped this series** — options reuse the Fortal Checkbox recipe, layout stays caller-owned. Audited via the checker-enforced `unmappedUpstreamFamilies` record in PR 7. |
| `segmented-control.png` | Yes | pr-04, pr-07 | Sizes 1–3, surface/classic variants, radius options, equal-width segments | No sliding/animated indicator, no separators, no active-label crossfade in v1 (manifest approximations). Radius comes from `FortalScope`, not a per-widget prop, matching existing wrappers. |
| `text-area.png` | Yes | pr-05, pr-07 | Sizes 1–3, classic/surface/soft, resize prop | No browser drag-resize handle; `minLines`/`maxLines`/constraints are the layout API, and default `maxLines: null` auto-grows. |
| `data-list.png` | Yes | pr-06, pr-07 | Horizontal aligned label column, vertical stacking, sizes 1–3, item alignment | Data-driven item API instead of compositional Root/Item/Label/Value; no per-label color/width props (global `highContrast` only); no leading trim; no responsive prop DSL. |
| `table.png` | Yes (visual baseline only) | pr-09 | Sizes 1–3, surface/ghost, gray dividers, bold column headers, panel radius | Sorting, selection, pagination, hover actions are **Flutter/Fortal extensions** — Radix Table is passive. Row-header cells deferred (no Flutter role). |
| `text.png` | Yes | pr-08 | Sizes 1–9, four weights, align, truncate/wrap, colors, high contrast | `pretty`/`balance` wrap map to normal wrapping; no `as`/`asChild` polymorphism; responsive props map to ordinary rebuilds. |
| `heading.png` | Yes | pr-08 | Sizes, weights, semantic level vs visual size | Leading trim deferred; same wrap deltas as Text. |
| `code.png` | Yes | pr-08 | solid/soft/outline/ghost variants, sizes, weights, high contrast | Standalone widget (not an inline `TextSpan`); platform font fallback may shift glyph widths; no code semantics role exists in Flutter. |
| `kbd.png` | Yes | pr-08 | classic/soft variants, em-relative sizing | Flutter shadow rasterization tolerance on the six-layer classic stack (all layers kept). |
| `link.png` | Yes | pr-08 | Underline auto/always/hover/none, sizes, weights, high contrast | Native underline placement approximates CSS `text-underline-offset` (measured tolerance recorded); navigation is caller-owned. |
| — (no capture) | **No — Toast is not a Radix Themes component** | pr-10 | — | Tracked as Fortal extension #4. Visual evidence is the dashboard prototype + Fortal design, deliberately with no Radix probe or comparison. |

## How the implementing agent compares

1. Read the executing PR's plan; its Context section names the capture file(s)
   for that component.
2. Implement per the plan, then open the capture next to the playground state
   and compare feature-by-feature: every state/size/variant visible in the
   capture must exist in the Flutter build or appear in the "recorded deltas"
   column above (or the manifest's approximations).
3. For exact values (colors, paddings, radii, shadows), do not measure these
   captures — resolve against the pinned 3.3.0 artifact and the committed
   Chromium fixture (`packages/remix/reference/radix_themes_3_3_0/`).
4. Anything that differs and is not a recorded delta is a real gap — fix it or
   record it in the manifest; never silently drift.
5. These captures live only under `plan/` as planning evidence. Per
   `01-conventions.md`, component PRs still attach fresh manual side-by-side
   screenshots in the PR description and commit no new screenshot binaries to
   the package beyond the existing parity fixture. Captures are dark-appearance;
   the pinned fixture (`families-light.png`) is the light-mode evidence.
