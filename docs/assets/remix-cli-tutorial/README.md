# Tutorial assets

Open `docs/remix-cli-tutorial.html` with this directory beside it at `assets/remix-cli-tutorial`.
The tutorial uses local styles, scripts, fonts, screenshots, and sample projects.
The reader can open the complete tutorial without a server or an internet connection.

## Source and editing

Edit the tutorial HTML for instructions and complete code examples.
`docs/tutorials/settings-screen.mdx` is the condensed documentation walkthrough.
Its fenced code blocks use hidden `tutorial-source` markers to identify their
exact figures in the reviewed HTML; the
asset checker enforces this along with the checkout pin and local content links.
Update both presentations deliberately when instructions change. Do not add a
second independently maintained copy of the full sample applications.
Edit `tutorial.css` for layout and syntax colors. Edit `tutorial.js` for navigation, wrapping, and copying.
The page needs no build step. Keep each code block's `language-*` class consistent with its source.

The screenshot files contain actual application or editor captures.
Keep their captions and capture context accurate when replacing them.
`evidence.json` records the source checkout, toolchain, and screenshot digests.

`sample-projects.zip` contains the complete default and Fortal projects.
Its README explains how to set the local checkout paths and run the samples.

Check the recorded screenshot, archive, and sample-source hashes from the
repository root with `python3 tool/check_tutorial_assets.py`. This requires
only Python's standard library and does not extract the archive. It verifies
the recorded evidence; replay the Flutter instructions separately when the
CLI, examples, or dependencies change. `melos run docs:check` includes this check
and its regression tests. Do not update hashes to bypass a failed
check without reviewing the replacement assets.

## Third-party files

- [Prism 1.30.0](https://github.com/PrismJS/prism/tree/v1.30.0) provides syntax highlighting. Its MIT license is in `prism/LICENSE`.
- [IBM Plex Sans](https://github.com/IBM/plex) provides the text font. Its license is in `fonts/Plex-LICENSE.txt`.
- [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono) provides the code font. Its license is in `fonts/JetBrains-OFL.txt`.

The font files match the fonts embedded in `docs/remix-cli-guide.html`.
The tutorial loads the Prism language files directly. It does not use a CDN or an autoloader.
