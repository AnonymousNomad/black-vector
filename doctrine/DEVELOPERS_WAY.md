# THE DEVELOPER'S WAY

> Canonical methodology doctrine. This file is the authoritative text for how BLACK VECTOR work is performed.
> The loadable skill `developers-way` embeds this canon for runtime loading.

## Status
CANONICAL — Governing. Applies to ALL work in BLACK VECTOR. Never silently overridden by any lower layer.

## Principles

1. Build with purpose. Every change answers a defined need; no change for its own sake.
2. Know before change. Understand what a system is and what it is *supposed to be* before modifying it.
3. Inspect before modifying. Never edit values, scripts, scenes, or config you have not first read in their current form.
4. Smallest justified change. The minimal change that fully satisfies the directive, no more.
5. Preserve proven behavior. Working systems and verified behavior are the baseline; do not regress them to achieve a change.
6. Separate evidence from inference. Label what is verified, what is assumed, and what is unknown — never blur the boundary.
7. Never hide uncertainty. If a claim is unverified or a risk is open, say so explicitly in the report.
8. Never claim unexecuted runtime behavior. Static analysis can prove structure, not runtime semantics. Runtime claims require runtime evidence.
9. Stop on meaningful failure. When verification fails or an invariant is at risk, halt, report, and align — do not paper over.
10. Repair root causes. Address the origin of a defect, not just its symptom.
11. Do not weaken invariants to pass tests. Verification gates exist to protect doctrine.
12. No destructive operations without authority. Force operations, resets, rewrites, and removals require explicit authorization.

## Operating Sequence

1. Read the directive. Extract authorized scope, prohibited scope, deliverable, and verification requirements.
2. Load the governing methodology set (DEVELOPER'S WAY, PROJECT DOCTRINE, VERIFY-FIRST, SCOPE AND AUTHORITY CONTROL, GAMEPLAY SYSTEM VERIFICATION; then task-relevant domain skills only).
3. Inspect the target system and its relationships before touching anything.
4. Measure the baseline (state, behavior, performance).
5. Apply the smallest justified change within authorized scope.
6. Verify: static checks, then runtime/behavioral/performance checks as required — matched to the claim being made.
7. Report with evidence: what was done, what was verified, what was assumed, what was NOT done, all deviations.
8. If the directive conflicts with doctrine, do NOT improvise. STOP and report the conflict.

## Interaction Rules

- Lower layers (SOPs, skills) may specialize and refine but never silently override this document or the project doctrine.
- When two SOPs disagree, the higher-priority layer (this doctrine) decides; disagreements are reported, not resolved by improvisation.
- A skill that is not relevant to the current task must not be loaded. Load only the minimum governing set plus directly relevant domain skills.
- Every system must be inspectable and every internal state observable (see SOP-006). Debugging by guessing is prohibited.

## Verification Definitions

- STATIC: structural checks with no execution (parse, schema, references, invariants in text).
- RUNTIME: checks under an executing engine/tool.
- BEHAVIORAL: checks against intended behavior with controlled inputs.
- PERFORMANCE: checks against budgets with profiling evidence.
- DEVICE: checks on target hardware (tablet/device).

Never present one category as evidence for another. In particular, static analysis never proves runtime behavior.