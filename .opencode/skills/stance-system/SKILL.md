---
name: stance-system
description: The stance/locomotion-state system (stand, crouch, prone, sprint) — mode-owned speed/height/collision, transitions with reason, and how each stance changes the player's signature channel. Load when implementing or tuning stances.
---

# STANCE SYSTEM (BV-SKILL-004)

## NAME
STANCE SYSTEM

## PURPOSE
Own the player's standing/crouching/prone/sprinting states as real, observable mode states that change locomotion, collision profile, and movement signature — not cosmetic animation flags.

## WHEN TO LOAD
- Implementing or tuning stances, stance transitions, stance-derived speed/height.
- Reasoning about how a stance affects detection (signature) or traversal (surface heights).

## DO NOT LOAD WHEN
- General locomotion math (use third-person-character-controller).
- Perception internals (stealth-and-concealment owns the channel calculations).

## PRECONDITIONS
- Governing set loaded.
- Controller body and its roles understood (BV-SKILL-003).
- Stance data resource (`stances.speed_*`, height) decided and single-sourced.

## GOVERNING INVARIANTS
1. Stance is a first-class mode state owned by a dedicated Stance node. It is not a boolean on the controller, not an animation blend value, and not a camera trick.
2. Each stance has: movement speed (and sprint booth), capsule height/collision extents, id-able signature multiplier (sound + silhouette + visual), and a transition rule set. Prone is not "crouch while hidden."
3. Transitions are explicit and gated by validity (space, current state, intent). Each transition logs a REASON (SOP-006).
4. Stance data lives in a Resource (single source of truth); gameplay logic never hardcodes per-stance numbers scattered across scripts.
5. Stance always affects the signature channel deterministically: the same stance + same conditions → same signature contribution. No binary hidden-flag here either (doctrine §2).
6. A stance is a tool: it trades speed/collision for signature/concealment. Tradeoffs are the design, not a bug.

## WORKFLOW
1. Read current stance handling in its current form.
2. Define the stance table (stand/crouch/prone/sprint): speed, capsule height/radius, transition legality, signature factor.
3. Implement transitions as a small explicit machine (states + guards), each transition emitting a reason.
4. Wire speed/height consumption and signature emission (controller and stealth respect the same table).
5. Static verify; runtime verify only when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Default stance: STAND. Sprint is a mode of stand (from-a-stand fast state) with its own signature cost, not a separate posture.
- Capsule height changes with stance; check clearances on stance change (headroom test) before committing.
- Crouch should change avatar height AND camera height AND collision; prone more so.
- Provide stance-change intent from input (discrete event); never let stance flip as unintentional side effect.

## ANTI-PATTERNS
- `if crouching:` god-check spread across 6 scripts instead of a Stance node.
- Stance as a camera-only tweak (collision unchanged).
- Hiding partial in prone with no signature consequence.
- Transitions without legality checks (crouch under low ceiling clipping into walls).
- Hardcoded magic speed numbers duplicated between controller and stealth.

## KNOWN FAILURE MODES
- Standing into an overhead cover and clipping — headroom check missing on transition.
- Proning in an open field silently granting invisibility — signature channel still sees you (doctrine §2).
- Sprint + stance race conditions — one owner per state, transitions serialized in one machine.

## VERIFICATION
- Static: one stance owner; table single-sourcer; transitions explicit with reason logging.
- Behavioral: fixture walkthrough of each legal/illegal transition under running engine (when authorized); signature contribution asserted per stance.

## STOP CONDITIONS
If a stance produces an unintended gameplay consequence (e.g., free invisibility or impossible boundary), stop — it indicates a signature or transition-contract bug.

## PERFORMANCE
- Stance changes are discrete; cost is negligible. Avoid per-frame stance polling loops everywhere.

## RELATED SKILLS
- BV-SKILL-003 third-person-character-controller (consumes stance speed/height)
- BV-SKILL-007 stealth-and-concealment (signature factors per stance)
- BV-SKILL-005 systemic-traversal (stance × surface height interplay)
- SOP-006 debug-observability; developers-way (governing)
- BV-SKILL-036 touchscreen-input-architecture (D026 — stance chain (crouch/prone) exposed on the touch movement stack; this skill retains stance state mechanics; composition)