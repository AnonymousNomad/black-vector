---
name: enemy-architecture
description: Reusable design procedure for AI / faction / enemy architecture systems — per-faction profile design (goals / resources / leadership / tactics / equipment / morale / weaknesses), AI perception state machine design (UNAWARE → SUSPICIOUS → SEARCHING → TRACKING → ENGAGED → LOSING CONTACT → RETREATING), squad behavior design (communication / radio dependency / command structure / panic when leaders die / fallback behavior / mistakes), per-role archetype design (frightened survivor / desperate scavenger / disciplined security operator / tracker / sniper / medic / engineer / commander), Black Hand / Shade distinction design (information / coordination / sensory integration / discipline — NOT armor / damage), boss philosophy design (unique people / unique situations / history / preparation / consequences — no giant health bars / no bullet sponges / no arena fights), wildlife / human / threat ecology interaction design (hazard triggers / warning signals / avoidance signals / human-activity impact), slice enemy package design (INCLUDED / EXCLUDED). Pure methodology: NO per-character or per-campaign canon lives here (canon lives in the bible + doctrine). Load when designing any enemy / faction / squad / perception / archetype / boss / wildlife-interaction system.
---

# ENEMY ARCHITECTURE (BV-SKILL-033)

## NAME
ENEMY ARCHITECTURE

## PURPOSE
Own the REUSABLE design procedure for AI / faction / enemy architecture systems. This is METHODOLOGY,
not canon — it tells future directives how to design a per-faction profile, an AI perception state
machine, a squad behavior pattern, a per-role archetype, a Black Hand / Shade distinction, a boss
philosophy, a wildlife / human / threat ecology interaction, or a slice enemy package. It does not
state who the specific enemies are in a specific campaign; those statements live in the per-character
/ per-campaign bible (e.g. `docs/design/AI_FACTION_ENEMY_ARCHITECTURE_BIBLE.md`) and in doctrine (BV-D###
rows). This separation keeps the skill fleet from collapsing into duplicated lore.

## WHEN TO LOAD
- Designing or extending any per-faction profile (goals / resources / leadership / tactics / equipment
  / morale / weaknesses).
- Designing or extending any AI perception state machine (UNAWARE → SUSPICIOUS → SEARCHING → TRACKING →
  ENGAGED → LOSING CONTACT → RETREATING or equivalent).
- Designing or extending any squad behavior system (communication / radio dependency / command structure
  / panic / fallback / mistakes).
- Designing or extending any human enemy archetype (frightened survivor / desperate scavenger /
  disciplined security operator / tracker / sniper / medic / engineer / commander — actual people not
  enemy classes).
- Designing or extending any Black Hand / Shade distinction or boss philosophy.
- Designing or extending any wildlife / human / threat ecology interaction.
- Designing a slice enemy package (INCLUDED / EXCLUDED).
- Reconciling an authored encounter against the AI perception state machine or against the prevention-
  matrix-like "no enemy knows player location" rule.

## DO NOT LOAD WHEN
- Implementing AI bounded sensing internals (BV-SKILL-008 owns tactical-ai-perception; this skill composes
  with 008).
- Implementing combat architecture (BV-SKILL-021 owns CQC; this skill composes with 021's AI-facing
  interfaces).
- Implementing population taxonomy (BV-SKILL-027 owns island-population-threat-ecology; this skill composes
  with 027's D011 §3-§32 catalog).
- Implementing world-systems substrate (BV-SKILL-029 owns simse-island-systems; this skill composes with
  029's world-state propagation).
- Implementing per-character enemy canon, per-campaign faction content, or per-encounter scene authoring —
  those live in the per-character bible and in scene-authoring directives.

## PRECONDITIONS
- Governing set loaded.
- Existing doctrine read: §23 (three threat classes), §26 (ally role), §27 (former Hidden Hand), §34
  (narrative pillars), §35-§39 (combat / Control / Strain / Reclamation — BV-D033..D040), §35.7 (AI-
  facing combat interfaces), §41 (visual / equipment doctrine).
- D008/D009 CQC doctrine read.
- D011 ecology read (§3 progression tier; §4 military operative roles; §5 Black Hand security; §6
  Shades; §7 truthful sensing; §8 commander externalization; §10 doctors / scientists; §11-§13 prisoners /
  subjects / cybernetic; §14 former Hidden Hand; §15-§17 civilians / community / contractors; §18 wildlife;
  §22 human-first ability rule; §23 regional distribution; §24 relationship model; §26 weapon ecology;
  §27 D007 perception compatibility; §28 D008/D009 combat compatibility; §29 Pillar 3 RESPONSIBILITY; §30
  content / horror budget; §31 boss doctrine; §32 future-team boundary).
- D013 weapon bible read.
- D015 survival/horror substrate read (§15 wildlife-as-environmental-information; §18 wildlife; §28 off-
  screen coarse model; §33 horror rarity; §34 True Unknowns; §40 wildlife-as-environmental-information).
- D016 anomaly bible read (§48 prevention matrix).
- D017 persistent-state + reclamation read (§11 LIVING SAVE FILE).
- D018 campaign spine read (§11 / §37 threat escalation; §14 encounter functions; §15 second-in-command
  arc; §27 former Hidden Hand; §36 end-of-Season woman).
- D019 visual production read.
- D020 vertical-slice specification read (BV-D123).
- D021 combat architecture read (BV-D124) — D022 DEEPENS D021 §7 AI doctrine.
- Existing skills read: 008 (tactical-ai-perception), 009 (contextual-assassination), 021 (cqc-combat-
  architecture), 027 (island-population-threat-ecology), 028 (prologue), 029 (simse-island-systems), 031
  (persistent-character-state-architecture), 032 (visual-presentation-architecture), 015 (observability).
- Existing per-character bible (the canonical Season-1 example is
  `docs/design/AI_FACTION_ENEMY_ARCHITECTURE_BIBLE.md`) read so methodology does not duplicate per-canon
  limits.

## GOVERNING INVARIANTS
1. METHODOLOGY ONLY: this skill defines HOW to design an enemy / faction / squad / perception / archetype
   / boss / wildlife-interaction system; it does not state who the specific enemies are in a specific
   campaign. Per-character / per-campaign canon lives in the per-character bible and in doctrine. A
   future directive that wants to amend a campaign's enemies does not edit this skill.
2. FACTIONS ARE TAXONOMIES, NOT ENEMY CLASSES: each faction has a frozen profile shape (goals · resources ·
   leadership · tactics · equipment · morale · weaknesses). The seven canonical factions (Black Hand
   Remnants · Island Survivors · Security/Recovery Teams · Researchers · Contractors · Escaped Subjects ·
   Criminal Networks [optional]) are AUTHORED; per-character canon uses them as the design palette.
3. HUMAN-FIRST ABILITY RULE: Tier 0-3 threats are HUMANS with bounded abilities; Tier 4 is rare and
   authored (D011 §22 / D015 §33). NO enemy is a health-sponge; NO enemy is a generic combat class.
4. NO OMNISCIENCE: AI uses the D011 §7 truthful sensing pipeline. AI NEVER has omniscient player location.
   Every belief carries a source (BV-SKILL-008 knowledge-with-source). AI NEVER auto-pivots to "psychic-
   detector mode."
5. AI PERCEPTION STATE MACHINE: UNAWARE → SUSPICIOUS → SEARCHING → TRACKING → ENGAGED → LOSING CONTACT →
   RETREATING (or equivalent). AI NEVER transitions directly to ENGAGED without the legitimate chain.
   Every transition has a documented trigger.
6. SQUAD BEHAVIOR IS BOUNDED: squads coordinate via radio / hand signals / network; command structure
   matters; radio dependency is a real vector; panic when leaders die is a real state; fallback behavior
   follows D011 §7; mistakes are legitimate (not dice rolls).
7. ENEMY PSYCHOLOGY IS BEHAVIORAL: fear · surrender · retreat · negotiation · betrayal · desperation ·
   loyalty are behavioral states with routes in/out. The most memorable encounters should sometimes end
   without killing.
8. ARCHETYPES ARE ACTUAL PEOPLE: frightened survivor / desperate scavenger / disciplined security operator
   / tracker / sniper / medic / engineer / commander — each is a PERSON with WHO / WHY HERE / AWARENESS /
   TACTICS / COMMUNICATION / MORALE / WEAKNESS, not a stat block.
9. BLACK HAND / SHADE DISTINCTION: a Shade is a human (D011 §6 — all Shades are human; doctrine §41.4
   Shade baseline) with optimized information + coordination + sensory integration + discipline. NOT
   armor. NOT damage. NOT bullet-spongy. NOT superhuman (D016 §48 prevention matrix). BROKEN /
   DESYNCHRONIZED Shades (D011 §6) are the most human — network failure restored some individuality
   at the cost of stability.
10. BOSS PHILOSOPHY: bosses are UNIQUE PEOPLE in UNIQUE SITUATIONS with HISTORY, PREPARATION, and
    CONSEQUENCES. NO giant health bars; NO bullet sponges; NO arena fights. Boss doctrine (D011 §31)
    frozen checklist applies: identity · provenance · motive · tactical rule · visual identity · narrative
    significance · environment · tell · counterplay · consequence.
11. WILDLIFE / HUMAN / THREAT ECOLOGY: wildlife is NOT a routine combat enemy. Wildlife is an
    environmental sensor (D015 §40 wildlife-as-environmental-information) — warning signals, avoidance
    signals, hazard triggers, and human-activity impact. Wildlife has credible regional behavior (D004 §7).
12. SLICE ENEMY PACKAGE: a vertical slice ships with a bounded enemy package (INCLUDED list); everything
    else is EXCLUDED until a later slice / future-fleet directive.
13. NO FUTURE-SAGA CONTAMINATION: designing for the current saga must not import future-saga material
    into the current canon. Defer with CANDIDATE flags; do not promote.
14. NO COSMETIC CASH-SHOP LOGIC: not applicable here, but rarity colors / loot spreadsheets are forbidden
    for enemies (D011 §26 weapon ecology + D017 §42).
15. OBSERVABILITY: every AI state transition must declare its reason (BV-SKILL-015 invariant 2). WORLD
    vs PERCEIVED separation preserved (BV-SKILL-018 invariant 4). Replayable fixture reproduces AI
    behavior with the same seed.
16. COMPOSITION DISCIPLINE: this skill composes with BV-SKILL-008 (tactical-ai-perception), 021 (cqc-combat-
    architecture), 027 (island-population-threat-ecology), 028 (prologue-narrative-architecture), 029
    (simse-island-systems), 031 (persistent-character-state-architecture), 032 (visual-presentation-
    architecture), 015 (observability). It does not duplicate any of them; it does not replace any of
    them.

## WORKFLOW
1. Read the per-character / per-campaign bible to confirm the enemy / faction / squad / perception /
   archetype / boss / wildlife-interaction layer's canonical scope; confirm no design will duplicate
   canon.
2. Define or extend PER-FACTION PROFILES (goals · resources · leadership · tactics · equipment · morale
   · weaknesses) for each faction in the campaign.
3. Define or extend the AI PERCEPTION STATE MACHINE (UNAWARE → SUSPICIOUS → SEARCHING → TRACKING →
   ENGAGED → LOSING CONTACT → RETREATING or equivalent) with documented transition conditions.
4. Define or extend SQUAD BEHAVIOR (communication / radio dependency / command structure / panic when
   leaders die / fallback behavior / mistakes / squad-level examples).
5. Define or extend PER-ROLE ARCHETYPES (frightened survivor / desperate scavenger / disciplined security
   operator / tracker / sniper / medic / engineer / commander) — each as ACTUAL PEOPLE with WHO / WHY
   HERE / AWARENESS / TACTICS / COMMUNICATION / MORALE / WEAKNESS profiles.
6. Define or extend the BLACK HAND / SHADE DISTINCTION: information · coordination · sensory integration
   · discipline (NOT armor / damage). Confirm BROKEN / DESYNCHRONIZED Shades as the most human.
   Companion Shade preserved.
7. Define or extend BOSS PHILOSOPHY: unique people · unique situations · history · preparation ·
   consequences. Confirm NO giant health bars / NO bullet sponges / NO arena fights. Apply D011 §31
   frozen checklist.
8. Define or extend WILDLIFE / HUMAN / THREAT ECOLOGY INTERACTION: hazard triggers · warning signals ·
   avoidance signals · human-activity impact. Wildlife is NOT a routine combat enemy.
9. Define or extend the SLICE ENEMY PACKAGE: INCLUDED list · EXCLUDED list · integration with vertical-
   slice spec.
10. Validate against: NO OMNISCIENCE; HUMAN-FIRST ABILITY RULE; BOSS PHILOSOPHY; WILDLIFE BOUNDED;
    SLICE PACKAGE BOUNDED; NO FUTURE-SAGA CONTAMINATION; OBSERVABILITY.

## IMPLEMENTATION GUIDANCE
- For PER-FACTION PROFILES: every faction answers the seven profile questions; no exceptions.
- For AI PERCEPTION STATE MACHINE: every transition has a documented trigger; the AI NEVER skips states;
  every belief carries a source.
- For SQUAD BEHAVIOR: radio dependency is a real vector the player can exploit; command loss matters;
  panic thresholds are tier-dependent.
- For PER-ROLE ARCHETYPES: the archetype is a PERSON with a story, not a stat block; the player can read
  the archetype's behavior through observation.
- For BLACK HAND / SHADE DISTINCTION: a Shade is information + coordination + sensory integration +
  discipline; a BROKEN Shade is the most human because the network's gone.
- For BOSS PHILOSOPHY: every boss has the D011 §31 frozen checklist + the unique-people-unique-situations-
  history-preparation-consequences frame.
- For WILDLIFE / HUMAN / THREAT ECOLOGY: wildlife is a sensor (D015 §40); credible regional behavior
  (D004 §7); NO mutant-shooter; NO combat-fodder.
- For SLICE ENEMY PACKAGE: INCLUDED is small; EXCLUDED is everything else until a later slice / future-
  fleet directive authorizes it.

## ANTI-PATTERNS
- Re-stating per-character / per-campaign canon inside this skill (creates duplicated lore).
- Faction taxonomy drifting to "enemy classes" (the seven factions are AUTHORED palettes; the archetypes
  are PEOPLE).
- AI gaining omniscient player location (forbidden; no shortcut).
- Tier 4 becoming routine combat mob (D015 §33 / §34 scarcity preserved).
- Squad behavior becoming deterministic-perfect (mistakes are legitimate, not dice rolls).
- Shade becoming "stronger soldier" (the distinction is information / coordination / sensory integration
  / discipline, NOT armor / damage).
- Boss becoming giant health bar / bullet sponge / arena fight.
- Wildlife becoming mutant-shooter faction or combat fodder.
- Slice enemy package becoming army.
- Per-character content in the skill (the lore-duplication anti-pattern).
- Future-saga material imported into Season-1 canon (the contamination anti-pattern).

## KNOWN FAILURE MODES
- Faction taxonomy drift: re-anchor to the seven canonical factions; new factions require a directive.
- AI omniscience drift: pair every AI state transition with a SOURCE (BV-SKILL-008 knowledge-with-source).
- Tier 4 normalization: re-anchor to D015 §33 / §34 scarcity; budget per slice.
- Squad perfectionism: enforce mistakes + fallback behavior; Tier-dependent intelligence.
- Shade creep toward "stronger soldier": re-anchor to information / coordination / sensory integration /
  discipline distinction.
- Boss simplification toward HP-sponge: re-anchor to D011 §31 + unique-people-unique-situations-history-
  preparation-consequences frame.
- Wildlife creep toward combat enemy: re-anchor to D004 §7 + D015 §40 + credible regional behavior.
- Slice enemy package creep: re-anchor to INCLUDED / EXCLUDED lists.

## VERIFICATION
- Static: every faction profile answers the seven questions; AI perception state machine has documented
  transition conditions for every state change; squad behavior has radio dependency / command structure /
  panic / fallback / mistakes profiles; per-role archetypes are PEOPLE not stat blocks; Black Hand / Shade
  distinction preserves information / coordination / sensory integration / discipline; boss philosophy
  preserves unique-people-unique-situations-history-preparation-consequences; wildlife interaction preserves
  credible regional behavior + environmental sensor role; slice enemy package has INCLUDED + EXCLUDED
  lists; no per-character canon in the skill.
- Cross-skill: no parallel AI sensing, combat, population, world-system, or observability systems invented;
  existing owners consumed.
- Tooling: run `tools/validate_methodology.py` and `tests/static_verify_game.py` after any canon change.
  Per-character bible's contradiction ledger should remain at zero contradictions.

## STOP CONDITIONS
If a designed enemy / faction / squad / perception / archetype / boss / wildlife-interaction system gains
omniscience, becomes an enemy class instead of a person, makes a Shade into a stronger soldier, makes a
boss into a health-sponge, makes wildlife into a combat mob, makes a slice into an army, imports future-
saga material, or duplicates per-character canon inside this skill — stop and re-anchor to this skill's
invariants and the per-character bible.

## RELATED SKILLS
- BV-SKILL-008 tactical-ai-perception (bounded AI sensing; knowledge-with-source; last-known-position —
  this skill composes for AI sensing internals but does not duplicate)
- BV-SKILL-009 contextual-assassination (combat vs assassination separation — this skill composes)
- BV-SKILL-021 cqc-combat-architecture (CONTACT / SPATIAL / Control × Strain / AI-facing combat interfaces
  — this skill composes)
- BV-SKILL-027 island-population-threat-ecology (population taxonomy; faction roles — this skill
  composes for population taxonomy but does not duplicate)
- BV-SKILL-028 prologue-narrative-architecture (opening gates — this skill composes)
- BV-SKILL-029 simse-island-systems (world-systems substrate — this skill composes)
- BV-SKILL-031 persistent-character-state-architecture (state channels — this skill composes for state
  persistence but does not duplicate)
- BV-SKILL-032 visual-presentation-architecture (visual production — this skill composes for visual
  presentation but does not duplicate)
- BV-SKILL-015 gameplay-debugging-instrumentation (observability surfaces; SOP-006)
- D022 canonical bible = `docs/design/AI_FACTION_ENEMY_ARCHITECTURE_BIBLE.md` (per-character canon this
  skill does not duplicate)
- D021 combat architecture = `docs/design/COMBAT_ARCHITECTURE_BIBLE.md` (BV-D124; D022 DEEPENS D021 §7 AI
  doctrine)
- developers-way, black-vector-project-doctrine (governing); SOP-005/006
- BV-SKILL-034 companion-relationship-architecture (D023 — Companion Shade control chain + visual identity + relationship progression compose with enemy architecture methodology; the Shade is a separate victim of the same machine per BV-D127 canon correction; this skill retains enemy architecture ownership)