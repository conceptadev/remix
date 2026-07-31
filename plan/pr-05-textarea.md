# Plan: Add Remix TextArea

> Expose Remix's existing Naked multiline editor as a discoverable constructor-only TextArea type, with correct top-aligned placeholder behavior.

## PR contract

- Title: `feat(remix): add textarea component`
- Depends on: none.
- Compatibility: additive subtype/facade plus one backward-compatible multiline hint fix; no migration.
- Primary outcome: `RemixTextArea` has safe multiline defaults while retaining the exact TextField spec, state, semantics, controller, and input pipeline.
- Out of scope: a new text-editing implementation, a second spec/styler, browser drag-resize, auto-growing beyond Flutter line/constraint behavior, and the Fortal recipe (PR 7).

## Context

- `RemixTextField` already forwards `minLines`, `maxLines`, and `expands` to `NakedTextField`, which owns editable focus/input/semantics.
- Its resolved visual tree currently aligns every hint at `AlignmentDirectional.centerStart`. That is correct for a single-line field but vertically centers a multiline placeholder.
- Because `RemixTextField` is not final and TextArea changes constructor defaults only, a constructor-only subtype keeps one widget implementation and preserves identity of `RemixTextFieldStyler` / `RemixTextFieldSpec`.
- A composing `StatelessWidget` would work, but it would duplicate every forwarding field and add a needless widget boundary. A subtype still forwards constructor fields once while inheriting the proven build path.
- Radix 3.3 TextArea supports sizes 1-3 and classic/surface/soft variants; those are Fortal recipe concerns. Its browser `resize` prop does not map to a native Flutter drag handle.

Official references: [Radix Themes Text Area](https://www.radix-ui.com/themes/docs/components/text-area), [Flutter EditableText](https://api.flutter.dev/flutter/widgets/EditableText-class.html), and [Flutter text-field semantics testing](https://api.flutter.dev/flutter/flutter_test/matchesSemantics.html).

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
    int? minLines = 3,
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

  static final styleFrom = RemixTextFieldStyler.new;
}
```

Constructor rules:

- Default `maxLines: null`, `minLines: 3`, `keyboardType: TextInputType.multiline`, and `textInputAction: TextInputAction.newline`.
- Expose `minLines` and `maxLines` overrides with the same valid relationships as Flutter. Add descriptive assertions for positive values and `maxLines >= minLines` when both are non-null.
- Forward all current `RemixTextField` arguments except `obscureText`, `obscuringCharacter`, and `expands`, which are fixed to nonsecure multiline behavior. Include controller/focus/undo/group, capitalization/direction, length/input formatters, editing callbacks, cursor/selection configuration, scroll/controller physics, autofill/content insertion, restoration/IME/context menu/spellcheck/magnifier, pointer/focus flags, leading/trailing, semantics, and style/styleSpec.
- Keep `keyboardType` and `textInputAction` overridable because multiline content may still use address or done actions.
- Keep the style types named `RemixTextFieldStyler` and `RemixTextFieldSpec`; do not introduce aliases that imply separate anatomy.

Put a class-site comment explaining the facade decision: TextArea is the same accessible editor with multiline defaults, so a forked spec/build would drift.

## Shared hint-alignment fix

In `RemixTextField._buildResolved`, derive:

```dart
final isMultiline = expands || maxLines != 1 || (minLines ?? 1) > 1;
final hintAlignment = isMultiline
    ? AlignmentDirectional.topStart
    : AlignmentDirectional.centerStart;
```

Use `hintAlignment` for both the `Stack` and filled `Align` around the hint. Preserve single-line geometry byte-for-byte otherwise. Directional alignment must put the hint at top-right under RTL.

Do not add a `textAlignVertical` public prop only to solve the placeholder: the editable and hint should agree from the component's multiline state. If testing reveals Naked's actual editable origin differs for an existing custom style, fix the shared resolved layout at the narrowest point and add a regression test; do not special-case `runtimeType == RemixTextArea`.

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
  - Cover top-start hint geometry in LTR/RTL, center-start single-line regression, label/hint/error/read-only/disabled semantics, and multiline flag.

- [ ] Task 3: Implement the constructor-only subtype and shared alignment fix.
  - Files: `packages/remix/lib/src/components/textfield/textfield.dart`, new `textarea_widget.dart`, `textfield_widget.dart`.
  - Forward the complete supported constructor surface; add the facade rationale comment.
  - Acceptance: `RemixTextArea` inherits the exact existing `build` and introduces no override/spec/style state.

- Checkpoint: run all textfield tests, including existing Fortal disabled tests, before docs/playground changes.

- [ ] Task 4: Prove styling and dynamic behavior are identical.
  - Files: `textarea_widget_test.dart`.
  - Test fluent `RemixTextFieldStyler`, raw `RemixTextFieldSpec`, leading/trailing widgets, controller replacement, focus, text entry with newline, line override validation, and error state updates.
  - Acceptance: there are no `textarea_spec_test.dart` or `textarea_style_test.dart` files because there are no corresponding production types.

- [ ] Task 5: Add docs and playground.
  - Files: `docs/components/textarea.mdx`, root `docs.json`, `packages/playground/lib/registry/entries/textarea_entry.dart`, registry.
  - Show basic, labeled/helper/error, controlled controller, max-length, disabled/read-only, and custom Remix styling. Document constraints/lines instead of web resize.

- [ ] Task 6: Capture light/dark screenshots and validate.
  - Include empty focused (top hint), filled multiline, error, and disabled states.
  - PR reuse note names `RemixTextField` and `NakedTextField` and states there is zero new spec/styler/editable machinery.

## Test strategy

### Defaults/input

- Default descendant is multiline with `maxLines == null`, `minLines == 3`, multiline keyboard, newline action, `expands == false`, and `obscureText == false`.
- Entering `first\nsecond` preserves the newline and calls `onChanged` with the complete value.
- Explicit valid line/input-action overrides are forwarded; invalid ranges assert clearly.
- Controller, focus node, undo controller, restoration ID, formatters, max length, callbacks, and selection flags reach the same underlying editor.

### Semantics

- One node exposes text-field and multiline flags plus the effective semantic label/hint/error.
- Disabled/read-only states and actions match `RemixTextField`/Naked behavior.
- Leading/trailing visual content does not duplicate the field name.
- `excludeSemantics` behaves identically to TextField.

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
- [ ] Exact multiline/accessibility states are covered once.
- [ ] No TextArea spec, styler, generated wrapper, or duplicate editable state is introduced.
- [ ] Public API, docs, nav, playground, screenshots, and the shared validation gate are complete.

## Risks and mitigations

- Risk: the parent constructor gains a field that TextArea fails to forward. Mitigation: a public-API compatibility test constructs every supported category; class comment directs future fields to the facade.
- Risk: subtype assumptions break if TextField becomes final. Mitigation: this PR owns both in one library; a future finalization must migrate the facade intentionally.
- Risk: top alignment changes custom multiline TextFields. Mitigation: that is the bug fix; lock single-line behavior and multiline LTR/RTL geometry in regression tests.
- Risk: a small `maxLines` conflicts with default `minLines: 3`. Mitigation: descriptive assertion and docs showing both overrides together.

## Validation and rollout

Run `fvm flutter test test/components/textfield`, then the shared gate. This is additive and unflagged. Rollback removes the facade and reverts the narrow hint-alignment change; no persisted data or Fortal parity family changes until PR 7.
