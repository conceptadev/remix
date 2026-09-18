# Application-owned Remix UI

This example is installed by `remix_cli`. It gives an application editable
theme and component source while Remix continues to own rendering, interaction,
focus, loading, disabled behavior, and accessibility.

The two registry trees live in
`packages/remix_cli/lib/src/registry/default/` and
`packages/remix_cli/lib/src/registry/fortal/`. There is no second registry copy
under `open_code/`. `open_code/fixture/` proves the default preset, while
`open_code/fortal_fixture/` proves Fortal with every generated widget and
known Radix Themes 3.3.0 color values. A behavioral package can be styled from
the same installed source; see
[Styling a package on top of the catalog](#styling-a-package-on-top-of-the-catalog).

## Install the CLI in a project

The CLI has not been published. The hosted commands below apply after its
first release. Until then, use the checkout command in this section.

Use a project-local development dependency so the application's lockfile pins
the CLI version and its bundled templates:

```shell
flutter pub add dev:remix_cli
dart run remix_cli:remix init --prefix Acme --preset default
dart run remix_cli:remix add button
```

One `add` installs every named item plus shared dependencies once. The catalog is `theme`, the opt-in `icons` seam,
the optional `chart` extension, plus `accordion`, `avatar`, `badge`, `button`,
`callout`, `card`, `checkbox`, `dashboard_demo`, `dashboard_shell`, `data_list`, `data_table`, `dialog`,
`disclosure`, `divider`, `icon_button`, `link`, `menu`, `popover`, `progress`,
`radio`, `segmented_control`, `select`, `sidebar`, `sidebar_layout`,
`skeleton`, `slider`, `spinner`, `switch`, `tabs`, `textfield`, `toast`,
`toggle`, `toggle_group`, and `tooltip`. `sidebar_layout` is a plain shell
layout with no `Spec` and no generated adapter, pairing an installed
`sidebar` with a header and body.

`dashboard_shell` installs a reusable, host-controlled shell plus its shared
composition source. It pulls in the existing sidebar layout, sidebar,
icon-button, icon, and text-field items; it does not install charts, tables,
sample data, routes, or an application entry point.

`dashboard_demo` installs that shell plus the same twelve destinations as the
Fortal reference dashboard: Overview, Chat, Customers, Orders, Settings,
Charts, Actions, Forms & Inputs, Data Display, Overlays, Navigation, and
Typography. It uses the same `UiDashboardDemo` API in both presets, renders
each preset's native component variants, and still leaves the host's app,
theme scope, routes, authentication, persistence, and real search behavior in
the application.

The `fortal` preset contains that complete surface plus `base_button`, `code`,
`heading`, `kbd`, `text`, and `typography`.

`chart` is the one optional extension outside the core Remix component
surface. It builds directly on `mix_chart`, installs no Fortal code, and
generates `AcmeLineChart`, `AcmeBarChart`, and `AcmePieChart` from one editable
recipe.

To run an unreleased build, contributors can point the development dependency
at a checkout or staged package:

```shell
dart pub add "dev:remix_cli@{path: /path/to/remix/packages/remix_cli}"
```

Both presets require Remix `^1.0.0-beta.10`. Until that release is available,
add a temporary `pubspec_overrides.yaml` to the application:

```yaml
dependency_overrides:
  remix:
    path: /path/to/remix/packages/remix
```

Replace the path with your checkout. The [release instructions](RELEASING.md)
cover hosted validation, CLI bootstrap, and the Fortal transition.

Two host notes travel with the catalog. An installed text field needs an
`Overlay` ancestor once it takes focus, for its selection handles —
`MaterialApp`, `CupertinoApp`, and any `WidgetsApp` with routes already provide
one, a bare `WidgetsApp(builder: ...)` does not. And four Remix widgets are
behavioral, carry no style, and therefore have no registry item:
`RemixCheckboxGroup`, `RemixRadioGroup`, `RemixTabs`, and
`RemixAccordionGroup`. Import those from `package:remix/remix.dart` and put the
installed adapters inside them.

`init` creates `remix.yaml` and a managed barrel at `lib/ui/ui.dart`. The
default prefix is `Ui`; `--prefix Acme` produces names such as
`AcmeThemeScope`, `AcmeButton`, and `acmeButtonStyle`. A different source root
can be chosen once with `--ui-path`. The preset also is chosen once: existing
projects default to `default`, and changing a configured preset is refused.

## Fortal as application-owned source

```shell
dart run remix_cli:remix init --prefix Acme --preset fortal
dart run remix_cli:remix add button
```

This installs the full Fortal theme and recipe as prefixed local source:
`AcmeScope`, `AcmeTokens`, `AcmeButton`, and `acmeButtonStyle`. It also installs
the shared `base_button.dart` implementation used by Button and IconButton.
No installed identifier is named Fortal, and the consumer does not declare
direct `mix`, `naked_ui`, or `remix_fortal` dependencies. `remix` owns behavior;
the application owns the copied Radix color table, 277-token theme, component
recipes, and generated adapters.

The Fortal templates are derived from analyzed Dart in
`registry_source/fortal/lib/src/`; do not edit the committed `.tmpl` files by
hand. `tool/build_registry.dart --check` makes source/template drift a CI
failure.

The prefixes `Remix` and `Mix` are reserved for runtime dependencies.
Use an application prefix such as `Ui` or `Acme`.

The default preset installs Theme before Button. The command adds missing
dependency constraints, writes source, updates the barrel, and generates the
adapter:

```text
lib/ui/
  ui.dart
  theme/
    tokens.dart
    theme_data.dart
    theme_scope.dart
  components/
    button.dart       authored; edit this
    button.g.dart     generated; do not hand-edit
```

Each later default component `add` adds another pair to `components/` and extends
the barrel's managed block. Existing authored source stays untouched. The
focused build also includes every installed generated adapter, so a dependency
change cannot remove an earlier generated part.

Fortal also installs shared source items without generated parts, such as
`base_button` and `typography`. Use `add <item> --dry-run` to inspect each
preset's files and dependencies.

`dart run remix_cli:remix add icons` instead adds `lib/ui/icons.dart`, declares
`remix_ui_icons`, and exposes a small, application-owned `UiIcons` alias set
without a generated adapter. Add or rename aliases there as the application
evolves. The complete 318-icon catalog is one direct
`package:remix_ui_icons/remix_ui_icons.dart` import away.

Recipe-only installs need no `build.yaml`. Agent surfaces use `@MixableSpec`,
whose styler builder is opt-in in the supported Mix generator. The CLI enables
that builder for the installed source paths in `build.yaml`, preserving other
settings and comments. Explicit disabled builders or excluded source fail in
preflight instead of being overridden. Dry-run/diff remain read-only.

Agent behavior is available in both bundled presets. Add a bare surface for
behavior-only source, or `<component>_recipe` for the surface plus its complete
preset-specific styling bundle. Each recipe is authored as Dart in its preset's
source (`registry_source/lib/src/{default,fortal}/recipes/`) against the Agent
behavior source beside it,
and derives into the registry like every other item.

## Charts without Fortal

```shell
dart run remix_cli:remix add chart
```

The application receives `components/chart.dart` and its generated adapter.
The authored file owns the categorical palette, axes, grid, line and bar
geometry, pie treatment, and tooltip. `mix_chart` still owns data, rendering,
interaction, and semantics.

Import `package:mix_chart/mix_chart.dart` for `LineSeries`, `ChartPoint`,
`BarGroup`, and `PieSlice`. The UI barrel does not re-export that dependency.
Give every chart finite dimensions; `mix_chart` charts have no intrinsic
height. A positive `centerRadius` turns `AcmePieChart` into a donut.

## Source ownership

After installation, the application owns every authored file. Change token
values, add a variant, rename a size, or replace a recipe. A normal `add`
rerun preserves existing authored files. It can recreate a missing generated
part, refresh the managed export block, and run the focused checks without
resetting local work.

Use `--diff` to compare the requested item with the bundled template. This is
read-only and requires Git:

```shell
dart run remix_cli:remix add button --diff
```

Use `--overwrite` only after reviewing that difference:

```shell
dart run remix_cli:remix add button --overwrite
```

Overwrite is requested-item-only. Overwriting Button does not overwrite its
Theme dependency. The CLI has no registry lockfile, content hash, remote
registry, or automatic update command in this MVP; updates are an explicit
diff-and-overwrite decision.

## Generated source

`components/button.dart` declares:

```dart
@MixWidget(name: 'AcmeButton', target: RemixButton.new)
ButtonStyler acmeButtonStyle({
  AcmeButtonVariant variant = .primary,
  AcmeButtonSize size = .medium,
  ButtonStyler style = const ButtonStyler.create(),
}) { /* recipe */ }
```

`mix_generator` creates `AcmeButton` in `button.g.dart`. The adapter forwards
the complete safe `RemixButton` constructor surface. The recipe owns
`RemixButton.style`, while raw `styleSpec` is intentionally omitted because it
would bypass the recipe and token resolution.

Commit the generated file, but regenerate it after changing the recipe,
upgrading Remix, or upgrading the generator:

```shell
dart run build_runner build \
  --build-filter=lib/ui/components/button.g.dart
```

## Customization

Theme-wide changes use `copyWith`:

```dart
AcmeThemeScope(
  data: const AcmeThemeData.light().copyWith(
    primary: const Color(0xFF4F46E5),
    primaryForeground: const Color(0xFFFFFFFF),
    radius: const Radius.circular(999),
  ),
  child: page,
)
```

Dynamic construction and named variants are both available:

```dart
AcmeButton(
  variant: variant,
  size: AcmeButtonSize.small,
  label: variant.name,
)

AcmeButton.destructive(
  label: 'Delete',
  onPressed: deleteAccount,
)
```

A per-instance `ButtonStyler` merges last:

```dart
AcmeButton.primary(
  label: 'Publish',
  style: ButtonStyler()
      .color(const Color(0xFF7C3AED))
      .minHeight(48),
  onPressed: publish,
)
```

Mix merges state fragments by state. To replace a hover value, provide an
`onHovered` fragment; an idle `.color(...)` changes only the idle value.

## Project-local versus global use

Project-local use is the supported default. It pins the CLI alongside the app
and makes template changes reviewable in ordinary dependency updates. A global
activation is convenient for experiments, but it can silently move every
project to a different template version.

## Styling a package on top of the catalog

Installed recipes are not only for an application's own widgets. A behavioral
package that takes unresolved stylers can be styled from them too, which keeps
its surfaces inside the application's design language instead of adding a
second one.

Agent is the worked example. Its `composer_recipe` item, authored in
each preset's source and installed like any other recipe, composes the
installed Theme, Card, TextField, and IconButton into one recipe bundle for
the installed `UiComposer`:

```dart
final recipe = uiAgentComposerRecipe();

UiComposer(
  onSubmit: submit,
  style: recipe.style,
  surfaceStyle: recipe.surfaceStyle,
  fieldStyle: recipe.fieldStyle,
  submitStyle: recipe.submitStyle,
  stopStyle: recipe.stopStyle,
)
```

A bundle rather than a single styler, because the widget takes five stylers and
its own spec covers one of them. The four child stylers are passed on
unresolved, so each control resolves its own hover, focus, and disabled state.

The eight Agent surfaces now install as `activity`, `answer`, `composer`,
`execution`, `message`, `permission`, `plan`, and `transcript` in both existing
presets. Shared `models` and `support` install through dependency closure. The
private authoring source (`registry_source/lib/src/agent`) is not a consumer
dependency. The dashboard imports installed `Ui*` classes. Fortal recipes use
only the installed Fortal theme and controls. Checkout verification does not
replace the hosted checks required before a release.

All eight surfaces have equivalent immutable recipe bundles. Call-site overrides
merge last, and child-control stylers remain unresolved until rendered. The
conversation shell and simulated runner belong to the applications, not the
registry or a source package.

## Repository proof

Run the focused unit test and the full fresh-consumer check from the workspace
root:

```shell
fvm dart test test/tool/check_open_code_test.dart
fvm dart run melos run open-code:check
```

The CI check creates a fresh application for each preset. It installs the
checkout CLI with prefix `Acme`, adds every item, and verifies generation,
analysis, and consumer tests against checkout Remix.

After Remix is published, run `fvm dart run melos run open-code:release:check`
to verify both presets with hosted Remix. The direct checker defaults to both
sources. Select `--source checkout` or `--source hosted` for one source.
Use `--hosted-cli --source hosted` after CLI publication to verify its hosted
assets. Pass `--keep` to retain a generated application for inspection.

All three dogfood consumers are checked against the templates they installed:

```shell
fvm dart run tool/check_open_code_dogfood.dart
```

`apps/playground` holds every default item; `apps/demo` installs the non-Agent
Fortal catalog; `apps/dashboard` installs the full Fortal catalog, including all
eight Agent surfaces and recipes. The checker declares the Fortal items
explicitly, so missing files are checked too. The CLI reads each consumer's
`remix.yaml` to locate its installed source.

Available styled items: `activity_recipe`, `answer_recipe`, `composer_recipe`,
`execution_recipe`, `message_recipe`, `permission_recipe`, `plan_recipe`, and
`transcript_recipe`. Each installs only its component and styled-control closure.
