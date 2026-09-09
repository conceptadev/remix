# Remix Fumadocs app

This app renders the canonical `../../docs` content with the shared Concepta
Fumadocs theme. It does not contain a second editable copy of the documentation.

## Run

Use Node 24.14+, pnpm 11.5.3, Python 3.9+, and FVM with the repository's
pinned Flutter SDK. Run `fvm flutter pub get` in `apps/demo` first:

```bash
cd apps/docs
pnpm install --frozen-lockfile
pnpm dev
```

Open `http://localhost:3000/tutorials/settings-screen`. Production checks:

```bash
pnpm typecheck
pnpm build
pnpm start
```

Set `NEXT_PUBLIC_SITE_URL` to the deployment origin before building metadata.
This is a server deployment: `/api/search` uses the native Fumadocs endpoint.
Static export and deployment under a path prefix are not configured.

## Theme access and release limitation

The theme is not published on npm yet. `package.json` and the lockfile pin the
reviewed `conceptadev/docs-theme` commit
`0f032d0efb437a2aface4e3198a708549ef39671`, the merged theme `main`. pnpm
fetches this GitHub dependency over SSH and builds it; only this exact Git
source is allowed to run scripts.
Installation requires GitHub access to that currently internal repository.
No theme source or credentials are vendored here.

This is ready for authorized local development, not anonymous installation or
public CI. Once the theme's license and publication are resolved, replace the
Git dependency with its verified npm release, regenerate the lockfile, and
repeat the production/browser checks. Do not add a token to this repository
or bypass access controls to make the dependency resolve.

## Content ownership

Edit MDX and assets under `../../docs`; edit navigation in `../../docs.json`.
`pnpm content` validates evidence, stages generated MDX in `.generated/content`,
and copies assets into `public/assets`. These directories are disposable and
gitignored. Restart `pnpm dev` after editing canonical content to stage changes.

`TutorialSource` is a build-time include, not a runtime React component. The
four source panels read the exact Dart files from the checked sample ZIP and
become native Fumadocs fenced blocks. Fumadocs owns highlighting, copying,
search, navigation, and responsive layout. The small MDX compatibility map
retains existing `Info`, `Note`, `Warning`, and single-example `CodeGroup` tags.

The retired standalone tutorial and guide URLs redirect to their native MDX
replacements. Old HTML files and their renderer dependencies remain recoverable
from Git history, not shipped alongside the new app.

## Live component examples

Every component page pairs a live Widgetbook preview with its real catalog
source. `docs/component-previews.json` selects the generated Widgetbook routes;
`tool/prepare_docs_site.py` includes `apps/demo/lib/components/<page>.dart`
directly. Edit these sources, not the generated MDX. Source panels are catalog
examples with Fortal styling, not standalone applications.

The embedded example follows the site's light/dark theme so a dark page never
frames a white canvas. The Theme control still overrides it for comparison, and
that explicit choice then persists across site theme changes.

Both `pnpm dev` and `pnpm build` build that same Flutter catalog into ignored
`public/previews`. `/previews/` opens the full catalog; embedded routes use
Widgetbook's native preview mode. No separate renderer or remote deployment
is required. To iterate on docs alone after the initial build, run `pnpm content`
and `pnpm exec next dev`. Rebuild previews after changing Flutter examples.

`apps/demo/test/docs_preview_test.dart` checks page coverage, actual generated
routes, and the new interactive examples. Run it from `apps/demo` with
`fvm flutter test test/docs_preview_test.dart test/catalog_test.dart`.

The build uses the current Git commit for page-source links. Set
`DOCS_SOURCE_REF` explicitly when building without a Git checkout. Configure
`NEXT_PUBLIC_SITE_URL` separately for canonical metadata.

## Styling

`app/global.css` loads Tailwind, the Fumadocs `preset.css`, and the theme's
`theme.css`, in that order. The Concepta payload is a complete Fumadocs color
preset, so `fumadocs-ui/css/neutral.css` must not be stacked underneath it.
Shared fonts, reading styles, and logo support belong in `conceptadev/docs-theme`.
Remix keeps only its own identity in `.remix-docs`: its existing artwork, the
green accent through `--docs-primary-light`/`--docs-primary-dark`, and the
Flutter preview styles. The theme documents its Concepta design-system
reference; private design-system source and assets are not copied here.
