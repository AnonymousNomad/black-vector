---
name: contextual-assassination
description: Contextual assassination — the distinct UNSEEN→POSITION→OPPORTUNITY→ASSASSINATION state of play, separate from combat; mechanical context resolution (drop assassination), player intent, and consequence. Load when implementing or reasoning about assassinations.
---

# CONTEXTUAL ASSASSINATION (BV-SKILL-009)

## NAME
CONTEXTUAL ASSASSINATION

## PURPOSE
Own the assassination state of play — UNSEEN→POSITION→OPPORTUNITY→ASSASSINATION (doctrine §7) — as a distinct system from combat, with position-aware contextual resolution (including the future drop-assassination arc and butterfly-knife-distance work), clear player intent gating, and causal consequence. Assassinations can target former Hidden Hand brothers — those are CHARACTER EVENTS with narrative weight, never generic boss fights (doctrine §27). NO simplification into "death animation on stagger."

## WHEN TO LOAD
- Implementing or tuning assassination mechanics, contextual prompts, or the position→opportunity resolution.
- Reconciling assassination vs combat state handoff.

## DO NOT LOAD WHEN
- Stealth sensing internals (BV-SKILL-007/008 own those).
- Deflection/equipment close combat (BV-SKILL-010).

## PRECONDITIONS
- Governing set loaded.
- Stealth emission + AI perception symmetric contract exist (BV-SKILL-007/008) — assassination reads DETECTED/UNSEEN state from perception, not from a world-omnipotent flag.
- A second state machine (STATE) exists: assassination is one high-level state; combat another (doctrine §7).

## GOVERNING INVARIANTS
1. Assassination and combat are DISTINCT states with distinct input, camera, and consequence (doctrine §7). They never share one loop with a boolean.
2. Resolution is contextual and observable: from a position+state, an OPPORTUNITY exists when (a) UNSEEN status is established by perception (belief model, not world truth), (b) positional/engagement geometry matches the allowed context set (vantage, ledge, drop, stealth-close), (c) the player expresses intent through a contextual prompt within a fair window.
3. UNSEEN is a belief-state fact (the target's perception does not currently hold a real-time belief of the player), NEVER `player.hidden == true` (Pillar 2, doctrine §6).
4. Position→opportunity mapping is explicit and legible: a small set of context resolvers (stealth close, ledge drop, hang drop, vault drop, environmental) with guard conditions; each resolvable case is listed — no hidden magic.
5. Psionics (doctrine §21) may EXPAND the resolvers (restraint/interruption creates a distinct opportunely-placed state; knife recall changes which tools conclude) — they multiply positioning options, they never replace the UNSEEN/opportunity gate and never bypass the belief model.
6. Impact/consequence is causal and remembered (Pillar 3): the assassination is an event the world can know about (sound, visual, body, investigation) — silence is a designed outcome (muffled/behind-cover rules), never a default.
7. Former Hidden Hand targets: assassinating "a brother" is a character event — consequence must include the narrative pillars (IDENTITY / BROTHERHOOD / RESPONSIBILITY, doctrine §34), and alternative outcomes (spare/break/recruit where the fiction allows) are designed, not glued on.
8. Future arc: tree drop-assassination attaches through the same context resolver (branch/vantage + descend) — design resolvers so the arc slots in without a rewrite (doctrine §5).

## WORKFLOW
1. Read current position/intent/consequence handling in current form.
2. Confirm distinct state machine separation (assassination vs combat) and the belief-based UNSEEN source.
3. Define resolver set + guard table (geometry, tags, perception belief, intent window).
4. Define consequence emission (sound, body, investigation hooks) per context grading.
5. Static verify; behavioral/device verify when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Prompt: diegetic contextual affordance (subtle, world-integrated) appearing only with a real opportunity; intent = player confirms within window; cancel is cheap.
- Guard table example fields: source (ledge/vantage/branch/vault/close), target-facing, distance/height range, UNSEEN-belief freshness, surface tag.
- Consequence: emit an "assassination event" the world subscribes to — witnesses investigate (sensing triggers from BV-SKILL-008), silent bodies stay worlds-remembered (detection-free does NOT mean consequence-free).
- Keep camera language distinct from combat: assassination camera (tight positioning), combat camera (exchange framing) — change is state change, logged with reason.

## ANTI-PATTERNS
- `if hidden: kill()` — any hidden-flag coupling (doctrine §6).
- Assassination as a stagger animation with instant win (no position/state/legality).
- Reading the player's true position into target-facing math without belief gating — cheating perception (BV-SKILL-008 invariant 1).
- One "assassinate" button in every context including mid-combat (violates state separation).
- Dropping the tree arc as a special case (“if on branch …”) instead of a resolver entry.

## KNOWN FAILURE MODES
- Opportunity triggers while DETECTED (belief not fresh) → guard on belief freshness.
- Resolver geometry drifts from mesh (ledge height mismatch vs collider) → device-validated fixture.
- Consequence skipped "for fun of flow" → consequence is pillar; report future-work explicitly.

## VERIFICATION
- Static: assassinate path only reachable via resolver guard + intent; UNSEEN belief-sourced; consequence subscription present.
- Behavioral (when authorized): each resolver case executes/denies per guard at fixture; DETECTED hard-blocks; drop arc attaches to branch resolver.

## STOP CONDITIONS
If assassination and combat cannot be cleanly separated, or UNSEEN ever depends on a hidden-flag, stop — the state design is wrong.

## PERFORMANCE
- Resolver cost nil (guard checks only on contextual prompt vote). Consequence events are subscriptions, bounded by observer count.

## DEVICE
- Prompt readability and touch-target size validated on tablet; contextual affordance must be clear at field-of-view.

## RELATED SKILLS
- BV-SKILL-007 stealth-and-concealment / BV-SKILL-008 tactical-ai-perception (belief-sourced UNSEEN)
- BV-SKILL-005 systemic-traversal / BV-SKILL-006 environmental-affordances (ledge/branch/vantage resolvers)
- BV-SKILL-010 close-combat-exchange (the DETECTED branch)
- SOP-006 debug-observability; developers-way (governing)