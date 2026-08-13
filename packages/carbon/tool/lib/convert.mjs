/**
 * Shared, deterministic conversion helpers used by the extraction, normalization
 * and Dart generation stages. Keeping them in one module guarantees that the
 * normalized snapshot and the generated Dart agree on every rounding rule.
 *
 * Carbon values are authored for the web (rem / px / rgba / cubic-bezier). These
 * helpers translate them into the primitives Flutter and Mix expect (ARGB ints,
 * logical pixels, height ratios, Cubic control points) with documented rules.
 */

/** Carbon's rem base is a fixed 16px. Only applied at generation time. */
export const REM_BASE_PX = 16;

/**
 * The four Carbon themes as [upstreamKey, dartSuffix] pairs — the single
 * source of truth for every pipeline stage that iterates themes.
 */
export const THEMES = [
  ['white', 'White'],
  ['g10', 'G10'],
  ['g90', 'G90'],
  ['g100', 'G100'],
];

/** Convert a rem value (number) to logical pixels. */
export function remToPx(rem) {
  return round4(rem * REM_BASE_PX);
}

/** Parse a numeric rem string like "1.5rem" (or a bare "0") to a number of rem. */
export function parseRem(value) {
  if (typeof value === 'number') return value;
  const s = value.trim();
  if (s === '0') return 0;
  const m = /^(-?[\d.]+)rem$/.exec(s);
  const n = m ? Number(m[1]) : NaN;
  if (Number.isNaN(n)) throw new Error(`Not a rem value: ${value}`);
  return n;
}

/** Parse a px string like "0.16px" or a number to logical pixels. */
export function parsePx(value) {
  if (typeof value === 'number') return value;
  const s = String(value).trim();
  if (s === '0') return 0;
  const m = /^(-?[\d.]+)px$/.exec(s);
  const n = m ? Number(m[1]) : NaN;
  if (Number.isNaN(n)) throw new Error(`Not a px value: ${value}`);
  return n;
}

/** Round to 4 decimal places to keep generation byte-stable across runs. */
export function round4(n) {
  return Math.round(n * 1e4) / 1e4;
}

/**
 * Parse a CSS color (hex `#rgb`/`#rrggbb`/`#rrggbbaa`, `rgb()`, `rgba()`) into
 * channel integers. Alpha uses the documented rule `round(a * 255)`.
 */
export function parseColor(input) {
  const s = String(input).trim();
  if (s.startsWith('#')) {
    let hex = s.slice(1);
    if (hex.length === 3) {
      hex = hex.split('').map((c) => c + c).join('');
    }
    if (hex.length === 6) {
      return {
        a: 255,
        r: parseInt(hex.slice(0, 2), 16),
        g: parseInt(hex.slice(2, 4), 16),
        b: parseInt(hex.slice(4, 6), 16),
      };
    }
    if (hex.length === 8) {
      return {
        r: parseInt(hex.slice(0, 2), 16),
        g: parseInt(hex.slice(2, 4), 16),
        b: parseInt(hex.slice(4, 6), 16),
        a: parseInt(hex.slice(6, 8), 16),
      };
    }
    throw new Error(`Unsupported hex color: ${input}`);
  }
  const m = /^rgba?\(([^)]+)\)$/.exec(s);
  if (m) {
    // Handles both legacy `rgb(r, g, b, a)` and CSS Color 4 `rgb(r g b / a)`,
    // where channels may be `%` and alpha may be `0.3` or `30%`.
    let body = m[1].trim();
    let alphaToken = null;
    const slash = body.indexOf('/');
    if (slash !== -1) {
      alphaToken = body.slice(slash + 1).trim();
      body = body.slice(0, slash).trim();
    }
    const parts = body.split(/[\s,]+/).filter(Boolean);
    const channel = (p) => p.endsWith('%')
      ? Math.round((Number(p.slice(0, -1)) / 100) * 255)
      : Math.round(Number(p));
    const r = channel(parts[0]);
    const g = channel(parts[1]);
    const b = channel(parts[2]);
    if (alphaToken === null && parts.length > 3) alphaToken = parts[3];
    const a = alphaToken === null
      ? 255
      : alphaToken.endsWith('%')
        ? Math.round((Number(alphaToken.slice(0, -1)) / 100) * 255)
        : Math.round(Number(alphaToken) * 255);
    if ([a, r, g, b].some((n) => Number.isNaN(n))) {
      throw new Error(`Unsupported color: ${input}`);
    }
    return { a, r, g, b };
  }
  throw new Error(`Unsupported color: ${input}`);
}

/** Convert a CSS color to a 0xAARRGGBB integer. */
export function colorToArgb(input) {
  const { a, r, g, b } = parseColor(input);
  return ((a << 24) >>> 0) + (r << 16) + (g << 8) + b;
}

/**
 * Format a CSS color as the normalized `0xAARRGGBB` literal used in the
 * snapshot and validated by the Dart emitter. Single formatting rule for the
 * whole pipeline.
 */
export function cssColorToArgbHex(input) {
  return '0x' + colorToArgb(input).toString(16).toUpperCase().padStart(8, '0');
}

/** Parse a duration string like "70ms" to integer milliseconds. */
export function parseMs(value) {
  if (typeof value === 'number') return value;
  const m = /^([\d.]+)ms$/.exec(String(value).trim());
  if (!m) throw new Error(`Not a ms duration: ${value}`);
  return Number(m[1]);
}

/** Parse `cubic-bezier(x1, y1, x2, y2)` into `[x1, y1, x2, y2]` numbers. */
export function parseCubicBezier(value) {
  const m = /^cubic-bezier\(([^)]+)\)$/.exec(String(value).trim());
  if (!m) throw new Error(`Not a cubic-bezier: ${value}`);
  const nums = m[1].split(',').map((p) => round4(Number(p.trim())));
  if (nums.length !== 4 || nums.some((n) => Number.isNaN(n))) {
    throw new Error(`Malformed cubic-bezier: ${value}`);
  }
  return nums;
}

/** Deterministic JSON stringify with sorted object keys. */
export function stableStringify(value) {
  return JSON.stringify(sortDeep(value), null, 2) + '\n';
}

function sortDeep(value) {
  if (Array.isArray(value)) return value.map(sortDeep);
  if (value && typeof value === 'object') {
    const out = {};
    for (const key of Object.keys(value).sort()) {
      out[key] = sortDeep(value[key]);
    }
    return out;
  }
  return value;
}

/** Lower-camel a token identifier and guard against Dart reserved words. */
const DART_RESERVED = new Set([
  'assert', 'break', 'case', 'catch', 'class', 'const', 'continue', 'default',
  'do', 'else', 'enum', 'extends', 'false', 'final', 'finally', 'for', 'if',
  'in', 'is', 'new', 'null', 'rethrow', 'return', 'super', 'switch', 'this',
  'throw', 'true', 'try', 'var', 'void', 'while', 'with', 'abstract', 'as',
  'covariant', 'deferred', 'dynamic', 'export', 'external', 'factory', 'get',
  'implements', 'import', 'interface', 'library', 'mixin', 'operator', 'part',
  'set', 'static', 'typedef', 'on', 'base', 'sealed', 'when', 'required',
  'late', 'extension', 'Function', 'hide', 'show', 'sync', 'async', 'await',
  'yield', 'Never',
]);

export function dartIdentifier(name) {
  if (DART_RESERVED.has(name)) {
    throw new Error(`Token name collides with Dart reserved word: ${name}`);
  }
  if (!/^[a-zA-Z_$][a-zA-Z0-9_$]*$/.test(name)) {
    throw new Error(`Token name is not a valid Dart identifier: ${name}`);
  }
  return name;
}
