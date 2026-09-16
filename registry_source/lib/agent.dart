/// Agent-run UI surfaces for Remix.
///
/// Remix Agent ships conversation, permission, and progress widgets with no
/// theme, no token scope, and no model SDK. Import
/// `package:remix/remix.dart` alongside this library when a host needs base
/// Remix widgets or stylers. This barrel does not re-export Remix.
library;

export 'src/agent/components/activity.dart';
export 'src/agent/components/answer.dart';
export 'src/agent/components/composer.dart';
export 'src/agent/components/execution.dart';
export 'src/agent/components/message.dart';
export 'src/agent/components/permission.dart';
export 'src/agent/components/plan.dart';
export 'src/agent/components/transcript.dart';
export 'src/agent/models/activity_item.dart';
export 'src/agent/models/plan_item.dart';
export 'src/agent/models/statuses.dart';
