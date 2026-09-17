# BLACK VECTOR — VERTICAL SLICE PLAYABLE-PROOF SPECIFICATION (D027)

> Directive-027 deliverable. The FIRST-PLAYABLE-PROOF specification: converts the frozen design canon
> D001–D026 into the smallest complete, provable slice of the game. SPECIFICATION ONLY — not implementation,
> not production, not code, not game-file modification, not commits.
> Authority: THE DEVELOPER'S WAY -> doctrine -> SOP -> skills -> D001..D026 (full frozen canon, incl. D020
> vertical-slice anchor, D021 combat, D022 enemies, D023 companion, D024 dynamic world, D025 operator
> identity, D026 touchscreen input) -> this document.
> D020 (`docs/design/VERTICAL_SLICE_IMPLEMENTATION_SPECIFICATION.md`, Directive 020, doctrine BV-D123)
> remains the IMMUTABLE anchor for the slice's geography, required-experience loop, production boundaries,
> acceptance criteria, fixture design, and observability contract. D027 COMPOSES the full D001–D026 canon
> around that anchor and finalizes the first-playable-proof slice; it does not rewrite D020.
> GAME IMPLEMENTATION STARTED: NO.

---

## 1. Preserved canon — DO NOT REOPEN OR REWRITE (frozen)

The user's D027 directive issues an explicit list of canon that must be PRESERVED. D027 composes around
this canon; it does not redesign it.

- **The Hand identity** — military operator, overwatch/recon/scout-sniper lineage, prison-built body,
  seven advantages, six competencies, no-XP progression (doctrine §14-§18 / D025 / BV-D130). Unchanged.
- **Opening timeline** — last Hidden Hand mission → collapse at home → prison/death row → covert diversion
  → island transfer → experimentation → awakening (D014 §1/§29; doctrine §29). Unchanged.
- **Death Row → Island transition** — prologue handoff ends at S-1 Strand awakening, STAGE 1 BROKEN
  SURVIVOR (D014 §26 / D017 §3 / D020 §3.1). Unchanged.
- **Anomaly origin** — Compound science, post-island, discovery-gated phases, no pre-island anomaly (D016
  §7 / D012 §10-§12 / D017). Unchanged.
- **Shade architecture** — separate victim of the same machine; companion rules, request-not-order, no
  summon, not in first slice (D023 / BV-D126 / BV-D127 / D022 §2 [Shade distinction]). Unchanged.
- **Combat philosophy** — grounded military + preparation-first + decisions-not-combos +
  consequence-honest + tension-not-twitch (D021 / doctrine §35.1). Unchanged.
- **Dynamic island philosophy** — state tracker + authored consequence injector; not a sim monster; island
  is the game (D024 / BV-D128). Unchanged.
- **Touchscreen controls** — "minimum input, maximum intent"; the slice's touch layout must realize D025
  §9 action priority as D026 (§16) (D025 §9 / D026 / BV-D036). Unchanged.

D027 adds NO new player/enemy/anomaly/companion fiction. It is the ENGINEERING-OF-PROOF directive.

---

## 2. Player-fantasy proof (frozen)

The slice must prove ONE thing: the four-layer operator fantasy, playable and legible (BV-SKILL-016
invariant 2 — "the slice is an EXPERIENCE, not a list"). The one-sentence elevator proof for D027:

> **"A broken prisoner wakes on a frozen coastline, claws his way through weather and one hostile man
> toward a dark cannery, and dies or lives by what he chose — and something is wrong that he cannot yet
> name."**

The four layers map onto canon:

| Fantasy layer | Canon source | What the slice must make the player FEEL |
|---|---|---|
| BROKEN PRISONER | D017 §3 STAGE 1; D014 §1; doctrine §29 | powerlessness, cold, disorientation, a body that fights him, survival as the only goal |
| SURVIVAL INSTINCT | D015 substrate; doctrine §30; BV-SKILL-017 | cold/wetness/fatigue are real pressure; shelter is a decision; the world is indifferent |
| RECOVERING OPERATOR | D017 §3; D025 identity; D021 | the operator re-asserts through discipline, not numbers — steadier hands, reading the land |
| OVERWATCH RECONNAISSANCE IDENTITY | D011 §4; D025 seven advantages; D021 7-step loop | observe, assess, commit, advantage, break — the fantasy of seeing and choosing, not of shooting |

Frozen rule: all four layers are present at once in the FIRST hour; the slice does not sequence them into
acts — the same walk-to-cannery loop exercises all four (broken body + cold pressure + operator reading +
recon decision).

---

## 3. Slice location & required moments (frozen — composes D020 §3/§4)

D020 freezes the geography. D027 re-states it as the playable proof's stage and REQUIRES the directive's
moment list, composed with the D020 nine-moment loop (D020 §4.1–§4.8) and the D022 slice enemy package.

### 3.1 Stage geometry (frozen — D020 §3.1–§3.3)

```
S-1 Strand (awakening, D004 §3)
   ↓  coastal approach corridor (D020 §3.2): weather-exposed, route-risk band LOW→MODERATE (D024 §7.7)
F1 Gyle Cannery approach + ONE interior hot-load (D020 §3.3 / D018 §39 / D020 §6.1)
```

### 3.2 Required moment list (frozen — D027 directive, composed)

| # | Moment (D027) | Composes | Acceptance proof |
|---|---|---|---|
| 1 | COASTLINE ARRIVAL / AWAKENING | D020 M1; D014 §26 handoff; D017 STAGE 1; D025 identity-lock | wake on S-1; body state observable; the world is hostile-quiet |
| 2 | FIRST EXPLORATION | D020 M3; BV-SKILL-003/004/006; D024 region-read | walk/crouch/prone/sprint work; world interaction surfaces work; terrain reads |
| 3 | SURVIVAL PRESSURE | D020 M2; D015 §9/§12/§14; BV-SKILL-017 | weather presses; shelter is a decision; cold/wetness are felt not read |
| 4 | FIRST HUMAN ENCOUNTER | D020 M4; D022 Tier 1; D021 7-step; psyche per D022 §4 | ONE desperate survivor; stealth/avoid/engage options; failure tolerated |
| 5 | FIRST COMBAT SCENARIO | D020 M5; D021; D022 Tier 2; D017 injury | ONE Tier 2 trained human; weapon handling + injury consequence + limited ammo; "I survived by choice" |
| 6 | FIRST RESTORATION INTERACTION | D020 M7; D015 §16-§21; D024 §10/§16; BV-SKILL-020 | ONE system restored → world visibly changes (consequence law: one benefit + one cost) |

Composition rule: D027's six moments are the D020 nine-moment loop re-sequenced to the directive's proof;
MOMENT 8 (First Anomaly Seed) and MOMENT 6 (First Community Contact) remain in the slice as required
(D020 §6.1) and are REACHED in the same walk (see §7 acceptance). The slice is the FULL S-1 → F1 proof
path — not a subset.

---

## 4. Required systems — implementation specification (frozen)

For each requirement the directive names, D027 specifies: what the system IS, who owns it in the fleet,
what the slice MUST ship (in-slice production surface), and what is OUT (deferred).

### 4.1 PLAYER — movement

- In-slice: walk / jog / sprint / crouch / prone + one traversal (climb or mantle) — BV-SKILL-003
  (controller), BV-SKILL-004 (stance), BV-SKILL-005 (traversal); locomotion agency preserved in combat
  (BV-SKILL-021 invariant 2); the operator reads terrain (D024 §19 world read; D025 information advantage).
- Owner: BV-SKILL-003/004/005 consume.
- Out: full traversal suite, swimming, vehicle, mobility upgrades.

### 4.2 PLAYER — camera

- In-slice: 3P shoulder operational view + ONE FP precision window + helmet passive layer toggle
  (D020 §5.2/§5.3; D019 §3-§4); bounded sensitivity curves; shakes reduced per D017 §53.
- Owner: BV-SKILL-032 (visual-presentation) + D019 §3–§6.
- Out: helmet tactical overlay (opt-in, D019 §4.2), animated camera conventions beyond slice moments.

### 4.3 PLAYER — touch controls (D026 composed)

- In-slice: the D026 input layer for the slice's verbs — left-thumb analog move; right-thumb camera/aim;
  core cluster = fire / aim / reload / crouch / interact / weapon swap / melee / defensive move; ONE
  contextual surface (context-lock on press-down, safe cancel); equipment glance + quick radial (≤6);
  controller + keyboard/mouse parity; adjustable size/opacity/position; left-handed mirror; all actions map
  to the EXISTING project.InputMap vocabulary (input abstraction law — one simulation layer, many input
  layers, BV-SKILL-036).
- Slice touch budget (frozen): 2 movement thumbs + 1 combat cluster + 1 contextual + 1 gesture pad shell —
  anomaly gestures are DEV-SCOPED: ZERO deliberate player surface in the slice (D016 §7 Phase 0–1; D026
  discovery-gating). The pad exists as a placeholder reading State, not an ability.
- Owner: BV-SKILL-036 (touchscreen-input-architecture) is THE slice input authority; D025 §9 action
  priority realises the layout.
- Out: companion command layer, gesture grammar beyond shell, assist toggles beyond bounded baseline
  (D026 accessibility list is designed-in but only the slice-needed subset is wired).

### 4.4 PLAYER — body state

- In-slice: BODY persistent channel (D017 §11/§10); observable condition/temperature/exertion bands
  (D015 §6/§9); injury consequences (walking wound, cold struggling — D021 §3 injury); LIVING SAVE
  filestate for the slice's channels; animation-evolution LADDER at STAGE 1→2 edge surface (D017 §36) when
  the operator recovers measureably (D025 no-XP visible progression).
- Owner: BV-SKILL-031 (persistent state) + BV-SKILL-017 (survival internals).
- Out: full 5-stage reclamation transition (slice stays STAGE 1; a MEASURE of steadier hands is allowed —
  D020 §6.1 no stage transition).

### 4.5 PLAYER — inventory & equipment

- In-slice: minimal kit per D017 §18/§19 + D026 equipment tiers — wrist glance + quick radial (≤6) + ONE
  field-accessible item; ONE weapon from D013 family authority (improvised or survival class) with
  familiarity/history surface (D017 §27/§42 / D025 weapon relationship); equipment persists per D017 §11.
- Owner: D013 + D017 §26-§28 + BV-SKILL-036 (equipment UI).
- Out: base locker layer, full loadout, clothing-layer cosmetics, looting economies.

### 4.6 WORLD — island streaming boundary

- In-slice: ONE active sector (S-1 → coastal corridor → F1) with BV-SKILL-013 SECTOR ACTIVATION discipline
  (activation, not streaming — BV-D009/doctrine §31); off-screen coarse states (D015 §28) for the slice's
  corridor; active-node budget <1,200 (D020 §7.3).
- Owner: BV-SKILL-013 (sectors) + BV-SKILL-029 (substrate).
- Out: multi-sector streaming (D018 full island), per-region faction sweep.

### 4.7 WORLD — weather state

- In-slice: the D015 §14 weather state machine ran for ONE cycle holding THREE authored states (e.g.,
  CLEAR/COLD → HIGH WIND → LIGHT SNOW) that the player experiences; single-sourced WORD refresh
  (BV-SKILL-014); weather couples to survival pressure, sound masking, wildlife signal, patrol read
  (D024 §6 collation); storm punctuation optional-seed (D020 §4.9).
- Owner: BV-SKILL-014 (graphics/atmosphere) + BV-SKILL-017 (survival internals) share the same WORD.
- Out: full 9-state machine across the island, seasonal drift.

### 4.8 WORLD — time state

- In-slice: D024 §5 time-of-day — the slice runs the morning-in (DAWN→DAY) that the awakening requires;
  one authored NIGHT window optional-garnish if time-bounded; a visible sky/sun/bear-in-light read
  (D024 §17 / D019 §11); the wrist-device may show TIME_OF_DAY band.
- Owner: D024 §5/§17 (world rhythm) consumed by implementation.
- Out: full day cycle, rest-advances-time simulation, community night-watch.

### 4.9 WORLD — environmental interaction

- In-slice: the D020 §5.5 world surface for the S-1 corridor: open/close/enter structures, loot a cache
  (bounded), climb/mantle points, one hatch/bunker, one restoration interaction (D020 M7) — every surface
  is emissive of signature (BV-SKILL-007) and reads the world (D024 §19); interaction emits observable
  world-change when consequential (D024 §15 island memory).
- Owner: BV-SKILL-006 (environmental affordances) + BV-SKILL-029 (interaction classes / consequence law).
- Out: full interaction taxonomy (D024 §13), radio/power nodes beyond the ONE restoration.

### 4.10 WORLD — persistent changes

- In-slice: world-state channels for the slice (D024 §4.1 subset): FACILITY_STATE (the ONE restorable
  system at F1), LOCAL_AFTERMATH (the first human encounter's result persists on the ground — D024 §11.4),
  WILDLIFE_SIGNAL (one read), TIME/WEATHER (transient). All save-persistent via LIVING SAVE FILE (D017 §11
  / D024 §19); the world does NOT run ahead (D024 §5.8).
- Owner: BV-SKILL-031 / BV-SKILL-029 / D024 §15.
- Out: faction presence/replacement, community index beyond the ONE survivor threshold, island memory ledger.

---

### 4.11 COMBAT — observation

- In-slice: the D021 7-step loop OBSERVE→ASSESS→COMMIT→EXCHANGE→ADVANTAGE/DISADVANTAGE→BREAK/RECOVERY→
  RESOLUTION is the combat backbone (BV-SKILL-021 invariant 2); the player observes via D021 signature
  channels (movement/noise/body — BV-SKILL-007) and D024 world read (patrol behavior, wildlife signal,
  aftermath); the FIRST contact is made by looking and choosing, not by encounter-gate.
- Owner: BV-SKILL-021 (CQC architecture) as combat authority; BV-SKILL-007/008 as perception truth.
- Out: full tactical-graph, multi-target observation bookkeeping.

### 4.12 COMBAT — decision

- In-slice: every combat moment offers the decision set contact/avoid/withdraw + stance + weapon + timing
  (D021 philosophy: decisions-not-combos; D022 7-faction psychology means fights often END without lethal
  resolution). One Tier 1 and one Tier 2 encounter are DESIGNED as decision-points, and the slice honors
  "the player kills the man or the man lives" (D021 §5 psychology; Pillar 3 RESPONSIBILITY surface).
- Owner: D021 + D022 §4 (surrender/retreat/negotiation) + D023 moral-consequence framework (sparing is a
  recordable deed).
- Out: full faction memory, morality ledger beyond immediate consequence.

### 4.13 COMBAT — engagement

- In-slice: one engagement at Tier 1 (frightened, flinches, flees) and one at Tier 2 (disciplined, seeks
  cover, retreats when leaders/odds fold — D022 §4); weapons from a bounded D013 set; CQC uses D009
  CONTACT/SPATIAL; GUNFIGHT PRESSURE comes from limited ammo + injury consequence (D021), NOT from
  bullet-sponge enemies (doctrine §35.1); combat never disables locomotion agency (BV-SKILL-021 invariant 2).
- Owner: BV-SKILL-021 + BV-SKILL-011 (weapon handling) consume D013/D021/D022.
- Out: Tier 3/4, Shades, Program Casualties, boss fights (D020 §6.2; D022 §slice package).

### 4.14 COMBAT — injury

- In-slice: wounds have consequence (walking wound, raised bleed, cold + injury compounding — D021 §3, D015
  §13); injury state persists (BODY channel, D017 §11); the player MUST make the recovery decision
  (stop-and-treat, reach F1, ration meds — one med pack). No auto-magic regen (D021 consequence-honest).
- Owner: BV-SKILL-017 (injury internals) + BV-SKILL-031 (persistent state).
- Out: surgery-depth treatment, injury-infection timers beyond the slice's cold/hunger press.

### 4.15 COMBAT — recovery

- In-slice: recovery beats are the writer's currency (D021): shelter-rest thread (D024 §5.7), med-kit
  usage, and the walk-continue choice; recovery is read through animation-state and diegetic HUD
  (D019 §15 signature moments, wrist-band), never a magic bar (D019 §6 forbid).
- Owner: BV-SKILL-017/031 compose.
- Out: deep treatment minigame, decompression/relapse systems.

### 4.16 ENEMY — one Tier 1 desperate-survivor encounter

- In-slice: a frightened survivor with a rifle who does NOT want to fight (D022 §slice package: "one
  desperate survivor group"; D021 five-tier Tier 1: desperate survivors — panicked, mistakes, flees,
  surrenders). Psychology per D022 §4: fear, surrender, flight. The slice designs this as a decision-point
  with lethal / avoidance / sparing outcomes, all WRITTEN and all consequential (D023 applies the record).
- Owner: BV-SKILL-033 (enemy architecture) + BV-SKILL-027 (population ecology).
- Out: survivor faction meta, settlement interaction beyond the single encounter.

### 4.17 ENEMY — one Tier 2 trained-human encounter

- In-slice: a disciplined armed person (Security/Recovery or BH Remnant lean, D022 §2) with cover/seek/
  retreat skill who will fight and can be beaten by reading + choice (D021); NOT a bullet sponge; gives
  the "I survived because I made the right decision" proof (D022 psychology; D021 §5).
- Owner: BV-SKILL-033 + BV-SKILL-008 (tactical perception).
- Out: squad coordination, commanders, let-alone Tier 3+ (D020 §6.2).

### 4.18 ANOMALY — discovery only

- In-slice: the anomaly NEVER demonstrates ("no full power demonstration unless required" — directive
  §3.ANOMALY; D020 M8 First Anomaly Seed). Ship ONE authored subtle perception event (the MICRO bleed or
  an echo-seed; D015 §31 MICRO / D019 §12) + ONE unexplained symptom on the body (cold-fingered touch
  leave, disorientation at a marker — D016 §7 Phase 0 AMBIGUOUS). It is a MYSTERY that raises the question
  "what is wrong with this island/him" — it carries Pillar 1 IDENTITY dread and Pillar 3 RESPONSIBILITY
  read, but NOT a power gadget, NOT a UI meter (D016 §9/§45; D019 §6 forbid; D026 zero-gesture-surface at
  Phase 0–1).
- Owner: BV-SKILL-030 (anomaly methodology) + BV-SKILL-018 (horror/perceptual events) + D016 §7/§9-§19;
  bodies of WORK: BV-SKILL-019 (psionic cost prototype) consumer if powered, else this directive keeps
  ZERO power code (D016 Phase 0 reader only).
- Out: all deliberate anomalous capability (pull/push/blade/focus), Strain cost graph, Compound/Independent
  split (D020 §6.2; D016 §30-§34).

### 4.19 COMPANION — Shade deferred

- In-slice: NO Shade is introduced (directive §3.COMPANION; D023 companion rules; D020 §6.2 Companion
  Shade EXCLUDED). If the proof requires a relationship beat, it is the SURVIVOR NPC at F1 (D020 M6
  community contact), NOT the Shade. The Shade appears only if the slice's acceptance literally cannot
  be met without him — and the current design does NOT require him; the companion command input layer
  (D026 §16 companion ≤6) is excluded from the touch build.
- Owner: BV-SKILL-034 (companion relationship) — RETAINED for future slices, NOT consumed here.
- Out: Shade, Companion command layer, base-anchored ally, Six Commands.

---

## 5. ENGINEERING ARCHITECTURE (frozen)

D027 freezes the implementation architecture for the slice. It is NOT implementation; it is the contract
the future implementation authorization (D027-EXEC, per SOP-003) will satisfy.

### 5.1 Godot scene structure

```
res://                 (project root — existing game/ tree preserved, D009 structure)
└─ scenes/
   ├─ slice/                 <- D027 slice root (future-exec)
   │   ├─ slice_main.tscn         ONE entry scene: game-root + sector activation + word-clock
   │   ├─ sector_s1_strand.tscn   awakening theater (D014 handoff, D020 §3.1)
   │   ├─ corridor.tscn           S-1→F1 approach corridor (D020 §3.2)
   │   ├─ f1_cannery.tscn         exterior + ONE interior hot-load (D020 §3.3)
   │   └─ interactables/          openable/lootable/mantle surfaces (BV-SKILL-006)
   ├─ player/                 (existing player scaffolding, D009 — consumed)
   ├─ ai/                     (existing AI scaffolding — one observer prototype base)
   ├─ ui_core/                touch cluster + wrist + prompt host (BV-SKILL-036 input host)
   └─ world/                  weather/time/facility-state hosts (BV-SKILL-014/024/029)
├─ scripts/{slice, player, ai, world, ui_core}/   <- typed scripts, single-responsibility
```

Rules (frozen):
- ONE simulation layer; input layers (BV-SKILL-036) sit BELOW the simulation — the slice's scene tree has
  a single `GameWorld` that owns world state; `InputRouter` maps touch/controller/KBM onto simulation
  abstraction only (D026 input abstraction law).
- Scenes do NOT own foreign logic: sector owns terrain/activation; player owns body; ai owns its belief;
  world owns weather/time/facility state. Cross-talk via signals/central state store (BV-SKILL-029
  consequence-graph), never via node-hacking (D007 §9 no-IPC).

### 5.2 System boundaries

| System | Owns | Reads from (never writes) | Boundary gate |
|---|---|---|---|
| PlayerController (BV-SKILL-003) | movement/injury/equipment verbs | world state, weather, signature | emits moves + state; no AI knowledge |
| CameraRig (BV-SKILL-032/D019) | 3P/FP/helmet views + shake | player state + world read | outputs view; never decides combat |
| InputRouter (BV-SKILL-036) | touch/KBM/controller mapping to InputMap actions | action definitions (project.godot) | zero gameplay logic; settings-save only |
| WorldState (BV-SKILL-029/024) | weather/time/facility/aftermath channels | authored word + consequence graph | single source; deterministic under seed |
| AIGroup (BV-SKILL-033/008) | Tier1/Tier2 belief+behavior | truthful sensing reads | no omniscience; seed-driven |
| SignatureChannel (BV-SKILL-007) | emission currencies | player/AI world state | consumed by AI + wildlife; one truth |
| PersistenceStore (BV-SKILL-031/017) | LIVING SAVE channels | all owned state | sole save/load authority |

### 5.3 Data ownership

- World data (weather/time/facility/aftermath/wildlife) — ONE owned state (BV-SKILL-029 consequence
  graph + D024 channels); no per-node copies.
- Player data (BODY/CLOTHING/WEAPONS/RESIDUE + CONDITION/CORE-TEMP/EXERTION/CONTROL) — ONE owned body
  store (BV-SKILL-031); animation reads, writes only on real change.
- AI data — belief tables with source (BV-SKILL-008 knowledge-with-source): AI never writes world truth.
- Save — ONLY VitalStore reads ALL owners at save-time (D017 §11 LIVING SAVE FILE); single-writer rule.
- Debug — SOP-006 overlay reads only; zero gameplay effect (BV-SKILL-015 invariant 5).

### 5.4 Save-state requirements

- One manifest file per player slot (LIVING SAVE FILE); contents = world channels (D024 subset,
  §4.10) + BODY channel (D017 §11) + equipment slots (D017 §18) + the restoration/first-encounter record
  (island memory seed, D024 §15) + camera/input profile (settings-save, D026).
- World does not simulate while offscreen (D024 §5.8); save resumes exactly where the world left off.
- No respawn: death is consequence (D021); the slice may offer CONTINUE at last shelter-rest only as a
  debug/QA affordance, NOT as canon fiction (fixture-proof needs determinism — D020 §9).
- Determinism: save + seed must reproduce state transitions (D020 §9.2; BV-SKILL-015 invariant 4).

### 5.5 Input abstraction

- project.godot InputMap actions already exist (22 actions, D009); D027 slice must map touch/KBM/joystick
  to THOSE actions only (D026 input abstraction law; BV-SKILL-036). No new raw-input gameplay paths.
- Touch layout = bimanual core (move/camera) + cluster + contextual + gesture-pad-shell (ZERO function in
  slice); controller parity mandatory; adjustments per D026 accessibility minimum set.

### 5.6 Mobile performance constraints (frozen — D004 §10 / D019 §16 / D020 §7.3)

| Constraint | Bound |
|---|---|
| Active nodes | <1,200 per active sector (D020 §7.3; BV-SKILL-013 activation) |
| Sector footprint | ~1–2 km² |
| Working set | ~200–260 MB |
| Renderer | GL Compatibility baseline (BV-D001); scalable/fallback per D019 §16 |
| Simulation | world channels + coarse offscreen (D015 §28) only; no per-NPC/per-animal sim (D024 §4.2) |
| Draw calls / LOD / lighting | authored triggers + state swaps per D019 §16/D019 §11 |
| Frame target | stable on Android tablet baseline (D004 §10); observability zero-cost (BV-SKILL-015 invariant 5) |

### 5.7 Testing fixtures

- ONE acceptance fixture (D020 §9): deterministic seed; canonical playthrough S-1→F1 covering all
  moments; records every state transition + reason (BV-SKILL-015 invariant 2), WORLD/PERCEIVED split of
  the anomaly seed (BV-SKILL-018 invariant 4), restoration propagation delta (D015 §21), and every choice
  point (spare/kill/avoid; shelter; med; weapon). Fixture is the SLICE PASS/FAIL gate (reinforced by
  D027-DEXEC QA per BV-SKILL-016 invariant 5: device run, not desktop feel).

---

## 6. DEVELOPMENT ORDER (frozen — exact implementation sequence)

The future implementation authorization (D027-EXEC, per SOP-003) must build IN THIS ORDER. Each step has
an explicit DONE gate; each gate is verifiable (BV-SKILL-016 invariant 5: not "feels fine").

```
STEP 0 — FOUNDATION            Boot the D027 scene; world clock; input router shell; debug overlay;
                               seed determinism skeleton (BV-SKILL-015).
   GATE: project boots to slice_main with dev overlay reading seeded world state; 0 raw-input path.
STEP 1 — PLAYER CONTROLLER     Movement/body verbs (walk/jog/sprint/crouch/prone + ONE traversal);
                               body state readout. (BV-SKILL-003/004/005/031)
   GATE: player moves on tablet with touch thumbs; crouch/prone; body bands read-only in debug.
STEP 2 — CAMERA               3P shoulder + FP precision window + helmet passive; shake-reduction
                               scaffolding. (BV-SKILL-032 / D019 §3–§4 / D017 §53)
   GATE: camera switches cleanly; sensitivity curves honor D026 design; no camera-swap glitches.
STEP 3 — INTERACTION SYSTEM    Contextual action (ONE surface), open/loot/mantle/interact/restore hooks;
                               world interaction emits signature channel. (BV-SKILL-006/007/029)
   GATE: every directive §4.9 surface usable; interaction read in world-state log.
STEP 4 — ENVIRONMENT          Sector activation (S-1→corridor→F1); weather WORD cycle (3 authored states);
                               TIME_OF_DAY dawn→day; environmental storytelling + MICRO bleed placement.
                               (BV-SKILL-013/014; D024 §5/§6; D015 §31/§40)
   GATE: 3-state weather observed; route-risk band reads; active-node budget honors bound.
STEP 5 — COMBAT PROTOTYPE     The D021 7-step loop + weapon handling (bounded D013 set) + ammo-ration +
                               injury consequence. (BV-SKILL-021/011; D021; D017 injury)
   GATE: one scripted tier-1 engagement completes with decision options exercised; no bullet sponges.
STEP 6 — AI PROTOTYPE         Tier 1 desperate survivor + Tier 2 trained human (D022 psychology);
                               truthful sensing (BV-SKILL-008) + retreat/surrender/flee; seeded.
   GATE: both archetypes behave per D022 §4; no omniscience; spare/kill/avoid all land.
STEP 7 — SURVIVAL SYSTEMS     Cold/wetness/fatigue + shelter/rest + ONE med pack + damage-honest injury
                               coupling. (BV-SKILL-017/031; D015 §9/§12/§13; D020 M2)
   GATE: survival creates decisions (not meters); cold exposure sends the player to shelter; rest advances
         time (D024 §5.7).
STEP 8 — ANOMALY PROTOTYPE    ONE seed read (MICRO bleed or symptom; WORLD/PERCEIVED split); ZERO power
                               code; impact via dread/story/HUD-freeo title. (D016 §7 Phase 0; D015 §31;
                               D019 §12; D020 M8)
   GATE: the seed is authored, deterministic, mysteries not cascades; no ability UI.
STEP 9 — SLICE POLISH         Signature-moments (D019 §15 catalog: weapon-clean / visor-on-storm / mirror);
                               accessibility minimum (scaling/mirror/haptics off); observability + fixture
                               card; device QA on tablet. (D019; D026; BV-SKILL-016)
   GATE: acceptance fixture PASS on device; declared cut list; observability compliance; canon check.
```

Frozen rules:
- No step reached before its predecessor gate holds (depth-over-breadth, BV-SKILL-016 invariant 1).
- Slicing a step = cutting GARNISH, never CORE, and is a DECLARED-CUT item in the final report
  (BV-SKILL-016 invariant 4); ANY cut to Steps 1–3 or 5–7 CORE is a scope change requiring approval.
- Vendor-in step order reflects risk: input→camera→interaction→world arrive before combat/survival/
  anomaly, because they are the substrate of the one-line experience (BV-SKILL-016 implementation guidance:
  prove signature/stance/weather micro-loop before big world).
- D027-EXEC may NOT reorder STEP 8 before STEP 7 (anomaly proof rests on survival pressure being real).

---

## 7. ACCEPTANCE TEST (frozen)

The directive's acceptance statement is the SLICE GATE. A player must be able to:

1. WAKE ON ISLAND — cold, disoriented, broken-bodied (MOMENT 1).
2. MOVE — walk/jog/sprint/crouch/prone on touch, camera & helmet passive work (MOMENT 2).
3. EXPLORE — read the corridor, interact with surfaces, feel the world is indifferent (MOMENT 2).
4. UNDERSTAND VULNERABILITY — cold/wet/hunger/fatigue press; limited ammo; no max-HP crutch (MOMENT 3).
5. ENCOUNTER DANGER — one frightened survivor who does not want to fight (MOMENT 4) and one trained
   personality who does (MOMENT 5).
6. MAKE TACTICAL DECISIONS — observe→assess→commit→break, weapon/angles/time, use cover, read wind (MOMENT 5).
7. FIGHT OR AVOID — both paths genuinely viable and consequential (MOMENT 4/5).
8. EXPERIENCE THE FIRST SIGNS THAT SOMETHING IS WRONG — one authored anomaly seed; mystery, not power;
   no cascade (MOMENT 8), still on the same walk.
9. REACH THE CANNERY — arrive at F1 with the community contact + one restoration beat diary
   (MOMENT 6/7), the walk complete, and the world visibly changed behind him.

### 7.1 Required experience loop (frozen — D020 §7.1 composed)

Steps 1–9 are exactly the walk; the slice is complete when the player has reached F1, restored ONE system,
seen the world change, and met the anomaly seed — with the automatic support of the D020 nine-moment
fixture (D020 §7.1-§7.3).

### 7.2 Technical surface (frozen — D020 §4.9/§7.2 composed)

- Character controller (movement/camera/interaction/injury/equipment)
- World (ONE sector + 3-state weather + ONE facility interior + ONE restoration system + TIME dawn→day)
- AI (Tier 1 + Tier 2, truthful sensing, seeded)
- UI/touch (bimanual thumbs + cluster + contextual + wrist + helmet passive; controller parity)
- Audio (environment/combat/anomaly channels per D019 §13)
- Observability (SOP-006 overlay; zero gameplay effect)

### 7.3 Tablet feasibility (frozen — D020 §7.3 / D019 §16 / D004 §10)

Active nodes <1,200; sector ~1–2 km²; working set ~200–260 MB; GL Compatibility; activation-not-streaming;
coarse offscreen; bounded simulation (§5.6). The slice MUST validate on the Android-tablet target (BV-SKILL-016
invariant 5) — desktop pass is NOT acceptance.

### 7.4 Canon compliance (frozen)

- 0 contradictions vs D001–D026 (D027 contradiction ledger, §8).
- No game/ files modified by D027 (directive-level; D027-EXEC re-checks before each gate).
- Hard-stop conditions observed (SOP-003; D020 §7.4).

### 7.5 Fixture determinism (frozen — D020 §9)

- Deterministic seed → anomaly seed, weather cycle, AI choices, restoration propagation identical
  (BV-SKILL-015 invariant 4).
- Fixture = acceptance test (D020 §9.3); recorder asserts every moment + every choice point.

### 7.6 Validator gates (frozen)

- `tools/validate_methodology.py` — PASSED (2 governing + 36 BV skills, 6 SOPs; D027 adds no skill)
- `tests/static_verify_game.py` — CLEAN (24 ok / 0 fail baseline preserved; no game/ changes)
- Doctrine rows preserved (BV-D001..BV-D132 frozen; D027 adds BV-D132 only)


## 8. METHODOLOGY VALIDATION (frozen)

### 8.1 Do we need a doctrine addition? — YES (one row)

D027 FREEZES the finalized first-playable-proof slice specification (composing D020 + D021–D026). This is
a durable canonical statement worth a doctrine row (BV-D132). It is ONE row: the slice-spec hardening.

### 8.2 Do we need a new skill? — NO. Ownership map (proof):

| Layer | Owner (exists) |
|---|---|
| Slice scoping/QA | BV-SKILL-016 vertical-slice-discipline |
| Movement/camera | BV-SKILL-003/004/005 + BV-SKILL-032 |
| Input | BV-SKILL-036 touchscreen-input-architecture (D026) |
| Body/persistence | BV-SKILL-031 |
| Survival | BV-SKILL-017 |
| Interact/world-substrate | BV-SKILL-006/029 |
| Sectors | BV-SKILL-013 |
| Enemy/AI | BV-SKILL-033 + BV-SKILL-008 |
| Combat | BV-SKILL-021/011 |
| Anomaly | BV-SKILL-030 + BV-SKILL-019 + D016 |
| Horror | BV-SKILL-018 |
| Population | BV-SKILL-027 |
| Companion (deferred) | BV-SKILL-034 |
| Observability | BV-SKILL-015 (SOP-006) |

Frozen determination: **NO new BV-SKILL-037.** The finalized slice specification is an APPLICATION of
BV-SKILL-016 compsethodology compose with the existing fleet; it does not invent a reusable procedure that
no owner covers. (Mirrors D020's determination; strengthened by D021–D026 owning every consumer layer.)

### 8.3 Validation status

- Contradiction check vs D001–D026: PASS (§8 ledger; 16 checks, 0 contradictions, 0 silent repairs).
- Methodology: PASSED (2 governing + 36 BV skills, 6 SOPs).
- Static game: CLEAN (24 ok / 0 fail; no game/ changes).
- D024 PAUSED note: RESOLVED — D024 completed (BV-D128 frozen); doctrine chain now BV-D001..D131 + D027
  adds BV-D132.
- No commits; repo `main` unborn (unchanged).

---

## 9. CONTRADICTION CHECK vs D001–D026

| # | Canon point | D027 relation | Verdict |
|---|---|---|---|
| 1 | D020 anchor (geography, moments, boundaries, acceptance, fixture) | D027 composes EXACTLY; re-states, does not rewrite | CLEAN |
| 2 | doctrine §31 no lobby/load-fiction | D027 slice is one continuous walk, no lobby | CLEAN |
| 3 | D021 combat philosophy (decisions-not-combos, no sponge) | D027 Step 5/6 design honors both Tiers | CLEAN |
| 4 | D022 slice enemy package (Tier 1 + Tier 2 + wildlife + civilian) | D027 ships Tier 1 + Tier 2 + ONE wildlife + survivor NPC interaction; same package | CLEAN |
| 5 | D023/Shade rules (no summon; not in slice) | D027 §4.19 defers Shade entirely | CLEAN |
| 6 | D024 dynamic world (state tracker + consequence injector) | D027 slice uses the D024 channel subset (§4.10); no faction presence/sim; offscreen coarse | CLEAN |
| 7 | D024 §15 island memory | slice records the first-encounter + restoration deeds; no global reputation | CLEAN |
| 8 | D024 §21 island-as-progression (no world-map/mission select) | slice has no map/mission screen; progression read through world change | CLEAN |
| 9 | D025 identity (odd operator; no-XP; competencies) | the four-layer fantasy IS operator identity; progression measured not grinded | CLEAN |
| 10 | D026 touchscreen ("minimum input, maximum intent"; abstraction law) | D027 §4.3/§5.5 realize the input layer against existing action set | CLEAN |
| 11 | D026 anomaly gesture discovery-gating (zero surface Phase 0–1) | D027 Step 8 ships ZERO power code/UI; gesture pad is a shell | CLEAN |
| 12 | D015 substrate (weather machine, survival decisions) | D027 Step 7 runs the WORD cycle + survival decisions | CLEAN |
| 13 | D017 reclamation (slice stays STAGE 1) | D027 does not advance stage; A single steadier-hands moment is allowed | CLEAN |
| 14 | D013 weapon family authority | slice uses ONE improvised/survival weapon from D013; no loot table | CLEAN |
| 15 | D019 HUD ownership (wrist/helmet/world; forbid meters) | slice uses wrist + helmet passive + world band only | CLEAN |
| 16 | D020 §6.1/§6.2 production boundaries (excluded: no Shade, no later facilities, no powers) | D027 §4.19/§7 comply exactly | CLEAN |

**16 checks, 0 contradictions, 0 silent repairs required.**

---

## 10. DEFERRED DECISIONS

| Decision | Note |
|---|---|
| Exact Tier 1 survivor identity/name | D022/server-authoring at D027-EXEC (must stay D022 psychology-compliant) |
| Exact Tier 2 affiliation (Security/Recovery vs BH Remnant lean) | Leave to D027-EXEC; both honor D022 |
| Which ONE restoration system at F1 | Re-choose D020's M7 per-hot-load plan (D018 §39) at exec |
| Med-pack count & placement | Tuned at exec inside survival budget |
| Weapon pick in D013 improvised/survival family | F1-corridor allows 1–2 placements; exec chooses |
| Gesture-pad shell shape | BV-SKILL-036 layout pass; zero function in slice |
| MICRO bleed wording & trigger | BV-SKILL-018 authoring; must preserve WORLD/PERCEIVED split |
| Weather 3-state exact sequence | Authored at exec; must hold D015 §14 rule/language |
| Milliseconds for shake-reduction damping | Tuned at exec; D017 §53 contract held |
| Slice duration target (minutes) | Tuned; the EXPERIENCE is the gate, not runtime (BV-SKILL-016 invariant 2) |

---

## 11. FUTURE-SLICE CONTAINMENT

D027 does NOT import: full island multi-sector (D018 spine), later facilities (F2–F5), full faction
system, Reclamation stage advances, anomalous power suites, Companion Shade, boss doctrine, Program
Casualties, future-saga material (D015 §47 seam budget only). These are future-slice territory. The slice
is the PROOF, not the product — and the proof must stay honest (BV-SKILL-016 invariant 4).

------

# DIRECTIVE 027 — FINAL REPORT

**VERTICAL SLICE PLAYABLE-PROOF SPECIFICATION — the first-playable-proof slice (D001–D026 composed)**

**Files inspected:** doctrine §1/§5/§11/§14–§18/§23/§29–§31/§33–§35.1/§38/§41; D001; D004 §3–§5/§10;
D011 §3–§4/§22/§26; D012; D013; D014 §1/§26/§29; D015 §9/§12/§14/§16–§21/§28/§31/§40/§45/§47; D016
§7/§9–§19/§30–§34/§48–§49; D017 §3/§10/§11/§18/§19/§26–§28/§36/§42/§46/§53; D018 §20/§37/§39; D019 §3–§6/
§11–§16; D020 (the anchor spec) in full — §1–§12 + appendices + report; D021; D022; D023; D024 (BV-D128);
D025; D026. Skills reviewed: BV-SKILL-003/004/005/006/007/008/011/013/014/015/016/017/018/019/020/021/027/
029/030/031/032/033/034/035/036 + governing set.

**Files created:** `docs/design/VERTICAL_SLICE_PLAYABLE_PROOF_SPECIFICATION.md` (Directive 027).
**Files modified:** `doctrine/BLACK_VECTOR_DOCTRINE.md` (add BV-D132; correct BV-D131's stale D024-PAUSED
tail to reference D024 completion). `README.md` (D027 paragraph). `skills/registry.md` (BV-D132 reference
note if the registry records doctrine rows) and validator list UNCHANGED (no new skill; 36 BV skills).

**Doctrine:** **BV-D132** added — the finalized first-playable-proof slice specification (composes
D020 as anchor; mandates the S-1→F1 walk, 6+9 moment composition, the D027 required-systems list, the
engineering architecture, the exact development order, the acceptance test, and the fixture gate).
One row only; a durable-canon hardening, not a law dump.

**Player fantasy:** the four-layer proof is ONE walk — broken prisoner + survival instinct + recovering
operator + overwatch recon identity, all exercised in the first hour, measured through reads and choices,
never numbers (D017/D025/D021).

**Slice location:** S-1 Strand awakening → coastal approach corridor → F1 Gyle Cannery approach + ONE
interior hot-load (D020 §3). Continuous, no lobby, no map screen (D024 §21), island-as-progression.

**Required systems (implemented specification):**
- PLAYER: movement (walk/jog/sprint/crouch/prone + ONE traversal), camera (3P/FP/helmet-passive,
  shake-reduced), touch controls (D026 layer — bimanual thumbs + cluster + contextual + equipment glance +
  radar ≤6, gesture-pad SHELL with zero power function at D016 Phase 0–1), body state (D017 bands), minimal
  inventory/equipment (D013 family; D017 §18; persists).
- WORLD: one-sector activation (not streaming), 3-state authored weather cycle (D015 §14 WORD), time
  dawn→day (D024 §5), environmental interaction (contextual action; signature emission), persistent
  changes (world-channel subset save-persistent; no run-ahead).
- COMBAT: observation→decision→engagement→injury→recovery as the D021 7-step loop; decision-not-cobo
  combat; injury is real; recovery beats are writer's currency.
- ENEMY: one Tier 1 desperate-survivor encounter (psychology: fear/surrender/flight) + one Tier 2 trained-
  human encounter (cover/seek/retreat) — D022 slice package.
- ANOMALY: discovery only — one MICRO bleed/echo seed + one unexplained symptom; ZERO power code, ZERO
  ability UI; mystery-not-power (D016 Phase 0; D015 §31; D019 §12).
- COMPANION: Shade explicitly deferred; no companion command layer in the slice.

**Engineering architecture (contract for D027-EXEC):** Godot scene structure (slice root; sector corridor
F1 interior; player/AI/UI/world hosts), system boundaries (ownership table + signal/store cross-talk only),
data ownership (single-store world, single body store, AI belief-with-source, save = single writer),
save-state (LIVING SAVE FILE: world-channels + BODY + equipment + island-memory seed + settings profile;
deterministic under seed; no respawn fiction), input abstraction (existing InputMap actions only;
D026 layer), mobile constraints (<1,200 active nodes; ~1–2 km²; ~200–260 MB; GL Compatibility; bounded
simulation; device-run QAT), testing fixtures (ONE deterministic acceptance fixture = pass/fail gate).

**Development order (exact):** Foundation → Player controller → Camera → Interaction system → Environment →
Combat prototype → AI prototype → Survival systems → Anomaly prototype → Slice polish. Each step has an
explicit verifiable GATE; no reordering; cuts = declared garnish-only (BV-SKILL-016 invariant 4).

**Acceptance test:** the directive's nine-step player proof (wake → move → explore → understand
vulnerability → encounter danger → make tactical decisions → fight or avoid → experience the first signs
something is wrong → reach the cannery) — composed with D020's nine-moment fixture; device-tablet run;
declared cut list; canon check; observability compliance.

**Contradictions:** 16 checks vs D001–D026 (ledger §9) — 0 contradictions, 0 silent repairs. D024 PAUSED
chain-note resolved (D024 completed; BV-D128 frozen).

**Deferred decisions:** 10 recorded (§10) — all D027-EXEC authoring latitude, bounded by frozen law.

**Validation:** methodology **PASSED** (2 governing + 36 BV skills + 6 SOPs, no new skill — ownership
proof §8.2); static game **CLEAN (24 ok / 0 fail; no game/ changes)**; doctrine rows BV-D001..BV-D132
consistent; **GAME IMPLEMENTATION STARTED: NO**; **game/ files changed: NO**; **commit made: NO.**

---

**D027 COMPLETE — STOPPED, AWAITING APPROVAL.**
The first-playable-proof slice is now speced against the FULL frozen canon. The slice's elevator proof:
*"A broken prisoner wakes on a frozen coastline, claws his way through weather and one hostile man toward a
dark cannery, and dies or lives by what he chose — and something is wrong that he cannot yet name."*
Next step would be D027-EXEC (the authorized implementation run per SOP-003) — not before your approval.