---
name: psychological-horror-perceptual-events
description: Psychological horror and perceptual/paranormal events — three-threat-class discipline (HUMAN/EXPERIMENTAL/PARANORMAL), ambiguity-by-design, hallucination vs reality separation, biblical imagery as symbolism, authoring rare disruptive anomalies that NEVER become routine enemy content. Load when designing/verifying horror, anomalies, or perception distortion.
---

# PSYCHOLOGICAL HORROR AND PERCEPTUAL EVENTS (BV-SKILL-018)

## NAME
PSYCHOLOGICAL HORROR AND PERCEPTUAL EVENTS

## PURPOSE
Make horror a disciplined design system, not chaos: author and verify the three threat classes (HUMAN / EXPERIMENTAL / PARANORMAL, doctrine §23), perceptual-modulation events (conditioning, hallucination, memory instability — doctrine §16/§18/§22), and the ambiguity contract (doctrine §24). Paranormal phenomena are rare, disruptive, frightening, partially unexplained, and NEVER routine enemy content (doctrine §23). Horror and bugs must be separable by design (BV-SKILL-015).

## WHEN TO LOAD
- Designing/authoring any horror, anomaly, hallucination, or perceptual-modulation content.
- Verifying that anomalous/paranormal content obeys the ambiguity contract and does not drift into a routine bestiary.
- Reasoning about the EXPERIMENTAL vs PARANORMAL boundary.

## DO NOT LOAD WHEN
- Normal tactical HUMAN threat perception (BV-SKILL-008).
- Psionic cost/mechanics pipeline (BV-SKILL-019) — though psionic distortion events are consumed here for authored expression.
- Combat/close-combat internals (BV-SKILL-010).

## PRECONDITIONS
- Governing set loaded.
- Horror model (doctrine §23-24) understood: three classes, paranormal-scarcity rule, no over-explanation.
- Observability contract (BV-SKILL-015) available — every perceptual event must be WORLD/PERCEIVED separable.
- Narrative pillars (doctrine §34) available — every major horror arc strengthens at least one.

## GOVERNING INVARIANTS
1. THREE CLASSES, THREE DISCIPLINES: HUMAN (tactical — BV-SKILL-008), EXPERIMENTAL (objective, physical rules — e.g., BV-SKILL-008 bounded machinery reuse), PARANORMAL/ANOMALOUS (this skill; rare, ambiguous, non-routine). A manifested thing is CLASSIFIED EXACTLY ONCE; classification is canonical data exposed in debug (BV-SKILL-015).
2. PARANORMAL IS NEVER ROUTINE: no standard demon bestiary with ordinary health bars (doctrine §23). Paranormal encounters are authored events — sparse, scripted-or-event-driven, physically-inconsistent-on-purpose. If a "paranormal thing" recurs casually, it is either reclassified EXPERIMENTAL or cut.
3. AMBIGUITY IS MANDATORY: the game may never fully resolve whether an anomaly is supernatural, psychic, experimental, hallucinatory, or something else. Definitive over-explanation is a design defect (doctrine §23-24).
4. PERCEPTUAL EVENTS ARE AUTHORED AND TRACEABLE: conditioning, hallucination, memory instability, and psionic distortion are authored events with an ID and a reason chain (BV-SKILL-015 WORLD/PERCEIVED rows). A hallucinated thing is encoded as a PERCEIVED-layer event; the WORLD layer truth is separate. No hallucination exists that the fiction cannot name (doctrine §16/§18/§22).
5. BIBLICAL IMAGERY IS SYMBOLISM: terms like WATCHER/SERAPH/CAIN/ABADDON/THE PIT/SEAL are interpretation/classification by characters — NEVER a claim that a real-world religion is true in-world, NEVER a roadmap to a canonical demonology (doctrine §24).
6. HORROR SERVES THE PILLARS: every major horror structure strengthens IDENTITY, BROTHERHOOD, or RESPONSIBILITY (doctrine §34). Horror is never noise.
7. CONSEQUENCE CLEAN: even ambiguous events produce causal, remembered world effects (Pillar 3) where the fiction allows (bodies, changed patrols, surviving researchers); ambiguity never means "nothing happened."
8. HORROR IS FAIR TO THE PLAYER AS A SYSTEM: legibility of affect (what the player perceives and why) is parenthetical to the fiction — the OVERLAY is always truthful about WORLD vs PERCEIVED, the player's diegetic confusion is a designed experience, not an unobservable state.

## WORKFLOW
1. Classify the content into exactly one threat class; record classification.
2. Author the anomaly/perceptual event as data: id, class, WORLD-layer truth, PERCEIVED-layer content, reason (conditioning event / psionic load / anomaly script), scarcity budget.
3. Design the DIEGETIC cue trail (what the character sees/hears, what might be context-consistent) — the player reads horror from evidence, not from the overlay.
4. Verify scarcity: count of PARANORMAL-class content in the slice/world stays small; check it against the no-routine-bestiary rule.
5. Verify ambiguity: a checklist — can this be read as experimental, psychic, hallucinatory, or supernatural without contradiction? If only one reading is possible, the ambiguity contract is broken.
6. Wire consequence (Pillar 3) and narrative-pillar anchoring (doctrine §34).
7. Static verify; behavioral/device verify when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Author a "threat-class ledger" (data): each manifested entity/event has class, recurrence budget, physical-rule flag, and ambiguity spectrum. The ledger is the anti-bestiary control (BV-SKILL-015 shows it in debug).
- Perceptual events reuse the WORLD/PERCEIVED overlay contract (BV-SKILL-015) with authored event-ids: "NPC X exists in WORLD = false, PERCEIVED = true, reason=psionic-load-event#47".
- EXPERIMENTAL class may reuse BV-SKILL-008 sensing machinery, but authored as its own archetype (sound-driven, or a physical blind-spot behavior) — never a human-brain copy.
- Use biblical imagery as CHARACTER language (classification tags in researcher logs, prisoner graffiti) with explicit canonical note that this proves nothing about any real-world religion (doctrine §24).
- Cadence: paranormal density rises with isolation/darkness/cold and heavy psionic load (doctrine §22) — the state machine of horror is tied to the survival-weather state (BV-SKILL-017), never random dice rolls with no cause.
- The resulting unease must never morph the genre: keep the tactical/human layer grounded (doctrine §23 "Realistic tactical layer vs paranormal ambiguity" resolution: they are separated classes, they never contaminate each other).

## ANTI-PATTERNS
- Every other NPC is a paranormal ghost (routine bestiary).
- Paranormal things with ordinary health bars and farming-style kills.
- Over-explaining the anomaly in a data-dump or a definitive NPC lore-drop (breaks ambiguity).
- Having the WORLD layer secretly "true" a supernatural reading (over-commit) while the fiction is still ambiguous.
- Horror with no authored trace in WORLD/PERCEIVED (a "spooky thing" a developer cannot classify = a bug wearing a costume).
- Horror content that serves no narrative pillar (doctrine §34).

## KNOWN FAILURE MODES
- Ambiguity collapses under player theories → keep ambiguity-spectrum checks in content review; if a probe of "untangle-ability" stays positive, add a second plausible reading.
- Paranormal recurrence creeps up across slices → the ledger's recurrence budget is validated per slice (BV-SKILL-016).
- Bugs mistaken for horror, and horror mistaken for bugs → BV-SKILL-015 overlay separation is the fixed contract; classification + reason are mandatory fields.
- Biblical vocabulary hardening into a known mythology → doctrine §24 note stays canonical; reviewer greps new terms toward symbolism-only usage.

## VERIFICATION
- Static: every anomaly/event has class, reason, WORLD/PERCEIVED truth, scarcity value, ambiguity checklist ≥2 readings, pillar anchor, and consequence hook.
- Behavioral (when authorized): fixture shows an authored hallucination renders only in PERCEIVED layer, does not affect WORLD sim, is greppable to its event id; scarcity count for the slice passes budget; ambiguity checklist passes.

## STOP CONDITIONS
If paranormal content becomes routine, if a hallucination lacks an authored trace, or if ambiguity is irreconcilable with the fiction — stop and re-author. Horror in isolation may be quiet, but it must always be classified.

## PERFORMANCE
- Perceptual events are occasional; cost is event-triggered, budget-checked under SOP-004. Never a per-frame "spooky pass."

## DEVICE
- Tablet: darkness/fog readability and audio consistency for horror beats (headphones-vs-speaker mixes) validated on device.

## RELATED SKILLS
- BV-SKILL-015 gameplay-debugging-instrumentation (WORLD vs PERCEIVED contract)
- BV-SKILL-008 tactical-ai-perception (HUMAN/EXPERIMENTAL boundary)
- BV-SKILL-019 psionic-gameplay-neural-load (distortion source)
- BV-SKILL-012 diegetic-memory-progression (memory instability events)
- BV-SKILL-017 survival-wilderness-systems (isolation/weather cadence hooks)
- BV-SKILL-020 facility-and-ally-support (ally reality-reference role)
- BV-SKILL-028 prologue-narrative-architecture (D014 bloodscene/catastrophe horror + responsibility beats; no-paranormal opening boundary)
- BV-SKILL-029 simse-island-systems (D015 island-system cadence: weather/isolation feeds horror frequency; threat ontology overlap)
- BV-SKILL-030 anomalous-capability-architecture (D016 capability-presentation methodology + discovery-progression Memory-Bleed separation; this skill retains authored horror CONTENT)
- SOP-006 debug-observability; developers-way (governing)