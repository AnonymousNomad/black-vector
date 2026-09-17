---
name: gameplay-debugging-instrumentation
description: Gameplay debugging and state instrumentation — build observable systems, instrument first, diagnose from evidence not guesswork, reproducible fixtures. Load when debugging a gameplay system or when a system lacks observable state.
---

# GAMEPLAY DEBUGGING AND STATE INSTRUMENTATION (BV-SKILL-015)

## NAME
GAMEPLAY DEBUGGING AND STATE INSTRUMENTATION

## PURPOSE
Make debugging a discipline of reading evidence instead of guessing (SOP-006): systems expose internal state, state changes carry reasons, faults are reproduced in fixtures, and the diagnosis path is always instrument→observe→explain. BLACK VECTOR adds a special obligation: perception-modulated states (hallucination, conditioning disruption, psionic distortion — doctrine §22-23) are DESIGNED, so instrumentation must separate TRUE WORLD STATE from PLAYER-PERCEIVED MODIFICATION — otherwise designed horror becomes inseparable from bugs (BV-SKILL-018, BV-SKILL-019).

## WHEN TO LOAD
- Debugging any gameplay/engine behavior that diverges from intent.
- Building a new system that needs observable state.
- Any claim requiring reproducibility (repro step).

## DO NOT LOAD WHEN
- Pure code-reading/spec work where no runtime behavior is claimed.

## PRECONDITIONS
- Governing set + SOP-006 in context.
- A fault is expressed as "system's state entered X, expected Y" — not a vibe.

## GOVERNING INVARIANTS
1. OBSERVABILITY BEFOREEVERYTHING: a system with no benign window into its state is unfinished — instrumentation precedes diagnosis and precedes claiming correctness (SOP-006).
2. STATE CHANGES CARRY REASONS: every transition (state machine, stance, perception belief, memory ledger row, weapon mode) logs WHY — trigger, source, value. State without reason is not diagnosable.
3. EVIDENCE NOT VIBES: no "restart and see if it stops" debugging. If behavior can't be explained from observable state, the missing instrumentation is the bug — add it, don't theorize (SOP-006 stop rule).
4. REPRODUCIBILITY: debug scenes/games admit deterministic setup (fixed seeds/state/time); a fault that cannot be reproduced is still a fault, and the missing fixture is logged as debt.
5. ZERO-GAMEPLAY-EFFECT TOOLS: debug overlay/hotkeys never alter gameplay state. Overlay ON == gameplay identical. Violation is a blocking defect.
6. ROOT CAUSE, NOT SYMPTOM: fixes repair the cause; no branch exists only to silence an error (Developer's Way).
7. REALITY LAYER SEPARATION (project-specific): every observable carrying perception-modulated content is tagged with a layer (WORLD / PERCEIVED) and a reason. Diagnosis asks "did the world actually change, or does the player SEE something else?" — by overlay, these must answer independently (SOP-006; BV-SKILL-018).
8. THE ALLY IS AN INTENDED REFERENCE CHANNEL: the primary ally occasionally provides a "reality reference" during anomalous events (doctrine §26) — in instrumentation terms that is a diegetic debug anchor (what the world observer agrees on), but it is NEVER the overlay itself; the overlay must be real and the ally's role authored.

## WORKFLOW
1. RESTATE fault as state expectation (what state would prove the bug? what observed data contradicts intent?).
2. CHECK INSTRUMENTATION: can I see the state? If not, add instrumentation (overlay/log/query) first.
3. REPRODUCE: build/refresh fixture deterministically; capture the divergence with evidence.
4. TRACE reason-chain backward along logged transitions to the first state cause.
5. FIX root at that cause with the smallest justified change (Developer's Way).
6. RE-VERIFY: fixture passes; no symptom-suppression branch; overlay still non-invasive; record evidence.

## IMPLEMENTATION GUIDANCE
- Instrumentation primitives: boundary-event log line (timestamp, system, transition + reason), state query/hotkey, sync/async-renderable overlay fields, fixture runs that script inputs.
- Logging volume: boundary events only (one line, dense, greppable) — interior spam is noise that buries the reason.
- Use a single diagnostic namespace per system (`BV.DEBUG.` prefix) so logs/overlays are greppable as one.
- For perception/stealth: overlay shows belief tables with sources (BV-SKILL-008) — the diagnosis for "why did it see me" is a query, not a stream of luck.
- For timers (deflect windows, perception ticks, exposure): expose schedule + expiry with reason, not just "that took 2s."
- For perception-modulated states (BV-SKILL-018/019): overlay shows WORLD-truth row and PERCEIVED row side by side with the modulating reason (conditioning, psionic load, anomaly id) — a hallucinated NPC must be traceable to its authored event, not read as a ghost in the code.

## ANTI-PATTERNS
- `print()` archaeology (guessing where to print then re-running forever).
- Randomizing repro ("sometimes it notices me") without seeding/fixture.
- Debug flag that changes gameplay timing (invalidating verification).
- Fixing by retiming constants without understanding the state path.
- Commenting-out a failing branch instead of explaining it.
- Reading a designed hallucination/distortion as a bug (or worse, "fixing" it away) because the overlay lacked a PERCEIVED layer (BV-SKILL-018).

## KNOWN FAILURE MODES
- Instrumentation overhead itself disturbs timing (perception windows shift) → keep overlay/emit path cheap; clock from timestamps not wall-clock prints in hot loops.
- Overlay readability on tablet (too much in one pane) → pane per system; readable font sizes.
- Reason-logs truncated at volume (logs lost on long sessions) → rolling ring buffer; fault is reproducible in fixture, so capture is short.
- Designed ambiguity misread as a defect (a "missing NPC" that is actually authored misperception) → WORLD/PERCEIVED overlay rows must make the authored nature undeniable and greppable by event id.

## VERIFICATION
- Static: state transitions log reasons; observable-state API exists for the system in question; tools are zero-gameplay-effect.
- Behavioral (when authorized): fixture deterministically reproduces the original fault pre-fix and proves it gone post-fix with the same inputs.

## STOP CONDITIONS
If a system can't be diagnosed from state evidence, STOP diagnosing by prose — the instrumentation gap is the defect, add it before any further fix attempts.

## PERFORMANCE
- Instrumentation is included in runtime budget; hot-loop emits are gated/batched so debug never becomes the measurable cost.

## DEVICE
- Debug stress on tablet: verify overlay/tooling running on Android editor/dev build; performance instrumentation on device only.

## RELATED SKILLS
- SOP-006 debug-observability (canon requirements)
- BV-SKILL-008 tactical-ai-perception (belief overlay)
- BV-SKILL-003 third-person-character-controller (movement state reason logs)
- developers-way (governing)