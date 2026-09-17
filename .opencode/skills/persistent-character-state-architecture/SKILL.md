---
name: persistent-character-state-architecture
description: Reusable design procedure for persistent character-state and reclamation progression systems — reclamation-stage framework, persistent visual state channels, persistence law, visible-state→consequence→response design, grooming system methodology, quick-radial design, base-grooming facilities, clothing/armor/weapon progression shapes, animation-evolution ladder, body-presence methodology, tablet-feasible persistent-state architecture, save-data shape, accessibility overrides, observability requirements. Pure methodology: NO per-character or per-campaign canon lives here (canon lives in the bible + doctrine). Load when designing any persistent character-state system, reclamation arc, persistent visual-state architecture, or player-authored presentation layer.
---

# PERSISTENT CHARACTER-STATE ARCHITECTURE (BV-SKILL-031)

## NAME
PERSISTENT CHARACTER-STATE ARCHITECTURE

## PURPOSE
Own the REUSABLE design procedure for persistent character-state and reclamation progression. This is
METHODOLOGY, not canon — it tells future directives how to design a reclamation arc, a persistent visual-state
architecture, a grooming system, a base-grooming facility shape, a quick-radial, a clothing/armor/weapon
progression shape, an animation-evolution ladder, body-presence, save-data shape, accessibility overrides, and
observability surfaces. It does not state what a specific character looks like or wears at a specific point
in a specific campaign; those statements live in the per-character bible (e.g.
`docs/design/PLAYER_RECLAMATION_PERSISTENT_CHARACTER_STATE_BIBLE.md` for The Hand / Season 1) and in doctrine
(BV-D### rows). This separation keeps the skill fleet from collapsing into duplicated lore.

## WHEN TO LOAD
- Designing or extending any reclamation arc or persistent character-state system.
- Authoring a new state channel, a new progression category, or a new visual-state→consequence→response design.
- Designing a quick-radial, base-grooming facility, or hair/beard/grooming system.
- Reconciling an authored visual state against tablet-feasible performance architecture.
- Designing save-data shape, observability surfaces, or accessibility overrides for character state.
- Reasoning about animation-evolution ladder or body-presence methodology.

## DO NOT LOAD WHEN
- Implementing equipment visual language (BV-SKILL-022 owns armor/weapons/gear silhouette; this skill composes
  with it for state channels but does not duplicate).
- Implementing memory progression gates (BV-SKILL-012 owns EXPERIENCE → TRIGGER → MEMORY → RECOGNITION →
  CAPABILITY RESTORED).
- Implementing restorable-facility RESTORE pipeline (BV-SKILL-020).
- Authoring anomalous capability canon or its design procedure (BV-SKILL-030 methodology; per-character bible).
- Designing world-systems substrate (BV-SKILL-029).
- Per-character capability canon, per-campaign reclamation pacing, or per-stage content — those live in the
  per-character bible and in doctrine.

## PRECONDITIONS
- Governing set loaded.
- Existing doctrine read: §3 (memory not XP), §4 (starting character lock), §14 (The Hand), §29 (opening),
  §32 (disciplines), §35-§38 (combat/reclamation), §37.2-§37.3 (Compound/Independent), §41 (visual/equipment).
- Existing skills read: 022 (equipment visual), 012 (memory progression), 020 (facility/ally), 028 (prologue),
  029 (world-systems), 030 (anomaly methodology), 015 (observability), 018 (horror authoring).
- Existing per-character bible (the canonical Season-1 example is `docs/design/PLAYER_RECLAMATION_PERSISTENT_CHARACTER_STATE_BIBLE.md`)
  read so methodology does not duplicate per-canon limits.

## GOVERNING INVARIANTS
1. METHODOLOGY ONLY: this skill defines HOW to design a persistent-state system; it does not state what a
   specific character wears, looks like, or has done at any specific point. Per-character/per-campaign canon
   lives in the per-character bible and in doctrine. A future directive that wants to amend a character's
   state does not edit this skill.
2. LIVING SAVE FILE LAW: the character model is a living save file. State changes persist until an actual
   system changes them. No arbitrary reset-to-clean across scene boundaries, save/load, or chapter
   transitions. The visible-state architecture is the system; persistence is its foundation.
3. RECLAMATION NOT RESTORATION: progression is RECLAMATION — the recovery, recombination, and rewriting of a
   character — never a reset to a prior state. A reclamation-stage gain that mirrors a prior stage 1:1 is
   a violation. The character becomes a THIRD thing, not the original.
4. MULTIPLE CHANNELS, EACH WITH ITS OWN CADENCE: physical recovery, procedural memory, player practice,
   equipment access, environmental mastery, Control/self-mastery, anomalous discovery, relationships,
   Compound/Independent, and visual evolution each progress at their own rate. No single channel is the
   funnel for all progress.
5. NO XP-FOR-EVERYTHING: generic kill-XP → buy-unrelated-skill chains are FORBIDDEN. Use combinations of USE,
   PRACTICE, RECOVERY, STORY GATES, TRAINING, DISCOVERY, EQUIPMENT FAMILIARITY, ENVIRONMENTAL MASTERY,
   SELF-MASTERY. A lightweight in-fiction currency MAY exist only when justified for in-world purchases.
6. THREE CAPABILITY ORIGINS: RECOVERED (pre-imprisonment), LEARNED (prison/island/survival/relationships/anomaly),
   INTEGRATED (only possible because old + new combine). Tag every reclamation gain with one or more of
   these origins at design time. The player does not see the tag; the design uses it to keep reclamation
   honest.
7. STATE CHANNELS ARE BOUNDED: BODY, HAIR/FACE, CLOTHING, ARMOR, WEAPONS, ENVIRONMENTAL RESIDUE — each channel
   has a closed list of state items. New state items go in via directive, not via freeform authoring.
8. PERSISTENCE LAW: visible state persists. No arbitrary reset. Repair remains visible; hair continues from
   prior state; armor damage remains until repaired/replaced; wet clothing dries by world-system action,
   not by scene transition.
9. VISIBLE-STATE → CONSEQUENCE → RESPONSE: a visible physical state may have a small believable consequence
   and a natural response. Consequences are SMALL, BELIEVABLE, RESPONSIVE, REMOVABLE through normal play.
   Not every visible condition needs a gameplay penalty; some are expressive.
10. ANTI-TEDIUM: persistent realism must never become maintenance spam. High-frequency grooming/maintenance
    ticks are FORBIDDEN. Recovery happens at substrate cadence, not UI cadence. Grooming actions that do
    not produce meaningful change are cut.
11. TABLET-FEASIBLE ARCHITECTURE: finite-state hair meshes (not strand simulation), bounded decals for residue,
    material parameters for wetness/dirt, animation layers for the BROKEN → REMEMBERING → RECOVERING →
    INTEGRATED ladder, state-driven clothing swaps, modular accessories. Reject continuous strand simulation,
    unlimited persistent decals, combinatorial full-character mesh explosion.
12. NO COSMETIC CASH-SHOP LOGIC: appearance items exist because they belong in the world. No rarity colors,
    no cosmetic loot showers, no disconnected costumes, no immersion-breaking skins.
13. CHARACTER IDENTITY PROTECTION: the character is authored. Player customization shapes PRESENTATION and
    EVOLUTION, not face identity, tattoos, core body identity, established scars, or narrative history.
14. NO FUTURE-SAGA CONTAMINATION: designing for the current saga must not import future-saga material into
    the current canon. Defer with CANDIDATE flags; do not promote.
15. ACCESSIBILITY OVERRIDES REQUIRED: hair obstruction · heavy visual injury effects · excessive tremor ·
    camera interference · grime/blood overlays all have EXPRESSION toggles. The underlying state still
    exists; what is suppressed is its visual/auditory expression when a player requires it. Removing the
    visual cue never grants a gameplay advantage.
16. OBSERVABILITY: every state channel and every reclamation-stage gain must declare the debug surfaces it
    will need (current state, last change reason, persistence, accessibility toggle state, performance
    budget consumption) so SOP-006 / BV-SKILL-015 contracts are honored at implementation time.
17. COMPOSITION DISCIPLINE: this skill composes with BV-SKILL-022 (equipment visual), 012 (memory gates),
    020 (facility pipeline), 028 (prologue gates), 029 (world-systems), 030 (anomaly methodology), 018 (horror
    authoring), 015 (observability). It does not duplicate any of them; it does not replace any of them.

## WORKFLOW
1. Read the per-character / per-campaign bible to confirm the persistent-state layer's canonical scope;
   confirm no design will duplicate canon.
2. Define RECLAMATION STAGES: enumerate the arc (Season-1 example: LEGEND → BROKEN SURVIVOR → RELEARNING →
   RECOVERING OPERATOR → INTEGRATED HAND). Each stage is a narrative-playable state, not a number. Confirm
   the final state is NOT a reset to the reference state.
3. Define PROGRESSION CHANNELS and their cadences; confirm multi-channel composition and no-XP discipline.
4. Define STATE CHANNELS (BODY / HAIR-FACE / CLOTHING / ARMOR / WEAPONS / ENVIRONMENTAL RESIDUE) and the bounded
   state items per channel; confirm no duplication with existing owners (022/012/020/029).
5. Define PERSISTENCE LAW: every visible state persists until an actual system changes it. Confirm scene
   boundaries, save/load, and chapter transitions do NOT reset visible state.
6. Define VISIBLE-STATE → CONSEQUENCE → RESPONSE pairs. Confirm every consequence is small, believable,
   responsive, removable. Confirm responses are diegetic (animations, brush-aside, shelter, base interaction),
   not stat-menu chores.
7. Define GROOMING SYSTEM (hair / beard / facial hair / nails / presentation accessories), including finite
   states, hair-tie ecology, and base-grooming facilities (mirror / wash / locker / workbench / medical).
8. Define QUICK PRESENTATION RADIAL: bounded slot count (Season-1 example: 6), controller + touch + KBM,
   contextual, persistence-respecting.
9. Define CLOTHING / ARMOR / WEAPON PROGRESSION SHAPES (broad visual phases; not per-piece content). Confirm
   repairs remain visible, provenance ecology (D013) preserved, no rarity-color loot.
10. Define SIGNATURE EQUIPMENT RETURN design moment: diegetic signals (animation / inspection / handling /
    memory / posture), not system popups.
11. Define ANIMATION EVOLUTION LADDER (BROKEN → REMEMBERING → RECOVERING → INTEGRATED) and the ranked effects
    the ladder drives (posture, weapon handling, recovery transitions, idle behavior, etc.).
12. Define BODY PRESENCE in FP/TP views and the third-person-readable signals at tablet viewing distance.
13. Define BASE AS IDENTITY ANCHOR (doctrine §31; D015 §24 RESTORE pipeline) — base reflects RECOVERY, not
    strategy. Confirm facility types and the base's place in the reclamation arc.
14. Define COMPOUND / INDEPENDENT RECLAMATION design (D016 §30 / §31 / doctrine §37.2 / §37.3): seductive
    draw of Compound; slower rougher Independent; neither objectively superior.
14a. Define PLAYER-AUTHORED VISUAL IDENTITY: how two players' characters may diverge meaningfully while
    preserving the authored core identity (grooming / clothing / repairs / armor / headgear / weapon history /
    path visual consequences).
15. Define TABLET PERFORMANCE ARCHITECTURE: material parameters / masks / bounded decals / modular accessory
    meshes / finite hair meshes / finite beard states / state-driven swaps / animation layers. Reject
    strand sim / unlimited decals / combinatorial mesh explosion.
16. Define SAVE-DATA SHAPE (channels per character) and OBSERVABILITY surfaces (state, last change reason,
    persistence, accessibility toggle state).
17. Define ACCESSIBILITY OVERRIDES for hair obstruction · heavy visual injury effects · excessive tremor ·
    camera interference · grime/blood overlays (and any other EXPRESSION-toggles the system requires).
18. Validate against TABLET FEASIBILITY, NO-XP discipline, NO COSMETIC CASH-SHOP LOGIC, NO FUTURE-SAGA
    CONTAMINATION, and the per-character bible's contradiction ledger.

## IMPLEMENTATION GUIDANCE
- Use FINITE STATE for hair and beard: discrete meshes per state, swapped via animation tree or state
  machine. Do NOT simulate strands.
- Use DECALS for residue (mud/blood/snow) with a small palette (boots / knees / gloves / outer armor /
  shoulders). Selective accumulation (boots first; shoulders last) communicates the player's movement and
  exposure without burden.
- Use MATERIAL PARAMETERS for wetness (a wet-darkening scalar driven by D015 shared truth) and dirt (an
  accumulation scalar).
- Use ANIMATION LAYERS for the BROKEN → REMEMBERING → RECOVERING → INTEGRATED ladder — a small number of
  additive layers, not a complete re-rig.
- Use DAMAGE DECALS + REPAIR DECALS stacked for repair visibility; do not mesh-swap unless the item changes.
- A REPAIR / PATCH is visible until the player deliberately replaces or further repairs the item.
- A WOUND persists through treatment / healing / scarred states (a small bounded state machine per body
  region); only AUTHORED significance creates a permanent scar (D017 §46).
- A GROOMING action is CHARACTERIZATION (D017 §20) plus mechanical effect. The base facility surface
  mediates both.

## ANTI-PATTERNS
- Re-stating per-character / per-campaign canon inside this skill (creates duplicated lore).
- "Reset to clean" on scene boundary, save/load, or chapter transition.
- A single channel that funnels all progression (the reclamation-funnel anti-pattern).
- Generic kill-XP → buy-unrelated-skill (the kill-XP anti-pattern).
- High-frequency grooming/maintenance ticks (the chore-spam anti-pattern).
- Strand-by-strand hair simulation or combinatorial full-character mesh explosion (the tablet-implausibility
  anti-pattern).
- Cosmetic rarity colors, loot showers, disconnected costumes, immersion-breaking skins (the cash-shop
  anti-pattern).
- Player customization that erases face identity, tattoos, core body identity, established scars, or
  narrative history (the character-erasure anti-pattern).
- Per-character content in the skill (the lore-duplication anti-pattern).
- Future-saga material imported into Season-1 canon (the contamination anti-pattern).

## KNOWN FAILURE MODES
- Visible state drifts toward maintenance: pair every channel with a SUBSTRATE that drives it without UI
  cadence.
- Reclamation-stage drift toward stat-grind: tie every gain to a RECOVERED/LEARNED/INTEGRATED origin and
  verify it is not "restore the old Hand."
- Tablet performance blow-up from persistent state: enforce the §11 / §15 architecture (finite meshes,
  bounded decals, layered animations).
- Channel scope creep: add new channels only via directive, never casually.
- Accessibility override gap: every visible-side-effect needs an EXPRESSION toggle; if a player can be
  disadvantaged, the override exists.
- Lore duplication: per-character state details appearing in the skill instead of the bible — strip and
  reference.

## VERIFICATION
- Static: every reclamation-stage gain tagged RECOVERED/LEARNED/INTEGRATED; state channels bounded; persistence
  law enforced; visible-state→consequence→response pairs satisfy SMALL/BELIEVABLE/RESPONSIVE/REMOVABLE;
  grooming system finite; quick-radial bounded slot count; clothing/armor/weapon progression broad-phase
  only; animation-evolution ladder declared; tablet performance architecture per §11/§15; save-data shape
  declared; accessibility overrides declared for all five EXPRESSION toggles; observability surfaces
  declared; no per-character canon in the skill.
- Cross-skill: no parallel visual-language, memory-gate, facility, world-system, anomaly, or observability
  systems invented; existing owners consumed.
- Tooling: run `tools/validate_methodology.py` and `tests/static_verify_game.py` after any canon change. Per-
  character bible's contradiction ledger should remain at zero contradictions.

## STOP CONDITIONS
If a designed persistent-state system resets state arbitrarily, funnels all progression through one channel,
resorts to kill-XP, becomes tablet-implausible, erases authored character identity, imports future-saga
material, or duplicates per-character canon inside this skill — stop and re-anchor to this skill's
invariants and the per-character bible.

## RELATED SKILLS
- BV-SKILL-022 visual-equipment-doctrine (equipment visual language; this skill composes for state channels
  but does not duplicate)
- BV-SKILL-012 diegetic-memory-progression (memory gates; methodology owns the stage framework; skill owns the
  trigger pattern)
- BV-SKILL-020 facility-and-ally-support (RESTORE pipeline + ally role; methodology owns the base-as-identity
  anchor; skill owns the facility pipeline)
- BV-SKILL-028 prologue-narrative-architecture (STAGE 0 reference; knowledge gates preserved)
- BV-SKILL-029 simse-island-systems (world-systems substrate; environmental coupling for state channels)
- BV-SKILL-030 anomalous-capability-architecture (D016 methodology; composition partner, not duplicate)
- BV-SKILL-018 psychological-horror-perceptual-events (horror authoring contract)
- BV-SKILL-015 gameplay-debugging-instrumentation (observability surfaces; SOP-006)
- BV-SKILL-032 visual-presentation-architecture (D019 visual production methodology — this skill retains state channels + animation-evolution; camera/helmet/HUD compose without duplicating)
- BV-SKILL-034 companion-relationship-architecture (D023 Companion visual evolution + Hand's guilt visual language + base relationships observing visible state compose with persistent-state methodology; this skill retains state channels + animation-evolution ladder)
- BV-SKILL-035 operator-discipline-architecture (D025 — physical character evolution body channel + visual transitions BROKEN PRISONER → SURVIVOR → RECOVERED OPERATOR → UNIQUE PLAYER EXPRESSION compose with persistent-state; this skill retains state channels + animation-evolution ladder)
- D017 canonical bible = `docs/design/PLAYER_RECLAMATION_PERSISTENT_CHARACTER_STATE_BIBLE.md`
- developers-way, black-vector-project-doctrine (governing); SOP-005/006