# Agent worksheets and shipped recipes

## Reconciled ownership

The eight files in `components/` are anatomy and behavior reference worksheets.
Their `recipe_measurements` record the benchmark from which the slots were
identified, **not acceptance dimensions for the shipped presets**. Shared
behavior under `lib/src/agent` supplies those slots. The authored bundles under
`lib/src/default/recipes` and `lib/src/fortal/recipes` supply the shipped styles.

The [package-boundary ADR](../docs/adr/agent/0001-package-boundary.md) and
[registry-source ADR](../docs/adr/fortal/0002-registry-source.md) remain the
architectural contract. A worksheet difference alone is not justification to
change installed consumer visuals.

## Current differences retained deliberately

| Surface | Shipped recipe decision versus reference benchmark |
|---|---|
| Activity | 200px maximum viewport and 6px item spacing, rather than the reference fixed 208px well. Disclosure content inset is cleared so the ledger owns its layout. |
| Answer | Uses the selected preset's card, disclosure, and ghost action controls. Action spacing is 6px with 8px top padding, rather than the reference 2px/12px. |
| Composer | Uses a 12px card inset, a 56px field minimum, 8px toolbar spacing, and 40px submit/stop controls. The reference's 32px controls are not substituted into the existing responsive demo. |
| Execution | Uses preset card/disclosure controls plus a separately styled output well and action row. Benchmark typography and motion are not a cross-preset parity contract. |
| Message | Uses preset card/button controls, a 640px content maximum, and a 72px collapsed-height recipe. Host-rendered content remains app-owned. |
| Permission | Uses preset buttons, data-list, card, and disclosure styles. The host chooses status and callbacks; the recipe does not implement authorization policy. |
| Plan | 220px maximum viewport and 6px item gap instead of reference 248px/10px. The two presets share anatomy but use their own foreground/accent tokens. |
| Transcript | 16px item spacing and 12px right viewport inset; the application supplies bounded available height and conversation state. |

Fortal recipes use theme color tokens and compose the existing Fortal control
recipes. Some Agent-specific dimensions remain numeric. Converting every
number to a scale token would change scaling behavior and requires a separate
visual contract and responsive review; it is not a registry-cutoff fix.

## Change and verification rules

- Fix behavior in `lib/src/agent`; fix preset style in its authored recipe.
- Keep caller overrides merged last and child-control styles unresolved until
  the child renders its own interactive state.
- Do not edit derived registry templates or installed consumer mirrors by hand.
- Regenerate with `dart run tool/build_registry.dart`, reinstall affected items,
  and run registry/dogfood checks plus recipe and consumer tests.
- Treat a proposed reference-parity redesign as explicit new work; do not silently
  update these benchmarks to make an implementation appear conformant.

The existing dashboard recipe-contract tests exercise caller override and child
hover behavior. Dashboard chat tests cover navigation, theme changes, permission,
retry, Stop, copying, and responsive state retention. These establish behavior,
not pixel equivalence to the reference worksheets.
