# SOP-003 — GODOT CHANGE PROCEDURE

## Purpose
Make engine changes to scenes, scripts, resources, input, autoloads, and `project.godot` in a disciplined order so nothing is edited blind and nothing regresses silently.

## When Mandatory
Every time a directive authorizes changes to Godot assets, scripts, resources, project settings, or the scene tree. Not applicable to pure methodology files.

## Workflow
1. RELATIONSHIP INSPECTION (mandatory, before ANY modification): for each target, read it in its CURRENT form, then read its relationships:
   - Scene/script: which script is attached, which nodes reference it, which scenes/prefabs instance it, which autoloads/signals it connects to, which exported resources it uses.
   - Resource: where it is referenced from, what it inherits (ext_resource/extends), who writes to it.
   - Input: which actions are bound to which events, which code polls those actions.
   - Autoload: its registration in project settings, who depends on it, initialization order.
   - `project.godot`: current config_version, renderer settings, main scene, autoload section, input section, GDExtension/DLL entries.
   If a relationship is unknown, STOP and inspect before proceeding.
2. ORDER: modify leaf assets/resources before the nodes that reference them; update references last; never leave a dangling reference.
3. ATOMICITY: one logical change per step, verified immediately (must parse, must load, must not break references).
4. STATIC VERIFY: parse scripts (`--check-only` if tooling available), validate scene/resource references, confirm no broken `ext_resource` paths.
5. RUNTIME/DEVICE VERIFY: only for systems the directive authorizes to run; never claim runtime validity from static checks alone (SOP-005).
6. RECORD: log every file touched, every setting changed, with the reason tied to the directive.

## Invariants
- Nothing edited without a current read (Developer's Way: inspect before modifying).
- No dangling references left behind; relationships re-inspected after change.
- Project settings changes are minimal and justified.

## Stop Conditions
If a relationship cannot be traced, a load/parse fails, or a change would ripple beyond intended referencers — stop and report before proceeding.