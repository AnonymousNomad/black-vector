---
name: scene-composition
description: How to compose Godot scene trees that stay legible, modular, and relationship-safe in BLACK VECTOR — node roles, instancing, ownership, and change discipline for scenes. Load when creating or modifying scenes and scene relationships.
---

# SCENE COMPOSITION (BV-SKILL-002)

## NAME
SCENE COMPOSITION

## PURPOSE
Keep scene trees small, legible, and relationship-safe so that scenes are inspectable, changeable without ripple damage, and composable into the one-world structure without god-scenes.

## WHEN TO LOAD
- Creating or editing `.tscn`/`.godot` scene files, node structure, instancing, or exported node references.
- Any work that must read or preserve scene relationships.

## DO NOT LOAD WHEN
- Pure scripting at a layer that owns no scene tree (data/reasoning skills only).

## PRECONDITIONS
- Governing set loaded.
- SOP-003 relationship inspection available (inspect before ANY scene modification).

## GOVERNING INVARIANTS
1. Every node has one role: a scene is either a Character, a World Piece, an Interface, an Area/Trigger, or a System Hub — explicit in its root comment or class.
2. Composition over inheritance: prefer owned child nodes and injected dependencies over deep `extends` hierarchies.
3. No god-scenes and no god-scripts: any node owning more than its stated role is a violation to split.
4. Instancing: reusable pieces are PackedScenes; shared configuration lives in Resources (`.tres`), never duplicated in node trees.
5. Relationships are explicit and traceable: exported node paths, `@onready` access only at ready time, and no hidden `get_node("hardcoded/path")` strings.
6. Changes are atomic and verified: read the scene in current form first; modify leaf before referencer (SOP-003).
7. One scene per file boundary: the scene tree and its script file must agree (script does not reach outside its scene via hardcoded paths).

## WORKFLOW
1. Read the target scene in current form; read what references it (instances, scripts, autoload, exported resources).
2. Identify role classes of nodes; confirm each node fits its role.
3. Choose the smallest structural change; prefer editing data (Resource) over restructuring the tree.
4. Apply; immediate static check (references resolved, no broken `ext_resource`, parse clean).
5. Record the relationship diagram of what changed (who refers to whom) for the report.

## IMPLEMENTATION GUIDANCE
- Autoloads are for cross-cutting, stateless or thin services only; gameplay data belongs to scenes/resources.
- Reuse established patterns (e.g., region/resource naming) — convention consistency beats cleverness.
- Keep node names stable once referenced; renaming is a relationship change and requires the full workflow.

## ANTI-PATTERNS
- One monolithic scene holding the entire world (split by sector/area; see large-world-sector-architecture).
- `$"Deep/Path/Nodes"` chains reaching across scene roots from a script.
- Deep inheritance forests where a composed node layout would do.
- Copy-pasting node subtrees instead of instancing a PackedScene.
- Editing a scene from memory without re-reading it.

## KNOWN FAILURE MODES
- Dangling `ext_resource` after a resource path move → re-inspect references and fix in referencers.
- Duplicated state between a Resource and the node that reads it (single source of truth).
- `@onready` ordering bugs — initialize only references actually ready at `_ready`; prefer `_physics_process` first-frame guards for cross-scene links.

## VERIFICATION
- Static: each node has a role; references resolved; scene parses; script and tree agree; no god-scene.
- Behavioral (when running is authorized): a composed scene loads without errors and its role contract holds.

## STOP CONDITIONS
If a scene's relationships cannot be fully traced (who instances/reads it), stop and inspect before any edit; if any role is ambiguous, stop and assign.

## RELATED SKILLS
- BV-SKILL-006 environmental-affordances (world-piece composition)
- BV-SKILL-013 large-world-sector-architecture (world partitioning)
- SOP-003 godot-change-procedure; developers-way (governing)