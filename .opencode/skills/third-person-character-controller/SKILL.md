---
name: third-person-character-controller
description: Third-person character movement on CharacterBody3D — physics-driven locomotion, camera rig, input handoff, and the velocity/grounding correctness contract. Load when building or reasoning about player character movement.
---

# THIRD-PERSON CHARACTER CONTROLLER (BV-SKILL-003)

## NAME
THIRD-PERSON CHARACTER CONTROLLER

## PURPOSE
Provide correct, predictable, physics-correct third-person locomotion on a CharacterBody3D with a composed player body (Movement/Stance/Interaction/SignatureEmitter roles), producing believable locomotion and a clean movement-signature channel.

## WHEN TO LOAD
- Building, extending, or debugging the player character's movement and camera.
- Defining how input feeds movement (touch on tablet).

## DO NOT LOAD WHEN
- Stealth/perception or combat systems (those load their own skills; this skill owns locomotion only).
- Static data work unrelated to a body.

## PRECONDITIONS
- Governing set loaded.
- Scene composition reviewed (BV-SKILL-002) if the body scene already exists.
- Input actions exist in the InputMap (see look/touch conventions in the project docs) before wiring handlers.

## GOVERNING INVARIANTS
1. Velocity is expressed in m/s and assigned to `velocity` before `move_and_slide()`; NEVER integrate by `width*delta` into a separate motion vector (the CharacterBody3D contract is velocity-per-physics-tick, not position delta).
2. Locomotion runs in `_physics_process` (fixed timestep), not `_process`.
3. Grounding is authoritative via `is_on_floor()` / `is_on_wall()` / `is_on_ceiling()`, with `floor_max_angle` (default 45°) matched to what the world considers walkable slope. `get_floor_normal()` is the floor normal, NOT necessarily the surface normal — do not treat them as interchangeable.
4. Movement is split by responsibility: Movement node (locomotion), Stance node (stance/mode → speed), SignatureEmitter node (sound/motion signature for perception; see stealth skill). The body composes these; none silently controls another.
5. Camera is a designed rig (follow, aim offset, obstruction handling), not an afterthought node bolted on.
6. Input: continuous actions polled with `Input.is_action_pressed` in `_physics_process`; discrete actions via `_input`/`InputEventScreenTouch`/`InputEventScreenDrag` events. Touch events map: screen-touch ≈ mouse click, screen-drag ≈ mouse motion.
7. Every movement state change (stance/angle/speed) is logged with reason (SOP-006).

## WORKFLOW
1. Read the body scene and current movement script in current form (SOP-003).
2. Identify the four composed roles and confirm ownership boundaries.
3. Implement/verify locomotion math: acceleration, friction, airborne control, grounding.
4. Wire input actions → Movement intent, and Movement → SignatureEmitter emission.
5. Static verify (parse, references); runtime verified ONLY when a running engine is authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Use `motion_mode` GROUNDED for humanoid; FLOATING only for physics-cheap or non-humanoid bodies.
- Tune `floor_snap_length`, `floor_stop_on_slope`, `floor_block_on_wall`, `max_slides` (default 6) deliberately; don't accept the last default you saw.
- Split move input into normalized direction from the camera-relative forward/right axes (yaw-only; never off-axis lock-on unless designed).
- Stance speed table lives in a Resource (stances.speed_*), owned by the Stance node — single source of truth.
- Keep camera obstruction resolution cheap (raycast against a mask); avoid per-frame scene queries elsewhere.
- Desired velocity from input; apply gravity manually or via `velocity = last_velocity + gravity * delta` pattern; then `move_and_slide()`.

## ANTI-PATTERNS
- `position = position + x * delta` (or `velocity*delta` pre-move) — breaks collision/sliding semantics and the CharacterBody3D contract.
- Reading `get_floor_normal()` for slope visuals/edges without checking `is_on_floor()`.
- God-object player script owning movement+stance+camera+interaction (violates composition invariant).
- Camera-relative movement ignoring stance speed caps.
- Polling mouse-like buttons for touch in `_input` and also in `_process` (double-handling).

## KNOWN FAILURE MODES
- Sliding on start/end of slopes from `floor_max_angle` mismatch → tune angle per world material set; verify with fixtures.
- "Stuck" at walls from floor_block_on_wall/wall_min_slide_angle mis-tuned → inspect contact via `get_slide_collision`.
- Touch look jitter/sway from screen-drag deltas applied per-frame without sensitivity scaling on tablet DPI → use normalized deltas and fixed sensitivity.

## VERIFICATION
- Static: parser-clean; velocity contract correct (no delta-integration); composition roles hold; stance→speed resource traced.
- Behavioral (when authorized to run): floor/wall/ceiling gating correct on a test slope scene; stance speed deltas applied; signature events match locomotion state.

## STOP CONDITIONS
If locomotion behavior diverges from intent and the cause is not visible in observable state (SOP-006 instrumentation), stop and add instrumentation before modifying further.

## PERFORMANCE
- Move queries are per-body cheap; budget camera raycasts and per-frame lookups; no per-frame world-wide searches.

## DEVICE
- Touch input calibration must be validated on the tablet; DPI/sensitivity differs from desktop.

## RELATED SKILLS
- BV-SKILL-004 stance-system (stance/mode speed source)
- BV-SKILL-005 systemic-traversal (climb/mantle surfaces at edges)
- BV-SKILL-007 stealth-and-concealment (movement signature channel)
- SOP-006 debug-observability; developers-way (governing)
- BV-SKILL-036 touchscreen-input-architecture (D026 — touch/controller/KBM layers map onto this skill's abstract actions; this skill retains movement/camera/input-handoff simulation; composition)