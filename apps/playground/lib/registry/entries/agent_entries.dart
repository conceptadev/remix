import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remix/remix.dart';

import '../../ui/ui.dart';

Widget _scope(BuildContext context, Widget child) => PlaygroundThemeScope(
  data: Theme.of(context).brightness == Brightness.dark
      ? const PlaygroundThemeData.dark()
      : const PlaygroundThemeData.light(),
  child: DefaultTextStyle.merge(
    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
    child: child,
  ),
);

Widget buildAgentComposer(BuildContext context) {
  final recipe = playgroundAgentComposerRecipe();
  return _scope(
    context,
    PlaygroundComposer(
      onSubmit: (_) {},
      style: recipe.style,
      surfaceStyle: recipe.surfaceStyle,
      fieldStyle: recipe.fieldStyle,
      submitStyle: recipe.submitStyle,
      stopStyle: recipe.stopStyle,
    ),
  );
}

Widget buildAgentMessage(BuildContext context) {
  final recipe = playgroundAgentMessageRecipe();
  return _scope(
    context,
    PlaygroundMessageGroup(
      spacing: 12,
      children: [
        PlaygroundMessage(
          role: .user,
          style: recipe.style,
          surfaceStyle: recipe.surfaceStyle,
          child: const Text('Review the checkout flow.'),
        ),
        PlaygroundMessage(
          role: .assistant,
          style: recipe.style,
          surfaceStyle: recipe.surfaceStyle,
          child: const Text('I will inspect it and report the focused checks.'),
        ),
      ],
    ),
  );
}

Widget buildAgentTranscript(BuildContext context) {
  final recipe = playgroundAgentTranscriptRecipe();
  return _scope(
    context,
    SizedBox(
      height: 280,
      child: PlaygroundTranscript(
        style: recipe.style,
        children: List.generate(
          8,
          (index) => Text('Transcript event ${index + 1}'),
        ),
      ),
    ),
  );
}

Widget buildAgentPlan(BuildContext context) {
  final recipe = playgroundAgentPlanRecipe();
  return _scope(
    context,
    PlaygroundPlan(
      style: recipe.style,
      disclosureStyle: recipe.disclosureStyle,
      items: const [
        PlaygroundPlanItem(
          id: 'one',
          title: 'Inspect request',
          status: .completed,
        ),
        PlaygroundPlanItem(
          id: 'two',
          title: 'Run focused checks',
          status: .inProgress,
        ),
        PlaygroundPlanItem(id: 'three', title: 'Report result'),
      ],
    ),
  );
}

Widget buildAgentActivity(BuildContext context) {
  final recipe = playgroundAgentActivityRecipe();
  return _scope(
    context,
    PlaygroundActivity(
      style: recipe.style,
      disclosureStyle: recipe.disclosureStyle,
      items: const [
        PlaygroundActivityItem(
          id: 'one',
          title: 'Read files',
          status: .complete,
        ),
        PlaygroundActivityItem(
          id: 'two',
          title: 'Checking behavior',
          status: .active,
        ),
      ],
    ),
  );
}

Widget buildAgentAnswer(BuildContext context) {
  final recipe = playgroundAgentAnswerRecipe();
  return _scope(
    context,
    PlaygroundAnswer(
      status: .complete,
      style: recipe.style,
      surfaceStyle: recipe.surfaceStyle,
      sourcesStyle: recipe.sourcesStyle,
      copyStyle: recipe.copyStyle,
      retryStyle: recipe.retryStyle,
      onCopy: () {},
      onRetry: () {},
      sourcesContent: const Text('Local deterministic fixture'),
      child: const Text('The checkout flow is ready for review.'),
    ),
  );
}

Widget buildAgentExecution(BuildContext context) {
  final recipe = playgroundAgentExecutionRecipe();
  return _scope(
    context,
    PlaygroundExecution(
      tool: 'terminal.run',
      title: 'Focused checks',
      status: .running,
      style: recipe.style,
      surfaceStyle: recipe.surfaceStyle,
      disclosureStyle: recipe.disclosureStyle,
      copyStyle: recipe.copyStyle,
      retryStyle: recipe.retryStyle,
      child: const Text('\$ flutter test\n00:01 +12: running'),
    ),
  );
}

Widget buildAgentPermission(BuildContext context) =>
    _scope(context, const _PermissionPreview());

class _PermissionPreview extends StatefulWidget {
  const _PermissionPreview();
  @override
  State<_PermissionPreview> createState() => _PermissionPreviewState();
}

class _PermissionPreviewState extends State<_PermissionPreview> {
  var status = PlaygroundPermissionStatus.pending;
  @override
  Widget build(BuildContext context) {
    final recipe = playgroundAgentPermissionRecipe();
    return PlaygroundPermission(
      requestId: 1,
      tool: 'terminal.run',
      description: 'Run deterministic focused checks.',
      status: status,
      parameters: const [
        RemixDataListItem(label: 'Command', value: 'flutter test'),
      ],
      style: recipe.style,
      surfaceStyle: recipe.surfaceStyle,
      detailsStyle: recipe.detailsStyle,
      parametersStyle: recipe.parametersStyle,
      allowOnceStyle: recipe.allowOnceStyle,
      alwaysAllowStyle: recipe.alwaysAllowStyle,
      denyStyle: recipe.denyStyle,
      onAllowOnce: () => setState(() => status = .running),
      onAlwaysAllow: () => setState(() => status = .running),
      onDeny: () => setState(() => status = .denied),
    );
  }
}

Widget buildAgentChat(BuildContext context) =>
    _scope(context, const _CompactChat());

enum _ChatStage {
  ready,
  permission,
  running,
  failed,
  complete,
  stopped,
  denied,
}

class _CompactChat extends StatefulWidget {
  const _CompactChat();
  @override
  State<_CompactChat> createState() => _CompactChatState();
}

class _CompactChatState extends State<_CompactChat> {
  static const _executionOutput = '\$ flutter test\nSimulated output';
  final _draft = TextEditingController();

  @override
  void dispose() {
    _draft.dispose();
    super.dispose();
  }

  var stage = _ChatStage.ready;
  var prompt = 'Run the focused checks.';
  var attempt = 0;
  var alwaysAllow = false;
  var ranTool = false;

  void _begin(String value) {
    if (stage == .permission || stage == .running) return;
    setState(() {
      attempt++;
      prompt = value;
      ranTool = alwaysAllow;
      stage = alwaysAllow ? .running : .permission;
    });
  }

  void _allow(int id, {bool always = false}) {
    if (id != attempt || stage != .permission) return;
    setState(() {
      alwaysAllow = alwaysAllow || always;
      ranTool = true;
      stage = .running;
    });
  }

  void _reset() => setState(() {
    _draft.clear();
    attempt++;
    alwaysAllow = false;
    ranTool = false;
    stage = .ready;
  });

  @override
  Widget build(BuildContext context) {
    final message = playgroundAgentMessageRecipe();
    final transcript = playgroundAgentTranscriptRecipe(
      style: PlaygroundTranscriptStyler(viewport: BoxStyler().padding(.all(0))),
    );
    final permission = playgroundAgentPermissionRecipe();
    final execution = playgroundAgentExecutionRecipe();
    final answer = playgroundAgentAnswerRecipe();
    final composer = playgroundAgentComposerRecipe();
    final active = stage == .permission || stage == .running;
    final requestId = attempt;
    return Box(
      style: BoxStyler().height(600).maxWidth(800).padding(.all(16)),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Interactive chat demo',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(onPressed: _reset, child: const Text('New chat')),
            ],
          ),
          const SizedBox(height: 4),
          const Text('Simulated locally · no backend'),
          const SizedBox(height: 20),
          Expanded(
            child: PlaygroundTranscript(
              busy: active,
              style: transcript.style,
              children: [
                if (stage != .ready)
                  PlaygroundMessage(
                    role: .user,
                    style: message.style,
                    surfaceStyle: message.surfaceStyle,
                    child: Text(prompt),
                  ),
                if (stage == .permission)
                  PlaygroundPermission(
                    requestId: requestId,
                    tool: 'terminal.run',
                    description: 'Run a simulated command.',
                    status: .pending,
                    style: permission.style,
                    surfaceStyle: permission.surfaceStyle,
                    detailsStyle: permission.detailsStyle,
                    parametersStyle: permission.parametersStyle,
                    allowOnceStyle: permission.allowOnceStyle,
                    alwaysAllowStyle: permission.alwaysAllowStyle,
                    denyStyle: permission.denyStyle,
                    onAllowOnce: () => _allow(requestId),
                    onAlwaysAllow: () => _allow(requestId, always: true),
                    onDeny: () {
                      if (requestId != attempt || stage != .permission) return;
                      setState(() => stage = .denied);
                    },
                  ),
                if (ranTool &&
                    {
                      _ChatStage.running,
                      _ChatStage.failed,
                      _ChatStage.complete,
                      _ChatStage.stopped,
                    }.contains(stage))
                  PlaygroundExecution(
                    tool: 'terminal.run',
                    title: 'Focused checks',
                    status: stage == .running
                        ? .running
                        : stage == .failed
                        ? .error
                        : stage == .complete
                        ? .success
                        : .cancelled,
                    style: execution.style,
                    surfaceStyle: execution.surfaceStyle,
                    disclosureStyle: execution.disclosureStyle,
                    copyStyle: execution.copyStyle,
                    retryStyle: execution.retryStyle,
                    onCopy: () => Clipboard.setData(
                      const ClipboardData(text: _executionOutput),
                    ),
                    onRetry: () => _begin(prompt),
                    child: const Text(_executionOutput),
                  ),
                if ({
                  _ChatStage.denied,
                  _ChatStage.failed,
                  _ChatStage.complete,
                  _ChatStage.stopped,
                }.contains(stage))
                  PlaygroundAnswer(
                    status: stage == .failed ? .error : .complete,
                    style: answer.style,
                    surfaceStyle: answer.surfaceStyle,
                    sourcesStyle: answer.sourcesStyle,
                    copyStyle: answer.copyStyle,
                    retryStyle: answer.retryStyle,
                    onRetry: () => _begin(prompt),
                    child: Text(
                      stage == .complete
                          ? 'All checks passed.'
                          : stage == .failed
                          ? 'The command failed. Retry is available.'
                          : stage == .denied
                          ? 'Permission denied. No command was run.'
                          : ranTool
                          ? 'The run was stopped.'
                          : 'Stopped before running the command.',
                    ),
                  ),
              ],
            ),
          ),
          if (stage == .running)
            Wrap(
              spacing: 8,
              children: [
                TextButton(
                  onPressed: () => setState(() => stage = .complete),
                  child: const Text('Finish'),
                ),
                TextButton(
                  onPressed: () => setState(() => stage = .failed),
                  child: const Text('Simulate failure'),
                ),
              ],
            ),
          const SizedBox(height: 16),
          PlaygroundComposer(
            controller: _draft,
            running: active,
            onSubmit: _begin,
            onStop: () => setState(() => stage = .stopped),
            style: composer.style,
            surfaceStyle: composer.surfaceStyle,
            fieldStyle: composer.fieldStyle,
            submitStyle: composer.submitStyle,
            stopStyle: composer.stopStyle,
          ),
        ],
      ),
    );
  }
}
