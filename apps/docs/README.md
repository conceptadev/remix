# Remix Fumadocs app

This app renders the canonical `../../docs` content with the shared Concepta
Fumadocs theme. It does not contain a second editable copy of the documentation.

## Run

Use Node 24.14+, pnpm 11.5.3, and Python 3.9+:

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
`57be8044beaf23c5414a671693b297615560095c`. pnpm fetches this GitHub dependency
over SSH and builds it; only this exact Git source is allowed to run scripts.
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
