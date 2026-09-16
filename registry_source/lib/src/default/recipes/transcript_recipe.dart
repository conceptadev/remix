import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import '../../agent/components/transcript.dart';

@immutable
final class VanillaAgentTranscriptRecipe {
  const VanillaAgentTranscriptRecipe({required this.style});
  final AgentTranscriptStyler style;
}

VanillaAgentTranscriptRecipe vanillaAgentTranscriptRecipe({
  AgentTranscriptStyler style = const AgentTranscriptStyler.create(),
}) => VanillaAgentTranscriptRecipe(
  style: AgentTranscriptStyler(
    viewport: BoxStyler().padding(.only(right: 12)),
    item: BoxStyler(),
    spacing: 16,
  ).merge(style),
);
