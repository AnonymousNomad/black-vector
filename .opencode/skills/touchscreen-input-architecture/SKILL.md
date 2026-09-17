---
name: touchscreen-input-architecture
description: Reusable design procedure for touchscreen input / mobile control layout / interaction architecture systems — input layer architecture (one simulation layer, different input layers; abstract action vocabulary; per-layer mapping; no layer-specific rules), touch ergonomics (two-thumb foundation; placement law; adjustable size/position/opacity; left-handed mirroring; safe-area anchors), control-cluster budgets (minimum-set law; core-count discipline; absorption before addition), contextual action standards (one surface many meanings; context-lock law; priority resolution; diegetic prompt layer; signature costs), gesture vocabulary design (hold / select / directional / recall / focus; discovery-gated appearance; interruption priority), strain-vs-input-trust reconciliation (capability degrades the EFFECT; the control channel is never corrupted), equipment access layer design (glance / radial / wheel / base-deliberate tiers; time-live field law), companion command-layer methodology (request-not-order; ≤6 caps; person-preservation), accessibility input design (scaling / repositioning / opacity / colorblind / one-handed / controller parity / assist boundaries), hardware scaling + performance + save-independence of input profiles, input observability (abstract-action logging; replay determinism). Pure methodology: NO per-character or per-campaign canon lives here (canon lives in the bible + doctrine). Load when designing any input layer / touch layout / contextual action / gesture vocabulary / equipment access / companion command / mobile ergonomics system.
---

# TOUCHSCREEN INPUT ARCHITECTURE (BV-SKILL-036)

## NAME
TOUCHSCREEN INPUT ARCHITECTURE

## PURPOSE
Own the REUSABLE design procedure for touchscreen input / mobile control layout / interaction
architecture. This is METHODOLOGY, not canon — it tells future directives how to design input layers,
touch ergonomics, control-cluster budgets, contextual action surfaces, gesture vocabularies, equipment
access tiers, companion command layers, accessibility input, hardware scaling, and input observability.
It does not state where BLACK VECTOR's fire button sits or how large its anomaly pad is; those
statements live in the per-game bible (e.g.
`docs/design/TOUCHSCREEN_INPUT_INTERACTION_ARCHITECTURE_BIBLE.md`) and in doctrine (BV-D### rows). This
separation keeps the skill fleet from collapsing into duplicated lore.

## WHEN TO LOAD
- Designing or extending any input layer architecture (touch / controller / keyboard+mouse) or the
  abstraction boundary between input and simulation.
- Designing or extending touch ergonomics (placement, sizing, opacity, left-handed mirroring, safe
  areas).
- Designing or extending any control cluster / button budget.
- Designing or extending any contextual action surface or context-resolution behavior.
- Designing or extending any gesture vocabulary (anomaly / interact / command gestures).
- Reconciling degraded capability with input trust (strain, injury, fear) so the control channel
  remains fair.
- Designing or extending equipment access tiers (glance / radial / wheel / base).
- Designing or extending companion or ally command layers.
- Designing or extending accessibility input options or hardware-scaling laws for inputs.

## DO NOT LOAD WHEN
- Implementing the movement controller or camera rig internals (BV-SKILL-003 third-person-character-controller
  owns the simulation side that consumes actions).
- Implementing stance mechanics (BV-SKILL-004), traversal mechanics (BV-SKILL-005), world affordance
  tags (BV-SKILL-006), stealth channels (BV-SKILL-007), perception internals (BV-SKILL-008).
- Implementing combat architecture (BV-SKILL-021 owns CQC; AI-facing interfaces included).
- Implementing presentation / HUD design (BV-SKILL-032 visual-presentation-architecture owns
  HUD-as-equipment, camera methodology, animation tiers, tablet-performance law).
- Implementing anomaly capability mechanics (BV-SKILL-030 methodology; BV-SKILL-019 cost pipeline).
- Implementing companion behavior arcs (BV-SKILL-034 companion-relationship-architecture).
- Implementing operator fantasy / progression (BV-SKILL-035 operator-discipline-architecture).
- Per-game control canon (button positions, pad geometry, layout values) — those live in the per-game
  bible and in implementation specs.

## PRECONDITIONS
- Governing set loaded.
- Existing doctrine read: §5 (world as interface), §6 (stealth — no stealth mode), §10 (platform /
  renderer decision), §33 (reference games inform areas, never copied), §34 (narrative pillars),
  §35.1/§35.3 (combat identity; locomotion agency).
- Platform baseline known: Android tablet + Godot + GL Compatibility renderer; the project's existing
  abstract action vocabulary (the `InputMap` actions) is the canonical action set inputs must map onto.
- Existing skills read: 003 (controller — input handoff), 004 (stance), 005 (traversal), 006
  (affordances), 007 (stealth), 008 (AI perception), 009 (contextual assassination), 014 (mobile
  graphics/atmosphere), 021 (CQC), 030 (anomaly methodology), 032 (visual-presentation), 034
  (companion-relationship), 035 (operator discipline — action priority input), 015 (observability).
- Existing per-game bible (the canonical example is
  `docs/design/TOUCHSCREEN_INPUT_INTERACTION_ARCHITECTURE_BIBLE.md`) read so methodology does not
  duplicate per-game limits.

## GOVERNING INVARIANTS
1. METHODOLOGY ONLY: this skill defines HOW to design an input layer; it does not state a specific
   game's layout values. Per-game canon lives in the per-game bible and in doctrine. A future directive
   that wants to amend a campaign's controls does not edit this skill.
2. ONE SIMULATION LAYER, DIFFERENT INPUT LAYERS: the simulation consumes ABSTRACT ACTIONS; it never
   knows which input layer produced them. No layer-specific gameplay rules, no touch-only mechanics, no
   controller-only advantages, no raw-touch gameplay reads.
3. MINIMUM INPUT, MAXIMUM INTENT: every control must answer "what does the operator need to do right
   now?" Control counts are budgets; new controls must absorb or contextualize an existing one first.
4. ADJUSTABLE-EVERYTHING: every control supports adjustable size, adjustable opacity, movable layout,
   input-parity (controller support), and tap-or-hold options where hold fatigue matters.
5. CONTEXT REDUCES BUTTONS BY MEANING: a single contextual action surface with documented priority
   resolution; CONTEXT-LOCK on press-down (the meaning at press is the meaning that executes; changed
   context cancels safely — no mis-execution).
6. NO MODES THAT SHOULD BE BEHAVIORS: stealth is physical behavior, not a mode; presentation is
   physical verbs, not a cosmetics screen; anomaly is gesture + intent, not an ability menu. If a
   system's fiction is behavioral, its input must be behavioral.
7. DISCOVERY-GATED INPUT: input surfaces for emergent capabilities appear with the fiction's discovery
   phases, never before. Zero deliberate surface pre-discovery.
8. INPUT TRUST IS ABSOLUTE: degraded capability (strain, injury, suppression) degrades the EFFECT and
   the WORLD-PERCEPTION, never the control channel. No phantom presses, no fake latency, no inverted
   controls, no corrupted input as "feel." Fairness law applies (input/save/critical state trustworthy;
   bugs never mimicked).
9. EQUIPMENT ACCESS TIERS: glance layer (read), quick radial (≤ small cap of presentation verbs),
   time-live equipment wheel (kit; world keeps running; opening kit is an operational decision), base
   deliberate layer (safe organization). No field full-screen inventory that breaks immersion.
10. COMPANION COMMAND LAYER: requests, not orders. Small capped command sets. The companion remains a
    person with judgment; refusal is an authored outcome, not a failed input. No summon/puppet controls.
11. DIEGETIC PROMPTS: prompts belong to the world / equipment; one-shot; fade; never re-prompt without
    meaningful state change; never a permanent label layer on healthy UI.
12. ACCESSIBILITY IS MANDATORY, ASSISTS ARE BOUNDED: scaling / repositioning / opacity / colorblind
    glyph safety / left-handed mirror / controller parity / one-handed supported / sensitivity curves
    are required. Aim or other assists, if shipped, are player-side settings-layer features — optional,
    bounded, fiction-invisible, never character capabilities.
13. HARDWARE SCALING: baseline hardware + supported inputs are declared; layouts are safe-area and
    aspect aware; input adds no measurable simulation cost; input profiles live in settings, not in the
    world save.
14. OBSERVABILITY: input is logged as abstract actions with reasons (SOP-006 / BV-SKILL-015), enabling
    deterministic replay fixtures. Debug input surfaces stay dev-only and zero-gameplay-effect.
15. NO LICENSED OR COPIED LAYOUTS: reference games inform areas (per doctrine §33 discipline);
    protected UI layouts, glyph sets, or control schemes are never reproduced. Combinations must be
    original.
16. OBSERVABILITY (SOP-006 / BV-SKILL-015): every input-driven state must be explainable from action
    logs; the overlay stays zero-gameplay-effect; replay fixtures reproduce with the same action
    sequence.
17. COMPOSITION DISCIPLINE: this skill composes with 003 (controller), 004 (stance), 005 (traversal),
    006 (affordances), 007 (stealth), 008 (perception), 009 (assassination), 014 (atmosphere), 021
    (CQC), 030 (anomaly methodology), 032 (presentation), 034 (companion), 035 (operator identity),
    015 (observability). It duplicates and replaces none of them.

## WORKFLOW
1. Read the per-game bible to confirm the input layer's canonical scope; confirm no design duplicates
   per-game canon (positions, sizes, glyph art are canon-side, not methodology-side).
2. Confirm the abstract action vocabulary (existing project `InputMap` actions or successor) and freeze
   the mapping targets BEFORE designing any layout. The simulation never gains new action names for
   input-layer convenience.
3. Define the control budget: core cluster (minimum set), movement stack, contextual surface, and any
   gated layers (anomaly / companion / helmet). Apply the absorption rule — new controls must absorb or
   contextualize before adding.
4. Define touch ergonomics: two-thumb foundation, placement law (free zones for grip and center-of-
   interest), adjustable size/position/opacity, left-handed mirroring, safe-area/anchor definitions.
5. Define the contextual action surface: context table, priority resolution, CONTEXT-LOCK law, prompt
   layer behavior, signature costs of interactions.
6. Define behavioral stealth inputs: postures, cover interaction, analog noise discipline — no mode
   toggles.
7. Define gesture vocabularies for emergent layers: gesture grammar (hold / select / directional /
   recall / focus), discovery gating, interruption priority (defensive verbs interrupt cleanly), and
   the strain-vs-input-trust reconciliation (§8 / §9.4 in the canonical bible).
8. Define equipment access tiers (glance / radial / wheel / base), the time-live field law, and
   survival verb contextualization.
9. Define the companion command layer (request-not-order, capped commands, person-preservation).
10. Define HUD/input separation: the touch layer is NOT a HUD; mastery dissolves; feedback routes
    through world response / animation / body cues / symptom-first presentation.
11. Define accessibility input supports (mandatory list) and assist boundaries (player-side, bounded,
    fiction-invisible).
12. Define hardware scaling, input performance budget (no simulation cost), and input-profile save
    separation (settings, not world-save).
13. Define observability: abstract-action logging with reasons; replay determinism; dev-only debug
    surfaces.
14. Validate against: ABSTRACTION LAW; MINIMUM-INPUT BUDGET; CONTEXT-LOCK; INPUT TRUST; NO COPIED
    LAYOUTS; ACCESSIBILITY; PERFORMANCE; OBSERVABILITY.

## IMPLEMENTATION GUIDANCE
- Treat the input layer as an EVENT SOURCE, not a per-frame system: touch produces abstract actions;
  no simulation cost per frame beyond event handling.
- Analog movement magnitude is a first-class value (speed + signature coupling) — preserve it through
  every layer (touch stick magnitude must map identically to controller stick magnitude in effect).
- Context resolution: compute the candidate set, apply priority (safety > interaction), display both
  affordances when ambiguous, lock on press.
- Gesture recognition must be simple, bounded, and cancellable; defensive verbs interrupt and the
  partial action refunds per the cost model (§9.4 reconciliation in the canonical bible).
- Time-live interfaces (wheel / radial) must not pause the world in field contexts; base contexts may
  pause per future directive.
- Prompts: world-space / equipment-bound; one-shot; fade; re-prompt only on meaningful state change.
- Accessibility overrides must never be detectable in fiction, and assists must never grant fictional
  capability.
- Debug input visualizations (touch debug overlay) stay dev-only, zero-gameplay-effect.

## ANTI-PATTERNS
- Re-stating per-game layout canon inside this skill (creates duplicated lore).
- Layer-specific gameplay rules (touch-only affordances, controller advantages).
- Virtual button clutter / MMO action bars / floating ability wheels.
- A stealth MODE / an anomaly ability menu / a cosmetics screen in the field.
- Phantom presses, fake latency, or corrupted input as "feel" (input-trust violation).
- Permanent on-screen labels on healthy UI; touch controls rendered as HUD.
- Field full-screen inventory that pauses and breaks immersion.
- Companion controls that summon / puppet / order a person.
- Copied reference layouts or protected UI assets.
- Assists leaking into fiction as character capability.

## KNOWN FAILURE MODES
- Control creep: a new verb gets a permanent button — re-run the absorption rule.
- Context accidents: meaning changes mid-press — enforce CONTEXT-LOCK and safe cancel.
- Input-trust drift: "horror" latency or phantom behavior sneaks into strain feedback — STOP and
  re-anchor to invariant 8.
- HUD bleed: labels / prompts / indicators accumulate until the touch layer looks like a HUD —
  re-anchor to invariants 11 and 12.
- Wheel pause: opening kit pauses the world in the field — re-anchor to the time-live law.
- Companion puppetry: commands multiply past the cap or turn into orders — re-anchor to invariant 10.
- Accessibility regressions: an override changes gameplay or fiction — re-anchor to invariant 12.
- Determinism loss: raw touch values reach gameplay state — re-anchor to invariant 2.

## VERIFICATION
- Static: abstract-action mapping declared with no layer-specific rules; control budget documented with
  absorption rule; ergonomics (placement/adjustability/mirroring/safe areas) declared; contextual
  surface with context table + priority + lock law; behavioral stealth inputs (no mode); gesture
  vocabulary with discovery gating + interruption; strain-vs-input-trust reconciliation stated;
  equipment tiers declared with time-live field law; companion command cap + request-not-order;
  prompt layer one-shot/diegetic; accessibility list complete + assist boundary; hardware scaling +
  performance + save separation; observability (action logs with reasons; replay determinism);
  no copied layouts; no per-game canon in the skill.
- Cross-skill: no parallel controller, stance, traversal, affordance, stealth, perception, combat,
  anomaly, presentation, companion, or operator-identity systems invented; existing owners consumed.
- Tooling: run `tools/validate_methodology.py` and `tests/static_verify_game.py` after any canon change.
  Per-game bible's contradiction ledger should remain at zero contradictions.

## STOP CONDITIONS
If a designed input system introduces layer-specific gameplay rules, mode-based stealth/anomaly/
presentation, phantom or corrupted input as flavor, control clutter that violates the budget,
field full-screen inventory, companion puppetry, copied reference layouts, fiction-visible assists,
raw-touch gameplay reads, or per-game canon duplicated inside this skill — stop and re-anchor to this
skill's invariants and the per-game bible.

## RELATED SKILLS
- BV-SKILL-003 third-person-character-controller (movement / camera rig / input handoff — the
  simulation side this skill provides actions for)
- BV-SKILL-004 stance-system (stance states the movement stack drives)
- BV-SKILL-005 systemic-traversal (traversal affordances the contextual surface exposes)
- BV-SKILL-006 environmental-affordances (world tags the contextual surface consumes)
- BV-SKILL-007 stealth-and-concealment (signature channels interactions and movement emit)
- BV-SKILL-008 tactical-ai-perception (suspicion feedback the stealth layer reads)
- BV-SKILL-009 contextual-assassination (takedown resolve behind the contextual surface)
- BV-SKILL-014 mobile-graphics-atmosphere (tablet scale + hazard law)
- BV-SKILL-021 cqc-combat-architecture (combat verbs / defensive choice / AI-facing interfaces)
- BV-SKILL-030 anomalous-capability-architecture (gesture grammar composes with anomaly methodology)
- BV-SKILL-032 visual-presentation-architecture (HUD-as-equipment; camera methodology; presentation
  ownership — this skill owns the input layer it does not own)
- BV-SKILL-034 companion-relationship-architecture (companion person-preservation the command layer
  obeys)
- BV-SKILL-035 operator-discipline-architecture (action priority list this skill realizes as controls)
- BV-SKILL-015 gameplay-debugging-instrumentation (observability surfaces; SOP-006)
- D026 canonical bible = `docs/design/TOUCHSCREEN_INPUT_INTERACTION_ARCHITECTURE_BIBLE.md` (per-game
  canon this skill does not duplicate)
- developers-way, black-vector-project-doctrine (governing); SOP-004/006