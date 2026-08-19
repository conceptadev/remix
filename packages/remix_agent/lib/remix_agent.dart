/// Agent-run UI surfaces for Remix.
///
/// Remix Agent ships conversation, permission, and progress widgets with no
/// theme, no token scope, and no model SDK. Import
/// `package:remix/remix.dart` alongside this library when a host needs base
/// Remix widgets or stylers. This barrel does not re-export Remix.
library remix_agent;

export 'src/behavior/collapse_when_complete.dart';
export 'src/behavior/live_edge.dart';
export 'src/components/activity.dart';
export 'src/components/answer.dart';
export 'src/components/composer.dart';
export 'src/components/disclosure.dart';
export 'src/components/execution.dart';
export 'src/components/message.dart';
export 'src/components/permission.dart';
export 'src/components/plan.dart';
export 'src/components/transcript.dart';
export 'src/models/activity_item.dart';
export 'src/models/permission_parameter.dart';
export 'src/models/plan_item.dart';
export 'src/models/statuses.dart';
export 'src/style/defaults.dart';
