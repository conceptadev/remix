# Plan: Add Remix TextArea

> Expose Remix's existing Naked multiline editor as a discoverable constructor-only TextArea type, with correct multiline layout and a nonduplicated shared TextField semantics boundary.

## PR contract

- Title: `feat(remix): add textarea component`
- Depends on: none.
- Compatibility: additive subtype/facade plus intentional backward-compatible
  TextField accessibility and multiline-hint corrections; no migration.
- Primary outcome: `RemixTextArea` has safe multiline defaults while retaining
  the exact TextField spec, state, controller, and input pipeline, and both
  components expose label/hint/error once with independent accessory semantics.
- Out of scope: a new text-editing implementation, a second spec/styler,
  browser drag-resize/fixed-height behavior, and the Fortal recipe (PR 7).
  Flutter's `maxLines: null` auto-growth within parent constraints remains the
  documented native behavior.

## Context

- `RemixTextField` already forwards `minLines`, `maxLines`, and `expands` to `NakedTextField`, which owns editable focus/input/semantics.
- Its resolved visual tree currently aligns every hint at `AlignmentDirectional.centerStart`. That is correct for a single-line field but vertically centers a multiline placeholder.
- The same resolved tree currently places visible label, hint, helper, and
  leading/trailing accessories inside NakedTextField's `MergeSemantics`. A
  Flutter 3.44 semantics dump confirmed duplicated label/hint/helper text and
  absorption of an interactive trailing button into the field node. This PR
  must correct the shared TextField boundary rather than reproduce it in the
  new facade.
- Because `RemixTextField` is not final and TextArea changes constructor defaults only, a constructor-only subtype keeps one widget implementation and preserves identity of `TextFieldStyler` / `TextFieldSpec`.
- A composing `StatelessWidget` would work, but it would duplicate every forwarding field and add a needless widget boundary. A subtype still forwards constructor fields once while inheriting the proven build path.
- Radix 3.3 TextArea supports sizes 1-3 and classic/surface/soft variants; those are Fortal recipe concerns. Its browser `resize` prop does not map to a native Flutter drag handle.

Official references: [Radix Themes Text Area](https://www.radix-ui.com/themes/docs/components/text-area), [Flutter EditableText](https://api.flutter.dev/flutter/widgets/EditableText-class.html), and [Flutter text-field semantics testing](https://api.flutter.dev/flutter/flutter_test/matchesSemantics.html). Feature-comparison capture: `radix-reference/text-area.png` (usage and expected deltas in `radix-reference/README.md`).

## Public API

Add `part 'textarea_widget.dart';` to `components/textfield/textfield.dart`; no new library/export line or generated spec is necessary because `remix.dart` already exports the textfield library.

```dart
class RemixTextArea extends RemixTextField {
  const RemixTextArea({
    super.key,
    super.controller,
    super.focusNode,
    super.label,
    super.hintText,
    super.helperText,
    super.error,
    TextInputType? keyboardType = TextInputType.multiline,
    TextInputAction? textInputAction = TextInputAction.newline,
    super.textCapitalization,
    super.textDirection,
    super.enabled,
    super.readOnly,
    super.autofocus,
    int? maxLines,
    int? minLines = 2,
    // Forward all remaining general editing, selection, callback,
    // controller, accessory, semantics, style, and styleSpec arguments.
  }) : super(
         keyboardType: keyboardType,
         textInputAction: textInputAction,
         maxLines: maxLines,
         minLines: minLines,
         expands: false,
         obscureText: false,
       );

  static final styleFrom = TextFieldStyler.new;
}
```

Constructor rules:

- Default `maxLines: null`, `minLines: 2`, `keyboardType: TextInputType.multiline`, and `textInputAction: TextInputAction.newline`. Two lines matches the native HTML textarea default; Fortal size-specific minimum heights land in PR 7.
- Expose `minLines` and `maxLines` overrides with the same valid relationships as Flutter. Add descriptive assertions for positive values and `maxLines >= minLines` when both are non-null.
- Forward all current `RemixTextField` arguments except `obscureText`, `obscuringCharacter`, and `expands`, which are fixed to nonsecure multiline behavior. Include controller/focus/undo/group, capitalization/direction, length/input formatters, editing callbacks, cursor/selection configuration, scroll/controller physics, autofill/content insertion, restoration/IME/context menu/spellcheck/magnifier, pointer/focus flags, leading/trailing, semantics, and style/styleSpec.
- Keep `keyboardType` and `textInputAction` overridable because multiline content may still use address or done actions.
- Keep the style types named `TextFieldStyler` and `TextFieldSpec` (the canonical post-#100 names); do not introduce aliases that imply separate anatomy.

Put a class-site comment explaining the facade decision: TextArea is the same accessible editor with multiline defaults, so a forked spec/build would drift.

## Shared TextField layout and semantics corrections

In `RemixTextField._buildResolved`, derive:

```dart
final isMultiline = expands || maxLines != 1 || (minLines ?? 1) > 1;
final hintAlignment = isMultiline
    ? AlignmentDirectional.topStart
    : AlignmentDirectional.centerStart;
```

Use `hintAlignment` for both the `Stack` and filled `Align` around the hint. Preserve single-line geometry byte-for-byte otherwise. Directional alignment must put the hint at top-right under RTL.

Do not add a `textAlignVertical` public prop only to solve the placeholder: the editable and hint should agree from the component's multiline state. If testing reveals Naked's actual editable origin differs for an existing custom style, fix the shared resolved layout at the narrowest point and add a regression test; do not special-case `runtimeType == RemixTextArea`.

Restructure `RemixTextField._buildResolved` without forking the editor:

1. Keep only the styled editable plus decorative visible hint inside
   `NakedTextField.builder`; wrap the visible hint in `ExcludeSemantics`.
2. Place the resulting `NakedTextField` in the resolved container alongside
   `leading` and `trailing`, outside Naked's `MergeSemantics`. Interactive
   accessories therefore remain separate focusable/actionable semantic nodes.
3. Keep visible `label` and `helperText` outside the Naked boundary and wrap
   them in `ExcludeSemantics`; continue forwarding `semanticLabel ?? label`.
   Build one effective semantic hint from `semanticHint ?? hintText` plus a
   distinct non-error `helperText`, preserving that supporting information
   after its visual node is excluded. When `error` is true, pass `helperText`
   only as Naked's semantic error text so Naked appends it once and drives its
   live/error behavior. Ignore empty/duplicate pieces when joining with a
   newline.
4. When the component's `excludeSemantics` is true, wrap the complete composite
   in one outer `ExcludeSemantics` so the field and accessory subtree retain the
   existing full-exclusion contract.
5. Preserve the current whole-composite tap target after moving the visual
   wrapper outside Naked. Let `_RemixTextFieldBodyState` own an effective
   `FocusNode` only when the caller does not supply one, pass that node to
   Naked, and add a translucent fallback recognizer for label/helper/container
   padding. Set `excludeFromSemantics: true` (or use an equivalently semantics-
   silent recognizer) so it cannot add a second semantic tap action. Mirror
   Naked's enabled/readOnly/canRequestFocus behavior, the public `onTap` and
   `onTapAlwaysCalled` multi-tap contract, and pressed-state down/up/cancel
   transitions into the existing style controller. Inner editable-selection
   gestures and interactive accessories must win their gesture arenas, so the
   fallback neither changes selection nor focuses/double-activates the field for
   those regions. Swap and dispose only internally owned nodes, including
   internal-to-external-to-internal replacement.

Preserve the resolved visual tree, hit regions, state-controller updates, and
one-line geometry while moving only semantic boundaries. This is an intentional
accessibility behavior correction for existing `RemixTextField`; call it out in
the PR description and changelog/release note if the package uses one.

Alternatives rejected:

- Copy `RemixTextField` into a new widget/spec — duplicates a large, security-sensitive input surface.
- Compose and manually forward to a private TextField instance — adds another boundary without more isolation and still duplicates the constructor list.
- Use `expands: true` by default — Flutter requires incompatible line settings and a bounded parent; it is not Radix's normal TextArea behavior.
- Implement a browser-like resize handle — platform-specific behavior outside this parity series.

## Work breakdown

- [ ] Task 1: Add failing facade and default tests.
  - Files: new `packages/remix/test/components/textfield/textarea_widget_test.dart`, both public-API tests.
  - Inspect the descendant `EditableText`/Naked configuration for default line count, input type/action, and fixed nonsecure/nonexpanding behavior.
  - Acceptance: public construction and default assertions fail before the part exists.

- [ ] Task 2: Add failing hint and semantics regressions.
  - Files: `textarea_widget_test.dart`, existing `textfield_widget_test.dart`.
  - Cover top-start hint geometry in LTR/RTL, center-start single-line
    regression, label/hint/non-error-helper/error exactly once,
    read-only/disabled and
    multiline flags, a decorative accessory, and a trailing `IconButton` that
    remains a distinct semantic/action node. Pin taps on label, helper, and
    container padding plus accessory taps so the semantics refactor does not
    narrow or double-activate the existing hit region. Cover consecutive/double
    taps with `onTapAlwaysCalled` false/true, fallback down/up/cancel pressed
    styling, semantic tap-action counts, and internal/external/internal
    `FocusNode` replacement and disposal.

- [ ] Task 3: Implement the constructor-only subtype and shared TextField fixes.
  - Files: `packages/remix/lib/src/components/textfield/textfield.dart`, new `textarea_widget.dart`, `textfield_widget.dart`.
  - Land the shared TextField hint/semantics corrections as their own commit(s),
    green against the complete existing textfield test directory, before the
    facade commit, so the behavior correction to the shipped component stays
    independently bisectable inside the PR.
  - Forward the complete supported constructor surface; add the facade rationale comment.
  - Acceptance: `RemixTextArea` inherits the exact existing `build` and
    introduces no override/spec/style state; moving label/hint/helper/accessory
    boundaries produces no resolved-style, geometry, hit-target, callback, or
    caller-focus-node ownership change.

- Checkpoint: run all textfield tests, including existing Fortal disabled tests, before docs/playground changes.

- [ ] Task 4: Prove styling and dynamic behavior are identical.
  - Files: `textarea_widget_test.dart`.
  - Test fluent `TextFieldStyler`, raw `TextFieldSpec`, independent
    leading/trailing interactive semantics, controller replacement, focus,
    text entry with newline, line override validation, and error state updates.
  - Acceptance: there are no `textarea_spec_test.dart` or `textarea_style_test.dart` files because there are no corresponding production types.

- [ ] Task 5: Add docs and playground.
  - Files: `docs/components/textarea.mdx`, root `docs.json`, `packages/playground/lib/registry/entries/textarea_entry.dart`, registry.
  - Show basic, labeled/helper/error, controlled controller, max-length, disabled/read-only, and custom Remix styling. Document constraints/lines instead of web resize.

- [ ] Task 6: Capture light/dark screenshots and validate.
  - Include empty focused (top hint), filled multiline, error, and disabled states.
  - PR reuse note names `RemixTextField` and `NakedTextField` and states there is zero new spec/styler/editable machinery.

## Test strategy

### Defaults/input

- Default descendant is multiline with `maxLines == null`, `minLines == 2`, multiline keyboard, newline action, `expands == false`, and `obscureText == false`.
- Entering `first\nsecond` preserves the newline and calls `onChanged` with the complete value.
- Explicit valid line/input-action overrides are forwarded; invalid ranges assert clearly.
- Controller, focus node, undo controller, restoration ID, formatters, max length, callbacks, and selection flags reach the same underlying editor.

### Semantics

- One node exposes text-field and multiline flags plus the effective semantic
  label, hint, non-error helper, or error exactly once; visible
  label/hint/helper text is excluded beneath that owner.
- Disabled/read-only states and actions match `RemixTextField`/Naked behavior.
- Decorative leading/trailing content does not duplicate the field name, while
  interactive accessories remain separate named nodes with their own actions.
- The semantics-silent fallback contributes no action of its own; the field has
  one semantic tap action, and an interactive accessory has only its separate
  action.
- `excludeSemantics` removes the full TextField/TextArea composite, including accessories.

### Styling/layout

- Empty multiline hint top-aligns and uses leading direction in LTR/RTL.
- Existing one-line TextField hint remains vertically centered.
- Fluent and raw TextField style inputs resolve without conversion or loss.
- Text wraps/grows within min/max line constraints at 200% scale and narrow width without overflow.

### Manual

- Type multiple paragraphs and navigate/select using keyboard and pointer.
- Inspect empty/filled/focused/error/disabled states in both directions and brightnesses.
- Verify no drag-resize affordance is implied in docs or UI.

## Acceptance criteria

- [ ] TextArea is only a public constructor/default layer over the existing TextField implementation.
- [ ] Multiline defaults and fixed nonsecure/nonexpanding contract are explicit and tested.
- [ ] Multiline hints top-align directionally; single-line TextField is unchanged.
- [ ] Existing TextField and new TextArea announce label/hint/error once and preserve interactive accessories as separate nodes.
- [ ] Exact multiline/accessibility states are covered once.
- [ ] No TextArea spec, styler, generated wrapper, or duplicate editable state is introduced.
- [ ] Public API, docs, nav, playground, screenshots, and the shared validation gate are complete.

## Risks and mitigations

- Risk: the parent constructor gains a field that TextArea fails to forward. Mitigation: a public-API compatibility test constructs every supported category; class comment directs future fields to the facade.
- Risk: subtype assumptions break if TextField becomes final. Mitigation: this PR owns both in one library; a future finalization must migrate the facade intentionally.
- Risk: top alignment changes custom multiline TextFields. Mitigation: that is the bug fix; lock single-line behavior and multiline LTR/RTL geometry in regression tests.
- Risk: moving accessories outside Naked's merge boundary changes visual or
  hit-test layout. Mitigation: retain the same resolved container/child order,
  lift only effective FocusNode ownership into the existing state body, add a
  semantics-silent translucent outer tap fallback that loses to real child
  gestures, and pin coordinate, multi-tap, pressed down/up/cancel, semantic-
  action, callback-count, and focus-node lifecycle regressions.
- Risk: a small `maxLines` conflicts with default `minLines: 2`. Mitigation: descriptive assertion and docs showing both overrides together.

## Validation and rollout

Run `fvm flutter test test/components/textfield`, then the shared gate. This is
additive and unflagged, with the disclosed shared accessibility correction.
Rollback removes the facade and reverts both shared TextField corrections; no
persisted data or Fortal parity family changes until PR 7.
