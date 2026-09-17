---
name: facility-and-ally-support
description: Restorable facilities and ally support — approximately five curated restorable bases (DISCOVER→INVESTIGATE→SECURE→RESTORE→CLAIM→IMPROVE), no freeform building; the primary ally (ex-second-in-command) provides base-anchored capabilities, never a constant follower or stat aura. Load when implementing facilities, base mechanics, or the ally's role.
---

# FACILITY AND ALLY SUPPORT (BV-SKILL-020)

## NAME
FACILITY AND ALLY SUPPORT

## PURPOSE
Implement the restorable-facilities layer (doctrine §31) and the primary-ally layer (doctrine §25-26) as capability providers — NOT building sandboxes, NOT follower companions, NOT stat auras. The world's five curated facilities are handcrafted, risk-typed, and restored through a fixed pipeline; the former second-in-command anchors at the player's facility and multiplies what the base provides. Both layers serve the narrative pillars (doctrine §34) and the bounded-scope discipline (doctrine §11).

## WHEN TO LOAD
- Implementing/tuning restorable facilities, base systems, the restore pipeline, or outposts.
- Implementing/tuning the ally's behaviors, base roles, or the reality-reference role.

## DO NOT LOAD WHEN
- Pure combat/stealth internals (BV-SKILL-007/008/009/010/011) — the ally/facility provide context, not mechanics.
- Memory-progression internals (BV-SKILL-012) — facilities/ally CONSUME memory/capability gates.

## PRECONDITIONS
- Governing set loaded.
- Five-facility plan (doctrine §31) and ally design (doctrine §25-26) read.
- Progression/capability model (BV-SKILL-012) and sector architecture (BV-SKILL-013) exist.

## GOVERNING INVARIANTS
1. APPROXIMATELY FIVE CURATED FACILITIES (doctrine §31, BV-D019): COASTAL/MARINE, FOREST/RESEARCH, MOUNTAIN/RADAR, UNDERGROUND/MINE, PRIMARY BLACK HAND FACILITY. NO voxel/freeform/unrestricted building, ever.
2. EACH FACILITY IS DISTINCT IN ALL FOUR: environment, built-in infrastructure, risk, and strategic advantage — plus a HANDCRAFTED VISUAL IDENTITY (doctrine §31). Facilities are never reskins.
3. RESTORE PIPELINE IS CANONICAL: DISCOVER → INVESTIGATE → SECURE → RESTORE POWER/HEAT/ACCESS → CLAIM → IMPROVE (doctrine §31). Each stage is observable, gated, and logged with reason (BV-SKILL-015).
4. HOME + OUTPOSTS: the player chooses a primary home and retains others as outposts (doctrine §31) — outports are lesser, seasonal, or support-typed, not "also full bases."
5. ALLY IS BASE-ANCHORED (doctrine §26, BV-D020): the former second-in-command does NOT constantly follow. He defends/occupies the restored base, investigates independently, provides radio/intel analysis, identifies Hidden Hand methods, trains, maintains equipment, reconnoiters, reconstructs story/memory, and acts as an occasional REALITY REFERENCE during anomalous events (BV-SKILL-018).
6. ALLY PROVIDES CAPABILITIES, NOT AURAS: ALLY AT BASE → better intel, improved preparation, recovered Hidden Hand techniques, stronger base defense, equipment support, recovery support (doctrine §26). Any "ally-buffs-stats-when-nearby" pattern is a violation.
7. ALLY IS IMPERFECT: he carries his own conditioning, damage, uncertainty; he can be unreliable (doctrine §26). Reconciled, not idealized.
8. CHARACTER EVENTS, NOT TASK QUEUES: encounters with other former members are character events (doctrine §27); the ally's network is how the player MEETS the roster — the base is a social hub that respects isolation/horror (doctrine §23; the world stays mostly lonely).
9. FACILITIES FEED SURVIVAL AND PROGRESSION: a restored facility is survival infrastructure (warmth, shelter, healing — BV-SKILL-017), a progression anchor (capability families recover on-site, BV-SKILL-012), and a sector landmark (BV-SKILL-013). Same authored truth, multiple consumers (SOP-003 relationship rule).

## WORKFLOW
1. Read current base/ally handling in current form; confirm no builder-companion-aura patterns.
2. Fix the five-facility roster (data): environment, infrastructure, risk identity, strategic advantage, visual identity; declare which is the PRIMARY BLACK HAND FACILITY.
3. Implement the restore pipeline as an explicit gated state machine with reasons per stage.
4. Implement the ally as a set of base-role behaviors (defend/occupy/investigate/radio/intel/train/equip/reality-reference) dispatched from the base — never a follow-clairvoyance companion.
5. Wire facility capability consumption (survival restoration, capability recovery, sector presence) through the shared capability/weather state (BV-SKILL-012/017/013).
6. Static verify; behavioral/device verify when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Representation: each facility is a scene/root (BV-SKILL-002) implementing a "facility_state" (undiscovered→discovered→investigated→secured→restored→claimed→improved) with per-stage gates (power, heat, access, security). Observable and logged (BV-SKILL-015).
- Ally mechanics live as base-role jobs with cooldown/intent and an absence (independent investigations) — his presence is a budgeted resource, not a permanent wall of firepower.
- The reality-reference role: on authored anomaly events (BV-SKILL-018), the ally (when present) may voice one grounded reading — a diegetic, budgeted sanity anchor, never an overlay (BV-SKILL-015).
- Outposts: reuse the pipeline with a lighter "outpost" tier (supply, safe-shelter, radio) so scope stays bounded (doctrine §31 vs §11).
- Keep facility gameplay legible: the pipeline stages, current power/heat/access, ally status are all overlay-visible (BV-SKILL-015).

## ANTI-PATTERNS
- Freeform construction / voxel building systems (doctrine §31).
- Facility #3 as a palette-swap of #1 (distinctness invariant).
- The ally with "follow me everywhere, auto-fights, buffs nearby" behaviors (doctrine §26, BV-D020).
- "ALLY NEAR = +10% damage" stat auras.
- Restoration as a quest-giver chain of generic fetch errands (scope/meaning violation; doctrine §31).
- The base as a de-facto hub-screen that breaks the world-as-interface principle (doctrine §5).

## KNOWN FAILURE MODES
- Pipeline stage skips (claimed before secured) → gate enforcement + reason logging.
- Ally always-available firepower (scope/fiction drift) → base-role budget + independent investigation absences.
- Facilities desynced with sector activation (a "restored" base not present when sector activates) → facility_state is save-state data consumed by the sector, single-sourced.
- Outpost creep toward "six more bases" → roster is FIXED at five; additions require a directive.
- Reality-reference becoming free intrusion into horror → budgeted, authored, ally-absent during silence stretches (BV-SKILL-018).

## VERIFICATION
- Static: five-facility roster; pipeline stages canonical and gated; ally roles base-anchored; no aura pattern; no builder subsystem; facility_state single-sourced and save-consistent.
- Behavioral (when authorized): fixture runs DISCOVER→…→IMPROVE with gated progression and logged reasons; ally performs a base-role job without teleporting/following; reality-reference fires only on authored anomaly events; outpost tier behaves lighter than home tier.

## STOP CONDITIONS
If facilities exceed five, building becomes freeform, or the ally becomes a companion that fights by the player's side — stop and re-anchor to doctrine §31/§26.

## PERFORMANCE
- Facility states are data + gated events; ally roles are sparse jobs/absences; zero per-frame friendlies following the player. Budgeted under SOP-004.

## DEVICE
- Tablet: facility HUD (power/heat/access), ally dispatch viability touch UI, and isolation-per-horror tuning validated on device.

## RELATED SKILLS
- BV-SKILL-012 diegetic-memory-progression (capability recovery anchors)
- BV-SKILL-017 survival-wilderness-systems (shelter/healing/heating)
- BV-SKILL-013 large-world-sector-architecture (facility-as-sector-government)
- BV-SKILL-018 psychological-horror-perceptual-events (reality reference budget)
- BV-SKILL-006 environmental-affordances (facility surfaces/tags)
- BV-SKILL-029 simse-island-systems (D015 infrastructure consequence law + world-state propagation the RESTORE pipeline feeds)
- BV-SKILL-031 persistent-character-state-architecture (D017 base-as-identity-anchor design — this skill retains the RESTORE pipeline + ally role; base reflects RECOVERY, not strategy)
- BV-SKILL-034 companion-relationship-architecture (D023 base relationships + Second-in-Command bond architecture; this skill retains facility RESTORE + ally gameplay role per doctrine §26; composition)
- SOP-006 debug-observability; developers-way (governing)