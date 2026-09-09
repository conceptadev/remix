import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import 'agent_recipes.dart';
import 'host.dart';
import 'motion.dart';
import 'ui/ui.dart';

/// Example-only light/dark recipes. They are deliberately not exported by the
/// headless package.
final class _AgentDemoStyles {
  _AgentDemoStyles(this.theme, {required this.narrow, required this.feedback});

  final AnimationConfig? feedback;

  final bool narrow;

  final HostTheme theme;

  Color get ink => theme.ink;
  Color get paper =>
      theme.dark ? const Color(0xFF1A1E28) : const Color(0xFFF7F9FB);
  Color get line => ink.withValues(alpha: 0.16);

  CardStyler get card => CardStyler()
      .color(paper)
      .border(.all(.color(line).width(1)))
      .borderRadius(.circular(12))
      .padding(.all(16));

  ButtonStyler get button => uiButtonStyle(
    style: ButtonStyler(
      animation: feedback,
    ).minHeight(48).padding(.horizontal(12)),
  );

  ButtonStyler get quietButton => uiButtonStyle(
    variant: .outline,
    style: ButtonStyler(
      animation: feedback,
    ).minHeight(48).padding(.horizontal(12)),
  );

  ButtonStyler get ghostButton => uiButtonStyle(
    variant: .ghost,
    style: ButtonStyler(
      animation: feedback,
    ).minHeight(48).padding(.horizontal(12)),
  );

  ButtonStyler decision(ButtonStyler style) =>
      narrow ? style.width(double.infinity) : style;

  IconButtonStyler get utilityIconButton => uiIconButtonStyle(
    variant: .ghost,
    style: IconButtonStyler(animation: feedback).size(48, 48),
  );

  DataListStyler get dataList =>
      DataListStyler().rowSpacing(6).columnSpacing(12);

  DisclosureStyler get disclosure => DisclosureStyler()
      .trigger(BoxStyler().minHeight(48).padding(.symmetric(vertical: 8)))
      .content(BoxStyler().padding(.only(top: 8)));

  // The trigger already reserves 48px. Avoid stacking another content inset
  // above the first row; keep the row spacing and outer card inset intact.
  DisclosureStyler get ledger => disclosure
      .content(BoxStyler().padding(.all(0)))
      .container(
        BoxStyler()
            .color(paper)
            .border(.all(.color(line).width(1)))
            .borderRadius(.circular(12))
            .padding(.symmetric(horizontal: 16, vertical: 8)),
      );

  AgentMessageStyler get message => AgentMessageStyler(
    row: FlexBoxStyler().mainAxisSize(.max).spacing(8),
    avatar: BoxStyler().size(28, 28),
    header: BoxStyler().padding(.only(bottom: 6)),
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
    item: FlexBoxStyler().spacing(6).padding(.symmetric(vertical: 6)),
    summaryTitle: TextStyler()
        .color(ink)
        .fontSize(14)
        .fontWeight(FontWeight.w600),
    itemTitle: TextStyler().color(ink).fontSize(14),
    itemDetail: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    count: TextStyler()
        .color(ink.withValues(alpha: 0.62))
        .fontSize(12)
        .wrap(.padding(.only(right: 8))),
    indicator: IconStyler().color(ink).size(16),
    pendingStatus: IconStyler().color(ink.withValues(alpha: 0.45)).size(18),
    activeStatus: IconStyler().color(theme.live).size(18),
    completedStatus: IconStyler().color(theme.live).size(18),
    cancelledStatus: IconStyler().color(ink.withValues(alpha: 0.45)).size(18),
  );

  // Keep 12px status marks centered in the same 18px slot as Plan's glyphs.
  // With the 6px row gap, both ledgers share the tool headers' 24px text gutter.
  IconStyler _leadingStatus(Color color) =>
      IconStyler().color(color).size(12).wrap(.padding(.horizontal(3)));

  AgentActivityStyler get activity => AgentActivityStyler(
    viewport: BoxStyler().maxHeight(200),
    item: FlexBoxStyler().spacing(6).padding(.symmetric(vertical: 6)),
    summaryTitle: TextStyler()
        .color(ink)
        .fontSize(14)
        .fontWeight(FontWeight.w600),
    itemTitle: TextStyler().color(ink).fontSize(14),
    itemDetail: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    indicator: IconStyler().color(ink).size(16),
    pendingStatus: _leadingStatus(ink.withValues(alpha: 0.45)),
    activeStatus: _leadingStatus(theme.live),
    completedStatus: _leadingStatus(theme.live),
  );

  AgentExecutionStyler get execution => AgentExecutionStyler(
    header: FlexBoxStyler().spacing(8),
    output: BoxStyler()
        .color(ink.withValues(alpha: 0.05))
        .borderRadius(.circular(6))
        .padding(.all(12)),
    actions: FlexBoxStyler().spacing(6).padding(.only(top: 8)),
    tool: TextStyler()
        .color(ink.withValues(alpha: 0.62))
        .fontSize(12)
        .wrap(.padding(.only(top: 4))),
    title: TextStyler().color(ink).fontWeight(FontWeight.w600),
    meta: TextStyler().color(ink.withValues(alpha: 0.62)).fontSize(12),
    status: TextStyler()
        .color(ink.withValues(alpha: 0.72))
        .fontSize(12)
        .wrap(.padding(.symmetric(horizontal: 6))),
    toolIcon: IconStyler().color(ink).size(16),
    statusIcon: IconStyler().color(theme.live).size(12),
    indicator: IconStyler().color(ink).size(16),
  );

  AgentPermissionStyler get permission => AgentPermissionStyler(
    header: FlexBoxStyler().spacing(8),
    actions: FlexBoxStyler()
        .direction(narrow ? .vertical : .horizontal)
        .crossAxisAlignment(narrow ? .stretch : .center)
        .spacing(8)
        .padding(.only(top: 8)),
    title: TextStyler().color(ink).fontWeight(FontWeight.w600),
    tool: TextStyler()
        .color(ink.withValues(alpha: 0.62))
        .fontSize(12)
        .wrap(.padding(.directional(start: 24, top: 4))),
    description: TextStyler()
        .color(ink.withValues(alpha: 0.72))
        .wrap(.padding(.symmetric(vertical: 8))),
    status: TextStyler()
        .color(ink.withValues(alpha: 0.72))
        .fontSize(12)
        .wrap(.padding(.symmetric(horizontal: 6))),
    detailsLabel: TextStyler().color(ink).fontSize(13),
    toolIcon: IconStyler().color(ink).size(16),
    statusIcon: _leadingStatus(theme.live),
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
    spacing: 16,
  );
}

_AgentDemoStyles _styles(BuildContext context) => _AgentDemoStyles(
  HostTheme.of(context),
  narrow: MediaQuery.sizeOf(context).width < 600,
  feedback: catalogMotion(context, quick: true),
);

class CatalogAction extends StatelessWidget {
  const CatalogAction({
    super.key,
    required this.label,
    this.onPressed,
    this.quiet = true,
  });
  final String label;
  final VoidCallback? onPressed;
  final bool quiet;

  @override
  Widget build(BuildContext context) {
    final styles = _styles(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: RemixButton(
          label: label,
          onPressed: onPressed,
          enabled: onPressed != null,
          style: quiet ? styles.quietButton : styles.button,
        ),
      ),
    );
  }
}

/// The catalog's composer, styled by the installed recipes.
///
/// Both call sites go through here so the standalone demo and the composed run
/// cannot drift apart.
Widget _installedComposer(
  BuildContext context, {
  required ValueChanged<String> onSubmit,
  bool running = false,
  VoidCallback? onStop,
}) {
  final feedback = catalogMotion(context, quick: true);
  final recipe = uiAgentComposerRecipe(
    submitStyle: IconButtonStyler(animation: feedback),
    stopStyle: IconButtonStyler(animation: feedback),
  );

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
          context,
          running: running,
          onSubmit: (value) => setState(() {
            sent = value;
            running = true;
          }),
          onStop: () => setState(() => running = false),
        ),
        if (sent != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text('Last sent: $sent', style: HostTheme.of(context).meta),
          ),
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
      spacing: 16,
      children: [
        AgentMessage(
          role: AgentRole.user,
          style: styles.message,
          surfaceStyle: styles.card,
          header: Text('You', style: HostTheme.of(context).meta),
          child: const Text('Review the checkout flow and pause before tests.'),
        ),
        AgentMessage(
          role: AgentRole.assistant,
          style: styles.message,
          surfaceStyle: styles.card,
          header: Text('Agent', style: HostTheme.of(context).meta),
          child: AgentMessageCollapsible(
            style: styles.collapsible,
            toggleStyle: styles.ghostButton,
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
  final _scroll = ScrollController();
  var lines = 10;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  var following = true;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      RemixCard(
        style: _styles(context).card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              following ? 'Following the live edge' : 'Reading history',
              style: HostTheme.of(context).meta,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(
                  context,
                ).copyWith(scrollbars: false),
                child: RawScrollbar(
                  controller: _scroll,
                  thumbVisibility: true,
                  thumbColor: HostTheme.of(context).ink.withValues(alpha: 0.45),
                  child: AgentTranscript.builder(
                    controller: _scroll,
                    style: _styles(context).transcript,
                    itemCount: lines,
                    itemBuilder: (_, i) =>
                        Text('Line ${i + 1} of the growing log.'),
                    onFollowChanged: (value) =>
                        setState(() => following = value),
                  ),
                ),
              ),
            ),
          ],
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
          indicatorBuilder: catalogChevron,
          surfaceStyle: styles.card,
          detailsStyle: styles.disclosure,
          parametersStyle: styles.dataList,
          allowOnceStyle: styles.decision(styles.button),
          alwaysAllowStyle: styles.decision(styles.quietButton),
          denyStyle: styles.decision(styles.ghostButton),
          tool: 'terminal.run',
          status: status,
          description:
              'Run the focused test suite. Always allow applies only '
              'to this command in this demo session.',
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

String _executionOutput(AgentExecutionStatus status) => switch (status) {
  .running => 'Running the focused test suite…',
  .success => '12 passed · 0 failed',
  .error => 'Checkout validation failed. Review the output and retry.',
  .cancelled => 'Checks stopped before completion.',
};

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
          indicatorBuilder: catalogChevron,
          surfaceStyle: styles.card,
          disclosureStyle: styles.disclosure,
          copyStyle: styles.utilityIconButton,
          retryStyle: styles.utilityIconButton,
          tool: 'terminal.run',
          title: 'Focused checks',
          status: status,
          onCopy: () =>
              Clipboard.setData(ClipboardData(text: _executionOutput(status))),
          onRetry: () => setState(() => status = AgentExecutionStatus.running),
          child: Text(_executionOutput(status)),
        ),
        CatalogAction(
          label: status.isWorking ? 'Succeed' : 'Replay',
          onPressed: () => setState(
            () => status = status.isWorking
                ? AgentExecutionStatus.success
                : AgentExecutionStatus.running,
          ),
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
          indicatorBuilder: catalogChevron,
          disclosureStyle: styles.ledger,
          items: items,
        ),
        CatalogAction(
          label: step < 3 ? 'Advance' : 'Replay',
          onPressed: () => setState(() => step = step < 3 ? step + 1 : 0),
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
          indicatorBuilder: catalogChevron,
          disclosureStyle: styles.ledger,
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
          sourcesIndicatorBuilder: catalogChevron,
          surfaceStyle: styles.card,
          sourcesStyle: styles.disclosure,
          copyStyle: styles.utilityIconButton,
          retryStyle: styles.utilityIconButton,
          streamId: stream,
          status: status,
          onCopy: () => Clipboard.setData(
            const ClipboardData(text: 'The checkout flow is ready for review.'),
          ),
          onRetry: () => setState(() {
            stream++;
            status = AgentAnswerStatus.streaming;
          }),
          sourcesContent: status.isStreaming
              ? null
              : const Text('Checkout brief · payment notes'),
          child: Text(
            status.isStreaming
                ? 'Writing the answer…'
                : 'The checkout flow is ready for review.',
          ),
        ),
        CatalogAction(
          label: 'Complete',
          onPressed: status.isStreaming
              ? () => setState(() => status = AgentAnswerStatus.complete)
              : null,
        ),
      ],
    );
  }
}

enum _RunStage { permission, running, complete, denied, cancelled }

/// A deterministic host-owned run; no model or terminal is contacted.
class ComposedRunDemo extends StatefulWidget {
  const ComposedRunDemo({super.key});

  @override
  State<ComposedRunDemo> createState() => _ComposedRunDemoState();
}

class _ComposedRunDemoState extends State<ComposedRunDemo> {
  var stage = _RunStage.permission;
  var request = 0;
  var prompt = 'Review the checkout flow.';

  void _start(String value) => setState(() {
    prompt = value;
    request++;
    stage = _RunStage.permission;
  });

  @override
  Widget build(BuildContext context) {
    final styles = _styles(context);
    final working = stage == _RunStage.running;
    final complete = stage == _RunStage.complete;
    final stopped = stage == _RunStage.denied || stage == _RunStage.cancelled;
    final output = _executionOutput(
      complete
          ? AgentExecutionStatus.success
          : stopped
          ? AgentExecutionStatus.cancelled
          : AgentExecutionStatus.running,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AgentTranscript(
          style: styles.transcript.viewport(BoxStyler().padding(.all(0))),
          followOutput: false,
          children: [
            AgentMessage(
              key: ValueKey('message-$request'),
              role: AgentRole.user,
              style: styles.message,
              surfaceStyle: styles.card,
              child: Text(prompt),
            ),
            AgentPlan(
              key: ValueKey('plan-$request'),
              style: styles.plan,
              indicatorBuilder: catalogChevron,
              disclosureStyle: styles.ledger,
              items: [
                const AgentPlanItem(
                  id: 'inspect',
                  title: 'Inspect checkout',
                  status: .completed,
                ),
                AgentPlanItem(
                  id: 'checks',
                  title: 'Run focused checks',
                  status: complete
                      ? .completed
                      : stopped
                      ? .cancelled
                      : stage == _RunStage.permission
                      ? .pending
                      : .inProgress,
                ),
              ],
            ),
            AgentActivity(
              key: ValueKey('activity-$request'),
              style: styles.activity,
              indicatorBuilder: catalogChevron,
              disclosureStyle: styles.ledger,
              status: complete || stopped ? .complete : .working,
              items: [
                const AgentActivityItem(
                  id: 'read',
                  title: 'Read the checkout flow',
                  status: .complete,
                ),
                AgentActivityItem(
                  id: 'checks',
                  title: stage == _RunStage.permission
                      ? 'Waiting for permission'
                      : stopped
                      ? 'Checks stopped'
                      : complete
                      ? 'Finished focused checks'
                      : 'Running focused checks',
                  status: complete || stopped ? .complete : .active,
                ),
              ],
            ),
            AgentPermission(
              key: ValueKey('permission-$request'),
              requestId: request,
              style: styles.permission,
              indicatorBuilder: catalogChevron,
              surfaceStyle: styles.card,
              detailsStyle: styles.disclosure,
              parametersStyle: styles.dataList,
              allowOnceStyle: styles.decision(styles.button),
              denyStyle: styles.decision(styles.ghostButton),
              tool: 'terminal.run',
              description:
                  'Run the focused test suite. This demo never executes a command.',
              status: stage == _RunStage.permission
                  ? .pending
                  : stage == _RunStage.denied
                  ? .denied
                  : working
                  ? .running
                  : .complete,
              parameters: const [
                RemixDataListItem(label: 'Command', value: 'flutter test'),
              ],
              onAllowOnce: () => setState(() => stage = _RunStage.running),
              onDeny: () => setState(() => stage = _RunStage.denied),
            ),
            if (working || complete || stage == _RunStage.cancelled)
              AgentExecution(
                key: ValueKey('execution-$request'),
                style: styles.execution,
                indicatorBuilder: catalogChevron,
                surfaceStyle: styles.card,
                disclosureStyle: styles.disclosure,
                copyStyle: styles.utilityIconButton,
                retryStyle: styles.utilityIconButton,
                tool: 'terminal.run',
                title: 'Focused checks',
                status: complete
                    ? .success
                    : working
                    ? .running
                    : .cancelled,
                onCopy: () => Clipboard.setData(ClipboardData(text: output)),
                onRetry: () => _start(prompt),
                child: Text(output),
              ),
            if (complete || stopped)
              AgentAnswer(
                key: ValueKey('answer-$request'),
                style: styles.answer,
                sourcesIndicatorBuilder: catalogChevron,
                surfaceStyle: styles.card,
                sourcesStyle: styles.disclosure,
                status: .complete,
                child: Text(
                  complete
                      ? 'All 12 checks passed. The checkout flow is ready for review.'
                      : stage == _RunStage.denied
                      ? 'Permission denied. No checks were run.'
                      : 'Run stopped. Submit another message to try again.',
                ),
              ),
          ].map((child) => CatalogEntrance(key: child.key, child: child)).toList(),
        ),
        if (working)
          CatalogAction(
            label: 'Finish checks',
            onPressed: () => setState(() => stage = _RunStage.complete),
          ),
        const SizedBox(height: 16),
        _installedComposer(
          context,
          onSubmit: _start,
          running: working,
          onStop: () => setState(() => stage = _RunStage.cancelled),
        ),
      ],
    );
  }
}
