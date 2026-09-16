# Chromium reference fixtures

These files are browser references for Fortal's mapped Radix Themes families. They are generated from the exact `@radix-ui/themes@3.3.0` npm artifact by the sibling `tool/fortal_parity/chromium` harness.

Run `npm ci && npm run generate` from that tool directory to refresh both the computed-style JSON and the 1440×1280 screenshot. The five-column fixture contains one probe for each of the 30 mapped families across six rows. The JSON records the npm integrity, Chromium version, viewport, color profile, and font-rendering flags used for the capture.

Each probe records the resolved type run — family, weight, style, letter and word spacing, decoration line, color, thickness and offset, white space, and vertical alignment — alongside its box geometry. Kbd is probed at size 6 rather than the grid's usual size 2 because its letter spacing is an em: only a step whose `--letter-spacing-N` is non-zero shows that it resolves against Kbd's own `0.8em` font size.

Cross-engine parity compares resolved colors, geometry, layers, states, semantics, and visual intent; anti-aliasing and platform glyph rasterization may differ by at most one 8-bit channel at an edge pixel and are not compared byte-for-byte.
