import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../../foundation/carbon_layer.dart';
import '../../icons/icons.dart';
import '../../tokens/generated/carbon_tokens.g.dart';
import '../button/carbon_button.dart';

/// Carbon code-snippet presentations.
enum CarbonCodeSnippetType { inline, single, multi }

/// Carbon code block with an owned copy action and multiline disclosure.
class CarbonCodeSnippet extends StatefulWidget {
  const CarbonCodeSnippet({
    super.key,
    required this.code,
    this.type = .single,
    this.collapsedLines = 3,
    this.copyLabel = 'Copy code',
    this.onCopy,
  }) : assert(collapsedLines > 0);

  final String code;
  final CarbonCodeSnippetType type;
  final int collapsedLines;
  final String copyLabel;
  final ValueChanged<String>? onCopy;

  @override
  State<CarbonCodeSnippet> createState() => _CarbonCodeSnippetState();
}

class _CarbonCodeSnippetState extends State<CarbonCodeSnippet> {
  var _expanded = false;

  void _copy() {
    widget.onCopy?.call(widget.code);
    unawaited(Clipboard.setData(ClipboardData(text: widget.code)));
  }

  @override
  Widget build(BuildContext context) {
    final multiline = widget.type == .multi;
    final canCollapse =
        multiline &&
        '\n'.allMatches(widget.code).length + 1 > widget.collapsedLines;
    final codeStyle = TextStyler()
        .style(
          widget.type == .inline
              ? CarbonTokens.code01.mix()
              : CarbonTokens.code02.mix(),
        )
        .color(CarbonTokens.textPrimary())
        .softWrap(multiline)
        .maxLines(canCollapse && !_expanded ? widget.collapsedLines : 1000000)
        .overflow(.clip);
    final content = Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(child: StyledText(widget.code, style: codeStyle)),
        SizedBox(width: CarbonTokens.spacing05.resolve(context)),
        CarbonIconButton(
          icon: CarbonIcons.copy,
          kind: .ghost,
          size: .sm,
          semanticLabel: widget.copyLabel,
          onPressed: _copy,
        ),
      ],
    );

    return Semantics(
      label: 'Code snippet',
      container: true,
      explicitChildNodes: true,
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          Box(
            style: BoxStyler()
                .color(CarbonLayer.of(context).color(.layer).resolve(context))
                .padding(
                  widget.type == .inline
                      ? EdgeInsetsGeometryMix.symmetric(
                          horizontal: CarbonTokens.spacing03(),
                          vertical: CarbonTokens.spacing02(),
                        )
                      : EdgeInsetsGeometryMix.all(CarbonTokens.spacing05()),
                )
                .border(
                  BoxBorderMix.all(
                    BorderSideMix(
                      color: CarbonLayer.of(
                        context,
                      ).color(.borderSubtle).resolve(context),
                      width: 1,
                    ),
                  ),
                ),
            child: content,
          ),
          if (canCollapse)
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: CarbonButton(
                label: _expanded ? 'Show less' : 'Show more',
                trailingIcon: _expanded
                    ? CarbonIcons.chevronUp
                    : CarbonIcons.chevronDown,
                kind: .ghost,
                size: .sm,
                onPressed: () => setState(() => _expanded = !_expanded),
              ),
            ),
        ],
      ),
    );
  }
}
