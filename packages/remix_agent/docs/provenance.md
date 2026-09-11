# Behavioral benchmark provenance

`remix_agent` used the BeUI agent components as a behavior, anatomy, and icon
vocabulary benchmark. The pinned local checkout is:

- Repository: <https://github.com/starc007/ui-components.git>
- Commit: `1942f3f93d8d36dba8a0dd8366699a933f56b135`
- License at that commit: MIT, copyright 2026 Saurabh Chauhan

## Source mapping

| Remix Agent surface | Benchmark source |
| --- | --- |
| `AgentComposer` | `components/agents/prompt-input.tsx` |
| `AgentMessage`, `AgentMessageCollapsible` | `components/agents/message.tsx`, `message-bubble.tsx` |
| `AgentTranscript` | `components/agents/message-scroller.tsx` |
| `AgentAnswer` | `components/agents/streaming-response.tsx` |
| `AgentPermission` | `components/agents/tool-approval.tsx` |
| `AgentExecution` | `components/agents/tool-result.tsx` |
| `AgentPlan` | `components/agents/todo-list.tsx` |
| `AgentActivity` | `components/agents/agent-activity/` |

## Intentional deviations

The benchmark informed workflow questions such as component boundaries,
disclosure placement, lifecycle states, live-edge behavior, and functional icon
choices. It is not an API, branding, or pixel-parity target. The implementation
uses Flutter, Naked UI behavior, Remix controls, generated Mix specs, and the
independently licensed `lucide_icons_flutter` dependency. That dependency is
exactly pinned because the implementation references a small, web-safe subset
of its font codepoints instead of importing its full generated catalog. It
deliberately ships empty visual defaults; the example's light/dark appearance
is local and non-exported. Remix Agent also defines its own
controlled/uncontrolled contracts, accessibility tree, keyboard behavior,
lifecycle transitions, and scroll-controller ownership rules.

## License and NOTICE conclusion

The benchmark repository's MIT license was reviewed at the pinned commit. No
benchmark source code, runtime asset, branding, or substantial copied portion
is distributed by `remix_agent`; the implementation was written against the
behavioral/anatomical observations above. On that basis there is no benchmark
license text or NOTICE file to add to the package artifact. Preserve this
record and reassess that conclusion if future work copies source or assets.
