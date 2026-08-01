/**
 * Stage 3 — Generate Dart.
 *
 * Reads the committed normalized snapshot `tool/tokens/carbon-tokens.normalized.json`
 * and emits strongly-typed Dart token declarations, resolved theme maps,
 * responsive type data, `Duration`s, `Cubic`s and a source manifest into
 * `lib/src/tokens/generated/`.
 *
 * Note on tooling: the project brief sketches this stage as `generate_tokens.dart`.
 * Because the whole extraction pipeline is Node-based (importing the official
 * Carbon ES modules), the emitter is implemented in Node too, so CI and
 * contributors need only a single toolchain to reproduce the generated files.
 * See docs/adr/0001-carbon-token-pipeline.md.
 *
 * Run:  node tool/generate_tokens.mjs
 */
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import { dartIdentifier, THEMES } from './lib/convert.mjs';

const __dirname = dirname(fileURLToPath(import.meta.url));
const tokensDir = join(__dirname, 'tokens');

// Optional output override (used by verify_generated.mjs for a read-only check).
const outFlag = process.argv.indexOf('--out');
const outDir = outFlag !== -1
  ? process.argv[outFlag + 1]
  : join(__dirname, '..', 'lib', 'src', 'tokens', 'generated');

const snapshot = JSON.parse(
  readFileSync(join(tokensDir, 'carbon-tokens.normalized.json'), 'utf8'),
);
const P = snapshot.provenance;

// ---- formatting helpers -----------------------------------------------------

/** Format a number as a Dart double literal (always with a decimal point). */
function d(n) {
  if (typeof n !== 'number' || !Number.isFinite(n)) {
    throw new Error(`Not a finite number: ${n}`);
  }
  return Number.isInteger(n) ? n.toFixed(1) : String(n);
}

/** `0xFF0F62FE` -> `Color(0xFF0F62FE)`. Guards against unparsed values. */
function color(hex) {
  if (!/^0x[0-9A-F]{8}$/.test(hex)) {
    throw new Error(`Not a normalized ARGB literal: ${hex}`);
  }
  return `Color(${hex})`;
}

function header(title, sourceLine) {
  return [
    '// GENERATED CODE - DO NOT MODIFY BY HAND.',
    `// ${title}`,
    '//',
    `// Source: IBM Carbon Design System (${P.license})`,
    `//   repo commit ${P.carbonCommit} (${P.carbonCommitDate})`,
    `//   ${sourceLine}`,
    '// Regenerate: node tool/generate_tokens.mjs',
    '// SPDX-License-Identifier: Apache-2.0',
    '',
  ].join('\n');
}

const files = {};
function emit(name, content) {
  files[name] = content.replace(/[ \t]+$/gm, '').replace(/\n{3,}/g, '\n\n');
}

// Guard: every generated Dart identifier must be unique and legal.
function uniq(names, label) {
  const seen = new Set();
  for (const n of names) {
    dartIdentifier(n);
    if (seen.has(n)) throw new Error(`Duplicate ${label} identifier: ${n}`);
    seen.add(n);
  }
}

// ---- token key namespaces ---------------------------------------------------

const KEY = {
  role: (n) => `carbon.color.${n}`,
  comp: (n) => `carbon.comp.${n}`,
  space: (n) => `carbon.space.${n}`,
  type: (n) => `carbon.type.${n}`,
  motion: (n) => `carbon.motion.${n}`,
  fontWeight: (n) => `carbon.fontWeight.${n}`,
};

const roleNames = Object.keys(snapshot.themes.white).sort();
const typeNames = Object.keys(snapshot.type.styles).sort();
const fluidNames = Object.keys(snapshot.type.fluidStyles).sort();
const spacing = snapshot.layout.spacing;
const containers = snapshot.layout.containers;
const iconSizes = snapshot.layout.iconSizes;
const sizeEntries = Object.entries(snapshot.layout.sizes)
  .sort(([a], [b]) => a.localeCompare(b));
const durationNames = Object.keys(snapshot.motion.durations)
  .filter((n) => n.startsWith('duration')).sort();
const weightNames = [
  ['fontWeightLight', 300], ['fontWeightRegular', 400], ['fontWeightSemibold', 600],
];
const sizeTokenName = (dartName) =>
  'size' + dartName[0].toUpperCase() + dartName.slice(1);

// ============================================================================
// carbon_palette.g.dart
// ============================================================================
{
  const names = Object.keys(snapshot.palette).sort();
  uniq(names, 'palette');
  const lines = names.map(
    (n) => `  static const Color ${dartIdentifier(n)} = ${color(snapshot.palette[n])};`,
  );
  emit('carbon_palette.g.dart',
    header('IBM Carbon primitive color palette.',
      `@carbon/colors ${P.packages['@carbon/colors']} (${names.length} scalar colors)`)
    + "import 'package:flutter/widgets.dart';\n\n"
    + '/// The IBM Design Language primitive palette (scalar colors).\n'
    + '///\n'
    + '/// These are raw palette values. Prefer role tokens (`CarbonTokens.*`) resolved\n'
    + '/// by `CarbonScope` in component code; use the palette only where a primitive is\n'
    + '/// genuinely required.\n'
    + 'class CarbonPalette {\n'
    + '  CarbonPalette._();\n\n'
    + lines.join('\n') + '\n'
    + '}\n');
}

// ============================================================================
// carbon_tokens.g.dart  (public token handles)
// ============================================================================
{
  const idents = [
    ...roleNames,
    ...spacing.map((s) => s.token),
    ...containers.map((c) => c.token),
    ...iconSizes.map((c) => c.token),
    ...sizeEntries.map(([dartName]) => sizeTokenName(dartName)),
    ...typeNames,
    ...durationNames,
    ...weightNames.map(([n]) => n),
  ];
  uniq(idents, 'CarbonTokens');

  const section = (title) => `\n  // ${'='.repeat(74)}\n  // ${title}\n  // ${'='.repeat(74)}\n`;
  const parts = [];
  parts.push(section(`Color role tokens (${roleNames.length}) — identical set across all four themes`));
  parts.push(roleNames.map(
    (n) => `  static const ${dartIdentifier(n)} = ColorToken('${KEY.role(n)}');`).join('\n'));

  parts.push(section(`Fixed spacing scale (${spacing.length} steps: 2..160px)`));
  parts.push(spacing.map(
    (s) => `  static const ${s.token} = SpaceToken('${KEY.space(s.token)}');`).join('\n'));

  parts.push(section('Layout container sizes'));
  parts.push(containers.map(
    (c) => `  static const ${c.token} = SpaceToken('${KEY.space(c.token)}');`).join('\n'));

  parts.push(section('Icon sizes'));
  parts.push(iconSizes.map(
    (c) => `  static const ${c.token} = SpaceToken('${KEY.space(c.token)}');`).join('\n'));

  parts.push(section('Control sizes (24..80px)'));
  parts.push(sizeEntries.map(
    ([dartName]) => `  static const ${sizeTokenName(dartName)} = SpaceToken('${KEY.space(sizeTokenName(dartName))}');`).join('\n'));

  parts.push(section(`Fixed type styles (${typeNames.length})`));
  parts.push(typeNames.map(
    (n) => `  static const ${dartIdentifier(n)} = TextStyleToken('${KEY.type(n)}');`).join('\n'));

  parts.push(section(`Motion durations (${durationNames.length})`));
  parts.push(durationNames.map(
    (n) => `  static const ${n} = DurationToken('${KEY.motion(n)}');`).join('\n'));

  parts.push(section('Font weights (300 / 400 / 600)'));
  parts.push(weightNames.map(
    ([n]) => `  static const ${n} = FontWeightToken('${KEY.fontWeight(n)}');`).join('\n'));

  // Indexed role families: every role family with 01/02/03 layer levels,
  // grouped mechanically so the layer model can be validated against upstream.
  const familyNames = roleNames
    .filter((n) => n.endsWith('01')
      && roleNames.includes(n.slice(0, -2) + '02')
      && roleNames.includes(n.slice(0, -2) + '03'))
    .map((n) => n.slice(0, -2))
    .sort();
  const familyEntries = familyNames.map((f) =>
    `  '${f}': [CarbonTokens.${f}01, CarbonTokens.${f}02, CarbonTokens.${f}03],`);

  emit('carbon_tokens.g.dart',
    header('Public Carbon token handles.',
      `@carbon/themes ${P.packages['@carbon/themes']}, @carbon/layout ${P.packages['@carbon/layout']}, @carbon/type ${P.packages['@carbon/type']}, @carbon/motion ${P.packages['@carbon/motion']}`)
    + "import 'package:mix/mix.dart';\n\n"
    + '/// Strongly-typed handles for every Carbon design token.\n'
    + '///\n'
    + '/// Resolve to concrete values inside a `CarbonScope`, e.g.\n'
    + '/// `CarbonTokens.background()` or `$box.color.ref(CarbonTokens.layer01)`.\n'
    + 'class CarbonTokens {\n'
    + '  CarbonTokens._();\n'
    + parts.join('\n') + '\n'
    + '}\n\n'
    + '/// Every indexed role family (levels 01–03), grouped from the theme roles.\n'
    + '/// The contextual layer model resolves against these; a test asserts the\n'
    + `/// hand-written aliases cover every family here (${familyNames.length} at this baseline).\n`
    + 'const Map<String, List<ColorToken>> carbonIndexedRoleFamilies = {\n'
    + familyEntries.join('\n') + '\n};\n');
}

// ============================================================================
// carbon_themes.g.dart  (resolved role colors per theme)
// ============================================================================
{
  const themeFns = [];
  for (const [themeKey, dartName] of THEMES) {
    const roles = snapshot.themes[themeKey];
    const entries = roleNames.map(
      (n) => `  CarbonTokens.${dartIdentifier(n)}: ${color(roles[n])},`);
    themeFns.push(
      `/// Resolved color roles for the Carbon ${dartName} theme (${roleNames.length} roles).\n`
      + `final Map<ColorToken, Color> carbonRoleColors${dartName} = {\n`
      + entries.join('\n') + '\n};\n');
  }
  emit('carbon_themes.g.dart',
    header('Resolved color roles for the four Carbon themes.',
      `@carbon/themes ${P.packages['@carbon/themes']} (white, g10, g90, g100)`)
    + "import 'package:flutter/widgets.dart';\n"
    + "import 'package:mix/mix.dart';\n\n"
    + "import 'carbon_tokens.g.dart';\n\n"
    + themeFns.join('\n'));
}

// ============================================================================
// carbon_component_tokens.g.dart
// ============================================================================
{
  const groups = snapshot.componentTokens;
  const allNames = [];
  const declLines = [];
  const groupMeta = [];
  for (const group of Object.keys(groups).sort()) {
    const names = Object.keys(groups[group]).sort();
    declLines.push(`\n  // ${group} (${names.length})`);
    for (const n of names) {
      allNames.push(n);
      declLines.push(`  static const ${dartIdentifier(n)} = ColorToken('${KEY.comp(n)}');`);
    }
    groupMeta.push(`  '${group}': [\n`
      + names.map((n) => `    CarbonComponentTokens.${dartIdentifier(n)},`).join('\n')
      + '\n  ],');
  }
  uniq(allNames, 'CarbonComponentTokens');

  // Per-theme resolution: value = theme value, else fallback, else omitted.
  const themeFns = [];
  for (const [themeKey, dartName] of THEMES) {
    const lines = [];
    for (const group of Object.keys(groups).sort()) {
      for (const n of Object.keys(groups[group]).sort()) {
        const entry = groups[group][n];
        const value = entry[themeKey] ?? entry.fallback;
        if (value) {
          lines.push(`  CarbonComponentTokens.${dartIdentifier(n)}: ${color(value)},`);
        }
        // Missing theme value with no fallback is preserved as an omission.
      }
    }
    themeFns.push(
      `/// Resolved component-token colors for the ${dartName} theme.\n`
      + `/// Tokens with no ${themeKey} value and no fallback are intentionally omitted.\n`
      + `final Map<ColorToken, Color> carbonComponentColors${dartName} = {\n`
      + lines.join('\n') + '\n};\n');
  }

  emit('carbon_component_tokens.g.dart',
    header('Namespaced Carbon component-token colors.',
      `@carbon/themes ${P.packages['@carbon/themes']} component-tokens (${allNames.length} tokens)`)
    + "import 'package:flutter/widgets.dart';\n"
    + "import 'package:mix/mix.dart';\n\n"
    + '/// Component-specific color tokens (Button, Tag, Notification, Status,\n'
    + '/// Content Switcher). Namespaced separately from theme role tokens.\n'
    + 'class CarbonComponentTokens {\n'
    + '  CarbonComponentTokens._();\n'
    + declLines.join('\n') + '\n'
    + '}\n\n'
    + '/// Component tokens grouped by the Carbon component that owns them.\n'
    + 'const Map<String, List<ColorToken>> carbonComponentTokenGroups = {\n'
    + groupMeta.join('\n') + '\n};\n\n'
    + themeFns.join('\n'));
}

// ============================================================================
// carbon_layout.g.dart
// ============================================================================
{
  const spacingVals = [
    ...spacing.map((s) => `  CarbonTokens.${s.token}: ${d(s.px)},`),
    ...containers.map((c) => `  CarbonTokens.${c.token}: ${d(c.px)},`),
    ...iconSizes.map((c) => `  CarbonTokens.${c.token}: ${d(c.px)},`),
    ...sizeEntries.map(([dartName, s]) => `  CarbonTokens.${sizeTokenName(dartName)}: ${d(s.px)},`),
  ];
  const bpOrder = ['sm', 'md', 'lg', 'xlg', 'max'];
  const bps = bpOrder.filter((k) => snapshot.layout.breakpoints[k]).map((k) => {
    const b = snapshot.layout.breakpoints[k];
    return `  CarbonBreakpointData(name: '${k}', width: ${d(b.widthPx)}, columns: ${b.columns}, margin: ${d(b.marginPx)}),`;
  });
  const fluid = snapshot.layout.fluidSpacing.map(
    (f) => `  CarbonFluidSpaceData(${d(f.value)}, CarbonSpaceUnit.${f.unit}),`);
  const controlSizes = sizeEntries.map(
    ([dartName, s]) => `  '${dartName}': ${d(s.px)},`);

  emit('carbon_layout.g.dart',
    header('Carbon layout values (spacing, sizes, breakpoints, fluid spacing).',
      `@carbon/layout ${P.packages['@carbon/layout']}`)
    + "import 'package:mix/mix.dart';\n\n"
    + "import '../carbon_token_types.dart';\n"
    + "import 'carbon_tokens.g.dart';\n\n"
    + '/// Fixed spacing, container, icon and control-size token values (logical px).\n'
    + 'final Map<SpaceToken, double> carbonSpacingValues = {\n'
    + spacingVals.join('\n') + '\n};\n\n'
    + `/// The 13-step fixed spacing scale in logical pixels.\n`
    + `const List<double> carbonFixedSpacingPx = [${spacing.map((s) => d(s.px)).join(', ')}];\n\n`
    + '/// Responsive breakpoints, ordered small to large.\n'
    + 'const List<CarbonBreakpointData> carbonBreakpoints = [\n'
    + bps.join('\n') + '\n];\n\n'
    + '/// Fluid spacing steps (viewport-relative data preserved).\n'
    + 'const List<CarbonFluidSpaceData> carbonFluidSpacing = [\n'
    + fluid.join('\n') + '\n];\n\n'
    + '/// Control sizes (default heights) in logical pixels, keyed by size name.\n'
    + 'const Map<String, double> carbonControlSizePx = {\n'
    + controlSizes.join('\n') + '\n};\n');
}

// ============================================================================
// carbon_type.g.dart
// ============================================================================
{
  const styleEntry = (name, s) => {
    const props = [
      s.fontSizePx != null ? `fontSize: ${d(s.fontSizePx)}` : null,
      s.fontWeight != null ? `fontWeight: FontWeight.w${s.fontWeight}` : null,
      s.lineHeight != null ? `height: ${d(s.lineHeight)}` : null,
      s.letterSpacingPx != null ? `letterSpacing: ${d(s.letterSpacingPx)}` : null,
    ].filter(Boolean);
    return `  CarbonTokens.${dartIdentifier(name)}: TextStyle(${props.join(', ')}),`;
  };
  const fixed = typeNames.map((n) => styleEntry(n, snapshot.type.styles[n]));

  const dataLiteral = (s) => {
    const props = [
      s.fontSizePx != null ? `fontSize: ${d(s.fontSizePx)}` : null,
      s.fontWeight != null ? `fontWeight: ${s.fontWeight}` : null,
      s.lineHeight != null ? `lineHeight: ${d(s.lineHeight)}` : null,
      s.letterSpacingPx != null ? `letterSpacing: ${d(s.letterSpacingPx)}` : null,
    ].filter(Boolean);
    return `CarbonTextStyleData(${props.join(', ')})`;
  };
  const fluidEntries = fluidNames.map((n) => {
    const fs = snapshot.type.fluidStyles[n];
    const bpKeys = Object.keys(fs.breakpoints).sort();
    const bpLines = bpKeys.map(
      (bp) => `      '${bp}': ${dataLiteral(fs.breakpoints[bp])},`);
    return `  '${n}': CarbonFluidTypeStyle(\n`
      + `    base: ${dataLiteral(fs.base)},\n`
      + `    breakpoints: {\n${bpLines.join('\n')}\n    },\n`
      + '  ),';
  });

  const weights = weightNames.map(
    ([n, v]) => `  CarbonTokens.${n}: FontWeight.w${v},`);

  // CSS font stacks are unusable as a Flutter `fontFamily` (which expects one
  // registered family name). Split each stack into the primary family plus a
  // `fontFamilyFallback`-shaped list.
  const families = Object.entries(snapshot.type.fontFamilies)
    .sort(([a], [b]) => a.localeCompare(b))
    .flatMap(([k, stack]) => {
      const parts = String(stack)
        .split(',')
        .map((p) => p.trim().replace(/^['"]|['"]$/g, ''))
        .filter(Boolean);
      const [family, ...fallback] = parts;
      return [
        `  /// Primary family of Carbon's \`${k}\` stack. Register the font asset`,
        '  /// in the app before using it.',
        `  static const String ${k} = ${JSON.stringify(family)};`,
        '',
        `  /// Fallback families of Carbon's \`${k}\` stack, for \`TextStyle.fontFamilyFallback\`.`,
        `  static const List<String> ${k}Fallback = [`,
        ...fallback.map((f) => `    ${JSON.stringify(f)},`),
        '  ];',
        '',
      ];
    });
  // Trim trailing blank entry.
  if (families[families.length - 1] === '') families.pop();

  emit('carbon_type.g.dart',
    header('Carbon typography: fixed styles, fluid styles, weights, families.',
      `@carbon/type ${P.packages['@carbon/type']}`)
    + "import 'package:flutter/widgets.dart';\n"
    + "import 'package:mix/mix.dart';\n\n"
    + "import '../carbon_token_types.dart';\n"
    + "import 'carbon_tokens.g.dart';\n\n"
    + `/// Fixed (non-responsive) Carbon text styles (${typeNames.length}).\n`
    + 'final Map<TextStyleToken, TextStyle> carbonTextStyleTokens = {\n'
    + fixed.join('\n') + '\n};\n\n'
    + `/// Responsive Carbon type styles with per-breakpoint overrides (${fluidNames.length}).\n`
    + 'const Map<String, CarbonFluidTypeStyle> carbonFluidTypeStyles = {\n'
    + fluidEntries.join('\n') + '\n};\n\n'
    + '/// Font-weight token values.\n'
    + 'final Map<FontWeightToken, FontWeight> carbonFontWeightValues = {\n'
    + weights.join('\n') + '\n};\n\n'
    + '/// IBM Plex font families from Carbon\'s official stacks, split into a\n'
    + '/// primary family name (for `TextStyle.fontFamily`) and fallback list\n'
    + '/// (for `TextStyle.fontFamilyFallback`).\n'
    + 'class CarbonFontFamilies {\n'
    + '  CarbonFontFamilies._();\n\n'
    + families.join('\n') + '\n'
    + '}\n');
}

// ============================================================================
// carbon_motion.g.dart
// ============================================================================
{
  const durs = durationNames.map(
    (n) => `  CarbonTokens.${n}: Duration(milliseconds: ${snapshot.motion.durations[n]}),`);
  const easingConsts = [];
  for (const intent of Object.keys(snapshot.motion.easings).sort()) {
    for (const mode of Object.keys(snapshot.motion.easings[intent]).sort()) {
      const [x1, y1, x2, y2] = snapshot.motion.easings[intent][mode];
      const name = intent + mode[0].toUpperCase() + mode.slice(1);
      easingConsts.push(
        `  static const Cubic ${name} = Cubic(${d(x1)}, ${d(y1)}, ${d(x2)}, ${d(y2)});`);
    }
  }
  emit('carbon_motion.g.dart',
    header('Carbon motion durations and easing curves.',
      `@carbon/motion ${P.packages['@carbon/motion']}`)
    + "import 'package:flutter/widgets.dart';\n"
    + "import 'package:mix/mix.dart';\n\n"
    + "import 'carbon_tokens.g.dart';\n\n"
    + '/// Motion duration token values.\n'
    + 'final Map<DurationToken, Duration> carbonDurationValues = {\n'
    + durs.join('\n') + '\n};\n\n'
    + '/// Carbon easing curves by intent (standard/entrance/exit) and mode\n'
    + '/// (productive/expressive), as Flutter [Cubic] curves.\n'
    + 'class CarbonEasings {\n'
    + '  CarbonEasings._();\n\n'
    + easingConsts.join('\n') + '\n'
    + '}\n');
}

// ============================================================================
// carbon_source_manifest.g.dart
// ============================================================================
{
  const pkgLines = Object.entries(P.packages)
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([k, v]) => `    '${k}': '${v}',`);
  emit('carbon_source_manifest.g.dart',
    header('Provenance for the generated Carbon token set.',
      'source manifest')
    + '/// Records exactly which upstream sources produced the generated tokens.\n'
    + 'class CarbonSourceManifest {\n'
    + '  CarbonSourceManifest._();\n\n'
    + `  static const String carbonCommit = '${P.carbonCommit}';\n`
    + `  static const String carbonCommitDate = '${P.carbonCommitDate}';\n`
    + `  static const String license = '${P.license}';\n`
    + `  static const int extractionSchemaVersion = ${P.extractionSchemaVersion};\n\n`
    + '  /// Pinned official npm package versions used for extraction.\n'
    + '  static const Map<String, String> packageVersions = {\n'
    + pkgLines.join('\n') + '\n  };\n\n'
    + `  static const int roleColorCount = ${roleNames.length};\n`
    + `  static const int paletteColorCount = ${Object.keys(snapshot.palette).length};\n`
    + `  static const int componentTokenCount = ${
        Object.values(snapshot.componentTokens).reduce((n, g) => n + Object.keys(g).length, 0)};\n`
    + '}\n');
}

// ---- write ------------------------------------------------------------------
mkdirSync(outDir, { recursive: true });
for (const [name, content] of Object.entries(files)) {
  writeFileSync(join(outDir, name), content);
}
console.log(`generate: wrote ${Object.keys(files).length} Dart files to lib/src/tokens/generated/`);
for (const name of Object.keys(files).sort()) {
  console.log(`  ${name} (${files[name].split('\n').length} lines)`);
}
