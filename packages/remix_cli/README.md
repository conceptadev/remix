# remix_cli

`remix_cli` installs editable component source into a Flutter application.
Choose the compact `default` preset or the Radix Themes-inspired `fortal`
preset at initialization. Remix remains the behavior dependency; the
application owns its tokens, theme values, component recipes, and generated
adapters.

The 0.1.0 catalog includes an opt-in `icons` seam and covers the core Remix
component surface: `accordion`, `avatar`, `badge`, `button`, `callout`, `card`,
`checkbox`, `data_list`, `data_table`, `dialog`, `disclosure`, `divider`,
`icon_button`, `link`, `menu`, `popover`, `progress`, `radio`,
`segmented_control`, `select`, `sidebar`, `skeleton`, `slider`, `spinner`,
`switch`, `tabs`, `textfield`, `toast`, `toggle`, `toggle_group`, and
`tooltip`, each with a `theme` dependency. The Fortal preset also includes
`base_button`, `code`, `heading`, `kbd`, `text`, and `typography`. The
`data_table` item uses `checkbox`, `icon_button`, and `select` for its
controls, and `toast` uses `button` and `icon_button` for its action and close
control. The default `sidebar`
item uses the application's `toggle` recipe for destinations.
The catalog also offers `chart` as an optional extension over
`mix_chart`; it does not depend on `remix_fortal`. There is no remote registry,
update command, registry lockfile, or content-hash protocol.

## Install project-locally

The CLI has not been published. The hosted commands below apply after its
first release. Until then, use the checkout command in this section.

The CLI requires Flutter 3.44 or later (Dart 3.12). With an older SDK, adding
the dependency fails during version solving.

A project-local development dependency is preferred because the app's lockfile
pins the CLI version and its bundled templates:

```shell
flutter pub add dev:remix_cli
dart run remix_cli:remix init --prefix Acme --preset fortal
dart run remix_cli:remix add button
```

To run an unreleased build, point at a checkout or staged package path:

```shell
dart pub add "dev:remix_cli@{path: /path/to/remix/packages/remix_cli}"
```

Both presets require Remix `^1.0.0-beta.9`. Before that release is available,
add this `pubspec_overrides.yaml` to the application:

```yaml
dependency_overrides:
  remix:
    path: /path/to/remix/packages/remix
```

Replace the path with your checkout. Remove the override after beta.9 is
published and run `flutter pub get` to use hosted Remix.

Global activation is convenient for experiments, but it does not pin the
template version per project:

```shell
dart pub global activate remix_cli
```

`remix_cli` is versioned independently of `remix`, so its version does not
match Remix's. Its registry is authored against one `remix`
version; `add` reports when your resolved `remix` is newer than that one.

## Initialize a project

Run from a Flutter package root:

```shell
dart run remix_cli:remix init
```

The default configuration is:

```yaml
schema: 2
prefix: Ui
preset: default
paths:
  ui: lib/ui
```

Customize it only at initialization:

```shell
dart run remix_cli:remix init --prefix Acme --preset fortal --ui-path lib/design_system
```

`init` validates the Flutter project, writes `remix.yaml`, and creates a barrel
with a managed export block. Repeating the same command is safe. A different
configuration is refused instead of silently rewriting an existing project.
The preset defaults to `default` when omitted and cannot be changed after
initialization.

### Fortal as owned source

With `preset: fortal`, `add button` installs the full local theme layer,
`base_button.dart`, `button.dart`, and the generated adapter. The configured
prefix replaces Fortal throughout: `--prefix Acme` creates `AcmeScope`,
`AcmeTokens`, `AcmeButton`, and `acmeButtonStyle`. The installed application
does not depend directly on `mix`, `naked_ui`, or `remix_fortal`; it can edit
the Radix color data, tokens, recipes, and instance overrides as ordinary app
source.

Place `AcmeScope` below the application host. For a routed Material app, wrap
the child of `MaterialApp.builder` with `AcmeScope`. Routes and dialogs then
inherit its tokens and text defaults. See `lib/ui/theme/theme_scope.dart` for
the scope example.

The prefixes `Remix` and `Mix` are reserved for runtime dependencies.
Use an application prefix such as `Ui` or `Acme`.

## Add a component

```shell
dart run remix_cli:remix add button
```

The command installs Theme before Button, adds missing compatible hosted
dependencies, formats the authored files, runs generation only for the
declared `button.g.dart`, and analyzes the installed UI path. It does not create
or modify `build.yaml`.

The current `mix_generator` writes explicit `this.` qualifiers into generated
adapters, which `flutter_lints` reports as `unnecessary_this` infos. They do
not fail the command. To keep `flutter analyze` on the source you own, exclude
the adapters in `analysis_options.yaml`, matching your `paths.ui`:

```yaml
analyzer:
  exclude:
    - lib/ui/**/*.g.dart
```

With the default preset and path, the application receives:

```text
lib/ui/
  ui.dart
  theme/
    tokens.dart
    theme_data.dart
    theme_scope.dart
  components/
    button.dart
    button.g.dart
```

One `add` installs one item and its registry dependencies. Repeat it for each
component you need. Default component items add an authored file and a
generated part to `components/`. Fortal also has shared source items without
generated parts, such as `base_button` and `typography`.
Existing authored source stays untouched. When generation runs, the build
includes every installed adapter. This protects earlier generated parts when
dependencies change.

`dart run remix_cli:remix add icons` is the deliberate exception. It adds
`lib/ui/icons.dart`, declares `remix_ui_icons`, and exposes a small,
application-owned `UiIcons` alias set with no generated adapter. Add or rename
aliases there as your interface evolves. The complete 318-icon catalog remains
one direct `package:remix_ui_icons/remix_ui_icons.dart` import away.

Most default component items generate one widget. Four generate several:
`checkbox` also generates
`UiCheckboxGroupItem`, `textfield` generates `UiTextField` and `UiTextArea`,
`tabs` generates `UiTabBar`, `UiTab`, and `UiTabView`, and `chart` generates
`UiLineChart`, `UiBarChart`, and `UiPieChart`.

### Add application-owned charts

```shell
dart run remix_cli:remix add chart
```

This installs one editable `components/chart.dart` recipe and adds
`mix_chart`. The generated adapters cover line and area charts, grouped,
stacked, and floating bars, and pie and donut charts. They use the existing
application theme and never import Fortal.

Import `mix_chart` directly for chart data. The UI barrel exports the generated
widgets and the application-owned style functions, but it does not re-export a
dependency's API:

```dart
import 'package:mix_chart/mix_chart.dart';

import 'ui/ui.dart';

final chart = SizedBox(
  height: 240,
  child: UiLineChart(
    semanticsLabel: 'Weekly revenue',
    series: [
      LineSeries(
        id: 'revenue',
        label: 'Revenue',
        points: [
          ChartPoint(id: 'mon', x: 0, y: 18),
          ChartPoint(id: 'tue', x: 1, y: 31),
        ],
      ),
    ],
  ),
);
```

Charts have no intrinsic height, so give line and bar charts a bounded height
and pie charts a bounded size. The palette is the theme's `chart1` to
`chart5` tokens: edit them in `theme/theme_data.dart` to restyle every chart,
or pass `palette` or a chart `style` for one instance.

`RemixCheckboxGroup`, `RemixRadioGroup`, `RemixTabs`, and
`RemixAccordionGroup` are behavioral and carry no style, so the registry has
nothing to render for them: import them from `package:remix/remix.dart` and put
the installed adapters inside. `toggle_group`, `segmented_control`, `menu`, and
`select` are the opposite case — their rows are data rather than widgets, so
the parent's recipe carries the row style and one `add` covers both.

The authored files are application source. A normal rerun preserves them. The
generated part is owned by the consumer's resolved generator and should be
committed, but not edited by hand.

## Review and overwrite

Preview a new install without changing the project or running package tools:

```shell
dart run remix_cli:remix add button --dry-run
```

Compare the requested item with the bundled source using Git's no-index diff:

```shell
dart run remix_cli:remix add button --diff
```

After reviewing the difference, replace only the requested item's authored
files:

```shell
dart run remix_cli:remix add button --overwrite
```

Overwriting Button preserves locally edited Theme files. Compatible existing
hosted, path, Git, custom-hosted, and override dependency declarations are also
preserved. An incompatible resolved dependency fails before authored-source
writes.

Section placement is checked but never rewritten. Packages the installed source
imports at runtime (`remix`, `mix_annotations`, `mix_chart` for `chart`, and
`remix_ui_icons` for `icons`) must be declared under
`dependencies`; build-only packages (`build_runner`, `mix_generator`) may sit in
either section. Declaring the same package in both sections is rejected. A
misplaced declaration fails before any process runs or file is written, and the
CLI names the package and the section to move it to rather than editing your
`pubspec.yaml`.

If generation or analysis fails after installation, the authored source stays
in place for inspection. Fix the reported issue and rerun the same command.

## Exit codes

- `0`: success, including help, version, dry-run, diff, and no-op reruns
- `64`: invalid command or command-line arguments
- `1`: project/configuration, registry, dependency, process, generation,
  analysis, or filesystem failure

## Manual updates

The MVP's update workflow is explicit:

1. update the project-local `remix_cli` constraint;
2. run `add button --diff`;
3. review the template changes against local customizations;
4. use `add button --overwrite` only when replacement is intended;
5. reapply or refine application-specific changes and commit the regenerated
   adapter.

There is no automatic merge or migration layer in 0.1.0.
