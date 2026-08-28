# Clean-sheet decision: application-owned UI on Remix

## The problem

Remix deliberately ships behavior without a theme. An application can use the
opinionated `remix_fortal` preset, or it can own a design language. Owning the
design language used to require copying a theme and hand-maintaining wrappers
that could fall behind the Remix constructor surface.

The MVP asks a narrower question: can an application own Theme and Button
source, keep Remix as the maintained behavior dependency, and receive a
generated forwarding adapter without adopting Fortal?

## Decision

Yes. `remix_cli` installs authored Theme and Button source into the application,
and `@MixWidget` generates the forwarding adapter there. The application edits
the visual recipe; Remix still handles the difficult behavioral contract.

The initial catalog contained only two items:

```text
theme -> button
```

Button depends on Theme. Installing Button resolves that graph in a stable
order, adds its hosted dependencies, exports the authored files, and generates
`button.g.dart` in the consumer.

**Since:** the catalog has grown to twenty-six components on the same two
mechanisms — one authored file plus one generated part per item, every item
depending on `theme`. Nothing in the decision below changed to accommodate
them: no schema field, no installer branch, and no addition to the fifteen
theme tokens. Compound components (a checkbox group option, a tab bar with its
tabs and panels) fit by declaring more than one `@MixWidget` in the same file.
The current catalog is listed in `docs/open-code.mdx`.

## Ownership boundary

| Remix owns | The application owns |
|---|---|
| Rendering and layout machinery | Semantic tokens and light/dark values |
| Pointer, keyboard, focus, and feedback behavior | Button variants, sizes, and visual recipe |
| Accessibility semantics | Theme, recipe, and instance customization |
| Loading and disabled interaction rules | Installed authored files |
| Naked UI delegation | The generated adapter committed by the app |
| Mix specs, stylers, variants, and resolution | |

Nothing installed by the CLI copies Remix internals or depends on Fortal.
Installed source imports the public `package:remix/remix.dart` surface.

## Why generation is part of the consumer

The recipe is a normal function returning `ButtonStyler`:

```dart
@MixWidget(name: 'AcmeButton', target: RemixButton.new)
ButtonStyler acmeButtonStyle({
  AcmeButtonVariant variant = .primary,
  AcmeButtonSize size = .medium,
  ButtonStyler style = const ButtonStyler.create(),
}) { /* recipe */ }
```

The generator combines the recipe parameters with the complete safe
`RemixButton` constructor surface. A non-nullable variant enum also produces
named constructors such as `AcmeButton.destructive`.

Default-all forwarding is intentional. A handwritten wrapper or parameter
allowlist can silently miss a new Remix capability. Regeneration instead turns
constructor changes into generated diffs that an application can review.

Two target parameters are not exposed as ordinary overrides:

- `style` is supplied by the recipe. The recipe's own `style` argument merges
  last and is the application-level override.
- `styleSpec` bypasses style resolution, including the recipe and its tokens,
  so it is not a useful visual customization hook here.

Generated source is not bundled in the registry. It is emitted from the
consumer's resolved Remix and generator versions, then compared with a
committed Acme fixture in this repository to make drift visible.

## Why a small local catalog

The MVP has one registry YAML file and one canonical template tree inside
`remix_cli`. It has no remote registry, cache, lockfile, content hashes, update
protocol, or per-component manifest format. Those features need evidence from
more components and real consumers before they earn their maintenance cost.

The installer still protects application source:

- existing authored files are preserved on normal runs;
- `--diff` is read-only;
- `--overwrite` applies only to the item explicitly requested;
- dependency declarations that already resolve compatibly are preserved;
- validation and dependency failures happen before authored-source writes;
- generation targets only the parts declared by resolved items.

This is enough distribution machinery for a growing catalog without pretending
the MVP has an update system.

## Dependency cost

Runtime dependencies are `remix` and `mix_annotations`. Mix and Naked UI arrive
through Remix, which avoids choosing a direct Mix version that Remix was not
compiled against. Development dependencies are `build_runner` and
`mix_generator`.

The recurring costs are visible:

- recipe, Remix constructor, or generator changes require regeneration;
- Remix prerelease changes can rewrite the generated adapter;
- the installed layer intentionally relies on Remix's Mix re-export;
- compact 32/36/40px sizes suit web density but are below common mobile touch
  target guidance, so adopting apps must make their own density decision.

## What remains outside this MVP

Fortal stays unchanged. There is no general component marketplace, remote
registry, automatic migration, source lockfile, or public-release automation
for `remix_cli`.

The first public release has a separate gate: confirm the pub.dev package and
publisher, add an isolated tag contract, verify bundled assets from a staged
archive in a clean Pub cache, publish a prerelease, and repeat the flow from the
hosted package. Until then, project-local checkout or staged-package use is the
honest supported path.
