# Application-owned Remix UI

This example is installed by `remix_cli`. It gives an application editable
theme and component source while Remix continues to own rendering, interaction,
focus, loading, disabled behavior, and accessibility.

The registry source lives in `packages/remix_cli/lib/src/registry/`. There is
no second copy under `open_code/`. The files in `open_code/fixture/` are a
fresh-app gallery, behavioral test suite, and expected generated adapter used
by `tool/check_open_code.dart`.

## Install the CLI in a project

The CLI has not been published. The hosted commands below apply after its
first release. Until then, use the checkout command in this section.

Use a project-local development dependency so the application's lockfile pins
the CLI version and its bundled templates:

```shell
flutter pub add dev:remix_cli
dart run remix_cli:remix init --prefix Acme
dart run remix_cli:remix add button
```

One `add` installs one item. The catalog is `theme`, the opt-in `icons` seam,
the optional `chart` extension, plus `accordion`, `avatar`, `badge`, `button`,
`callout`, `card`, `checkbox`, `data_list`, `data_table`, `dialog`,
`disclosure`, `divider`, `icon_button`, `link`, `menu`, `popover`, `progress`,
`radio`, `segmented_control`, `select`, `skeleton`, `slider`, `spinner`,
`switch`, `tabs`, `textfield`, `toggle`, `toggle_group`, and `tooltip`.

`chart` is the one optional extension outside the core Remix component
surface. It builds directly on `mix_chart`, installs no Fortal code, and
generates `AcmeLineChart`, `AcmeBarChart`, and `AcmePieChart` from one editable
recipe.

To run an unreleased build, contributors can point the development dependency
at a checkout or staged package:

```shell
dart pub add "dev:remix_cli@{path: /path/to/remix/packages/remix_cli}"
```

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
can be chosen once with `--ui-path`.

The prefixes `Remix` and `Mix` are reserved for runtime dependencies.
Use an application prefix such as `Ui` or `Acme`.

`add button` resolves the Theme dependency first, adds compatible hosted
package constraints when they are missing, writes the authored source, updates
the managed barrel, and generates only the declared adapter:

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

Every later component `add` drops one more pair into `components/` and extends
the barrel's managed block. Existing authored source stays untouched. The
focused build also includes every installed generated adapter, so a dependency
change cannot remove an earlier generated part.

`dart run remix_cli:remix add icons` instead adds `lib/ui/icons.dart`, declares
`remix_ui_icons`, and exposes a small, application-owned `UiIcons` alias set
without a generated adapter. Add or rename aliases there as the application
evolves. The complete 318-icon catalog is one direct
`package:remix_ui_icons/remix_ui_icons.dart` import away.

The CLI does not create or modify `build.yaml`.

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

## Repository proof

Run the focused unit test and the full fresh-consumer check from the workspace
root:

```shell
fvm dart test test/tool/check_open_code_test.dart
fvm dart run tool/check_open_code.dart
```

The full check creates a guarded temporary Flutter app, installs the checkout
CLI with prefix `Acme`, adds every registry item, and proves generation,
analysis, and all behavior tests against hosted Remix. It then overrides Remix to the current checkout,
regenerates without a consumer `build.yaml`, and repeats the checks. Pass
`--keep` to retain the generated gallery for inspection.
