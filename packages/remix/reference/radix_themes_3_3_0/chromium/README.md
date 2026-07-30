# Chromium reference fixtures

These files are browser references for Fortal's mapped Radix Themes families. They are generated from the exact `@radix-ui/themes@3.3.0` npm artifact by the sibling `tool/fortal_parity/chromium` harness.

Run `npm install && npm run generate` from that tool directory to refresh both the computed-style JSON and the 1440×1280 screenshot. The JSON records the npm integrity, Chromium version, viewport, color profile, and font-rendering flags used for the capture.

Cross-engine parity compares resolved colors, geometry, layers, states, semantics, and visual intent; anti-aliasing and platform glyph rasterization may differ by at most one 8-bit channel at an edge pixel and are not compared byte-for-byte.
