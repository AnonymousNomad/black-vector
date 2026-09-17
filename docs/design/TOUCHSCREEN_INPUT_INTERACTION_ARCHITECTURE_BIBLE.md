# BLACK VECTOR — TOUCHSCREEN INPUT, MOBILE CONTROL LAYOUT & INTERACTION ARCHITECTURE BIBLE

> Directive-026 deliverable. INPUT / CONTROL-LAYOUT / INTERACTION ARCHITECTURE ONLY. Not implementation,
> not code, not Godot/engine work, not UI art, not production file modification. Primary model: Big Pickle
> (per user routing; the directive's "MiniMax M3" attribution is again disregarded this session).
> Authority: THE DEVELOPER'S WAY -> doctrine -> SOP -> skills -> D004 §10 (tablet budgets) -> D010 visual ->
> D011 ecology -> D015 substrate -> D016 anomaly -> D017 persistent state + reclamation (quick radial) ->
> D018 campaign spine -> D019 visual production (camera / helmet / HUD-as-equipment) -> D020 vertical-slice
> specification -> D021 combat architecture -> D022 AI / faction / enemy architecture -> D023 companion /
> relationship / Shade reclamation -> D025 operator identity (action priority list) -> this document.
> Purpose: translate an operator's hands, equipment, and decisions into a touchscreen interface.
> The goal is NOT "a mobile control scheme." The goal is: **the touchscreen is an extension of the
> operator's body.** One simulation layer. Different input layers.
> SYSTEM LAW vs CANDIDATE CONTENT strictly separated (D026 §15).
> GAME IMPLEMENTATION STARTED: NO.

---

## 1. Binding context & canon consumed

- Inspected: doctrine §5 (Environment — world as interface), §6 (Stealth Doctrine — no stealth mode),
  §10 (Platform and Renderer Decision — Android tablet first; GL Compatibility; BV-D001), §29 (Opening
  Structure), §33 (Design References — reference games inform specific areas; never copied), §34
  (Narrative Pillars).
- D004 §10 edge-device budget (Android/tablet target; GL Compatibility; <1,200 active nodes per sector;
  ~200–260 MB working set; no renderer change).
- D008/D009 CQC doctrine (BV-SKILL-021 — CONTACT state model, SPATIAL ranges, minimal physical systems).
- D013 weapons + Layered Overwatch (weapon families; the psionic weapon boundary BV-D070).
- D015 substrate (BV-D079..D086; §6 survival decisions, §9 cold, §12 shelter, §14 weather, §25
  navigation, §30 fairness law, §45 HUD ownership).
- D016 anomaly (BV-D087..D095; §7 five-phase discovery, §4 Neural Strain bands, §5 Control × Strain 2×2,
  §17/§18 firearms + projectile correction, §19 perceptual acceleration, §27 CQC integration, §41–§45
  presentation, §48 prevention matrix, §49 Season-1 ceiling).
- D017 persistent state + reclamation (BV-D096..D104; §18 quick presentation radial — MAX 6 SLOTS;
  §19 base-grooming facilities; §53 accessibility overrides).
- D018 campaign spine (BV-D105..D113; §55 mission taxonomy).
- D019 visual production (BV-D114..D122; §3 camera system — 3P shoulder + FP precision + transitions +
  weather/injury effects; §4 helmet / visor three-layer; §5 HUD-as-equipment; §6 survival HUD; §11 weather
  presentation; §14 animation priority tiers; §16 tablet performance law).
- D020 vertical-slice specification (BV-D123; §4.9 technical requirements — UI / HUD surfaces).
- D021 combat architecture (BV-D124; §3 7-step loop; §4 player combat model; §6 injury integration).
- D022 AI / faction / enemy architecture (BV-D125; §3 AI perception state machine; §5 archetypes).
- D023 companion / relationship / Shade reclamation (BV-D126 + BV-D127; §8 companion rules — NOT a summon;
  limited commands; the Shade remains a person).
- D025 operator identity / military discipline / combat expression (BV-D130; §9 ACTION PRIORITY list —
  movement / aiming / stealth / interaction / equipment / companion commands / grooming / anomaly
  control — "informs D026").
- Existing project direction (README): tablet touch HUD maps to the SAME `InputMap` action vocabulary
  already declared in `game/project.godot` (22 actions include stance, tactical profiles, interact,
  CQC attack/guard, debug overlay); screen-drag maps to the camera rig look function. D026 preserves
  this direction and freezes it as the input abstraction law (§13).
- Skills reviewed: BV-SKILL-001 godot-android-edge; BV-SKILL-002 scene-composition; BV-SKILL-003 third-
  person-character-controller (movement, camera rig, input handoff); BV-SKILL-004 stance-system; BV-SKILL-005
  systemic-traversal; BV-SKILL-006 environmental-affordances; BV-SKILL-007 stealth-and-concealment; BV-SKILL-008
  tactical-ai-perception; BV-SKILL-009 contextual-assassination; BV-SKILL-014 mobile-graphics-atmosphere; BV-SKILL-021
  cqc-combat-architecture; BV-SKILL-032 visual-presentation-architecture (HUD-as-equipment; camera; quick
  radial ownership in D017); BV-SKILL-035 operator-discipline-architecture (action priority list).

## 2. Preserved canon — DO NOT REOPEN OR REWRITE (frozen)

- **No lobby. No menu-driven gameplay loop. The player enters directly into the island. The world is the
  interface** (doctrine §5 / §31; BV-SKILL-013 concealed transitions; D026 §2 frozen).
- **The player controls The Hand:** Overwatch Reconnaissance Operator (scout sniper foundation, stealth
  specialist, survival operator, anomaly-adapted human) — D025 / BV-D130 preserved.
- **Combat is decision-based, not button-combo-based** (doctrine §35.1; BV-SKILL-021 invariant 3; D021
  §2 / §4). The touchscreen does NOT create combos or action bars.
- **Stealth is physical behavior, not a mode** (doctrine §6; BV-SKILL-007 — no `hidden = true` anywhere).
- **The HUD belongs to equipment, not to the player's videogame overlay** (D019 §5; D015 §45). The
  touchscreen controls DO NOT become a floating HUD.
- **Controls never override the fairness law** (D015 §30): input remains trustworthy; saving remains
  trustworthy; critical HUD state remains functionally trustworthy; bugs are never mimicked. Where D026
  degrades interaction under Neural Strain (D026 §7), it degrades the EFFECT and the PERCEPTION, never
  the control channel itself (§7.4 frozen reconciliation).
- **Tablet baseline: Android tablet + GL Compatibility renderer** (BV-D001; D004 §10; D019 §16). Touch is
  the primary input layer; Bluetooth controller and keyboard/mouse are supported layers; the simulation
  layer never learns which one the player uses.
- **One simulation layer. Different input layers** (the directive's own law — §13).

---

## 3. Control philosophy (frozen — D026 §1)

> **"Minimum input, maximum intent."**

Every control must answer: **What does the operator need to do right now?**

### 3.1 Rejected patterns (frozen)

- virtual button clutter (fifteen buttons because "mobile games have buttons")
- MMO-style action bars (ability grids, cooldown rows, combo ranks)
- floating ability wheels everywhere (a wheel on every gesture)
- console ports copied directly to mobile (shoulder buttons mapped to touch corners)
- stealth modes / aim-assist magic / auto-play affordances dressed as controls

### 3.2 Accepted patterns (frozen)

- dual-thumb foundation (movement left, camera/aim right) — the industry-proven base that does not
  break immersion
- minimal combat cluster (small, adjustable, movable, never a bar)
- ONE primary contextual action surface (context reduces button count by MEANING, not by hiding)
- diegetic prompts (world-space, wrist-device, helmet-passive) — never giant floating callouts
- gesture interaction for the anomaly layer (hold / select / pull — §7), never an ability menu
- every control: adjustable size, adjustable opacity, movable, controller-supported (§4 / §12)

### 3.3 The operator extension law (frozen)

> **The touchscreen is an extension of the operator's body.**

- The control surface mirrors The Hand's learned behaviors: he observes before he acts (minimal UI
  until intent), he moves with discipline (analog, pressure-sensitive movement), he acts with precision
  (a small committed action set), and he manages himself (equipment, strain, presentation) through the
  SAME in-world objects the game already uses (wrist device, helmet, kit).
- A control that would not exist on the operator's body or kit is suspect. A control that duplicates an
  in-world object's function is redundant.
- Reduced-immersion controls (large floating labels, magic confirm buttons) are LAST-RESORT accessibility
  affordances, not default layout (§12).

### 3.4 Rareness discipline (frozen)

The control surface must stay legible under stress and on a tablet screen held in two hands. Frozen
budget: the player should never see more than a small fixed set of on-screen touch zones at one time
(core cluster count frozen in §5.2; anomaly and companion layers appear ONLY when their systems are
active). If a new control needs a permanent home on screen, an existing one must be absorbed or
contextualized first (same discipline as D017 §13 anti-tedium).
# — CONTINUED: PART B — MOVEMENT, CAMERA / AIM, CORE BUTTONS, CONTEXTUAL ACTIONS —

---

## 4. Movement architecture (frozen — D026 §2)

### 4.1 Left thumb — primary movement stick (frozen)

- ANALOG movement (magnitude = speed + noise; the movement stick is a signature channel source —
  BV-SKILL-007 coupling).
- ADJUSTABLE SIZE (small/medium/large; scaling extends to XL accessibility).
- ADJUSTABLE POSITION (free placement within the left-third region; left-handed mirroring supported —
  §14).
- TRANSPARENCY SETTINGS (opacity slider; a fully invisible stick with tap-to-reset is a CANDIDATE
  option for expert players).
- ZERO-SNAP ZONE (dead zone; separately adjustable).
- LEFT-HANDED OPTION (whole-layout mirror: movement on the right, camera on the left).

### 4.2 Movement states (frozen)

```
WALK       — low signature; slow; the operator's default in danger
JOG        — standard movement; moderate signature
SPRINT     — high signature; stamina drain; not available from crouch/prone (BV-SKILL-004)
CROUCH MOVEMENT — reduced signature + reduced height; slower; headroom rules apply (BV-SKILL-003/004)
PRONE MOVEMENT  — lowest signature; slowest; the operator's lowest profile (BV-SKILL-004)
```

Movement states are PHYSICAL behaviors (doctrine §6 — no stealth mode). The touch layer exposes the
STATE TRANSITIONS; the character executes them (BV-SKILL-021 invariant 3 ownership split).

### 4.3 Movement must support (frozen)

- STEALTH SPEED CONTROL — analog magnitude + crouch/prone + tactical profile (SILENT / NORMAL /
  AGGRESSIVE — existing project actions preserved) determine noise/signature; the player learns to move
  QUIETLY by using the control, not by toggling a menu.
- INJURED MOVEMENT — leg wounds alter pace, stance recovery, and signature (D015 §13; D017 §36
  animation-evolution; the controller consumes the injury state).
- EXHAUSTION — EXERTION band drains sprint availability and adds sway (D015 §7).
- TERRAIN EFFECTS — snow depth, ice, mud, water, slopes (D004 §7 / §9; D015 §14). The analog stick
  preserves the FEEL of terrain resistance through movement response, not through a popup.

### 4.4 Traversal actions (frozen)

- JUMP / MANTLE / VAULT / CLIMB remain the system's authored affordances (BV-SKILL-005;
  BV-SKILL-006 expectation doctrine) exposed on a small number of touch surfaces.
- The CONTEXTUAL ACTION surface (§7) covers CLIMB / MANTLE / VAULT when the affordance is nearby —
  context reduces the button count.
- A dedicated JUMP control exists (movement-adjacent tap zone; adjustable) because jump is frequent and
  context should not own frequent verbs.

### 4.5 Movement-during-combat (frozen — D021 invariant: locomotion agency preserved)

- The player NEVER loses locomotion agency to a script (BV-SKILL-021 invariant 2). The touch movement
  stick stays live during exchanges, aim, crouch, and CQC.
- STRAFE-WITH-AIM: while aiming, the movement stick produces strafe + slow advance/retreat at reduced
  speed (standard operator behavior; no lock).
- GRAPPLE RANGE: in CLINCH (BV-SKILL-021 SPATIAL), movement input becomes struggle-direction input; the
  contextual surface offers the authored counters (break / pin / disengage) — the input question stays
  "what is the operator doing," not "which combo."

---

## 5. Camera / aim architecture (frozen — D026 §3)

### 5.1 Right thumb — primary camera control (frozen)

- FREE LOOK (touch-drag; sensitivity curves; separate hipfire / aim / scope sensitivity settings).
- AIMING (see §6 core buttons; aim entry reduces sensitivity and narrows FOV per D019 §3).
- PRECISION AIMING / SCOPE TRANSITION (scope = a deeper zoom state with dedicated sensitivity;
  breathing-control support — composes with D025 §7 sniping techniques: BREATHING CONTROL).
- SHOULDER SWAP (left/right shoulder camera offset — a bounded tap control near the camera cluster;
  composes with D019 §3 shoulder behavior).
- CAMERA-ASSIST vs PLAYER-ASSIST distinction: the camera rig's authored behaviors (auto-frame on aim
  entry, collision avoidance) are SIMULATION behaviors; touch-side assists (sensitivity smoothing) are
  INPUT behaviors. The simulation never gains knowledge from the input layer (§15 input abstraction law).

### 5.2 View modes (frozen)

- THIRD PERSON — primary exploration / combat camera (D019 §3.1).
- FIRST PERSON — precision aiming, helmet/visor moments, psychological events, immersion moments
  (D019 §3.2). FP preserves hands / sleeves / gloves / hair / breath / dirt / blood / equipment.
- HELMET VIEW — passive-layer helmet readings (D019 §4.1) overlay the current view; tactical-layer
  activation is an OPT-IN action (D026 §7 / §13) with signature cost; the anomalous layer arrives late
  and stays authored (D019 §4.3).

### 5.3 Reference evaluation (frozen — D026 §3 evaluate-and-combine)

The directive asks to evaluate two reference styles and determine what combines best. Per doctrine §33
(reference games inform specific AREAS; protectable content is never copied; no feature soup), the
evaluation is scoped and the COMBINATION is frozen as an original layout:

- **King's Road-style reference — clean combat buttons + contextual actions.** Take: the discipline of a
  SMALL committed combat cluster, and the strength of a single contextual action surface that changes by
  situation. This matches BLACK VECTOR's decision-based combat (D021 §2) and "minimum input, maximum
  intent" (§3).
- **Delta Force mobile-style reference — tactical FPS touchscreen layout.** Take: the dual-stick tactical
  foundation, aim/fire separation, crouch/lean support, and responsive look ergonomics expected by mobile
  FPS players. This matches the operator fantasy (D025) and the stealth/aim loop (D019 §3).
- **Frozen combination (original):** dual-thumb foundation + minimal combat cluster + ONE contextual
  action surface + diegetic prompt layer + gesture-only anomaly layer + adjustable-everything layout.
  NOT a copy of either reference; an original layout for an original game (doctrine §33; BV-D042-analog
  originality boundary for UI).

### 5.4 Camera control and the operator's body (frozen)

- The camera is NOT an invisible floating lens in FP (D019 §3.2). The touch layer NEVER adds a
  free-fly camera; the camera belongs to the body and the body obeys stance / injury / suppression.
- Camera kick (recoil), camera breathing (exertion), and camera weight (injury/cold) are SIMULATION
  behaviors surfaced through the same input layer (§15).

---

## 6. Core combat buttons (frozen — D026 §4)

### 6.1 The minimum set (frozen)

```
FIRE            — the primary combat action (hipfire or aim)
AIM             — aim entry / exit (toggle-aware; hold-or-toggle settable per player)
RELOAD          — reload / magazine management (weapon state per D017 §29 / D013)
CROUCH          — crouch state (movement-adjacent; not a separate "combat" button cluster member)
INTERACT        — the CONTEXTUAL ACTION surface (§7; this is ONE button with many meanings)
WEAPON SWAP     — primary ↔ sidearm (bounded; the kit is small — doctrine §4 starting lock)
MELEE           — knife / buttstroke / clinch entry (CQC integration per BV-SKILL-021)
DEFENSIVE MOVE  — dodge / evade / break (one committed defensive action; BV-SKILL-021 defensive choice)
```

Frozen rules:
- This is the TOTAL core cluster. No combo strings, no ability buttons, no grenade-wheel (throwables
  live in the equipment layer, §10), no stance-dance buttons.
- CROUCH and PRONE: crouch is a core button; PRONE lives one layer deeper (movement long-press / stance
  chain: tap = crouch, hold = prone) so the standing surface count stays minimal. The stance chain
  composes with BV-SKILL-004 stance transitions (feet → crouch → prone).
- FIRE and AIM are SEPARATE surfaces (aim/fire separation per §5.3 reference evaluation). Aim is
  toggle-aware so a player may aim, release, adjust, and fire without holding two touches.
- LEAN / PEEK (stealth postures, §8) appear CONTEXTUALLY at corners/cover edges; they are not permanent
  buttons.

### 6.2 Placement law (frozen)

- Combat cluster: right side, thumb-reachable arc; FIRE is the largest target; all sizes adjustable.
- Movement stack: left side; stance chain + jump-adjacent; all sizes adjustable.
- CENTER on the lower edge is kept clear — no controls where the tablet grip lives; no controls where
  the world's center-of-interest lives.
- Placement is MIRRORED for left-handed players (§14).

### 6.3 Every button must have (frozen)

```
adjustable size       (touch target 44pt-equivalent minimum → XL)
adjustable opacity    (10%–100%, remembered per control)
movable layout        (free reposition within the player's saved layout profile)
controller support    (the same ACTION is bound to a controller button when a controller is present)
tap-or-hold options   (for aim / crouch / sprint where hold fatigue matters)
haptic options        (on/off; per-control intensity band)
```

### 6.4 Contextual button-crowd prevention (frozen)

When two contexts collide (near enemy AND near door), the CONTEXTUAL ACTION surface resolves by
PRIORITY (combat > interaction: the operator's safety first) and the world-space prompt shows BOTH
affordances as two small icons (tap the desired one). No hidden modalities. No accidental interactions.

---

## 7. Contextual action system (frozen — D026 §5)

### 7.1 ONE surface, MANY meanings (frozen)

The contextual action surface changes meaning by CONTEXT. This is the primary button-count reducer
(§3.1: minimum input, maximum intent).

Context table (frozen):

| Context | Contextual action becomes |
|---|---|
| Near object (door / container / panel / cache) | OPEN · SEARCH · REPAIR · USE |
| Near climb affordance (BV-SKILL-006 tags) | CLIMB · MANTLE · VAULT |
| Near a body (human / animal) | DRAG BODY · SEARCH · IDENTIFY |
| Near a wounded person (ally / community / enemy) | STABILIZE · TREAT · CARRY |
| Near enemy (stealth resolve) | TAKEDOWN · RESTRAIN · KNOCK OUT (BV-SKILL-009 contextual assassination) |
| Near enemy (after resolve) | INTERROGATE (bounded; D022 §3.4 negotiation/psychology compose) · HIDE |
| Near companion (D023) | the companion gesture layer (§11) |
| Near vehicle / boat / winch | BOARD · RELEASE · SECURE |
| Near presentation surface (mirror / wash / locker) | the presentation action (§12) |

### 7.2 Context resolution law (frozen)

- The contextual surface shows the CURRENT top action as a small diegetic glyph plus an optional label.
- The action LOCK is on PRESS-DOWN: the meaning that existed when the player pressed is the meaning
  that executes. If the context changes mid-press (enemy moves away; door closes), the action CANCELS
  SAFELY — no mis-execution, no accidental door-open-instead-of-takedown (fairness; D015 §30). This is
  the CONTEXT-LOCK LAW.
- Context never cycles automatically without player input. No auto-context surprises.

### 7.3 Prompt layer (frozen)

- Prompts are DIEGETIC: world-space markers that belong to the object (a wrist-device pulse; a helmet
  passive edge light; a subtle in-world affordance glow bounded by BV-SKILL-006 expectation tags).
- Prompts are ONE-SHOT INTELLIGENCE: a prompt appears, reads, and fades; it does not cluster.
- A prompt that has been read does NOT re-prompt until meaningful state changes (anti-tedium;
  D017 §13 discipline applied to input).
- Accessibility alternate prompts (§14) exist; the default prompt layer is minimal.

### 7.4 Interaction ranges (frozen)

- Context is RANGE-BOUNDED (near-object radii per BV-SKILL-006 tags; near-enemy per CQC SPATIAL ranges).
- Interaction range is never "grab from across the room." If the player wants it, the player moves
  there — the world as interface (doctrine §5).

### 7.5 Interaction and stealth (frozen)

- Interactions EMIT SIGNATURE (door creak, drag noise, first-aid rustle) per BV-SKILL-007. The
  contextual system carries the noise cost — interacting is a tactical decision, not a free action.
- The TAKEDOWN contextual action composes with BV-SKILL-009 (contextual-assassination state separation):
  it is a stealth resolve, not a combat button.
# — CONTINUED: PART C — STEALTH, ANOMALY, EQUIPMENT / SURVIVAL INTERFACE —

---

## 8. Stealth controls (frozen — D026 §6)

> **Do not create a "stealth mode." Stealth is physical behavior.**

### 8.1 Stealth controls (frozen)

```
CROUCH            — core button; posture reduction (BV-SKILL-004)
PRONE             — stance chain (hold crouch); lowest profile
LEAN              — contextual at edges/corners (peek angles; composes with BV-SKILL-006 affordances)
PEEK              — contextual at cover edges and openings
COVER INTERACTION — contextual at authored cover surfaces (BV-SKILL-006 COVER / CONCEALMENT tags);
                    entering cover is a physical posture (low, wall-adjacent), not a mode toggle
SILENT MOVEMENT   — analog stick discipline + crouch/prone + tactical profile (SILENT); the operator's
                    noise floor is a function of ALL of these, never a button
```

### 8.2 No stealth mode (frozen)

- There is NO mode toggle that switches the character into a different ruleset. Concealment is a
  CHANNEL (doctrine §6; BV-SKILL-007) — light, angle, posture, movement, cover — and the controls expose
  the PHYSICAL ACTIONS that reduce the channel, not its state.
- The player NEVER sees a "STEALTH: ON" indicator. The player sees the operator lower, slow, and use
  cover — and watches AI suspicion react (BV-SKILL-008 knowledge-with-source).

### 8.3 Stealth feedback (frozen)

- Feedback is DIEGETIC: the operator's movement sound (feet, cloth, breath), the AI's search behavior
  (BV-SKILL-008 suspicion ladder), and the tactical-profile audio character (the existing project's
  SILENT/NORMAL/AGGRESSIVE profile remains the movement-quietness control).
- The tactical profile cycling control is a compact, adjustable touch surface (3-state select; also
  bindable to controller D-pad; also available from the quick radial — §12). It NEVER becomes a slider
  with numbers.

### 8.4 Stealth and combat readability (frozen — D021 §3 compose)

- Entering stealth never disables the combat cluster; the operator is always capable of either. The
  contextual surface changes meaning (takedown vs attack) but the core cluster is stable.
- A player who wants to break stealth and fight does so without a mode switch: draw, aim, fire
  (D021 §3 COMMIT from OBSERVE).

---

## 9. Anomaly controls (frozen — D026 §7)

> **The anomaly is not a superhero power menu.**

### 9.1 Anomaly control law (frozen)

- The anomaly has NO ability bar, NO cooldown UI, NO hotkey list. The anomaly is expressed through
  GESTURE + CONTEXT + INTENT (§9.2), layered on the operator's existing verbs (BV-D130 anomaly
  integration law; D016 §27).
- Anomaly controls appear with DISCOVERY, not at start: D016 §7 Phase 0 (AMBIGUOUS) and Phase 1
  (DENIAL) ship ZERO deliberate anomaly input surface. Phase 2 (CONTROLLED EXPERIMENTATION) introduces
  the gesture layer. Phase 3 (INTEGRATION) adds competency combinations. Phase 4 (MASTERY) refines
  reliability. The control surface grows with the fiction — never before it.
- The anomaly layer uses the SAME input grammar across its capabilities (hold / select / pull —
  §9.2) so the player never learns a new control per trick.

### 9.2 Gesture vocabulary (frozen)

```
HOLD           — sustained press on the anomaly surface: charge / maintain (the operator's concentration
                 made physical; release endpoint = commit)
SELECT OBJECT  — a bounded focus state (brief slow-time-feel focus per D016 §19 PERCEPTUAL ACCELERATION)
                 that tags a small object near the operator for interaction; selection is line-of-effect
                 and range bounded (D016 §18 legitimate-target-information rule)
DIRECTIONAL PULL / PUSH — a directional swipe from the anomaly surface: bounded force application in a
                 direction (mass / range / complexity bounded per D016 §13–§16)
RECALL         — the signature early capability: the operator reaches and returns an object (D016 §9);
                 a bounded gesture (tap-and-drag-toward-self) with short-range early
BLADE SUPPORT  — bounded thrown-blade assists (D016 §10); same grammar (hold + directional)
FOCUS          — the perception state (temporary; D016 §19); entered by holding the anomaly surface
                 while stationary; costs Strain; exits on release for a bounded aftershock window
```

### 9.3 Anomaly control and the operator's kit (frozen)

- The gesture surface lives on the NON-AIMING hand side by default (a small adjustable pad), so anomaly
  use does not fight the camera/aim thumb. It is not a wheel; it is a pad with four intent verbs.
- Anomaly use NEVER replaces the weapon controls (§6) — the firearm remains forever. A player mid-
  anomaly use who is shot at breaks the gesture by moving, aiming, or firing (input priority law:
  defensive verbs interrupt, §9.5).
- The gesture pad is DISCOVERED glass: it is not rendered until Phase 2; after Phase 2 it can be hidden
  entirely by players who prefer to only use anomalies from the quick radial (§12) — a CANDIDATE
  player-choice, frozen as supported.

### 9.4 Strain affects interaction, not input trust (frozen — fairness reconciliation)

D016 §4 strain bands and D026 §2 fairness law are reconciled HERE (frozen):

- Neural Strain HIGH/CRITICAL affects the EFFECT and the WORLD-PERCEPTION of anomaly actions:
  - gesture HOLD becomes harder to MAINTAIN to full charge (the effect releases early if the operator's
    control slips — the SIMULATION ends the charge; the touch input is never falsely read)
  - SELECT loses precision (selection candidates jitter in the world; the wrong small object may be
    selected — a WORLD-layer wobble the player can see and correct)
  - DIRECTIONAL PULL drifts (the force vector wanders in the world)
  - visual tearing / tinnitus / pressure cues increase (D019 §11 / D016 §44 presentation)
- The INPUT CHANNEL remains trustworthy (D015 §30): no phantom presses, no inverted controls, no fake
  touch loss, no "your input didn't register" bugs disguised as horror. What the operator's hands
  cannot do reliably is a CAPABILITY problem; what the player's touch does is a CONTROL problem and it
  always works.
- Gaming the trust boundary (input latency as "strain flavor") is a STOP condition (§19).

### 9.5 Input priority law during anomaly use (frozen)

- Defensive verbs (move strongly, aim, fire, dodge) INTERRUPT anomaly gestures instantly and cleanly
  (the gesture cancels; Strain partially refunds as the action never completed — D016 §9 interrupted-
  recall costing rule composes).
- The operator never becomes a sitting duck by menu; the inputs always answer.

---

## 10. Equipment / survival interface (frozen — D026 §8)

> **Avoid inventory screens that break immersion.**

### 10.1 Equipment access layers (frozen)

```
WRIST DEVICE (glance layer)     — condition / temperature / inventory read / communications /
                                   diagnostics (D019 §5.1); a GLANCE, not a menu (tap-and-hold or
                                   two-finger tap opens the wrist surface; releasing closes it)
QUICK RADIAL (verb layer)       — D017 §18 quick presentation radial: MAX 6 SLOTS (frozen) — hair tie /
                                   hood / face covering / goggles / helmet state / one flexible slot
                                   (bandanna or clean-weapon cloth per D017 §17)
EQUIPMENT WHEEL (kit layer)     — weapons / medical / tools / throwables: a hold-to-open wheel with
                                   TIME AS THE COST (the world keeps running while the wheel is open —
                                   no pause; opening kit mid-firefight is a real risk; D021 §3 ASSESS
                                   verb made flesh)
LOCKER / BASE (deliberate layer)— deep organization happens at base facilities (D017 §19 LOCKER /
                                   WORKBENCH); safe contexts allow deliberate, unhurried loadout work
                                   (pause behavior per future directive; the field wheel never pauses)
```

### 10.2 Medical / tools (frozen)

- MEDICAL lives in the equipment wheel and in the CONTEXTUAL surface near a wounded person (STABILIZE /
  TREAT / CARRY; §7.1). Treatment is decision-rich (D015 §13) — the controls expose the verbs; the
  operator's knowledge decides outcomes.
- TOOLS (knife, hatchet, multi-tool, wire cutters, climbing aid; D021 §8.2) live in the wheel; tool
  USE is CONTEXTUAL at the object (cut / pry / fix / rig), never a tool-mode menu.
- HELMET FUNCTIONS (D019 §4): passive layer is always available through helmet view; tactical activation
  is a bounded deliberate action with signature cost (a small control near the camera cluster; also
  available from the wrist device); anomalous layer is authored (Phase 3+, D026 §9).

### 10.3 Survival interface (frozen)

- Survival state is READ, not managed: bands, conditions, and cold/wetness feedback surface through
  diegetic cues + wrist device (D015 §45 / D019 §6). No survival action bar.
- Survival VERBS (drink, eat, warm, dry, rest, treat) are CONTEXTUAL (near water / fire / shelter /
  food) or from the wheel; they are decisions with time cost (D015 §6), not button maintenance.

### 10.4 Immersion guard (frozen)

- No full-screen inventory in the field. The field surfaces are: glance (wrist), radial (presentation),
  wheel (kit), contextual (world). A full-screen pack screen exists only at base/locker contexts
  (safe layer) or via deliberate long-hold at a rest point — CANDIDATE, frozen as bounded.
- Every wheel/radial is TIME-LIVE: the world does not pause in the field (D015 §28 / dynamic-world
  compose). This is a design law: OPENING YOUR KIT IS AN OPERATIONAL DECISION.

### 10.5 Equipment and the operator's identity (frozen — D025 §8 compose)

- Weapon relationship (familiarity / maintenance / history; BV-D130) surfaces through the wheel: the
  player's preferred weapon sits in the primary slot; familiarity shows as handling character
  (animation/audio), never as a stat row.
- PRESENTATION items (hair tie, hood, face covering, goggles, cleaning cloth) remain six-or-fewer quick
  actions (D017 §18 cap preserved); their effects stay diegetic (D019 §9).
# — CONTINUED: PART D — COMPANION, GROOMING / PRESENTATION, HUD INTEGRATION —

---

## 11. Companion Shade controls (frozen — D026 §9)

> **Not a summoned companion. The Shade remains a person.**

### 11.1 The companion control law (frozen — BV-D127 / BV-D126 §8 compose)

- The Companion Shade is NEVER a button payload. There is no summon, no "call companion" ability, no
  pet bar. The Shade is a PERSON who travels, waits, and chooses (BV-D127).
- Commands are REQUESTS, not orders. The Shade ACTS on his own judgment and relationship stage (D023
  §7 stages / §8.3 companion choices). A refused request is an authored character moment, not a failed
  input.
- The commander relationship is expressed through a small command layer, not a control panel.

### 11.2 Command set (frozen — maximum six)

```
OBSERVE      — watch a direction / area (the Shade's recon competence echoes the operator's)
HOLD         — hold position (the Shade's default when idle)
MOVE         — move to a location (a small tap-on-world designation; no drag-routing)
FOLLOW       — follow at distance (bounded; the Shade keeps tactical spacing, not pet-closeness)
DEFEND       — protect a person / place / the operator (the Shade's protective instinct)
RESPOND      — react tactically to a situation the operator designates (a bounded "watch my back"
                / "cover that" intent; the Shade chooses the METHOD)
```

Frozen rules:
- MAX SIX commands (mirrors D017 §18 radial cap discipline as a fleet pattern). No micro-management
  verbs (no crouch-here / reload-now / switch-weapon).
- No command exists for "use your special ability" — the Shade has no abilities; he has a person's
  skills and a soldier's training (BV-D127).
- Base-anchored by default (BV-D126; doctrine §26): the Shade is deployable in SELECTED operations; in
  the field the commander layer is available only when the Shade is present, which is authored (D023
  §6-§8 / D018 §13).

### 11.3 The companion gesture layer (frozen)

- The command layer opens from the wrist device (a companion tab) or a bounded two-finger gesture on
  the world designation; it is a small radial of ≤6 glyphs; tap = request.
- The Shade's response is DIEGETIC: he acknowledges, refuses, or acts (with his own body language and
  his own timing). No UI confirmation toast.
- The command layer NEVER pauses the world (field law §10.4 composes).

### 11.4 Companion and stealth balance (frozen)

- The Shade has his OWN signature channel (BV-SKILL-007 applies to him as a sensing actor — the world
  sees and hears him too). Commands that move him through danger create real risk; the player manages
  TWO signatures when the Shade is present. This is the tactical cost of companionship (D023 §13).
- The Shade is NEVER invisible to AI and NEVER exempt from AI perception (D011 §7 truthful sensing
  applies to all actors).

---

## 12. Grooming / presentation interaction (frozen — D026 §10)

### 12.1 Presentation controls (frozen)

Preserve D017 §14–§22 and D019 §9. The interaction paths are:

```
HAIR TIE / RELEASE        — quick radial slot (D017 §18)
HOOD UP / DOWN            — quick radial slot
FACE COVERING UP / DOWN   — quick radial slot
GOGGLES POSITION          — quick radial slot
HELMET STATE (where allowed) — quick radial slot (requires equipped headgear; unavailable clearly shown)
CLEAN WEAPON / CLOTH      — contextual at a cloth item or at rest (D019 §15 signature moment: cleaning
                             weapon after survival) — also radialable if a cloth is in the kit
INSPECT EQUIPMENT         — wrist device inspect action (§10.1) + base workbench (D017 §19)
```

### 12.2 These are world interactions (frozen)

- Presentation actions are PHYSICAL: the operator ties his hair, raises his hood, wipes his optic. The
  input is a verb; the animation is the operator's; the state persists (D017 §11 LIVING SAVE FILE).
- No cosmetics menu, no appearance screen in the field. Base presentation (shave, trim, wash, arrange —
  D017 §19) happens at MIRROR / BATHROOM / WASH surfaces as deliberate character beats (D017 §40), not
  as a customization screen.
- The quick radial NEVER exceeds 6 slots (frozen, D017 §18). If a seventh verb wants in, one comes out.

### 12.3 Presentation and signal (frozen)

- Presentation actions can be TACTICAL: hood up changes silhouette; face covering affects identity reads
  at range; goggles placement affects clarity vs protection; hair state affects peripheral view (D017
  §15). The player uses presentation as a tool, not as decoration.

---

## 13. HUD integration (frozen — D026 §11)

> **Every element must belong to: wrist device, helmet system, physical world.**

### 13.1 Ownership preserved (frozen — D015 §45 / D019 §5 / D019 §17)

| Surface | Host | Input relation |
|---|---|---|
| WRIST DEVICE (condition / temp / inventory read / comms / diagnostics) | equipment | glance layer (§10.1) |
| HELMET PASSIVE (env readings / compass / equipment status) | equipment | always-on through helmet view (§5.2) |
| HELMET TACTICAL (drone / system info / threat marking) | equipment | bounded deliberate activation with signature cost (§10.2) |
| HELMET ANOMALOUS (perceptual changes / distortion / anomaly feedback) | equipment | authored; grows with D016 §7 phases (§9.1) |
| SURVIVAL BANDS (CONDITION / CORE TEMP / EXERTION / CONTROL; NEURAL STRAIN later) | wrist + helmet passive | read, not managed (§10.3) |
| CONTEXTUAL CONDITIONS (wet / bleeding / chilled / etc.) | contextual icons per D015 §45 | read, not managed |
| WORLD HUD (objectives / clues / propagation) | the world | prompts diegetic (§7.3) |
| QUICK RADIAL | in-world (held input) | §12 / D017 §18 (6 max) |
| EQUIPMENT WHEEL | in-world (held input) | §10.1 (time-live) |

### 13.2 Forbidden (frozen)

```
floating health bars over enemies
MMO icon grids
ability cooldown wheels
quest-marker arrows pasted on the screen
touch-controls-rendered-as-HUD (the touch layer must not LOOK like a game controller)
permanent on-screen button labels once the player has learned the layout (labels fade per onboarding)
```

### 13.3 The touch layer is NOT the HUD (frozen)

- The touch controls are an INPUT layer, not a HUD layer. A control that has been mastered should be
  able to fade to near-invisible (opacity memory per control; §6.3) and still work — the operator's
  hands know where their body is.
- Onboarding teaches the layout; mastery DISSOLVES it (frozen progression: full visibility → reduced →
  player-chosen opacity). This is the touchscreen equivalent of the HUD-as-equipment law: the controls
  are a tool the player learns, then stops seeing.

### 13.4 Action feedback without a HUD (frozen)

- Interaction feedback: world response (§7.3).
- Weapon feedback: animation / audio / recoil (D019 §14 Tier 1).
- Damage feedback: body cues (blood, breath, posture — D017 §10 / D019 §6).
- Strain feedback: symptoms first (D016 §45).
- Suspicion feedback: AI behavior (BV-SKILL-008 search states; never a "!" from nowhere).
# — CONTINUED: PART E — ACCESSIBILITY, HARDWARE SCALING, INPUT ABSTRACTION, SKILL REVIEW —

---

## 14. Accessibility (frozen — D026 §12)

### 14.1 Required supports (frozen — mandatory)

```
BUTTON SCALING            — every control scales from default to XL without overlap breaks
REPOSITIONING             — free layout; saved player layout profiles (per-device)
OPACITY                   — per-control opacity 10%–100%; a "ghost" preset for mastered layouts
COLORBLIND CONSIDERATIONS — prompts / markers / team-color reads do not rely on a single hue; glyph +
                             shape + position carry meaning independent of color
ONE-HANDED SUPPORT        — left-handed full mirror (mandatory); a one-handed assisted layout is a
                             CANDIDATE (frozen as supported): movement + camera co-pilot affordances
                             bounded and optional
CONTROLLER SUPPORT        — full Bluetooth controller bindings for every action; no action is
                             touch-exclusive; input layer swap is seamless mid-session where the OS
                             allows
HAPTICS OPTIONS           — per-control intensity / total off
TAP-OR-HOLD OPTIONS       — aim / crouch / sprint / charge actions support both interaction styles
SENSITIVITY CURVES        — hipfire / aim / scope separately tunable; acceleration on/off
TEXT / GLYPH SIZE         — prompt labels scale independently of prompts
SCREEN-SHAKE REDUCTION    — composes with D017 §53 accessibility overrides (weather / impact shake)
```

### 14.2 Assist boundaries (frozen)

- AIM ASSISTS (if shipped) are ACCESSIBILITY-layer features, not fiction (D016 §48 prevention matrix is
  about the CHARACTER's capability; a player-side assist option is a settings-layer affordance). They
  are: optional, off by default at higher difficulty, bounded in strength, and NEVER marketed as the
  operator's ability.
- The operator's actual capabilities come from D016 / D025 (reclamation + discipline). Accessibility
  assists do not change the simulation; they change the input device's contribution.
- Assist presence must be player-invisible in fiction: no in-world indicator that an assist is on.

### 14.3 Hazard avoidance (frozen — D019 §16 / D016 §55 compose)

- No control scheme may rely solely on: screen shake / flashing / chromatic aberration / high-frequency
  visual distortion. The touch layer obeys the same law.
- Turbulence-style camera effects (storms; strain) have reduction overrides (D017 §53).

### 14.4 One-handed and left-handed (frozen)

- LEFT-HANDED: full mirror of the default layout (frozen mandatory).
- ONE-HANDED ASSISTED (CANDIDATE frozen as supported): movement anchor + tap-to-direct pathing +
  reduced simultaneous-input demands; bounded; documented as an assist mode. Never a default.

---

## 15. Hardware scaling and the input abstraction law (frozen — D026 §13)

### 15.1 Hardware targets (frozen)

```
BASELINE               — Android tablet; Godot 4.x; GL Compatibility renderer (BV-D001; D004 §10)
PRIMARY INPUT          — touchscreen (two-thumb ergonomics; tablet-first layout)
SUPPORTED INPUTS       — Bluetooth controller (full bindings); keyboard/mouse (where available;
                          desktop dev keys preserved: WASD / mouse / Space / E / C / Z / Shift /
                          1-2-3 tactical / J-K CQC / F2 overlay / R reset)
DEVICE-ADAPTIVE LAYOUT — safe-area aware (notches / bezels / gesture zones); tablet aspect ratios
                          (16:10 / 4:3 / 16:9) each get authored layout anchors; orientation: landscape
                          primary (frozen); portrait is out of scope for gameplay (CANDIDATE for menus only)
```

### 15.2 The input abstraction law (frozen)

> **One simulation layer. Different input layers.**

- The SIMULATION consumes ABSTRACT ACTIONS (the existing `InputMap` vocabulary in `game/project.godot`
  is the canonical action set: move / look / stance / tactical profile / interact / jump / CQC attack /
  guard / etc.). The simulation NEVER knows whether an action came from a touch, a controller, or a key.
- Every INPUT LAYER (touch / controller / keyboard+mouse) maps onto the SAME action vocabulary. No
  layer-specific gameplay rules. No touch-only mechanics. No controller-only advantages.
- Existing project direction preserved (README): the touch HUD maps to the same declared actions;
  screen-drag maps to the camera look function. D026 freezes this as canon for all future UI work.
- The simulation never reads raw touch coordinates for gameplay effect; only the mapped action values
  (analog magnitude included) reach the character. This preserves determinism, replay fixtures
  (BV-SKILL-015 invariant 4), and fairness (D015 §30).

### 15.3 Input performance budget (frozen)

- Touch input latency budget: input-to-action under the project's gesture budget (target: single-frame
  sampling; no buffered gestures beyond the authored double-tap window).
- The touch layer must add no measurable simulation cost: it is an event source, not a per-frame
  system (SOP-004 discipline).
- Inputs are SAVE-INDEPENDENT: layout profiles save with settings, never with the world save (layout
  does not travel with the character's fiction).

### 15.4 Dev-only controls (frozen)

- The desktop dev vocabulary (F2 overlay / R observer reset / Backspace opponent reset / etc.) remains
  DEV-ONLY. It is not shipped as touch UI. Debug instrument surfaces stay behind the observability
  contract (SOP-006; BV-SKILL-015 invariant 5 — overlay ON == gameplay identical).

---

## 16. Skill review, methodology, validation (frozen — D026 §14)

### 16.1 Skill review (frozen)

Inspect the 35-BV-skill fleet:

| Candidate skill | What it owns | Owns touchscreen input architecture? |
|---|---|---|
| BV-SKILL-003 third-person-character-controller | movement, camera rig, input handoff (SIMULATION side) | NO — it consumes actions; it does not design the input layers |
| BV-SKILL-004 stance-system | stance locomotion states | NO |
| BV-SKILL-005 systemic-traversal | traversal affordances/mechanics | NO |
| BV-SKILL-006 environmental-affordances | world surfaces/tags (what can be interacted with) | NO — D026 designs the INPUT to those surfaces |
| BV-SKILL-007 stealth-and-concealment | signature channels / concealment mechanics | NO |
| BV-SKILL-014 mobile-graphics-atmosphere | weather/lighting/LOD/atmosphere | NO |
| BV-SKILL-032 visual-presentation-architecture | camera methodology / helmet-visor methodology / HUD-as-equipment / animation tiers / tablet-performance law | PARTIAL — it owns HUD-as-equipment and camera methodology; it explicitly does NOT own input layers (BV-SKILL-032's workflow step 4 covers HUD surfaces, not touch ergonomics) |
| BV-SKILL-035 operator-discipline-architecture | operator fantasy / action priority list | NO — it produced the action priority list as INPUT for D026 |

Ownership gap (frozen determination): NO existing skill owns the REUSABLE METHODOLOGY for touchscreen
input / mobile control layout / interaction architecture. BV-SKILL-032 owns presentation (what the
player sees); BV-SKILL-003 owns the simulation's input consumption; BV-SKILL-035 owns the fantasy's
action priority. The layer between them — input layers, ergonomics, gesture vocabulary, contextual
action standards, adjustable-layout law, accessibility input, abstraction law — is unowned.

**A new methodology-only skill is JUSTIFIED: BV-SKILL-036 touchscreen-input-architecture** (mirrors
BV-SKILL-030 / 031 / 032 / 033 / 034 / 035 discipline). It owns the REUSABLE design procedure for:

- input layer architecture (one simulation layer / different input layers; abstract action vocabulary;
  per-layer mapping; no layer-specific rules)
- touch ergonomics (two-thumb foundation; placement law; adjustable size/position/opacity; left-handed
  mirroring; safe-area/layout anchors)
- control-cluster budgets (minimum set law; core-cluster count discipline; absorption/contextualization
  before additions)
- contextual action standards (one surface / many meanings; context-lock law; priority resolution;
  diegetic prompt layer; signature costs)
- gesture vocabulary design (hold / select / directional / recall / focus patterns; discovery-gated
  appearance; interruption priority)
- strain-vs-input-trust reconciliation (capability degrades the EFFECT; the control channel is never
  corrupted)
- equipment access layer design (glance / radial / wheel / base-deliberate tiers; time-live field law)
- companion command-layer methodology (request-not-order; ≤6 command caps; person-preservation rules)
- accessibility input design (scaling / repositioning / opacity / colorblind / one-handed / controller
  parity / assist boundaries)
- hardware scaling + performance + save-independence of input profiles
- input observability (abstract-action logging; replay determinism)

It does NOT contain statements like "BLACK VECTOR's fire button sits at X position" or "the anomaly pad
is 96px wide." Those live in this bible (D026) and in doctrine (BV-D131) and in future implementation
specs.

### 16.2 What D026 is NOT (frozen — scope guards)

- NOT a Godot UI implementation (no nodes, no Control trees, no theme resources; BV-D052 analog).
- NOT art direction for buttons (glyph style / materials / animation belong to a future UI-art pass and
  BV-SKILL-032 territory).
- NOT a re-design of the existing `InputMap` actions (they are preserved; D026 maps onto them).
- NOT a change to any game file (validation below; no game/ modifications).
- NOT a controls-tutorial flow (onboarding pedagogy is a future directive; D026 freezes the FADE
  principle in §13.3 only).

### 16.3 Validation (frozen)

- `python3 tools/validate_methodology.py` — expected PASSED (2 governing + 36 BV skills, 6 SOPs,
  registry, gameplay confined).
- `python3 tests/static_verify_game.py` — expected CLEAN (24 ok / 0 fail; no verifier inventory
  change expected; no game/ modifications).
- Contradiction ledger against D001–D025: Appendix A (frozen result: 0 contradictions; 2 explicit
  reconciliations recorded — strain-vs-input-trust §9.4 and assist-vs-character-capability §14.2).

### 16.4 Recommended next directive (frozen — not executed)

Per the directive's closing statement: **D027 — VERTICAL SLICE IMPLEMENTATION** (the build line).

Chain status at D026 completion:

```
D015 World Foundation        ✔
D016 Anomaly                 ✔
D017 Character State         ✔
D018 Campaign                ✔
D019 Presentation            ✔
D020 Slice Test              ✔ (specification)
D021 Combat                  ✔
D022 Enemies                 ✔
D023 Relationships / Shade   ✔
D024 Dynamic World           PAUSED (scope frozen in BV-D128; bible not yet assembled)
D025 Operator Identity       ✔
D026 Controls                ✔
→ D027 Build the first playable slice
```

D027 is where BLACK VECTOR stops being a design document and starts becoming a game. D026 does NOT
execute D027. **Not executed. STOP. NO COMMIT.**
# — CONTINUED: PART F — APPENDICES AND FINAL REPORT —

---

## Appendix A — Contradiction ledger (D026)

| # | Existing canon | D026 position | Result |
|---|---|---|---|
| 1 | Doctrine §5 world as interface / no lobby | §2 preserved; §3.3 diegetic controls; §7.3 diegetic prompts | No contradiction |
| 2 | Doctrine §6 stealth doctrine (no `hidden = true`) | §8.2 no stealth mode; stealth is physical behavior | No contradiction |
| 3 | Doctrine §10 platform (Android tablet, GL Compatibility, BV-D001) | §15.1 preserved; touch primary; GL baseline | No contradiction |
| 4 | Doctrine §29 opening structure | §2 preserved; D026 touches no narrative | No contradiction |
| 5 | Doctrine §33 reference games inform areas / never copied | §5.3 explicit scoped combination; originality boundary frozen | No contradiction |
| 6 | Doctrine §34 narrative pillars | §7 (interaction), §11 (companion), §12 (presentation) compose | No contradiction |
| 7 | Doctrine §35.1 combat identity (no combos/QTEs) | §6 minimal cluster; §6.1 frozen rules forbid combos/QTE | No contradiction |
| 8 | Doctrine §35.3 locomotion agency preserved | §4.5 movement-during-combat preserved | No contradiction |
| 9 | Doctrine §41 / BV-D042..D052 visual/equipment (design language only) | §16.2 D026 is not UI art; BV-D052 analog applied | No contradiction |
| 10 | D004 §10 edge-device budget | §15.3 input adds no simulation cost; budgets preserved | No contradiction |
| 11 | D008/D009 CQC doctrine | §4.4 / §6.1 / §7.5 CONTACT/SPATIAL/ranges compose | No contradiction |
| 12 | D011 §7 truthful sensing (no omniscience) | §11.4 Shade sensed; §7.2 no auto-context omniscience | No contradiction |
| 13 | D013 weapons + BV-D070 psionic boundary | §6 weapon cluster; §9 gesture anomaly never replaces firearm | No contradiction |
| 14 | D015 §6 survival decisions | §10.3 survival verbs contextual/time-costed | No contradiction |
| 15 | D015 §9 cold / §12 shelter / §14 weather | §4.3 movement supports terrain/weather effects; no input change | No contradiction |
| 16 | D015 §13 injury model | §4.3 injured movement; §7.4? none; injuries as simulation behavior | No contradiction |
| 17 | D015 §28 off-screen coarse model | §10.4 time-live field interfaces compose (no pause in field) | No contradiction |
| 18 | D015 §30 fairness law (input trustworthy) | §9.4 EXPLICIT RECONCILIATION — strain degrades effect/perception, never the control channel; phantom presses/input corruption forbidden | No contradiction (reconciliation frozen) |
| 19 | D015 §45 HUD ownership | §13.1 ownership table preserved | No contradiction |
| 20 | D016 §4 Neural Strain bands | §9.4 strain interaction law | No contradiction |
| 21 | D016 §5 Control × Strain 2×2 | §9.4 composes; no new model | No contradiction |
| 22 | D016 §7 five-phase discovery | §9.1 anomaly input grows with phases; zero deliberate surface Phase 0–1 | No contradiction |
| 23 | D016 §9 recall / §10 blade / §13–§16 mass/range/complexity | §9.2 gesture vocabulary bounded by these | No contradiction |
| 24 | D016 §17/§18 firearms + projectile correction | §6 fire/aim cluster; no auto-aim magic; assist is accessibility-layer | No contradiction |
| 25 | D016 §19 perceptual acceleration | §9.2 FOCUS gesture; §9.4 wobble discipline | No contradiction |
| 26 | D016 §27 CQC integration | §4.4 / §6.1 melee + defensive verbs compose | No contradiction |
| 27 | D016 §41–§45 presentation language | §13.4 strain feedback symptoms-first compose | No contradiction |
| 28 | D016 §48 Superhero-prevention matrix | §14.2 EXPLICIT RECONCILIATION — assists are player-side, optional, bounded; the character gains nothing in fiction | No contradiction (reconciliation frozen) |
| 29 | D016 §49 Season-1 mastery ceiling | §9 (anomaly is never the primary verb); §6 firearm forever | No contradiction |
| 30 | D017 §18 quick radial MAX 6 SLOTS | §10.1 / §12.2 / §11.2 all respect the ≤6 discipline | No contradiction |
| 31 | D017 §19 base-grooming facilities | §10.1 LOCKER / base deliberate layer; §12.2 base presentation beats | No contradiction |
| 32 | D017 §36 animation-evolution ladder | §4.3 injured/exhaustion handling consumes; §13.4 body feedback | No contradiction |
| 33 | D017 §53 accessibility overrides | §14.1 composes (shake reduction; sensitivity; scaling) | No contradiction |
| 34 | D018 §55 mission taxonomy | §7 contextual verbs compose (RESCUE / INVESTIGATE / RECOVER interactions) | No contradiction |
| 35 | D019 §3 camera system (3P/FP/helmet; weather/injury effects) | §5 camera/aim input for those cameras; body-presence preserved | No contradiction |
| 36 | D019 §4 helmet three-layer | §5.2 / §10.2 passive free; tactical opt-in w/ signature; anomalous authored | No contradiction |
| 37 | D019 §5 HUD-as-equipment | §13.1 ownership; §13.3 touch layer is NOT HUD | No contradiction |
| 38 | D019 §6 survival HUD diegetic cues | §10.3 read-not-managed | No contradiction |
| 39 | D019 §14 animation priority tiers | §13.4 feedback via Tier 1 animations | No contradiction |
| 40 | D019 §15 signature moments | §12.1 clean-weapon contextual composes | No contradiction |
| 41 | D019 §16 tablet performance law | §15.3 input budget; no per-frame system | No contradiction |
| 42 | D019 §17 HUD ownership boundary | §13.1 preserved | No contradiction |
| 43 | D020 §4.9 technical requirements (UI/HUD surfaces) | §16 (skill review) and §15 compose; slice UI surfaces enabled by D026 | No contradiction |
| 44 | D020 §10 production boundaries | §16.2 D026 is architecture only; no implementation | No contradiction |
| 45 | D021 §2 combat philosophy | §3 philosophy + §6 cluster preserve decision-over-combo | No contradiction |
| 46 | D021 §3 7-step loop | §7.1 contextual verbs map to ASSESS/COMMIT; §7.5 takedown is stealth resolve | No contradiction |
| 47 | D021 §4 player combat model (movement/stance/commitment/defense/evasion/counters/grappling/env/weapons) | §4–§6 expose each as verbs | No contradiction |
| 48 | D021 §6 injury + survival integration | §4.3 injured movement; §10.3 survival read | No contradiction |
| 49 | D021 §7 AI doctrine (bounded; no omniscience) | §7.2 context-lock never grants knowledge; §11.4 Shade sensed | No contradiction |
| 50 | D022 §3 AI perception state machine | §8.3 feedback via suspicion ladder; controls do not alter states | No contradiction |
| 51 | D022 §5 archetypes | §7.1 contextual verbs (takedown/restrain/interrogate/hide) compose | No contradiction |
| 52 | D023 §2 / BV-D127 Shade canon correction | §11 companion law preserves ("the Shade remains a person") | No contradiction |
| 53 | D023 §7 relationship stages | §11.1 requests, not orders; refusal is an authored beat | No contradiction |
| 54 | D023 §8 companion rules (no summon / no helper / base-anchored) | §11.2 frozen six commands, no summon, base-anchored | No contradiction |
| 55 | D023 §10 community relationship system | §7 contextual interactions with people; no reputation UI | No contradiction |
| 56 | D025 §9 action priority (movement/aiming/stealth/interaction/equipment/companion/grooming/anomaly) | §4–§12 map 1:1 to the priority list | No contradiction |
| 57 | BV-D123 vertical-slice canonical reference | §16.4 chain status; slice build is D027 recommendation | No contradiction |
| 58 | BV-D124 combat architecture canonical reference | §6 / §7 compose | No contradiction |
| 59 | BV-D125 enemy architecture canonical reference | §7 / §8 compose | No contradiction |
| 60 | BV-D126 companion/relationship canonical reference | §11 compose | No contradiction |
| 61 | BV-D127 Shade reclamation correction | §11.1 person-preservation and request-not-order frozen | No contradiction |
| 62 | BV-D128 (D024 paused) | §16.4 chain status records D024 PAUSED; D026 does not alter D024 scope | No contradiction |
| 63 | BV-D130 operator identity canonical reference | §4.3 stealth-speed control composes with D025 techniques; §10.5 weapon relationship compose | No contradiction |
| 64 | BV-SKILL-003 third-person-character-controller (input handoff) | §15.2 abstraction law preserves; touch maps to same actions | No contradiction |
| 65 | BV-SKILL-004 stance-system | §4.2 / §6.1 crouch/prone chain compose | No contradiction |
| 66 | BV-SKILL-005 systemic-traversal | §4.4 traversal expose compose | No contradiction |
| 67 | BV-SKILL-006 environmental-affordances | §7.4 range-bounded context compose | No contradiction |
| 68 | BV-SKILL-007 stealth-and-concealment | §8 physical stealth; signature costs on interactions (§7.5) | No contradiction |
| 69 | BV-SKILL-008 tactical-ai-perception | §8.3 suspicion feedback; §11.4 Shade sensing | No contradiction |
| 70 | BV-SKILL-009 contextual-assassination | §7.5 takedown is stealth resolve | No contradiction |
| 71 | BV-SKILL-014 mobile-graphics-atmosphere | §15 tablet scale; §14.3 hazard law | No contradiction |
| 72 | BV-SKILL-021 cqc-combat-architecture | §4.4 / §6.1 compose | No contradiction |
| 73 | BV-SKILL-032 visual-presentation-architecture | §16.1 PARTIAL ownership recorded; D026 owns the unowned input layer | No contradiction |
| 74 | BV-SKILL-035 operator-discipline-architecture | §16.1 action priority list honored as input | No contradiction |
| 75 | Existing project `InputMap` actions (22 actions) / README touch-HUD direction | §15.2 abstraction law freezes this; no action renamed/removed | No contradiction |
| 76 | SOP-004 mobile performance | §15.3 input budget discipline | No contradiction |
| 77 | SOP-006 observability | §15.4 debug dev-only; overlay non-invasive | No contradiction |

Result: **0 contradictions found.** Two explicit reconciliations frozen (§9.4 strain-vs-input-trust;
§14.2 assist-vs-character-capability). No silent repair required. No prior canon modified.

## Appendix B — Deferred decisions (D026)

1. Exact glyph / visual style for touch controls (UI-art pass; BV-SKILL-032 territory) — CANDIDATE.
2. Exact default positions / sizes / opacity values (device-profile validation) — CANDIDATE.
3. Onboarding pedagogy (how the layout is taught, and how it fades — §13.3 principle frozen; flow is a
   future directive) — CANDIDATE.
4. One-handed assisted layout specifics (§14.4) — CANDIDATE.
5. Aim-assist strength tiers, if shipped (§14.2) — CANDIDATE.
6. Portrait-mode menus (gameplay portrait out of scope; menus CANDIDATE) — CANDIDATE.
7. Gyro fine-tune aim support (optional; off by default) — CANDIDATE (frozen as permitted, not required).
8. Equipment wheel exact geometry / hold duration — CANDIDATE.
9. Companion command-layer gesture binding (wrist tab vs two-finger world designation — both permitted;
   one default chosen at implementation) — CANDIDATE.
10. D027 vertical slice implementation — recommended next; not executed.

## Appendix C — Stop-condition trace (D026)

This bible STOPS if any stop condition fires:
- controls become button clutter / MMO action bars / copied console ports — §3.1 rejected patterns.
- a stealth MODE appears — §8.2 frozen.
- an ability menu / cooldown wheel appears for the anomaly — §9.1 frozen.
- the player's input channel becomes untrustworthy (phantom presses, fake latency as horror, inverted
  controls) — §9.4 / §2 fairness; STOP.
- the companion becomes a summon / puppet — §11.1 frozen.
- the touch layer becomes a HUD (permanent labels; floating bars) — §13.2 / §13.3 frozen.
- accessibility assists leak into the fiction as character abilities — §14.2 frozen.
- input layers gain layer-specific gameplay rules — §15.2 abstraction law frozen.
- any game/ file is modified in this directive — validation below; STOP.
- prior canon is contradicted — Appendix A: 0 contradictions.
- validators fail — validation below.

None triggered. **Validation below. STOP. NO COMMIT. RETURN REPORT.**

---

# FINAL REPORT — DIRECTIVE 026

**Touchscreen Input, Mobile Control Layout & Interaction Architecture Bible.**

---

**Files inspected:** doctrine §5 / §6 / §10 / §29 / §33 / §34 / §35.1 / §35.3 / §41; D004 §10; D008/D009; D010; D011 §7; D013; D015 §6/§9/§12/§13/§14/§25/§28/§30/§45; D016 §4/§5/§7/§9/§10/§13–§19/§27/§41–§49; D017 §18/§19/§36/§53; D018 §55; D019 §3–§6/§14–§17; D020 §4.9/§10; D021 §2–§7; D022 §3/§5; D023 §2/§7/§8/§10; D025 §9; BV-D123..BV-D130; README (existing InputMap / touch-HUD direction). Skills 001–035 + 2 governing + 6 SOPs.

**Skills consumed:** governing set + SOP-004 / SOP-006; composed with the full 35-BV-skill fleet.
**NEW skill created: BV-SKILL-036 touchscreen-input-architecture — METHODOLOGY ONLY** (ownership gap
proven in §16.1: presentation owned by 032, simulation input consumption by 003, action priority by 035;
input-layer methodology unowned).

**Files created/modified:**
- Created: `docs/design/TOUCHSCREEN_INPUT_INTERACTION_ARCHITECTURE_BIBLE.md` (assembled from staged
  chunks); `.opencode/skills/touchscreen-input-architecture/SKILL.md` (BV-SKILL-036, METHODOLOGY ONLY).
- Modified: `doctrine/BLACK_VECTOR_DOCTRINE.md` (BV-D131 — Touchscreen Input & Interaction Architecture
  Canonical Reference); `skills/registry.md` (inventory 001..036 + routing row + quality-gate note);
  `tools/validate_methodology.py` (36-skill fleet); `README.md` (status + fleet count); RELATED SKILLS
  cross-refs in composing skills (003 / 004 / 007 / 014 / 032 / 035). Staging chunks removed.

**Doctrine IDs added:** **BV-D131** — Touchscreen Input & Interaction Architecture canonical reference
(frozen): control philosophy ("minimum input, maximum intent"; rejected patterns; operator-extension
law; rareness discipline); movement architecture (left-thumb analog stick; adjustable size/position/
opacity; left-handed; states walk/jog/sprint/crouch/prone; stealth speed control / injured movement /
exhaustion / terrain effects; traversal contextual; locomotion agency preserved); camera/aim architecture
(right-thumb; free look / aiming / precision / scope / shoulder swap; 3P / FP / helmet view; scoped
reference combination frozen as original); core combat buttons (minimum set: fire / aim / reload /
crouch / interact / weapon swap / melee / defensive move; every button adjustable; context-lock law);
contextual action system (one surface many meanings; priority + context-lock; diegetic prompts;
signature costs); stealth controls (crouch / prone / lean / peek / cover / silent movement; NO stealth
mode); anomaly controls (gesture vocabulary hold/select/pull/recall/focus; discovery-gated appearance;
strain degrades EFFECT not input trust — explicit reconciliation; input priority interruption); equipment
interface (wrist glance / quick radial ≤6 / time-live equipment wheel / base-deliberate locker);
companion controls (request-not-order; max six commands; person-preservation; own signature channel);
grooming/presentation interactions (world verbs; radial cap preserved); HUD integration (ownership table
preserved; touch layer is NOT HUD; mastery dissolves the layer); accessibility (scaling/repositioning/
opacity/colorblind/one-handed/controller/haptics/tap-or-hold/sensitivity/shake reduction; assist
boundaries frozen); hardware scaling + input abstraction law (one simulation layer, different input
layers; existing InputMap actions preserved; input profiles are settings-save, not world-save);
NO game/ modifications; no commit; D024 remains paused (BV-D128 untouched); D027 vertical slice
implementation recommended next.

**Control philosophy:** "Minimum input, maximum intent." The touchscreen is an extension of the
operator's body. Rejected: clutter, MMO bars, floating wheels, console-port corners. Accepted:
dual-thumb foundation, minimal combat cluster, ONE contextual surface, diegetic prompts, gesture-only
anomaly layer, adjustable-everything.

**Movement:** left-thumb analog stick (adjustable size/position/opacity; left-handed mirror); states
walk/jog/sprint/crouch/prone; supports stealth speed control, injured movement, exhaustion, terrain
effects; jump dedicated; traversal contextual; locomotion agency preserved in combat.

**Camera/aim:** right-thumb; free look / aiming / precision / scope transition / shoulder swap; 3P + FP
+ helmet view; King's Road-style and Delta Force mobile-style REFERENCES evaluated and an ORIGINAL
combination frozen (dual-thumb + minimal cluster + contextual surface + diegetic prompts + gesture
anomaly + adjustable layout); doctrine §33 originality boundary applied.

**Core buttons:** fire / aim / reload / crouch / interact / weapon swap / melee / defensive move — the
frozen minimum. Every control: adjustable size, opacity, movable, controller-supported, tap-or-hold
options, haptics options. Context prevents button-crowd; combat > interaction priority; context-lock
on press-down; safe cancel on context change.

**Contextual actions:** one surface, many meanings (open/search/repair/climb/drag/stabilize/takedown/
restrain/interrogate/hide/etc.); prompt layer diegetic and one-shot; range-bounded; interactions emit
signature (BV-SKILL-007 compose).

**Stealth:** crouch / prone / lean / peek / cover / silent movement; NO stealth mode (doctrine §6);
feedback diegetic (noise, suspicion ladder, tactical profile); stealth never disables combat.

**Anomaly:** no ability bar / no cooldown UI; gesture vocabulary (hold / select / directional pull /
recall / focus); zero deliberate surface in Phase 0–1 (D016 §7); strain degrades EFFECT and PERCEPTION,
never input trust (explicit reconciliation with D015 §30); defensive verbs interrupt gestures cleanly.

**Equipment:** wrist glance layer; quick radial ≤6 (D017 §18); time-live equipment wheel (opening kit
mid-firefight is a real operational decision); base/locker deliberate layer; no field full-screen
inventory; survival verbs contextual/time-costed.

**Companion:** request-not-order; max six commands (observe / hold / move / follow / defend / respond);
no summon; no ability button; refusal is an authored character moment; the Shade has his own signature
channel and is never invisible to AI.

**Grooming/presentation:** hair tie / hood / face covering / goggles / helmet state at the quick radial
(≤6 preserved); clean weapon contextual (signature moment per D019 §15); inspection at wrist + base;
no cosmetics menu; presentation can be tactical.

**HUD:** ownership table preserved (wrist / helmet passive / helmet tactical / helmet anomalous /
survival bands / contextual / world / radial / wheel); forbidden: floating bars, MMO icons, cooldown
wheels, touch-controls-as-HUD, permanent labels; mastery DISSOLVES the touch layer (opacity memory);
feedback via world response / animation tiers / body cues / symptom-first strain.

**Accessibility:** scaling / repositioning / opacity / colorblind-safe glyphs / left-handed mirror +
one-handed assisted (supported) / full controller parity / haptics options / tap-or-hold options /
separate sensitivity curves / glyph scaling / shake reduction compose; assists are player-side, off by
default at higher difficulty, bounded, fiction-invisible.

**Hardware scaling:** Android tablet baseline + GL Compatibility (BV-D001); touch primary; Bluetooth
controller + KBM supported; safe-area and aspect anchors; landscape primary. Input abstraction law:
"One simulation layer. Different input layers." Input profiles live in settings, not world-save;
input never introduces layer-specific gameplay rules.

**Contradictions:** 77-ledger check vs D001–D025 — **0 contradictions found** (two explicit
reconciliations frozen: strain-vs-input-trust §9.4; assist-vs-character-capability §14.2). No silent
repair required. No prior canon modified.

**Deferred decisions:** 10 recorded (Appendix B) — glyph art, default layout values, onboarding flow,
one-handed specifics, assist tiers, portrait menus, gyro, wheel geometry, companion gesture default,
D027.

**Validation:** methodology PASSED (2 governing + 36 BV skills, 6 SOPs, registry, gameplay confined);
static game CLEAN (24 ok / 0 fail; unchanged); **GAME IMPLEMENTATION STARTED: NO**; **no game/ files
changed**; **no commit made**.

**Chain status note:** D024 (Dynamic World) remains PAUSED per the earlier redirect — its doctrine row
BV-D128 is reserved and the partial staged chunk is preserved; doctrine number BV-D129 is reserved for
D024's completion. D026 does not alter D024's scope. Recommend resolving D024 (complete or formally
defer) before or alongside D027 build planning.

---

**Recommended D027 (not executed):** **D027 — VERTICAL SLICE IMPLEMENTATION** (the build line). Per the
directive's closing statement: at D026 completion the chain is world → anomaly → character → campaign →
presentation → slice test → combat → enemies → relationships → dynamic world (paused) → identity →
controls. The next step is the first playable slice build against the D020 specification (BV-D123),
composed with the D026 control architecture and the D025 identity layer.

**Not executed. STOP. NO COMMIT.**
