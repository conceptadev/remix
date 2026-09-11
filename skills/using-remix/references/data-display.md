# Data Display Components

Constructor details for Remix data-display widgets. Fortal widgets mentioned
here come from the application-owned Fortal preset; see [Fortal](fortal.md).

## Table of Contents

- [Avatar](#remixavatar)
- [Badge](#remixbadge)
- [Card](#remixcard)
- [Callout](#remixcallout)
- [Data list](#remixdatalist)
- [Data table](#remixdatatablet)
- [Progress](#remixprogress)
- [Spinner](#remixspinner)
- [Skeleton](#remixskeleton)
- [Divider](#remixdivider)

## Components

### RemixAvatar

Purely presentational — no interaction params. Content precedence:
`child` > `labelBuilder`/`label` > `iconBuilder`/`icon`.

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `label` | `String?` | `null` | no |
| `icon` | `IconData?` | `null` | no |
| `backgroundImage` | `ImageProvider?` | `null` | no |
| `foregroundImage` | `ImageProvider?` | `null` | no |
| `child` | `Widget?` | `null` | no |
| `labelBuilder` | `RemixAvatarLabelBuilder?` | `null` | no |
| `iconBuilder` | `RemixAvatarIconBuilder?` | `null` | no |
| `onBackgroundImageError` | `ImageErrorListener?` | `null` | no |
| `onForegroundImageError` | `ImageErrorListener?` | `null` | no |

Fortal preset: `FortalAvatar` — `variant` (`soft|solid`), `size`
(`size1–size9`). Use `fallbackLength: 2` for two-character initials.

### RemixBadge

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `label` | `String?` | `null` | no |
| `child` | `Widget?` | `null` | no |
| `labelBuilder` | `RemixBadgeLabelBuilder?` | `null` | no |

Fortal preset: `FortalBadge` — `variant` (`solid|soft|surface|outline`),
`size` (`size1–size3`).

### RemixCard

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `child` | `Widget?` | `null` | no |

Fortal preset: `FortalCard` — `variant` (`surface|classic|ghost`), `size`
(`size1–size5`).

### RemixCallout

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `text` | `String?` | `null` | \* |
| `icon` | `IconData?` | `null` | no |
| `child` | `Widget?` | `null` | \* |

\* Either `text` or `child` must be provided.

Fortal preset: `FortalCallout` — `variant` (`outline|surface|soft`), `size`
(`size1–size3`).

### RemixDataList

A display-only label/value list. Horizontal orientation shares one label
column; vertical orientation stacks each label over its value.

| Parameter | Type | Default | Required |
| --- | --- | --- | --- |
| `items` | `List<RemixDataListItem>` | — | yes |
| `orientation` | `Axis` | `Axis.horizontal` | no |
| `semanticLabel` | `String?` | `null` | no |
| `excludeSemantics` | `bool` | `false` | no |

Each item requires `label` and exactly one of string `value` or widget `child`.
Use `semanticValue` to replace a display-only child's semantics; omit it for an
interactive child. Fortal preset: `FortalDataList` — size `size1–size3`, no
variant.

### RemixDataTable\<T\>

A controlled table. The caller supplies the current page in final order;
sorting, selection, and pagination callbacks report intent and never mutate or
fetch rows.

Required parameters are `rows: List<T>` and
`columns: List<RemixDataTableColumn<T>>`. Optional controlled surfaces include
`sort`/`onSortChanged`, `rowId`/`selectedRowIds`/`onSelectionChanged`, and
`totalRows`/`pageIndex`/`pageSize`/`pageSizeOptions` with page callbacks.
`minimumWidth`, `emptyBuilder`, localized `labels`, and `pageRangeFormatter`
control layout and empty/footer presentation.

Fortal preset: `FortalDataTable<T>` — `variant` (`surface|ghost`), `size`
(`size1–size3`).

### RemixProgress

| Parameter | Type | Default | Required |
|-----------|------|---------|----------|
| `value` | `double` | — | yes (0.0–1.0) |

Fortal preset: `FortalProgress` — `variant` (`classic|surface|soft`), `size`
(`size1–size3`, 4/8/12 px height).

### RemixSpinner

Only `style`/`styleSpec`. The spec carries `size`, `strokeWidth`,
`indicatorColor`, `trackColor`, `trackStrokeWidth`, `duration`.

Fortal preset: `FortalSpinner` — `size` only (`size1–size3`), no variant.

### RemixSkeleton

A decorative loading placeholder that preserves its child's geometry and local
state. Parameters: optional `child`, `loading` (default true), `style`, and
`styleSpec`. While loading, the child cannot paint, receive input or focus,
tick, or appear in semantics. Announce loading separately when needed.

Fortal preset: `FortalSkeleton` — no variant or size.

### RemixDivider

Only `style`/`styleSpec`.

Fortal preset: `FortalDivider` — `size` only (`size1–size4`), no variant.

---
