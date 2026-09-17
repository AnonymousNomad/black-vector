---
name: stealth-and-concealment
description: Stealth as multi-channel signature reduction — visual/movement/silhouette/illumination/acoustic/environmental/thermal/electronic/social channels, cover vs concealment, legible suspicion, and weather-driven environmental masking in the Alaska setting. NO hidden=true. Load when implementing or reasoning about stealth, detection, or enemy/wildlife sensing.
---

# STEALTH AND CONCEALMENT (BV-SKILL-007)

## NAME
STEALTH AND CONCEALMENT

## PURPOSE
Deliver stealth as a legible, multi-channel, computationally bounded SIGNATURE system (Pillar 2): the player reduces detectability across channels (visual, movement, silhouette, illumination, acoustic, environmental, thermal, electronic, social) instead of flipping a hidden flag. The ENVIRONMENTAL channel is now first-class gameplay: Alaska weather (storms, snow, wind, visibility collapse) is a designed stealth tool AND a survival hazard (doctrine §5, §6, §30). Avoid overengineering into a military sensor platform (doctrine §6).

## WHEN TO LOAD
- Implementing or tuning detection, suspicion, noise, light, or concealment.
- Designing how the player reads the world's senses.

## DO NOT LOAD WHEN
- Pure movement/stance (those feed signature here but are owned elsewhere).
- Single-target combat/AI behavior without sensing (use tactical-ai-perception).

## PRECONDITIONS
- Governing set loaded.
- Stance table (BV-SKILL-004) and affordance taxonomy (BV-SKILL-006) exist — signature consumes them.
- AI sensing contract (BV-SKILL-008) is symmetric with this skill's emission model.

## GOVERNING INVARIANTS
1. THERE IS NO `hidden = true`. Concealment is a set of per-channel detectability reductions with sources (light, cover, concealment, stance, motion, noise, environment). (doctrine §6)
2. Channels are distinct and future-proof: VISUAL (sight lines, illumination, silhouette), MOVEMENT (speed/motion), SILHOUETTE (background contrast), ILLUMINATION (player light), ACOUSTIC (noise), ENVIRONMENTAL (weather/traffic masking, foliage, snow, storm noise, visibility collapse), THERMAL, ELECTRONIC, SOCIAL — and new channels must be addable without rewriting the emitter.
3. Detection is simulation-cheap and bounded; it NEVER scans the whole world per frame in full fidelity (doctrine §6, SOP-004).
4. Legibility: the player must predict the world's senses from diegetic evidence (shadows, light pools, sound sources, alertness, weather) — never from debug internals.
5. Stance × motion × environment produce deterministic signature contributions (same inputs → same signature, so the player can learn them).
6. No omniscient AI: knowledge has a source (Pillar 1); an enemy "knows" only what its channel evidence produced.
7. ANCESTRY OF SURVIVAL: cold/fatigue/wetness (doctrine §30 survival state) feed the MOVEMENT and ENVIRONMENTAL channels as bounded, decision-relevant contributions (shivering noise, slowed motion) — never as instant busywork meters bolted onto detection.
8. WILDLIFE on the same model: wildlife sensing consumes the same bounded emission (doctrine §6) — it is credible regional behavior, never spawning monsters with telepathic sight.
9. THERMAL is a designed-alaska channel: cold environments make thermal contrast matter; hard shelter/concealment is a legitimate lever. This is weather physics IN the signature game, not a gimmick.

## WORKFLOW
1. Read current emission/sensing code in current form; confirm no hidden-flag pattern exists.
2. Define channel set in one place (a ChannelPrimary resource/enum) with per-emitter emit logic.
3. Implement SignatureEmitter (player) that emits per-channel contributions from stance, speed, light level, carrying environment, activity; guaranteed O(1)-ish per tick.
4. Balance: verify channel contributions produce learned, fair outcomes (fixture: light + motion + noise cases).
5. Make sensing legible: in-universe cues + debug overlay (SOP-006) showing channel breakdown (dev tools only, no gameplay effect).

## IMPLEMENTATION GUIDANCE
- Represent concealment as: for each channel → a detectability value (0..1 or similar) driven by environment+stance+motion; aggregate bounded by the sensing game face (thresholds, suspicion) — do not build a general "sensor math" platform.
- Illumination: player light level from light sources (baked light probes or cheap sampled values); silhouette from background treatment where affordable.
- Acoustic: emit sound events with radius/texture; sensing cost = event count, not world scan.
- Weather (ENVIRONMENTAL): wind/storm sets a global noise floor that raises hearing thresholds symmetrically (both sides) and lowers visual range; snow cover changes silhouette/thermal contrast. Implemented as bounded global state + per-emitter deltas, never per-frame world scans.
- Cover (blocks sight line/ballistics) vs Concealment (reduces detection without blocking) are distinct affordance tags (BV-SKILL-006); never conflate.
- Keep the world's senses symmetric: the same emitter rules the player uses should let the player be sensed identically (design honest friction). Weather masking must apply to the player too — a blizzard that hides you also hides you from yourself (navigation/survival reads) — that is the decision the player makes (doctrine §30).
- Avoid the "everything senses everything" default: each NPC has a bounded sense configuration.

## ANTI-PATTERNS
- `hidden = true` / `is_hidden` inventory — any boolean stealth flag (doctrine §6, Pillar 2).
- A global "detection level" scalar that is secretly one channel in disguise.
- Per-frame full-fidelity sensing (raycast storms) — violates bounded sensing (SOP-004).
- Making stealth all-or-nothing (0.0 or 1.0 with no learned gradient).
- Emitting sounds/light that no one can interpret diegetically (magic telepathy).
- Weather as pure cosmetic FX (no gameplay or sensing effect) — a missed designed mechanic.
- Weather that hides the player but never hurts the player's optics (one-sided masking).

## KNOWN FAILURE MODES
- Detections that are impossible to learn (random jitter instead of deterministic channel math).
- Player "standing in shadow" meaning nothing → illumination channel missing/broken contribution; validate by fixture.
- Concealment positioned where cover should be (blocks nothing) — affordance tag mismatch.
- Overengineering creep (10 channels, 0 gameplay) — mission discipline per doctrine §11: cut invisible systems.

## VERIFICATION
- Static: no hidden-flag pattern (grep-able), one channel definition, bounded emissions, symmetry rule present.
- Behavioral (when authorized to run): fixture sets (light+motion, noise+cover, stance states) → expected detectability; learning test: player can predict a detection from diegetic cues alone.

## STOP CONDITIONS
If channel math becomes opaque (unexplainable detections), if sensing cost grows unboundedly, or if legibility fails — stop; stealth in opacity state is a defect, not a feature.

## PERFORMANCE
- Emission O(1)-ish per emitter; sensing bounded per observer; no per-frame global scans (SOP-004).

## DEVICE
- Light/visibility calibration validated on tablet display (brightness/screen-gamma differs from desktop); enum it in device-notes.

## RELATED SKILLS
- BV-SKILL-004 stance-system (signature factors per stance)
- BV-SKILL-006 environmental-affordances (illumination/cover/concealment surfaces)
- BV-SKILL-008 tactical-ai-perception (symmetric sensing contract)
- BV-SKILL-014 mobile-graphics-atmosphere (baked light/mood visuals of darkness)
- SOP-006 debug-observability; developers-way (governing)
- BV-SKILL-036 touchscreen-input-architecture (D026 — stealth inputs are physical postures/analog discipline, no stealth mode; interactions emit signature; this skill retains channel mechanics; composition)