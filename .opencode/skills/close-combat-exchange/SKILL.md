---
name: close-combat-exchange
description: Deflection and close-combat exchange — the READ→ENGAGE→EXCHANGE→(DEFLECT|EVADE|COUNTER|BREAK|DISENGAGE)→ADVANTAGE→FINISH|ESCAPE state vocabulary; readable, reaction-based, budget-cheap melee/engagement loop. Load when implementing or tuning close combat or deflection.
---

# DEFLECTION AND CLOSE-COMBAT EXCHANGE (BV-SKILL-010)

## NAME
DEFLECTION AND CLOSE-COMBAT EXCHANGE

## PURPOSE
Implement the EXCHANGE windows layer of close combat (deflect/counter/break/evade timing and directional reads) inside the frozen D008 architecture: doctrine §8 compact vocabulary, frozen and extended in doctrine §35-§39 — the canonical flow is COMBAT_READ → ENGAGE → EXCHANGE → (DEFLECT | EVADE | COUNTER | BREAK | DISENGAGE) → ADVANTAGE → CONTROL → RESOLUTION → RESET (BV-D033). This skill owns window mechanics/timing; the battle-state model, Control/Neural Strain, rage, reclamation gating, TK-in-CQC boundaries, and AI-facing interfaces belong to BV-SKILL-021. The loop is a readable, reaction-based, simulation-cheap engagement layer that is a real alternative, not the universal optimal tactic (doctrine §4). NO enormous combo lists — influence comes from directional/read-based exchanges, timed counters/deflections, and heavy impact, NOT from long strings (doctrine §8).

## WHEN TO LOAD
- Implementing/tuning melee, deflection, counter, break, disengage, or engagement timing.
- Reconciling combat state handoff with assassination (BV-SKILL-009).

## DO NOT LOAD WHEN
- Ranged weapon systems (BV-SKILL-011) or per-sense AI behavior (BV-SKILL-008).

## PRECONDITIONS
- Governing set loaded.
- High-level state machine separates combat from assassination (BV-SKILL-009 invariant 1).
- Animation/interaction budget model available (dynamics of exchange are timing-critical).

## GOVERNING INVARIANTS
1. The exchange window layer feeds the canonical battle-state vocabulary (BV-D033): READ/ENGAGE/EXCHANGE, then one of DEFLECT/EVADE/COUNTER/BREAK/DISENGAGE, then ADVANTAGE, then CONTROL/RESOLUTION/RESET. No combat loop invented outside this vocabulary, and no mechanics-level state invented outside the architecture owned by BV-SKILL-021.
2. The loop is reaction-based and readable: timing windows (deflect window, counter window, break window) must be learnable from the enemy's visible telegraphs, tuned by design, not hidden jitter.
3. Direct combat must exist but is NEVER the universal optimal solution (doctrine §4): cost/benefit of melee exchange vs stealth vs positioning remains a designed tradeoff, always inferior in some contexts.
4. All exchange is symmetric and observable: both player and enemy use the same state machine; every transition logged with reason (SOP-006). No invisible frames, no unfair AI reaction, no player-benefit-only swings.
5. Break/disengage are first-class escape tools: they trade posture/stamina for spacing, feeding ESCAPE/FINISH outcomes — not afterthoughts.
6. Close combat does not silently weaponize perception internals (no auto-aim reads; engage targets by affordance, not via sensing cheat).

## WORKFLOW
1. Read current combat/melee handling in current form; map it onto the vocabulary; flag any state missing.
2. Define guard windows data table (deflect/counter/break timings per attack archetype), single-sourced.
3. Implement the machine as an explicit state graph with reason logging per transition.
4. Wire telegraph emission (enemy windup → readable cue) and cost hooks (stamina/posture) on both sides.
5. Balance by design (tradeoff with stealth), then static+fixture verify (behavioral when authorized, SOP-005).

## IMPLEMENTATION GUIDANCE
- Encode attacks as telegraph frames + active frames + recovery frames from the SAME data the AI plays; windows derive from that data (single source).
- Battlefield reads are DIRECTIONAL: the exchange resolves from who is facing whom and what the attacker telegraphs — not from memorized combo dials. Deep but few attack archetypes; depth from reads and counters, not list length (influence: Absolver/Assassin's-Creed-style readable counters, doctrine §33).
- EXCHANGE bifurcation: on window, resolve DEFLECT (timed guard), EVADE (spatial), COUNTER (invokes opponent recovery); on failure → breaking postures; each path explicit.
- ADVANTAGE is a transient ownership state (who has initiative) — not a global "stunned" debuff.
- Retain same-state fairness: an enemy that can deflect must face player telegraphs too (symmetry) or the asymmetry is a designed trait (e.g., elite) — document it.
- Keep close combat cheap: no per-frame physics solve; windows are timer-based, sampled at discrete events (SOP-004).
- Close-combat targets may include former Hidden Hand members with their OWN abnormal capabilities (doctrine §27) — those are character encounters whose exchange rules honor the vocabulary but carry narrative consequence (doctrine §34).

## ANTI-PATTERNS
- Mini-game metronome hidden inside the deflect window (unlearnable timing).
- "Instant success" branch where deflection always wins fights regardless of cost — breaks doctrine §4.
- States invented ad-hoc (e.g., "CLASH that skips the vocabulary").
- Converting the machine into per-frame state soup inside a single tick function.
- Making evasion a strict superset of deflection (one window always wins) — trades off stamina/spacing by design.
- 40-attack combo lists — violates doctrine §8 (NO enormous combo lists).

## KNOWN FAILURE MODES
- Deflect window too tight → melee unusable, players forced to stealth (detected-fail pressure) — retune windows AND costs, not just windows.
- Counter stun-lock loops (player can grind any enemy into forever-Counter) — ADVANTAGE budgets/exhaustion.
- Telegraph invisible on tablet draw (enemy action missed) — device-validated visual clarity (BV-SKILL-014).

## VERIFICATION
- Static: states ∈ canonical vocabulary; windows data-driven; symmetry rule present; reason logging per transition.
- Behavioral (when authorized): fixture script plays scripted telegraphs; assert window outcomes match table; break/disengage matrix outcomes; cost effects on stamina/posture.

## STOP CONDITIONS
If an exchange outcome cannot be explained by its state + window data, or combat becomes universally optimal, stop — the machine or balance is broken.

## PERFORMANCE
- All exchange logic event-sampled; no per-frame solve storms (SOP-004). Verify on tablet with population in area.

## DEVICE
- Timing and visibility are tablet-validation-critical (frame-rate variance affects felt windows — check at 60 and 90Hz frames budget).

## RELATED SKILLS
- BV-SKILL-021 cqc-combat-architecture (frozen battle-state/range model; Control/Strain/rage consumers of window outcomes)
- BV-SKILL-009 contextual-assassination (combat vs assassination separation)
- BV-SKILL-008 tactical-ai-perception (reaction sourcing)
- BV-SKILL-011 weapon-handling-ballistics (ranged alternative; tradeoff balance)
- SOP-006 debug-observability; developers-way (governing)