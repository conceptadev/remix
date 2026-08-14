import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../tokens/generated/carbon_component_tokens.g.dart';
import '../../tokens/generated/carbon_tokens.g.dart';

/// Carbon toggle sizes.
enum CarbonToggleSize { regular, small }

/// Carbon's visual recipe for [RemixSwitch].
SwitchStyler carbonToggleStyle({CarbonToggleSize size = .regular}) {
  final small = size == .small;
  final width = small ? 32.0 : 48.0;
  final height = small ? 16.0 : 24.0;
  final thumbSize = small ? 10.0 : 18.0;

  return SwitchStyler()
      .size(width, height)
      .padding(.all(3))
      .borderRadius(.all(.circular(height / 2)))
      .color(CarbonTokens.toggleOff())
      .thumb(
        BoxStyler()
            .size(thumbSize, thumbSize)
            .borderRadius(.all(.circular(thumbSize / 2)))
            .color(CarbonTokens.iconOnColor()),
      )
      .trackEffects(
        RemixBoxEffectsMix(
          outline: BorderSideMix(color: const Color(0x00000000), width: 2),
          outlineOffset: 1,
        ),
      )
      .onSelected(SwitchStyler().color(CarbonTokens.supportSuccess()))
      .onFocusVisible(
        SwitchStyler().trackEffects(
          RemixBoxEffectsMix(
            outline: BorderSideMix(color: CarbonTokens.focus(), width: 2),
            outlineOffset: 1,
          ),
        ),
      )
      .onDisabled(
        SwitchStyler()
            .color(CarbonComponentTokens.buttonDisabled())
            .thumb(BoxStyler().color(CarbonTokens.iconOnColorDisabled())),
      );
}

/// A labeled Carbon toggle with visible on/off state text.
class CarbonToggle extends StatelessWidget {
  const CarbonToggle({
    super.key,
    required this.selected,
    required this.label,
    this.onChanged,
    this.enabled = true,
    this.size = .regular,
    this.labelA = 'Off',
    this.labelB = 'On',
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  });

  final bool selected;
  final String label;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final CarbonToggleSize size;
  final String labelA;
  final String labelB;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final interactive = enabled && onChanged != null;

    return GestureDetector(
      behavior: .translucent,
      excludeFromSemantics: true,
      onTap: interactive ? () => onChanged!(!selected) : null,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          ExcludeSemantics(
            child: StyledText(
              label,
              style: TextStyler()
                  .style(CarbonTokens.label01.mix())
                  .color(
                    interactive
                        ? CarbonTokens.textSecondary()
                        : CarbonTokens.textDisabled(),
                  ),
            ),
          ),
          SizedBox(height: CarbonTokens.spacing05.resolve(context)),
          Row(
            mainAxisSize: .min,
            children: [
              RemixSwitch(
                selected: selected,
                onChanged: onChanged,
                enabled: interactive,
                focusNode: focusNode,
                autofocus: autofocus,
                semanticLabel: semanticLabel ?? label,
                style: carbonToggleStyle(size: size),
              ),
              SizedBox(width: CarbonTokens.spacing03.resolve(context)),
              ExcludeSemantics(
                child: StyledText(
                  selected ? labelB : labelA,
                  style: TextStyler()
                      .style(CarbonTokens.body01.mix())
                      .color(
                        interactive
                            ? CarbonTokens.textPrimary()
                            : CarbonTokens.textDisabled(),
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
