# remix_cli

`remix_cli` installs editable Theme and Button source into a Flutter
application. Remix remains the behavior dependency; the application owns its
tokens, theme values, component recipe, and generated adapter.

The 0.1.0 catalog is intentionally small: `button` depends on `theme`. There is
no remote registry, update command, registry lockfile, or content-hash protocol.

## Install project-locally

A project-local development dependency is preferred because the app's lockfile
pins the CLI version and its bundled templates:

```shell
flutter pub add dev:remix_cli
dart run remix_cli:remix init --prefix Acme
dart run remix_cli:remix add button
```

Before the first hosted release, use a checkout or staged package path:

```shell
dart pub add "dev:remix_cli@{path: /path/to/remix/packages/remix_cli}"
```

Global activation is convenient for experiments, but it does not pin the
template version per project. Hosted/global activation remains behind the
post-MVP release gate until the package and publisher configuration have been
verified.

## Initialize a project

Run from a Flutter package root:

```shell
dart run remix_cli:remix init
```

The default configuration is:

```yaml
schema: 1
prefix: Ui
paths:
  ui: lib/ui
```

Customize it only at initialization:

```shell
dart run remix_cli:remix init --prefix Acme --ui-path lib/design_system
```

`init` validates the Flutter project, writes `remix.yaml`, and creates a barrel
with a managed export block. Repeating the same command is safe. A different
configuration is refused instead of silently rewriting an existing project.

## Add Button

```shell
dart run remix_cli:remix add button
```

The command installs Theme before Button, adds missing compatible hosted
dependencies, formats the authored files, runs generation only for the
declared `button.g.dart`, and analyzes the installed UI path. It does not create
or modify `build.yaml`.

With the default path, the application receives:

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
imports at runtime (`remix`, `mix_annotations`) must be declared under
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
