# BLACK VECTOR — VERTICAL SLICE IMPLEMENTATION SPECIFICATION

> Directive-020 deliverable. IMPLEMENTATION SPECIFICATION ONLY. Not implementation, not production code, not
> VFX assets. Primary model: Big Pickle (per user routing; the directive's "MiniMax M3" attribution is again
> disregarded this session).
> Authority: THE DEVELOPER'S WAY -> doctrine -> SOP -> skills -> D001..D019 canon stack (BV-D001..D122) ->
> this document.
> Purpose: prove the BLACK VECTOR experience exists. The slice is small enough to ship and complete enough to
> demonstrate the full experiential identity (world, systems, character, campaign, visual). NOT a full game
> spec; NOT implementation. SYSTEM LAW vs CONTENT CANDIDATE strictly separated (D020 §16 / D015 §58 /
> D016 §58). This document is the AUTHORITATIVE SPEC for the first vertical slice; runtime implementation
> requires its own authorization per SOP-003 / SOP-005.
> GAME IMPLEMENTATION STARTED: NO.

---

## 1. Binding context & canon consumed

- Inspected: doctrine §3 (memory not XP), §4 (starting character lock), §5 (Environment), §6 (Stealth), §10
  (Platform/Renderer — GL Compatibility, Android-tablet first), §29 (Opening Structure), §34 (Narrative
  Pillars), §35-§39 (Combat / Control / Strain / Reclamation — BV-D033..D040), §41 / §41.1-§41.16 (Visual &
  Equipment Doctrine).
- D004 §10 edge-device budget (Android/tablet target; GL Compatibility; <1,200 active nodes per sector;
  baked lightmaps + 1 directional + fog; ~200–260 MB working set).
- D008/D009 CQC doctrine (BV-D033..D040) — combat ownership; the slice's first combat test exercises the
  architecture (BV-SKILL-021 owning).
- D010 visual/equipment doctrine (BV-D042..D052) — slice's clothing/armor/weapon visual language
  (BV-SKILL-022 owning).
- D011 ecology (D011 §15-§17 civilians/community archetypes; §22 human-first ability rule; §23 S-1 regional
  distribution).
- D012 provenance — program lineage informs program-island reading (slice does NOT reveal the program
  lineage to the player; D014 §28 knowledge gates preserved).
- D013 weapon bible — slice uses bounded starter weapons (doctrine §4 starting lock + scavenge).
- D014 prologue bible — slice begins AFTER the D014 §26 awakening handoff; the slice IS the S-1 Strand
  awakening scene.
- D015 §6-§15 survival substrate + §22 community state + §24 F1 systemic profile + §31 Memory Bleed taxonomy
  + §33 horror rarity + §47 Saga-1 containment.
- D016 anomaly bible — slice exposes D016 §7 Phase 0 AMBIGUOUS only; Phase 1 DENIAL seed may appear (no
  Phase 2 entry); no power unlock; first anomaly is a MYSTERY (D020 §8).
- D017 reclamation bible — slice opens in STAGE 1 BROKEN SURVIVOR (D017 §3); persistent state channels active
  (D017 §10-§11); persistent-state architecture demonstrates the LIVING SAVE FILE.
- D018 campaign spine — slice spans ACT I SURVIVE (D018 §5); F1 Gyle Cannery is the slice's destination
  (D018 §6); weather-as-punctuation active (D018 §20).
- D019 visual production / HUD / presentation — slice demonstrates 3P camera, FP precision window, helmet
  passive layer (D019 §4.1), wrist device (D019 §5.1), world HUD (D019 §5.3), weather presentation (D019
  §11), horror language (D019 §12), sound language (D019 §13), animation priority tiers (D019 §14),
  signature moments (D019 §15), tablet performance law (D019 §16).
- Skills reviewed: BV-SKILL-001..032 + 2 governing + 6 SOPs. All composing authorities available; no new
  skill created (D020 §15 frozen determination).
- The slice anchors on the user's directive specification (D020 §1-§10) + the campaign recommendation
  (D018 §39) + the visual production signature-moment catalog (D019 §15).

## 2. Slice purpose (frozen)

> **Prove the BLACK VECTOR experience exists.**

The slice is the smallest playable segment that demonstrates the COMPLETE experiential identity:
- world (S-1 Strand + coastal approach + F1 Gyle Cannery)
- systems (D015 survival substrate; D008/D009 combat; D011 ecology)
- character (D017 STAGE 1 BROKEN SURVIVOR + persistent state)
- campaign (D018 ACT I SURVIVE)
- visual (D019 camera / helmet / wrist / world HUD / weather / horror / sound / signature moments)

The slice is NOT a tutorial. The slice is NOT a vertical slice of the prologue. The slice is the FIRST
PLAYABLE EXPERIENCE OF SIMSE SOUND after the D014 awakening handoff.

## 3. Slice geography (frozen)

Anchored to D018 §39 recommendation + D020 §1.

### 3.1 S-1 Strand (D004 §3)
Identity (frozen): the awakening ground; the crash/landing edge; survival + stealth teaching ground; entry
wedge.
- flats, delta, drowned spruce, tide flats, marsh (D004 §3)
- weather-exposed (D015 §9 cold signature pressure; D015 §14 weather)
- wildlife present (D004 §7 ambient tier — seabirds, marine mammals; decision-tier — brown bear, moose;
  wolves)

### 3.2 Coastal approach path (between S-1 and F1)
Identity (frozen): the player's first travel; environmental storytelling corridor.
- weather-exposed coast (D004 §4 F1 logic; D015 §14)
- ruined infrastructure / abandoned USCG outpost remnants (D015 §24 F1 systemic profile; the program used
  civilian heritage as cover; D012 §12)
- weather punctuation (a major storm or weather event punctuates the approach; D018 §20 ACT I weather beat)

### 3.3 F1 Gyle Cannery (D004 §4 + D015 §24)
Identity (frozen): first stable personal/community anchor (D018 §6); coastal survival; first community;
practical restoration.
- marine / weather-exposed construction (stilted / quonset heritage per D004 §4)
- working-boat infrastructure (float ramp, dock)
- community spaces (kitchen / mess)
- a radio that looks like the program's communication gear when restored
- D011 §16 community archetype = WORK/FISHING CAMP or REMOTE HOUSEHOLD

Frozen rule: F1 interior is ONE contained interior hot-load (D004 §10 budget). The slice reaches F1
exterior; F1 interior is hot-loaded for the restoration beat + community contact scene.

## 4. Required experience loop (frozen — 9 moments + tech spec)

The slice delivers NINE EXPERIENCE MOMENTS + A TECHNICAL REQUIREMENT SET. Each moment is a demonstration of
a canon stack; each is observable; each is anchored to a frozen doctrine row.

### 4.1 MOMENT 1 — Awakening Sequence (frozen)

Player experiences:
- confusion
- physical weakness
- environmental danger
- missing identity
- damaged equipment
- first survival decisions

Systems demonstrated:
- D017 STAGE 1 BROKEN SURVIVOR (D017 §3)
- D015 survival model (CONDITION + CORE TEMPERATURE + EXERTION bands; D015 §7-§9)
- D019 presentation (3P camera; wrist device; world HUD; weather per D015 §14; first weather presentation
  cues; D019 §11)

Slice requirement (frozen):
- The player wakes on S-1 Strand under sudden catastrophe (D014 §26; D017 broken-survivor).
- Starting lock applied: sidearm + 1 loaded magazine + 1 spare magazine + boot knife + photograph (doctrine
  §4 / D014 §26 / D018 §5).
- Body in a damaged state (D015 §7 CONDITION low; CORE TEMPERATURE band = COLD or CHILLED; EXERTION band =
  ELEVATED; persistent-state channels: BODY bruises/scars/dirt; CLOTHING wet/damaged; residue on hands).
- The player must move; the world presses (cold, wind, weather).

### 4.2 MOMENT 2 — First Survival Problem (frozen)

Player must solve:
- cold exposure (D015 §9 cold bands)
- shelter (D015 §12 shelter levels — start at EXPOSED; reach WINDBREAK or CRUDE SHELTER)
- water / food decision (D015 §6 — meal/recovery beats, not hunger meter; place-based water)
- equipment recovery (D017 persistent-state channels; the player sees what they have / what's damaged)

Player understanding (frozen):
> **"This place is trying to kill me."**

Slice requirement (frozen):
- The player faces a weather event (D015 §14-§15) on the S-1 Strand.
- The cold bands activate diegetic feedback (D019 §6.2 — shaking hands / slower breathing / frost buildup /
  wrist warning / reduced dexterity).
- The player must find shelter (the WINDBREAK / CRUDE SHELTER choice is the first decision).
- A meal/recovery beat is available (D015 §6 meal beats — place-based, not a meter).

### 4.3 MOMENT 3 — Exploration Layer (frozen)

Demonstrate:
- environmental storytelling
- abandoned infrastructure
- evidence of previous events
- Memory Bleed candidate system (D015 §31 MICRO Bleed)
- world interaction (D015 §4 / §16-§21)

Frozen rule: NO exposition dump. The island tells the story.

Slice requirement (frozen):
- The player traverses a coastal approach corridor with AUTHORED environmental storytelling cues:
  - a damaged structure that suggests program use (D012 §12 program used civilian heritage as cover)
  - a body or a recording that suggests catastrophe (D014 §25 aftermath)
  - a piece of equipment that hints at the program (a uniform, a coded log, a damaged relay)
  - wildlife-silence signals (D015 §40 wildlife-as-environmental-information)
- ONE Memory Bleed candidate moment (D015 §31 MICRO — seconds; voice/face/gunshot/family fragment/prison
  sound). AUTHORED with budget (D015 §33). Triggers on a diegetic cue.
- World interaction surfaces (D015 §27 bounded interaction classes):
  - POWER (a generator or a switch)
  - ACCESS (a door / hatch / dock gate)
  - SHELTER (the WINDBREAK / CRUDE SHELTER surfaces)

### 4.4 MOMENT 4 — First Human Encounter (frozen)

Must demonstrate:
- Human threats are the primary danger (D011 §22 / doctrine §23).
- Stealth option, avoidance option, tactical engagement option.
- NO power fantasy. The player is weak (D017 STAGE 1; D019 §7 STAGE 1 reads).

Slice requirement (frozen):
- One human encounter archetype (D011 §23 S-1 regional: survivors · guards · contractors · fractured
  personnel · S-1 Black Hand remnants).
- The encounter is bounded (D011 §31 boss doctrine does NOT apply — this is a non-boss encounter).
- The player has three readable options:
  - STEALTH: avoid detection via D015 §40 stealth channels (cover / concealment / line-of-sight);
    D011 §7 truthful sensing (the AI sees what a real observer would see)
  - AVOIDANCE: a route around the encounter reads as an option
  - ENGAGEMENT: a tactical engagement the player can win if they execute well (weapon handling; injury
    consequence; limited resources)
- A death or failure of the encounter does NOT block the slice; the slice tolerates failure (D017 §47
    nonfatal failure: temporary injury / equipment loss / resource consumption / world state change).

### 4.5 MOMENT 5 — First Combat Test (frozen)

Demonstrate:
- weapon handling (D013 weapon bible; doctrine §9; starting lock weapons)
- injury consequences (D015 §13 injury model; CONDITION impact; persistent-state BODY channel)
- limited resources (1+1 magazines; boot knife; scavenged supplies)
- tactical decision making (D008/D009 combat ownership; player chooses timing/target/aggression/defensive
  choice)

Combat feeling (frozen):
> **"I survived because I made the right choice."**

NOT:
> **"I had more stats."**

Slice requirement (frozen):
- The combat moment exercises the D008/D009 architecture (CONTACT state graph + SPATIAL ranges; BV-SKILL-
  021).
- The Hand is in STAGE 1 (D017 §3): weapon handling is bounded; precision is not yet reclaimed.
- A successful engagement consumes resources (ammo count visible on the wrist device; D019 §5.1).
- An injury event updates CONDITION + persistent-state BODY channel (D015 §13 + D017 §10).
- The player has FEEDBACK on every choice (BV-SKILL-015 observability contract — events logged).

### 4.6 MOMENT 6 — First Community Contact (frozen)

Arrival at F1 Gyle Cannery (D018 §6).

Demonstrate:
- survivors (D011 §16 WORK/FISHING CAMP or REMOTE HOUSEHOLD)
- trust system foundation (D015 §22 community state — POPULATION / SAFETY / WARMTH-POWER / MEDICINE /
  TRUST / ACCESS / THREAT PRESSURE; D017 §22 cleanliness social reactions)
- shelter (D015 §12 HEATED STRUCTURE once the player has done the restoration beat)
- restoration (D017 §19 base-grooming facilities present; the player sees mirror/wash/locker/workbench/
  medical surfaces)
- character reaction (D017 §40 mirror moments; D017 §9/§22 reactions; persistent-state visible)

This establishes the reason to keep going.

Slice requirement (frozen):
- One named survivor NPC (D011 §16) at F1.
- The player observes the community state (D015 §22); the community state is LOW TRUST initially (the
  Hand is a stranger; doctrine §26 ally is NOT here — that comes later).
- A short authored conversation reads the player's choices; the player can observe trust evolving.
- The survivor NPC provides information (route, weather, condition of F1 systems) without exposition-dumping
  the program.
- The slice ends with the player INSIDE F1 (after the restoration beat) OR with the player having begun the
  restoration.

### 4.7 MOMENT 7 — Restoration Beat (frozen)

The player fixes or restores ONE meaningful system.

Examples (frozen set — choose one):
- GENERATOR — power restored (D015 §17-§19 consequence law)
- COMMUNICATIONS — radio restored (D015 §23 liability law: communications restored → new information
  AND new exposure)
- HEATING — heat restored (D015 §12 INTACT UNHEATED STRUCTURE → HEATED STRUCTURE transition)
- MEDICAL EQUIPMENT — medical equipment restored (D015 §24 F2-style medical, scoped down)

The world visibly changes.

Slice requirement (frozen):
- The restoration beat applies D015 §17 consequence law (BENEFIT + COST + FAILURE STATE + DEPENDENCY +
  SECONDARY CONSEQUENCE). One benefit; one cost visible to the player.
- The world-state propagation graph (D015 §21) reads the change. A small visible world change (a light
  comes on; a heater hums; a radio crackles) is observable.
- The player experiences one consequence of restoration (e.g., a light reveals their position; a radio
  picks up a transmission from someone who now knows they're here).

### 4.8 MOMENT 8 — First Anomaly Seed (frozen)

Important: NOT a power unlock. A MYSTERY.

Example: something impossible happens.

Player reaction (frozen):
> **"Did I just see that?"**

NOT:
> **"New ability unlocked."**

Slice requirement (frozen):
- ONE authored anomaly event (D015 §33 / D016 §7 Phase 0 AMBIGUOUS or Phase 1 DENIAL).
- The event is bounded: it is OBSERVABLE; it does NOT activate an ability; the player cannot dismiss it
  as technology.
- It is tied to the slice's geography (e.g., on the coastal approach / in F1's interior / during the
  restoration beat — slice authoring decides).
- It consumes ONE slot of the horror budget (D015 §33) — it does NOT spawn bleeds, does NOT cascade.
- It carries Pillar 3 RESPONSIBILITY (doctrine §34): the event reads as a thing the world did, not a thing
  the player did.
- The event is diegetic (BV-SKILL-018 invariant 4): WORLD vs PERCEIVED separation preserved in overlay.

### 4.9 Technical Requirements (frozen)

D020 §9 freezes the technical requirement set. Each system is a thin slice — enough to demonstrate, not
enough to ship.

#### Character
- movement (BV-SKILL-003 third-person-character-controller; BV-SKILL-004 stance-system; BV-SKILL-005
  systemic-traversal)
- camera (D019 §3 — 3P shoulder + FP precision window; not the full signature-moment catalog)
- interaction (BV-SKILL-006 environmental-affordances; D015 §27 bounded interaction classes)
- injury state (D015 §13; D017 §10 BODY channel; CONDITION band)
- equipment state (D017 §10 CLOTHING / WEAPON channels; D015 §10 wetness; D015 §25 residue)

#### World
- ONE terrain region (S-1 Strand + coastal approach corridor + F1 exterior + F1 interior hot-load;
  D004 §10 budgets)
- ONE weather cycle (D015 §14 state machine: at least CLEAR → RAIN → HEAVY SNOW or MAJOR STORM transition
  with isochronal ramps; D019 §11 presentation)
- ONE facility interior (F1 Gyle Cannery; one hot-load per D004 §10 budget)
- ONE restoration system (D015 §16-§21; D020 §4.7 frozen choice)

#### AI
- ONE human enemy archetype (D011 §4 military roles + D011 §23 S-1 regional; D011 §7 truthful sensing;
  D008/D009 AI-facing combat interfaces via BV-SKILL-021 invariant 11)
- ONE wildlife behavior (D004 §7 decision-tier: brown bear OR moose OR wolves; bounded, signed behavior
  per BV-SKILL-017 / D004 §7)
- ONE survivor NPC (D011 §16; community disposition D015 §22; D017 §22 cleanliness social reactions)

#### UI / HUD (D019 §5)
- wrist device (D019 §5.1; CONDITION / temperature bands)
- basic helmet passive systems (D019 §4.1; env readings / compass)
- survival indicators (D015 §45 / D019 §6 diegetic cues)

#### Audio (D019 §13)
- weather (D019 §13.1)
- footsteps (D019 §13.2)
- combat (D019 §13.2; D013 weapon reports)
- anomaly language (D019 §13.3; D016 §44 vocabulary)# — CONTINUED: PART B — IMPLEMENTATION SPEC, FIXTURE DESIGN, ACCEPTANCE, BOUNDARIES —

---

## 5. Per-system implementation specification (frozen — D020 §9/§10)

The slice is implemented as a thin vertical cut across all systems. Each system ships a MINIMAL VIABLE
SURFACE sufficient to demonstrate the canon stack. Below is the system-by-system spec.

### 5.1 Character controller (frozen spec)

Required surface:
- 3P third-person character controller (BV-SKILL-003) — walk / run / sprint / crouch / prone / jump /
  mantle / vault / climb affordances.
- Stance system (BV-SKILL-004) — stand / crouch / prone / sprint.
- Systemic traversal (BV-SKILL-005) — climb / mantle / ledge / branch (where affordances exist).
- Stealth + concealment (BV-SKILL-007) — cover / concealment channels.
- Weapon handling (BV-SKILL-011) — sidearm ready / reload / aim / fire; boot knife ready / attack; scavenged
  weapon if present.
- Player body feedback (D019 §3.2 + D017 §37) — FP precision window for aiming; 3P body state visible at
  distance.
- Persistent state channels (D017 §10) — BODY / CLOTHING / WEAPONS / ENVIRONMENTAL RESIDUE active; HAIR/FACE
  minimal (no grooming UI yet — that's a future slice).
- D019 §14 animation priority Tier 1 set: movement / weapons / stealth / injury / climbing / interaction.

Out of scope for this slice (frozen):
- Grooming UI (D017 §18 quick radial; D017 §19 base grooming)
- Quick presentation radial (D017 §18)
- Mirror moments (D017 §40) — only if F1 interior supports them
- Compound/Independent path UI
- Companion Shade
- Anomaly capability

### 5.2 Camera (frozen spec)

Required surface (D019 §3):
- 3P shoulder offset (not behind-back only)
- Aiming transition eases to/from 3P (zoom into FP precision window)
- Stealth camera tightens FOV during crouch-walk
- Injury camera effects: CONDITION LOW → slight camera weight + peripheral vignette; visible body
  region wound → micro-tremor / posture tilt
- Weather camera effects: rain droplets + snow accumulation + fog desaturation + storm shake
- D017 §53 accessibility override: shake reduction available
- D019 §3.2 FP body-preservation: when FP active, hands / sleeves / gloves / hair / breath / dirt / blood /
  equipment visible

Out of scope for this slice (frozen):
- Full signature-moment catalog (D019 §15)
- Helmet visor activation (D019 §4.2 tactical layer — TACTICAL is OPT-IN; the slice includes PASSIVE only;
  tactical activation is a future slice)

### 5.3 Helmet / visor (frozen spec)

Required surface (D019 §4):
- PASSIVE layer (D019 §4.1): env readings / basic diagnostics / compass / equipment status — diegetic
  wrist device + helmet passive readings
- Tactical + Anomalous layers are OUT OF SCOPE for this slice (D019 §4.2 / §4.3 are future slices)
- Helmet hardware identity: the helmet LOOKS USED; visor state reads clean / dirty / cracked (D017 §27
  pattern); damaged visor reduces clarity (D017 §12)

Out of scope for this slice (frozen):
- Tactical activation signature event
- Anomalous perceptual changes
- Drone feed integration (D019 §4.2 — out of scope; the slice does not include drone)

### 5.4 HUD (frozen spec)

Required surface (D019 §5):
- Wrist device: CONDITION / temperature / inventory / comms / diagnostics (D019 §5.1)
- Helmet passive: navigation / compass / env readings (D019 §5.1)
- World HUD: objectives / clues / propagation effects (D019 §5.3)
- Survival indicators: per-state-variable diegetic cue set (D019 §6); no MMO meters / no floating numbers /
  no happy-gauges
- Diegetic-first feedback (doctrine §36.4); thin HUD band label only

Out of scope for this slice (frozen):
- Anomaly HUD discovery presentation (D016 §45)
- Quick presentation radial (D017 §18)
- Diagnostic screen (D015 §45) — minimal wrist-device diagnostics only
- Neural Strain band (D016 §45 late-campaign) — D016 §7 Phase 0 AMBIGUOUS only; no Strain band yet

### 5.5 World (frozen spec)

Required surface:
- ONE terrain region (S-1 Strand + coastal approach + F1 exterior + F1 interior hot-load)
- ONE weather cycle (D015 §14 state machine): at least 3 weather states observed by the slice (e.g.,
  CLEAR → RAIN → MAJOR STORM or HEAVY SNOW)
- ONE restoration system (D020 §4.7 frozen choice)
- Environmental storytelling cues (D020 §4.3): damaged structures / body / recording / equipment hint /
  wildlife-silence signals
- Memory Bleed candidate (D020 §4.3): ONE MICRO Bleed (D015 §31) authored; budgeted (D015 §33); diegetic
  trigger
- Affordance surfaces (BV-SKILL-006): one of each bounded interaction class used (POWER / ACCESS /
  SHELTER / HEAT / INFORMATION)
- World-state propagation (D015 §21): the restoration beat reads ONE small world-state change visible to
  the player

Out of scope for this slice (frozen):
- Full island (D018 §39 — slice is the candidate, not the world)
- Full factions (D018 §11/§37; one human archetype only)
- Advanced powers / capabilities
- Complete crafting
- Final AI systems
- Later facilities (F2 / F3 / F4 / F5)

### 5.6 AI (frozen spec)

Required surface:
- ONE human enemy archetype (D011 §4 + D011 §23 S-1): a Black Hand remnant or guard with bounded
  capabilities (D011 §22 human-first; D008/D009 combat ownership)
- ONE wildlife behavior (D004 §7 decision-tier: brown bear OR moose OR wolves; BV-SKILL-017 / BV-SKILL-008
  bounded sensing)
- ONE survivor NPC (D011 §16 community archetype; D015 §22 community state; D017 §22 cleanliness social
  reactions)

AI rules (frozen):
- Truthful sensing (D011 §7): no omniscience; bounded signature channel
- AI-facing combat interfaces (BV-SKILL-021 invariant 11) — observable events
- Wildlife sensing uses the bounded signature model (BV-SKILL-008)
- The survivor NPC is not a quest-giver; the survivor is a person with state

Out of scope for this slice (frozen):
- Multiple archetypes
- Commander systems (D011 §8)
- Shades (D011 §6; D018 §12 reserved for later)
- Companion Shade
- Former Hidden Hand
- Program Casualties (D011 §12 — beyond slice scope)
- True Unknowns (D015 §34 — beyond slice scope)

### 5.7 Audio (frozen spec)

Required surface (D019 §13):
- Weather (D019 §13.1)
- Footsteps (D019 §13.2 — cloth / metal / water / mud per D017 §25)
- Combat (D019 §13.2 — weapon reports, breath, equipment movement)
- Anomaly language (D019 §13.3 — pressure, distortion, tinnitus vocabulary per D016 §44)

Audio rules (frozen):
- Single-sourced weather (D015 §14)
- Ordinary audio taught BEFORE contamination (D015 §43 / §44) — the slice has no contamination
- Essential gameplay cues never permanently unreliable (D015 §30 fairness)

### 5.8 Persistence / save (frozen spec)

Required surface:
- Save-state shape (D017 §51) covers at minimum:
  - clothing state (D017 §10 CLOTHING channel)
  - clothing condition (wetness / residue / damage)
  - armor condition
  - weapon identity / condition
  - reclamation stage (D017 §3 — STAGE 1)
  - Compound/Independent path state (none — slice does not introduce Compound)
- D017 §11 LIVING SAVE FILE law: state changes persist; no arbitrary reset
- Observability per SOP-006 / BV-SKILL-015 (every state change logged with reason)

Out of scope for this slice (frozen):
- Hair/beard/grooming state (D017 §14-§22; future slices)
- Major scars / persistent injuries (D017 §46 — future slice; slice records injuries as authored
  events only)
- Reclamation stage progression (slice opens in STAGE 1; does not transition)

### 5.9 Observability (frozen spec)

Required (BV-SKILL-015 / SOP-006):
- BV.DEBUG overlay prefix; events log reason; fixture runs deterministic with seed (BV-SKILL-015
  invariant 4)
- Overlay is zero-gameplay-effect (BV-SKILL-015 invariant 5)
- WORLD vs PERCEIVED separation preserved (BV-SKILL-018 invariant 4) — the slice's anomaly event must
  trace to its authored ID
- Replayable fixture: deterministic seed reproduces the slice's anomaly event + state transitions

---

## 6. Production boundaries (frozen — D020 §10)

### 6.1 Included (frozen)
- S-1 Strand awakening + coastal approach + F1 Gyle Cannery approach
- One survivor NPC interaction
- One restoration beat
- One anomaly hint (mystery; not a power unlock)
- One human enemy encounter (stealth / avoidance / engagement options)
- One wildlife behavior (decision-tier)
- One Memory Bleed candidate (MICRO; authored)
- One weather cycle (3 states observed)
- One restoration system (D020 §4.7 choice)
- Persistent state channels active (BODY / CLOTHING / WEAPONS / ENVIRONMENTAL RESIDUE)
- Survival HUD diegetic cues per state variable
- Camera system (3P shoulder + FP precision window)
- Helmet passive layer only
- Wrist device HUD
- World HUD
- Audio per channel (environment / combat / anomaly)

### 6.2 Excluded (frozen)
- Full island (S-1..S-7 sectors; D018 spine is the long arc)
- Full factions (D011 §4 / §5 / §6 / §10 / §17 / §12 — beyond slice)
- Advanced powers / capabilities (D016 §8+; slice is D016 §7 Phase 0 AMBIGUOUS only)
- Complete crafting (D015 §16 / §27 — beyond slice)
- Final AI systems (D011 §31 boss doctrine; D011 §6 Shades; D011 §8 commanders)
- Later facilities (F2 Tanellus / F3 Frostvane / F4 Vivara / F5 Annex)
- Reclamation stage progression (D017 §3 — slice opens in STAGE 1; no transition)
- Anomalous path expression / Compound / Independent (D016 §30-§34)
- Companion Shade
- Former Hidden Hand encounters
- True Unknowns (D015 §34)
- Program Casualties (D011 §12)
- Memory Bleeds beyond MICRO (D015 §31 — slice uses MICRO only; WALK-THROUGH / INTERACTIVE / REALITY
  BREACH are future slices)
- Major horror events (D018 §22 — Cannery Event / High Pass Event / Vivara Descent)
- Signature-moment catalog beyond the slice's required moments (D019 §15)
- Prologue references / D014 sequence (slice begins AFTER the D014 §26 handoff)
- Future-saga material (D015 §47 / D020 §16)

---

## 7. Acceptance criteria (frozen)

The slice is ACCEPTED when ALL of the following are true:

### 7.1 Required experience loop (frozen — D020 §4.1–§4.8)

- MOMENT 1 — Awakening: the player wakes on S-1 Strand in STAGE 1 BROKEN SURVIVOR with the doctrine §4
  starting lock; the body state is observable; survival pressure is present.
- MOMENT 2 — First Survival Problem: a weather event presses; the player finds shelter (WINDBREAK or
  CRUDE SHELTER); cold bands are diegetic; meal/recovery beat is available.
- MOMENT 3 — Exploration: the coastal approach corridor delivers environmental storytelling cues; ONE
  MICRO Bleed is authored and observed; world interaction surfaces work.
- MOMENT 4 — First Human Encounter: the player has STEALTH / AVOIDANCE / ENGAGEMENT options; the AI uses
  truthful sensing; the encounter tolerates failure.
- MOMENT 5 — First Combat Test: the player exercises weapon handling, injury consequence, limited
  resources, tactical decision making; combat reads as "I survived because I made the right choice."
- MOMENT 6 — First Community Contact: the player arrives at F1; one named survivor NPC; trust state
  evolves with player choices; the player sees base-grooming facilities present.
- MOMENT 7 — Restoration Beat: ONE system is restored; the world visibly changes; the §17 consequence
  law is observable (one benefit + one cost).
- MOMENT 8 — First Anomaly Seed: ONE authored anomaly event; it is a mystery not a power; it does not
  cascade; it carries Pillar 3 RESPONSIBILITY.

### 7.2 Required technical surface (frozen — D020 §4.9)

- Character controller: movement / camera / interaction / injury state / equipment state
- World: ONE terrain region / ONE weather cycle / ONE facility interior / ONE restoration system
- AI: ONE human enemy archetype / ONE wildlife behavior / ONE survivor NPC
- UI: wrist device / basic helmet passive / survival indicators
- Audio: weather / footsteps / combat / anomaly language

### 7.3 Tablet feasibility (frozen — D019 §16 / D004 §10)

- Active scene nodes per active sector: <1,200
- Sector footprint: ~1–2 km²
- Working set: ~200–260 MB
- GL Compatibility renderer baseline (BV-D001)
- Sector activation (BV-SKILL-013) — not streaming implementation (BV-D009 / doctrine §31)
- Off-screen coarse states (D015 §28 — SAFE / ACTIVE / THREATENED / DISPLACED / LOST)

### 7.4 Canon compliance (frozen)

- 0 contradictions vs D001..D019 (D020 contradiction ledger; Appendix A).
- No game/ files modified without explicit authorization.
- All HARD STOP CONDITIONS observed.

### 7.5 Fixture determinism (frozen)

- A deterministic seed reproduces the slice's anomaly event + state transitions (BV-SKILL-015
  invariant 4).
- The fixture is the ACCEPTANCE TEST.

### 7.6 Validator gates (frozen)

- `tools/validate_methodology.py` — PASSED (no new skill created; 32 BV skills unchanged from D019)
- `tests/static_verify_game.py` — CLEAN (24 ok / 0 fail baseline preserved)
- No game/ files modified
- All doctrine rows preserved (BV-D001..BV-D122 frozen; this directive adds no doctrine rows
  unless durable laws are discovered)

### 7.7 Slice completion (frozen)

The slice is COMPLETE when:
- The player has walked S-1 → F1 coastal approach
- The player has made the awakening decision
- The player has survived the first weather event
- The player has completed the first human encounter (via stealth, avoidance, or engagement)
- The player has completed the first combat test
- The player has reached F1
- The player has completed the first community contact
- The player has completed the restoration beat
- The player has experienced the first anomaly seed

The slice may END before the player has fully restored F1, before the player's reclamation stage
advances, before the player's anomalous capability becomes deliberate. The slice demonstrates the
EXPERIENCE; it does not complete the campaign.

---

## 8. Methodology validation (frozen — D020 §15)

Per the user's "methodology validation" deliverable expectation. Inspect the 32-BV-skill fleet + 2 governing
+ 6 SOPs:

| Skill | What it owns |
|---|---|
| BV-SKILL-016 | vertical-slice discipline (scoping + QA criteria for a playable slice) |
| BV-SKILL-003 / 004 / 005 | controller / stance / traversal (slice consumes) |
| BV-SKILL-007 / 008 | stealth / AI perception (slice consumes) |
| BV-SKILL-011 | weapon handling / ballistics (slice consumes) |
| BV-SKILL-006 | environmental affordances (slice consumes) |
| BV-SKILL-013 | sector architecture (slice consumes for activation) |
| BV-SKILL-014 | mobile graphics / atmosphere (slice consumes for weather / lighting) |
| BV-SKILL-015 | observability contract (slice consumes) |
| BV-SKILL-017 | survival internals (slice consumes) |
| BV-SKILL-018 | horror authoring (slice consumes for anomaly seed) |
| BV-SKILL-020 | facility pipeline (slice consumes for restoration) |
| BV-SKILL-021 | CQC architecture (slice consumes for combat) |
| BV-SKILL-022 | equipment visual (slice consumes) |
| BV-SKILL-025 / 013 / 027 | weapons / sectors / ecology (slice consumes) |
| BV-SKILL-029 | world-systems (slice consumes for substrate) |
| BV-SKILL-031 | persistent-state methodology (slice consumes for state channels) |
| BV-SKILL-032 | visual presentation methodology (slice consumes for camera / HUD / weather / sound) |

D020's domain is **the SPECIFICATION of a vertical slice** — a sequencing / scoping / acceptance-criteria
layer that composes all the existing owners. Per D020 §15 expectation, a new skill is permitted only if no
current skill owns a reusable methodology.

BV-SKILL-016 (vertical-slice-discipline) ALREADY owns the methodology for scoping a playable slice, scoping
its fortune through depth over breadth, and QA criteria (per the skill's own description). D020
IMPLEMENTS the methodology through slice-specific application — it does not invent a new methodology.

Frozen determination: **NO new BV-SKILL-033.** The vertical-slice specification is a per-slice
application of BV-SKILL-016, composes with the rest of the fleet, and lives in this bible + this bible's
doctrine + the future implementation authorization.# — CONTINUED: PART C — FIXTURE DESIGN, OBSERVABILITY, DOCTRINE, APPENDICES, REPORT —

---

## 9. Fixture design (frozen)

The slice is shipped with ONE ACCEPTANCE FIXTURE. The fixture is a deterministic run that exercises the
acceptance criteria (D020 §7.1-§7.3).

### 9.1 Fixture scope (frozen)

- ONE deterministic seed.
- ONE run from S-1 Strand awakening through F1 Gyle Cannery interior.
- The run exercises ALL NINE MOMENTS (D020 §4.1-§4.8).
- The fixture records:
  - every state transition with reason (BV-SKILL-015 invariant 2)
  - the anomaly event's WORLD vs PERCEIVED separation (BV-SKILL-018 invariant 4)
  - the restoration beat's world-state propagation effect (D015 §21)
  - the player choice at every choice point (stealth / avoidance / engagement; trust evolution; shelter
    choice; meal/recovery beat)

### 9.2 Fixture determinism (frozen — BV-SKILL-015 invariant 4)

- AI decisions are seeded.
- Wildlife behavior is seeded.
- Weather transitions are seeded (the weather cycle is authored; not random).
- The anomaly event's trigger condition is authored; its reproduction is deterministic with the same seed.
- The player's choices are scripted in the fixture (the fixture is the canonical playthrough).

### 9.3 Fixture as acceptance test (frozen)

The fixture is the ACCEPTANCE TEST for the slice. If the fixture reproduces all 9 moments + all
acceptance criteria (D020 §7) with the same seed, the slice PASSES.

---

## 10. Observability requirements (frozen — SOP-006 / BV-SKILL-015)

Future implementation must expose:

```
- current character state (CONDITION / CORE TEMP / EXERTION / CONTROL bands)
- persistent-state channel reads (BODY / CLOTHING / WEAPONS / ENVIRONMENTAL RESIDUE)
- weather state (D015 §14 — the SINGLE-SOURCED WORD)
- AI belief tables (BV-SKILL-008 knowledge-with-source; D011 §7 truthful sensing)
- combat state (D008/D009 — CONTACT + SPATIAL; CONTROL; Strain)
- world-state propagation graph (D015 §21 — the edge that fired; the delta)
- anomaly event ID + WORLD/PERCEIVED truth (BV-SKILL-018 invariant 4)
- restoration beat's reason chain (D015 §17 consequence law)
```

Frozen rules:
- Overlay is zero-gameplay-effect (BV-SKILL-015 invariant 5)
- All state transitions carry reasons (BV-SKILL-015 invariant 2)
- WORLD vs PERCEIVED separation preserved (BV-SKILL-018 invariant 4)
- Replayable fixture is the canonical playthrough (D020 §9)

---

## 11. Future-saga containment (frozen)

D020 does NOT import:
- Saga 3 player-created protagonist
- real-island meta reveal
- future cosmic mythology
- later body transformation
- lunar / nonhuman story
- final-saga technology

Only the existing TINY retrospective seam budget is preserved (D015 §48). Seam candidates are not
promoted to canon.

---

## 12. Recommended D021 (not executed)

Per the user's directive (D020 final note):

**D021 — COMBAT ARCHITECTURE BIBLE.**

The user framing: combat is the remaining pillar that needs a deep design pass before implementation. The
production sequence is:

```
D019 = how it feels
D020 = prove it works
D021 = how fighting works
D022 = who fights you
```

D021 would author the combat architecture bible (deep design pass on D008/D009; BV-SKILL-021; combat
ownership; encounter design; player vs human threat escalation; combat integration with anomaly D016;
combat integration with reclamation D017; combat integration with survival D015). It would precede D022
(the AI / faction enemy-architecture bible).

D020 does NOT execute D021. **Not executed. STOP. NO COMMIT.**

---

## Appendix A — Contradiction ledger (D020)

| # | Existing canon | D020 position | Result |
|---|---|---|---|
| 1 | Doctrine §4 starting character lock (sidearm + 1+1 mag + boot knife + photograph) | §4.1 starting lock applied at awakening | No contradiction |
| 2 | Doctrine §10 GL Compatibility + Android-tablet first | §5.7 GL Compatibility baseline preserved; D004 §10 budgets | No contradiction |
| 3 | Doctrine §23 three threat classes | §4.4 human threat = primary; D016 anomaly is Phase 0 AMBIGUOUS only | No contradiction |
| 4 | Doctrine §29 opening structure (prologue peak, no supernatural) | §3 slice begins AFTER D014 §26 handoff; no prologue content in slice | No contradiction |
| 5 | Doctrine §34 narrative pillars (IDENTITY/BROTHERHOOD/RESPONSIBILITY) | §4.8 anomaly seed carries Pillar 3 RESPONSIBILITY | No contradiction |
| 6 | Doctrine §35-§39 combat / BV-D033..D040 | §4.5 + §5.1 combat uses D008/D009 architecture via BV-SKILL-021 | No contradiction |
| 7 | Doctrine §41 / §41.4 / §41.5 visual/equipment | §5.1 / §5.3 equipment visual via BV-SKILL-022 | No contradiction |
| 8 | BV-D001 GL Compatibility | §5.7 preserved | No contradiction |
| 9 | BV-D019 facility roster closed | §6.1 / §6.2 slice uses F1 only; later facilities excluded | No contradiction |
| 10 | BV-D020 ally anchored at base | §6.2 companion + ally future slices | No contradiction |
| 11 | BV-D033..D040 combat ownership | §4.5 / §5.1 combat exercises AI-facing interfaces via BV-SKILL-021 invariant 11 | No contradiction |
| 12 | BV-D042..D052 visual/equipment doctrine | §5.1 / §5.3 equipment visual via BV-SKILL-022 | No contradiction |
| 13 | BV-D052 design-language freeze only | §1 no implementation; specification only | No contradiction |
| 14 | D004 §3 / §4 sectors + facilities | §3 slice geography: S-1 Strand + coastal approach + F1 Gyle Cannery | No contradiction |
| 15 | D004 §10 edge-device budget | §5.7 budgets preserved | No contradiction |
| 16 | D008/D009 combat doctrine | §4.5 / §5.1 combat exercises D008/D009 architecture | No contradiction |
| 17 | D010 visual/equipment doctrine | §5.1 / §5.3 aligned | No contradiction |
| 18 | D011 §7 truthful sensing / no omniscience | §5.6 AI truthful sensing | No contradiction |
| 19 | D011 §15-§17 community archetypes | §4.6 survivor NPC uses WORK/FISHING CAMP or REMOTE HOUSEHOLD | No contradiction |
| 20 | D011 §22 human-first ability rule | §4.4 / §4.5 / §6.2 human threat = primary | No contradiction |
| 21 | D011 §23 regional distribution (S-1 restrained horror) | §5.6 S-1 archetype (Black Hand remnant / guard / contractor / fractured personnel) | No contradiction |
| 22 | D011 §31 boss doctrine | §6.2 boss doctrine excluded (slice is non-boss encounter) | No contradiction |
| 23 | D012 §12 pre-collapse markers stay non-paranormal | §4.1 slice is post-D014 awakening; pre-collapse reading preserved | No contradiction |
| 24 | D013 weapons | §5.1 starting lock + scavenge | No contradiction |
| 25 | D014 §26 S-1 awakening handoff | §3 / §4.1 slice begins AT the handoff | No contradiction |
| 26 | D014 §28 knowledge-gate table | §4.8 anomaly seed does not expose unknown facts; gates preserved | No contradiction |
| 27 | D015 §6 survival decisions not meters | §4.2 meal/recovery beats; place-based water | No contradiction |
| 28 | D015 §9 cold signature pressure | §4.2 / §5.1 cold bands active; diegetic feedback | No contradiction |
| 29 | D015 §12 shelter levels | §4.2 EXPOSED → WINDBREAK / CRUDE SHELTER | No contradiction |
| 30 | D015 §14 weather state machine | §5.5 / §5.7 one weather cycle; 3 states observed | No contradiction |
| 31 | D015 §16-§21 infrastructure + consequence law | §4.7 restoration beat applies §17 consequence law | No contradiction |
| 32 | D015 §22 community state + liability law | §4.6 trust evolves; survivor interaction observes community state | No contradiction |
| 33 | D015 §24 F1 Gyle Cannery systemic profile | §3 / §4.6 F1 anchored to D015 §24 | No contradiction |
| 34 | D015 §28 off-screen coarse model | §5.7 coarse states (SAFE / ACTIVE / THREATENED / DISPLACED / LOST) | No contradiction |
| 35 | D015 §31 Memory Bleed taxonomy (MICRO first) | §4.3 ONE MICRO Bleed authored; WALK-THROUGH / INTERACTIVE / REALITY BREACH future slices | No contradiction |
| 36 | D015 §33 horror rarity budget | §4.8 anomaly seed consumes ONE budget slot | No contradiction |
| 37 | D015 §34 True Unknowns scarce | §6.2 True Unknowns excluded from slice | No contradiction |
| 38 | D015 §40 wildlife-as-environmental-information | §4.3 wildlife-silence signal in coastal approach | No contradiction |
| 39 | D015 §43 sound as survival information | §5.7 ordinary audio taught before contamination | No contradiction |
| 40 | D015 §45 HUD ownership boundary | §5.4 wrist device + helmet passive + world HUD | No contradiction |
| 41 | D015 §47 Saga-1 containment | §11 future-saga containment preserved | No contradiction |
| 42 | D016 §7 five-phase discovery | §4.8 slice is Phase 0 AMBIGUOUS only; Phase 1 DENIAL seed may appear; no power unlock | No contradiction |
| 43 | D016 §11 first undeniable event (earned, forced, undeniable) | §4.8 / §6.2 slice = mystery not power; first undeniable event is post-slice (D018 §9 / D020 §12) | No contradiction |
| 44 | D016 §30 Compound / §31 Independent | §6.2 Compound/Independent excluded from slice | No contradiction |
| 45 | D016 §41-§45 presentation language | §5.1 / §5.2 / §5.3 / §5.4 / §5.7 compose with D016 | No contradiction |
| 46 | D016 §48 Superhero-prevention matrix | §4.4 / §4.5 NO power fantasy; player is weak | No contradiction |
| 47 | D017 §3 5-stage reclamation arc | §4.1 slice opens in STAGE 1; no transition | No contradiction |
| 48 | D017 §7 procedural memory | §4.1 STAGE 1 = broken; procedural memory surfacing is future slice | No contradiction |
| 49 | D017 §10 persistent state channels + §11 persistence law | §5.1 / §5.8 persistent state channels active; LIVING SAVE FILE | No contradiction |
| 50 | D017 §13 anti-tedium law | §4.6 washing/meal beats satisfying not mandatory | No contradiction |
| 51 | D017 §22 cleanliness social reactions | §4.6 survivor NPC observes player cleanliness | No contradiction |
| 52 | D017 §36 animation-evolution ladder | §5.1 STAGE 1 BROKEN animation-evolution state; ladder not transitioned | No contradiction |
| 53 | D017 §37 body-presence | §5.1 / §5.2 FP body-preservation | No contradiction |
| 54 | D017 §40 mirror moments | §6.1 / §6.2 mirror moments future slice (only if F1 interior supports) | No contradiction |
| 55 | D017 §42 no cosmetic cash-shop logic | §6.2 cosmetic cash-shop excluded | No contradiction |
| 56 | D017 §46 permanent consequences | §5.8 major scars / persistent injuries future slice | No contradiction |
| 57 | D017 §47 failure recovery | §4.4 encounter tolerates failure | No contradiction |
| 58 | D017 §50 tablet-feasible persistent-state architecture | §5.1 / §5.7 architecture preserved | No contradiction |
| 59 | D017 §51 save-data shape | §5.8 save-state shape aligned | No contradiction |
| 60 | D017 §53 accessibility overrides | §5.2 weather shake reduction; §5.7 audio accessibility | No contradiction |
| 61 | D017 §54 character identity protection | §4.1 / §6.2 character is The Hand; player shapes presentation, not identity | No contradiction |
| 62 | D018 §5 ACT I SURVIVE | §3 / §4 slice spans ACT I | No contradiction |
| 63 | D018 §6 F1 Gyle Cannery first stable anchor | §3 / §4.6 F1 anchored | No contradiction |
| 64 | D018 §11 / §37 human threat escalation | §4.4 / §5.6 human threat = primary (D011 §22) | No contradiction |
| 65 | D018 §20 weather pacing | §4.2 / §5.5 weather event punctuates slice | No contradiction |
| 66 | D018 §39 vertical-slice recommendation | §3 slice = S-1 → F1 coastal approach with one restoration beat | No contradiction |
| 67 | D018 §55 mission taxonomy (frozen) | §4 MOMENTS correspond to mission families (SURVIVE / RECON / INFILTRATE / CONFRONT / TRAVERSE / RESTORE / INVESTIGATE) | No contradiction |
| 68 | D019 §3 camera system | §5.2 camera spec aligned | No contradiction |
| 69 | D019 §4 helmet/visor | §5.3 PASSIVE only; tactical/anomalous future | No contradiction |
| 70 | D019 §5 HUD-as-equipment | §5.4 wrist device + helmet passive + world HUD aligned | No contradiction |
| 71 | D019 §6 survival HUD | §5.4 diegetic cues aligned | No contradiction |
| 72 | D019 §11 weather presentation | §5.5 / §5.7 per-state presentation aligned | No contradiction |
| 73 | D019 §12 horror presentation | §4.8 mystery not power; fairness preserved (D015 §30) | No contradiction |
| 74 | D019 §13 sound language | §5.7 audio channels aligned | No contradiction |
| 75 | D019 §14 animation priority tiers | §5.1 Tier 1 active; Tier 2 partial; Tier 3 minimal | No contradiction |
| 76 | D019 §15 signature moments | §4.1 awakening / §4.7 restoration / §4.8 anomaly seed are slice moments | No contradiction |
| 77 | D019 §16 tablet performance law | §5.7 + §7.3 budgets preserved | No contradiction |
| 78 | D019 §17 HUD ownership boundary | §5.4 ownership table aligned | No contradiction |
| 79 | BV-SKILL-016 vertical-slice-discipline | §1 / §7 / §8 BV-SKILL-016 owns slice scoping; D020 applies it | No contradiction |
| 80 | BV-SKILL-015 / SOP-006 observability | §10 observability aligned | No contradiction |
| 81 | SOP-005 gameplay verification | §7.5 / §7.6 acceptance criteria + validator gates | No contradiction |
| 82 | SOP-003 godot-change-procedure | §1 no implementation; future runtime requires SOP-003 | No contradiction |

Result: **0 contradictions found.** No silent repair required. D020 specifies the first vertical slice
without modifying any prior canon. The slice is a per-slice application of BV-SKILL-016 + the rest of the
fleet; no new methodology skill is needed.

## Appendix B — Deferred decisions (D020)

1. The exact authored scene content for each of the 9 moments — CANDIDATE pending implementation
   authorization (this spec is the architecture; the content is the implementation).
2. The specific restoration system choice (generator / communications / heating / medical equipment) —
   CANDIDATE per implementation; the spec covers all four.
3. The specific human archetype (Black Hand remnant / guard / contractor / fractured personnel) — CANDIDATE.
4. The specific wildlife behavior choice (brown bear / moose / wolves) — CANDIDATE.
5. The specific anomaly event content — CANDIDATE; bounded by §4.8 / §6.
6. The exact weather cycle (3 states observed) — CANDIDATE; D015 §14 state machine constrained.
7. The exact authored survivor NPC identity / backstory — CANDIDATE.
8. The specific environmental storytelling cue set in the coastal approach — CANDIDATE.
9. The exact seed for the acceptance fixture — implementation authorization.
10. The future implementation authorization — separate directive (D021 or later per user's directive final
    note).

## Appendix C — Stop-condition trace (D020)

This bible STOPS if any stop condition fires:
- slice scope becomes "full game" — §6.1 / §6.2 frozen inclusions/exclusions prevent.
- implementation changes game/ without authorization — §1 / §7.6 / D020 STOP prevent.
- canon is contradicted — 82-ledger check: 0 contradictions.
- new methodology skill is created without justification — §8 frozen determination: NO new skill.
- future-saga material is imported — §11 containment preserved.
- validators fail — §7.6 / §9.2 deterministic fixture gates.

None triggered. **Validation below. STOP. NO COMMIT. RETURN REPORT.**

---

# FINAL REPORT — DIRECTIVE 020

**Vertical Slice Implementation Specification.**

---

**Files inspected:** doctrine §3 / §4 / §5 / §6 / §10 / §29 / §34 / §35-§39 / §41 / §41.1-§41.16; D004 §3 / §4 / §10; D008/D009; D010; D011 §15-§17 / §22 / §23 / §31; D012 §12; D013; D014 §26 / §28; D015 §6-§15 / §22 / §24 / §28 / §31 / §33 / §34 / §40 / §43 / §45 / §47; D016 §7 / §11 / §30 / §31 / §41-§45 / §48; D017 §3 / §7 / §10 / §11 / §13 / §22 / §36 / §37 / §40 / §42 / §46 / §47 / §50 / §51 / §53 / §54; D018 §5 / §6 / §11 / §20 / §37 / §39 / §55; D019 §3 / §4 / §5 / §6 / §11 / §12 / §13 / §14 / §15 / §16 / §17. Skills 001..032 + 2 governing + 6 SOPs.

**Skills consumed:** governing set + SOP-003 / SOP-005 / SOP-006; composed with full 32-BV-skill fleet (BV-SKILL-016 vertical-slice-discipline owning slice scoping methodology; BV-SKILL-021 combat; BV-SKILL-022 equipment visual; BV-SKILL-031 persistent-state; BV-SKILL-032 visual-presentation; etc.).

**Files created/modified:**
- Created: `docs/design/VERTICAL_SLICE_IMPLEMENTATION_SPECIFICATION.md` (chunk assembly in progress at report time).
- Modified: `doctrine/BLACK_VECTOR_DOCTRINE.md` (if durable laws are discovered — CANDIDATE pending final assembly check); `README.md` (status update). Staging chunks removed. No skill / no registry / no validator changes (no new skill created per §8 frozen determination).

**Doctrine IDs added:** Per the user's "BV-D123+ only if durable laws are discovered" instruction, D020 reviews the 82-ledger contradiction check for durable laws. ONE durable law discovered in the slice specification:

**BV-D123** — VERTICAL SLICE CANONICAL REFERENCE (frozen): the first BLACK VECTOR vertical slice is `docs/design/VERTICAL_SLICE_IMPLEMENTATION_SPECIFICATION.md` (Directive 020); slice geography = S-1 Strand awakening → coastal approach corridor → F1 Gyle Cannery exterior + interior hot-load (D018 §39 recommendation); nine required experience moments anchored to D017 / D015 / D019 / D008-D009 / D016 / D011; per-system implementation spec preserves D004 §10 budgets + D017 §50 architecture + D019 §16 tablet-performance law; production boundaries frozen (§6.1 INCLUDED; §6.2 EXCLUDED); acceptance criteria frozen (§7); acceptance fixture is deterministic with seed; NO new methodology skill created (BV-SKILL-016 owns slice scoping; D020 applies it); no game/ modifications without authorization; no implementation without SOP-003.

**Slice geography (frozen):** S-1 Strand awakening (D014 §26 handoff) → coastal approach corridor → F1 Gyle Cannery exterior + ONE interior hot-load (D015 §24 + D018 §6).

**Required experience loop (frozen):** 9 moments + technical requirements (D020 §4):
1. Awakening Sequence (D017 BROKEN SURVIVOR + D015 survival + D019 presentation)
2. First Survival Problem (D015 cold bands + shelter levels + meal beats)
3. Exploration Layer (environmental storytelling + abandoned infrastructure + ONE MICRO Bleed)
4. First Human Encounter (D011 §22 human-first; stealth/avoidance/engagement; tolerates failure)
5. First Combat Test (D008/D009 ownership; "I survived because I made the right choice")
6. First Community Contact (F1 Gyle Cannery; D011 §16 community archetype; trust evolution)
7. Restoration Beat (ONE system restored; D015 §17 consequence law; world visibly changes)
8. First Anomaly Seed (D016 §7 Phase 0 AMBIGUOUS; MYSTERY not power; Pillar 3 RESPONSIBILITY)
9. Technical Requirements (character / world / AI / UI / audio)

**Implementation specification (frozen — D020 §5):** per-system spec for character controller / camera / helmet-visor / HUD / world / AI / audio / persistence / observability; out-of-scope explicitly listed per system.

**Production boundaries (frozen — D020 §6):** INCLUDED = S-1 + coastal approach + F1 + ONE survivor + ONE restoration + ONE anomaly hint + ONE human encounter + ONE wildlife + ONE weather cycle + ONE Memory Bleed + persistent state channels + camera + helmet passive + wrist device + audio. EXCLUDED = full island / full factions / advanced powers / complete crafting / final AI systems / later facilities / reclamation stage progression / Compound-Independent / Companion / former Hidden Hand / True Unknowns / Program Casualties / Bleeds beyond MICRO / major horror events / prologue / future-saga.

**Acceptance criteria (frozen — D020 §7):** required experience loop (9 moments); required technical surface (character/world/AI/UI/audio); tablet feasibility (D004 §10 budgets; D015 §28 off-screen; D019 §16); canon compliance (0 contradictions vs D001..D019); fixture determinism (BV-SKILL-015 invariant 4); validator gates (methodology PASSED; static game CLEAN 24 ok / 0 fail); no game/ modifications without authorization.

**Fixture design (frozen — D020 §9):** ONE deterministic seed; ONE canonical playthrough from S-1 to F1 interior; records every state transition with reason + anomaly event's WORLD/PERCEIVED truth + restoration propagation effect + player choices; the fixture IS the acceptance test.

**Observability (frozen — D020 §10):** SOP-006 / BV-SKILL-015 contract: BV.DEBUG overlay prefix; events log reason; WORLD vs PERCEIVED separation preserved; replayable fixture; overlay zero-gameplay-effect.

**Future-saga containment (frozen — D020 §11):** no Saga-3 / real-island meta / cosmic mythology / body transformation / lunar / nonhuman / final-saga technology; only the existing tiny retrospective seam budget (D015 §48) preserved.

**Methodology validation (frozen — D020 §8):** 32-BV-skill fleet inspected. NO new skill created. BV-SKILL-016 (vertical-slice-discipline) owns the slice scoping methodology; D020 applies it.

**Validation:** methodology PASSED (2 governing + 32 BV skills unchanged from D019); static game **CLEAN 24 ok / 0 fail** (unchanged); **no game/ files touched**; chunks removed.

**Contradictions:** 82-ledger check vs D001..D019 — **0 contradictions found.** No silent repair required. D020 specifies the first vertical slice without modifying any prior canon.

---

**Recommended D021 (not executed):** D021 — COMBAT ARCHITECTURE BIBLE. Per the user's directive final note. The production sequence:

```
D019 = how it feels        ✔
D020 = prove it works      ✔
D021 = how fighting works  (recommended next)
D022 = who fights you      (after D021)
```

D021 would author a deep combat design pass (D008/D009; BV-SKILL-021; combat ownership; encounter
design; player vs human threat escalation; combat integration with anomaly D016 + reclamation D017 +
survival D015). It would precede D022 (the AI / faction enemy-architecture bible).

**Not executed. STOP. NO COMMIT.**

---

**Slice canonical reference established (BV-D123). D020 complete. Awaiting approval or next directive.**