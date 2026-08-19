import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';
import 'package:remix_agent/remix_agent.dart';

import 'host.dart';

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
    final theme = HostTheme.of(context);
    final style = quiet
        ? agentQuietButtonStyle(context)
        : agentButtonStyle(
            context,
          ).color(theme.live).labelColor(const Color(0xFFFFFFFF));
    return RemixButton(label: label, onPressed: onPressed, style: style);
  }
}

class ComposerDemo extends StatefulWidget {
  const ComposerDemo({super.key});

  @override
  State<ComposerDemo> createState() => _ComposerDemoState();
}

class _ComposerDemoState extends State<ComposerDemo> {
  final _sent = <String>[];
  var _running = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AgentComposer(
          running: _running,
          onSubmit: (value) => setState(() {
            _sent.add(value);
            _running = true;
          }),
          onStop: () => setState(() => _running = false),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            CatalogAction(
              label: _running ? 'Mark idle' : 'Mark running',
              quiet: true,
              onPressed: () => setState(() => _running = !_running),
            ),
          ],
        ),
        if (_sent.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Last sent: ${_sent.last}', style: HostTheme.of(context).meta),
        ],
      ],
    );
  }
}

class MessageDemo extends StatelessWidget {
  const MessageDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const AgentMessageGroup(
      children: [
        AgentMessage(
          role: AgentRole.user,
          header: Text('You'),
          child: Text('Review the checkout flow and pause before tests.'),
        ),
        AgentMessage(
          role: AgentRole.assistant,
          header: Text('Agent'),
          footer: Text('just now'),
          child: Text(
            'I will read the brief, then ask before I run the suite.',
          ),
        ),
        AgentMessage(
          role: AgentRole.assistant,
          child: Text('Grouped follow-up stays aligned with the first turn.'),
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
  var _lines = 8;
  var _following = true;

  @override
  Widget build(BuildContext context) {
    final theme = HostTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _following ? 'Following the live edge' : 'Released — reading history',
          style: theme.meta.copyWith(color: theme.live),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: AgentTranscript(
            followOutput: true,
            onFollowChange: (value) => setState(() => _following = value),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var i = 0; i < _lines; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text('Line ${i + 1} of the growing log.'),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        CatalogAction(
          label: 'Append lines',
          onPressed: () => setState(() => _lines += 4),
        ),
      ],
    );
  }
}

class PermissionDemo extends StatefulWidget {
  const PermissionDemo({super.key});

  @override
  State<PermissionDemo> createState() => _PermissionDemoState();
}

class _PermissionDemoState extends State<PermissionDemo> {
  var _status = AgentPermissionStatus.pending;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AgentPermission(
          tool: 'terminal.run',
          description: 'Run the focused test suite in this workspace.',
          status: _status,
          parameters: const [
            AgentPermissionParameter(
              id: 'command',
              label: 'Command',
              value: 'flutter test',
            ),
            AgentPermissionParameter(
              id: 'cwd',
              label: 'Directory',
              value: 'packages/remix_agent',
            ),
          ],
          onAllowOnce: () =>
              setState(() => _status = AgentPermissionStatus.allowed),
          onAlwaysAllow: () =>
              setState(() => _status = AgentPermissionStatus.complete),
          onDeny: () => setState(() => _status = AgentPermissionStatus.denied),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: CatalogAction(
            label: 'Replay',
            quiet: true,
            onPressed: () =>
                setState(() => _status = AgentPermissionStatus.pending),
          ),
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
  var _status = AgentExecutionStatus.running;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AgentExecution(
          tool: 'terminal.run',
          title: 'Focused checks',
          status: _status,
          meta: _status == AgentExecutionStatus.running ? 'live' : '2.1s',
          child: const Text('12 passed · 0 failed'),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            CatalogAction(
              label: 'Succeed',
              onPressed: () =>
                  setState(() => _status = AgentExecutionStatus.success),
            ),
            CatalogAction(
              label: 'Fail',
              quiet: true,
              onPressed: () =>
                  setState(() => _status = AgentExecutionStatus.error),
            ),
            CatalogAction(
              label: 'Cancel',
              quiet: true,
              onPressed: () =>
                  setState(() => _status = AgentExecutionStatus.cancelled),
            ),
          ],
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

class _PlanDemoState extends State<PlanDemo> {
  var _step = 1;

  List<AgentPlanItem> get _items {
    AgentPlanItemStatus at(int index) {
      if (_step > index) return AgentPlanItemStatus.completed;
      if (_step == index) return AgentPlanItemStatus.inProgress;
      return AgentPlanItemStatus.pending;
    }

    return [
      AgentPlanItem(id: '1', title: 'Read the checkout brief', status: at(1)),
      AgentPlanItem(id: '2', title: 'Map the payment path', status: at(2)),
      AgentPlanItem(id: '3', title: 'Run focused checks', status: at(3)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AgentPlan(items: _items),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            CatalogAction(
              label: 'Advance',
              onPressed: _step >= 4 ? null : () => setState(() => _step += 1),
            ),
            CatalogAction(
              label: 'Replay',
              quiet: true,
              onPressed: () => setState(() => _step = 1),
            ),
          ],
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
  var _status = AgentRunStatus.working;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AgentActivity(
          status: _status,
          items: [
            const AgentActivityItem(
              id: 'read',
              title: 'Reading the brief',
              status: AgentActivityItemStatus.complete,
            ),
            AgentActivityItem(
              id: 'map',
              title: 'Mapping the payment path',
              status: _status == AgentRunStatus.working
                  ? AgentActivityItemStatus.active
                  : AgentActivityItemStatus.complete,
              child: const Text('3 screens, 1 shared cart model'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: CatalogAction(
            label: _status == AgentRunStatus.working ? 'Complete' : 'Replay',
            onPressed: () => setState(() {
              _status = _status == AgentRunStatus.working
                  ? AgentRunStatus.complete
                  : AgentRunStatus.working;
            }),
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
  var _status = AgentAnswerStatus.streaming;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AgentAnswer(
          status: _status,
          copyAction: const Text('Copy'),
          retryAction: GestureDetector(
            onTap: () => setState(() => _status = AgentAnswerStatus.streaming),
            child: const Text('Retry'),
          ),
          sources: const Text('Sources: checkout brief, payment notes'),
          child: Text(
            _status == AgentAnswerStatus.streaming
                ? 'The checkout flow is…'
                : 'The checkout flow is ready for a focused check. Payment and cart share one model.',
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            CatalogAction(
              label: 'Complete',
              onPressed: () =>
                  setState(() => _status = AgentAnswerStatus.complete),
            ),
            CatalogAction(
              label: 'Error',
              quiet: true,
              onPressed: () =>
                  setState(() => _status = AgentAnswerStatus.error),
            ),
          ],
        ),
      ],
    );
  }
}

class ComposedRunDemo extends StatefulWidget {
  const ComposedRunDemo({super.key});

  @override
  State<ComposedRunDemo> createState() => _ComposedRunDemoState();
}

class _ComposedRunDemoState extends State<ComposedRunDemo> {
  final _prompts = <String>[];
  var _running = false;
  var _permission = AgentPermissionStatus.pending;
  var _execution = AgentExecutionStatus.running;
  var _answer = AgentAnswerStatus.streaming;
  var _activity = AgentRunStatus.working;

  void _submit(String prompt) {
    setState(() {
      _prompts.add(prompt);
      _running = true;
      _answer = AgentAnswerStatus.streaming;
      _activity = AgentRunStatus.working;
    });
  }

  void _allow() {
    setState(() {
      _permission = AgentPermissionStatus.complete;
      _execution = AgentExecutionStatus.success;
      _answer = AgentAnswerStatus.complete;
      _activity = AgentRunStatus.complete;
      _running = false;
    });
  }

  void _deny() {
    setState(() {
      _permission = AgentPermissionStatus.denied;
      _running = false;
      _answer = AgentAnswerStatus.complete;
      _activity = AgentRunStatus.complete;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Column(
        children: [
          Expanded(
            child: AgentTranscript(
              followOutput: false,
              busy: _running,
              child: AgentMessageGroup(
                children: [
                  const AgentMessage(
                    role: AgentRole.user,
                    child: Text('Review the checkout flow.'),
                  ),
                  const AgentMessage(
                    role: AgentRole.assistant,
                    child: Text(
                      'I will inspect the flow and pause before running checks.',
                    ),
                  ),
                  AgentPlan(
                    items: [
                      const AgentPlanItem(
                        id: '1',
                        title: 'Inspect the checkout flow',
                        status: AgentPlanItemStatus.completed,
                      ),
                      AgentPlanItem(
                        id: '2',
                        title: 'Run focused checks',
                        status: _permission == AgentPermissionStatus.pending
                            ? AgentPlanItemStatus.inProgress
                            : AgentPlanItemStatus.completed,
                      ),
                    ],
                  ),
                  AgentActivity(
                    status: _activity,
                    items: [
                      const AgentActivityItem(
                        id: 'read',
                        title: 'Reading the brief',
                        status: AgentActivityItemStatus.complete,
                      ),
                      AgentActivityItem(
                        id: 'check',
                        title: 'Preparing checks',
                        status: _running
                            ? AgentActivityItemStatus.active
                            : AgentActivityItemStatus.complete,
                      ),
                    ],
                  ),
                  AgentPermission(
                    tool: 'terminal.run',
                    description: 'The agent wants to run focused checks.',
                    status: _permission,
                    parameters: const [
                      AgentPermissionParameter(
                        id: 'command',
                        label: 'Command',
                        value: 'flutter test',
                      ),
                    ],
                    onAllowOnce: _allow,
                    onAlwaysAllow: _allow,
                    onDeny: _deny,
                  ),
                  if (_permission == AgentPermissionStatus.allowed ||
                      _permission == AgentPermissionStatus.running ||
                      _permission == AgentPermissionStatus.complete)
                    AgentExecution(
                      tool: 'terminal.run',
                      title: 'Focused checks',
                      status: _execution,
                      child: const Text('12 passed'),
                    ),
                  AgentAnswer(
                    status: _answer,
                    copyAction: const Text('Copy'),
                    child: const Text(
                      'The checkout flow is ready for a focused check.',
                    ),
                  ),
                  for (final prompt in _prompts)
                    AgentMessage(role: AgentRole.user, child: Text(prompt)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          AgentComposer(
            running: _running,
            onSubmit: _submit,
            onStop: () => setState(() {
              _running = false;
              _answer = AgentAnswerStatus.complete;
              _activity = AgentRunStatus.complete;
            }),
          ),
        ],
      ),
    );
  }
}
