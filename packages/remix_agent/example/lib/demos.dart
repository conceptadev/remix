import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import 'agent_recipes.dart';
import 'host.dart';

/// Example-only light/dark recipes. They are deliberately not exported by the
/// headless package.
final class _AgentDemoStyles {
  _AgentDemoStyles(this.theme);

  final HostTheme theme;

  Color get ink => theme.ink;
  Color get paper =>
      theme.dark ? const Color(0xFF1A1E28) : const Color(0xFFF7F9FB);
  Color get line => ink.withValues(alpha: 0.16);

  CardStyler get card => CardStyler()
      .color(paper)
      .border(.all(.color(line).width(1)))
      .borderRadius(.circular(12))
      .padding(.all(12));

  ButtonStyler get button => ButtonStyler()
      .color(theme.live)
      .padding(.symmetric(horizontal: 12, vertical: 15))
      .borderRadius(.circular(8))
      .label(TextStyler().color(const Color(0xFFFFFFFF)).fontSize(13));

  IconButtonStyler get utilityIconButton => IconButtonStyler()
      .size(48, 48)
      .color(const Color(0x00000000))
      .borderRadius(.circular(8))
      .iconColor(ink.withValues(alpha: 0.62))
      .iconSize(14)
      .onHovered(
        IconButtonStyler().color(ink.withValues(alpha: 0.06)).iconColor(ink),
      )
      .onPressed(IconButtonStyler().color(ink.withValues(alpha: 0.10)));

  DataListStyler get dataList =>
      DataListStyler().rowSpacing(6).columnSpacing(12);

  DisclosureStyler get disclosure => DisclosureStyler()
      .trigger(BoxStyler().padding(.symmetric(vertical: 15)))
      .content(BoxStyler().padding(.only(top: 8)));

  AgentMessageStyler get message => AgentMessageStyler(
    row: FlexBoxStyler().mainAxisSize(.max).spacing(8),
    avatar: BoxStyler().size(28, 28),
    header: BoxStyler().padding(.only(bottom: 4)),
    body: BoxStyler(),
    footer: BoxStyler().padding(.only(top: 4)),
    maxWidth: 560,
  );

  AgentMessageCollapsibleStyler get collapsible =>
      AgentMessageCollapsibleStyler(
        collapsedHeight: 72,
        container: BoxStyler(),
        clipped: BoxStyler(),
      );

  AgentPlanStyler get plan => AgentPlanStyler(
    viewport: BoxStyler().maxHeight(220),
    item: FlexBoxStyler().spacing(8).padding(.symmetric(vertical: 5)),
    summaryTitle: TextStyler().color(ink).fontSize(14),
    itemTitle: TextStyler().color(ink).fontSize(14),
    itemDetail: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    count: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    indicator: IconStyler().color(ink).size(16),
    pendingStatus: IconStyler().color(ink.withValues(alpha: 0.45)).size(18),
    activeStatus: IconStyler().color(theme.live).size(18),
    completedStatus: IconStyler().color(theme.live).size(18),
    cancelledStatus: IconStyler().color(ink.withValues(alpha: 0.45)).size(18),
  );

  AgentActivityStyler get activity => AgentActivityStyler(
    viewport: BoxStyler().maxHeight(200),
    item: FlexBoxStyler().spacing(8).padding(.symmetric(vertical: 5)),
    summaryTitle: TextStyler().color(ink).fontSize(14),
    itemTitle: TextStyler().color(ink).fontSize(14),
    itemDetail: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    indicator: IconStyler().color(ink).size(16),
    pendingStatus: IconStyler().color(ink.withValues(alpha: 0.45)).size(12),
    activeStatus: IconStyler().color(theme.live).size(12),
    completedStatus: IconStyler().color(theme.live).size(12),
  );

  AgentExecutionStyler get execution => AgentExecutionStyler(
    header: FlexBoxStyler().spacing(8),
    output: BoxStyler().color(ink.withValues(alpha: 0.05)).padding(.all(10)),
    actions: FlexBoxStyler().spacing(6).padding(.only(top: 8)),
    tool: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    title: TextStyler().color(ink).fontWeight(FontWeight.w600),
    meta: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    status: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    toolIcon: IconStyler().color(ink).size(16),
    statusIcon: IconStyler().color(theme.live).size(12),
    indicator: IconStyler().color(ink).size(16),
  );

  AgentPermissionStyler get permission => AgentPermissionStyler(
    header: FlexBoxStyler().spacing(8),
    actions: FlexBoxStyler().spacing(8).padding(.only(top: 10)),
    title: TextStyler().color(ink).fontWeight(FontWeight.w600),
    tool: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    description: TextStyler().color(ink.withValues(alpha: 0.72)),
    status: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    detailsLabel: TextStyler().color(ink).fontSize(13),
    toolIcon: IconStyler().color(ink).size(16),
    statusIcon: IconStyler().color(theme.live).size(12),
    indicator: IconStyler().color(ink).size(16),
  );

  AgentAnswerStyler get answer => AgentAnswerStyler(
    body: BoxStyler(),
    actions: FlexBoxStyler().spacing(6).padding(.only(top: 8)),
    sourcesLabel: TextStyler().color(ink).fontSize(13),
    indicator: IconStyler().color(ink).size(16),
  );

  AgentTranscriptStyler get transcript => AgentTranscriptStyler(
    viewport: BoxStyler().padding(.only(right: 12)),
    item: BoxStyler(),
    spacing: 10,
  );
}

_AgentDemoStyles _styles(BuildContext context) =>
    _AgentDemoStyles(HostTheme.of(context));

class CatalogAction extends StatelessWidget {
  const CatalogAction({
    super.key,
    required this.label,
    this.onPressed,
    this.quiet = false,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool quiet;

  @override
  Widget build(BuildContext context) {
    final styles = _styles(context);
    return RemixButton(
      label: label,
      onPressed: onPressed,
      style: quiet
          ? styles.button
                .color(styles.ink.withValues(alpha: 0.14))
                .labelColor(styles.ink)
          : styles.button,
    );
  }
}

/// The catalog's composer, styled by the installed recipes.
///
/// Both call sites go through here so the standalone demo and the composed run
/// cannot drift apart.
Widget _installedComposer({
  required ValueChanged<String> onSubmit,
  bool running = false,
  VoidCallback? onStop,
}) {
  final recipe = uiAgentComposerRecipe();

  return AgentComposer(
    style: recipe.style,
    surfaceStyle: recipe.surfaceStyle,
    fieldStyle: recipe.fieldStyle,
    submitStyle: recipe.submitStyle,
    stopStyle: recipe.stopStyle,
    running: running,
    onSubmit: onSubmit,
    onStop: onStop,
  );
}

class ComposerDemo extends StatefulWidget {
  const ComposerDemo({super.key});
  @override
  State<ComposerDemo> createState() => _ComposerDemoState();
}

class _ComposerDemoState extends State<ComposerDemo> {
  var running = false;
  String? sent;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _installedComposer(
          running: running,
          onSubmit: (value) => setState(() {
            sent = value;
            running = true;
          }),
          onStop: () => setState(() => running = false),
        ),
        if (sent != null) Text('Last sent: $sent'),
      ],
    );
  }
}

class MessageDemo extends StatelessWidget {
  const MessageDemo({super.key});
  @override
  Widget build(BuildContext context) {
    final styles = _styles(context);
    return AgentMessageGroup(
      spacing: 8,
      children: [
        AgentMessage(
          role: AgentRole.user,
          style: styles.message,
          surfaceStyle: styles.card,
          header: const Text('You'),
          child: const Text('Review the checkout flow and pause before tests.'),
        ),
        AgentMessage(
          role: AgentRole.assistant,
          style: styles.message,
          surfaceStyle: styles.card,
          header: const Text('Agent'),
          child: AgentMessageCollapsible(
            style: styles.collapsible,
            toggleStyle: styles.button,
            child: const Text(
              'I will inspect the checkout flow, map the payment path, verify the shared cart model, and pause before running focused checks. '
              'This longer message demonstrates explicit opt-in clipping.',
            ),
          ),
        ),
      ],
    );
  }
}

class TranscriptDemo extends StatefulWidget {
  const TranscriptDemo({super.key});
  @override
  State<TranscriptDemo> createState() => _TranscriptDemoState();
}

class _TranscriptDemoState extends State<TranscriptDemo> {
  var lines = 10;
  var following = true;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(following ? 'Following the live edge' : 'Reading history'),
      SizedBox(
        height: 180,
        child: AgentTranscript.builder(
          style: _styles(context).transcript,
          itemCount: lines,
          itemBuilder: (_, i) => Text('Line ${i + 1} of the growing log.'),
          onFollowChanged: (value) => setState(() => following = value),
        ),
      ),
      CatalogAction(
        label: 'Append lines',
        onPressed: () => setState(() => lines += 4),
      ),
    ],
  );
}

class PermissionDemo extends StatefulWidget {
  const PermissionDemo({super.key});
  @override
  State<PermissionDemo> createState() => _PermissionDemoState();
}

class _PermissionDemoState extends State<PermissionDemo> {
  var status = AgentPermissionStatus.pending;
  var request = 0;
  @override
  Widget build(BuildContext context) {
    final styles = _styles(context);
    return Column(
      children: [
        AgentPermission(
          requestId: request,
          style: styles.permission,
          surfaceStyle: styles.card,
          detailsStyle: styles.disclosure,
          parametersStyle: styles.dataList,
          allowOnceStyle: styles.button,
          alwaysAllowStyle: styles.button,
          denyStyle: styles.button,
          tool: 'terminal.run',
          status: status,
          description: 'Run the focused test suite.',
          parameters: const [
            RemixDataListItem(label: 'Command', value: 'flutter test'),
            RemixDataListItem(
              label: 'Directory',
              value: 'packages/remix_agent',
            ),
          ],
          onAllowOnce: () =>
              setState(() => status = AgentPermissionStatus.complete),
          onAlwaysAllow: () =>
              setState(() => status = AgentPermissionStatus.complete),
          onDeny: () => setState(() => status = AgentPermissionStatus.denied),
        ),
        CatalogAction(
          label: 'Replay',
          onPressed: () => setState(() {
            request++;
            status = AgentPermissionStatus.pending;
          }),
        ),
      ],
    );
  }
}

class ExecutionDemo extends StatefulWidget {
  const ExecutionDemo({super.key});
  @override
  State<ExecutionDemo> createState() => _ExecutionDemoState();
}

class _ExecutionDemoState extends State<ExecutionDemo> {
  var status = AgentExecutionStatus.running;
  @override
  Widget build(BuildContext context) {
    final styles = _styles(context);
    return Column(
      children: [
        AgentExecution(
          style: styles.execution,
          surfaceStyle: styles.card,
          disclosureStyle: styles.disclosure,
          copyStyle: styles.utilityIconButton,
          retryStyle: styles.utilityIconButton,
          tool: 'terminal.run',
          title: 'Focused checks',
          status: status,
          onCopy: () {},
          onRetry: () => setState(() => status = AgentExecutionStatus.running),
          child: const Text('12 passed · 0 failed'),
        ),
        CatalogAction(
          label: 'Succeed',
          onPressed: () =>
              setState(() => status = AgentExecutionStatus.success),
        ),
      ],
    );
  }
}

class PlanDemo extends StatefulWidget {
  const PlanDemo({super.key});
  @override
  State<PlanDemo> createState() => _PlanDemoState();
}

AgentPlanItemStatus _planItemStatus(int index, int currentStep) {
  if (index < currentStep) return AgentPlanItemStatus.completed;
  if (index == currentStep) return AgentPlanItemStatus.inProgress;
  return AgentPlanItemStatus.pending;
}

class _PlanDemoState extends State<PlanDemo> {
  var step = 0;
  @override
  Widget build(BuildContext context) {
    final styles = _styles(context);
    final items = List.generate(
      3,
      (i) => AgentPlanItem(
        id: '$i',
        title: ['Read the brief', 'Map the path', 'Run checks'][i],
        status: _planItemStatus(i, step),
      ),
    );
    return Column(
      children: [
        AgentPlan(
          style: styles.plan,
          disclosureStyle: styles.disclosure,
          items: items,
        ),
        CatalogAction(
          label: 'Advance',
          onPressed: () => setState(() => step = (step + 1).clamp(0, 3)),
        ),
      ],
    );
  }
}

class ActivityDemo extends StatefulWidget {
  const ActivityDemo({super.key});
  @override
  State<ActivityDemo> createState() => _ActivityDemoState();
}

class _ActivityDemoState extends State<ActivityDemo> {
  var status = AgentRunStatus.working;
  @override
  Widget build(BuildContext context) {
    final styles = _styles(context);
    return Column(
      children: [
        AgentActivity(
          style: styles.activity,
          disclosureStyle: styles.disclosure,
          status: status,
          items: [
            const AgentActivityItem(
              id: 'read',
              title: 'Reading the brief',
              status: AgentActivityItemStatus.complete,
            ),
            AgentActivityItem(
              id: 'map',
              title: 'Mapping the path',
              status: status == AgentRunStatus.working
                  ? AgentActivityItemStatus.active
                  : AgentActivityItemStatus.complete,
            ),
          ],
        ),
        CatalogAction(
          label: status == AgentRunStatus.working ? 'Complete' : 'Replay',
          onPressed: () => setState(
            () => status = status == AgentRunStatus.working
                ? AgentRunStatus.complete
                : AgentRunStatus.working,
          ),
        ),
      ],
    );
  }
}

class AnswerDemo extends StatefulWidget {
  const AnswerDemo({super.key});
  @override
  State<AnswerDemo> createState() => _AnswerDemoState();
}

class _AnswerDemoState extends State<AnswerDemo> {
  var status = AgentAnswerStatus.streaming;
  var stream = 0;
  @override
  Widget build(BuildContext context) {
    final styles = _styles(context);
    return Column(
      children: [
        AgentAnswer(
          style: styles.answer,
          surfaceStyle: styles.card,
          sourcesStyle: styles.disclosure,
          copyStyle: styles.utilityIconButton,
          retryStyle: styles.utilityIconButton,
          streamId: stream,
          status: status,
          onCopy: () {},
          onRetry: () => setState(() {
            stream++;
            status = AgentAnswerStatus.streaming;
          }),
          sourcesContent: const Text('Checkout brief · payment notes'),
          child: Text(
            status.isStreaming
                ? 'The checkout flow is…'
                : 'The checkout flow is ready for review.',
          ),
        ),
        CatalogAction(
          label: 'Complete',
          onPressed: () => setState(() => status = AgentAnswerStatus.complete),
        ),
      ],
    );
  }
}

class ComposedRunDemo extends StatelessWidget {
  const ComposedRunDemo({super.key});
  @override
  Widget build(BuildContext context) {
    final styles = _styles(context);
    return SizedBox(
      height: 420,
      child: Column(
        children: [
          Expanded(
            child: AgentTranscript(
              style: styles.transcript,
              followOutput: false,
              children: [
                AgentMessage(
                  role: AgentRole.user,
                  style: styles.message,
                  surfaceStyle: styles.card,
                  child: const Text('Review the checkout flow.'),
                ),
                AgentPlan(
                  style: styles.plan,
                  disclosureStyle: styles.disclosure,
                  items: const [
                    AgentPlanItem(
                      id: '1',
                      title: 'Inspect checkout',
                      status: AgentPlanItemStatus.inProgress,
                    ),
                  ],
                ),
                AgentPermission(
                  style: styles.permission,
                  surfaceStyle: styles.card,
                  detailsStyle: styles.disclosure,
                  parametersStyle: styles.dataList,
                  allowOnceStyle: styles.button,
                  alwaysAllowStyle: styles.button,
                  denyStyle: styles.button,
                  tool: 'terminal.run',
                  parameters: const [
                    RemixDataListItem(label: 'Command', value: 'flutter test'),
                  ],
                  onAllowOnce: () {},
                  onDeny: () {},
                ),
                AgentAnswer(
                  style: styles.answer,
                  surfaceStyle: styles.card,
                  sourcesStyle: styles.disclosure,
                  copyStyle: styles.utilityIconButton,
                  retryStyle: styles.utilityIconButton,
                  status: AgentAnswerStatus.complete,
                  child: const Text('Ready for review.'),
                ),
              ],
            ),
          ),
          _installedComposer(onSubmit: (_) {}),
        ],
      ),
    );
  }
}
