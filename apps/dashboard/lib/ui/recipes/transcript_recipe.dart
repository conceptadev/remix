import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

import '../components/transcript.dart';

@immutable
final class UiAgentTranscriptRecipe {
  const UiAgentTranscriptRecipe({required this.style});
  final UiTranscriptStyler style;
}

UiAgentTranscriptRecipe uiAgentTranscriptRecipe({
  UiTranscriptStyler style = const UiTranscriptStyler.create(),
}) => UiAgentTranscriptRecipe(
  style: UiTranscriptStyler(
    viewport: BoxStyler().padding(.only(right: 12)),
    item: BoxStyler(),
    spacing: 16,
  ).merge(style),
);
