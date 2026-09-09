# Remix Agent catalog

Local review surface for every unpublished `remix_agent` widget. Host chrome
only — the package still ships no theme.

```bash
cd packages/remix_agent/example
fvm flutter run -d chrome
# or
fvm flutter run -d web-server --web-hostname localhost --web-port 7388
```

Day / Night switches the Composer's installed `UiThemeScope` and the local
styles used by the other seven surfaces. The Agent package contributes no
visual defaults. The catalog uses a fixed two-column wide layout at 880 logical
pixels and a single-column narrow layout below that breakpoint.

The hero is a full turn. The rail jumps to Composer, Message, Transcript,
Permission, Execution, Plan, Activity, and Answer. Each section is a live
control, not a screenshot. The composed run uses the page scroll so every
permission decision stays visible. Allow or deny the mock command, finish or stop it, and submit a new
message to replay. It never invokes a terminal or model.

The registry-installed Button recipe also supplies catalog and permission
actions. Composer controls add 48px touch geometry through the recipe override
slots; the installed source remains unchanged.

The catalog recipes pass Remix child stylers separately from structural Agent
stylers and rely on Agent's built-in Lucide glyphs. Top-bar and rail actions are
Remix controls, so the same catalog can be reviewed with pointer or keyboard.
