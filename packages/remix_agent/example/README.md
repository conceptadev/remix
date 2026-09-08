# Remix Agent catalog

Local review surface for every unpublished `remix_agent` widget. Host chrome
only — the package still ships no theme.

```bash
cd packages/remix_agent/example
fvm flutter run -d chrome
# or
fvm flutter run -d web-server --web-hostname localhost --web-port 7388
```

Day / Night in the top bar switches local, non-exported light and dark style
recipes. The Agent package itself contributes no visual defaults. The catalog
uses a fixed two-column wide layout at 880 logical pixels and a single-column
narrow layout below that breakpoint.

The hero is a full turn. The rail jumps to Composer, Message, Transcript,
Permission, Execution, Plan, Activity, and Answer. Each section is a live
control, not a screenshot. The composed hero deliberately disables transcript
auto-follow so its fixed review frame remains stable.

The catalog recipes pass Remix child stylers separately from structural Agent
stylers and rely on Agent's built-in path glyphs. Top-bar and rail actions are
Remix controls, so the same catalog can be reviewed with pointer or keyboard.
