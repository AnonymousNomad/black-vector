---
name: diegetic-memory-progression
description: Diegetic memory progression — EXPERIENCE→TRIGGER→MEMORY→RECOGNITION→CAPABILITY RESTORED. No XP trees. Disciplines are recovered capability families. Memory is ALSO peril (amnesia, fragmentation, conditioning, psionic-cost events). The photograph is the roster anchor. Load when implementing or reasoning about progression, memory, or unlocks.
---

# DIEGETIC MEMORY PROGRESSION (BV-SKILL-012)

## NAME
DIEGETIC MEMORY PROGRESSION

## PURPOSE
Implement progression as memory, not levels (doctrine §3): EXPERIENCE → TRIGGER → MEMORY → RECOGNITION → CAPABILITY RESTORED. Generic XP trees, skill points, and stat progression are FORBIDDEN. Every unlock is diegetically caused. Memory is ALSO a threat surface: amnesia, fragmentation, conditioning disruption, and psionic-cost events are gameplay and narrative, never only flavor. The Hidden Hand photograph is the diegetic roster/memory anchor that keeps the history legible (doctrine §28).

## WHEN TO LOAD
- Implementing/tuning progression, memories, triggers, unlocks, amnesia, or capability restoration.
- Reasoning about what the player can do (and what the Hand remembers) at any point in the world.

## DO NOT LOAD WHEN
- Weapon internals (BV-SKILL-011) or combat balance — they consume capabilities, they don't govern progression.
- Psionic cost mechanics (BV-SKILL-019 owns neural-load pipeline; this skill consumes its memory/perception events).

## PRECONDITIONS
- Governing set loaded.
- Capability registry exists (which capabilities are "restored") and aligns with the starting lock (sidearm + knife + photograph; rifles/carbines and disciplines are memory-restored — doctrine §4, §32).
- Disciplines model (8 recovered capability families) exists or is being designed with this skill (doctrine §32).
- Save-state model decided (local-first, offline).

## GOVERNING INVARIANTS
1. THE SEQUENCE IS UNCHANGEABLE: EXPERIENCE → TRIGGER → MEMORY → RECOGNITION → CAPABILITY RESTORED. No skipping (no "kill 3 enemies → unlock"), no XP, no currency, no skill trees (doctrine §3).
2. TRIGGERS ARE WORLD FACTS with a source: a place, an object, a weapon, a combat situation, a person, an injury, a sound, a landmark, or recovered information. Each unlock traces to a specific trigger, and the memory ledger records WHICH source. The Hand's OWN memory is a source with damaged reliability (Pillar 1): a memory row may be marked ADMITTEDLY-FRAGMENTED where the fiction calls for it — but the LEDGER is truthful about what the player has encountered; only the MEMORY CONTENT is fragmentable.
3. Recognition is diegetic: restoring a capability is accompanied by memory text/dialogue/visual (or the photograph, doctrine §28), not a "+1 pistol skill" toast.
4. CAPABILITY UNIT = DISCIPLINE FAMILY (doctrine §32): FIELDCRAFT, RECON, INFILTRATION, CLOSE QUARTERS, MARKSMAN, ASSAULT, TECH, PSIONICS. Capabilities are organized as recovered family knowledge (e.g., MARKSMAN restores rifle familiarity), NOT as eight siloed skill trees.
5. MEMORY IS PERIL: amnesia/fragmentation are legitimate game states (missing time, unreliable recollection, conditioning gaps). They are authored as designed ambiguity, and observability rules (SOP-006 / BV-SKILL-015) apply — a "memory failure" must be distinguishable from a save/ledger bug by its logged reason+source.
6. PSIONIC COST EVENTS (doctrine §22) can trigger memory/perception events but do NOT auto-unlock capabilities, and are NOT triggered on every psionic use — they are the heavy-use consequence path, and they never skip the CAPABILITY RESTORED gate.
7. The photograph (doctrine §28) is the diegetic roster/memory interface: annotating/repairing it maps to memory recovery (not ordinary inventory management; it cannot be dropped/sold).
8. Capability restoration is additive and observable: the registry (capability → unlocked|locked + discipline) is a truthful, single-sourced state; the HUD/memory UI derive from it. No capability exists outside the registry.
9. Offline and local: progression/memory state is stored locally (file/scene state), no cloud, no accounts (BV-D003).
10. Prologue truth: capabilities shown at OPERATIONAL PEAK in the prologue (doctrine §29) are, at wilderness start, LOST — the wilderness state enumerates lower caps; recognition raises them back toward (never beyond) prologue peak until later canon says otherwise.

## WORKFLOW
1. Read current progression code in current form; confirm no XP/skill-point pattern exists.
2. Align capability registry with the eight disciplines and the starting lock; declare the prologue-peak baseline capability set.
3. Define trigger interceptor: world events (reach, interact, take, witness, injury, sound, landmark, photograph-annotation) evaluate the registry's trigger conditions with source recorded.
4. Implement memory ledger: (experience→trigger→memory→recognition→capability) rows with source, timestamp, resolve order; rows may carry a FRAGMENTED flag (designed amnesia) with the reason logged.
5. Wire capability application: on recognition, activate registered capability/feature (weapon family, traversal, interaction, discipline knowledge) — actual gameplay effects — surfaced diegetically (photograph/dialogue/memory).
6. Consume psionic-cost memory/perception events (BV-SKILL-019) WITHOUT shortcutting the gate.
7. Verify statically; behaviorally+device when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Separate data (trigger/memory/capability definitions in Resources) from machine (ledger/recognition evaluator) — new memories = new data, no logic change.
- Detection of trigger use: world coordinates/actions post events; recognition eval runs sparse (on trigger event, not per-frame).
- Save the ledger; restore capability state from ledger on load (idempotent resolution).
- Keep memory content authored as text/art (diegetic), min UI chrome; the weapon/discipline memory (e.g., "I know this rifle family") is a capability gate with memory, not a stat.
- Photograph wiring: photograph state (worn/folded/water-damaged/blood-stained/repaired/annotated) mirrors ledger awareness; repairs/annotations are diegetic UI, not menu screens (doctrine §28).
- Amnesia authoring: each FRAGMENTED row must state in data what the player still believes vs. what is true (world truth is separate from belief — same discipline as BV-SKILL-008 beliefs).

## ANTI-PATTERNS
- `player.get("xp") += n` anywhere (doctrine §3).
- Skill tree / perk panel UI; eight parallel "trees" (doctrine §32).
- Achievements-as-progression substitute.
- Capability unlocked with no trigger source (unexplained power creep).
- Auto-granting capabilities "because the player finished level X" or "because a heavy psionic use happened" (invariant 6).
- Amnesia used as a smoke-screen for missing content (a memory "failure" with no authored content behind it).
- Photograph treated as inventory to drop/sell (doctrine §28).

## KNOWN FAILURE MODES
- Trigger fires but memory ledger misses source → progression untraceable/unexplained; fix ledger integrity, never grant silently.
- Save/load diverges (restored capability not persisted) → activation must be derived from ledger each load.
- Capability registry deviates from starting lock → guard the lock separation.
- Amnesia indistinguishable from a bug → FRAGMENTED rows must log reason+source; the overlay (BV-SKILL-015) shows whether a gap is authored or a ledger fault.
- Psionic-cost events over-trigger memory sequences → doctrine §22: not on every use; heavy-use only.

## VERIFICATION
- Static: no XP tree patterns (grep); sequence enforced; every capability has ≥1 trigger with source; registry single source; disciplines map cleanly; FRAGMENTED rows declare authored content; rediscoverable from save.
- Behavioral (when authorized): scripted path touches each trigger class → ledger rows resolve → capabilities applied; restart-from-save asserts same final capability set; psionic heavy-use event fires memory event but does NOT auto-unlock.

## STOP CONDITIONS
If any progression step bypasses the five-stage sequence or lacks a source trigger, stop — the model has broken the pillar. If a memory "failure" has no authored content and no logged reason, stop — it is a smuggling loophole, not amnesia.

## PERFORMANCE
- Trigger eval is event-sampled, sparse, negligible; ledger is small-file local writes.

## DEVICE
- Memory UI legibility on tablet (diegetic briefing panel + photograph sheet), all offline.

## RELATED SKILLS
- BV-SKILL-011 weapon-handling-ballistics (ranged families restored later)
- BV-SKILL-019 psionic-gameplay-neural-load (cost-event consumption)
- BV-SKILL-015 gameplay-debugging-instrumentation (amnesia vs bug observability)
- BV-SKILL-006 environmental-affordances (world triggers: places/landmarks)
- BV-SKILL-020 facility-and-ally-support (ally "reality reference", memory reconstruction)
- BV-SKILL-028 prologue-narrative-architecture (D014 opening memory beats: photograph thread, prison fragments, catastrophic-facility flash)
- BV-SKILL-031 persistent-character-state-architecture (D017 reclamation stages + visual evolution channel — this skill retains memory gates EXPERIENCE→TRIGGER→MEMORY→RECOGNITION→CAPABILITY RESTORED)
- BV-SKILL-034 companion-relationship-architecture (D023 — memory bleed integration with relationships; this skill retains memory progression gates; composition)
- BV-SKILL-035 operator-discipline-architecture (D025 — recovered memory is a progression source; this skill retains memory progression gates; composition)
- BV-SKILL-035 operator-discipline-architecture (D025 — recovered memory is a progression source; this skill retains memory progression gates; composition)
- SOP-006 debug-observability; developers-way (governing)