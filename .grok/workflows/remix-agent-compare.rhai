let meta = #{
    name: "remix-agent-compare",
    description: "Walk each remix_agent surface one by one: compare to the local reference catalog, apply Remix-correct visual adjustments, then verify that implementation",
    when_to_use: "Use when remix_agent surfaces should be compared to .local/ui-components/components/agents, adjusted one at a time, and checked with FVM tests after each slice",
    phases: [
        #{ title: "Composer", detail: "compare, adjust, check" },
        #{ title: "Message", detail: "compare, adjust, check" },
        #{ title: "Transcript", detail: "compare, adjust, check" },
        #{ title: "Permission", detail: "compare, adjust, check" },
        #{ title: "Execution", detail: "compare, adjust, check" },
        #{ title: "Plan", detail: "compare, adjust, check" },
        #{ title: "Activity", detail: "compare, adjust, check" },
        #{ title: "Answer", detail: "compare, adjust, check" },
        #{ title: "Summary", detail: "isolation and report" },
    ],
};

let compare_schema = #{
    "type": "object",
    "required": ["gaps"],
    "properties": #{
        "gaps": #{
            "type": "array",
            "maxItems": 8,
            "items": #{ "type": "string" },
        },
        "notes": #{ "type": "string" },
    },
};

let check_schema = #{
    "type": "object",
    "required": ["passed", "evidence"],
    "properties": #{
        "passed": #{ "type": "boolean" },
        "evidence": #{ "type": "string" },
    },
};

let wanted = "";
if args != () && args.surface != () {
    wanted = args.surface;
}

let surfaces = [
    #{
        id: "composer",
        title: "Composer",
        ours: "packages/remix_agent/lib/src/components/composer.dart",
        reference: ".local/ui-components/components/agents/prompt-input.tsx",
        tests: "test/components/composer_test.dart",
    },
    #{
        id: "message",
        title: "Message",
        ours: "packages/remix_agent/lib/src/components/message.dart",
        reference: ".local/ui-components/components/agents/message-bubble.tsx",
        tests: "test/components/message_test.dart",
    },
    #{
        id: "transcript",
        title: "Transcript",
        ours: "packages/remix_agent/lib/src/components/transcript.dart",
        reference: ".local/ui-components/components/agents/message-scroller.tsx",
        tests: "test/components/transcript_test.dart",
    },
    #{
        id: "permission",
        title: "Permission",
        ours: "packages/remix_agent/lib/src/components/permission.dart",
        reference: ".local/ui-components/components/agents/tool-approval.tsx",
        tests: "test/components/permission_test.dart",
    },
    #{
        id: "execution",
        title: "Execution",
        ours: "packages/remix_agent/lib/src/components/execution.dart",
        reference: ".local/ui-components/components/agents/tool-result.tsx",
        tests: "test/components/execution_test.dart",
    },
    #{
        id: "plan",
        title: "Plan",
        ours: "packages/remix_agent/lib/src/components/plan.dart",
        reference: ".local/ui-components/components/agents/todo-list.tsx",
        tests: "test/components/plan_test.dart",
    },
    #{
        id: "activity",
        title: "Activity",
        ours: "packages/remix_agent/lib/src/components/activity.dart",
        reference: ".local/ui-components/components/agents/agent-activity/index.tsx",
        tests: "test/components/activity_test.dart",
    },
    #{
        id: "answer",
        title: "Answer",
        ours: "packages/remix_agent/lib/src/components/answer.dart",
        reference: ".local/ui-components/components/agents/streaming-response.tsx",
        tests: "test/components/answer_test.dart",
    },
];

let rules = "";
rules += "Follow skills/using-remix and .agents/skills/mix. ";
rules += "Keep host DefaultTextStyle ink. No token pipeline, Fortal recipes, AgentScope, Lucide dependency, syntax highlighter, model picker, action menu, or chat shell. ";
rules += "Do not change packages/remix or packages/remix_fortal public APIs. ";
rules += "Do not write third-party catalog names into packages/remix_agent or docs/plans. ";
rules += "Keep Enter/IME/send-stop, live-edge follow, and collapse-when-complete behavior. ";
rules += "Prefer Mix stylers and Remix widgets for chrome. ";

let rows = [];
for s in surfaces {
    if wanted != "" && s.id != wanted {
        continue;
    }

    phase(s.title);
    log("Comparing " + s.title);

    let compare_prompt = "";
    compare_prompt += "Compare one remix_agent surface to the local reference checkout. ";
    compare_prompt += "You MUST read both files with read_file before answering: ";
    compare_prompt += "OURS=" + s.ours + " REFERENCE=" + s.reference + ". ";
    compare_prompt += "Also read packages/remix_agent/lib/src/style/defaults.dart if the surface uses it. ";
    compare_prompt += "If the reference file is missing, return gaps=[] and notes='reference missing'. ";
    compare_prompt += "List at most 8 concrete visual/layout gaps we should close in Flutter while staying Remix-correct. ";
    compare_prompt += "Do not invent gaps you did not see in both files. Empty gaps is valid only after both files were read. ";
    compare_prompt += rules;
    compare_prompt += "Return JSON {gaps: string[], notes?: string}.";

    let compared = agent(compare_prompt, #{
        label: "compare-" + s.id,
        capability_mode: "read-only",
        output_schema: compare_schema,
    });

    let gaps = [];
    let notes = "";
    if compared != () && compared.success && compared.output != () {
        if compared.output.gaps != () {
            gaps = compared.output.gaps;
        }
        if compared.output.notes != () {
            notes = compared.output.notes;
        }
    }

    log(s.id + " gaps=" + gaps.len().to_string());

    if gaps.len() > 0 {
        let adjust_prompt = "";
        adjust_prompt += "Adjust ONLY " + s.ours + " and its worksheet under packages/remix_agent/specs if needed, plus packages/remix_agent/lib/src/style/defaults.dart when shared measurements must change. ";
        adjust_prompt += "Gaps to close (from an independent compare): " + json_encode(gaps) + ". ";
        adjust_prompt += "Read the shipped file and the reference " + s.reference + " again before editing. ";
        adjust_prompt += "Make the smallest Remix-correct visual adjustments. Do not add out-of-scope product chrome. ";
        adjust_prompt += rules;
        adjust_prompt += "Update " + s.tests + " if geometry/chrome assertions must move with the layout. ";
        adjust_prompt += "Then run: cd packages/remix_agent && fvm flutter test " + s.tests + " and fix failures you caused.";

        let adjusted = agent(adjust_prompt, #{
            label: "adjust-" + s.id,
            capability_mode: "all",
        });
        if adjusted == () || !adjusted.success {
            log("adjust failed for " + s.id);
        }
    }

    let check_prompt = "";
    check_prompt += "Verify the shipped implementation of " + s.title + ". ";
    check_prompt += "Read " + s.ours + " and packages/remix_agent/" + s.tests + ". ";
    check_prompt += "Run exactly: cd packages/remix_agent && fvm flutter test " + s.tests + " ";
    check_prompt += "and capture the real output. ";
    check_prompt += "Set passed=true only if that command exits 0. ";
    check_prompt += "evidence must quote the test summary line (e.g. All tests passed) or the first failure. ";
    check_prompt += "Do not claim pass without running the command.";

    let checked = agent(check_prompt, #{
        label: "check-" + s.id,
        capability_mode: "all",
        output_schema: check_schema,
    });

    let passed = false;
    let evidence = "check did not run";
    if checked != () && checked.success && checked.output != () {
        if checked.output.passed == true {
            passed = true;
        }
        if checked.output.evidence != () {
            evidence = checked.output.evidence;
        }
    }

    rows.push(#{
        id: s.id,
        title: s.title,
        gaps: gaps.len(),
        notes: notes,
        passed: passed,
        evidence: evidence,
    });
}

phase("Summary");
log("Running package isolation check");

let iso_prompt = "";
iso_prompt += "From the remix repo root run these and report the raw results: ";
iso_prompt += "1) rg -i 'beui|starc007' packages/remix_agent docs/plans ; ";
iso_prompt += "2) rg 'package:flutter/material.dart' packages/remix_agent/lib ; ";
iso_prompt += "3) git status --short -- packages/remix packages/remix_fortal ; ";
iso_prompt += "4) cd packages/remix_agent && fvm dart analyze . ; ";
iso_prompt += "5) cd packages/remix_agent && fvm flutter test . ";
iso_prompt += "passed=true only if analyze is clean (No issues found), the package tests pass (All tests passed), both greps have zero matching lines, and remix/remix_fortal are unmodified. ";
iso_prompt += "A grep with no matching lines is success even when the tool exits 1. Do not treat an empty no-match grep as FAIL. ";
iso_prompt += "evidence must include the command tails.";

let iso = agent(iso_prompt, #{
    label: "isolation",
    capability_mode: "all",
    output_schema: check_schema,
});

let iso_ok = false;
let iso_ev = "isolation check missing";
if iso != () && iso.success && iso.output != () {
    if iso.output.passed == true {
        iso_ok = true;
    }
    if iso.output.evidence != () {
        iso_ev = iso.output.evidence;
    }
}

let report = "# remix-agent-compare\n\n";
for row in rows {
    let mark = "FAIL";
    if row.passed {
        mark = "PASS";
    }
    report += "- " + row.title + " [" + mark + "] gaps=" + row.gaps.to_string();
    report += " " + row.evidence + "\n";
}
report += "\nIsolation: ";
if iso_ok {
    report += "PASS\n";
} else {
    report += "FAIL\n";
}
report += iso_ev + "\n";

let path = write_scratch_file("remix-agent-compare.md", report);
complete(#{
    path: path,
    isolation: iso_ok,
    surfaces: rows,
});
