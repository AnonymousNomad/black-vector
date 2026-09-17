---
name: prologue-narrative-architecture
description: Prologue and opening narrative architecture — the canonical Hidden Hand opening structure (ICON → BROTHER → FRACTURED VETERAN → KILLER → PRISONER → SUBJECT → SURVIVOR), Layered Overwatch gameplay loop at peak, gameplay-vs-cinematic ownership allocation, player-information gating across the fall, prologue pacing, and future observability. Load for ANY work on the opening experience, the fall-from-grace through-line, the peak-mission loop, or knowledge-boundary design for the first hour.
---

# PROLOGUE NARRATIVE ARCHITECTURE (BV-SKILL-028)

## NAME
PROLOGUE NARRATIVE ARCHITECTURE

## PURPOSE
Own the interactive opening structure and the peak-vs-broken contrast that carries the first hour of BLACK VECTOR.
This skill exists because no other skill owned: interactive opening structure, gameplay/narrative contrast (peak
Hidden Hand vs island-era Hand), player-information gating across the fall, or prologue pacing (Directive 013 §36
inspection). Canon source: `docs/design/HIDDEN_HAND_PROLOGUE_BIBLE.md` (Directive 014). It composes — never
replaces — the specialists: D013 weapon bible owns the Layered Overwatch kit; doctrine §29-§31 owns the icon/fall;
BV-SKILL-012 owns memory/progression; BV-SKILL-018 owns horror/ambiguity presentation; BV-SKILL-011 owns the
starting lock. This skill owns the FRAME that orders them.

## WHEN TO LOAD
- Any work on the opening experience (OP HALF-LIGHT peak mission, decline, atrocity, prison, diversion,
  awakening) or the fall-from-grace through-line.
- Authoring the Layered Overwatch gameplay loop or the attention-management model at peak.
- Any player-knowledge-boundary / information-gating decision in the first hour.
- Prologue pacing, agency allocation (FULLY/LIMITED/INTERACTIVE/NONINTERACTIVE), or sequence↔mechanical alignment.
- Replay-mode decisions for the peak mission, or future implementation observability (MISSION_PHASE etc.).

## DO NOT LOAD WHEN
- Weapon/equipment design (BV-SKILL-025 / D013 bible), ballistics (BV-SKILL-011), visual (BV-SKILL-022).
- Combat/CQC systems (BV-SKILL-021), memory/progression internals (BV-SKILL-012).
- Horror/perceptual anomaly authoring (BV-SKILL-018 owns rarity and ambiguity by itself).
- Actual scene/level implementation of the opening beat (BV-SKILL-016 vertical-slice discipline routes a slice).

## PRECONDITIONS
- Governing set loaded; SOP-002 routing confirms opening-scope.
- D014 bible current + doctrine §29-§31/§33-§34 + D012/D011/D013 cross-canon read (bible header lists them).
- The six-purpose contract and the emotional spine ACKNOWLEDGED as the through-line guard (§1 of the bible).

## GOVERNING INVARIANTS
1. EMOTIONAL SPINE HOLDS: ICON → BROTHER → FRACTURED VETERAN → KILLER → PRISONER → SUBJECT → SURVIVOR; every beat
   serves at least one spine station; no beat jumps purely for spectacle.
2. GROUNDED-FIRST OPENING: the player begins in a grounded elite military game; NO pre-collapse supernatural
   powers (doctrine §29; D012 §12); unusual awareness stays explainable (training/intuition/perception/tech/
   experience); the door to later ambiguity stays OPEN, never ANSWERED here (bible §27).
3. RESPONSIBILITY, NOT EMPOWERMENT: the civilian/family catastrophe sequences are presented fragmented/controlled;
   The Hand genuinely committed them; context never exonerates; never sandbox-violence gameplay (bible §16/§17;
   doctrine §18; D012 §14).
4. LAYERED OVERWATCH OPERATES UNDER D013 LAW: three layers (Hand / remote support platform / drone) + fused
   visor/forearm picture, all bounded — no omniscience, B/C/F/D intact, equipment multiplies skill not replaces
   it (D013 §8-§11, §21; D011 §7 truth).
5. ATTENTION IS THE CULTURE: more active systems = more cognitive load; the legend is earned by correct
   prioritization under load; this learned muscle conceptually re-arms Neural Strain later (no mechanical
   carryover) (bible §6).
6. KNOWLEDGE GATE TABLE IS LAW: at main-game start the player understands the 9 facts, does NOT understand the 9
   enriches (Compound, withdrawal cause, Black Hand's truth, uniqueness, diversion reason, BLACK VECTOR meaning,
   catastrophe cause, Darkness, paranormal reality) — the main game DISCOVERS these (bible §28; doctrine §3/§2).
7. BROTHERHOOD BEFORE THE FALL: Hidden Hand's love/trust of The Hand is established before anything breaks; the
   extraction beat is the keystone ("These people love this man") (bible §10/§12).
8. AGENCY FOLLOWS THE MAN: FULLY PLAYABLE at the peak, decaying through LIMITED/INTERACTIVE in the fall, rising
   again (differently) through reclamation; allocation table in bible §31 is the contract.
9. LEGAL THREAD STAYS COHERENT: life sentence → NEW capital conviction in prison → death row → fictional/opaque
   diversion; no administrative-transfer shortcuts, no real-world procedures (bible §19/§22).

## WORKFLOW
1. Identify the sequence (peak / homecoming / decline / bloodscene / catastrophe / police / prison / death row /
   diversion / experimentation / nurse / awakening) and its spine station.
2. Read the bible section + this skill's invariants for that sequence; confirm the frozen allocation (agency) and
   any hard-limit list that applies.
3. Compose across owners: route mechanics to BV-SKILL-011/021/012, visuals to BV-SKILL-022, horror beats to
   BV-SKILL-018, equipment to BV-SKILL-025/D013 — never write their internals here.
4. Verify each beat against: knowledge-gate table (§28), power boundary (§27), promise boundary (§29, 60–70%
   conventional only), benefit/cost (§30), no-omniscience (D011 §7).
5. Close: update bible/deferred list if a durable decision emerged; run methodology validation; surface any
   contradiction to doctrine honestly.

## IMPLEMENTATION GUIDANCE
- Peak mission pacing rides the §8 competing-demands list expressed as POSITIONS in space, not prose checkboxes;
   the crisis (§9) is the designed peak of the Layered Overwatch loop.
- When authoring decline: alcohol/cannabis are failed self-medication, never the CAUSE of violence; underlying
   cause = fictional conditioning collapse (bible §15; D012 §13).
- Prison arc must read through Control bands degrading toward BROKEN/PRISONER (doctrine §35.4/§38.1) with the
   photograph as the retention thread (bible §20).
- Experimentation flashes carry phenomenon, never terminology (no "Compound", no program names) (bible §23/§28).
- Awakening must hand off to S-1 Strand slice (ALASKA_WORLD_FOUNDATION §12-J) with starting-lock possessions law
   intact (bible §26).
- Replay of the peak mission is an explicit opt-in mastery mode only; never interferes with first-run pacing
   (bible §33).
- Future implementation debugs are pre-defined channels (MISSION_PHASE / TEAMMATE_STATE / SENSOR_TRUTH /
   DRONE_INFORMATION_OWNERSHIP / REMOTE_PLATFORM_STATE / HAND_ATTENTION_LOAD / OBJECTIVE_STATE / EXTRACTION_STATE /
   bible §34) — instrument first (SOP-006).

## ANTI-PATTERNS
- Opening with exposition about Black Hand/Compound/TK/Shades/Darkness (doctrine §29; bible §2).
- Pre-collapse superhuman reads or an answered "was something beginning?" (bible §27; D012 §12).
- Cigar scene without the brotherhood keystone (bible §12); fall without love-first (bible §10).
- Freeform/celebratory civilian-violence gameplay (bible §16/§17).
- A legal shortcut that makes prison/death-row incoherent (bible §19/§22).
- Reaching for omniscient drone/visor/telemetry truth (D011 §7; bible §4/§5/§34).
- Putting any of the nine "should-not-understand" facts on the opening's surface (bible §28).
- Treating the opening as a tutorial for Neural Strain (conceptual continuity only, §6).

## KNOWN FAILURE MODES
- Pacing bloat: opening outruns "the island is the beginning" (bible §32 targets). Trim toward proportional bands.
- Attention model collapses into busywork: peak loop must feel like judgment, not juggling-a-HUD (bible §6/§9).
- Agency rule drift: a sequence grants play the narrative can't justify, or withholds it to fake drama (bible §31).
- Replay leaking into first-run: keep replay strictly opt-in post-completion (bible §33).
- Knowledge creep: an experimental flash accidentally names a program or the Compound (bible §23/§28 stop).

## VERIFICATION
- Static: each opening sequence maps to a spine station + an agency allocation + knowledge-gate compliance; power
   boundary intact; brotherhood keystone present before the fall; legal thread coherent; validator clean.
- Read-through: an unfamiliar lead can, from the bible alone, answer "what does the player know WHERE and WHEN"
   and "which beats are playable" for every sequence.
- Contradiction watch: D011/D012/D013/world-foundation mismatch surfaced to doctrine (bible Appendix A pattern).

## STOP CONDITIONS
If the opening asks for paranormal powers, omniscient info, celebratory catastrophe play, a legally incoherent
prison/death-row thread, a premature Compound/program reveal, or a brotherhood-less fall — stop and re-anchor to
the D014 bible sections cited above before continuing.

## RELATED SKILLS
- D014 canonical bible = `docs/design/HIDDEN_HAND_PROLOGUE_BIBLE.md` (BV-D071–D078)
- BV-SKILL-012 diegetic-memory-progression (memory/progression; photograph thread)
- BV-SKILL-018 psychological-horror-perceptual-events (atrocity/ambiguity presentation)
- BV-SKILL-025 weapon-platform-role-design + D013 bible (Layered Overwatch kit)
- BV-SKILL-011 weapon-handling-ballistics (starting lock), BV-SKILL-021 cqc-combat-architecture,
  BV-SKILL-008 tactical-ai-perception (no-omniscience contracts)
- BV-SKILL-016 vertical-slice-discipline (when/slice implementation is scoped), BV-SKILL-020 observability (as future channel)
- BV-SKILL-029 simse-island-systems (D015 substrate the S-1 awakening wakes INTO: survival-state/weather/shelter; NEURAL STRAIN held dark)
- BV-SKILL-030 anomalous-capability-architecture (D016 capability design procedure — opening knowledge gates preserved; first undeniable event is post-opening, earned)
- BV-SKILL-031 persistent-character-state-architecture (D017 STAGE 0 LEGEND reference + prologue→BROKEN SURVIVOR handoff — knowledge gates preserved)
- BV-SKILL-032 visual-presentation-architecture (D019 visual production methodology — prologue visual reference STAGE 0 LEGEND composed; FP body-presence and signature moments preserved)
- BV-SKILL-033 enemy-architecture (D022 enemy architecture methodology — prologue opponents compose; faction taxonomy excluded from slice scope per D022 §10)
- BV-SKILL-034 companion-relationship-architecture (D023 companion / relationship / Shade reclamation — the prologue's emotional anchor for IDENTITY pillar; the prologue's emotional beats drive companion arc; composition)
- BV-SKILL-035 operator-discipline-architecture (D025 — operator identity foundation rooted in the prologue's military lineage; preserved canon (opening timeline + body identity) protected; composition)
- developers-way, black-vector-project-doctrine (governing); SOP-002/006