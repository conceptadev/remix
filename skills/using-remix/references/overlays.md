# Overlay Components

Constructor details and host requirements for Remix dialogs, tooltips, and menus. Fortal widgets mentioned here live in the separate `remix_fortal` package; see [Fortal](fortal.md).

## Table of Contents

- [Popover](#remixpopover)
- [Dialog routes](#showremixdialogt)
- [Alert dialog routes](#showremixalertdialogt)
- [Dialog](#remixdialog)
- [Tooltip](#remixtooltip)
- [Menu](#remixmenut)

## Components

### RemixPopover

An anchored interactive overlay. It requires `popoverChild` and trigger
`child`; optional parameters include `positioning`, `consumeOutsideTaps`,
`useRootOverlay`, `openOnTap`, `triggerFocusNode`, lifecycle/request callbacks,
`controller`, `semanticLabel`, and `excludeSemantics`.

Fortal preset: `FortalPopover` — size `size1–size4`, no variant.

Menu, select, popover, and tooltip content uses the nearest caller-provided
`Overlay`; these components do not require a `Navigator`. If the existing host
does not expose an overlay, wrap the relevant subtree with `Overlay.wrap`.
Dialog helpers push routes and therefore require a caller-provided `Navigator`.

### showRemixDialog\<T\>

The general-purpose dialog helper wraps `showNakedDialog`. When the calling
context has a `MixScope`, it clones that scope's tokens and
modifier order into the dialog route; it also works when no `MixScope` is
present. That makes the route helper scope-optional; Fortal-styled dialog
content still needs a `FortalScope` above the calling context so its tokens
can resolve.

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `context` | `BuildContext` | — | yes |
| `builder` | `WidgetBuilder` | — | yes |
| `barrierColor` | `Color?` | `Colors.black54` when null | no |
| `barrierDismissible` | `bool` | `true` | no |
| `barrierLabel` | `String?` | `null` | no |
| `transitionDuration` | `Duration` | `400ms` | no |
| `transitionBuilder` | `RouteTransitionsBuilder?` | `null` | no |
| `useRootNavigator` | `bool` | `true` | no |
| `routeSettings` | `RouteSettings?` | `null` | no |
| `anchorPoint` | `Offset?` | `null` | no |
| `requestFocus` | `bool` | `true` | no |
| `traversalEdgeBehavior` | `TraversalEdgeBehavior?` | `null` | no |

### showRemixAlertDialog\<T\>

Use for urgent or destructive confirmations. It requires `context`, `builder`,
and a nonempty localized `semanticLabel`. The barrier is non-dismissible by
default. Optional parameters include `barrierColor`, `barrierLabel`,
`barrierDismissible`, `useRootNavigator`, route/anchor settings, transition
settings, and caller-owned `initialFocusNode`.

### RemixDialog

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `title` | `String?` | `null` | \* |
| `description` | `String?` | `null` | \* |
| `child` | `Widget?` | `null` | \* |
| `actions` | `List<Widget>?` | `null` | no |
| `modal` | `bool` | `true` | no |
| `semanticLabel` | `String?` | `null` | no |

\* At least one of `child`, `title`, or `description` must be provided.
Content renders in the order title → description → child → actions.

Fortal preset: `FortalDialog` — same params plus `size` (`size1–size4`), no
variant.

### RemixTooltip

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `tooltipChild` | `Widget` | — | yes (overlay content) |
| `child` | `Widget` | — | yes (trigger) |
| `tooltipSemantics` | `String?` | `null` | no |
| `positioning` | `OverlayPositionConfig` | `OverlayPositionConfig()` | no |

Spec timing defaults: `waitDuration` 300ms (hover delay), `showDuration`
1500ms (touch long-press), `dismissDuration` 100ms (hover-exit grace).
The tooltip styler's `label(...)` spec is applied through `DefaultTextStyle`,
so bare `Text` descendants inside an arbitrary `tooltipChild` inherit it.
Fortal typography children pin their own token run instead; transparent,
non-accent `FortalCode.ghost` retains only the ambient foreground.

Fortal preset: `FortalTooltip` — same params, no variant/size.

### RemixMenu\<T\>

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `trigger` | `RemixMenuTrigger` | — | yes |
| `items` | `List<RemixMenuItemData<T>>` | — | yes |
| `controller` | `MenuController?` | auto-created | no |
| `onSelected` | `ValueChanged<T>?` | `null` | no |
| `onOpen` / `onClose` / `onCanceled` | `VoidCallback?` | `null` | no |
| `onOpenRequested` / `onCloseRequested` | `RawMenuAnchor*Callback?` | `null` | no |
| `consumeOutsideTaps` | `bool` | `true` | no |
| `closeOnClickOutside` | `bool` | `true` | no |
| `useRootOverlay` | `bool` | `false` | no |
| `positioning` | `OverlayPositionConfig` | `OverlayPositionConfig()` | no |
| `triggerFocusNode` | `FocusNode?` | `null` | no |

`RemixMenuTrigger` and item entries are **data classes**, not widgets:

- **RemixMenuTrigger**: `label` (required), `icon` (optional).
- **RemixMenuItem\<T\>**: `value` (required), `label` (required),
  `leadingIcon`, `trailingIcon`, `enabled` (default true), `closeOnActivate`
  (default true), `semanticLabel`, `style`.
- **RemixMenuDivider\<T\>**: no fields, visual separator.

Fortal preset: `FortalMenu<T>` — `variant` (`solid|soft`), `size`
(`size1–size2`). Like Select, `fortalMenuStyle` already bakes in the matching
item styler; use an individual item's `style` only for a row-level override.

---
