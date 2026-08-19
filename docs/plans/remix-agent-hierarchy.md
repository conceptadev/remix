# Plan: `remix_agent` hierarchy pass

> A transcript is a conversation. Only permission and the composer earn a
> surface. Everything else is type, a live mark, and space.

## Goal (paste into `/goal`)

Apply the hierarchy pass in `docs/plans/remix-agent-hierarchy.md`. Follow
`skills/using-remix`, `skills/building-remix-design-system`, Mix, and
frontend-design. A run should read as prose plus one interruption and one
instrument — not a stack of identical cards.

Done when: assistant / plan / activity / answer / execution have no default
`RemixCard`; user bubbles shrink to content; no letter avatars; no Show/Hide
or status-word columns; permission is one card with sentence description and
one primary action; FVM package + example tests are green; `lib/` stays
Material-free; isolation search for third-party catalog names is empty.

## Objective

- Primary: visual grammar. Same behavior, fewer boxes.
- Out of scope: Fortal, token pipeline, AgentScope, publishing, chat shell.
- Constraint: ink still from host `DefaultTextStyle`. No new palette.

## Visual contract

| Surface | Chrome |
| --- | --- |
| Assistant message | Text. No card. No letter avatar. |
| User message | Shrink-wrapped bubble. No letter avatar. |
| Plan / activity | Flush disclosure + 6px live mark. No card. |
| Answer | Body + quiet actions. No card. |
| Execution | Disclosure + output well. No outer card. |
| Permission | One card. Title. Tool. Sentence. Params well. Allow once / Always / Deny. |
| Composer | One card (already). |

Signature: the 6px live mark. Everything else is quiet.

## Cleanup

- Delete unused `agentBadgeStyle` / `agentAvatarStyle` / `agentCalloutStyle`
  if nothing remains.
- One `_AgentLiveMark` (plan + activity). Delete both `_StatusWord`s.
- Replace unicode carets with a 8px stroke chevron.
- `style` on plan/activity/answer/execution stays as an opt-in card wrap.
- Type helpers: title / body / meta from `DefaultTextStyle`.

## Compat

Unpublished hard-cut. `showAvatar` still works; we never invent `U`/`A`.
Tests that count two `RemixCard`s in a message group must compare text
geometry instead.

## Work

1. Chrome helpers + disclosure caret + live mark
2. Message, plan, activity, answer, execution, permission
3. Tests + FVM analyze
