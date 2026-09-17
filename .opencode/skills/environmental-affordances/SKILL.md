---
name: environmental-affordances
description: Environmental affordances — terrain-as-gameplay surfaces, tagged world props, and composable world pieces for the one-world BLACK VECTOR space. The layer that decides WHAT is usable and WHERE, keeping expectation doctrine. Load when designing or placing world geometry/props.
---

# ENVIRONMENTAL AFFORDANCES (BV-SKILL-006)

## NAME
ENVIRONMENTAL AFFORDANCES

## PURPOSE
Define and place the world's usable surfaces so terrain is gameplay (doctrine §5): traversal, concealment, positioning, observation, escape, and ambush are all supported where the player reasonably expects them — deliberately, not accidentally — across the Alaska-inspired wilderness (boreal forest, mountains, snow, coast, settlements, military/research infrastructure, underground). Tags answer the expectation question AND the weather question (which surfaces become concealment vs. hazard in snow/storm, doctrine §5/§6/§30).

## WHEN TO LOAD
- Designing/placing world pieces, surfaces, props, or sector layouts.
- Extending the affordance taxonomy or verifying expectation coverage.

## DO NOT LOAD WHEN
- Movement implementation (systemic-traversal / controller own mechanics).

## PRECONDITIONS
- Governing set loaded.
- Affordance taxonomy exists (this skill defines it); world-piece composition conventions from scene-composition.

## GOVERNING INVARIANTS
1. Expectation doctrine (doctrine §5): if the player reasonably expects a surface to support traversal/concealment/positioning/observation/escape/ambush, support it wherever practical.
2. Every gameplay-meaningful surface carries explicit affordance tags (climbable, mantleable, concealment, cover, ledge, branch, vantage) in one place — the world piece — never inferred ad-hoc.
3. Tags have one owner per surface; tag collisions (a surface both cover and climbable) are resolved deliberately with a priority rule, never randomly.
4. Trees are explicit gameplay terrain with the tree-climb arc (doctrine §5); canopy branches provide concealment + observation, and (future) drop-assassination attach points.
5. WEATHER-ADJACENT TAGS: surfaces carry a weather-interaction note (snow-drift cover, storm sound-shield, ice hazard, thermal-concealing rock overhang) as DATA, so survival (BV-SKILL-017), stealth (BV-SKILL-007), and graphics (BV-SKILL-014) consume the same authored intent. A "shelter" surface is truthful or it isn't a shelter.
6. World pieces compose into sectors without re-tagging (a piece ships self-contained: mesh + collider + tags + any interactive hooks).
7. Ambient decoration is distinguished from gameplay surface; the two never visually impersonate each other.
8. Alaska surface families are first-class pieces: trees, ledges, roofs, rocks, wreckage, vegetation, windows, terrain depressions, and industrial/military structures are all candidate gameplay surfaces (doctrine §27) — placed deliberately with the expectation rule applied.

## WORKFLOW
1. Read target sector/piece in current form; inventory surfaces.
2. Classify each gameplay-meaningful surface by affordance(s) and expectation-relevance (would a player try?).
3. Apply/verify tags; resolve collisions by priority rule; record decisions.
4. Cross-check composition: base + props → do tags survive instancing?
5. Static verify (tag inventory complete); behavioral/runtime verify when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Taxonomy primitives: COVER (blocks line-of-sight/ballistics), CONCEALMENT (reduces visual/other signature without blocking), CLIMBABLE, MANTLEABLE, LEDGE, BRANCH, VANTAGE, ESCAPE (leave-point), AMBUSH/NEST, SHELTER (survival-usable; weather-truthful), HAZARD (ice, unstable snow, electric/industrial risk).
- Minimum viable world piece: visual mesh + matching collider + tags block + weather-interaction note + small footnotes for gameplay intent.
- Sector handoff: sector boundary doc lists each gameplay surface and its tag (BV-SKILL-013) — so next engineer (or the AI) doesn't re-derive intent.
- Place vantages and alternate routes deliberately into every sector: a sector with one entrance is a trap, not design.
- Snow/storm states change which surfaces read as concealment vs. hazard: author surface weather-notes so a "shelter rock" is a shelter and a "covered approach" stays a covered approach as the storm builds (doctrine §30).

## ANTI-PATTERNS
- Untagged decorative cliffs that the traversal system ignores while players try to climb them.
- Tag overloading (`climbable = true` on a wall AND used as an ambient texture).
- Re-tagging at instancing time per sector (keep tags in the piece resource).
- Sectors without escape/vantage affordances (breaks expectation doctrine).
- Shelter/concealment tags that weather systems ignore (a tagged shelter that a storm passes through, doctrine §30).
- Carrying over NOMADIC CREED level layouts or its canon (separate project; doctrine §1).

## KNOWN FAILURE MODES
- Geometry/collider mismatch (visually climbable, actually a slipped collider face) — fixture verifies tags match colliders.
- Tag drift when a piece is edited elsewhere — tag block owned by piece; re-validation on change.
- Mixed expectation (e.g., “a low wall, is it cover or mantle?”) — resolve priority explicitly at placement.

## VERIFICATION
- Static: every piece's tag inventory documented; taxonomy terms valid; no untagged gameplay surface in a sector audit.
- Behavioral (when authorized): sample fixture — a real player expectation for each tag type resolves to the tagged behavior.

## STOP CONDITIONS
If a surface's gameplay meaning cannot be stated in one sentence, stop and resolve it — ambiguous surfaces become untrustworthy surfaces.

## PERFORMANCE
- Tags are data, zero runtime cost; runtime only pays for bounded probes (traversal/sensing).

## DEVICE
- None specific; tablet field-of-view means expectation coverage should be validated in-tablet camera, not desktop ultrawide.

## RELATED SKILLS
- BV-SKILL-005 systemic-traversal (traversal consumption of tags)
- BV-SKILL-007 stealth-and-concealment (concealment/cover surfaces)
- BV-SKILL-013 large-world-sector-architecture (sector handoff)
- BV-SKILL-002 scene-composition (piece composition)
- developers-way (governing)