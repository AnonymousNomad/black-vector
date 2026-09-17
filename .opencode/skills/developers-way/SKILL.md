---
name: developers-way
description: The governing methodology for all BLACK VECTOR work — build with purpose, inspect before modifying, smallest justified change, evidence over assumption, verification discipline. ALWAYS loaded first, before any task directive or domain skill.
---

# DEVELOPER'S WAY

## NAME
DEVELOPER'S WAY — governing methodology canon for every BLACK VECTOR task.

## PURPOSE
Make every act of work in this project deliberate, evidence-based, and audit-safe: inspect before change, verify after change, report honestly, and never improvise past authority.

## WHEN TO LOAD
ALWAYS. Before reading any directive. This is the first item of the governing set and is required before ANY implementation or analysis work.

## DO NOT LOAD WHEN
Never skip it. (This is the one skill with no skip condition.)

## PRECONDITIONS
- None. Load first, always.

## GOVERNING INVARIANTS
1. Build with purpose; no change without a defined need.
2. Know before change; inspect before modifying (read the current form first).
3. Smallest justified change; preserve proven behavior.
4. Separate evidence from inference; never hide uncertainty.
5. Never claim unexecuted runtime behavior (SOP-005).
6. Stop on meaningful failure; repair root causes; do not weaken invariants to pass tests.
7. No destructive operations, commits, pushes, or branches without explicit authority (SOP-002).
8. Lower layers specialize; they never silently override this document or the project doctrine.
9. Every system must be observable (SOP-006). Debugging by guessing is prohibited.

## WORKFLOW
1. Read the directive; extract AUTHORIZED / PROHIBITED / UNAUTHORIZED-BY-DEFAULT scope.
2. Load governing set (this skill, project doctrine, verify-first, scope-authority, gameplay-verification).
3. Inspect the target system and its relationships in their current form.
4. Establish baseline (state/behavior/performance) as evidence.
5. Apply the smallest justified change inside authority.
6. Verify with the category that matches the claim (static/runtime/behavioral/performance/device).
7. Report: done / verified / assumed / unknown / not-done / deviations, each labeled.
8. On conflict with doctrine: STOP, report, align. Do not improvise.

## IMPLEMENTATION GUIDANCE
- Treat every file read as a fresh fact. Never trust memory of a file's contents.
- When verification tooling is absent, say "structurally verified; runtime pending debt" — never "working."
- Keep reports compact: one line per finding, with `file:line` references.
- The methodology set is incomplete if any of the five governing files cannot be loaded → STOP.

## ANTI-PATTERNS
- Editing a file that was not read in this session.
- Claiming a system works based on a parse check alone.
- "Optimize later" as an excuse for known unbounded cost (SOP-004).
- Weakening an invariant or test to make a check pass.
- Hiding a scope deviation because it was "small."

## KNOWN FAILURE MODES
- Cross-contamination between projects (porting NOMADIC CREED assumptions into BLACK VECTOR): guarded by doctrine §1.
- Treating world-model knowledge as global truth: guarded by Pillar KNOWLEDGE (state has a source).
- Verifying structurally and reporting behaviorally: guarded by verification-category rules.

## VERIFICATION
- Static: each claim in a report maps to an evidence line; every deviation has a label.
- The methodology is satisfied when a report explicitly separates VERIFIED/ASSUMED/UNKNOWN/NOT DONE and no
  runtime claim lacks runtime evidence.

## STOP CONDITIONS
Stop immediately if: the governing set cannot be fully loaded; a directive conflicts with doctrine; a verification
fails; or scope is ambiguous. Report and align before continuing.

## RELATED SKILLS
- black-vector-project-doctrine (canon in doctrine/BLACK_VECTOR_DOCTRINE.md)
- SOP-001 verify-first, SOP-002 scope-authority, SOP-005 gameplay-verification (load as governing set)
- SOP-003 godot-change-procedure, SOP-004 mobile-performance, SOP-006 debug-observability (load on demand)