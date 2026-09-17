# BLACK VECTOR

Edge-native third-person survival / stealth / tactical-action / psychological-horror game.
One large fictional Alaska-inspired coastal wilderness world. GDScript only, Android-tablet first, fully offline,
local-only — no accounts, no telemetry, no network dependency, no plugins.

## Status

- **Methodology (canon):** `doctrine/`, `sop/`, `skills/`, `tools/validate_methodology.py` — governing canon, SOPs, and
  a 27-skill fleet (Directive 010 added the visual/equipment doctrine skill; doctrine §41 freezes the military visual
  language before asset/enemy-family production; Directive 011-R added the four research skills — historical provenance,
  Alaska site/environment reference, weapon platform/role design, anomalous-consciousness — and the `docs/research/`
  ledger, gating all future historically-grounded work behind named sources and evidence classification;
  Directive 012 added the canonical lore bible `docs/lore/BLACK_HAND_PROVENANCE.md` (program-generation model G0–G8,
  Compound/Shade/nanobite lineages, divergence node, doctrine BV-D053–D058) as the provenance foundation for all
  island population/threat work; Directive 011 added the population/threat-ecology bible
  `docs/design/SIMSE_SOUND_POPULATION_THREAT_ECOLOGY.md` and skill BV-SKILL-027 (doctrine BV-D059–D063) freezing
  Shade network truth, the ability contract, Hidden Hand survivor framework, and the horror budget;
  Directive 013 added the weapon/rifle-family & battlefield-equipment bible
  `docs/design/WEAPON_RIFLE_FAMILY_BIBLE.md` (doctrine BV-D064–D070) freezing 11 long-gun families, the Shade
  S-line, the Layered Overwatch kit, the Benefit/Cost/Failure/Dependency model + 10 handling axes, reclamation,
  and the psionic projectile-correction boundary — design architecture only, no weapons implemented;
  Directive 014 added the opening bible `docs/design/HIDDEN_HAND_PROLOGUE_BIBLE.md` (doctrine BV-D071–D078,
  BV-SKILL-028) freezing the icon→brother→fractured-veteran→killer→prisoner→subject→survivor spine, the Layered Overwatch
  opening loop, the no-paranormal grounded opening, the legal/prison/death-row arc, the player-knowledge gate
  table, agency/pacing law, and the S-1 awakening hand-off — narrative architecture only, no cinematics/implementation;
  Directive 015 added the world-system bible `docs/design/SIMSE_SOUND_SURVIVAL_ENVIRONMENT_HORROR_BIBLE.md`
  (doctrine BV-D079–D086, BV-SKILL-029) freezing the systemic island (four overlapping islands, survival-state
  architecture, weather/storm law, infrastructure consequence law, bounded world-state propagation, community
  liability law,   the five-facility restoration network, horror/certainty + fairness law, threat taxonomy, Saga-1
  containment + seam budget) — world architecture only, no gameplay systems implemented).
  Directive 016 added the anomalous-capability bible `docs/design/ANOMALOUS_CAPABILITY_BIBLE.md` (doctrine
  BV-D087–D095, BV-SKILL-030) freezing governing power identity (HUMAN SKILL × ANOMALOUS ASSISTANCE × CONTEXT),
  no-mana law, mass/range/complexity law, FIVE-phase discovery progression, the earned "first undeniable event"
  constraint, the Superhero-Prevention Matrix, path persistence/switching rules, presentation language
  (visual/audio/body/HUD), and   cross-system integration — gameplay architecture only, no VFX/implementation).
  Directive 017 added the reclamation + persistent-character-state bible
  `docs/design/PLAYER_RECLAMATION_PERSISTENT_CHARACTER_STATE_BIBLE.md` (doctrine BV-D096–D104, BV-SKILL-031)
  freezing the 5-stage arc (LEGEND→BROKEN SURVIVOR→RELEARNING→RECOVERING OPERATOR→INTEGRATED HAND), the
  three capability origins (RECOVERED/LEARNED/INTEGRATED), the LIVING SAVE FILE persistence law, the bounded
  state channels (BODY/HAIR-FACE/CLOTHING/ARMOR/WEAPONS/ENVIRONMENTAL-RESIDUE), the visible-state →
  consequence → response design law, the grooming + base-grooming systems, the animation-evolution ladder, the
  accessibility overrides, and the tablet-feasible persistent-state architecture — gameplay/visual architecture
  only, no VFX/implementation).
  Directive 018 added the Season-1 campaign & mission spine
  `docs/design/SEASON_1_CAMPAIGN_MISSION_SPINE.md` (doctrine BV-D105–BV-D113) arranging the existing canon
  into PROLOGUE + ACT I SURVIVE + ACT II UNDERSTAND THE PROGRAM + ACT III THE ISLAND OPENS + ACT IV
  CONVERGENCE + FINALE/EPILOGUE, with F1 Gyle Cannery as first stable anchor, sequenced facility
  dependencies (mandatory/optional/gated/loopback), human threat escalation, rising-significance Memory
  Bleed pacing, Compound/Independent path placement, and the REAL → MILITARIZED → CLASSIFIED → EXPERIMENTAL
  → IMPOSSIBLE   escalation — arrangement only, no new capability canon).
  Directive 019 added the visual production / HUD / presentation bible
  `docs/design/VISUAL_PRODUCTION_HUD_PRESENTATION_BIBLE.md` (doctrine BV-D114–BV-D122, BV-SKILL-032)
  freezing the visual identity (5-second recognizable test), camera system (3P shoulder + FP body-presence +
  transitions + weather/injury effects), helmet/visor three-layer system (passive/tactical/anomalous +
  hardware identity), HUD-as-equipment ownership philosophy (wrist device / helmet passive / world HUD;
  no MMO meters / no floating numbers / no happy-gauges), per-state survival HUD presentation rules, the
  character visual evolution ladder, clothing/armor/weapon + grooming visual language, per-facility
  environment visual bible (F1-F5 identity contracts), weather/horror/sound presentation language,
  animation-priority tiers, signature-moment catalog, and the tablet-performance law for visual
  production — visual architecture only, no VFX/implementation).
  Directive 020 added the vertical-slice implementation specification
  `docs/design/VERTICAL_SLICE_IMPLEMENTATION_SPECIFICATION.md` (doctrine BV-D123, BV-SKILL-016 vertical-slice-
  discipline owning slice scoping methodology) freezing the slice geography (S-1 Strand awakening → coastal
  approach → F1 Gyle Cannery + ONE interior hot-load per D018 §39), the nine required experience moments
  (awakening · first survival problem · exploration · first human encounter · first combat test · first
  community contact · restoration beat · first anomaly seed), per-system implementation spec (character /
  camera / helmet / HUD / world / AI / audio / persistence / observability), production boundaries
  (INCLUDED / EXCLUDED), acceptance criteria + deterministic fixture, NO new methodology skill, no
  implementation without SOP-003 — specification only, no game/ modifications).
  Directive 021 added the combat architecture bible `docs/design/COMBAT_ARCHITECTURE_BIBLE.md` (doctrine
  BV-D124, NO new methodology skill; BV-SKILL-021 retains CQC ownership) deepening the D008/D009 architecture
  with the 7-step player-perception loop (OBSERVE → ASSESS → COMMIT → EXCHANGE → ADVANTAGE/DISADVANTAGE
  → BREAK/RECOVERY → RESOLUTION), five-tier human threat architecture (Tier 0 civilians · Tier 1 desperate
  survivors · Tier 2 trained humans · Tier 3 elite threats · Tier 4 unknown/anomalous), player combat
  model (no button-combos), injury + survival integration, AI combat doctrine (no omniscience; no
  "enemy knows player location"), weapons + tools categories (no loot spreadsheet), and the combat
  acceptance fixture (deterministic; companion test to D020 §4.5) — combat architecture only, no
  implementation).
  Directive 022 added the AI / faction / enemy architecture bible
  `docs/design/AI_FACTION_ENEMY_ARCHITECTURE_BIBLE.md` (doctrine BV-D125, BV-SKILL-033 enemy-architecture
  methodology-only) deepening D021 §7 AI doctrine with the 7-faction taxonomy (Black Hand Remnants ·
  Island Survivors · Security/Recovery Teams · Researchers · Contractors · Escaped Subjects · Criminal
  Networks [optional]) each with goals / resources / leadership / tactics / equipment / morale /
  weaknesses; enemy psychology frozen (fear · surrender · retreat · negotiation · betrayal · desperation
  · loyalty — most memorable encounters should sometimes end without killing); AI perception state
  machine frozen (UNAWARE → SUSPICIOUS → SEARCHING → TRACKING → ENGAGED → LOSING CONTACT → RETREATING —
  bounded; no omniscience; knowledge-with-source); squad behavior frozen (radio dependency · command
  structure · panic when leaders die · fallback · mistakes); 8 human enemy archetypes frozen (frightened
  survivor / desperate scavenger / disciplined security operator / tracker / sniper / medic / engineer /
  commander — actual people not enemy classes); Black Hand / Shade distinction frozen (information ·
  coordination · sensory integration · discipline — NOT armor / damage); boss philosophy frozen (unique
  people · unique situations · history · preparation · consequences — no giant health bars · no bullet
  sponges · no arena fights); wildlife / human / threat ecology interaction; slice enemy package
  (INCLUDED / EXCLUDED) — enemy architecture only, no implementation).
  Directive 023 added the companion / relationship / Shade reclamation bible
  `docs/design/COMPANION_RELATIONSHIP_SHADE_RECLAMATION_BIBLE.md` (doctrine BV-D126 + BV-D127 Shade
  Reclamation Correction per user's canon correction packet — the Shade IS a separate victim of the same
  machine, NOT a failed version of The Hand; D023 §2 supersedes D022 §7.4-§7.5 narrow Shade framing;
  BV-SKILL-034 companion-relationship-architecture methodology-only) freezing the Companion Shade
  architecture (control chain OPERATOR → CONTROL GAUNTLET → ENCRYPTED NEURAL COMMAND → IMPLANT →
  SHADE NERVOUS SYSTEM OVERRIDE; visual identity = Metal Gear cyborg ninja + stealth operator + military
  assassin + controlled human weapon; relationship progression Stage 1 "Awaiting command" → Stage 5 "I
  choose"; companion rules = NOT summon / NOT helper / NOT weapon upgrade, IS damaged person learning
  humanity; combat capability preserved; base-anchored; companion makes choices); community relationship
  system (survivor trust progression UNKNOWN → STRANGER → GUEST → NEIGHBOR → KINDRED; relationship-index
  per cluster; community remembers); Second-in-Command bond (UNRESOLVED → BROTHERHOOD — doctrine §25
  scene lock deepens; BROTHERHOOD not romance); Hand's guilt channel + effect on relationships + visual
  language carrying D017 §36 animation-evolution ladder; moral consequences (saved-people outcomes + kill
  outcomes + mercy consequences — Pillar 3 RESPONSIBILITY); memory bleed integration with relationships
  (trigger anchors + content relationships + frequency relationships — bleed as CHARACTER MOMENT, not horror
  event); base relationships; Companion personality evolution; psychological tone references = Man on Fire +
  Shutter Island + MGS3 + MGS4 (avoid simple revenge / superhero transformation / chosen-one mythology) —
  companion / relationship / reclamation architecture only, no implementation).
  Directive 025 added the operator identity / military discipline / combat expression bible
  `docs/design/OPERATOR_IDENTITY_COMBAT_DISCIPLINE_BIBLE.md` (doctrine BV-D130, BV-SKILL-035 operator-
  discipline-architecture methodology-only) freezing the operator identity philosophy (the seven
  advantages — information advantage · patience · preparation · observation · precision · battlefield
  understanding · controlled violence — "the Hand wins fights BEFORE they begin"), the military
  lineage (Scout Sniper · Reconnaissance · Forward Observation · Intelligence Collection · Precision
  Engagement · Stealth Operations), the six military competencies (Overwatch Reconnaissance · Scout
  Sniper · Forward Observer · Covert Operations · Close Quarters Combat · Direct Action Recovery — NOT
  RPG classes, with four levels UNTRAINED / DEVELOPING / PROFICIENT / MASTERED), the player expression
  model (three example expressions — the patient hunter, the closer-range operator, the anomaly-integrated
  operator; variation through USE not class selection), no-XP progression (use · experience · training
  · mentorship · recovered memory · equipment familiarity · surviving situations · relationships;
  FORBIDDEN skill points / arbitrary unlocks / damage percentages / level numbers / experience bars),
  combat technique architecture (behaviors not abilities), weapon relationship system (familiarity ·
  maintenance · history · modification · emotional attachment · field adaptation — weapons tell stories
  and persist), anomaly integration with competencies (the anomaly MODIFIES operator skill; bounded by
  D016 §48 + §49), physical character evolution (BROKEN PRISONER → SURVIVOR → RECOVERED OPERATOR →
  UNIQUE PLAYER EXPRESSION aligned with D017 §3 ladder), touchscreen action priority (movement / aiming
  / stealth / interaction / equipment / companion commands / grooming / anomaly control — informs D026) —
  operator identity architecture only, no implementation).
  A 35-BV-skill fleet now validates clean (2 governing + 35 BV skills, 6 SOPs).
  Directive 026 added the touchscreen input / interaction architecture bible
  `docs/design/TOUCHSCREEN_INPUT_INTERACTION_ARCHITECTURE_BIBLE.md` (doctrine BV-D131, BV-SKILL-036
  touchscreen-input-architecture methodology-only) freezing the control philosophy ("minimum input,
  maximum intent"; the touchscreen is an extension of the operator's body), movement architecture
  (left-thumb analog stick; adjustable size/position/opacity; left-handed; walk/jog/sprint/crouch/prone;
  stealth speed control / injured movement / exhaustion / terrain), camera / aim architecture (right-thumb;
  3P + FP + helmet view; scoped reference combination frozen as original per doctrine §33), the core
  combat cluster (fire / aim / reload / crouch / interact / weapon swap / melee / defensive move — no
  combos), the contextual action system (one surface many meanings; context-lock; diegetic prompts),
  stealth controls (no stealth mode — physical behavior), anomaly controls (gesture vocabulary; discovery-
  gated; strain degrades effect not input trust), equipment access tiers (glance / radial ≤6 / time-live
  wheel / base locker), companion Shade commands (request-not-order; max six; person-preservation),
  grooming/presentation interactions, HUD integration (touch layer is NOT the HUD; mastery dissolves it),
  accessibility (mandatory supports + bounded assists), and the input abstraction law (one simulation
  layer, different input layers — existing InputMap actions preserved) — input architecture only, no
  implementation).
  Directive 024 completed the dynamic world / island state / persistent simulation bible
  `docs/design/DYNAMIC_WORLD_ISLAND_STATE_PERSISTENT_SIMULATION_BIBLE.md` (canonical reference row
  BV-D128 unfrozen/finalized) freezing the world as a STATE TRACKER + AUTHORED CONSEQUENCE INJECTOR, not a
  continuous simulation: world-state channels (TIME_OF_DAY / WEATHER / STORM_EVENT / FACILITY_STATE /
  FACTION_PRESENCE / PATROL_STATE / COMMUNITY_STATE / TRAVEL_RISK / WILDLIFE_SIGNAL / RESOURCE_PRESSURE /
  LOCAL_AFTERMATH — save-persistent; deliberate non-tracks enumerated), time-as-day-windows + rest-as-
  tactical-choice, weather as systemic punctuation with route/patrol/wildlife consequences, region-state
  and travel-risk, bounded faction-reaction + propagation + memory (D022 composed), community-state
  evolution, F1–F5 facility causal maps, patrol/occupation/aftermath model (no respawn; alert escalation;
  scene persistence; quiet windows), wildlife signal bands as environmental information, dynamic side-
  content structure (state-driven instances, consequence-bearing, no spawner), bounded player-path world
  response (no global reputation bars), island memory (the world remembers deeds through its own state),
  restoration permanence, daily rhythm, SOP-006 observability, diegetic world information surfaces (no
  lobby / no mission select / the island IS the progression system), and SYSTEM LAW vs CANDIDATE CONTENT
  separation — world architecture only, no implementation, no new skill (specialist skills own the
  procedures: BV-SKILL-013/015/017/020/027/029/031/033/034 compose).
  Directive 027 delivered the vertical slice playable-proof specification
  `docs/design/VERTICAL_SLICE_PLAYABLE_PROOF_SPECIFICATION.md` (canonical reference row BV-D132) — the
  FIRST-PLAYABLE-PROOF slice: composes the D020 anchor spec as immutable base + the frozen D021–D026 canon
  into one continuous S-1 → F1 Gyle Cannery walk (no lobby / no map screen / island-as-progression).
  It freezes the four-layer player-fantasy proof (broken prisoner / survival instinct / recovering
  operator / overwatch recon identity — read through choice, never numbers), the required systems
  (PLAYER movement/camera/touch/body/inventory/equipment + WORLD streaming boundary/weather/time/env-
  interaction/persistent changes + COMBAT observation/decision/engagement/injury/recovery + ENEMY one
  Tier 1 desperate survivor + one Tier 2 trained human + ANOMALY discovery-only one MICRO bleed/echo seed,
  zero power code + COMPANION Shade deferred), the engineering contract for D027-EXEC (Godot scene
  structure / system-boundary table / single-store data ownership / save-state manifest / input abstraction
  to the existing 22 InputMap actions / mobile constraints <1200 nodes ~1–2 km² 200–260 MB gl-compatibility /
  ONE deterministic acceptance fixture), the exact 10-step development order with explicit gates, and the
  nine-step player acceptance test — specification only, no implementation, no new skill (BV-SKILL-016 owns
  slice discipline; all layers already covered).
  A 36-BV-skill fleet now validates clean (2 governing + 36 BV skills, 6 SOPs).

  See `docs/methodology/README.md` for the reading order.
- **D028 — Protagonist canon lock (DESIGN/CANON ONLY, no code):** `docs/lore/CORLEY_ALEXANDRA_FERRELL_BIBLE.md`
  freezes the authoritative protagonist — **Corley Alexandra Ferrell / THE HAND** (female): canonical identity,
  pre-fall personality, Hidden Hand family bond, manufactured civilian family, Compound collapse, the family
  killings, public mythology, prison transformation, death-row diversion, island awakening, voice/humor doctrine,
  reclamation arc, Shade/teammate/anomaly boundaries, the Hidden Hand photograph, and the full
  contradictions/supersession matrix (all prior male-coded protagonist renderings **SUPERSEDED**). Doctrine `BV-D152`.
- **D029 — Program-history canon lock (DESIGN/CANON ONLY, no code):**
  `docs/lore/BLACK_HAND_GENERATIONS_SHADE_BIBLE.md` freezes BLACK HAND as a multi-generation program (four eras
  across the preserved G0–G8 codename chain); Corley as prime benchmark of the Hidden Hand generation (not first
  subject, not program origin); **Hidden Hand synchronization EMERGENT** vs **Shade synchronization ENGINEERED**;
  the Hidden Hand control failure, post-service collapse and recovery doctrine; the six-Shade cohort; implant
  (presumed-fatal removal) and gauntlet modes/disengagement limits; isolation and emerging personhood; Shade voice;
  the full Corley–Shade arc from coercion to chosen trust; the surviving former second-in-command; and the
  contradictions/supersession matrix. Doctrine `BV-D153`.
- **D030 — Psychological canon lock (DESIGN/CANON ONLY, no code):**
  `docs/lore/PSYCHOLOGICAL_HORROR_MEMORY_ANOMALY_BIBLE.md` freezes the rules of experience — core horror
  principle (**trust the world, question interpretation**), the four truth layers
  (`OBSERVABLE_REALITY` / `SPOKEN_CORLEY` / `INNER_CORLEY` / `INTRUSION_OR_UNKNOWN`) and the player trust
  contract (no sanity meter; controls/saves/mechanics never invalidated; "the clues were there"), Corley's
  four competing psychological layers, inner-voice doctrine, Memory Bleed rules and memory-reliability law
  (memory emotionally true but factually incomplete; never randomly false), Compound interpretation, anomaly
  origin/philosophy, neural-cost philosophy, the three-wound model (Corley = identity/memory; Shade =
  agency/control; SECOND = perception/reality), the SECOND's deep perceptual architecture, reality-ambiguity
  rules, horror escalation, the central question, and the contradictions/supersession matrix. Doctrine
  `BV-D154`. D031 owns the Season-1 reveal; after D031 lore expansion stops and production resumes.
- **Game (Directive-002 BV-001A, Directive-006 BV-001B, Directive-007 BV-001C, Directive-009 BV-D041, D027-EXEC BV-D133):** `/black-vector/game` —
  Godot 4.x project with graybox movement/traversal lab, player-identity sandbox (tactical movement,
  signature emission, ledge traversal), a single-observer perception & hunting prototype (vision + hearing sensors,
  knowledge/suspicion ladder, investigation movement), and a bounded CQC proof slice (CombatController: CONTACT/RANGE
  seeds, Control/rage/stamina/posture; one TrainingOpponent in the sandbox arena). **D027-EXEC foundation placed** (input
  abstraction layer + runtime managers + GameWorld services locator + player body/animation-state foundation + S-1 Strand
  test scene + slice_main entry scene + observability rewrite — static verify CLEAN 35/0). **RUNTIME PENDING** — the
  engine binary is not available in this environment; nothing in `game/` has been executed. See the runtime checklist below.

## Layout

```
/black-vector
├── .git/            (initialized, zero commits — commit not authorized yet)
├── .gitignore
├── README.md
├── docs/            (methodology index + Directive-004 world-foundation reference)
├── doctrine/        (Developer's Way + Project Doctrine canon)
├── sop/             (SOP-001..006)
├── skills/          (BV-SKILL registry + tools)
├── tools/
├── game/            (Godot project; main scene = slice_main.tscn)
│   ├── project.godot
│   ├── icon.svg
│   ├── scenes/{player,movement_lab,sandbox,slice,world,ui,ui_core,ai}/
│   ├── scripts/{player,world,ui,ui_core,ai,slice,input}/
│   ├── resources/   (stances.tres — single source of stance data)
│   ├── data/        (runtime data layout docs; saves written to user:// at runtime)
│   └── assets/      (reserved; no art assets yet — primitives only)
└── tests/
    └── static_verify_game.py
```

## Opening the project

1. Open `/black-vector/game/project.godot` in Godot 4.x (GDScript, **GL Compatibility** renderer).
2. Run the main scene `res://scenes/slice/slice_main.tscn` (S-1 Strand foundation slice — GameWorld services locator,
   world channels seeded, player, debug overlay). Or run `res://scenes/sandbox/bv001b_alaska_sandbox.tscn` (identity
   sandbox) or `res://scenes/movement_lab/bv001a_movement_lab.tscn` (original lab).
3. Desktop dev keys: WASD move, mouse look (F1 toggles capture), Space jump/mantle/vault, E interact/climb,
   C crouch, Z prone, Shift sprint, **1/2/3 tactical SILENT/NORMAL/AGGRESSIVE**, F2 debug overlay,
   **R reset observer**, **F5 save / F9 load** (slice test), **Backspace reset opponent**. CQC slice: **J attack**, **K guard**.
4. Touch head for tablet: gameplay input is read only through the `InputMap` actions declared in `project.godot`;
   the touch adapter (`scripts/input/touch_input_adapter.gd`) maps raw touch → the same abstract actions
   (move vector + look vector); the input layer is the single translation point below the simulation (D026 law).

## Runtime validation checklist (required in the Godot Android Editor)

Controller foundation (Directive-006 A):
- Project loads with no script parse errors; main scene runs.
- Stance transitions change capsule + camera height and speed; headroom refusal works under the perch.
- Sprint only from the stand stance (SILENT profile blocks sprint).
- Acceleration/deceleration feel committed; slope walking decelerates on the SteepHill.

Tactical movement (B):
- 1/2/3 switches SILENT/NORMAL/AGGRESSIVE; SILENT is slower and quieter, AGGRESSIVE faster and louder.
- Movement reads as trained/controlled, not generic (see overlay: MOVEMENT/STANCE/TACTICAL/SPEED).

Traversal (C):
- Mantle (table ≈0.9 m), vault (fallen log ≈0.5 m), climb (E on trees/roof reach/rock/column).
- LEDGE: grab the StructureFloor lip (1.35 m) and CliffShelf (1.4 m) with Space into the jump,
  shimmy with A/D, Space to pull up, C/Z to drop.
- No free climbing — only authored affordances + the geometry ledge band.

Signature foundation (D):
- Overlay VISIBILITY/NOISE change with stance, tactical profile, cover (under canopy/inside structure/behind rock)
  and landing. Emission only — nothing consumes these values yet.

Test environment (E):
- Forest area, abandoned structure (roof overwatch), vertical terrain (cliff ladder, perch, hill),
  concealment areas (bush, canopy, rock shadow), climb opportunities all reachable from spawn.

Debug (F): overlay (F2) reports MOVEMENT/STANCE/TACTICAL/SPEED/GROUNDED/TRAVERSAL/VISIBILITY/NOISE/CONTEXT
plus an AI line (state/posture/SUSP/CONF/LKL/gist); overlay ON does not change gameplay.

Perception & hunting (Directive-007 G/H):
- Observer starts idle at (10,0.9,2) watching the structure; NORMAL → CURIOUS → ALERT → SEARCHING → COMBAT_READY.
- Vision: stand in open ground in front of the observer → ALERT at range; duck under canopy → lower detection;
  crouch/probe behind cover → OB server loses sight and drops to SEARCHING.
- Hearing: sprint/land/clamber events pull the observer toward a *scattered* position ("something near the
  structure"), never the exact spot. Move slowly in SILENT (1) to ghost past.
- Investigation: observer walks to cover/search markers, dwells, keeps looking; **R** resets it to idle.
- Stealth loop check: observe → approach → avoid → manipulate(constantly change height/cover) → escape — the
  observer must be able to lose you and you must be able to lose it.
- GL Compatibility path is what actually runs (verify via the editor's renderer indicator), not Forward+.

CQC proof slice (Directive-009/BV-D041):
- Player spawns near the opponent (6,0.9,-2). Hold **K** to guard, hold **J** to attack in range; entering range with
  hostile intent (attack/guard held) acknowledges ENGAGE. The opponent reserves or attacks and the CONTACT/RANGE states
  advance (overlay: COMBAT line, OPP line).
- Rage: absorb a few hits with control breaking at or below 0.22 → RAGE[trigger] with raised commitment; verify it
  reads violent-but-tactically-worse (overcommit, stamina burn, degraded guard-deflect) and cools only after 1.0 s clean
  at control ≥ 0.35. **Backspace** resets the opponent to its home position.
- Deflect: guard *before* the opponent telegraphs to deflect; guarding only at the last instant (or while raging) eats
  the hit as failed defensive timing.
- Pin/break: land pin from OFFENSIVE initiative while opponent posture is low; break out with K in opponent CONTROL
  (BREAK → READ). RESOLUTION/RESET conclude and return to READ.
- Control bands read COMPOSED / FRAGILE / BLEEDING; pressure and cornered (clinch + pressure + posture ≤ 0.5) drain it,
  host events punish above, and it recovers slowly when clean.

D027-EXEC slice foundation (BV-D133, main scene `slice_main.tscn`):
- Boot: project loads with no script parse errors; main_scene boots to SliceMain; world channels seeded in overlay
  (seed/TIME/WEATHER/FACILITY/AFTERMATH + player body bands).
- Move/camera: player walks/jogs/sprints, stance C/crouch Z/prone, camera 3P follows, F2 overlay reflects
  MOVEMENT/STANCE/SPEED.
- Input abstraction: touch zones (left move / right look) drive the same abstract actions as WASD; no raw-input
  path into simulation (none outside `scripts/input/`, presentation camera exempted).
- Save/load: **F5** writes `user://saves/slice/slot_00.save` (LIVING SAVE v1 manifest); **F9** restores it; verify
  re-seed matches and position/body restored; prompt host shows contextual action when facing the ClimbBlock (E).
- Deterministic baseline: fixed `slice_seed` reproduces the same world channel initialization and body state on reload.
- Performance (Android tablet, GL Compatibility): record FPS, `user://` working set (~200–260 MB target), loading
  behavior, and node counts (static node census in slice scenes = 12). Device-run QAT is the acceptance venue.

## D027-EXEC Phase 2 — Runtime foundation verification

Proves the Phase 1 skeleton on a real Godot runtime. No combat / AI / art / narrative additions.

Automated gate (deterministic subset) — EXECUTED, PASSING (Godot 4.7.2 headless):
```
godot --headless --path game res://scenes/slice/foundation_self_check.tscn
```
Expected: `TOTAL: 10 pass / 0 fail`, exit code 0, zero script errors. Coverage —
project boot · main scene = slice_main · autoloads InputManager+Settings · input abstraction
(all abstract actions bound, touch adapter live) · keyboard/controller adapters present ·
GameWorld+WorldState live · CameraRig present · save/load round-trip on `slot_254.save`
(write → verify manifest → load → world + body + seed + player position restored, player relocated) ·
GL Compatibility active.

Manual gate (functional, on-device):
- `slice_main.tscn` boots to SliceMain; overlay (F2) shows seed / TIME / WEATHER / FACILITY / body bands.
- Move: WASD (or both-thumb touch — left move zone / right look zone). Crouch C, prone Z, sprint Shift.
- Dual-thumb latch cases (run explicitly): hold movement, drag the look thumb out of its region and release
  there — camera must stay re-acquirable; repeat reversed with the move thumb — movement must stay cleared.
- Touch contextual control: hold the context strip (right side, x 72–98%, y 26–42% of the screen) to press
  `interact`; the ClimbBlock carries `affordance = "climb"` — approach it, the prompt shows, hold the strip to
  climb. Release must clear input; retreating must return the context to neutral; a second approach must work.
- Camera follows from the 3P rig; right-thumb drag drives look.
- Bluetooth controller: left stick move, right stick look.
- F5/F9 are debug-surface keys (keyboard only); on touch-only hardware run `foundation_self_check.tscn`
  natively instead — its on-screen result covers the save/load round trip deterministically.
- Touch dispatch failure cases (outside-zone releases both sides, cross-zone drag, two-cycle interaction)
  are pre-verified headless: 20/20 assertions — BV-D137.
- Movement calibration protocol (use if a re-test still flags movement): measure full-stick traversal over
  the 20 m floor — elapsed time → m/s → compare against the stand-speed target (5.0). Adjust ONE variable
  only: `max_speed` (stances.tres) if traversal speed is wrong · `move_stick_radius` if reaching full input
  is difficult · `analog_speed_floor` if partial movement is too weak. Camera values stay frozen.

Failure rule (per directive): STOP at first failure, identify root cause, repair ONLY the failed boundary,
rerun. Device-run remains the acceptance venue; the headless pass does not replace touch/controller QA.

D027-EXEC ladder status: Phase 1 COMPLETE · 2.1 Runtime gate COMPLETE · 2.2 Capability investigation COMPLETE ·
2.3 Human device gate COMPLETE · 2.4 Movement calibration COMPLETE · 2.5 Movement validation ACCEPTED ·
STEP 1 Player Controller & Body Expression IMPLEMENTED · STEP 2 Interaction/Environmental/Survival Foundation
IMPLEMENTED · STEP 3 Survival Condition & World Pressure IMPLEMENTED · STEP 4 Operator Equipment & Field System
IMPLEMENTED · STEP 5 Reconnaissance & Observation Foundation IMPLEMENTED · STEP 6 Stealth Foundation & Signature
System IMPLEMENTED · STEP 7 Tactical Positioning & Cover Foundation IMPLEMENTED · STEP 8 Tactical Route Planning
& Approach Foundation IMPLEMENTED · STEP 9 Human Presence & Threat Foundation IMPLEMENTED · STEP 10 Human
Perception, Awareness & Search Foundation IMPLEMENTED (BV-D150, candidate `af4eeb37…044`) · STEP 11 First
Contact, Human Reaction & Inner-Narrative Foundation IMPLEMENTED (BV-D151, candidate `9c0cc96e…9c`) — device
verification pending.
Awareness: presence_01 perceives only world truth — FOV + LOS sight (requiring the Hand's existing visibility
signature), STEP 6 sound traces (approximate points), physically discoverable footprints/moved objects with
weather aging authority. States UNAWARE→SUSPICIOUS→SEARCHING→TRACKING→LOSING_CONTACT with mandatory genuine loss;
TRACKING ≠ HOSTILE (authority rule frozen). Field readback shows behavior phrases only; exact state in the dev
overlay PRESENCE line. Awareness persists (mutation-discard proven).
Contact: ContactManager owns what is occurring BETWEEN the Hand and a human (NO_CONTACT→MUTUAL_AWARENESS→
CAUTIOUS/FEARFUL/COMMUNICATING/DISENGAGING→WITHDRAWN), separate from awareness (what the human perceives) and
human_records (what the Hand knows). Contact requires credible mutual recognition — not footprints/noise/search
alone. Physical behavior changes outcome (calm approach→CAUTIOUS · sprint→FEARFUL→DISENGAGING · back away→
WITHDRAWN); no charisma/intimidation/relationship meters. Narrative runs on four isolated channels — observable
reality, spoken Corley (NPCs hear), inner Corley (player-only, inaudible to NPCs), and intrusion/unknown
(interface only) — and may question memory/identity/causality but never lies about mechanical reality. Persists
(occurred/outcome/position/communicated/withdrew; ephemeral reaction discarded).
Still no combat, weapons, enemies, AI decision trees, damage, takedowns, Shade, anomaly, inventory UI, crafting,
progression, or dialogue.

Static verification lives in `tests/static_verify_game.py`; methodology validation is `tools/validate_methodology.py`.