import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:remix/remix.dart';

import '../ui/ui.dart';

enum _Scenario { success, permission, failure }

enum _Stage {
  idle,
  preparing,
  permission,
  running,
  complete,
  failed,
  stopped,
  denied,
}

/// A deterministic, local-only Agent demonstration. It contacts no model or
/// tool and intentionally keeps its state while DashboardShell's IndexedStack
/// switches pages.
class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.stepDelay = const Duration(milliseconds: 320),
  });

  final Duration stepDelay;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static const _chunks = [
    'I inspected the checkout flow. ',
    'The cart state is shared correctly, ',
    'and the focused checks pass. The flow is ready for review.',
  ];

  final _scroll = ScrollController();
  final _draft = TextEditingController();
  Timer? _timer;
  var _runId = 0;
  var _stage = _Stage.idle;
  var _scenario = _Scenario.success;
  var _prompt = '';
  var _answer = '';
  var _following = true;
  var _toolStarted = false;
  var _alwaysAllowTerminal = false;
  final _history = <({String prompt, String answer})>[];

  String get _visibleAnswer => _answer.isNotEmpty
      ? _answer
      : _stage == _Stage.denied
      ? 'Permission denied. No tool ran.'
      : !_toolStarted
      ? 'Stopped before running the tool. No tool ran.'
      : 'Run stopped; partial output was preserved.';

  String get _executionOutput =>
      _answer.isEmpty ? r'$ flutter test' : '${r'$ flutter test'}\n$_answer';

  bool get _active => const {
    _Stage.preparing,
    _Stage.permission,
    _Stage.running,
  }.contains(_stage);

  @override
  void dispose() {
    _cancelPending();
    _scroll.dispose();
    _draft.dispose();
    super.dispose();
  }

  void _cancelPending() {
    _runId++;
    _timer?.cancel();
    _timer = null;
  }

  void _reset() {
    _cancelPending();
    _draft.clear();
    setState(() {
      _stage = _Stage.idle;
      _prompt = '';
      _answer = '';
      _following = true;
      _alwaysAllowTerminal = false;
      _toolStarted = false;
      _history.clear();
    });
  }

  void _start(
    String prompt, {
    _Scenario scenario = _Scenario.success,
    bool keepMessage = false,
  }) {
    if (_active) return;
    _cancelPending();
    final id = _runId;
    setState(() {
      if (!keepMessage && _prompt.isNotEmpty) {
        _history.add((prompt: _prompt, answer: _visibleAnswer));
      }
      _scenario = scenario;
      if (!keepMessage) _prompt = prompt;
      _answer = '';
      _toolStarted = false;
      _stage = _Stage.preparing;
      _following = true;
    });
    _timer = Timer(widget.stepDelay, () {
      if (!mounted || id != _runId) return;
      if (scenario == _Scenario.permission && !_alwaysAllowTerminal) {
        setState(() => _stage = _Stage.permission);
      } else {
        _stream(id);
      }
    });
  }

  void _stream(int id) {
    var chunk = 0;
    setState(() {
      _toolStarted = true;
      _stage = _Stage.running;
    });
    _timer = Timer.periodic(widget.stepDelay, (timer) {
      if (!mounted || id != _runId) {
        timer.cancel();
        return;
      }
      if (_scenario == _Scenario.failure && chunk == 1) {
        timer.cancel();
        setState(() {
          _stage = _Stage.failed;
          _answer =
              'The simulated command failed. Retry to run the recovery path.';
        });
        return;
      }
      setState(() => _answer += _chunks[chunk++]);
      if (chunk == _chunks.length) {
        timer.cancel();
        setState(() => _stage = _Stage.complete);
      }
    });
  }

  void _allow(int requestId, {required bool always}) {
    if (requestId != _runId || _stage != _Stage.permission) return;
    if (always) _alwaysAllowTerminal = true;
    _stream(_runId);
  }

  void _stop() {
    _cancelPending();
    setState(() => _stage = _Stage.stopped);
  }

  void _retry() {
    _start(
      _prompt,
      scenario: _scenario == .failure ? .success : _scenario,
      keepMessage: true,
    );
  }

  void _returnToLatest() {
    setState(() => _following = true);
    if (_scroll.hasClients) {
      if (MediaQuery.disableAnimationsOf(context)) {
        _scroll.jumpTo(_scroll.position.maxScrollExtent);
        return;
      }
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gutter = MediaQuery.sizeOf(context).width < 600 ? 16.0 : 32.0;
    // The dashboard shell has no Scaffold to resize its body for the keyboard.
    return Padding(
      padding: EdgeInsets.fromLTRB(
        gutter,
        gutter,
        gutter,
        gutter + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Agent chat',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  RemixButton(
                    label: 'New chat',
                    onPressed: _reset,
                    style: uiButtonStyle(variant: .outline),
                  ),
                ],
              ),
              const Text('Interactive demo'),
              const SizedBox(height: 8),
              const Text(
                'Simulated responses and tools — no backend or credentials.',
              ),
              const SizedBox(height: 16),
              if (!_active) ...[_starters(), const SizedBox(height: 16)],
              Expanded(child: _transcript()),
              if (!_following)
                Align(
                  alignment: Alignment.center,
                  child: RemixButton(
                    label: 'Return to latest',
                    onPressed: _returnToLatest,
                    style: uiButtonStyle(variant: .soft),
                  ),
                ),
              const SizedBox(height: 12),
              _composer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _starters() => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      _starter('Review checkout', _Scenario.success),
      _starter('Run terminal checks', _Scenario.permission),
      _starter('Recover a failed command', _Scenario.failure),
    ],
  );

  Widget _starter(String label, _Scenario scenario) => RemixButton(
    label: label,
    onPressed: () => _start(label, scenario: scenario),
    style: uiButtonStyle(variant: .surface),
  );

  Widget _transcript() {
    final requestId = _runId;
    final transcript = uiAgentTranscriptRecipe(
      style: UiTranscriptStyler(viewport: BoxStyler().padding(.all(0))),
    );
    final children = <Widget>[];
    final message = uiAgentMessageRecipe();
    final answer = uiAgentAnswerRecipe();
    for (final turn in _history) {
      children.addAll([
        UiMessage(
          role: .user,
          style: message.style,
          surfaceStyle: message.surfaceStyle,
          child: Text(turn.prompt),
        ),
        UiAnswer(
          status: .complete,
          style: answer.style,
          surfaceStyle: answer.surfaceStyle,
          child: Text(turn.answer),
        ),
      ]);
    }
    if (_prompt.isNotEmpty) {
      children.add(
        UiMessage(
          role: .user,
          style: message.style,
          surfaceStyle: message.surfaceStyle,
          child: Text(_prompt),
        ),
      );
      final plan = uiAgentPlanRecipe();
      children.add(
        UiPlan(
          style: plan.style,
          disclosureStyle: plan.disclosureStyle,
          items: [
            const UiPlanItem(
              id: 'inspect',
              title: 'Inspect the request',
              status: .completed,
            ),
            UiPlanItem(
              id: 'tool',
              title: 'Run focused work',
              status: _active
                  ? .inProgress
                  : _stage == _Stage.complete
                  ? .completed
                  : .cancelled,
            ),
          ],
        ),
      );
      final activity = uiAgentActivityRecipe();
      children.add(
        UiActivity(
          style: activity.style,
          disclosureStyle: activity.disclosureStyle,
          status: _active ? .working : .complete,
          items: [
            UiActivityItem(
              id: 'run',
              title: _activityLabel,
              status: _active ? .active : .complete,
            ),
          ],
        ),
      );
      if (_stage == _Stage.permission ||
          (_scenario == _Scenario.permission &&
              _stage != _Stage.preparing &&
              (_stage != _Stage.stopped || _toolStarted))) {
        final permission = uiAgentPermissionRecipe(
          style: UiPermissionStyler(
            actions: FlexBoxStyler()
                .direction(
                  MediaQuery.sizeOf(context).width < 600
                      ? Axis.vertical
                      : Axis.horizontal,
                )
                .crossAxisAlignment(
                  MediaQuery.sizeOf(context).width < 600
                      ? CrossAxisAlignment.stretch
                      : CrossAxisAlignment.center,
                ),
          ),
        );
        children.add(
          UiPermission(
            requestId: _runId,
            tool: 'terminal.run',
            description: 'Run deterministic focused checks in this demo.',
            status: _stage == _Stage.permission
                ? .pending
                : _stage == _Stage.denied
                ? .denied
                : _stage == _Stage.stopped
                ? .allowed
                : _stage == _Stage.failed
                ? .error
                : _active
                ? .running
                : .complete,
            parameters: const [
              RemixDataListItem(label: 'Command', value: 'flutter test'),
            ],
            style: permission.style,
            surfaceStyle: permission.surfaceStyle,
            detailsStyle: permission.detailsStyle,
            parametersStyle: permission.parametersStyle,
            allowOnceStyle: permission.allowOnceStyle,
            alwaysAllowStyle: permission.alwaysAllowStyle,
            denyStyle: permission.denyStyle,
            onAllowOnce: () => _allow(requestId, always: false),
            onAlwaysAllow: () => _allow(requestId, always: true),
            onDeny: () {
              if (requestId != _runId || _stage != _Stage.permission) return;
              _cancelPending();
              setState(() => _stage = _Stage.denied);
            },
          ),
        );
      }
      if (_toolStarted &&
          {
            _Stage.running,
            _Stage.complete,
            _Stage.failed,
            _Stage.stopped,
          }.contains(_stage)) {
        final execution = uiAgentExecutionRecipe();
        children.add(
          UiExecution(
            tool: 'terminal.run',
            title: 'Focused checks',
            status: _stage == _Stage.running
                ? .running
                : _stage == _Stage.complete
                ? .success
                : _stage == _Stage.failed
                ? .error
                : .cancelled,
            style: execution.style,
            surfaceStyle: execution.surfaceStyle,
            disclosureStyle: execution.disclosureStyle,
            copyStyle: execution.copyStyle,
            retryStyle: execution.retryStyle,
            onCopy: () =>
                Clipboard.setData(ClipboardData(text: _executionOutput)),
            onRetry: _retry,
            child: Text(_executionOutput),
          ),
        );
      }
      if (_answer.isNotEmpty ||
          {_Stage.denied, _Stage.stopped}.contains(_stage)) {
        children.add(
          UiAnswer(
            streamId: _runId,
            status: _stage == _Stage.running
                ? .streaming
                : _stage == _Stage.failed
                ? .error
                : .complete,
            style: answer.style,
            surfaceStyle: answer.surfaceStyle,
            sourcesStyle: answer.sourcesStyle,
            copyStyle: answer.copyStyle,
            retryStyle: answer.retryStyle,
            onCopy: () =>
                Clipboard.setData(ClipboardData(text: _visibleAnswer)),
            onRetry: _retry,
            sourcesContent: const Text(
              'Deterministic local fixture · no network',
            ),
            child: Text(_visibleAnswer),
          ),
        );
      }
    }
    return UiTranscript(
      controller: _scroll,
      followOutput: _following,
      busy: _active,
      onFollowChanged: (value) {
        if (_following != value) setState(() => _following = value);
      },
      style: transcript.style,
      children: children.isEmpty
          ? [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text('Choose a starter or write a message.'),
                ),
              ),
            ]
          : children,
    );
  }

  Widget _composer() {
    final recipe = uiAgentComposerRecipe();
    return UiComposer(
      controller: _draft,
      running: _active,
      onSubmit: _start,
      onStop: _stop,
      hintText: _active ? 'Run in progress…' : 'Ask the demo agent…',
      style: recipe.style,
      surfaceStyle: recipe.surfaceStyle,
      fieldStyle: recipe.fieldStyle,
      submitStyle: recipe.submitStyle,
      stopStyle: recipe.stopStyle,
    );
  }

  String get _activityLabel => switch (_stage) {
    .preparing => 'Preparing the run',
    .permission => 'Waiting for permission',
    .running => 'Streaming simulated output',
    .complete => 'Run complete',
    .failed => 'Command failed',
    .stopped => 'Run stopped',
    .denied => 'Permission denied',
    .idle => 'Ready',
  };
}
