---
name: operator-discipline-architecture
description: Reusable design procedure for operator identity / military discipline / combat expression architecture systems — operator identity philosophy (the seven advantages; the foundation; "the Hand wins fights BEFORE they begin"), military discipline architecture (the six competencies — Overwatch Reconnaissance · Scout Sniper · Forward Observer · Covert Operations · Close Quarters Combat · Direct Action Recovery — NOT RPG classes, with four levels UNTRAINED / DEVELOPING / PROFICIENT / MASTERED), player expression model (three example expressions — the patient hunter, the closer-range operator, the anomaly-integrated operator — variation through use not class selection), no-XP progression model (use / experience / training / mentorship / recovered memory / equipment familiarity / surviving situations / relationships), combat technique architecture (behaviors not abilities; the technique examples; techniques compose; techniques integrate with foundation + anomaly), weapon relationship system (familiarity / maintenance / history / modification / emotional attachment / field adaptation — weapons tell stories and persist in the living save file), anomaly integration with competencies (recon + anomaly / sniper + anomaly / CQC + anomaly / FO + anomaly / covert + anomaly / direct action + anomaly; bounded by D016 §48 + §49; does NOT create new skills), physical character evolution (the body channel; visual transitions BROKEN PRISONER → SURVIVOR → RECOVERED OPERATOR → UNIQUE PLAYER EXPRESSION aligned with D017 §3 5-stage ladder), touchscreen action priority list (informs D026). Pure methodology: NO per-character or per-campaign canon lives here (canon lives in the bible + doctrine). Load when designing any operator identity / military discipline / combat expression / player expression / no-XP progression / combat technique / weapon relationship / anomaly-integration-with-competencies / physical-character-evolution system.
---

# OPERATOR DISCIPLINE ARCHITECTURE (BV-SKILL-035)

## NAME
OPERATOR DISCIPLINE ARCHITECTURE

## PURPOSE
Own the REUSABLE design procedure for operator identity / military discipline / combat expression
architecture systems. This is METHODOLOGY, not canon — it tells future directives how to design an
operator identity philosophy, a military discipline architecture, a player expression model, a no-XP
progression model, a combat technique architecture, a weapon relationship system, anomaly integration
with competencies, physical character evolution, and a touchscreen action priority list. It does not
state who the operator IS in a specific campaign; those statements live in the per-character /
per-campaign bible (e.g. `docs/design/OPERATOR_IDENTITY_COMBAT_DISCIPLINE_BIBLE.md`) and in doctrine
(BV-D### rows). This separation keeps the skill fleet from collapsing into duplicated lore.

## WHEN TO LOAD
- Designing or extending any operator identity philosophy (the seven advantages; the foundation).
- Designing or extending any military discipline architecture (the six competencies; the four levels).
- Designing or extending any player expression model (variation through use not class selection).
- Designing or extending any no-XP progression model.
- Designing or extending any combat technique architecture (behaviors not abilities).
- Designing or extending any weapon relationship system (familiarity / maintenance / history /
  modification / emotional attachment / field adaptation).
- Designing or extending any anomaly integration with competencies.
- Designing or extending any physical character evolution (the body channel; the visual transitions).
- Designing or extending any touchscreen action priority list (informs D026).

## DO NOT LOAD WHEN
- Implementing CQC architecture (BV-SKILL-021 owns CQC + Control × Strain + AI-facing interfaces).
- Implementing anomaly methodology (BV-SKILL-030 owns anomaly capability design).
- Implementing persistent state (BV-SKILL-031 owns state channels + animation-evolution).
- Implementing visual presentation (BV-SKILL-032 owns camera / HUD / animation / signature moments).
- Implementing enemy architecture (BV-SKILL-033 owns enemy architecture).
- Implementing companion / relationship (BV-SKILL-034 owns companion / relationship / Shade reclamation).
- Implementing memory progression gates (BV-SKILL-012 owns the memory sequence).
- Implementing touchscreen / mobile control layout (the D026 territory — D025 informs it via the
  action priority list).
- Per-character operator canon, per-campaign competency progression arcs, per-encounter scene
  authoring — those live in the per-character bible and in scene-authoring directives.

## PRECONDITIONS
- Governing set loaded.
- Existing doctrine read: §3 (memory not XP), §14-§18 (The Hand's collapse / conviction), §21
  (Psionics), §22 (Psionic Cost), §29 (Opening Structure), §32 (Disciplines), §34 (Narrative Pillars),
  §35-§39 (Combat / Control / Strain / Reclamation — BV-D033..D040), §41 (Visual & Equipment Doctrine).
- D008/D009 + D011 §3 / §4 / §22 read.
- D012 §10-§12 (Compound lineage + pre-collapse) read.
- D013 weapon bible read.
- D014 prologue read (STAGE 0 LEGEND).
- D015 substrate read.
- D016 anomaly read (BV-D087..D095; prevention matrix; Season-1 ceiling).
- D017 persistent state + reclamation read (BV-D096..D104; 5-stage arc; persistent channels; LIVING
  SAVE FILE; player-authored visual identity).
- D018 campaign spine read.
- D019 visual production read.
- D020 vertical-slice specification read.
- D021 combat architecture read.
- D022 AI / faction / enemy architecture read.
- D023 companion / relationship / Shade reclamation read.
- Existing skills read: 008 (tactical-ai-perception), 012 (diegetic-memory-progression), 016 (vertical-
  slice-discipline), 019 (psionic cost pipeline), 021 (cqc-combat-architecture), 027 (island-population-
  threat-ecology), 028 (prologue-narrative-architecture), 030 (anomalous-capability-architecture), 031
  (persistent-character-state-architecture), 032 (visual-presentation-architecture), 033 (enemy-architecture),
  034 (companion-relationship-architecture), 015 (observability).
- Existing per-character bible (the canonical Season-1 example is
  `docs/design/OPERATOR_IDENTITY_COMBAT_DISCIPLINE_BIBLE.md`) read so methodology does not duplicate
  per-canon limits.

## GOVERNING INVARIANTS
1. METHODOLOGY ONLY: this skill defines HOW to design an operator identity / military discipline /
   combat expression system; it does not state who the operator IS in a specific campaign. Per-character
   / per-campaign canon lives in the per-character bible and in doctrine. A future directive that wants
   to amend a campaign's operator does not edit this skill.
2. NOT A CLASS SYSTEM: the operator does NOT select a class. The operator RECONSTRUCTS, DEVELOPS, and
   EXPRESSES an identity through USE. Competencies are military disciplines, not RPG classes. There are
   NO skill points, NO levels, NO arbitrary unlocks, NO damage percentages, NO experience bars.
3. SEVEN ADVANTAGES (information advantage · patience · preparation · observation · precision ·
   battlefield understanding · controlled violence) are the FOUNDATION that distinguishes the operator
   from a normal soldier. They are TRAINED BEHAVIORS, not talents.
4. MILITARY LINEAGE LAW: the operator's foundation = Scout Sniper · Reconnaissance · Forward
   Observation · Intelligence Collection · Precision Engagement · Stealth Operations (D011 §4 SNIPER /
   RECONNAISSANCE / SURVEILLANCE / COMMAND / ASSAULT roles).
5. SIX COMPETENCIES (Overwatch Reconnaissance · Scout Sniper · Forward Observer · Covert Operations ·
   Close Quarters Combat · Direct Action Recovery) are layered ON TOP of the foundation. The foundation
   is ALWAYS PRESENT. The competencies EXTEND the foundation.
6. FOUR LEVELS (UNTRAINED / DEVELOPING / PROFICIENT / MASTERED) are READ through behavior, not through
   numbers. The levels are observable through animation, audio, narrative, visible state changes.
7. PLAYER EXPRESSION MODEL: variation emerges from USE not class selection. Two players become
   different versions of The Hand through DIFFERENT expression paths (the patient hunter, the closer-
   range operator, the anomaly-integrated operator). Expression is bounded by foundation + competencies +
   progression rules + canon constraints.
8. NO-XP PROGRESSION: progression comes from use + experience + training + mentorship + recovered
   memory + equipment familiarity + surviving situations + relationships. FORBIDDEN: skill points,
   arbitrary unlocks, damage percentages, level numbers, experience bars.
9. TECHNIQUES NOT ABILITIES: combat techniques are BEHAVIORS that emerge through use. Techniques do
   NOT have levels / ranks / skill points. Techniques COMPOSE. Techniques integrate with foundation +
   anomaly.
10. WEAPON RELATIONSHIP LAW: weapons are PERSONAL OBJECTS with HISTORY. Weapons have familiarity /
    maintenance / history / modification / emotional attachment / field adaptation. Weapons tell
    stories. Weapons PERSIST (D017 §11 LIVING SAVE FILE). Weapons lost = PART OF SELF lost.
11. ANOMALY INTEGRATION LAW: the anomaly MODIFIES operator skill across the six competencies. The
    anomaly does NOT create new skills. The anomaly does NOT create superheroes. The anomaly is BOUNDED
    by D016 §48 prevention matrix and D016 §49 Season-1 mastery ceiling. The anomaly has cost (Strain +
    Control + EXERTION).
12. PHYSICAL CHARACTER EVOLUTION LAW: the body channel tracks prison physique · scars · tattoos ·
    injuries · posture · movement · fatigue · clothing · armor · grooming. Visual transitions align
    with D017 §3 5-stage reclamation ladder. Body is player-authored expression (D017 §41).
13. PRESERVED CANON: the operator's opening timeline (final Hidden Hand mission → return home →
    Compound loss → collapse → prison → death row → island transfer → experimentation → awakening);
    anomaly NOT present before island; anomaly develops after Compound absence + experimentation; body
    identity prison-built · stocky · hardened · functional strength · scarred · tattooed · NOT bodybuilder
    physique; no loading-screen / lobby fiction; humans dominant; horror / anomaly restrained and costly.
14. NO FUTURE-SAGA CONTAMINATION: designing for the current saga must not import future-saga material
    into the current canon. Defer with CANDIDATE flags; do not promote.
15. NO COSMETIC CASH-SHOP LOGIC: not applicable here, but rarity colors / loot spreadsheets are forbidden
    (D017 §42).
16. OBSERVABILITY: every competency level transition must declare its reason (BV-SKILL-015 invariant 2).
    WORLD vs PERCEIVED separation preserved (BV-SKILL-018 invariant 4). Replayable fixture reproduces
    progression with the same seed.
17. COMPOSITION DISCIPLINE: this skill composes with BV-SKILL-008 (tactical-ai-perception), 012 (diegetic-
    memory-progression), 016 (vertical-slice-discipline), 019 (psionic cost pipeline), 021 (cqc-combat-
    architecture), 027 (island-population-threat-ecology), 028 (prologue-narrative-architecture), 030
    (anomalous-capability-architecture), 031 (persistent-character-state-architecture), 032 (visual-
    presentation-architecture), 033 (enemy-architecture), 034 (companion-relationship-architecture), 015
    (observability). It does not duplicate any of them; it does not replace any of them.

## WORKFLOW
1. Read the per-character / per-campaign bible to confirm the operator identity / military discipline /
   combat expression layer's canonical scope; confirm no design will duplicate canon.
2. Apply PRESERVED CANON (invariant 13): operator's opening timeline; anomaly NOT before island;
   anomaly develops after Compound absence + experimentation; body identity preserved.
3. Define the OPERATOR IDENTITY PHILOSOPHY: the seven advantages (information advantage · patience ·
   preparation · observation · precision · battlefield understanding · controlled violence); the foundation
   (the operator wins fights BEFORE they begin).
4. Define the MILITARY DISCIPLINE ARCHITECTURE: the foundation (Scout Sniper · Reconnaissance · Forward
   Observation · Intelligence Collection · Precision Engagement · Stealth Operations); the six
   competencies (Overwatch Reconnaissance · Scout Sniper · Forward Observer · Covert Operations · Close
   Quarters Combat · Direct Action Recovery); the four levels (UNTRAINED / DEVELOPING / PROFICIENT /
   MASTERED).
5. Define the PLAYER EXPRESSION MODEL: variation through use not class selection; example expressions
   (the patient hunter, the closer-range operator, the anomaly-integrated operator); expression
   boundaries (foundation + competencies + progression rules + canon constraints).
6. Define the NO-XP PROGRESSION MODEL: use · experience · training · mentorship · recovered memory ·
   equipment familiarity · surviving situations · relationships; FORBIDDEN skill points / arbitrary unlocks /
   damage percentages / level numbers / experience bars; observable through animation / audio /
   narrative / visible state.
7. Define the COMBAT TECHNIQUE ARCHITECTURE: techniques not abilities; technique examples (stealth +
   sniper); techniques compose; techniques integrate with foundation + anomaly.
8. Define the WEAPON RELATIONSHIP SYSTEM: familiarity · maintenance · history · modification · emotional
   attachment · field adaptation; weapons tell stories; weapons persist (D017 §11 LIVING SAVE FILE).
9. Define the ANOMALY INTEGRATION with competencies: recon + anomaly · sniper + anomaly · CQC + anomaly ·
   FO + anomaly · covert + anomaly · direct action + anomaly; bounded by D016 §48 + §49; does NOT
   create new skills; has cost (Strain + Control + EXERTION).
10. Define the PHYSICAL CHARACTER EVOLUTION: the body channel; the visual transitions (BROKEN
    PRISONER → SURVIVOR → RECOVERED OPERATOR → UNIQUE PLAYER EXPRESSION) aligned with D017 §3 5-stage
    reclamation ladder; body is player-authored expression.
11. Define the TOUCHSCREEN ACTION PRIORITY LIST: movement / aiming / stealth / interaction /
    equipment / companion commands / grooming / anomaly control — informs D026.
12. Validate against: NOT A CLASS SYSTEM; SEVEN ADVANTAGES; SIX COMPETENCIES; NO-XP; TECHNIQUES NOT
    ABILITIES; WEAPON PERSONAL OBJECTS; ANOMALY MODIFIES NOT REPLACES; BODY PRESERVED; NO FUTURE-SAGA
    CONTAMINATION; OBSERVABILITY.

## IMPLEMENTATION GUIDANCE
- For OPERATOR IDENTITY: design the seven advantages first; they are the foundation that distinguishes
  the operator from a normal soldier. The advantages are TRAINED BEHAVIORS, not talents.
- For MILITARY DISCIPLINE: design the foundation (six military lineage roles); design the six
  competencies LAYERED ON TOP of the foundation; design the four levels (UNTRAINED / DEVELOPING /
  PROFICIENT / MASTERED) READ through behavior, not numbers.
- For PLAYER EXPRESSION: design variation examples (the patient hunter, the closer-range operator, the
  anomaly-integrated operator); design expression boundaries; ensure expression is bounded by canon.
- For NO-XP PROGRESSION: design the eight progression sources; forbid skill points / levels / unlocks /
  percentages; ensure progression is OBSERVABLE through animation / audio / narrative / visible state.
- For COMBAT TECHNIQUE: design technique examples per category (stealth · sniper); design how techniques
  COMPOSE; design how techniques INTEGRATE with foundation + anomaly.
- For WEAPON RELATIONSHIP: design the six relationship dimensions (familiarity · maintenance · history ·
  modification · emotional attachment · field adaptation); design how weapons TELL STORIES; ensure
  weapons PERSIST.
- For ANOMALY INTEGRATION: design the six competency pairings (recon + anomaly · sniper + anomaly · CQC
  + anomaly · FO + anomaly · covert + anomaly · direct action + anomaly); ensure BOUNDED by D016 §48 +
  §49; ensure cost is REAL.
- For PHYSICAL EVOLUTION: design the body channel tracks; design the four visual transitions; align
  with D017 §3 5-stage ladder.
- For TOUCHSCREEN ACTION PRIORITY: design the priority list; ensure the priority informs D026 without
  designing the controls (D026 owns the controls).

## ANTI-PATTERNS
- Re-stating per-character / per-campaign canon inside this skill (creates duplicated lore).
- Competencies become RPG classes (invariant 2 violation).
- Progression becomes XP / skill points / arbitrary unlocks / damage percentages (invariant 8
  violation).
- Techniques become abilities with levels / ranks / skill points (invariant 9 violation).
- Weapons become stat sticks (invariant 10 violation).
- Anomaly replaces operator skill (invariant 11 violation).
- Anomaly creates superheroes (D016 §48 violation).
- Expression overrides canon (invariant 7 violation).
- Body becomes bodybuilder physique (invariant 13 violation).
- Anomaly is present before the island (invariant 13 violation).
- Per-character content in the skill (the lore-duplication anti-pattern).
- Future-saga material imported into Season-1 canon (the contamination anti-pattern).

## KNOWN FAILURE MODES
- Competencies drift to RPG classes: re-anchor to invariant 2 (military competencies, not classes).
- Progression drifts to XP: re-anchor to invariant 8 (use / experience / etc.).
- Techniques drift to abilities: re-anchor to invariant 9 (behaviors, not abilities).
- Weapons drift to stat sticks: re-anchor to invariant 10 (personal objects with history).
- Anomaly drift to superpower: re-anchor to invariant 11 (modify, not replace).
- Body drift to bodybuilder: re-anchor to invariant 13.
- Anomaly present before island: re-anchor to invariant 13.
- Expression drift to class selection: re-anchor to invariant 7 (use, not selection).

## VERIFICATION
- Static: operator identity philosophy answers the seven advantages + foundation; military discipline
  architecture answers the foundation + six competencies + four levels; player expression model answers
  variation examples + expression boundaries; no-XP progression model answers the eight progression
  sources + forbids; combat technique architecture answers technique examples + composition + integration;
  weapon relationship system answers the six dimensions + storytelling + persistence; anomaly integration
  answers the six competency pairings + bounded + cost; physical character evolution answers the body
  channel + visual transitions; touchscreen action priority answers the priority list; no per-character
  canon in the skill.
- Cross-skill: no parallel CQC, anomaly, persistent state, visual presentation, enemy architecture,
  companion / relationship, or observability systems invented; existing owners consumed.
- Tooling: run `tools/validate_methodology.py` and `tests/static_verify_game.py` after any canon change.
  Per-character bible's contradiction ledger should remain at zero contradictions.

## STOP CONDITIONS
If a designed operator / military discipline / combat expression system has competencies become RPG
classes; has progression become XP / skill points / arbitrary unlocks; has techniques become abilities
with levels; has weapons become stat sticks; has anomaly replace operator skill; has anomaly create
superheroes; has expression override canon; has body become bodybuilder physique; has anomaly be
present before the island; has future-saga material be imported; or has per-character canon be
duplicated inside this skill — stop and re-anchor to this skill's invariants and the per-character bible.

## RELATED SKILLS
- BV-SKILL-008 tactical-ai-perception (bounded AI sensing — this skill composes)
- BV-SKILL-012 diegetic-memory-progression (memory sequence + memory bleed — this skill composes for
  recovered memory progression)
- BV-SKILL-016 vertical-slice-discipline (slice scoping — this skill composes)
- BV-SKILL-019 psionic cost pipeline (anomaly cost — this skill composes for anomaly integration cost)
- BV-SKILL-021 cqc-combat-architecture (CQC + Control × Strain + AI-facing interfaces — this skill
  composes; this skill does NOT duplicate CQC architecture)
- BV-SKILL-027 island-population-threat-ecology (population / community — this skill composes)
- BV-SKILL-028 prologue-narrative-architecture (opening gates — this skill composes)
- BV-SKILL-030 anomalous-capability-architecture (anomaly methodology — this skill composes for anomaly
  integration; this skill does NOT duplicate anomaly methodology)
- BV-SKILL-031 persistent-character-state-architecture (state channels + animation-evolution — this skill
  composes for physical character evolution)
- BV-SKILL-032 visual-presentation-architecture (visual production — this skill composes for visual
  transitions)
- BV-SKILL-033 enemy-architecture (enemy architecture — this skill composes)
- BV-SKILL-034 companion-relationship-architecture (companion / relationship / Shade reclamation — this
  skill composes for companionship progression)
- BV-SKILL-015 gameplay-debugging-instrumentation (observability surfaces; SOP-006)
- D025 canonical bible = `docs/design/OPERATOR_IDENTITY_COMBAT_DISCIPLINE_BIBLE.md` (per-character canon
  this skill does not duplicate)
- developers-way, black-vector-project-doctrine (governing); SOP-005/006
- BV-SKILL-036 touchscreen-input-architecture (D026 — realizes the D025 §9 action priority list as the touch layout; this skill retains operator identity / discipline; composition)