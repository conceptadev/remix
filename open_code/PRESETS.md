# Presets: application-owned source

## Current implementation

`remix_cli` bundles two presets, `default` and `fortal`. Both registry manifests
and all templates are derived from analyzer-checked Dart by
`tool/build_registry.dart`; none of the templates are hand-authored.

```text
registry_source/                 one private workspace package
  lib/src/default/              default theme, components, Agent recipes
  lib/src/fortal/               Fortal theme, components, Agent recipes
  lib/src/agent/                shared Agent behavior, models, support
packages/remix_cli/lib/src/registry/
  default/                     derived registry.yaml and templates/
  fortal/                      derived registry.yaml and templates/
```

The accepted [registry-source ADR](../registry_source/docs/adr/fortal/0002-registry-source.md)
records the hard cutoff. The old package names are not consumer dependencies.
Agent behavior stays private during authoring and installs as editable source;
it is not a separately published runtime package.

## Consumer contract

A preset is chosen once at initialization. Theme tokens and component variants
belong to that preset, so a consumer cannot mix the two preset trees.

```shell
dart run remix_cli:remix init --prefix Acme --preset fortal
dart run remix_cli:remix add button
dart run remix_cli:remix add composer_recipe
```

```yaml
schema: 2
prefix: Acme
preset: fortal
paths:
  ui: lib/ui
```

Schema 1 configurations continue to select `default`. Installed type names and
token IDs use the consumer prefix, for example `AcmeButton` and `acme.accent.9`.
`Fortal` is an authoring prefix, not a required installed prefix; the review
catalog deliberately chooses it as its consumer prefix.

A recipe installs its dependency closure, not the entire catalog. The eight
Agent surfaces (`activity`, `answer`, `composer`, `execution`, `message`,
`permission`, `plan`, `transcript`) can install bare or through their
`*_recipe` bundles. Shared `models` and `support` install transitively.

Installed Dart imports the public `remix` API, not `registry_source`.
`mix_chart` and `remix_ui_icons` remain opt-in hosted dependencies of the items
that use them. Items with generated parts declare the generation dependencies;
the consumer generates its own adapters rather than copying authoring outputs.

When installed source uses `@MixableSpec`, the CLI enables the supported
spec-styler builder in the consumer's `build.yaml`. A new builder is scoped to
literal installed paths. Existing all-source settings remain all-source;
existing filters are extended only for missing installed paths. Explicit
exclusions, disabled builders, or competing target ownership fail preflight.
Both `$default` and package-named default targets are supported. Dry-run and
diff show proposed changes without writing them.

## Authoring and derivation

Edit Dart under `registry_source/lib/src/`, never `.tmpl` output. Default uses
the authoring word `Vanilla`, Fortal uses `Fortal`, and shared behavior uses
`Agent`. The builder checks prefix round trips and rewrites shared Agent
imports to their installed relative paths. Relative source imports determine
registry dependencies; generated parts determine adapter targets.

Fortal's Radix color table remains pinned source with a parity contract. Its
internal theme barrel excludes the unprefixed color-table globals from the
consumer's public barrel. Hosted dependency floors are shared through the
default registry and checked for drift.

```shell
dart run melos run open-code:registry:build
dart run melos run open-code:registry:check
```

The build command derives both presets. The check runs builder tests and
compares the complete output trees, including unexpected or missing files.
`--preset default` or `--preset fortal` selects one preset when invoking
`tool/build_registry.dart` directly.

## Repository consumers

- `apps/playground`: full default catalog, prefix `Playground`; its indigo
  theme customization is declared in the dogfood checker.
- `apps/demo`: non-Agent Fortal review catalog, prefix `Fortal`.
- `apps/dashboard`: full Fortal catalog including Agent surfaces and recipes,
  prefix `Ui`. Workspace → Chat demonstrates the eight surfaces together.

All three consume installed source. Dashboard pages and its simulated runner
remain application-owned; neither a full dashboard template nor a composed
`chat` item is currently bundled.

## Verification and release

```shell
dart run melos run ci
```

CI includes analysis, clean generation, formatting, registry derivation,
parity, docs, package tests, installed-source comparisons, and fresh checkout
consumers for both presets. Passing checkout checks does not establish hosted
release installability.

[RELEASING.md](RELEASING.md) describes package dry-runs, hosted runtime checks,
CLI publication, and verification of published registry assets. Discontinuing
the old hosted Fortal package is a release action after those checks, not part
of the source-tree migration.

## Separate follow-ups

- In-place preset switching and initialization theme knobs.
- A composed chat registry item or a full-dashboard template.
- Deliberate visual changes beyond the existing Agent recipes. The
  [worksheet reconciliation](../registry_source/specs/README.md) distinguishes
  reference measurements from shipped defaults.

The original five-commit preset plan is preserved in Git history; it is not a
pending execution checklist for this implementation.
