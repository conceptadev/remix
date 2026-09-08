# Clean-sheet review: Remix Agent and open-code

Reviewed 2026-09-08 against open-code PR [#177](https://github.com/conceptadev/remix/pull/177),
`feat/open-code` at `a56caca3b`, and the Agent implementation preserved in
`f471317ef`. This is an architecture and distribution review, not an exhaustive
defect review or evidence that registry installation already works.

## Recommendation

Keep `remix_agent` as the reusable owner of Agent behavior. Distribute its
application-owned visual recipes through the existing CLI registry as an
optional `agent` item. Do not put a runtime dependency on `remix_cli` in Agent.

The current branch is a draft foundation for that work. **There is no Agent
registry item yet.** Hosted installation cannot be advertised while
`remix_agent` remains `publish_to: none`.

## Start from the consumer's problem

An application needs prompt editing, streaming answers, permission decisions,
tool execution, plans, activity, and a transcript that follows new output.
Those surfaces should use the application's controls and theme, and changing
an installed button recipe should also change the corresponding Agent action.
The application should not need to maintain controller ownership, IME handling,
permission latches, accessibility semantics, or scroll-follow state machines.

The old package decision separated these behaviors from Fortal, which remains
useful. Open-code changes how the visual layer should be delivered: the local
demo recipes are now candidates for installable source. It does not, by
itself, justify copying the behavior implementation into every application.

## Evidence and consequences

1. **The registry is already sufficient for the distribution graph.**
   [RegistryItem](../../remix_cli/lib/src/registry.dart#L153) supports multiple
   files, item dependencies, hosted dependencies, optional generated files,
   and exports. Its parser requires at least one authored file; it does not
   require every item to be an annotated wrapper.
   [DataTable's recipe](../../remix_cli/lib/src/registry/templates/data_table/data_table.dart.tmpl)
   already imports other installed recipes. Agent needs new entries and
   templates, not a second registry, remote registry, or installer protocol.

2. **The ownership boundary matches the base PR.**
   [Open-code's decision](../../../open_code/CLEAN_SHEET.md) keeps interaction
   and accessibility in maintained packages and installs presentation source.
   Its optional chart item is precedent for a domain dependency outside core
   Remix. Agent's [composer](../lib/src/components/composer.dart),
   [permission](../lib/src/components/permission.dart), and
   [live-edge engine](../lib/src/style/live_edge.dart) contain behavioral work
   that a visual recipe should not duplicate.

3. **A single generated Agent wrapper does not style the whole surface.**
   [AgentComposer](../lib/src/components/composer.dart#L37) has separate
   `surfaceStyle`, `fieldStyle`, `submitStyle`, and `stopStyle` parameters.
   Its `AgentComposerSpec` contains only `toolbar`. A recipe returning
   `AgentComposerStyler` cannot provide the other four values through that
   spec. The same issue appears in Permission's six child-control stylers.
   `@MixWidget(target: AgentComposer.new)` is therefore insufficient on its
   own as a complete styled Composer. This conclusion follows from the
   current API; a generated Agent consumer has not yet been exercised.

   Preserve unresolved child stylers and pass them through each child's
   `style:` parameter. Resolving nested Button/TextField/Disclosure specs in
   the parent would lose the child's own hover, focus, and expanded state.
   [Existing tests](../test/components/child_style_and_glyph_test.dart#L166)
   explicitly protect this boundary.

4. **Publication is a separate, real prerequisite.**
   [The package](../pubspec.yaml) is private. A registry dependency is a
   hosted version constraint, not a way to publish a private workspace
   sibling. The current [fresh-consumer check](../../../tool/check_open_code.dart)
   installs every catalog item against hosted dependencies. Adding Agent to
   the bundled catalog before its runtime is available would break that
   path. Develop the first consumer with explicit checkout overrides, then
   require a hosted-consumer run before shipping the registry item. Align
   runtime and generator floors with the versions actually tested; the
   stack integration updates Agent's stale floors accordingly.

5. **The example and old worksheets are not the new visual contract.**
   [Demo styles](../example/lib/demos.dart#L8) hard-code a private palette and
   duplicate base-control recipes. Replace that wiring in the eventual
   consumer with installed recipe functions and existing semantic tokens.
   [Composer's worksheet](../specs/components/composer.yaml) still claims
   fixed dimensions and motion for a now-headless component. Reconcile the
   worksheets before using their `complete` labels as acceptance evidence.
   Agent's host documentation must also account for a focused text area's
   Overlay requirement, already documented by the installed textfield recipe.

6. **Icons need an explicit appearance decision, not an incidental migration.**
   [Functional glyphs](../lib/src/style/functional_glyph.dart) use a pinned
   Lucide font and public override builders. The default registry's optional
   icons item uses `remix_ui_icons`. Preserve the working Agent defaults for
   this draft. An Agent recipe can opt into the application's aliases where
   the public builders permit it; verify uncovered tool/status glyphs before
   promising full icon replacement. Do not silently swap icon vocabularies
   or add a second mandatory font to every non-Agent consumer.

## Alternatives considered

| Choice | Benefit | Cost and judgment |
| --- | --- | --- |
| Behavior package plus registry recipes | Shared behavioral fixes; application-owned visuals; matches #177 | Requires publishing the runtime and wiring compound recipes. Recommended. |
| Copy all Agent widgets and state machines through the registry | No Agent runtime release dependency; maximum source ownership | Every app owns behavioral forks, generated specs, and accessibility fixes. Choose only if owning Agent behavior is an explicit product requirement. |
| Move Agent widgets into core `remix` | One existing published dependency | Expands the generic package with domain models and workflows. No evidence that this improves the boundary. |
| Add an Agent theme preset or global scope | Central place for defaults | Agent is a component family that should work with an existing theme. A preset would conflate component selection with theme selection. |

The strongest argument for copying all source is immediate distribution
without a new package release. That is a meaningful advantage while Agent is
private, but it changes who maintains the difficult behavior. The existing
open-code contract and Agent regression tests favor keeping that behavior
centralized. Confidence is high in the registry fit and moderate in the final
recipe ergonomics, which still need a real consumer.

## Smallest integration design

Start with one optional `agent` registry item containing a small authored
recipe file for each surface. Reuse the current schema. Splitting into
per-surface items can wait for evidence that consumers need that granularity.

| Surface | Installed recipes it should reuse |
| --- | --- |
| Composer | `card`, `textfield` (TextArea recipe), `icon_button` |
| Message and collapsible message | `card`, `button` |
| Answer | `card`, `disclosure`, `icon_button` |
| Execution | `card`, `disclosure`, `icon_button` |
| Permission | `card`, `disclosure`, `data_list`, `button` |
| Plan and Activity | `disclosure` |
| Transcript | `theme`; scrolling remains in Agent |

The aggregate item depends on the union of those recipes. Declare `icons`
only if an authored file actually imports it. Declare a real hosted
`remix_agent` floor once the publication decision is implemented. Do not
invent a version that is not available.

For the initial consumer, use application-owned typed recipe bundles or
ordinary recipe functions that supply **both** Agent anatomy and unresolved
child stylers. Explicit wiring is already possible without a runtime API or
generator change. For example, a proposed `uiAgentComposerRecipe()` can return
`style`, `surfaceStyle`, `fieldStyle`, `submitStyle`, and `stopStyle`:

```dart
// Proposed consumer API, not currently shipped.
final recipe = uiAgentComposerRecipe();

AgentComposer(
  onSubmit: submit,
  style: recipe.style,
  surfaceStyle: recipe.surfaceStyle,
  fieldStyle: recipe.fieldStyle,
  submitStyle: recipe.submitStyle,
  stopStyle: recipe.stopStyle,
)
```

The bundle calls the installed Card, TextArea, and IconButton recipe functions
and adds only Agent-specific geometry. Per-instance overrides merge into the
corresponding unresolved styler last. This keeps local recipe edits effective
without copying controller or semantics code. Use `@MixWidget` where a single
styler actually covers a surface; do not add generator features merely to hide
the compound-style wiring. Evaluate thin application adapters after the first
consumer establishes that this explicit API is too cumbersome.

## Implementation sequence and acceptance gates

1. **Preserve and stack the current foundation.** Keep this PR as a draft
   targeting `feat/open-code`, with the upstream Disclosure implementation.
   Include Agent generation and tests in the combined workspace. Keep the
   two base-button loading-announcement changes visible in the diff and
   verify them separately; registry work does not make those changes implicit.

2. **Prove one consumer before converting eight surfaces.** In a temporary
   Flutter application, install Theme, Card, TextField, and IconButton with
   the checkout CLI; use explicit checkout overrides for Agent and Remix.
   Write a Composer recipe bundle using those installed functions. Confirm
   that editing the app's IconButton recipe changes Agent Send/Stop, field
   focus styling still works, instance overrides win, IME handling and
   controller swaps still work, and the semantic tree has one field and one
   action. Supply the Overlay required by focused editable text.

3. **Set the runtime release contract.** Resolve the package's publication
   metadata, dependency floors, supported Flutter floor, provenance, and
   release/version checks. A path-based consumer is development evidence;
   it is not proof of hosted installation. Do not remove `publish_to: none`
   merely to make a registry entry look installable.

4. **Add the item and convert the catalog.** Put templates in the canonical
   registry tree, with exact exports and generated targets only where used.
   Replace demo-only base-control recipes with installed ones. Reconcile
   the behavior worksheets and package decision record with the actual
   runtime/recipe split. Do not copy a second template tree under `open_code/`.

5. **Verify installation, ownership, and behavior together.** Extend registry
   inventory and fresh-consumer checks, not only package widget tests. Cover
   dependency closure, custom prefix/path, untouched authored files on rerun,
   read-only diff, requested-item-only overwrite, generated-part preservation,
   and import isolation. Run Agent's lifecycle, semantics, controller, and
   scrolling cases against the installed recipes, then check light/dark,
   narrow/wide, and reduced-motion states in a real browser. Run a hosted
   Agent consumer before advertising the item.

## Stack placement

This Agent foundation depends on [#177](https://github.com/conceptadev/remix/pull/177)
and targets `feat/open-code`. It can be reviewed alongside Fortal
[#180](https://github.com/conceptadev/remix/pull/180), which targets the same
base; Sidebar [#178](https://github.com/conceptadev/remix/pull/178) follows Fortal.
There is no demonstrated Agent dependency on Sidebar.

Fortal #180 relocates the default registry from `registry/registry.yaml` to
`registry/default/registry.yaml` and introduces preset selection. Paths in
this review describe #177. If that refactor lands first, put the default
Agent item under the relocated default tree. If supporting the Fortal preset
becomes part of this PR's required scope, incorporate #180 and use its preset
layout; otherwise keep that recipe work separate. Do not advertise an Agent
preset: it is an item within a theme preset.

Once #177 merges, retarget this draft to `main` and refresh its base as needed,
checking the diff after any squash merge. The current draft is not a request
to merge either branch now.

## Verification for this review

The stack integration preserved the current implementation before merging
`feat/open-code`. The only conflict was in workspace membership and generation
scopes; both branches' entries were retained. The upstream Disclosure sources
and tests have no diff against the stack base.

Fresh validation on 2026-09-08:

- `fvm flutter analyze --no-pub packages/remix_agent`: no issues.
- `fvm flutter test --no-pub --reporter=failures-only packages/remix_agent/test packages/remix_agent/example/test packages/remix/test/components/button packages/remix/test/components/icon_button packages/remix/test/components/disclosure`: 284 passed.
- `fvm dart test --reporter=failures-only` in `packages/remix_cli`: 76 passed.
- `fvm dart run ../../tool/check_generated.dart` in `packages/remix_agent`:
  eight generated artifacts reproduced byte-for-byte after regenerating them
  with the base's generator. The old output lacked `StylerFieldMetadata`.
- Workspace toolchain, version alignment, consumer Mix, and Material checks:
  passed. These existing checkers do not establish Agent's hosted-release
  compatibility; the consumer Mix checker covers Remix and Fortal.
- `git diff --check`: passed; all local links in this review resolve.

The complete workspace CI command was not run locally. Registry-specific
Agent installation and fresh browser/media checks remain future integration
gates; existing package tests cannot establish those results.
