import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.action,
  });

  final IconData icon;
  final String title;
  final String body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 340),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 24),
          child: Column(
            mainAxisSize: .min,
            spacing: 10,
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: .center,
                decoration: BoxDecoration(
                  color: MixScope.tokenOf(FortalTokens.gray4, context),
                  shape: .circle,
                ),
                child: Icon(
                  icon,
                  color: MixScope.tokenOf(FortalTokens.gray9, context),
                ),
              ),
              StyledText(
                title,
                style: TextStyler(style: FortalTokens.text3.mix())
                    .fontWeight(.w600)
                    .color(FortalTokens.gray12())
                    .textAlign(.center),
              ),
              StyledText(
                body,
                style: TextStyler(
                  style: FortalTokens.text2.mix(),
                ).color(FortalTokens.gray11()).textAlign(.center),
              ),
              if (action case final action?) ...[
                const SizedBox(height: 4),
                action,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
