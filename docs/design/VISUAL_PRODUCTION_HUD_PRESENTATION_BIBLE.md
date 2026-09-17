# BLACK VECTOR — VISUAL PRODUCTION, HUD & PRESENTATION BIBLE

> Directive-019 deliverable. VISUAL / HUD / PRESENTATION ARCHITECTURE ONLY. Not VFX production, not animation
> production, not shader implementation. Primary model: Big Pickle (per user routing; the directive's
> "MiniMax M3" attribution is again disregarded this session).
> Authority: THE DEVELOPER'S WAY -> doctrine -> SOP -> skills -> D004 world foundation -> D010 visual
> equipment doctrine (BV-D042..D052) -> D011 ecology -> D012 provenance -> D013 weapons -> D014 prologue ->
> D015 substrate (BV-D079..D086, HUD ownership) -> D016 anomaly presentation -> D017 persistent-state
> channels (BV-D096..BV-D104, animation-evolution) -> D018 campaign spine (BV-D105..BV-D113) -> this document.
> This bible FREEZES the player's experiential language: visual identity, camera, helmet/visor, HUD,
> survival feedback, character visual evolution, clothing/armor/weapon language, grooming presentation,
> environment visual bible, weather, horror, sound, animation priorities, signature moments, tablet
> performance law. SYSTEM LAW vs CONTENT CANDIDATE strictly separated (D019 §16 / D015 §58 / D016 §58).
> GAME IMPLEMENTATION STARTED: NO.

---

## 1. Binding context & canon consumed

- Inspected: doctrine §5 (Environment Doctrine), §6 (Stealth Doctrine), §9 (Weapon Doctrine), §10
  (Platform/Renderer — GL Compatibility, Android-tablet first), §29 (Opening Structure), §34 (Narrative
  Pillars), §41 / §41.1-§41.16 (Visual & Equipment Doctrine — BV-D042..D052), §41.4 (Shade baseline),
  §41.5 (Shade armor tiers), §41.11 (Wear/Damage states).
- D004 §10 edge-device budget (Android/tablet target; GL Compatibility; <1,200 active nodes per sector;
  6–10 human AI + 4–8 wildlife per hotspot; baked lighting + 1 directional + fog; ~200–260 MB working set).
- D011 §6/§10/§12/§14/§17/§22/§23 (population visual roles; Shade armor tiers; cybernetic subjects; former
  Hidden Hand; contractors; human-first ability rule; regional distribution).
- D012 provenance (program lineage; generation tags drive visual provenance; D010 already binds).
- D013 weapons + Layered Overwatch (R-1..R-7/P-1/G-1/civilian/S-line; precision family = R-6 mobile
  precision; D013 §25-§26 psionic weapon boundary BV-D070).
- D014 prologue (OP HALF-LIGHT peak — clean equipment, controlled movement, legendary silhouette — the
  visual reference; BV-D071..BV-D078).
- D015 §14 weather state machine + §9 cold diegetic feedback + §22 community state + §24 F1..F5 systemic
  profiles + §45 HUD ownership boundary + §47 Saga-1 containment.
- D016 §41-§45 presentation language (visual / audio / body feedback / HUD discovery principles) +
  §48 prevention matrix + §49 Season-1 ceiling.
- D017 §10-§11 persistent state channels + persistence law + §14-§17 hair + §18 quick radial + §19 base
  grooming + §21 facial hair + §26 clothing layer system + §28 armor progression + §29 weapon visual
  history + §35-§38 animation evolution + body presence + §42 no cosmetic cash-shop + §50 tablet-
  feasible architecture + §51 save-data shape + §53 accessibility overrides + §54 character identity
  protection.
- D018 §10 facility sequencing + §20 weather pacing + §34 escalation + §39 vertical slice recommendation.
- Skills reviewed: BV-SKILL-014 mobile-graphics-atmosphere (weather SHARED state / lighting / LOD /
  atmosphere), BV-SKILL-022 visual-equipment-doctrine (armor/weapons/gear silhouette language), BV-SKILL-031
  persistent-character-state-architecture (state channels, animation-evolution, body-presence methodology),
  BV-SKILL-015 gameplay-debugging-instrumentation (observability).

## 2. Visual identity (frozen)

> **When someone sees five seconds of gameplay, how do they know this is BLACK VECTOR?**

Lock (frozen):
- grounded military survival horror
- Alaska isolation
- abandoned infrastructure (people lived here)
- human vulnerability
- restrained anomaly

Avoid (frozen):
- superhero visuals
- glowing magic effects
- sci-fi cleanliness
- generic zombie apocalypse aesthetics
- fantasy loot appearance (D017 §42)
- rarity colors (D017 §42)

Core principle (frozen):
> **Technology should look USED. The environment should look like people LIVED here before everything failed.**

Frozen consequence: every visual decision must answer "what was this FOR, here, and who used it last?" (doctrine
§11 / D004 §5 anti-videogame-architecture rule). A structure / prop / object that exists only as decoration
is a design smell; what exists must read as USED.

## 3. Camera system (frozen)

### 3.1 Third Person (primary exploration/combat camera)

Requirements (frozen):
- cinematic but functional (the camera serves gameplay first)
- close enough to see CHARACTER CONDITION (D017 persistent-state channels must read at gameplay distance)
- readable weapon handling (the rifle in hand is a sentence the camera writes)
- environmental awareness (the player must read weather / route / threats through the camera)

Frozen shoulder behavior:
- camera follows shoulder (default over-the-shoulder offset; not behind-back only)
- distance + height per stance (D015 §14 weather can dampen camera; D015 §9 cold can tighten the camera —
  cold = close camera; storm = heavy camera weather-effects)
- stance transitions are visible (crouch / prone / sprint)

Frozen aiming transition:
- rifle aim zooms to FIRST-PERSON / precision view (D019 §3.2) for a held window
- return-to-3P on disengage; camera eases back to shoulder
- aim assist is diegetic (visor reticle; D019 §4) — no magic auto-aim

Frozen stealth camera behavior:
- camera lowers / tightens during stealth (closer, narrower FOV)
- environmental cover reads first (the camera frames the player's concealment surfaces)

Frozen injury camera effects:
- CONDITION LOW → slight camera weight; peripheral vignette
- WOUND visible body region → micro-tremor / posture tilt (D017 §37 body presence)
- a CRITICAL-band Strain / hypothermic state may tighten the FOV further (NOT a screen effect; the world reads)

Frozen weather camera effects (per D015 §14):
- rain → lens droplets (low-cost shader)
- snow → particle accumulation on lens (low-cost; clears with movement)
- fog → desaturated; reduced draw distance
- storm → heavy lens FX + camera shake (D017 §53 accessibility override for shake)

### 3.2 First Person (precision / helmet / psychological / immersion moments)

Used for (frozen):
- precision aiming (rifle / DMR / precision weapon moments)
- helmet / visor moments (D019 §4)
- psychological events (D015 §31 Memory Bleeds — Interactive / Reality Breach)
- immersion moments (D017 §40 mirror moments, base-grooming inspection, scar recognition)

Must preserve (frozen, body-presence law):
- hands (the player's hands are visible in FP)
- sleeves (clothing layers visible at wrist)
- gloves (gear / condition visible)
- hair (D017 §15 hair consequences; loose hair in precision view)
- breath (D015 §9 cold breath; D019 §12 audio)
- dirt (D017 §10 residue channel; FP reads dirt on the player's own hands)
- blood (D017 §23 blood on hands reads; Pillar 3 RESPONSIBILITY)
- equipment (weapon visible in FP; visor HUD elements visible)

Frozen rule: the FP camera is NOT an invisible floating lens. The body is the medium of feedback (doctrine
§36.4 diegetic-first; D017 §37).

## 4. Helmet / visor system (frozen — signature identity)

The helmet / visor is one of BLACK VECTOR's signature identities (D019 §3). Frozen as THREE LAYERS of capability
(NEVER a wallhack):

### 4.1 Passive (always available)

Always-on (frozen):
- environmental readings (temperature band, weather state, time-of-day read)
- basic diagnostics (condition band; control band; exertion band; later Neural Strain band per D015 §45 / D016 §45)
- compass (D015 §25 navigation)
- equipment status (current weapon + condition)

Frozen rule: PASSIVE is diegetic — the player has equipment, the equipment shows things. NO magical floating
numbers.

### 4.2 Tactical (activated)

Activated (frozen) — never on by default:
- drone feed (D013 Layered Overwatch sensor layer; D011 §7 truthful sensing)
- team / system information (ally radio; communication channel)
- threat marking (LEGITIMATE TARGET INFORMATION ONLY — no omniscient enemy outlines through walls; D011 §7)

Frozen rule: TACTICAL is OPT-IN. Activation is a deliberate player choice (button / gesture / voice cue).
Activation has a cost: it is a SIGNATURE event (lighting up; audio cue; brief moment of visual feedback the
world sees).

### 4.3 Anomalous (late discovery)

Discovered late in campaign (frozen):
- perceptual changes (the player's anomalous capability begins to alter what the visor shows)
- sensory distortion (the visor feeds back the player's Strain / perception state)
- anomaly feedback (rare; tied to True Unknowns / horror events; budget-controlled per D015 §33)

Frozen rule: ANOMALOUS is AUTHORED, never automatic. It may overlap with the capability discovery (D016 §7
five-phase). It is NEVER a wallhack — even when anomalous, the visor does NOT show enemy health, position
through walls, or guaranteed future knowledge (D016 §20 / D007 sensing truth authoritative).

### 4.4 Helmet hardware identity (frozen)

- The helmet is a piece of EQUIPMENT (BV-SKILL-022 visual). It looks USED.
- Helmet state: present / absent / visor-up / visor-down / visor-dirty.
- Visor state reads diegetically: clean → dirty → cracked → repaired (D017 §27 clothing history pattern).
- A damaged visor reduces clarity (D017 §12 visible-state → consequence law).
- The helmet is not a sci-fi HUD. It looks like the kind of equipment a military operator could wear that
  carries the diagnostics the world needs.

## 5. HUD philosophy (frozen)

> **The HUD exists because the character has equipment, not because the player needs a videogame overlay.**

Every HUD element must trace to EQUIPMENT the character is wearing. The HUD is the equipment's display, not
the game's UI.

### 5.1 Wrist Device (frozen)

Handles (frozen):
- condition (D015 §7 body-status model)
- temperature (D015 §9 thermal bands)
- inventory (what the player carries; D017 §26 clothing layer slots + carried gear)
- communications (D015 §23 community liability; ally radio)
- diagnostics (wound / injury / scar reads; weapon condition)

Frozen rules:
- The wrist device is a piece of EQUIPMENT the player character wears. It looks worn / repaired.
- Wrist-device UI surfaces are NOT a giant MMO inventory screen. They are READS the equipment shows.
- Wrist-device HUD respects D015 §45 (CONDITION / CORE TEMPERATURE / EXERTION / CONTROL near-permanent;
  conditions contextual; diagnostics screen for body diagram / detailed readouts).

### 5.2 Helmet HUD (frozen)

Handles (frozen):
- navigation (compass; landmark cues per D015 §25)
- tactical information (when tactical visor layer active; D019 §4.2)
- sensor information (drone feed when active; D011 §7 truthful sensing)

### 5.3 World (frozen)

Handles (frozen):
- objectives (environmental / contextual; not a giant quest log)
- clues (environmental storytelling; D011 / D015 program-island / civilian-island layering)
- world-state propagation indicators (D015 §21 propagation effects the world shows)

Frozen rules:
- World HUD is the world. A door that opens because you restored power is a world HUD cue. A storm that
  closes a route is a world HUD cue. NPCs who trust you is a world HUD cue.
- NO floating markers above NPCs / objectives. The world has to be READ, not scanned.

## 6. Survival HUD (frozen)

D019 §5 expands D015 §45 + D016 §45 ownership.

### 6.1 Presentation rules

Five near-permanent state variables (D015 §45 frozen):
- CONDITION (body-status model)
- CORE TEMPERATURE (band: NORMAL / COLD / CHILLED / HYPOTHERMIC RISK / SEVERE)
- EXERTION (band)
- CONTROL (D008/D009 band)
- NEURAL STRAIN (D016 §4 band; LATE in campaign)

Forbidden (frozen):
- giant health bars
- MMO meters
- floating numbers
- precision gauges
- "happy-gauges" (doctrine §36.1)

### 6.2 Examples (frozen — by state variable)

**Low temperature** — NOT:
> `TEMPERATURE -20%`

INSTEAD (frozen set):
- shaking hands
- slower breathing
- frost buildup (visual residue)
- wrist-device warning (small diegetic alert)
- reduced dexterity (action timing penalty + visible animation)

**High Exertion** — NOT:
> `EXERTION 87/100`

INSTEAD (frozen set):
- ragged breathing (audio + animation)
- posture degradation (D017 §35 animation-evolution)
- wrist-device band shifts toward RED (color band, no number)
- recovery transitions slow

**Low Control** — NOT:
> `CONTROL 0.34`

INSTEAD (frozen):
- hand tremor (animation)
- audio narrowing (D017 §12 / D016 §44)
- peripheral vignette (subtle)
- breathing pitch shift
- thin HUD band label only (doctrine §36.1)

**Critical Neural Strain** (D016 §4 late-campaign):
- visual tearing begins
- tinnitus layer (D016 §44 audio vocabulary)
- brief focus deformation (D016 §41 presentation principle)
- involuntary manifestation risk (D016 §29 / D015 §34)

Frozen rule: each variable has a SMALL SET of diegetic cues that READ THE STATE through the body / world,
not through a UI meter. The overlay confirms; the body communicates.# — CONTINUED: PART B — CHARACTER VISUAL EVOLUTION, CLOTHING/ARMOR/WEAPON LANGUAGE, GROOMING —

---

## 7. Character visual evolution (frozen)

D019 §6 maps D017 §3 5-stage reclamation arc into visual-evolution states (D017 §35-§36 ladder). Frozen:

### 7.1 STAGE 0 — Prologue Hand (LEGEND)
- clean equipment (D014 §10 OP HALF-LIGHT; D013 Layered Overwatch kit)
- controlled movement
- confidence
- legendary silhouette (Hidden Hand operator reference; doctrine §15)

This is the visual REFERENCE POINT, not the starting state of the main game.

### 7.2 STAGE 1 — Broken Hand (BROKEN SURVIVOR, main-game opening)
- damaged clothing (doctrine §4 starting lock + D015 substrate damage)
- poor posture (prison-hardened; survival focus; animation-evolution BROKEN state)
- uncontrolled appearance (deconditioning; hair / beard / residue; D017 §3)
- survival focus (the body reads as the man's life right now)

### 7.3 STAGE 2 — Relearning (RELEARNING)
- repaired equipment (player has begun restoring gear; F1 workshop accessible)
- recovered discipline (procedural memory surfacing; D017 §7)
- mixed old/new identity (prison adaptability + operator habits emerging; D017 §3 INTEGRATED origin tagging)

### 7.4 STAGE 3 — Recovering Operator (RECOVERING OPERATOR)
- operator-grade capability returns (D017 §35 animation-evolution RECOVERING; cleaner reloads; posture
  improves)
- deliberate weapon choice (D018 §28 weapon progression; R-3 / R-5 family familiarity)
- signature procedural recognition (D017 §30 signature precision return)

### 7.5 STAGE 4 — Integrated Hand (INTEGRATED HAND, late Season 1)
- unique player-created silhouette (D017 §41 player-authored visual identity)
- the synthesis — Hidden Hand discipline + prison adaptability + Simse Sound survival + anomalous
  integration + player-authored presentation (D018 §37)
- a player should be able to compare the final character VISUALLY and MECHANICALLY against the person who
  woke on the Strand (D018 §37; D017 §36 animation-evolution ladder)

Frozen rule: each STAGE transition is an AUTHORED EVENT (a moment, a beat, a chapter), not an ambient
drift (D017 §36 frozen rule).

## 8. Clothing & equipment visual language (frozen)

D019 §8 freezes presentation principles for clothing / armor / weapons. BV-SKILL-022 retains OWNERSHIP of the
equipment visual language (D010 / BV-D042..D052). D019 composes presentation-level rules that the equipment
language must satisfy.

### 8.1 Material rules (frozen)

- Materials look USED. Dirt, wear, repair decals, weathering, oil, blood residue — the equipment has history.
- No clean plastic / chrome / sci-fi surface treatments outside the T4 technology ladder (doctrine §41.12).
- Military substrate first (doctrine §41.2); Alaska serviceable (doctrine §41.10); wear/damage spectrum
  readable (doctrine §41.11).
- A piece of equipment looks like it was made FOR a purpose in the world and was used by people who lived
  here (D019 §2 core principle).

### 8.2 Layering (frozen)

- Clothing layers (D017 §26) are BOUNDED: base · mid · outer · lower body · footwear · gloves · head ·
  face/neck · armor overlay.
- Layers READ at gameplay distance. A player can see at 3P that the operator is wearing a base + mid + outer
  + armor overlay.
- A missing layer reads. A wet layer reads. A repaired layer reads (D017 §27 clothing history).

### 8.3 Repair visibility (frozen)

- Repairs remain visible where practical (D017 §27).
- A jacket's history is a sentence the player reads.
- No invisible auto-repair. No rarity-color loot that hides the repair history.

### 8.4 Weather effects (frozen)

- Wet clothing darkens (material parameter; D015 §24 wetness visualization).
- Snow / mud / salt / ash accumulate selectively on boots / knees / gloves / outer armor / hair / shoulders
  (D017 §25).
- Residue is diegetic state — the world shows it; the wrist device confirms it; the player feels it.

### 8.5 Armor progression (frozen, D017 §28)

Broad visual phases:

```
IMPROVISED        — scavenged / mismatched / minimal
FUNCTIONAL        — selected intentionally
RECONSTRUCTED     — operator-grade capability returns
INTEGRATED        — late-game customized configuration combining old/new identity
```

Frozen rules:
- No superhero armor (doctrine §41.4 / BV-D044).
- D010 / BV-SKILL-022 authoritative.
- The progression is CHARACTER-DRIVEN, not stat-driven (D017 §28).
- Each phase reads at 3P; the operator's armor choices are visible and meaningful.

### 8.6 Customization boundaries (frozen)

- The player shapes PRESENTATION (D017 §41 / D017 §54 character identity protection), not the man's face,
  tattoos, core body identity, or established scars.
- Repair, replacement, attachment changes — all allowed.
- No fantasy loot appearance; no rarity colors; no cosmetic cash-shop logic (D017 §42).
- Player-authored visual identity is meaningful at STAGE 4 (two players' Hands may look meaningfully different
  while preserving the authored core).

## 9. Grooming presentation (frozen)

D019 §9 expands D017 §14-§22. Frozen presentation rules:

### 9.1 Hair states (frozen; D017 §14)
- finite states: LOOSE · LOOSELY TIED · PONYTAIL/TIED BACK · UNDER HOOD · CONSTRAINED BY HEADGEAR ·
  WET/MATTED
- no strand simulation (D017 §50)
- hair state reads at 3P; loose hair occasionally crosses peripheral / FP view (D017 §15)

### 9.2 Beard states (frozen; D017 §21)
- CLEAN-SHAVEN · STUBBLE · SHORT BEARD/GOATEE · LONGER UNMANAGED GROWTH
- growth over MEANINGFUL TIME SPANS (D017 §14); no continuous strand simulation

### 9.3 Washing / shaving / grooming (frozen; D017 §19)
- Mirror / Bathroom surfaces mediate deliberate grooming (D017 §19)
- washing is satisfying, not mandatory busywork (D017 §22)
- grooming is CHARACTERIZATION, not a stat (D017 §20); no morality score

### 9.4 Injury inspection (frozen)
- Mirror / Medical surfaces allow the player to inspect visible injuries / scars (D017 §19 MEDICAL AREA)
- inspection is a deliberate character beat (D017 §40 mirror moments), not a routine action
- visible injuries are PERSISTENT (D017 §11) until the world changes them (treated / healed / scarred)

### 9.5 Mirror interactions (frozen; D017 §40)
- mirrors are SPARING character beats, not constant UI terminals
- first clear look after experimentation; noticing new scar; shaving after long growth; seeing resemblance
  to old Hand; choosing not to recreate old appearance
- each mirror beat is authored (D017 §40)

Frozen principle (frozen):
> **Grooming is not cosmetic.** It represents safety · identity · recovery · psychological state (D017 §1
> governing law). The visible state communicates the man's life.

## 10. Environment visual bible (frozen)

D019 §10 freezes the per-facility visual identity. Each facility has a distinct identity readable at the
moment of arrival. (Visual-content specifics are CANDIDATE; the IDENTITY CONTRACT is frozen.)

### 10.1 F1 GYLE CANNERY (S-3 Forelands)
Identity (frozen):
- coastal survival (the first stable anchor; D018 §6)
- first community (REMOTE HOUSEHOLD / WORK-FISHING CAMP archetypes per D011 §16)
- practical restoration (workshop / food / marine access)
- USCG-outpost heritage (doctrine §31 / D004 §4 / D015 §24)

Visual reads (frozen — character of the place, not locked content):
- marine / weather-exposed construction (stilted / quonset heritage per D004 §4)
- salt / rust / weather-stained surfaces
- working-boat infrastructure (float ramp, dock)
- community spaces (kitchen / mess) that read as LIVED-IN
- a radio that looks like the program's communication gear when restored (D015 §24 consequence)

### 10.2 F2 TANELLUS BIOLOGICAL STATION (S-6 Research Coast)
Identity (frozen):
- medical truth (D015 §24 medicine + archives)
- abandoned research (D011 §10 doctors/scientists; experimental residue)
- human cost (the program read on the place)

Visual reads (frozen):
- research-station heritage (D004 §4 Arctic Research Lab logic)
- small-staff compact life support
- examination-room spatial repetition (D015 §48 retrospective seam candidate; intentional motif)
- medical equipment that LOOKS medical (not sci-fi; not horror-movie)
- program-casualty evidence readable as medical-history, not shock-value

### 10.3 F3 FROSTVANE RIDGE RELAY (S-4 High Pass)
Identity (frozen):
- weather control (D015 §14 weather instrumentation; forecasting)
- communications (D011 §7 sector trunk; D015 §21 propagation)
- isolation (the place is lonely; the operator is alone up here)

Visual reads (frozen):
- White Alice heritage (D004 §4 / D012 §12)
- upper / lower camp split
- billboard troposcatter / EM tower
- wind / weather-hostile siting
- the relay restored becomes the sector's NERVE — restoration has a visible effect on the world

### 10.4 F4 VIVARA MINE (S-5 Gulch)
Identity (frozen):
- buried secrets (D015 §24 underground traversal + program layers)
- industrial depth (Kennecott heritage; timber / mill / aerial tram)

Visual reads (frozen):
- company-town over engineered mine galleries
- timber trestles / rail spur
- aerial tram heritage
- industrial tools that read INDUSTRIAL (not fantasy)
- the deep descent reads as DEPTH (the player's descent into program truth)

### 10.5 F5 BLACK HAND ANNEX (S-2)
Identity (frozen):
- deepest program horror (D015 §24 / doctrine §31 Primary)
- the world's CRISIS GROUND

Visual reads (frozen):
- dispersed military / "Navy Town" logic (D004 §4 / D012 §12)
- airfield-adjacent grid
- corridors / sealed levels
- security / medical / research spaces that read as BUILT FOR THEIR PURPOSES (doctrine §5 anti-videogame-
  architecture rule)
- the place LOOKS LIKE the program that built it — used, real, institutional
- the Darkness's effects (D012 §19-§20) are PRESENT but NOT theatrical (D015 §20 — restrained illumination /
  boundary-adjacent / tied to interior expansion)

Frozen rule: every facility's visual identity serves the IDENTITY CONTRACT above. Content-specific visual
choices are authored in future scene directives; the identity is frozen here.# — CONTINUED: PART C — WEATHER, HORROR, SOUND, ANIMATION PRIORITIES —

---

## 11. Weather presentation (frozen)

D019 §11 expands D015 §14 weather state machine + D015 §15 storms into PRESENTATION form. The weather state
machine is single-sourced (D015 §14); every consumer reads the same word. Presentation rules:

### 11.1 Per-state presentation (frozen)

| State | Lighting | Sound | Particle | Traversal feel |
|---|---|---|---|---|
| CLEAR/COLD | long shadows; cool color temperature | wind (low) | dust / breath | normal |
| OVERCAST | flat light | wind (low–medium) | sparse | normal |
| RAIN | diffused light; cool desaturated | rain on fabric / metal / wood | rain droplets + lens droplets (D019 §3) | slick; wetness accumulates (D015 §10) |
| FREEZING RAIN | low warm light; ice risk | ice creak / fracture | sleet | ice hazard visible |
| SNOWFALL | soft cool light | muffled | snowfall | tracks record; snow accumulates |
| HEAVY SNOW | grey; reduced draw distance | heavy muffling | heavy snowfall | deep snow; visibility limited |
| HIGH WIND | bright / moody (state-dependent) | wind roar; structural creak | airborne debris | buffeting; ear-protection / head-down |
| WHITEOUT | near-monochrome; visibility collapse | wind roar | driving snow | navigation failure risk (D015 §25) |
| MAJOR STORM | lightning-illuminated / dark | thunder; structural creak; machinery | driving rain / snow | unsafe traversal |

### 11.2 Weather-as-punctuation (D018 §20)
- weather is never ambient-only (D015 §14)
- a major storm is a CAMPAIGN PUNCTUATION event (D018 §20 ACT placements)
- the player sees + hears + feels weather; weather affects AI / wildlife / infrastructure (D015 §14 / §15)

Frozen rule: weather NEVER carries the horror budget alone (D015 §14 / BV-SKILL-018). Weather + isolation +
darkness + cold + a perceptual event compose; weather alone is not horror.

## 12. Horror presentation (frozen)

D019 §12 freezes horror presentation. NOT jump scares every room. INSTEAD:

### 12.1 Horror language (frozen set)
- UNCERTAINTY (D015 §29 — attack certainty, not health)
- ENVIRONMENTAL EVIDENCE (a thing in the world that suggests what happened — Pillar 3 RESPONSIBILITY)
- SOUND (the soundscape carries the horror; D019 §13 sound language)
- MEMORY BLEED (D015 §31 — the player's bleed is the horror)
- HUMAN CRUELTY (the program's cruelty is the human horror; D011 §29 program casualties)
- IMPOSSIBLE MOMENTS (D015 §34 True Unknowns / Echoes; sparse, authored, budget-controlled)

Frozen reference tone: Suffering + Silent Hill + grounded military thriller (doctrine §33; D011 §19).

### 12.2 Per-state presentation (frozen)
- PARANORMAL-class events are SPARSE (D015 §33 / §34); they are AUTHORED with scarcity budget.
- EXPERIMENTAL-class is OBVIOUSLY PHYSICAL (D015 §34) but reads as program-casualty, not monster.
- HUMAN-class carries weight via Pillar 3 RESPONSIBILITY (doctrine §34; D017 §23 blood on hands reads).

Frozen rule: horror is FAIR (D015 §30 — game may make player doubt reality; never doubt the game itself).
The horror budget is ledgered; the player's body confirms state through diegetic feedback.

## 13. Sound language (frozen)

D019 §13 freezes the SOUND LANGUAGE at the production layer. Per D015 §43 + D016 §44 + D017 §42, audio is
SHARED truth with stealth / horror; no parallel "magic" channel.

### 13.1 Environment (frozen)

The soundscape is LEGIBLE — every layer identifiable:
- wind (low / medium / high / roar)
- structures moving (metal creak; timber settling; cable hum)
- distant machinery (the program infrastructure has audio signature when running)
- wildlife silence (an absent-sound is information; D015 §40 wildlife-as-environmental-information)

### 13.2 Combat (frozen)
- weapon reports (D013 §25; the rifle is the player's voice)
- breathing (the player's breath is the player's body; CONDITION / EXERTION / STRAIN read through breath)
- equipment movement (gear shift; cloth rustle; sling adjust)

### 13.3 Anomaly (frozen)
- pressure (D016 §44 audio vocabulary)
- low-frequency distortion
- tinnitus (D016 §4 / §44)
- perception changes (audio narrowing; ambient fade; brief ringing)

Frozen rule: audio contamination (D015 §44) is AUTHORED and SPARING. Ordinary audio is taught BEFORE
contamination exists. Essential gameplay cues are NEVER permanently unreliable (D015 §30 fairness law).

## 14. Animation priorities (frozen)

D019 §14 freezes production priority tiers. Tablet-feasibility + D017 §36 animation-evolution ladder +
doctrine §11 scope-honesty + BV-D052 design-language-freeze-only — animation is design language, not
production volume.

### 14.1 Tier 1 (frozen, must-have)

```
- MOVEMENT           (walk / run / crouch / prone / sprint; stance transitions; traversal)
- WEAPONS            (ready / reload / aim / fire / melee / unarmed — the rifle is the voice)
- STEALTH            (cover entry/exit; crouch-walk; line-of-sight break; takedown initiation)
- INJURY             (limp / clutched side / posture degradation; visible-state channel)
- CLIMBING           (mantle / vault / climb / ledge)
- INTERACTION        (object use / door open / pickup / switch / button)
```

### 14.2 Tier 2 (frozen, should-have)

```
- GROOMING           (D017 §19 / §20 / §21 — base grooming surfaces; mirror moments)
- EQUIPMENT ADJUSTMENTS (hair tie / hood up-down / goggles position / helmet on-off; D017 §18 quick radial)
- ENVIRONMENTAL ACTIONS (sitting / kneeling / resting / eating / drinking beats)
```

### 14.3 Tier 3 (frozen, rare cinematic states)

```
- AUTHORED CHARACTER BEATS (D017 §40 mirror moments; D017 §30 signature equipment return; D016 §11
  first undeniable event; D014 reunion / catastrophe flashes)
- RARE HORROR CINEMATIC (D015 §31 / §33 budget; not ambient)
- SECOND-IN-COMMAND ARC moments (doctrine §25 scene lock)
```

### 14.4 Animation-evolution ladder (D017 §36)

Frozen ladder:
- BROKEN (STAGE 1) — rough / inefficient / forceful
- REMEMBERING (STAGE 2) — moments of precise old technique emerge
- RECOVERING (STAGE 3) — less wasted motion
- INTEGRATED (STAGE 4) — old precision + prison adaptability

Frozen rules:
- The ladder drives animation states, not the other way around (the ladder is content-led, not
  tech-led).
- Animation volume is BOUNDED by tier priorities. Tier 1 is the budget's spine.
- Each Tier-1 / Tier-2 effect is a STAGE-SHIFT, not an ambient drift (D017 §36 frozen rule).

## 15. BLACK VECTOR signature moments (frozen)

D019 §15 freezes recurring identity moments — the moments players remember. These are the spine of the
presentation identity.

### 15.1 Signature-moment catalog (frozen set)

| Moment | Where | Reads as |
|---|---|---|
| TYING HAIR BEFORE ENTERING DANGER | ACT II / ACT III onward | the operator READIES the body; the player shapes preparation; D017 §16 hair response |
| CLEANING WEAPON AFTER SURVIVAL | base-grooming / workbench surfaces | maintenance / history (D017 §29 weapon visual history); Pillar 3 RESPONSIBILITY |
| STANDING IN FRONT OF MIRROR SEEING SCARS | D017 §19 MIRROR/BATHROOM; D017 §40 mirror moment | identity (Pillar 1 IDENTITY, doctrine §34); reclamation state visible |
| RESTORING A DEAD FACILITY | F1-F5 restoration beats (D015 §24) | the world changes; the operator's choices matter; D015 §17 consequence law visible |
| VISOR ACTIVATING IN A STORM | D019 §4.2 tactical activation | tactical identity; signature gear; cost = signature event |
| FIRST IMPOSSIBLE EVENT | D016 §11 / D018 §9 ACT II early | the moment that changes the Hand's understanding of himself; Pillar 1 IDENTITY; the player's relationship to the man's capability shifts |

### 15.2 Signature-moment principles (frozen)
- Each moment is RECOGNIZABLE in five seconds (D019 §2).
- Each moment is AUTHORED (D017 §40 / D018 §22 — major horror events, mirror moments, signature returns).
- Each moment has a CLEAR visual / audio signature (D019 §13 sound language + D019 §12 horror language +
  D019 §11 weather presentation compose).
- Signature moments are NOT skippable for performance; they are content-led and must run.
- The signature catalog is not the end of the signature list; future directives may extend it (doctrine
  §34 narrative pillars anchor any addition).# — CONTINUED: PART D — TABLET PERFORMANCE LAW, METHODOLOGY SKILL, HUD OWNERSHIP —

---

## 16. Tablet performance law (frozen)

D019 §16 freezes the performance law at the visual / HUD / presentation layer. Anchored to D004 §10
edge-device budget + D015 §28 off-screen simulation model + D017 §50 tablet-feasible persistent-state
architecture.

### 16.1 Every visual system must have (frozen)

- SCALABILITY — visual systems scale down at low-spec targets without breaking identity
- FALLBACK STATE — a lower-cost representation exists when full representation is unavailable
- LOW-COST REPRESENTATION — the system's default cost is bounded

### 16.2 Forbidden (frozen)

- expensive simulations everywhere (continuous strand hair; particle storms everywhere; complex shaders on
  every surface)
- impossible character customization combinations (D017 §50)
- cinematic-only effects that cannot run interactively (D017 §50)
- per-frame "spooky passes" or any per-frame visual pass that runs without authored trigger (D017 §50)

### 16.3 Preferred techniques (frozen)

- shader / material parameters (wetness scalar; dirt scalar; cold scalar)
- masks + decals (residue; damage; repair)
- state-driven swaps (finite hair meshes; finite beard meshes; modular clothing)
- animation layer blending (D017 §36 ladder; Tier 1 / 2 / 3 priorities)
- pooled effects (VFX budget; weather FX budget)
- authored triggers (cinematic moments; horror events; signature moments — D019 §15)
- bounded lighting (baked lightmaps + 1 directional + fog; D004 §10 / BV-D001)
- bounded draw calls (instanced vegetation; baked shadows; selective postprocessing)
- LOD (D004 §10)
- coarse off-screen simulation (D015 §28 SAFE / ACTIVE / THREATENED / DISPLACED / LOST)

### 16.4 Tablet target budgets (frozen, anchored to D004 §10)

- ~200–260 MB working set
- <1,200 active scene nodes per active sector region
- 6–10 human AI + 4–8 wildlife per hotspot
- GL Compatibility renderer baseline (BV-D001; no renderer change unless profiling proves Mobile
  advantageous)
- sector footprint ~1–2 km²; total land ~9–12 km² (D004 §10)

Frozen rule: D019 PRESERVES D004 §10 budgets. A future device-profile directive may refine them; D019
does not loosen them.

## 17. HUD ownership boundary (frozen — D019 scope)

D019 expands D015 §45 + D016 §45 ownership but does NOT fully design the HUD (D017 §48). Freeze the
ownership for D019 surfaces:

| Surface | Owner | Layer |
|---|---|---|
| WRIST DEVICE (condition / temp / inventory / comms / diagnostics) | D019 §5.1 | equipment-owned |
| HELMET PASSIVE (env readings / compass / equipment status) | D019 §4.1 | always-on, diegetic |
| HELMET TACTICAL (drone feed / system info / threat marking) | D019 §4.2 | opt-in, signature cost |
| HELMET ANOMALOUS (perceptual / sensory distortion) | D019 §4.3 | late, authored, budgeted |
| NEAR-PERMANENT STATE BANDS (CONDITION / CORE TEMP / EXERTION / CONTROL / NEURAL STRAIN) | D015 §45 / D016 §45 | wrist + helmet passive |
| CONTEXTUAL CONDITIONS (wet / soaked / bleeding / pain / chilled / hypothermic risk / exhausted / etc.) | D015 §45 | contextual icon / edge |
| DIAGNOSTIC SCREEN (body diagram / injury / clothing / weapon / path state) | D015 §45 + D017 §51 | wrist device, deliberate |
| WORLD HUD (objectives / clues / propagation effects) | D019 §5.3 | world, not UI |
| QUICK PRESENTATION RADIAL (hair / hood / face covering / goggles / helmet) | D017 §18 | held input, 6-slot max |
| BASE GROOMING INTERFACES (mirror / wash / locker / workbench / medical) | D017 §19 | in-fiction facilities |

Frozen rule: D019 does NOT introduce a new HUD layer. Every element traces to the OWNED surfaces above.

## 18. Methodology skill review (frozen — D019 §15 result)

Per the user's D019 §"methodology review" deliverable expectation. Inspect the 31-BV-skill fleet:

| Skill | What it owns |
|---|---|
| BV-SKILL-014 mobile-graphics-atmosphere | weather SHARED state / lighting / LOD / atmosphere / VFX budget |
| BV-SKILL-022 visual-equipment-doctrine | equipment visual language (armor / weapons / gear silhouette; wear/damage spectrum) |
| BV-SKILL-031 persistent-character-state-architecture | persistent-state channels / animation-evolution / body-presence methodology |
| BV-SKILL-015 gameplay-debugging-instrumentation | observability contract |
| BV-SKILL-029 simse-island-systems | world-systems substrate |
| BV-SKILL-028 prologue-narrative-architecture | opening gates / visual reference |
| BV-SKILL-030 anomalous-capability-architecture | anomaly methodology |

D019's domain is **visual production / HUD / presentation** at the PLAYER-EXPERIENCING level — the layer
between all existing systems and the player's eyes.

What is NOT yet owned by a current skill:
- the CAMERA SYSTEM (D019 §3 — third-person shoulder behavior; FP body-presence; aiming transition; stealth
  camera; weather / injury camera effects)
- the HELMET / VISOR three-layer system (D019 §4 — passive / tactical / anomalous + helmet hardware identity)
- the HUD-OWNERSHIP-AS-EQUIPMENT philosophy and its surfaces (D019 §5 — wrist / helmet / world ownership
  mapping; the player's UI is the character's gear)
- SIGNATURE MOMENTS catalog + production principles (D019 §15 — the moments players remember; tied to
  identity)
- ANIMATION PRIORITY tiers (D019 §14 — production ordering of state channels + signature moments)
- TABLET PERFORMANCE LAW for visual / HUD / presentation (D019 §16 — extends D017 §50 + D004 §10 to the
  visual production layer)

Frozen determination (D019 §18):

A new skill is JUSTIFIED — **BV-SKILL-032 visual-presentation-architecture** — as **METHODOLOGY ONLY** (the
mirroring of BV-SKILL-030 / BV-SKILL-031 discipline). It owns the REUSABLE design procedure for:

- camera system (3P shoulder + FP body-presence + transitions + camera weather/injury effects)
- helmet / visor system (three-layer + hardware identity)
- HUD-as-equipment ownership philosophy + per-surface ownership table
- signature-moment methodology + catalog-extension discipline
- animation-priority tiering for production ordering
- tablet-performance law for visual production

It does NOT contain statements like "the helmet shows X in Season 1" or "the camera zooms Y at ACT III."
Those live in this bible (D019) and in doctrine (BV-D114+ rows). No duplicated lore.

The fleet stays strong (few strong skills). New skill composition: composes with 022 (equipment visual),
031 (persistent-state), 014 (graphics/atmosphere), 028 (prologue visual reference), 015 (observability),
029 (world-systems). Merges none.

---

## Appendix A — Contradiction ledger (D019)

| # | Existing canon | D019 position | Result |
|---|---|---|---|
| 1 | Doctrine §10 GL Compatibility + Android-tablet first (BV-D001) | §16 preserved; renderer baseline unchanged | No contradiction |
| 2 | Doctrine §29 opening structure (prologue peak, no supernatural) | §7 STAGE 0 = prologue visual reference | No contradiction |
| 3 | Doctrine §34 narrative pillars (IDENTITY/BROTHERHOOD/RESPONSIBILITY) | §15 signature moments anchor pillars (mirror moment = IDENTITY; reunion = BROTHERHOOD; blood on hands = RESPONSIBILITY) | No contradiction |
| 4 | Doctrine §36.1 Control NOT a happy-gauge | §6.2 Control reads through body, not numbers | No contradiction |
| 5 | Doctrine §36.4 diegetic-first feedback | §6 frozen example set; thin HUD band only | No contradiction |
| 6 | Doctrine §41 / §41.11 / §41.12 visual/equipment | §8 equipment language frozen with BV-SKILL-022 ownership preserved | No contradiction |
| 7 | BV-D042..D052 visual/equipment doctrine | §8 / §16 composed; BV-SKILL-022 owns | No contradiction |
| 8 | D004 §5 anti-videogame-architecture rule | §2 core principle "technology should look USED" | No contradiction |
| 9 | D004 §10 edge-device budget | §16 preserved; budgets not loosened | No contradiction |
| 10 | D011 §6/§10/§14/§22/§23 population visual roles | §10 facility identities aligned; human-first ability rule preserved | No contradiction |
| 11 | D011 §34-§35 True Unknowns / Echoes | §12 horror language aligns; budget respected | No contradiction |
| 12 | D012 provenance / program generations G0..G8 | §10 F5 Annex visual identity anchored to provenance | No contradiction |
| 13 | D013 weapons + Layered Overwatch + BV-D070 | §7 STAGE 4 + §10.3 F3 relay aligned; R-6 precision family preserved | No contradiction |
| 14 | D014 prologue + knowledge gates | §7 STAGE 0 reference; gates preserved | No contradiction |
| 15 | D015 §9 cold diegetic feedback | §6.2 example set aligns | No contradiction |
| 16 | D015 §14 weather state machine | §11 weather presentation per-state table; single-source preserved | No contradiction |
| 17 | D015 §22 community state + liability law | §10.1 F1 community identity; no new system | No contradiction |
| 18 | D015 §24 F1..F5 systemic profiles | §10 per-facility identity aligned; roster unchanged | No contradiction |
| 19 | D015 §30 fairness law (game may make player doubt reality; never doubt the game) | §12.2 horror fair; overlay truthful (D015 §30) | No contradiction |
| 20 | D015 §33 horror frequency budget | §12.2 scarcity preserved | No contradiction |
| 21 | D015 §43 sound as survival information | §13 sound language aligned; audio as shared truth | No contradiction |
| 22 | D015 §44 audio contamination | §13.3 anomaly audio vocabulary + contamination discipline preserved | No contradiction |
| 23 | D015 §45 HUD ownership boundary | §17 ownership table preserved; D019 surfaces owned | No contradiction |
| 24 | D015 §47 Saga-1 containment | §2 / §10 identity contracts aligned; no future-saga contamination | No contradiction |
| 25 | D016 §41-§45 presentation language | §6 / §11 / §12 / §13 compose with D016 | No contradiction |
| 26 | D016 §48 Superhero-prevention matrix | §2 forbidden list aligned | No contradiction |
| 27 | D016 §49 Season-1 mastery ceiling | §7 STAGE 4 retains fundamental requirements | No contradiction |
| 28 | D017 §3 5-stage arc | §7 visual-evolution stages aligned | No contradiction |
| 29 | D017 §10-§11 persistent state channels + persistence law | §8 layered material + weather effects aligned | No contradiction |
| 30 | D017 §14-§17 hair system + functional consequences + response | §9.1 hair states + presentation aligned | No contradiction |
| 31 | D017 §18 quick presentation radial MAX 6 SLOTS | §17 ownership table preserves; 6-slot law unchanged | No contradiction |
| 32 | D017 §19 base grooming facilities | §9.5 mirror interactions + §17 ownership aligned | No contradiction |
| 33 | D017 §22 cleanliness (no hygiene meter) | §9.3 satisfied (washing satisfying, not busywork) | No contradiction |
| 34 | D017 §26 clothing layer system | §8.2 layering aligned | No contradiction |
| 35 | D017 §28 armor progression | §8.5 phases aligned | No contradiction |
| 36 | D017 §29 weapon visual history | §8.1 / §8.3 materials + repair aligned | No contradiction |
| 37 | D017 §35-§38 animation-evolution ladder + body-presence + 3P readability | §3.2 FP body-presence + §14 animation tiers + §16.3 ladder preserved | No contradiction |
| 38 | D017 §40 mirror moments | §9.5 mirror interactions aligned (sparing character beats) | No contradiction |
| 39 | D017 §41 player-authored visual identity | §7 STAGE 4 + §8.6 customization boundaries aligned | No contradiction |
| 40 | D017 §42 no cosmetic cash-shop logic | §2 / §8.6 forbidden list aligned | No contradiction |
| 41 | D017 §50 tablet-feasible persistent-state architecture | §16.3 / §16.4 preferred techniques + budgets aligned | No contradiction |
| 42 | D017 §51 save-data shape | §17 ownership table preserves; observability contracts satisfied | No contradiction |
| 43 | D017 §53 accessibility overrides | §3.1 weather camera shake override aligned; §6.2 example set does not rely solely on visual | No contradiction |
| 44 | D017 §54 character identity protection | §8.6 customization boundaries aligned | No contradiction |
| 45 | D018 §10 facility sequencing | §10 per-facility identity aligned with F1-F5 roles | No contradiction |
| 46 | D018 §20 weather pacing | §11 per-state presentation aligns with weather-as-punctuation | No contradiction |
| 47 | D018 §34 REAL→IMPOSSIBLE escalation | §10 F1-F5 identities express escalation; F5 deepest | No contradiction |
| 48 | D018 §35 ACT IV climax | §15.1 signature moment "first impossible event" placed ACT II early per D018 §9 | No contradiction |
| 49 | D018 §39 vertical slice recommendation | §3 / §6 / §11 / §13 visual systems compose with the recommended slice | No contradiction |
| 50 | SOP-005 gameplay verification + SOP-006 observability | §17 observability surfaces preserved; §16.1 scalability law enables verification | No contradiction |

Result: **0 contradictions found.** No silent repair required. D019 freezes the visual production / HUD /
presentation layer without modifying any prior canon.

## Appendix B — Deferred decisions (D019)

1. Per-facility specific visual content (interior layouts, equipment placement, exact repair details) —
   CANDIDATE pending scene-authoring directive.
2. The signature-moment catalog extension (future additions anchored to doctrine §34 pillars) — CANDIDATE.
3. The exact animation volume per Tier 1/2/3 priority — content-authoring; budget bounded by D004 §10 + D017 §50.
4. The specific visor HUD visual layout per D019 §4 — content-authoring; ownership frozen.
5. The specific wrist-device HUD visual layout per D019 §5.1 — content-authoring; ownership frozen.
6. The exact FP body-presence cue set per state (D017 §37) — content-authoring; bounded by D017 §50.
7. Future device-profile refinement of budgets (D019 §16.4 — anchored to D004 §10; future directive may refine).
8. The mirror-moment content / scene authoring (D017 §40) — CANDIDATE.
9. The first undeniable event scene content (D016 §11 + D018 §9) — CANDIDATE.

## Appendix C — Stop-condition trace (D019)

This bible STOPS if any stop condition fires:
- visual language becomes superhero / glowing / sci-fi clean / generic apocalypse — §2 forbidden list
  prevents.
- camera loses body-presence (FP becomes invisible floating lens) — §3.2 FP preservation prevents.
- helmet/visor becomes wallhack — §4.2-§4.3 frozen rules + D011 §7 / D016 §20 prevent.
- HUD becomes MMO meters / floating numbers — §6 forbidden list prevents.
- character visual evolution drifts to rarity-color loot / cash-shop logic — §8.6 + D017 §42 prevent.
- grooming becomes chore spam — D017 §13 anti-tedium law preserved; §9.3 satisfied.
- environment visual bible drifts to sci-fi cleanliness / generic apocalypse aesthetics — §2 frozen principle
  + §10 per-facility identity contracts prevent.
- weather becomes horror-only / ambient-only — §11.2 + D015 §14 prevents.
- horror becomes jump-scare-only — §12.1 frozen language prevents.
- sound language drifts to fantasy spell sounds — D016 §44 + §13 prevents.
- animation volume exceeds tier priorities or tablet budget — §14 + §16 prevents.
- signature moments become skippable for performance — §15.2 frozen rule prevents.
- tablet performance law ignored — §16 prevents.
- any prior canon row (BV-D001 / D004..D018) is contradicted — 50-ledger check: 0 contradictions.
- validators fail — validation below.

None triggered. **Validation below. STOP. NO COMMIT. RETURN REPORT.**

---

## Appendix D — Recommended D020 (not executed)

Per the user's directive (D019 final note):

**D020 — VERTICAL SLICE IMPLEMENTATION SPECIFICATION.**

The canon stack at end of D019:

```
world        ✔ (D004 + D015)
systems      ✔ (D008/D009 combat; D015 survival/horror; D016 anomaly)
character    ✔ (D017 reclamation + persistent-state)
campaign     ✔ (D018 spine + pacing)
visual       ✔ (D019 production + HUD + presentation)
```

The next directive is D020 — Vertical Slice Implementation Specification (per D018 §39 recommendation:
S-1 Strand → F1 Gyle Cannery approach with one restoration beat). At that point we stop designing broadly
and prove the game works.

**Not executed. STOP. NO COMMIT.**