# SOP-005 — GAMEPLAY SYSTEM VERIFICATION

## Purpose
Define how a gameplay system earns the label "verified." Prevent structure-checks from being presented as proof of runtime behavior.

## Verification Categories (definitions from the Developer's Way)
- STATIC — structural, no execution: parse, schema, reference integrity, cross-file consistency.
- RUNTIME — evidence under an executing engine/tool (headless or on-device).
- BEHAVIORAL — controlled-input tests against expected behavior (asserts, fixtures, in-engine tests where available).
- PERFORMANCE — profiling against budgets (SOP-004).
- DEVICE — execution on target hardware (tablet/device).

## Rules
1. MATCH THE CLAIM: a claim of "this works" requires BEHAVIORAL (and typically RUNTIME) evidence. STATIC evidence supports structural claims only.
2. NO LEAKAGE: never present static analysis as runtime proof; never present desktop performance as device performance.
3. NO SYSTEM IS RUNTIME-PROVEN FROM STATIC ANALYSIS ALONE. Where runtime tooling is unavailable (e.g., no engine binary present), the report must say "STRUCTURALLY VERIFIED, RUNTIME PENDING DEBT" — never "working."
4. DEBT TRACKING: a system that is structurally complete but unexecuted is tracked as pending debt until it runs on the target device. Debt is reported, not hidden.
5. BEHAVIORAL COVERAGE: where tests/fixtures are authorized, test the seams that encode doctrine (signature channels, bounded perception, memory progression, no-hidden-flag), not just the happy paths.

## Workflow
1. Declare claim type per deliverable.
2. Execute the matching verification.
3. Record results and explicitly label the verification category for every claim.

## Invariants
- Claim category == evidence category (or the mismatch is stated in the report).
- Pending runtime validation is always declared in the completion report.

## Stop Conditions
If a deliverable requires runtime proof, tooling is absent, and the directive expects running behavior → deliver static evidence, label it, and surface the gap rather than bluffing completion.