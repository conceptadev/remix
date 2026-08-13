/// Carbon for Flutter — an IBM Carbon Design System implementation built on the
/// Remix, Naked UI and Mix foundations.
///
/// This entry point exposes only the public Carbon surface (scopes, tokens and
/// components). It deliberately does **not** re-export the full Remix or Mix API;
/// import those packages directly for advanced, lower-level styling.
library carbon;

// ---------------------------------------------------------------------------
// Foundation
// ---------------------------------------------------------------------------
export 'src/foundation/carbon_scope.dart';
export 'src/foundation/carbon_theme.dart'
    show CarbonTheme, CarbonThemeOverrides;
export 'src/foundation/carbon_layer.dart';
export 'src/foundation/carbon_layout_scope.dart';
export 'src/foundation/carbon_type.dart';
export 'src/foundation/carbon_motion.dart';

// ---------------------------------------------------------------------------
// Tokens (public handles, shared types, provenance)
// ---------------------------------------------------------------------------
export 'src/tokens/carbon_token_types.dart';
export 'src/tokens/generated/carbon_tokens.g.dart';
export 'src/tokens/generated/carbon_palette.g.dart';
export 'src/tokens/generated/carbon_source_manifest.g.dart';
export 'src/tokens/generated/carbon_component_tokens.g.dart'
    show CarbonComponentTokens, carbonComponentTokenGroups;
export 'src/tokens/generated/carbon_layout.g.dart'
    show
        carbonFixedSpacingPx,
        carbonBreakpoints,
        carbonFluidSpacing,
        carbonControlSizePx;
export 'src/tokens/generated/carbon_type.g.dart'
    show carbonFluidTypeStyles, CarbonFontFamilies;
export 'src/tokens/generated/carbon_motion.g.dart' show CarbonEasings;

// ---------------------------------------------------------------------------
// Components
// ---------------------------------------------------------------------------
export 'src/components/button/button.dart';
