# SOP-001 — VERIFY-FIRST DEVELOPMENT

## Purpose
Guarantee that no change ships on assumption. Every claim about the state of the project and every change to it must be preceded by inspection and verified after the fact.

## When Mandatory
Always. This SOP is part of the permanently loaded governing set for every directive.

## Workflow
1. INSPECT: read the actual current state of every file, node, setting, and relationship the directive will touch. Read them, do not recall them.
2. BASELINE: record the verified starting state (HEAD, branch, working tree status, config, signature of behavior) as evidence.
3. OWNERSHIP: confirm the change is inside the directive's authorized scope (see SOP-002). If not, stop and report.
4. SMALLEST CHANGE: apply the minimal justified change. Preserve proven behavior.
5. VERIFY: run the checks that match the claim being made — STATIC for structure, RUNTIME/BEHAVIORAL/PERFORMANCE/DEVICE for semantics (definitions in Developer's Way).
6. INDEPENDENT RECHECK: when the claim is material (push, handoff, release), re-verify from a fresh read — never trust your own earlier glance.
7. EVIDENCE: record results verbatim (commands, outputs, hashes) in the report. Label verified vs. assumed vs. unknown.

## Invariants
- Nothing is "known" about project state without a fresh read.
- No runtime claim is made from static analysis alone.
- Every report distinguishes VERIFIED / ASSUMED / UNKNOWN / NOT DONE.

## Verification
The SOP itself is verified when: baseline recorded, post-change check executed, result recorded, deviations flagged.

## Stop Conditions
If a check fails, a result is ambiguous, or the intended change depends on an unverified assumption — stop, report the blocker, and align before proceeding.