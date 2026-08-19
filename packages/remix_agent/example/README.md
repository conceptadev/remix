# Remix Agent catalog

Local review surface for every unpublished `remix_agent` widget. Host chrome
only — the package still ships no theme.

```bash
cd packages/remix_agent/example
fvm flutter run -d chrome
# or
fvm flutter run -d web-server --web-hostname localhost --web-port 7388
```

Day / Night in the top bar flips host ink. Widgets read that ink from
`DefaultTextStyle`.

The hero is a full turn. The rail jumps to Composer, Message, Transcript,
Permission, Execution, Plan, Activity, and Answer. Each section is a live
control, not a screenshot.
