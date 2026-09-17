---
name: companion-relationship-architecture
description: Reusable design procedure for companion / relationship / Shade reclamation architecture systems — Companion Shade architecture (control chain + visual identity + relationship progression + companion rules + psychological tone references), community relationship system (survivor trust progression + relationship-index + community reactions), Second-in-Command bond architecture (bond progression + bond character + bond gameplay role + bond relationship to the Shade), Hand's guilt architecture (guilt channel + effect on relationships + visual language), moral-consequences architecture (saved-people outcomes + kill outcomes + mercy consequences), memory bleed integration with relationships (trigger anchors + content relationships + frequency relationships), base relationships architecture (people at base + base relationships change + visible-state observation), Companion personality evolution (response shape + emotional shape + tactical shape). Pure methodology: NO per-character or per-campaign canon lives here (canon lives in the bible + doctrine). Load when designing any companion / relationship / reclamation / community-bond / memory-bleed-integration / base-relationship system.
---

# COMPANION RELATIONSHIP ARCHITECTURE (BV-SKILL-034)

## NAME
COMPANION RELATIONSHIP ARCHITECTURE

## PURPOSE
Own the REUSABLE design procedure for companion / relationship / Shade reclamation architecture
systems. This is METHODOLOGY, not canon — it tells future directives how to design a Companion Shade
architecture, a community relationship system, a Second-in-Command bond, a guilt architecture, a
moral-consequences architecture, a memory-bleed integration, base relationships, and a Companion
personality evolution. It does not state who the specific companions / communities / Second-in-Command
are in a specific campaign; those statements live in the per-character / per-campaign bible (e.g.
`docs/design/COMPANION_RELATIONSHIP_SHADE_RECLAMATION_BIBLE.md`) and in doctrine (BV-D### rows). This
separation keeps the skill fleet from collapsing into duplicated lore.

## WHEN TO LOAD
- Designing or extending any Companion Shade architecture (control chain + visual identity + relationship
  progression + companion rules + psychological tone).
- Designing or extending any community relationship system (survivor trust progression + relationship-
  index + community reactions).
- Designing or extending any Second-in-Command bond architecture (bond progression + bond character +
  bond gameplay role + bond relationship to the Shade).
- Designing or extending any Hand's guilt architecture (guilt channel + effect on relationships + visual
  language).
- Designing or extending any moral-consequences architecture (saved-people outcomes + kill outcomes +
  mercy consequences).
- Designing or extending any memory bleed integration with relationships (trigger anchors + content
  relationships + frequency relationships).
- Designing or extending any base relationships architecture (people at base + base relationships change +
  visible-state observation).
- Designing or extending any Companion personality evolution (response shape + emotional shape +
  tactical shape).

## DO NOT LOAD WHEN
- Implementing memory progression gates (BV-SKILL-012 owns the memory sequence).
- Implementing facility / ally base role (BV-SKILL-020 owns facility RESTORE + ally gameplay role).
- Implementing combat architecture (BV-SKILL-021 owns CQC + AI-facing interfaces).
- Implementing population taxonomy / community archetypes (BV-SKILL-027 owns island-population-threat-
  ecology).
- Implementing AI perception (BV-SKILL-008 owns tactical-ai-perception).
- Implementing enemy architecture (BV-SKILL-033 owns enemy architecture).
- Implementing persistent character state (BV-SKILL-031 owns state channels + animation-evolution).
- Per-character relationship canon, per-campaign community content, per-encounter scene authoring — those
  live in the per-character bible and in scene-authoring directives.

## PRECONDITIONS
- Governing set loaded.
- Existing doctrine read: §14-§18 (The Hand's collapse / conviction), §25 (Primary Ally scene lock), §26
  (Ally Gameplay Role), §27 (Other Hidden Hand Members), §34 (Narrative Pillars — IDENTITY /
  BROTHERHOOD / RESPONSIBILITY), §41.5 (Shade Armor Tiers), §41.15 (Companion Shade Visual Evolution).
- D011 §6 / §8 / §9 read (Shade families, Commander externalization, Companion Shade arc).
- D014 §17 (family catastrophe) + D015 §22 (community systemic state) + D015 §31 (Memory Bleed
  taxonomy) + D016 §49 (Season-1 mastery ceiling) + D017 §3 (5-stage reclamation) + D018 §13 (Shade
  commander + Companion thread) + D018 §15 (second-in-command arc) + D022 §2-§6 (factions, psychology,
  perception, squad, archetypes) + D022 §7.4-§7.5 (Shade distinction — SUPERSEDED by D023 canon
  correction packet; see D023 §2) read.
- Existing skills read: 008, 012, 019, 020, 021, 027, 028, 031, 032, 033, 015.
- Existing per-character bible (the canonical Season-1 example is
  `docs/design/COMPANION_RELATIONSHIP_SHADE_RECLAMATION_BIBLE.md`) read so methodology does not
  duplicate per-canon limits.

## GOVERNING INVARIANTS
1. METHODOLOGY ONLY: this skill defines HOW to design a companion / relationship / reclamation system;
   it does not state who the specific companions / communities / Second-in-Command are in a specific
   campaign. Per-character / per-campaign canon lives in the per-character bible and in doctrine. A
   future directive that wants to amend a campaign's companions does not edit this skill.
2. SHADE RECLAMATION CANON (the user's correction packet — SUPERSEDES D022 §7.4-§7.5 narrow framing):
   the Shade is NOT a former Hidden Hand / someone who knows The Hand / a failed version of The Hand /
   a person who understands The Hand's abilities / a special anomaly. The Shade IS a separate victim
   of the same machine. The Hand was created ACCIDENTALLY (program altered him; brain adapted; he
   escaped). The Shade was created INTENTIONALLY (program wanted a weapon). The Shade is what happens
   when the system succeeds.
3. CONTROL CHAIN LAW: the Shade has a control chain — OPERATOR → CONTROL GAUNTLET → ENCRYPTED NEURAL
   COMMAND → IMPLANT BEHIND EAR/SKULL INTERFACE → SHADE NERVOUS SYSTEM OVERRIDE. The Shade is NOT a
   robot. The person is still inside. The override failure modes are: gauntlet damage, operator death,
   implant damage, command conflict, override degradation.
4. SHADE VISUAL IDENTITY LAW: Metal Gear cyborg ninja silhouette + stealth operator + military assassin
   + controlled human weapon. AVOID: superhero armor, glowing fantasy armor, robotic appearance. The
   horror is "the armor is advanced, but the person inside is still human." Armor becomes LESS advanced
   as the Shade becomes more human (thematic statement).
5. RELATIONSHIP PROGRESSION LAW: Companion Shade progresses through 5 stages — "Awaiting command" →
   "Why did you spare me?" → "I don't understand choice" → "I am not your weapon" → "I choose."
   Iterative; not linear; patient. Second-in-Command bond progresses through 6 stages — UNRESOLVED →
   HOSTILE → RECOGNITION → RECIPROCITY → RECONCILIATION → BROTHERHOOD.
6. COMPANION RULE LAW: the Companion is NOT a summon / NOT a mindless AI helper / NOT a weapon upgrade.
   The Companion IS a damaged person learning humanity. The Companion's combat capability is
   PRESERVED because removing it would remove part of his identity. The Companion is BASE-ANCHORED
   (doctrine §26 / BV-SKILL-020). The Companion makes CHOICES that may contradict the player's.
7. COMMUNITY TRUST PROGRESSION LAW: survivor trust progresses through stages — UNKNOWN → STRANGER →
   GUEST → NEIGHBOR → KINDRED. The progression is AUTHORED; the progression is REVERSIBLE; the
   community REMEMBERS. The relationship-index is observable (D015 §22 community state).
8. GUILT CHANNEL LAW: the Hand carries guilt (D014 §17 family catastrophe + D012 §10-§11 Compound
   history). The guilt drives mercy, restraint, avoidance, communication. The guilt is the constraint
   that makes the Hand different from a weapon. The guilt has a visual language (D017 §36 animation-
   evolution ladder).
9. MORAL CONSEQUENCES LAW: saved people have outcomes; saved ≠ token; mercy is a moral choice; kill is
   a moral choice. Pillar 3 RESPONSIBILITY (doctrine §34 / D011 §29) is the constraint.
10. MEMORY BLEED INTEGRATION LAW: bleed trigger anchors are PLACE / OBJECT / PERSON / SOUND / CONDITION.
    Bleed content is shaped by the player's relationship with the trigger. Bleed frequency is shaped by
    reclamation stage + Control + Neural Strain + relationships. Bleed is a CHARACTER MOMENT, not a
    horror event. Bleed carries Pillar 1 IDENTITY.
11. BASE RELATIONSHIPS LAW: the base is NOT a hub. The base is a PLACE with PEOPLE — player, ally,
    Companion Shade, survivors, named NPCs. Base relationships change as the player's reclamation,
    restoration, community trust, Companion, and ally relationships evolve. The base is a LIVING
    PLACE. Base relationships observe visible state (D017 §22).
12. COMPANION PERSONALITY EVOLUTION LAW: Companion responds AUTHORED. Companion emotional shape is
    INVERSE of program's suppression (damaged, not perfect). Companion tactical shape is preserved
    (D011 §6 / doctrine §41.5). Companion's capability is the Companion's CHOICE.
13. PSYCHOLOGICAL TONE LAW: Man on Fire + Shutter Island + Metal Gear Solid 3 + Metal Gear Solid 4. AVOID
    simple revenge / superhero transformation / chosen-one mythology.
14. NO FUTURE-SAGA CONTAMINATION: designing for the current saga must not import future-saga material
    into the current canon. Defer with CANDIDATE flags; do not promote.
15. NO ROMANCE: bond is BROTHERHOOD (Pillar 2; doctrine §34). Bond is NOT romance. Bond is NOT
    servitude.
16. NO COSMETIC CASH-SHOP LOGIC: not applicable here, but rarity colors / loot spreadsheets are forbidden
    (D017 §42).
17. OBSERVABILITY: every relationship transition must declare its reason (BV-SKILL-015 invariant 2).
    WORLD vs PERCEIVED separation preserved (BV-SKILL-018 invariant 4). Replayable fixture reproduces
    relationship behavior with the same seed.
18. COMPOSITION DISCIPLINE: this skill composes with BV-SKILL-008 (tactical-ai-perception), 012
    (diegetic-memory-progression), 019 (psionic cost pipeline), 020 (facility-ally-support), 021 (cqc-
    combat-architecture), 027 (island-population-threat-ecology), 028 (prologue-narrative-architecture),
    029 (simse-island-systems), 031 (persistent-character-state-architecture), 032 (visual-presentation-
    architecture), 033 (enemy-architecture), 015 (observability). It does not duplicate any of them; it
    does not replace any of them.

## WORKFLOW
1. Read the per-character / per-campaign bible to confirm the companion / relationship / reclamation
   layer's canonical scope; confirm no design will duplicate canon.
2. If designing the Shade specifically, APPLY THE CANON CORRECTION (invariant 2) — the Shade is a
   SEPARATE VICTIM of the same machine, NOT a failed version of The Hand.
3. Define or extend the COMPANION SHADE ARCHITECTURE: control chain (invariant 3); visual identity
   (invariant 4); relationship progression (invariant 5); companion rules (invariant 6); psychological
   tone (invariant 13).
4. Define or extend the COMMUNITY RELATIONSHIP SYSTEM: survivor trust progression (invariant 7);
   relationship-index; community reactions; visible-state observation.
5. Define or extend the SECOND-IN-COMMAND BOND ARCHITECTURE: bond progression (invariant 5); bond
   character; bond gameplay role; bond relationship to the Shade.
6. Define or extend the HAND'S GUILT ARCHITECTURE: guilt channel (invariant 8); guilt's effect on
   relationships; guilt's visual language.
7. Define or extend the MORAL CONSEQUENCES ARCHITECTURE: saved-people outcomes (invariant 9); kill
   outcomes; mercy consequences.
8. Define or extend the MEMORY BLEED INTEGRATION: trigger anchors (invariant 10); content relationships;
   frequency relationships; bleed as character moment.
9. Define or extend the BASE RELATIONSHIPS ARCHITECTURE: people at base (invariant 11); base relationships
   change; visible-state observation.
10. Define or extend the COMPANION PERSONALITY EVOLUTION: response shape (invariant 12); emotional shape;
    tactical shape.
11. Validate against: SHADE CANON CORRECTION; NO ROMANCE; NO FUTURE-SAGA CONTAMINATION; OBSERVABILITY.

## IMPLEMENTATION GUIDANCE
- For COMPANION SHADE: design the control chain first (operator → gauntlet → command → implant → override);
  design the person's interior life next (sensory / emotional / memory / preference — preserved beneath
  the override); design the visual identity (T0/T1/T2/T3 armor tiers; armor becomes LESS advanced as the
  Shade becomes more human); design the relationship progression (5 stages; iterative); design the
  companion rules (NOT summon / NOT helper / NOT weapon upgrade).
- For COMMUNITY: design the survivor trust progression stages (5); design the relationship-index per
  cluster; design the visible-state observation (cleanliness + persistent-state + LIVING SAVE FILE);
  design the community reactions (information, resources, defense, gossip-as-sensor).
- For SECOND-IN-COMMAND: design the bond progression (6 stages); design the bond character (BROTHERHOOD,
  not romance / not servitude); design the bond's gameplay role (base-anchored ally; reality reference);
  design the bond's relationship to the Shade (OLD mirror vs NEW mirror).
- For GUILT: design the guilt channel; design the guilt's effect on choices (mercy / restraint /
  avoidance / communication); design the guilt's visual language (D017 §36 animation-evolution ladder).
- For MORAL CONSEQUENCES: design saved-people outcomes (alive + wounded + grateful + vengeful + broken +
  healing — AUTHORED); design kill outcomes (body + weapon + community reaction + guilt); design mercy
  consequences.
- For MEMORY BLEED INTEGRATION: design bleed trigger anchors (place / object / person / sound / condition);
  design bleed content relationships (saved vs killed shapes content); design bleed frequency relationships
  (reclamation + Control + Strain + relationships); design bleed as CHARACTER MOMENT.
- For BASE RELATIONSHIPS: design the people at base (player / ally / Companion Shade / survivors / named
  NPCs); design base relationships change (as reclamation / restoration / trust / Companion / ally
  evolve); design base relationships as visible-state observers.
- For COMPANION PERSONALITY: design the response shape (AUTHORED); design the emotional shape (INVERSE of
  program's suppression — damaged, not perfect); design the tactical shape (preserved from D011 §6 /
  doctrine §41.5; Companion's CHOICE).

## ANTI-PATTERNS
- Re-stating per-character / per-campaign canon inside this skill (creates duplicated lore).
- Shade becomes a former Hidden Hand / failed version of The Hand / anomaly (CANON CORRECTION
  violation).
- Shade becomes superhero armor / glowing fantasy / robotic (visual identity violation).
- Companion becomes a summon / mindless AI helper / weapon upgrade (companion rule violation).
- Bond becomes romance or servitude (BROTHERHOOD violation).
- Community relationship becomes quest tree / token system (community trust progression violation).
- Memory bleed becomes random horror (bleed frequency + content relationships violation).
- Guilt becomes stat / meter (guilt channel violation).
- Kill / mercy / save becomes consequence-free (moral consequences violation).
- Tone drifts to revenge / superhero transformation / chosen-one mythology (psychological tone violation).
- Per-character content in the skill (the lore-duplication anti-pattern).
- Future-saga material imported into Season-1 canon (the contamination anti-pattern).

## KNOWN FAILURE MODES
- Shade canon drift: re-anchor to CANON CORRECTION (invariant 2).
- Shade visual drift: re-anchor to invariant 4.
- Companion utility drift: re-anchor to invariant 6 (NOT a tool).
- Bond romance drift: re-anchor to BROTHERHOOD (invariant 5 + 15).
- Community quest-tree drift: re-anchor to community trust progression (invariant 7).
- Bleed chaos: re-anchor to bleed trigger anchors + frequency relationships (invariant 10).
- Guilt stat: re-anchor to invariant 8 (guilt is a channel, not a number).
- Consequence-free choices: re-anchor to invariant 9.
- Tone cliché: re-anchor to invariant 13 (Man on Fire / Shutter Island / MGS3 / MGS4).

## VERIFICATION
- Static: Companion Shade architecture answers control chain + visual identity + relationship progression +
  companion rules + psychological tone; community relationship system answers survivor trust progression +
  relationship-index + community reactions + visible-state observation; Second-in-Command bond answers
  bond progression + bond character + bond gameplay role + bond relationship to the Shade; Hand's guilt
  architecture answers guilt channel + effect on relationships + visual language; moral consequences
  architecture answers saved-people outcomes + kill outcomes + mercy consequences; memory bleed integration
  answers trigger anchors + content relationships + frequency relationships; base relationships answer
  people at base + base relationships change + visible-state observation; Companion personality evolution
  answers response shape + emotional shape + tactical shape; no per-character canon in the skill.
- Cross-skill: no parallel memory progression, ally role, combat, population, AI perception, enemy
  architecture, persistent state, or observability systems invented; existing owners consumed.
- Tooling: run `tools/validate_methodology.py` and `tests/static_verify_game.py` after any canon change.
  Per-character bible's contradiction ledger should remain at zero contradictions (excluding the narrow
  intentional supersession of D022 §7.4-§7.5 per the user's canon correction packet).

## STOP CONDITIONS
If a designed companion / relationship / reclamation system has the Shade become a former Hidden Hand /
a failed version of The Hand / an anomaly; has the Shade visual become superhero armor / glowing
fantasy / robotic; has the Companion become a summon / mindless AI helper / weapon upgrade; has the bond
become romance or servitude; has the community relationship become a quest tree / token system; has the
memory bleed become random horror; has the guilt become a stat / meter; has the kill / mercy / save
become consequence-free; has the tone drift to revenge / superhero transformation / chosen-one
mythology; has future-saga material been imported; or has per-character canon been duplicated inside
this skill — stop and re-anchor to this skill's invariants and the per-character bible.

## RELATED SKILLS
- BV-SKILL-008 tactical-ai-perception (bounded AI sensing — this skill composes)
- BV-SKILL-012 diegetic-memory-progression (memory sequence + memory bleed — this skill composes for
  bleed integration)
- BV-SKILL-019 psionic cost pipeline (anomaly cost — this skill composes)
- BV-SKILL-020 facility-ally-support (facility RESTORE + ally gameplay role — this skill composes)
- BV-SKILL-021 cqc-combat-architecture (CQC + AI-facing interfaces — this skill composes)
- BV-SKILL-027 island-population-threat-ecology (population taxonomy + community archetypes — this skill
  composes)
- BV-SKILL-028 prologue-narrative-architecture (opening gates — this skill composes)
- BV-SKILL-029 simse-island-systems (world-systems substrate — this skill composes)
- BV-SKILL-031 persistent-character-state-architecture (state channels + animation-evolution — this skill
  composes)
- BV-SKILL-032 visual-presentation-architecture (visual production — this skill composes)
- BV-SKILL-033 enemy-architecture (enemy / faction architecture — this skill composes for Shade control
  chain)
- BV-SKILL-015 gameplay-debugging-instrumentation (observability surfaces; SOP-006)
- BV-SKILL-035 operator-discipline-architecture (D025 — companion / relationship progression composes; this skill retains companion / relationship / Shade reclamation; composition)
- D023 canonical bible = `docs/design/COMPANION_RELATIONSHIP_SHADE_RECLAMATION_BIBLE.md` (per-character canon
  this skill does not duplicate)
- D022 enemy architecture = `docs/design/AI_FACTION_ENEMY_ARCHITECTURE_BIBLE.md` (BV-D125; D023 §2
  intentionally supersedes D022 §7.4-§7.5 narrow Shade framing)
- D021 combat architecture = `docs/design/COMBAT_ARCHITECTURE_BIBLE.md` (BV-D124)
- developers-way, black-vector-project-doctrine (governing); SOP-005/006