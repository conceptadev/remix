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

Open `http://localhost:3000/remix/tutorials/settings-screen/`. Production checks:

```bash
pnpm typecheck
pnpm build
pnpm test:search
DOCS_OUTPUT=out node scripts/test-pages.mjs --docs-only
DOCS_OUTPUT=out pnpm start
```

## GitHub Pages publishing

The app exports static HTML with `/remix` as its base path. Set
`NEXT_PUBLIC_SITE_URL` to the HTTPS origin before building metadata; it defaults
to `https://conceptadev.github.io`. Search downloads static page and section
indexes and runs in the browser, preserving component-title and keyword ranking.
No Node server runs in production.

`.github/workflows/deploy_web.yml` builds the docs and catalog, then the dashboard,
checks the combined artifact, and deploys it through GitHub Pages on main.
Pull requests build and validate without deploying. The public routes are:

- `/remix/`: Fumadocs documentation
- `/remix/catalog/`: Flutter component catalog and embedded examples
- `/remix/dashboard/`: dashboard showcase

`.github/actions/setup-docs` installs the pinned Node/pnpm toolchain and locked
dependencies. The reusable `.github/workflows/docs.yml` accepts a `site-url`
HTTPS origin and uploads a verified `remix-docs-static` artifact containing docs
and catalog. It does not deploy or include the dashboard.

To assemble and preview the full Pages artifact locally after `pnpm build`:

```bash
cd ../dashboard
fvm flutter build web --release --base-href /remix/dashboard/
cd ../docs
node scripts/package-pages.mjs
pnpm test:pages
pnpm start
```

The packager recreates `build/pages` and adds the dashboard. The docs build
includes `.nojekyll` and static aliases for `/remix/previews/` and the retired tutorial/guide HTML URLs.
Old catalog `#/?` links at the docs root forward to `/remix/catalog/` with their
query and fragment preserved; normal documentation anchors remain unchanged.
A retirement worker replaces the old root Flutter service worker so returning
visitors leave the cached catalog and load the docs. Catalog and dashboard
workers retain their own scopes.
The local server emulates directory indexes and real 404 responses under the
Pages mount, without a single-page-app fallback. Revert the migration and rerun
the main-branch Pages workflow to restore the previous deployment.

## Theme package

The site pins `@concepta/docs-theme@0.0.1` from the public npm registry.
The theme uses BSD-3-Clause; its source repository is `conceptadev/docs-theme`.
The lockfile records the published archive integrity. The release-age exception
is limited to this reviewed first version. To upgrade, change the pinned version,
regenerate the lockfile, and repeat the production and deployment smoke checks.

## Content ownership

Edit MDX and assets under `../../docs`; edit navigation in `../../docs.json`.
That JSON file contains only `sidebar`; site settings live in `docs.config.ts`
and colors live in `app/global.css`. Component categories use `collapsible: true`.
The Fortal catalog generator reuses those categories; regenerate it with
`melos docs:catalog` after changing their membership or names.
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
Reset example restores the first example, follows the site theme again, and
restarts the embedded Flutter app.

Both `pnpm dev` and `pnpm build` build that same Flutter catalog into ignored
`public/catalog`. `/remix/catalog/` opens the full catalog; embedded routes use
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
