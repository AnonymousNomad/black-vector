---
name: cqc-combat-architecture
description: Close-quarters combat architecture — the frozen battle-state/range model, Control & Neural Strain (governing combat-player systems), rage, reclamation bands, Compound vs independent path, TK-in-CQC boundaries, injury/stamina/posture scope, AI-facing combat interfaces, and CQC input/observability. Load when implementing, extending, or reasoning about any combat-facing system.
---

# CLOSE-QUARTERS COMBAT ARCHITECTURE (BV-SKILL-021)

## NAME
CLOSE-QUARTERS COMBAT ARCHITECTURE

## PURPOSE
Implement close-quarters combat as the canonical frozen architecture of doctrine §35-§39 (Directive 008). This is the owning skill for the combat layer itself: the battle-state CONTACT model and orthogonal SPATIAL ranges, the Control and Neural Strain systems and their 2×2 interaction, emergent rage, the reclamation framework that gates what combat can represent, the Compound vs independent paths that reshape Control recovery, TK-in-CQC boundaries, the minimal physical systems (injury/stamina/posture), and the AI-facing combat interfaces later enemies consume. Exchange WINDOWS mechanics (deflect/counter/break timing) remain BV-SKILL-010; this skill owns everything around and above them.

## WHEN TO LOAD
- Implementing or extending any combat-facing system: state model, Control, Neural Strain, rage, reclamation gating, Compound path, TK-in-CQC, physical consequences.
- Designing the D009 training-opponent slice or any later combat slice.
- Reconciling combat internals with assassination (BV-SKILL-009) or psionics (BV-SKILL-019).

## DO NOT LOAD WHEN
- Exchange-window timing/deflection internals (BV-SKILL-010), ranged weapon data (BV-SKILL-011), or per-sense AI behavior (BV-SKILL-008).
- Memory/discipline progression authoring itself (BV-SKILL-012) — load that gating skill; this skill only consumes its gates.

## PRECONDITIONS
- Governing set loaded.
- Doctrinal authority read: §7 (assassination vs combat), §8 (vocabulary reference), §35-§39 (Directive 008 frozen architecture), §21-§22 (psionics/cost), §3/§32 (memory/discipline), SOP-006 (observability).
- Combat-vs-assassination state separation exists (BV-SKILL-009 invariant 1); perception contract exists (BV-SKILL-007/008).

## GOVERNING INVARIANTS
1. CONTACT LAYER IS THE AUTHORITY STATE MACHINE (BV-D033): COMBAT_READ → ENGAGE → EXCHANGE → (DEFLECT | EVADE | COUNTER | BREAK | DISENGAGE) → ADVANTAGE → CONTROL → RESOLUTION → RESET; ADVANTAGE = transient initiative ownership, CONTROL = dominant positional state; no state invented outside this vocabulary.
2. SPATIAL LAYER IS ORTHOGONAL: STRIKING/CLOSE/CLINCH/ENVIRONMENTAL/GROUND/DISENGAGE; cross-range movement is seamless, positional, never a cinematic lock; the player never loses locomotion agency to a script.
3. OWNERSHIP SPLIT (BV-D032): player owns intent/movement/target/timing/defensive choice/aggression/positioning; the character owns exact execution from a directional-read library. NO combo strings, QTEs, memorized lists, or health-sponge exchanges.
4. CONTROL (BV-D035): continuous numeric core; player-facing discrete readable bands; governs anger/tunnel vision/aggression/procedural execution/decision/TK restraint/perceptual stability; NOT morality; low Control = situational benefit + tactical cost; feedback diegetic-first with a thin HUD anchor only.
5. NEURAL STRAIN (BV-D036): independent of Control; never a mana bar; TK is always present and the system governs cost/stability/consequence; heavy path opens authored memory/perception events (BV-SKILL-018) and the vulnerability window (BV-SKILL-019).
6. CONTROL × STRAIN IS A 2×2 OF PLAY STATES (BV-D037), not stacked penalties; Strain feeds Control decay; control recovery is state-dependent; rage emerges only at Control threshold + host event (BV-D034).
7. RAGE (BV-D034) is emergent and makes the Hand more violent but tactically worse (overcommit, stamina burn, tunnel vision, degraded defense, poor disengagement, neural destabilization, excessive-force risk); never a spendable resource.
8. RECLAMATION GATES THE LIBRARY (BV-D040): the execution library is consistent with BROKEN/PRISONER → RELEARNING/SURVIVOR → OPERATOR → THE HAND; progression is timing tolerance, recovery discipline, stamina economy, threat awareness, transitions, restraint, positional control, Control recovery, TK precision — never damage-percentage upgrades (doctrine §38).
9. TLK-IN-CQC BOUNDARY (doctrine §35.6): TK augments, never replaces; allowed levers only (openings, interrupts, nearby-object retrieval/movement, environmental destabilization, emergency separation, momentary restraint); every use incurs Strain; no superhero scale, no object spam, no trivializing positional CQC.
10. MINIMAL PHYSICAL SYSTEMS (doctrine §35.6): stamina, balance/posture, a small injury abstraction, pain/stagger, temporary impairment, environmental collision consequence — a few deep variables, decision-driven not busywork (doctrine §30).
11. AI-FACING INTERFACES (doctrine §35.7): the layer exposes range, exchange window data, initiative, CONTROL reservation/break conditions, posture/balance, stamina, injury, and defensive choice as observable legible events (SOP-006); enemies never read internals; former Hidden Hand mirrors are authored later against these events.

## WORKFLOW
1. Read current combat-adjacent handling (player controller composition, perception, assassination separation) in current form; map onto the frozen state/range model; flag gaps.
2. Define the CONTACT state graph + SPATIAL range layer as data, with reason logging per transition (SOP-006).
3. Define Control (numeric core, band mapping, diegetic thresholds) and Neural Strain (sources, accumulation/decay, consequence triggers) as independent systems; wire their 2×2 interplay.
4. Implement emergent rage (threshold + host event) with the cost set; gate the execution library by the current reclamation band.
5. Define the minimal physical systems and the AI-facing event contract; verify statically, then behaviorally/device when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Keep CONTACT and SPATIAL as two layers: the CONTACT machine answers "what is the exchange doing"; the SPATIAL layer answers "at what range"; transitions log both. This keeps takedown/clinch/environmental ground flow non-cinematic (doctrine §35.3).
- Control band feedback: breathing pitch, hand tremor, stance lowering, camera breathing, audio narrowing, peripheral vignette, and a thin HUD band label — never a precise number, never a happy-gauge.
- Neural Strain sources are events with a class (TK/injury/trauma/anomalous/stress/memory-perception), a cost rank, and a decay curve; consequences are authored per class, heavy-only memory/perception events delegated to BV-SKILL-018.
- Rage activation logs reason (host event + Control value) and opens the rage cost set for exactly as long as the state holds; rage exit (breathing-out, control regained) is a designed moment, not an instant toggle.
- D009 slice scoping: distance, basic offensive intent, guard/defensive intent, stamina/posture, Control, simple rage transition, debug observability — ONE training opponent, NO TK/Compound/boss/roster/animation-library (doctrine §39.1).
- The AI-facing contract is an event surface (range_changed, window_available, initiative_owned, control_reserved, posture_lost, defensive_choice) with payloads; enemies subscribe, they never poll internal state (SOP-006, BV-SKILL-008 honesty rule).

## ANTI-PATTERNS
- A combat machine that is really combination strings in disguise (doctrine §35.1).
- ADVANTAGE as a global "stunned" debuff rather than initiative ownership (doctrine §35.2).
- QTE-style cinematic locks that take locomotion agency from the player (doctrine §35.3).
- Control presented as a moral meter or a precise happy-gauge; Neural Strain reskinned as mana.
- Rage as a build-up resource the player spends for free power.
- Stacking every negative condition as plain stat penalties instead of shifting into a different 2×2 play state.
- "TK solves the fight" — any TK action that replaces positional CQC (doctrine §35.6).
- AI reading Combat controller internals instead of the exposed event contract.

## KNOWN FAILURE MODES
- Rage flicker from jittery Control values — hysteresis and a host-event gate before entry; log transitions.
- Strain consequence drift to "always worse numbers" — class-authored consequence sets keep states distinct (BV-D037).
- Reclamation library leaking higher-band executions into early bands — gate library content by band, not by player skill.
- CONTROL layer collapses into a single monolithic state soup inside one tick function — keep CONTACT/SPATIAL/data separated (SOP-006).
- D009 slice creep toward full combat — the slice proves architecture; everything outside §39.1 is deferred by authority.

## VERIFICATION
- Static: CONTACT states ⊆ canonical vocabulary; SPATIAL layer present; Control/Strain independent data; 2×2 interplay rule present; rage = threshold+host-event; reclamation gating hook present; minimal physical set; AI-facing event contract declared; damage-percentage upgrades absent.
- Behavioral (when authorized): fixture trains opponent intent; assert CONTACT transitions follow the data graph under scripted inputs; rage entry requires host event; Strain decay and Control recovery follow the 2×2 expectations; AI-facing events fire for a subscribing observer.

## STOP CONDITIONS
If the combat implementation reads player internals for the AI, presents Control as morality/mana, lets rage be spent as power, or lets TK replace positioning — stop and re-anchor to doctrine §35-§39.

## RELATED SKILLS
- BV-SKILL-010 close-combat-exchange (exchange windows/deflection internals)
- BV-SKILL-009 contextual-assassination (combat vs assassination separation)
- BV-SKILL-019 psionic-gameplay-neural-load (TK levers + neural-load pipeline feeding Strain)
- BV-SKILL-018 psychological-horror-perceptual-events (heavy-Strain authored events)
- BV-SKILL-012 diegetic-memory-progression (reclamation/discipline gates)
- BV-SKILL-015 gameplay-debugging-instrumentation (observability), SOP-006
- BV-SKILL-028 prologue-narrative-architecture (D014 prison/decline control-band degradation, post-completion mastery replay)
- BV-SKILL-030 anomalous-capability-architecture (D016 capability design procedure — this skill retains Combat/Control/Strain/TK-in-CQC ownership; methodology composes, does not replace)
- BV-SKILL-033 enemy-architecture (D022 AI / faction / enemy architecture methodology — this skill retains CQC architecture; AI perception state machine + squad behavior + archetypes compose through AI-facing interfaces)
- BV-SKILL-035 operator-discipline-architecture (D025 — six military competencies + combat technique architecture compose with CQC; this skill retains CQC + Control × Strain + AI-facing interfaces; composition)
- BV-SKILL-035 operator-discipline-architecture (D025 — six military competencies + combat technique architecture compose with CQC; this skill retains CQC + Control × Strain + AI-facing interfaces; composition)
- developers-way (governing)