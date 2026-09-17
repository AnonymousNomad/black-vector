---
name: tactical-ai-perception
description: Tactical AI Perception — bounded, computationally restrained, non-omniscient sensory cognition for enemies. Vision/hearing/suspicion/last-known-position, knowledge-with-source, and reason logging. Load when implementing or tuning enemy sensing and behavior.
---

# TACTICAL AI PERCEPTION (BV-SKILL-008)

## NAME
TACTICAL AI PERCEPTION

## PURPOSE
Implement HUMAN-threat sensing as simulation-cheap, legible, non-omniscient perception: bounded vision, hearing, suspicion, and last-known-position, where every knowledge the AI holds carries a source and can be explained in one sentence. No AI cheats (doctrine §2, §6; Pillar KNOWLEDGE). This skill covers the HUMAN threat class (doctrine §23); EXPERIMENTAL and PARANORMAL classes are governed elsewhere (see DO NOT LOAD WHEN / related skills).

## WHEN TO LOAD
- Building/tuning enemy sight, hearing, suspicion, alert states, or search behavior.
- Reasoning about why an AI did/didn't react.

## DO NOT LOAD WHEN
- Player-side stealth emission (stealth-and-concealment owns emission; this is the symmetric consumer).
- Close-combat/deflection behavior (close-combat-exchange).
- EXPERIMENTAL threat behaviors (physical horrors — they obey physical gameplay rules but are not human-tactical; see note in implementation guidance) or PARANORMAL/ANOMALOUS phenomena (BV-SKILL-018 governs: rare, partially unexplained, NEVER routine sensing content, doctrine §23).

## PRECONDITIONS
- Governing set loaded.
- Emission model (BV-SKILL-007) symmetric contract agreed (same channel vocabulary, bounded).
- World affordances (BV-SKILL-006) provide cover/concealment/light data the senses will consume.
- Threat class identified as HUMAN before this skill's machinery is applied wholesale (doctrine §23).

## GOVERNING INVARIANTS
1. NO OMNISCIENT AI. The AI perceives only what its configured senses produce: no world scans, no telepathic position access, no knowledge without a source.
2. Computationally bounded: sense cost is amortized over time (update fans out across frames/agents) — never full-fidelity every-agent every-frame (SOP-004).
3. Legible: every perception outcome has a reason chain (source+channel+value) recorded per SOP-006; suspicion is an interpretable scalar with labeled causes, not soup.
4. Knowledge-with-source (Pillar 1): the AI's state separates "world truth" from "AI belief" (positions it knows exactly, positions it suspects, sounds it heard). It can hold beliefs about the player's location; it cannot ever read the player's transform directly.
5. Behavior is consequence-driven: perception feeds behavior decisions; the AI reacts with search/approach/alert states that are explainable and testable.
6. Cooperation is bounded: a shared last-known-position across a squad is an OBSERVED report (a source), never an automatic mental sync of exact coordinates without a communication cost.
7. Perception failures are features: missed detection, misdirection, and time decay of suspicion are designed, not bugs.

## WORKFLOW
1. Read current enemy sensing in current form; confirm no cheat pattern.
2. Define sense configuration per archetype: vision cone (fov, range, cover-blocking, light weighting), hearing radius/fidelity, suspicion decay, alert thresholds.
3. Implement amortized scheduling: per-frame budget N perception ticks; queue observers across frames.
4. Record beliefs: each belief = (type, target-info, source channel, timestamp, confidence). Never write transform positions into belief without an observed source.
5. Implement suspicion + alert states with reason logging; wire to behavior (search, investigate, alert, engage) only via belief changes.
6. Static verify; behavioral/device verify when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Reference prototype (Directive-007/BV-001C): `game/scripts/ai/vision_sensor.gd`, `game/scripts/ai/hearing_sensor.gd`, `game/scripts/ai/observer.gd` (single-observer: Signature→Sensor→Observation→Knowledge→Suspicion→Decision→Action; no combat). Player emission side: `game/scripts/player/signature_controller.gd` `noise_event(origin, volume, kind)`.
- Vision: cone test + occlusion via a bounded number of raycasts (or area + cover tag) against tagged surfaces; weight by illumination/silhouette (consumer of emission).
- Hearing: use emitted sound events (radius/texture), not distance-only math; log event→belief. TRAP HEARING: human actors also hear the SAME weather/storm noise floor the player exploits (BV-SKILL-007) — masking must be symmetric.
- Last-known-position: belief written only from a perceived event; decays; alert only from accepted belief (never from world-state read).
- Scheduling: a central perception budget (e.g., K vision checks per frame distributed round-robin); every agent reports its own latency — late-but-fair beats instant-but-cheating.
- Expose overlay (SOP-006): sight cones, heard events, beliefs with sources — dev-only, zero gameplay effect.
- EXPERIMENTAL threats (doctrine §23) may reuse bounded sensing machinery where they obey physical rules, but their sense configuration is authored as its own archetype (e.g., sound-driven), NEVER a copy-paste human brain, and NEVER a global-scan cheat.
- Former Hidden Hand members are HUMAN threat archetypes first; abnormal capabilities (doctrine §27) are added as explicit, bounded sense/behavior deltas — they do not become omniscient.

## ANTI-PATTERNS
- `can_see_player()` that reads the player transform and returns bool — ANY direct read of world player truth an AI would not possess.
- Every-agent-every-frame full raycast vision (frame storm).
- A global "alert level" shared telepathically across the map.
- Belief = exactly player position forever (no decay, no search state).
- Knowledge with no stated source (grep-able “how did it know?”).

## KNOWN FAILURE MODES
- AI "sees" through cover because occlusion ray misses (cover tag mismatch vs collider mismatch in BV-SKILL-006) — fixture audit.
- Suspicion toggles too fast (perception cheapness → flicker) — hysteresis/latency in thresholds.
- Squad telepathy (all share exact knowledge) — enforce report-with-cost path.
- Burst frame spike from unscheduled perception — enforce amortization and measure (SOP-004).

## VERIFICATION
- Static: no transform-read-in-sensing; beliefs carry source+timestamp; scheduling budget present; decay/hysteresis wired.
- Behavioral (when authorized to run): fixtures — target behind cover vs exposed; noise behind wall; belief decay after target leave view; squad report latency asserted.

## STOP CONDITIONS
If any sensing path reads world truth without a source, or perception is not explainable from its beliefs, stop and fix — honesty of the AI's knowledge is a product pillar, not polish.

## PERFORMANCE
- Vision cone raycast counts bounded and amortized; hearing = event processing; no per-frame global scans (SOP-004).

## DEVICE
- Tablet CPU: keep amortization headroom sensible; measure with a full sector NPC population on device.

## RELATED SKILLS
- BV-SKILL-007 stealth-and-concealment (symmetric emission contract)
- BV-SKILL-006 environmental-affordances (light/cover consumption)
- BV-SKILL-009 contextual-assassination (detection → engagement handoff)
- BV-SKILL-018 psychological-horror-perceptual-events (PARANORMAL/ANOMALOUS sensing boundary)
- BV-SKILL-017 survival-wilderness-systems (wildlife as non-HUMAN sensing actors; same bounded model)
- SOP-004 mobile-performance; SOP-006 debug-observability; developers-way (governing)
- BV-SKILL-033 enemy-architecture (D022 AI / faction / enemy architecture methodology — this skill retains tactical AI sensing internals; AI perception state machine + squad behavior compose without duplicating)
- BV-SKILL-033 enemy-architecture (D022 AI / faction / enemy architecture methodology — this skill retains tactical AI sensing internals; AI perception state machine + squad behavior compose without duplicating)