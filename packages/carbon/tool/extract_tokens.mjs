/**
 * Stage 1 — Extract.
 *
 * Imports the pinned official IBM Carbon JavaScript packages (installed under
 * `tool/upstream`) and writes their fully-resolved token values to
 * `tool/build/raw-tokens.json`. Importing the executable ES modules is safer and
 * more faithful than parsing Sass/TypeScript with regular expressions.
 *
 * This stage also (re)writes `tool/upstream/carbon-source-lock.json` from the
 * pinned versions and the npm lockfile integrity hashes, so the exact upstream
 * baseline is captured alongside the extracted values.
 *
 * Run:  node tool/extract_tokens.mjs
 */
import { createRequire } from 'node:module';
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { stableStringify, THEMES } from './lib/convert.mjs';

const __dirname = dirname(fileURLToPath(import.meta.url));
const upstreamDir = join(__dirname, 'upstream');
const buildDir = join(__dirname, 'build');
const require = createRequire(join(upstreamDir, 'noop.js'));

// The Carbon research baseline (see project brief §2). Kept here so the lock and
// every generated manifest agree on provenance.
const CARBON_COMMIT = 'b288a66af010622bedc6de4d6d0b81ee3c9f5520';
const CARBON_COMMIT_DATE = '2026-07-09';
const EXTRACTION_SCHEMA_VERSION = 1;

// The pinned package versions come from the upstream manifest itself, so
// bumping upstream/package.json automatically flows into every provenance
// record (source lock, snapshot, generated manifest) — no second copy to drift.
const PINNED = JSON.parse(
  readFileSync(join(upstreamDir, 'package.json'), 'utf8'),
).dependencies;
for (const [name, version] of Object.entries(PINNED)) {
  if (!/^\d/.test(version)) {
    throw new Error(`Upstream dependency ${name} must pin an exact version, got: ${version}`);
  }
}

function loadUpstream(name) {
  return require(require.resolve(name, { paths: [upstreamDir] }));
}

function isColorString(v) {
  return typeof v === 'string' && (/^#/.test(v) || /^rgba?\(/.test(v));
}

async function main() {
  const colors = loadUpstream('@carbon/colors');
  const layout = loadUpstream('@carbon/layout');
  const motion = loadUpstream('@carbon/motion');
  const type = loadUpstream('@carbon/type');
  const themes = loadUpstream('@carbon/themes');

  // --- Primitive palette (scalar hex + family maps) ---
  const palette = {};
  const paletteFamilies = {};
  for (const [k, v] of Object.entries(colors)) {
    if (typeof v === 'string' && /^#/.test(v)) {
      palette[k] = v;
    } else if (v && typeof v === 'object' && !Array.isArray(v)) {
      const family = {};
      for (const [step, hex] of Object.entries(v)) {
        if (typeof hex === 'string' && /^#/.test(hex)) family[step] = hex;
      }
      if (Object.keys(family).length) paletteFamilies[k] = family;
    }
  }

  // --- Theme color roles (exactly the color-valued keys of each theme) ---
  const themeRoles = {};
  for (const [key] of THEMES) {
    const theme = themes[key];
    const roles = {};
    for (const [role, value] of Object.entries(theme)) {
      if (isColorString(value)) roles[role] = value;
    }
    themeRoles[key] = roles;
  }

  // --- Component tokens (per-theme values with fallbacks preserved) ---
  const componentGroups = {
    button: themes.buttonTokens.buttonTokens,
    tag: themes.tagTokens.tagTokens,
    notification: themes.notificationTokens.notificationTokens,
    status: themes.statusTokens.statusTokens,
    contentSwitcher: themes.contentSwitcherTokens.contentSwitcherTokens,
  };
  const componentTokens = {};
  for (const [group, obj] of Object.entries(componentGroups)) {
    const tokens = {};
    for (const [name, entry] of Object.entries(obj)) {
      // Preserve exactly which theme keys / fallback are present.
      tokens[name] = { ...entry };
    }
    componentTokens[group] = tokens;
  }

  // --- Layout ---
  const rawLayout = {
    spacing: layout.spacing, // array of 13 rem strings
    fluidSpacing: layout.fluidSpacing, // [0, "2vw", "5vw", "10vw"]
    sizes: layout.sizes, // {XSmall.."2XLarge"}
    container: layout.container, // array of 5 rem strings
    iconSize: layout.iconSize, // ["1rem","1.25rem"]
    breakpoints: layout.breakpoints,
    baseFontSize: layout.baseFontSize,
    miniUnit: layout.miniUnit,
  };

  // --- Type ---
  const typeStyles = {};
  const fluidTypeStyles = {};
  for (const [name, value] of Object.entries(type)) {
    if (value && typeof value === 'object' && 'fontSize' in value) {
      if ('breakpoints' in value) fluidTypeStyles[name] = value;
      else typeStyles[name] = value;
    }
  }
  const rawType = {
    styles: typeStyles,
    fluidStyles: fluidTypeStyles,
    fontWeights: type.fontWeights,
    fontFamilies: type.fontFamilies,
  };

  // --- Motion ---
  const durationNames = [
    'fast01', 'fast02', 'moderate01', 'moderate02', 'slow01', 'slow02',
    'durationFast01', 'durationFast02', 'durationModerate01',
    'durationModerate02', 'durationSlow01', 'durationSlow02',
  ];
  const durations = {};
  for (const name of durationNames) durations[name] = motion[name];
  const rawMotion = { durations, easings: motion.easings };

  const raw = {
    provenance: {
      carbonCommit: CARBON_COMMIT,
      carbonCommitDate: CARBON_COMMIT_DATE,
      license: 'Apache-2.0',
      extractionSchemaVersion: EXTRACTION_SCHEMA_VERSION,
      packages: PINNED,
    },
    palette,
    paletteFamilies,
    themeRoles,
    componentTokens,
    layout: rawLayout,
    type: rawType,
    motion: rawMotion,
  };

  mkdirSync(buildDir, { recursive: true });
  writeFileSync(join(buildDir, 'raw-tokens.json'), stableStringify(raw));

  writeSourceLock(upstreamDir);

  // Assertions guard against silent upstream drift.
  assertEqual(Object.keys(palette).length, 246, 'scalar palette colors');
  for (const [key] of THEMES) {
    assertEqual(Object.keys(themeRoles[key]).length, 234, `${key} color roles`);
  }
  const compCount = Object.values(componentTokens)
    .reduce((n, g) => n + Object.keys(g).length, 0);
  assertEqual(compCount, 78, 'component tokens');
  assertEqual(layout.spacing.length, 13, 'fixed spacing steps');

  console.log('extract: wrote build/raw-tokens.json');
  console.log(`  palette=${Object.keys(palette).length}`
    + ` roles=234x4 component=${compCount}`
    + ` type=${Object.keys(typeStyles).length}+${Object.keys(fluidTypeStyles).length}fluid`);
}

function writeSourceLock(upstreamDir) {
  const lock = JSON.parse(readFileSync(join(upstreamDir, 'package-lock.json'), 'utf8'));
  const pkgs = lock.packages || {};
  const integrity = {};
  for (const [path, meta] of Object.entries(pkgs)) {
    if (path.startsWith('node_modules/@carbon/') && meta.version && meta.integrity) {
      integrity[path.replace('node_modules/', '')] = {
        version: meta.version,
        integrity: meta.integrity,
        resolved: meta.resolved,
      };
    }
  }
  const sourceLock = {
    description: 'Pinned IBM Carbon token sources for the carbon Flutter package. '
      + 'Development-only; not required by consumers.',
    carbonRepo: 'https://github.com/carbon-design-system/carbon',
    carbonCommit: CARBON_COMMIT,
    carbonCommitDate: CARBON_COMMIT_DATE,
    license: 'Apache-2.0',
    extractionSchemaVersion: EXTRACTION_SCHEMA_VERSION,
    pinnedVersions: PINNED,
    integrity,
  };
  writeFileSync(
    join(upstreamDir, 'carbon-source-lock.json'),
    stableStringify(sourceLock),
  );
  console.log('extract: wrote upstream/carbon-source-lock.json');
}

function assertEqual(actual, expected, label) {
  if (actual !== expected) {
    throw new Error(`extract: expected ${expected} ${label}, got ${actual}`);
  }
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
