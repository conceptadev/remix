# Release the Open Code presets

## Current state

The stack prepares Remix `1.0.0-beta.8` and `remix_cli` `0.1.0`.
Neither version has been published from this stack. The existing
`remix_fortal` release remains available until the replacement passes validation.

Merge PR #177, the Fortal PR, and PR #178 in that order. Retarget each child
PR to `main` after its parent merges. Preserve the parent commits when merging,
or rebase the child after a squash merge. Require passing checks after each
retarget or rebase.

## Validate the release candidate

Run these commands from the final checkout with Flutter 3.44.0:

```shell
fvm flutter pub get
fvm dart run melos run ci
fvm dart analyze
```

CI installs every item from both presets in fresh applications. It uses
checkout Remix and hosted supporting packages. The source and template checks
also verify generated files, the Radix contract, and the catalog.

Run `fvm dart pub publish --dry-run` inside `packages/remix` and
`packages/remix_cli`. Confirm that the CLI archive includes both registry trees
and their templates. Resolve every publication error before continuing.

The version and changelog for beta.8 are already prepared in this stack.
Future releases use `.github/workflows/version.yml` to update Remix and both
registry minimum versions together.

## Publish Remix first

After release approval, tag the validated merge commit as `v1.0.0-beta.8` and
push that tag alone. The existing publish workflow publishes Remix.
After success, record `remix-v1.0.0-beta.8` on the same commit for Melos history.

Wait until pub.dev serves beta.8. Then run:

```shell
fvm dart run melos run open-code:release:check
```

This command installs both presets with hosted Remix and the checkout CLI.
It must pass before CLI publication. It never substitutes checkout Remix for
a missing hosted release. Keep the registry minimum at beta.8 if resolution fails.

## Bootstrap the CLI package

The first CLI publication requires an authorized uploader to run
`fvm dart pub publish` inside `packages/remix_cli` after the hosted checks pass.
Pub.dev requires a manual first publication before automated publishing can
be configured. See the [Dart publication instructions](https://dart.dev/tools/pub/automated-publishing).

Confirm the intended publisher. Then configure automated publishing in the
package Admin tab with repository `conceptadev/remix` and tag pattern
`remix_cli-v{{version}}`.

Do not push `remix_cli-v0.1.0` to publish the same version again. Future CLI
releases update the package version, `lib/src/version.dart`, and the changelog.
Their tag starts the hosted consumer checks before the publish job.

## Verify the published CLI

After pub.dev serves CLI `0.1.0`, run:

```shell
fvm dart run tool/check_open_code.dart --source hosted --hosted-cli
fvm dart run tool/check_open_code.dart --preset fortal --source hosted --hosted-cli
```

These checks install the exact CLI version declared in the checkout from
pub.dev. They require hosted runtime packages and reject checkout package
dependencies. They exercise the published registry assets, generation, analyzer,
and consumer tests.

Remove the pending-publication notices from the installation guides after
these checks pass.

## Discontinue the old Fortal package

After the published CLI checks pass, mark `remix_fortal` discontinued in its
pub.dev Admin tab. Name `remix_cli` as the replacement package. The migration
instructions use `remix init --preset fortal` and application-owned imports.

Keep `packages/remix_fortal` in the repository as the analyzed authoring source.
Keep `publish_to: none` and its tests. Existing hosted installations remain
available; discontinuation does not delete their package versions.

If either published consumer check fails, keep `remix_fortal` active and fix
the replacement before completing the transition.
