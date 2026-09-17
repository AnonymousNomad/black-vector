---
name: large-world-sector-architecture
description: Large-world sector architecture — the one-world BLACK VECTOR space sliced into sectors with clean ownership, loading discipline, and explicit boundaries. NO streaming implementation now — this skill is architecture and handoff doctrine only. Load when structuring the world, sectors, or their boundaries.
---

# LARGE-WORLD SECTOR ARCHITECTURE (BV-SKILL-013)

## NAME
LARGE-WORLD SECTOR ARCHITECTURE

## PURPOSE
Structure BLACK VECTOR's single persistent Alaska wilderness world (doctrine §5, §31, BV-D009) as a set of clean sectors with explicit ownership, boundaries, cross-sector references, ACTIVATION discipline, and handoff documentation — so the continuous world stays composable and cost-bounded on the tablet WITHOUT implementing streaming now (streaming is out of scope; this skill is architecture/handoff doctrine only, doctrine §31).

## WHEN TO LOAD
- Partitioning the world, defining sectors, or writing sector handoff docs.
- Reasoning about cross-sector references, load boundaries, or one-world continuity.

## DO NOT LOAD WHEN
- Runtime loading/streaming implementation (NOT AUTHORIZED — this skill explicitly does not build it).
- Per-sector content authoring (BV-SKILL-006).

## PRECONDITIONS
- Governing set loaded.
- One-world identity confirmed (single persistent world; sectors are spatial slices, not separate worlds/levels).

## GOVERNING INVARIANTS
1. One world, one space: sectors are contiguous partitions of a single coordinate-grounded fictional Alaska-inspired region; there is no level-loading metaphor and no conventional level selection. A sector is a spatial/ownership construct, not a separate "map" (doctrine §5).
2. ACTIVATION (not "levels"): only the player's RELEVANT region receives expensive simulation; other sectors exist in a light/static pedigree. This is documented here as doctrine and implemented only under a later authorized directive — NO streaming/loading code now.
3. NO STREAMING IMPLEMENTATION NOW: this skill defines doctrine for how sectors will be activated/deactivated/bounded later, including large-world coordinates and origin-shift considerations. Neither code nor scene implements streaming under the methodology phase; future implementation requires its own authorization (doctrine §31).
4. TRANSITIONS ARE CONCEALED BY DESIGN: loading boundaries are placed behind traversal, interiors, weather, boat travel, caves, tunnels, elevators, and distance (doctrine §5). A sector seam must be authored to feel continuous even when activation changes.
5. Sector = owner of its content: each piece (mesh/collider/props/affordance tags from BV-SKILL-006) belongs to exactly one sector; no cross-sector piece ownership.
6. Explicit boundaries: sector boundaries are defined (spatial extents + logical seam) and documented; cross-sector references are EXPRESSED IN DOCUMENTATION as intent (which dynamic entities may pass, what interacts across seams), never as hard cross-scene node grabbing.
7. Collaborative handoff: every sector ships with a handoff doc — gameplay surfaces + tags inventory (BV-SKILL-006), dynamic entity expectations, perf headroom notes (SOP-004), and the concealed-transition plan. The handoff doc is validation input, not decoration.
8. Large-world discipline: world coordinates and physics precision are planned for (large world coordinates / origin shifting strategy DOCUMENTED now, implemented later on authorization); sector size keeps a sector runtime-loadable on the tablet budget under the future activation scheme.

## WORKFLOW
1. Read current world structure in current form (world root, sector list, boundaries).
2. Audit ownership: assign every piece to exactly one sector; identify orphaned/duplicated pieces.
3. Write/update sector docs: spatial extents, seam behavior, dynamic-entity expectations, affordance inventory, perf notes.
4. Verify: no piece in two sectors; seams documented; no crossing hard node references; streaming markers absent (no loading code introduced).
5. Static verify; behavioral/device verify only when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Sector scale target: a sector sized so its full content fits the tablet runtime budget when activated (SOP-004). Larger worlds = more sectors, not bigger sectors.
- Keep sector roots as clean scene roots instanced into a world root at build time; sector content stays self-contained (BV-SKILL-002).
- Seam conventions: adjacent-sector shared-feature list (roads, sightlines, sound bleed, the concealed-transition point) documented — never "owned" twice. Example: a coastal-sector → island-sector transition hides activation inside a boat crossing; a valley seam hides inside a storm or tunnel (doctrine §5).
- Relationship with world-as-interface: sectors are the spine of the exploration interface (doctrine §5) — they are authored as the map the player reads diegetically (landmarks, weather direction), never as menu-selectable missions.
- Note large-world approach in doctrine/decisions (BV-D009 reference) and re-raise at first device profile if coordinates exceed the safety range.

## ANTI-PATTERNS
- Implementing streaming/activation/loading code now (scope violation under the methodology phase; requires authorization).
- Sector boundaries invisible → pieces accidentally double-owned or orphaned.
- Cross-sector node grabbing `get_node("SectorB/Road/Rock")` from Sector A (documented intent only).
- Sectors sized "as big as possible."
- Treating sectors as separate levels or as menu-selectable missions (breaks one-world identity, doctrine §5).
- Seams that announce themselves as level loads (no concealed transition).

## KNOWN FAILURE MODES
- Two sectors claim the same road → ownership audit catches; resolve by extents.
- Handoff doc drifts from actual content after piece edits → re-run sector validation on content change.
- Precision faults at large coordinates (physics jitter) — follow the documented large-world strategy when implemented; flag early evidence at device profile.
- Activation seam visible as game-feel pop (the "invisible level load") — the concealed-transition plan is part of handoff and QA; a seam that feels like a loading screen is a defect.

## VERIFICATION
- Static: ownership one-to-one; seams documented; no loading code present; handoff docs exist per sector; streaming markers absent.
- Behavioral (when authorized): world loads as one scene graph with sector roots cleanly instanced; boundary walk shows no double-owned pieces.

## STOP CONDITIONS
If ownership is ambiguous for any piece, or streaming code appears without scope authority, stop and resolve — architecture ambiguity is a world defect.

## PERFORMANCE
- Sector budget = full-sector load fits device frame/memory budget (SOP-004); record per-sector headroom in handoff docs.

## DEVICE
- Tablet: sector content load/unload strategy (future) verified on device when authorized; never desktop-only claim.

## RELATED SKILLS
- BV-SKILL-002 scene-composition (sector roots/instancing)
- BV-SKILL-006 environmental-affordances (per-sector surface inventory)
- BV-SKILL-014 mobile-graphics-atmosphere (baked lighting per sector)
- SOP-004 mobile-performance; developers-way (governing)