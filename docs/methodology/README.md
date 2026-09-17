# BLACK VECTOR — METHODOLOGY INDEX

This folder documents how BLACK VECTOR work is performed. It is the reading order for any agent entering the project.

## Reading order (established by Directive 002)

1. `doctrine/DEVELOPERS_WAY.md` — the canon: principles, operating sequence, verification definitions.
2. `doctrine/BLACK_VECTOR_DOCTRINE.md` — the project: identity, pillars, doctrine, decisions, hierarchy.
3. `sop/verify-first.md` (SOP-001) — inspect before change, verify after.
4. `sop/scope-authority.md` (SOP-002) — authorized/prohibited/default-forbidden.
5. `sop/gameplay-verification.md` (SOP-005) — what earns "verified"; no static-is-runtime.
6. `sop/godot-change-procedure.md` (SOP-003) — relationship-inspect before editing engine assets.
7. `sop/mobile-performance.md` (SOP-004) — measure first, budgets, renderer contracts.
8. `sop/debug-observability.md` (SOP-006) — systems expose state; no guessing.
9. `skills/registry.md` — mapping task → domain skill, and skill-number → slug.
10. `.opencode/skills/<slug>/SKILL.md` — load task-relevant domain skills only.

## Guardrails

- ALWAYS load the governing set, in order, before a task directive is executed. If the governing methodology
  cannot be loaded, STOP — do not implement.
- Load only the domain skills the task actually needs. Do not load every skill for every task.
- If a directive conflicts with doctrine, STOP and report the conflict. Do not improvise.
- Methodology files are documentation and skill material. They are not gameplay. Gameplay implementation begins
  only when a directive authorizes it (currently: NOT STARTED).

## Validation

`tools/validate_methodology.py` statically checks skill files (frontmatter, required sections, registry
consistency, prohibited-term scan). Run it when methodology changes.