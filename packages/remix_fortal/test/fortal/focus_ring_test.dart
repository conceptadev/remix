import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remix/remix.dart';
import 'package:remix_fortal/remix_fortal.dart';

/// Pins [fortalFocusRing] to the literal borders the recipes used before they
/// shared it. Toggle, toggle group, tabs, and accordion each had their own
/// copy; if the helper ever drifts, these fail instead of four focus rings
/// silently changing at once.
void main() {
  test('default ring matches the toggle border it replaced', () {
    expect(
      ToggleStyler().fortalFocusRing(),
      equals(
        ToggleStyler().borderAll(
          color: FortalTokens.focusA8(),
          width: FortalTokens.focusRingWidth(),
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
    );
  });

  test('default ring matches the toggle group border it replaced', () {
    expect(
      ToggleGroupItemStyler().fortalFocusRing(),
      equals(
        ToggleGroupItemStyler().borderAll(
          color: FortalTokens.focusA8(),
          width: FortalTokens.focusRingWidth(),
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
    );
  });

  test('tabs keeps solid focus-8 and an unset strokeAlign', () {
    // The one caller that differs. `strokeAlign: null` must stay absent rather
    // than pick up the parameter default — passing null explicitly is what
    // bypasses it.
    expect(
      TabStyler().fortalFocusRing(
        color: FortalTokens.focus8(),
        strokeAlign: null,
      ),
      equals(
        TabStyler().borderAll(
          color: FortalTokens.focus8(),
          width: FortalTokens.focusRingWidth(),
        ),
      ),
    );
  });

  test('box ring matches the accordion trigger border it replaced', () {
    expect(
      FlexBoxStyler().fortalFocusRing(),
      equals(
        FlexBoxStyler().borderAll(
          color: FortalTokens.focusA8(),
          width: FortalTokens.focusRingWidth(),
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
    );
  });

  test('tabs is the only ring that differs from the default', () {
    // Guards the open question recorded on fortalFocusRing: if someone
    // unifies tabs onto focus-a8, this fails and forces the decision to be
    // made deliberately rather than as a drive-by.
    expect(
      TabStyler().fortalFocusRing(color: FortalTokens.focus8()),
      isNot(equals(TabStyler().fortalFocusRing())),
    );
  });
}
