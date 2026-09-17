# SOP-002 — SCOPE AND AUTHORITY CONTROL

## Purpose
Ensure every operation is authorized. Nothing outside the current directive's granted scope is performed, and prohibited operations are never performed even when they seem convenient.

## When Mandatory
Before EVERY action: confirm the action is (a) within the current directive's authorized scope and (b) not on the prohibited list.

## Scope Classification
A directive defines three sets explicitly:
1. AUTHORIZED — work packages, files, and systems the directive grants.
2. PROHIBITED — explicitly forbidden operations (e.g., for Directive 002: no gameplay code, no scenes, no `project.godot`, no BV-001 implementation, no commits/pushes/remotes).
3. UNAUTHORIZED BY DEFAULT — everything not mentioned. Treat as forbidden unless a boundary question is raised and answered.

## Rules
- If scope is ambiguous: ask. Do not infer authority from convenience.
- Destructive or irreversible operations (force push, reset --hard, history rewrite, mass delete, LFS migration, project recreation) require EXPLICIT authorization beyond any standing grant.
- Commit, push, branching, and remote creation likewise require explicit authorization — never performed as a side effect of other work.
- A change that drifts outside authorized scope — even a small one — is a scope violation. Boundary creep is ejected and reported.
- When a directive conflicts with governing doctrine: STOP, report the conflict, do not improvise.

## Workflow
1. Parse the directive into AUTHORIZED / PROHIBITED / UNAUTHORIZED-BY-DEFAULT.
2. Work only inside AUTHORIZED.
3. Log any borderline boundary question in the report, even when resolved.
4. Before completion, re-read the directive and confirm the deliverable is exactly what was asked for.

## Invariants
- No operation occurs without an authority rationale.
- Deliverable is verbatim to the directive's specification.
- Prohibited list is never emptied by convenience.

## Stop Conditions
On any observed scope expansion without authorization, stop the expansion immediately, report it, and ask before continuing.