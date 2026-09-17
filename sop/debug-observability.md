# SOP-006 — DEBUG OBSERVABILITY

## Purpose
Every system must expose its internal state so diagnosing faults is a matter of reading evidence, never guessing. Debugging by speculation is prohibited.

## When Mandatory
- Every gameplay/engine system, from first implementation.
- Any investigation where behavior diverges from expectation.

## Requirements for Every System
1. OBSERVABLE STATE: internal state is exposed through a benign channel — debug overlay, inspector, or logged boundary events (transitions, signals, timer expiry, perception updates).
2. SIGNATURE-CENTERED DIAGNOSIS: because stealth is multi-channel (no `hidden = true`), observers must be able to see each channel's computed contribution (visual/audio/etc.) and why the aggregate changed — evidence, not vibes.
3. TRANSITION REASONS: state machines log the REASON for every state change (trigger id, source, value), not just the new state.
4. REPRODUCIBILITY: debug scenes/games must admit a deterministic setup (fixed seeds, fixed time, fixture states) so a reported fault can be re-run.
5. TIMERS AND PERCEPTION: bounded perception and deferred updates must expose their ticks and scheduling so "why did it react late" is answerable from data.
6. NO PRIVATE GUESSING: if a fault cannot be explained from observed state, that is a missing-instrumentation defect in the system — instrument, then diagnose. Do not invent explanations.

## Conventions
- Debug overlays: default OFF, single toggle, zero gameplay effect when on (never feed gameplay).
- Logs: one-line boundary events with timestamp, system id, and values.
- Overlay data must be readable by a human on a tablet without scrolling hacks.

## Invariants
- Every system is diagnosable without code reading under time pressure.
- No branch that exists only to silence a symptom; fix the root (Developer's Way: repair root causes).

## Stop Conditions
If a system's behavior cannot be explained from its observable state, work stops on that system until instrumentation exists.