# Application-owned Remix UI

This example is installed by `remix_cli`. It gives an application editable
Theme and Button source while Remix continues to own rendering, interaction,
focus, loading, disabled behavior, and accessibility.

The registry source lives in `packages/remix_cli/lib/src/registry/`. There is
no second copy under `open_code/`. The files in `open_code/fixture/` are a
fresh-app gallery, behavioral test suite, and expected generated adapter used
by `tool/check_open_code.dart`.

## Install the CLI in a project

Use a project-local development dependency so the application's lockfile pins
the CLI version and its bundled templates:

```shell
flutter pub add dev:remix_cli
dart run remix_cli:remix init --prefix Acme
dart run remix_cli:remix add button
```

Until the separate public-release gate is complete, contributors can point the
development dependency at a checkout or staged package:

```shell
dart pub add "dev:remix_cli@{path: /path/to/remix/packages/remix_cli}"
```

`init` creates `remix.yaml` and a managed barrel at `lib/ui/ui.dart`. The
default prefix is `Ui`; `--prefix Acme` produces names such as
`AcmeThemeScope`, `AcmeButton`, and `acmeButtonStyle`. A different source root
can be chosen once with `--ui-path`.

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

The CLI does not create or modify `build.yaml`.

## Source ownership

After installation, the application owns every authored file. Change token
values, add a variant, rename a size, or replace the recipe. A normal `add`
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
project to a different template version. Hosted/global activation remains a
post-MVP release gate until the package name, publisher, archive contents, and
activation flow have been verified.

## Repository proof

Run the focused unit test and the full fresh-consumer check from the workspace
root:

```shell
fvm dart test test/tool/check_open_code_test.dart
fvm dart run tool/check_open_code.dart
```

The full check creates a guarded temporary Flutter app, installs the checkout
CLI with prefix `Acme`, and proves generation, analysis, and all behavior tests
against hosted Remix. It then overrides Remix to the current checkout,
regenerates without a consumer `build.yaml`, and repeats the checks. Pass
`--keep` to retain the generated gallery for inspection.
