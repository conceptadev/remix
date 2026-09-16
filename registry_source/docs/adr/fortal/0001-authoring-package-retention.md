# ADR 0001 — Retain the private Fortal authoring package

Date: 2026-09-14. Status: superseded by [ADR 0002](0002-registry-source.md) — the
trigger below fired and the source moved to `registry_source/lib/src/fortal`.

## Decision

Keep `remix_fortal` as a private workspace authoring and parity-test package.
Consumers receive its derived, application-owned source from the Fortal registry,
not a new published dependency. This follows the ownership direction in
[the clean-sheet decision](../../../../open_code/CLEAN_SHEET.md) and
[the Fortal preset decision](../../../../open_code/PRESETS.md).

A future directory-only authoring layout is possible, but does not currently
improve the installed consumer contract. Do not move the source as part of Agent
registry integration.

## Cost and trigger

At this decision, 78 Dart files under app `lib/` directories import the package:
39 in demo, 30 in dashboard, and 9 in playground. A migration must retarget those
imports, preserve generated output and parity fixtures, update workspace and
build configuration, and retain a single authoring source for derivation. The
file counts measure import sites, not estimated engineering effort.

Reconsider when the private package boundary causes a demonstrated maintenance
problem, such as duplicate source ownership or blocking consumer adoption, and
a concrete migration shows lower ongoing cost than retaining it. Merely matching
the eventual directory shape is not a sufficient trigger.

## Consequences

Package tests and Radix parity remain useful independent checks. Applications
can move to installed source incrementally when justified. Until then, neither
the source package's version nor its workspace imports imply a hosted release.
No source move, app migration, or release-policy change is authorized by this ADR.
