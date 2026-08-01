/**
 * Stage 2 — Normalize.
 *
 * Reads `tool/build/raw-tokens.json` and writes the repository-owned normalized
 * snapshot `tool/tokens/carbon-tokens.normalized.json`. This snapshot is the
 * committed source of truth for Dart generation, so consumers never need Node,
 * npm, network access, or the Carbon repository.
 *
 * Conversions performed here (see lib/convert.mjs for the exact rules):
 *   - colors  -> `0xAARRGGBB` ARGB hex strings
 *   - rem     -> logical pixels (16px base)
 *   - px/vw   -> logical pixels / preserved viewport-relative data
 *   - ms      -> integer milliseconds
 *   - cubic-bezier -> [x1, y1, x2, y2]
 *
 * Special semantics are preserved, not flattened: fluid spacing keeps its unit,
 * fluid type keeps its per-breakpoint overrides, and component tokens keep their
 * fallback plus any missing-theme omissions.
 *
 * Run:  node tool/normalize_tokens.mjs
 */
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import {
  cssColorToArgbHex as argbHex, parseRem, remToPx, parsePx, parseMs,
  parseCubicBezier, stableStringify, round4, THEMES,
} from './lib/convert.mjs';

const __dirname = dirname(fileURLToPath(import.meta.url));
const buildDir = join(__dirname, 'build');
const tokensDir = join(__dirname, 'tokens');

// Optional output override (used by verify_generated.mjs for a read-only check).
const outFlag = process.argv.indexOf('--out');
const outPath = outFlag !== -1
  ? process.argv[outFlag + 1]
  : join(tokensDir, 'carbon-tokens.normalized.json');

function normColorMap(map) {
  const out = {};
  for (const [k, v] of Object.entries(map)) out[k] = argbHex(v);
  return out;
}

function normComponentTokens(groups) {
  const out = {};
  const themeKeys = ['whiteTheme', 'g10', 'g90', 'g100'];
  for (const [group, tokens] of Object.entries(groups)) {
    out[group] = {};
    for (const [name, entry] of Object.entries(tokens)) {
      const norm = {};
      // Preserve fallback and only the themes actually present upstream.
      if ('fallback' in entry) norm.fallback = argbHex(entry.fallback);
      for (const tk of themeKeys) {
        if (tk in entry) norm[tk === 'whiteTheme' ? 'white' : tk] = argbHex(entry[tk]);
      }
      out[group][name] = norm;
    }
  }
  return out;
}

function normLayout(layout) {
  const spacing = layout.spacing.map((rem, i) => ({
    token: `spacing${String(i + 1).padStart(2, '0')}`,
    index: i + 1,
    px: remToPx(parseRem(rem)),
  }));
  const fluidSpacing = layout.fluidSpacing.map((v, i) => {
    const token = `fluidSpacing${String(i + 1).padStart(2, '0')}`;
    if (typeof v === 'number') return { token, value: v, unit: 'px' };
    const m = /^([\d.]+)vw$/.exec(String(v));
    if (m) return { token, value: Number(m[1]), unit: 'vw' };
    return { token, value: parsePx(v), unit: 'px' };
  });
  const sizeNames = {
    XSmall: 'xSmall', Small: 'small', Medium: 'medium',
    Large: 'large', XLarge: 'xLarge', '2XLarge': 'xxLarge',
  };
  const sizes = {};
  for (const [carbonName, dartName] of Object.entries(sizeNames)) {
    sizes[dartName] = { carbonName, px: remToPx(parseRem(layout.sizes[carbonName])) };
  }
  const containers = layout.container.map((rem, i) => ({
    token: `container${String(i + 1).padStart(2, '0')}`,
    px: remToPx(parseRem(rem)),
  }));
  const iconSizes = layout.iconSize.map((rem, i) => ({
    token: `iconSize${String(i + 1).padStart(2, '0')}`,
    px: remToPx(parseRem(rem)),
  }));
  const breakpoints = {};
  for (const [name, bp] of Object.entries(layout.breakpoints)) {
    breakpoints[name] = {
      widthPx: remToPx(parseRem(bp.width)),
      columns: bp.columns,
      marginPx: remToPx(parseRem(bp.margin)),
    };
  }
  return {
    spacing,
    fluidSpacing,
    sizes,
    containers,
    iconSizes,
    breakpoints,
    baseFontSizePx: remToPx(parseRem(layout.baseFontSize)),
    miniUnitPx: remToPx(parseRem(layout.miniUnit)),
  };
}

function normTypeStyle(style) {
  const out = {
    fontSizePx: remToPx(parseRem(style.fontSize)),
    fontWeight: style.fontWeight,
    lineHeight: round4(style.lineHeight),
    letterSpacingPx: parsePx(style.letterSpacing ?? 0),
  };
  return out;
}

function normType(type) {
  const styles = {};
  for (const [name, style] of Object.entries(type.styles)) {
    styles[name] = normTypeStyle(style);
  }
  const fluidStyles = {};
  for (const [name, style] of Object.entries(type.fluidStyles)) {
    const { breakpoints, ...base } = style;
    const overrides = {};
    for (const [bp, ov] of Object.entries(breakpoints)) {
      const o = {};
      if ('fontSize' in ov) o.fontSizePx = remToPx(parseRem(ov.fontSize));
      if ('fontWeight' in ov) o.fontWeight = ov.fontWeight;
      if ('lineHeight' in ov) o.lineHeight = round4(ov.lineHeight);
      if ('letterSpacing' in ov) o.letterSpacingPx = parsePx(ov.letterSpacing);
      overrides[bp] = o;
    }
    fluidStyles[name] = { base: normTypeStyle(base), breakpoints: overrides };
  }
  return {
    styles,
    fluidStyles,
    fontWeights: type.fontWeights,
    fontFamilies: type.fontFamilies,
  };
}

function normMotion(motion) {
  const durations = {};
  for (const [name, v] of Object.entries(motion.durations)) durations[name] = parseMs(v);
  const easings = {};
  for (const [intent, modes] of Object.entries(motion.easings)) {
    easings[intent] = {};
    for (const [mode, cb] of Object.entries(modes)) {
      easings[intent][mode] = parseCubicBezier(cb);
    }
  }
  return { durations, easings };
}

function main() {
  const raw = JSON.parse(readFileSync(join(buildDir, 'raw-tokens.json'), 'utf8'));

  const normalized = {
    $schema: 'carbon-tokens/normalized/v1',
    provenance: raw.provenance,
    palette: normColorMap(raw.palette),
    paletteFamilies: Object.fromEntries(
      Object.entries(raw.paletteFamilies).map(([k, v]) => [k, normColorMap(v)]),
    ),
    themes: Object.fromEntries(
      THEMES.map(([key]) => [key, normColorMap(raw.themeRoles[key])]),
    ),
    componentTokens: normComponentTokens(raw.componentTokens),
    layout: normLayout(raw.layout),
    type: normType(raw.type),
    motion: normMotion(raw.motion),
  };

  mkdirSync(dirname(outPath), { recursive: true });
  writeFileSync(outPath, stableStringify(normalized));
  console.log(`normalize: wrote ${outPath}`);
}

main();
