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
This is a server deployment: `/api/search` uses Fumadocs search, prioritizing
page titles and frontmatter keywords while retaining section links.
Static export and deployment under a path prefix are not configured.

With the server running, verify component discovery with
`node --test scripts/test-search.mjs`. Set `DOCS_TEST_URL` for a different origin.

## Reusable build and publishing

`.github/actions/setup-docs` installs the pinned Node/pnpm toolchain and the
locked theme dependency. `.github/workflows/docs.yml` can be called from another
workflow with `workflow_call` or run manually with `workflow_dispatch`.
It validates sources, builds Flutter previews and the Next.js server, tests an
isolated deployment copy, and uploads `remix-docs-server` as a tar archive.

Supply `site-url` as the final HTTPS origin. Canonical/social URLs are baked
into the build, so rebuild when the public origin changes. The public npm
theme dependency requires no GitHub token or npm login.

The artifact supports a root-path Node server deployment. Extract it on a
Node 24.14+ host and run `HOSTNAME=0.0.0.0 PORT=3000 node server.js` behind the
host's HTTPS endpoint. It contains public assets, Flutter previews, Next client
chunks, and traced server dependencies; no install or Flutter SDK is needed
on the host. Linux CI produces the artifact intended for a Linux host.

Local artifact verification after `pnpm build`:

```bash
node scripts/package-server.mjs
node scripts/test-server.mjs
```

The workflow prepares an artifact; it does not provision hosting or publish a
site. Choose/configure the host before deploying. Run it manually or call it
from a deployment workflow. The existing GitHub Pages workflow continues
to publish the Flutter showcases and cannot serve this Next.js server app.

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
