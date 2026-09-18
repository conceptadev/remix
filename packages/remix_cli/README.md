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
`segmented_control`, `select`, `sidebar`, `sidebar_layout`, `skeleton`,
`slider`, `spinner`, `switch`, `tabs`, `textfield`, `toast`, `toggle`,
`toggle_group`, and `tooltip`, each with a `theme` dependency. The Fortal
preset also includes `base_button`, `code`, `heading`, `kbd`, `text`, and
`typography`. The `data_table` item uses `checkbox`, `icon_button`, and
`select` for its controls; `toast` uses `button` and `icon_button` for its
action and close control. The default `sidebar` item uses the application's
`toggle` recipe for destinations. `sidebar_layout` is a plain shell layout
with no `Spec` or generated adapter: it composes an installed `sidebar` into
a row above its compact breakpoint and a start-edge sheet below it.
The grouped `dashboard_shell` recipe builds on those pieces with host-owned
navigation, page content, optional search, and brand/account/action slots. It
has no generated adapter and does not install charts, tables, Agent surfaces,
or an application entry point.
The catalog also offers `chart` as an optional extension over
`mix_chart`; it does not depend on `remix_fortal`. There is no remote registry,
update command, registry lockfile, or content-hash protocol.

Both presets additionally distribute the unstyled Agent items:
`activity`, `answer`, `composer`, `execution`, `message`, `permission`, `plan`,
and `transcript`, with shared `models` and `support` dependencies. These are
application-owned source, not a dependency on the private authoring source.
Each surface has an opt-in `<component>_recipe` item that installs a complete,
preset-specific styler bundle under `lib/ui/recipes/`; bare components remain
unstyled and backward compatible.

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

Both presets require Remix `^1.0.0-beta.10`. Before that release is available,
add this `pubspec_overrides.yaml` to the application:

```yaml
dependency_overrides:
  remix:
    path: /path/to/remix/packages/remix
```

Replace the path with your checkout. Remove the override after beta.10 is
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

Several items can be named in one command:

```shell
dart run remix_cli:remix add button card dialog
```

A batch installs as one unit. The items and everything they depend on are
ordered once, so a dependency two of them share is written once, and the
resolve, format, generation, and analysis steps run once for the whole batch
rather than once per item. Naming an unknown item, or the same item twice,
fails before anything is written.

The command installs Theme before Button, adds missing compatible hosted
dependencies, formats the authored files, runs generation only for the
declared adapters (including previously installed adapters), and analyzes the
installed UI path. Recipe-only installs do not need `build.yaml`. Installing
Agent `@MixableSpec` source enables Mix's opt-in spec-styler builder there,
scoped to the installed files. The CLI preserves comments and unrelated
settings; it refuses explicit builder disablement, excluded source, or
conflicting target ownership before writing. `--dry-run` reports the required
configuration and `--diff` shows it without changing the application.

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

### Add a dashboard shell

```shell
dart run remix_cli:remix add dashboard_shell
```

This installs the preset's sidebar, responsive sidebar layout, icon button,
textfield, icons, and theme dependency closure plus two editable files under
`lib/ui/recipes/dashboard/`. The public `UiDashboardShell<T>` API is the same
for `default` and `fortal`. The host supplies `RemixSidebarSection<T>` values,
the selected value and callback, the current page body, title, and brand slot.
Account and header-action slots are optional. Search is absent unless the host
provides `onSearchChanged`.

The shell composes inside the existing application. It does not create a
`MaterialApp`, `WidgetsApp`, `Navigator`, route table, authentication layer, or
persistence mechanism. Place it below the preset theme scope and keep those
host responsibilities in the application. A normal reinstall preserves edits;
use `--diff` and explicit `--overwrite` for template updates.

### Add the full dashboard demo

Initialize either preset, then use the same item and public dashboard API:

```shell
dart run remix_cli:remix init --prefix Ui --preset default
# Or initialize a separate app with: --preset fortal
dart run remix_cli:remix add dashboard_demo
```

`dashboard_demo` installs `UiDashboardDemo`, `UiDashboardOverview`, the
reusable shell, and all twelve destinations from the Fortal reference
dashboard. Product pages and gallery categories match across presets while
their specimens use each preset's native variants. The overview's four
metrics, revenue series, and recent records live in editable
`lib/ui/recipes/dashboard/dashboard_sample_data.dart`; replace them there or
pass a `RegistryDashboardSampleData` to `UiDashboardDemo(data: ...)`.

The host supplies its Flutter application, directionality, brand, and theme
scope. Default uses `UiThemeScope(data: UiThemeData.light(), child: ...)`;
Fortal uses `UiScope(child: ...)`. The installer does not rewrite `main.dart`,
routes, authentication, persistence, or search behavior. Pass a real
`onSearchChanged` callback to show search; omit it to remove the field.

Installed recipe source follows the normal update contract. Re-running `add
dashboard_demo` preserves local edits. Inspect a newer template with `--diff`, and
use `--overwrite` only when deliberately replacing the installed recipe.

Contributors can reproduce the isolated consumer gates for either preset:

```shell
dart run tool/check_open_code.dart --preset default --source checkout --item dashboard_demo --keep
dart run tool/check_open_code.dart --preset fortal --source checkout --item dashboard_demo --keep
```

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

Overwriting Button preserves locally edited Theme files. With several items
named, `--overwrite` covers each of them and still preserves every dependency
that came in behind them; overwrite a dependency by naming it explicitly. Compatible existing
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

Available styled items: `activity_recipe`, `answer_recipe`, `composer_recipe`,
`execution_recipe`, `message_recipe`, `permission_recipe`, `plan_recipe`, and
`transcript_recipe`. Each installs only its component and styled-control closure.
