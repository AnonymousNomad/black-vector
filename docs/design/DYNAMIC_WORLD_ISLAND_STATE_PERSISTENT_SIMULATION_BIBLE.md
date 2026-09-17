# BLACK VECTOR — DYNAMIC WORLD, ISLAND STATE & PERSISTENT SIMULATION BIBLE

> Directive-024 deliverable (COMPLETE — resumed from paused chunk A per user order; canon D001-D026 frozen). Not implementation, not code, not Godot/
> engine work, not asset creation, not production file modification. Primary model: Big Pickle (per user
> routing; the directive's "MiniMax M3" attribution is again disregarded this session).
> Authority: THE DEVELOPER'S WAY -> doctrine -> SOP -> skills -> D004 world foundation -> D008/D009 + D010
> visual -> D011 ecology -> D012 provenance -> D013 weapons -> D014 prologue -> D015 substrate (BV-D079..D086)
> -> D016 anomaly -> D017 persistent state + reclamation -> D018 campaign spine -> D019 visual production ->
> D020 vertical-slice specification -> D021 combat architecture -> D022 AI / faction / enemy architecture
> (BV-D125) -> D023 companion / relationship / Shade reclamation (BV-D126 + BV-D127) -> D024 PAUSED -> D025 operator identity (BV-D130) -> D026 input/touch (BV-D131) -> this document (D024 COMPLETE).
> Purpose: freeze the dynamic-world architecture for Season 1 so the island feels alive without becoming a
> simulation monster. SYSTEM LAW vs CANDIDATE CONTENT strictly separated (D024 §22).
> GAME IMPLEMENTATION STARTED: NO.

---

## 1. Preserved canon — DO NOT REOPEN OR REWRITE (frozen)

The user's D024 directive issues an explicit list of canon that must be PRESERVED. D024 composes around
this canon; it does not rewrite it.

- **The Hand is already locked as overwatch / reconnaissance / scout-sniper lineage.** (doctrine §15 /
  D012 / D013 / D016 §27 / D021 §27 / BV-D070 psionic weapon boundary). D024 does NOT alter this.
- **The Hand's body / read must remain prison-built: stocky, hard, lean-strong, NOT bodybuilder-swollen.**
  (D017 §3 STAGE 1 BROKEN SURVIVOR; D017 §36 animation-evolution ladder; D019 §7 character visual
  evolution). D024 does NOT alter the Hand's body language.
- **Tattoos remain preserved as prior canon.** (doctrine §14; D017 §54 character identity protection).
  D024 does NOT alter tattoos.
- **The visual / lore opening sequence remains: last Hidden Hand mission → collapse at home → prison/
  death row → covert diversion to island → experimentation → awakening into chaos.** (D014 §1 / §29; doctrine
  §29). D024 does NOT alter the opening sequence.
- **Telekinetic sensitivity emerges after island experimentation + loss of Compound, NOT before.**
  (D012 §10-§11 / §12; D016 §7 Phase 0 AMBIGUOUS + Phase 1 DENIAL + first undeniable event ACT II
  early per D018 §9 / D016 §11). D024 does NOT alter anomalous progression timing.
- **No loading-screen / lobby fiction. The island is the game.** (doctrine §5 / §31). D024 honors the
  continuous-world principle; transitions are CONCEALED by geography / weather / interiors / distance
  (BV-SKILL-013).
- **Humans remain the dominant threat. Horror / anomaly remains restrained and costly.** (doctrine §23 /
  D011 §22; D015 §33/§34; D016 §48 prevention matrix; D018 §37). D024 does NOT alter threat dominance.

## 2. Binding context & canon consumed

- Inspected: doctrine §5 (Environment), §6 (Stealth), §10 (Platform/Renderer — GL Compatibility /
  Android-tablet first), §23 (Horror Model — three threat classes), §24 (Biblical Horror), §26 (Ally Gameplay
  Role), §27 (Other Hidden Hand Members), §29 (Opening Structure), §30 (Wilderness / Survival), §31
  (Restorable Facilities), §34 (Narrative Pillars).
- D004 §3 seven-sector world plan; §4 five-facility roster; §5 architecture reference + anti-videogame-
  architecture rule; §10 edge-device budget.
- D008/D009 CQC doctrine (BV-SKILL-021).
- D010 visual/equipment doctrine (BV-SKILL-022).
- D011 §3 progression tier; §4 military roles; §5 Black Hand security; §6 Shades; §7 truthful sensing;
  §8 commander externalization; §15-§17 civilians / community / contractors; §18 wildlife; §22 human-
  first ability rule; §23 regional distribution; §24 relationship model; §26 weapon ecology; §27 D007
  perception compatibility; §28 D008/D009 combat compatibility; §29 Pillar 3 RESPONSIBILITY; §30 content /
  horror budget; §31 boss doctrine.
- D012 provenance (program generations; D012 §22 keeper).
- D013 weapon bible.
- D014 prologue.
- D015 substrate (BV-D079..D086; §6 survival / §9 cold / §10 wetness / §12 shelter / §13 injury /
  §14 weather state machine / §15 wildlife-as-environmental-information / §16-§21 infrastructure +
  propagation + consequence law / §22 community state + liability law / §24 F1-F5 systemic profiles / §28
  off-screen coarse model / §31 Memory Bleed taxonomy / §33 horror rarity / §34 True Unknowns / §40 wildlife /
  §45 HUD ownership).
- D016 anomaly (BV-D087..D095; §7 5-phase discovery; §30 Compound / §31 Independent; §48 prevention matrix).
- D017 persistent state + reclamation (BV-D096..D104; §3 5-stage arc; §11 LIVING SAVE FILE; §22 cleanliness
  social reactions; §36 animation-evolution ladder; §39 base-as-identity anchor).
- D018 campaign spine (BV-D105..D113; §5 ACT I-IV; §6 F1; §10 facility sequencing; §11 / §37 threat
  escalation; §15 second-in-command arc; §20 weather pacing; §27 former Hidden Hand; §36 end-of-Season
  woman; §38/§39 vertical-slice; §55 mission taxonomy).
- D019 visual production (BV-D114..D122).
- D020 vertical-slice specification (BV-D123).
- D021 combat architecture (BV-D124).
- D022 AI / faction / enemy architecture (BV-D125; 7-faction taxonomy; AI perception state machine;
  squad behavior; archetypes; Shade distinction — D022 §7.4-§7.5 narrow framing SUPERSEDED by D023
  §2 canon correction).
- D023 companion / relationship / Shade reclamation (BV-D126 + BV-D127; Companion Shade architecture;
  community relationship system; Second-in-Command bond; Hand's guilt; moral consequences; memory bleed
  integration; base relationships; Companion personality evolution).
- Skills reviewed: BV-SKILL-006 environmental-affordances; BV-SKILL-008 tactical-ai-perception; BV-SKILL-012
  diegetic-memory-progression; BV-SKILL-013 large-world-sector-architecture (one-world; activation not
  streaming); BV-SKILL-014 mobile-graphics-atmosphere (weather SHARED state; lighting / LOD); BV-SKILL-015
  gameplay-debugging-instrumentation; BV-SKILL-017 survival-wilderness-systems; BV-SKILL-019 psionic cost
  pipeline; BV-SKILL-020 facility-ally-support; BV-SKILL-021 cqc-combat-architecture; BV-SKILL-027 island-
  population-threat-ecology; BV-SKILL-029 simse-island-systems (world-systems substrate — D015 §16-§21
  propagation + D015 §28 off-screen coarse model + D015 §22 community state); BV-SKILL-031 persistent-
  character-state-architecture; BV-SKILL-032 visual-presentation-architecture; BV-SKILL-033 enemy-architecture;
  BV-SKILL-034 companion-relationship-architecture; BV-SKILL-035 operator-discipline-architecture (D025 — the
  island is read, not fed; observation advantage composes D024); BV-SKILL-036 touchscreen-input-architecture
  (D026 — world layering composes D026 §19 world-information surfaces; island-as-game-space has no lobby UI).

## 3. Dynamic-world philosophy (frozen)

> **The island must feel alive because things change, consequences persist, different locations feel
> different at different times, and player choices reshape risk / opportunity. But it must not become a
> grand-strategy sim, a colony-management sim, a full economy sim, or an infinite respawn arcade.**

The sweet spot (frozen): AUTHORED SURVIVAL-HORROR PACING × PERSISTENT SYSTEMIC WORLD REACTION.

D024 freezes the sweet spot. Every dynamic-world system in this bible answers:
- Is this AUTHORED (scripted / event-driven)?
- Is this SYSTEMIC (state-driven + rule-driven)?
- Is this BOTH (scripted with systemic consequences)?

D024 prefers AUTHORED + SYSTEMIC combinations (the player sees a system change that was authored to
matter at this moment in the campaign).

D024 explicitly forbids:
- grand-strategy sim (no faction-wide economics; no resource harvesting loops)
- colony-management sim (no building systems; no citizen management)
- full economy sim (no supply chains; no production graphs)
- infinite respawn arcade (no respawning patrols; no loot grind)

---

## 4. World-state architecture — authoritative model (frozen)

D024 §4 freezes the dynamic-world state model. What the system TRACKS, and what it DOES NOT track.

### 4.1 Tracked state (frozen)

The dynamic-world system tracks these channels:

| Channel | Source | Resolution | Persistence |
|---|---|---|---|
| TIME_OF_DAY | game clock | day/dawn/dusk/night | save-persistent |
| WEATHER | D015 §14 state machine | 9 states | save-persistent |
| STORM_EVENT | D015 §15 storm-event law | authored (MAJOR STORM punctuation events) | save-persistent |
| FACILITY_STATE | D015 §16-§21 propagation | F1..F5 per-facility state (operational/degraded/offline) | save-persistent |
| FACTION_PRESENCE | D022 §2-§6 faction taxonomy | per-faction per-region presence (PRESENT / ABSENT / DEPLETED / REPLACED) | save-persistent |
| PATROL_STATE | D024 §11 patrol model | per-region patrol occupation (FULL / DEPLETED / ABSENT / REPLACED-WEAK / REPLACED-ESCALATED) | save-persistent |
| COMMUNITY_STATE | D015 §22 community state channels | per-cluster population/safety/warmth-power/medicine/trust/access/threat-pressure | save-persistent |
| TRAVEL_RISK | derived | per-route risk band (LOW / MODERATE / HIGH / EXTREME) | save-persistent |
| WILDLIFE_SIGNAL | D015 §40 + D024 §12 | per-region wildlife behavior (CALM / SILENT / DISTURBED / AVOIDING / AGITATED) | save-persistent (with decay per D024 §12.5) |
| RESOURCE_PRESSURE | per-region | LOW / MODERATE / HIGH / DEPLETED | save-persistent |
| LOCAL_AFTERMATH | D024 §11 | per-region aftermath state (CLEAN / RECENT-CONFLICT / HOT / COLD) | save-persistent (with decay) |

### 4.2 NOT tracked (frozen)

The dynamic-world system does NOT track:
- per-NPC schedules (NPCs are positioned by AUTHORED placement)
- per-NPC hunger / thirst (NPCs are populated by AUTHORED state)
- per-animal hunger / thirst (animals are populated by AUTHORED behavior)
- per-resource depletion per pickup (resources are AUTHORED restocks per D015 §16-§21)
- per-building interior weather (interiors are AUTHORED micro-climates)
- per-player reputation per faction (D024 §14 player-path world-response is bounded; no global reputation
  bars)

### 4.3 Tablet-feasibility law (frozen)

Per D004 §10 budgets:
- 9-state weather machine: single-sourced WORD refresh (D015 §14); no per-object weather sim
- faction presence: 6-10 human AI per hotspot (D011 §22); off-screen coarse state (D015 §28 SAFE / ACTIVE /
  THREATENED / DISPLACED / LOST)
- patrol state: bounded by faction presence; off-screen coarse state for non-player-relevant patrols
- community state: per-cluster snapshot; not per-NPC
- wildlife signal: per-region snapshot; not per-animal
- save state: the channels in §4.1 + persistent-state channels (D017 §10 / §51)

Frozen rule: the dynamic-world system is a STATE TRACKER + AUTHORED CONSEQUENCE INJECTOR, not a
continuous simulation.

---

## 5. Time architecture (frozen)

D024 §5 freezes time. Time is NOT continuous. Time is AUTHORED + EVENT-DRIVEN + STATE-RECORDED.

### 5.1 Time scale (frozen)

Season 1 time scale (frozen): the in-fiction day is the player's PRIMARY TIME UNIT. The player's
actions advance time in AUTHORED CHUNKS (a patrol engagement = ~30 min to a few hours; a travel leg = a
few hours; a rest in a HEATED STRUCTURE = several hours; a major-storm cover = up to a day).

### 5.2 Time-of-day windows (frozen)

```
DAWN        — pre-sunrise to sunrise; low light; wildlife active; AI transitioning from night to day
DAY         — sunrise to pre-dusk; full visibility; AI most active; patrol occupation standard
DUSK        — pre-dusk to dusk; transitional; wildlife shift; AI transitioning from day to night
NIGHT       — dusk to pre-dawn; low visibility; patrol occupation REDUCED; wildlife silence
```

### 5.3 What changes with time (frozen)

- PATROL occupation (D024 §11): night = REDUCED patrol occupation (Tier 2 trained humans are not
  night-optimized); dawn / dusk = transitional; day = standard.
- WILDLIFE behavior (D024 §12): dawn = active; day = standard; dusk = shift; night = some species
  active (owls / foxes / marine mammals), some silent (D015 §40 wildlife-as-environmental-information).
- VISIBILITY: night reduces visibility; AI perception reads signature channel (D011 §7 truthful
  sensing); the player's signature channel may also reduce.
- COMMUNITY behavior: community night-watch patterns (D024 §9).
- FACILITY systems: power/heat are continuous; some systems are off-hours (F2 Tanellus medical staff
  shifts; F3 Frostvane night-shift monitoring).
- ANOMALOUS: the world's anomaly behavior is not time-gated (D015 §34 True Unknowns are not time-of-
  day restricted).

### 5.4 What does NOT change with time (frozen)

- The Hand's reclamation stage (D017 §3 — progresses by player choices, not by time).
- The Hand's anomalous capability (D016 — progresses by player choices, not by time).
- The world's program ruins (D004 — present at start; preserved).
- The island's wildlife species roster (D004 §7 — preserved).
- The faction composition (D022 — preserved; faction presence changes by time-of-day but not by day-
  to-day progression unless AUTHORED).

### 5.5 Nighttime benefits (frozen)

- STEALTH: AI perception reduces at night (BV-SKILL-008 / D011 §7 — visual reduces; audio may increase
  in some conditions). The player who uses darkness gains a stealth advantage.
- WILDLIFE signals: night wildlife is active differently than day wildlife (D024 §12).
- PATROL gaps: night patrols are REDUCED (D024 §11); the player who times a night approach gains a
  patrol-gap advantage.

### 5.6 Nighttime costs (frozen)

- VISIBILITY: the player's own visibility reduces; navigation is harder (D015 §25).
- WILDLIFE hazards: some night wildlife is dangerous (D004 §7 — brown bear / moose).
- COLD exposure: night is colder than day (D015 §14 — temperature pressure increases; CORE
  TEMPERATURE drain may accelerate; D015 §9 cold bands).
- INJURY consequence: a wounded Hand at night has less visibility to find aid.

### 5.7 Sleep / rest (frozen)

- REST in a HEATED STRUCTURE (D015 §12) advances time by several hours; CONDITION / CORE TEMPERATURE /
  EXERTION bands recover per D015 §6 / §9.
- REST in a WINDBREAK / CRUDE SHELTER (D015 §12) advances time but with reduced recovery.
- EXPOSURE to MAJOR STORM (D015 §15) advances time; CONDITION + CORE TEMPERATURE drain; wildlife signals
  change.
- RESTING is not a UI button. RESTING is a player choice to advance time at the cost of what the
  world does while the player rests (D024 §5.8).

### 5.8 Off-screen simulation (frozen — D015 §28 / D011 §22)

- The island does NOT run continuously when the player is elsewhere (D004 §10 / D015 §28).
- The island RUNS at coarse states: per-region SAFE / ACTIVE / THREATENED / DISPLACED / LOST (D015 §28).
- The island RUNS at AUTHORED events: a major storm punctuates regardless of player presence (the
  player experiences the aftermath); a faction patrol depletion is observed by the player when they
  arrive (the depletion happened "off-screen" with a reason logged).
- The island does NOT simulate per-NPC decisions when the player is elsewhere.
- The island DOES record STATE CHANGES when the player is elsewhere (a faction's loss is recorded; the
  player sees the consequence).
- The island does NOT "run ahead" of the player — the island's state changes when the player arrives,
  not before. The exception is AUTHORED events that happened regardless of the player (the storm
  arrived; the patrol was depleted by another force).

### 5.9 Real-time vs event-driven vs abstracted (frozen)

- REAL-TIME: camera, input, weather SHARED WORD refresh (D015 §14), signature channel emission (BV-
  SKILL-007), animation state (D019 §14).
- EVENT-DRIVEN: patrol engagements, restoration beats (D020 §4.7), memory bleeds (D015 §31),
  community reactions (D024 §9), faction responses (D024 §8), wildlife signal changes (D024 §12),
  local aftermath events (D024 §11).
- ABSTRACTED: per-NPC schedules, per-animal hunger, per-resource depletion per pickup, per-building
  interior weather.

---

## 6. Weather as dynamic-world driver (frozen)

D024 §6 freezes weather-as-driver. Weather is the D015 §14 state machine + D018 §20 weather-as-
punctuation + D024's depth.

### 6.1 Weather as systemic punctuation (frozen — D018 §20)

- Weather punctuates the campaign. Major storms punctuate ACT I-IV.
- Weather's effect on the world is AUTHORED + SYSTEMIC (the storm is authored to land here; the
  system's reaction is rule-driven).
- Weather changes which routes are open / closed; which facilities are reachable; which patrols are
  active; which wildlife is silent.

### 6.2 Local visibility shifts (frozen)

- The 9 weather states (D015 §14) have per-state visibility (D019 §11).
- A WHITEOUT (D015 §14) reduces landmark visibility to near-zero (D015 §25 navigation failure risk).
- A MAJOR STORM (D015 §14) reduces visibility AND sound accuracy (the player cannot rely on audio).
- A CLEAR/COLD (D015 §14) gives full visibility; long shadows.

### 6.3 Sound masking (frozen)

- RAIN masks movement sound (the player who moves in rain is harder to detect by audio).
- SNOW is medium-masking.
- WIND (HIGH WIND / MAJOR STORM) is heavy-masking.
- The player who uses weather-masking gains a stealth advantage (D011 §7 truthful sensing).

### 6.4 Cold-pressure escalation (frozen)

- Cold bands (D015 §9) escalate during MAJOR STORM.
- Cold exposure in MAJOR STORM may push the player from CHILLED to HYPOTHERMIC RISK (D015 §9).
- The player who shelters (D015 §12) before the storm reduces the risk.

### 6.5 Route closure / opening (frozen)

- Routes that cross exposed terrain may be UNUSABLE during MAJOR STORM (D015 §12 EXPOSED).
- Routes through underground passages (F4 Vivara) may be USABLE during MAJOR STORM (D015 §12 INTACT
  UNHEATED STRUCTURE).
- Routes that require weather instrumentation (F3 Frostvane) gain FORECAST VALUE before the storm
  (D015 §14 forecast) — the player who restored F3 can plan.

### 6.6 Drone usefulness degradation (frozen — D013 Layered Overwatch)

- DRONE feed is degraded in wind / whiteout / storm (D015 §14 effect on drone; D019 §11).
- The player's D013 Layered Overwatch capability is REDUCED in bad weather.
- The player's tactical reliance on drone must account for weather.

### 6.7 Patrol pattern changes during storms (frozen)

- Patrols may retreat to prepared positions (D022 §3.3 retreat; D021 §5 retreat behavior) during
  MAJOR STORM.
- Patrol occupation may be REDUCED during MAJOR STORM (the storm is a hazard for AI too).
- The player who times the storm gains a patrol-gap advantage.

### 6.8 Wildlife behavior changes before / during / after bad weather (frozen — D015 §40 / D024 §12)

- BEFORE bad weather: wildlife is RESTLESS (animals sense the storm coming; the player can read this
  as a forecast signal).
- DURING bad weather: wildlife is SILENT (the player sees silence as warning — D024 §12).
- AFTER bad weather: wildlife is QUIET or SCAVENGING (animals emerge to feed on what the storm killed).

### 6.9 Shelter pressure (frozen)

- MAJOR STORM creates shelter pressure (the player needs WINDBREAK or CRUDE SHELTER or HEATED
  STRUCTURE).
- The player who has not restored F1 (D015 §24) does not have HEATED STRUCTURE access (D024 §9 — F1 is
  the first stable anchor).
- Shelter pressure creates AUTHORED survival moments (D020 §4.2 first survival problem).

### 6.10 Facility dependence on power / heat during storms (frozen)

- F1 Cannery without restored power / heat: the player cannot use HEATED STRUCTURE (D015 §12).
- F2 Tanellus medical equipment without power: equipment degrades (D015 §24).
- F3 Frostvane without restored relay: the storm forecast is NOT available; the player cannot plan.
- F4 Vivara underground: not weather-affected (D015 §24); the player who uses Vivara during the storm
  avoids surface exposure.
- F5 Black Hand Annex: not weather-affected; the player who uses the Annex during the storm uses a
  PROGRAM LAYER.

### 6.11 Forecast / sudden change / severe events / facility instrumentation (frozen)

- FORECAST: weather is forecasted through restored F3 Frostvane instrumentation (D015 §24) and local
  community knowledge (D024 §9).
- SUDDEN CHANGE: rare; AUTHORED (the storm arrives regardless of forecast; the player who relied on
  forecast gets a consequence).
- SEVERE EVENTS: MAJOR STORM punctuation events (D018 §20 / D015 §15); AUTHORED placement.
- FACILITY INSTRUMENTATION: weather instrumentation at F3 unlocks forecast (D015 §24); weather
  instrumentation elsewhere (F4 Vivara / F5 Annex) provides different readouts.

---

## 7. Region-state and travel-state (frozen)

D024 §7 freezes the region-state model. Each region has a bounded dynamic-state profile.

### 7.1 Region categories (frozen)

Seven canonical region categories (one per sector / facility layer):

| Region | Sector / Facility | Dynamic-state emphasis |
|---|---|---|
| COASTAL ZONE | S-1 Strand + S-3 Forelands coast + F1 Cannery | weather exposure; wildlife signal; survivor cluster; coastal patrol |
| FOREST / LOWLAND | S-3 Forelands interior + S-6 Research Coast | wildlife signal; wildlife hazards; program remnant; community; weather-masking |
| PASS / RIDGE | S-4 High Pass / F3 Frostvane | weather exposure (most extreme); wildlife hazards; visibility collapse; weather instrumentation |
| UNDERGROUND / MINE / ENCLOSED | S-5 Gulch / F4 Vivara + F5 Annex + sealed program levels | bounded weather; program remnant; experimental residue; program threat; not wildlife |
| OPEN SNOW / EXPOSED | S-1 Strand flats / S-5 Gulch open ground + S-4 High Pass approach | weather exposure (extreme); wildlife hazards; visibility collapse; route closure |
| NEAR-BASE SAFE ROUTES | near F1 Gyle Cannery + near restored facilities | weather-masking; wildlife signal; community protection; reduced patrol |
| DEEP-PROGRAM TERRITORY | F5 Black Hand Annex + sealed program facilities | not weather-affected; program remnant; experimental; program threat; bounded wildlife |

### 7.2 What can become safer (frozen)

- COASTAL ZONE: the player who restores F1 + works with survivors reduces local threat.
- FOREST / LOWLAND: the player who works with wildlife (reads signals) reduces wildlife hazards.
- PASS / RIDGE: the player who restores F3 Frostvane gains forecast; patrol gaps during storms are
  larger.
- NEAR-BASE SAFE ROUTES: the player who restores F1 + works with community expands the safe zone.

### 7.3 What can become more dangerous (frozen)

- COASTAL ZONE: a storm opens a route (the player who timed it gains access; the factions who lost
  patrol gain vulnerability).
- FOREST / LOWLAND: a faction sweep increases threat.
- PASS / RIDGE: a MAJOR STORM reduces visibility + increases cold exposure.
- UNDERGROUND / MINE / ENCLOSED: deeper program remnant access increases experimental threat.
- OPEN SNOW / EXPOSED: a MAJOR STORM is dangerous.
- DEEP-PROGRAM TERRITORY: deeper access increases program threat.

### 7.4 What can be temporarily blocked (frozen)

- COASTAL ZONE: a MAJOR STORM may close the coast.
- FOREST / LOWLAND: a sweep may block a route.
- PASS / RIDGE: a MAJOR STORM may close the pass.
- OPEN SNOW / EXPOSED: a MAJOR STORM is unsafe.

### 7.5 What recovers (frozen)

- COASTAL ZONE: storm ends; coast opens.
- FOREST / LOWLAND: sweep passes; wildlife recovers.
- PASS / RIDGE: storm ends; pass opens.
- WILDLIFE signals: wildlife recovers after disturbance (D024 §12.5).

### 7.6 What never fully recovers (frozen)

- DEEP-PROGRAM TERRITORY: the program remnant is permanent (the player cannot restore the
  world to pre-catastrophe; D014 §25 catastrophe is irreversible).
- PROGRAM CASUALTIES: once a program casualty is encountered, they remain in the world (D011 §12).
- AUTHORED scars: the player's permanent scars (D017 §46) never fully recover.

### 7.7 Travel risk (frozen)

- TRAVEL_RISK is per-route LOW / MODERATE / HIGH / EXTREME.
- TRAVEL_RISK is derived from: weather, time-of-day, faction presence, patrol state, wildlife hazards,
  program threat.
- The player reads TRAVEL_RISK through: wrist device (D019 §5.1), visor passive (D019 §4.1), community
  gossip (D024 §7), forecast (D024 §6.11).

### 7.8 Save-persistent world changes (frozen)

- The dynamic-world state (§4.1 channels) is save-persistent (D017 §11 LIVING SAVE FILE).
- The player's travel is save-persistent (the player resumes at the last save).
- The world's changes are save-persistent (a patrol depletion at F3 persists).

---

## 8. Faction reaction model (frozen)

D024 §8 freezes the faction reaction system. The world reacts to the player through faction behavior.
Faction profiles are preserved from D022 §2.

### 8.1 Faction reactions (frozen)

| Player action | Faction reaction |
|---|---|
| Player SEEN HELPING survivors | Survivor factions trust-up (D024 §9); Black Hand classifies as threat (D022 §2.1) |
| Player RAIDING facilities | All hostile factions alert; Black Hand / Security / Contractors retaliate; Survivors fear |
| Player KILLING key people | Pillar 3 RESPONSIBILITY (doctrine §34 / D011 §29); world remembers (D017 §11); survivors fear; faction removes the NPC's role |
| Player SPARING key people | Pillar 3 RESPONSIBILITY; world remembers; survivors trust-up; faction preserves the NPC's role |
| Player RESTORING power / heat / comms | Community state improves (D024 §9); world becomes more visible (lights, voices); faction presence may be affected (D015 §16-§19 consequence law) |
| Player ABUSING Compound | Anomalous signature increases (D016 §4 / §7); faction recognition increases (D022 §2.5 + §6.7 contractor / researcher reads); risk of recognition |
| Player SHOWING anomalous signs PUBLICLY | Survivor faction fear (D024 §9); Black Hand interest (D022 §2.1); faction recognition; risk of attention |
| Player REPEATEDLY using brutality | Survivor faction fear (D024 §9); Black Hand reads as threat (standard); community state degrades (D024 §10) |
| Player CARRYING visible damage / filth / recognizable gear | Community reaction per D017 §22 (cleanliness social reactions); faction reads visible state |
| Player FREEING / PROTECTING the Companion Shade | Black Hand interest (D022 §2.1); survivor fear + trust (mixed); ally / Second-in-Command bond depth (D023 §11); the Shade is a known signal |

### 8.2 Faction awareness rules (frozen)

- Faction awareness is per BV-SKILL-008 (tactical-ai-perception) + D022 §3 (perception state machine) +
  D011 §7 (truthful sensing).
- Faction awareness is NOT omniscient; the faction reads what a real observer would read (the player's
  visible state + audible + environmental cues).
- Faction awareness has a memory decay (D011 §7 INFORMATION LATENCY); stale beliefs decay.

### 8.3 Faction propagation rules (frozen)

- Faction propagation is per D011 §7 SQUAD BOUNDARY / SECTOR BOUNDARY / INFORMATION LATENCY /
  DEGRADED COMMS / JAMMING / CONTROLLER LOSS / DESYNCHRONIZATION / FALLBACK BEHAVIOR.
- A faction that learns about the player propagates the information WITHIN its squad boundary first;
  cross-squad propagation requires legitimate communication (radio / network / command hardware).
- A faction that loses the player LOSES the propagation trail; the player who breaks contact buys
  themselves time.

### 8.4 Faction memory rules (frozen)

- Faction memory is BOUNDED (D022 §3.7).
- A Tier 2 faction remembers the player's TACTIC PATTERN for a bounded time (the player's repeated
  approach is predictable).
- A Tier 3 faction remembers the player's TACTIC PATTERN longer; the player's feint is harder.
- A Tier 4 faction is rare and AUTHORED; memory is variable.
- Faction memory decays (D011 §7 INFORMATION LATENCY); stale beliefs decay.

### 8.5 Faction retaliation / avoidance / exploitation patterns (frozen)

- BLACK HAND REMNANTS (D022 §2.1): retaliation (the player is a threat to the program).
- ISLAND SURVIVORS (D022 §2.2): avoidance when threatened; exploitation of trust when safe.
- SECURITY / RECOVERY TEAMS (D022 §2.3): retaliation (mission-bound); avoidance when outmatched.
- RESEARCHERS (D022 §2.4): avoidance; bargain for survival; not combatants.
- CONTRACTORS (D022 §2.5): pragmatic retaliation when paid; avoidance when payment stops.
- ESCAPED SUBJECTS (D022 §2.6): unpredictable; may retaliate; may help.
- CRIMINAL NETWORKS (D022 §2.7, optional): opportunistic exploitation; opportunistic avoidance.

---

## 9. Community-state evolution (frozen)

D024 §9 freezes the community evolution model. Communities are NOT static; communities respond to
the player + the world.

### 9.1 What improves communities (frozen)

- WARMTH (the player who restores power / heat).
- SAFETY (the player who reduces threat pressure).
- MEDICINE (the player who restores medical equipment).
- TRUST (the player who helps survivors — D024 §9).
- ACCESS (the player who opens routes / boats / comms).

### 9.2 What degrades communities (frozen)

- WARMTH loss (the player who leaves a facility broken).
- SAFETY loss (the player who attracts attention to a community).
- MEDICINE loss (the player who consumes medicine without replenishment).
- TRUST loss (the player who betrays a community).
- THREAT PRESSURE increase (the player who brings a faction sweep to a community).

### 9.3 Visible examples of community improvement (frozen)

- MORE LIGHTS AT NIGHT (the player restored power at F1).
- REPAIRED DOORS (the community has the materials + the player helped).
- FEWER DEAD ZONES (the community can move safely).
- MORE TRADE OPTIONS (the community has goods to trade).
- BETTER WARNINGS (the community has lookout posts).
- NEW SIDE OPPORTUNITIES (the community offers a new quest / new ally / new trade).

### 9.4 Visible examples of community degradation (frozen)

- FEWER LIGHTS AT NIGHT (the facility broke again).
- BROKEN DOORS (the community cannot defend).
- MORE DEAD ZONES (the community is unsafe).
- FEWER TRADE OPTIONS (the community has lost goods).
- WORSE WARNINGS (the community is surprised).
- SURVIVOR MOVEMENT BETWEEN PLACES (the community is fleeing).

### 9.5 Rumor spread (frozen)

- The community is a SENSOR for the player's reputation (D015 §23 community systemic state).
- Rumors spread AUTHORED — the player hears about events through survivors.
- Rumors are AUTHORED CONTENT; they are not arbitrary chatter.
- Rumors reveal AUTHORED INFORMATION (the player learns about a faction's losses; the player learns
  about a community's needs; the player learns about the world's program).

### 9.6 Fear spread (frozen)

- FEAR spreads when the player brings attention to a community (D024 §8.1 brutal actions).
- FEAR is per-region; it does NOT contaminate the world (the player who has FEAR in S-1 does not
  have FEAR in F5).
- FEAR decays; recovery is the AUTHORED state.

---

## 10. Facility-network response (frozen)

D024 §10 freezes the facility propagation model. Per-facility causal maps.

### 10.1 F1 Gyle Cannery (frozen)

| Action | Local change | Propagation | Information unlock | Risk | Attracts |
|---|---|---|---|---|---|
| Restore power | Light / heat / equipment | Restores warmth/light; reduces fuel drain | Weather forecast (limited) | Light reveals position | Local wildlife; faction sweep |
| Restore communications | Radio | Comms restore; new info; new exposure | Info from far places | Others may hear | Black Hand; Survivor trust |
| Restore heating | Warmth | Heat + medicine + workshop | Workshop access | Fuel drain | Local wildlife; cold exposure risk |
| Restore medicine | Medical equipment | Treatment + recovery | Body-state inspection | Equipment damage | Survivor trust |
| Restore workshop | Repair | Repair chain for gear | Gear maintenance | Skill required | Survivor trust |

### 10.2 F2 Tanellus (frozen)

| Action | Local change | Propagation | Information unlock | Risk | Attracts |
|---|---|---|---|---|---|
| Restore power | Medbay + archives | Medical upgrade; records readable | Program archives | Power exposure | Researcher attention |
| Restore medical | Treatment + diagnosis | Body-diagram inspection | Injury history | Researcher attention | Security / Recovery |
| Restore archives | Records | Program truth | Keeper character | Program threat | Black Hand interest |

### 10.3 F3 Frostvane (frozen)

| Action | Local change | Propagation | Information unlock | Risk | Attracts |
|---|---|---|---|---|---|
| Restore power | Relay | Sector trunk propagation (D011 §7) | Weather forecast + comms reach | Relay exposure | Network coordination |
| Restore communications | Comms | Cross-sector reach | Far-place info | Information exposure | Black Hand network |
| Restore weather instrumentation | Forecast | Forecast | Storm prediction | Instrument damage | Weather hazards |
| Restore relay | Network | Sector-wide awareness | Network reach | Network exposure | Black Hand coordination |

### 10.4 F4 Vivara (frozen)

| Action | Local change | Propagation | Information unlock | Risk | Attracts |
|---|---|---|---|---|---|
| Restore power | Workshop + lamps + pumps | Repair chain + underground lights | Deep program access | Underground hazards | Experimental residue |
| Restore ventilation | Survivable depths | Reach to deeper levels | Program facility access | Deeper program threat | Program casualties |
| Restore workshop | Heavy repair | Repair for other facilities | Gear / vehicle maintenance | Workshop hazards | Contractor interest |
| Restore rail / tram | Materials + route | Logistics routes | Materials flow | Material hazards | Security / Recovery |

### 10.5 F5 Black Hand Annex (frozen)

| Action | Local change | Propagation | Information unlock | Risk | Attracts |
|---|---|---|---|---|---|
| Restore power | Institutional restoration | Program systems return (D015 §17 consequence law) | Program core truth | Surveillance / command restoration | Black Hand coordination |
| Restore surveillance | Eyes on the world | Black Hand sees more | Program truth | Player detection | Black Hand interest |
| Restore containment | Containment systems | Subject management | Program casualty content | Experimental threat | Program casualties |
| Restore medical | Medical program | Program medical | Subject content | Program threat | Researcher attention |

Frozen rule: F5 restoration is the ACT IV climax (D018 §35); F5 is the world hub; its restoration
MEANS Black Hand's systems come back (D015 §17 consequence law).---

## 11. Patrol, occupation & aftermath model (frozen)

D024 §11 freezes the patrol model. The island does not respawn. Occupation changes; patrols move; zones go
quiet, hot, and cold; the world records what happened where.

### 11.1 Patrol occupation states per region (frozen — D022 §2 faction presence)

Per-region PATROL_STATE occupation band (D024 §4.1):

```
FULL                — standard occupation; variant presence; patrols + guard posts manned to the faction's
                      capability (D022 §2)
DEPLETED            — losses; reduced force; guard posts unmanned at weak points; patrols shortened
ABSENT              — force withdrawn or destroyed; zone is quiet; may be reclaimed by wildlife /
                      environment (D024 §10)
REPLACED-WEAK       — another force moved in with fewer numbers (replacement is NOT respawn; it is a
                      new force arriving from elsewhere, and it is WEAKER for a bounded time)
REPLACED-ESCALATED  — replacement force is STRONGER (the faction reacts to a credible threat in the region;
                      escalation is AUTHORED at campaign punctuation, not constant)
```

Rules (frozen):
- Occupation is bounded by faction presence (D022 §2) and the faction's resources; a faction cannot
  garrison everywhere (D011 §22 human-first; D004 §10 budgets).
- NIGHT reduces occupation (D024 §5.3): Tier 2 trained humans reduce exposed posture; guard posts stay,
  patrols shorten.
- STORM reduces occupation (D024 §6.7): patrols retreat to prepared positions (D022 §3.3 / D021 §5 retreat).
- REPOPULATION is never instant and never unlimited. New forces must (a) have a source (a boat, a road, a
  nearby garrison), (b) travel legitimately (D011 §7 information latency — they learn what the region is),
  and (c) cost the faction resources. Faction replacement is bounded by the campaign spine (D018 §11 threat
  escalation is AUTHORED, not ambient).
- The player can destroy occupation permanently within a region (no patrol = no patrol; the zone becomes
  ABSENT until a faction decides, as a described choice, to send replacements — if they have any).

### 11.2 Patrol composition (frozen)

Per-region patrol elements (from D022 §3 squad behavior):

| Element | Behavior |
|---|---|
| ROUTE PATROL | bounded route; follows cover; predictable enough to be read; radio check-ins |
| GUARD POST | static observation; best arcs covered; weakest approach left realistic (D022 §3 mistake model) |
| SWEEP TEAM | temporary dismounted search during ALERT; exhausts; returns to post |
| QUIET POST | reduced presence at night / storm (D024 §11.1) |
| COMMAND NODE | small coordinating presence; radio backbone (D011 §7 controller loss / fallback) |

Frozen rule: patrols are people with a plan and a mistake model (D022 §3); they are not turret loops. The
player reads routes, timings, gaps, and weaknesses — that read is the game (D025 intelligence advantage).

### 11.3 Alert escalation (frozen)

Alert escalates per region and decays. It is the patrol counterpart to the AI suspicion ladder (D022 §3 /
BV-SKILL-008):

```
QUIET        — standard posture; routes normal; guard posts normal
ELEVATED     — the region saw something; routes shift; posts tightened; sweep possible
HOT          — recent conflict; forces concentrate; exterior routes reinforced; the region is dangerous
              for ALL movement, including the faction's (movement disciplines apply)
```

Rules (frozen):
- Escalation is LOCAL first (the region where the event happened), then propagates through legitimate
  communication (D011 §7 SQUAD BOUNDARY / SECTOR BOUNDARY / DEGRADED COMMS) — never omnisciently.
- Escalation DECAYS when the source stops (no event = the faction returns to standard posture over a
  bounded time, unless the event cost them enough to justify permanence).
- The player who breaks contact (D024 §8.3) buys time; the region cools; the trail dies with the source.
- FRESH KILLS smell; AUTHENTIC SCENES persist (D024 §11.4) — escalation is driven by evidence, not tags.

### 11.4 Aftermath & persistence of scenes (frozen)

Per-region LOCAL_AFTERMATH band (D024 §4.1):

```
CLEAN             — no recent conflict
RECENT-CONFLICT   — conflict happened recently; evidence present (corpses / wreck / blood / breaks)
HOT               — the fight is recent enough that faction behavior still reacts (D024 §11.3)
COLD              — old conflict; evidence degraded; faction has moved on
```

Frozen rules:
- CORPSE / WRECK / BLOOD persistence is REAL and bounded: bodies remain until the world acts on them
  (weather, wildlife, cleanup attempts, the player, or another faction). They are not despawned off-screen
  without a cause (D024 §15 island memory records what the world did about it).
- CLEANUP ATTEMPTS: factions remove their own dead when feasible (discipline, morale, order — D022 §3).
  Wild / isolate / Overwhelmed forces do not. Wildlife removes bodies when active (D024 §10, scavenging).
- HOT → COLD decay is the aftermath clock. The player can RE-VISIT scenes; what remains there after the
  decay is what the world genuinely left (some sites stay significant — D024 §15 island memory).
- Aftermath is a STEALTH INSTRUMENT: the player reads HOT zones (danger), RECENT-CONFLICT zones (evidence
  + opportunities, D024 §13 scavenging windows / aftermath discoveries), CLEAN zones (routine).

### 11.5 Quiet windows (frozen)

- Patches of the island are QUIET by geometry + time: off-route zones, night, storm interiors (D024 §6),
  zones a faction cannot cover. The quiet windows are where the player breathes, heals, plans, and rests
  (D024 §5.7 rest).
- Quiet is not guaranteed safety: quiet means no standing force, not no danger (wildlife, program remnants,
  True Unknowns per D015 §34).
- The player's discipline creates quiet: players who clear a region and hold it (D024 §16 restoration) keep
  it quiet longer; players who leave it open invite replacement (D024 §11.1 REPLACED).

---

## 12. Wildlife signal model (frozen)

D024 §12 freezes the wildlife signal layer. Wildlife is environmental INFORMATION (D015 §40 / D011 §18) with
a per-region WILDLIFE_SIGNAL band (D024 §4.1) and a recovery clock (D024 §12.5).

### 12.1 Wildlife signal bands (frozen)

```
CALM       — species behave naturally; signs are background
SILENT     — species have gone quiet / hidden; a WARNING the player reads (storms, predators, program
            presence, anomaly zones)
DISTURBED  — species are unsettled; signs (tracks / calls / carcasses) are present and recent
AVOIDING   — species actively avoid a zone; the player reads avoidance as a signal (danger beyond the
            obvious — program contamination / anomalous presence / True Unknown weighting)
AGITATED   — species are aggressive / fleeing; immediate environmental danger (predator pressure, or a
            natural event the wildlife is reacting to before humans read it)
```

### 12.2 What drives wildlife signals (frozen)

| Driver | Signal outcome |
|---|---|
| STORM approach (D015 §14 / D024 §6.8) | RESTLESS immediately before; SILENT during; QUIET/SCAVENGING after |
| HUMAN occupation | fauna suppress near active occupation; DEPLETED occupation = fauna return (a readable map of faction weakness) |
| CORPSES / BLOOD | scavenging activity; predators drawn; carcass signals attract / warn |
| DEEP-PROGRAM contamination (D015 §34) | zone AVOIDING (fauna know before humans do) |
| ANOMALY-heavy zones (D016) | change is region-sensitive and RESTRAINED (D016 §48); usually expressed as AVOIDING / subtle absence |
| SAFE-TRAVELED paths | CALM (fauna habituate) — the world tells the player a path is used |
| ABANDONED routes | fauna reclaim; signals shift to natural baseline |

### 12.3 Wildlife as information (frozen — D015 §40)

- Wildlife is NEVER a substitute for a load screen, an enemy marker, or a quest arrow. It is read; it is
  not rendered as icons (D019 §6 / D015 §45 HUD ownership).
- A SILENT forest is a real tension cue (the player registers "something is wrong here").
- Tracks / calls / carcasses / migration are DIEJECTIC information the operator reads with his own senses
  and, where equipped, through the wrist-device / helmet passive (D019 §4-§5) — worn gear reads the world,
  the HUD does not tag it.
- PREDATOR PRESSURE (bear / moose / marine mammals — D004 §7) is a hazard that drives movement decisions,
  not a combat encounter list; it feeds survival pressure (D015 §13 injury / D017 survival substrate).

### 12.4 Wildlife vs patrol (frozen)

- A faction's occupation SURPRESSES wildlife; player activity DISTURBS it. The world's wildlife signal is
  therefore a SHARED readout both sides can use (the faction's scouts read it poorly; the operator reads it
  well — D025 information advantage).
- Wildlife does not serve either side; it is the island's own layer (D015 §40 autonomy).

### 12.5 Recovery clock (frozen — D015 §40)

- WILDLIFE_SIGNAL decays to CALM after disturbance over a bounded, authored window (hours-to-days, species-
  and-budget-dependent). Disturbance without repetition = recovery; repeated disturbance = prolonged
  DISTURBED/AVOIDING states.
- PERMANENT change is rare and RE-READS: a zone that becomes AVOIDING for program reasons stays AVOIDING
  until the contamination is addressed (D024 §15 island memory records the cause).

---

## 13. Dynamic side-content structure (frozen)

D024 §13 freezes the dynamic-content layer: the island generates OPPORTUNITY through its state, but every
instance is BOUNDED, AUTHORED-COMPOSED, non-repeating, and consequence-bearing. Nothing respawns as
content (D024 §3).

### 13.1 Side-content taxonomy (frozen)

| Class | Example (state-driven) | Repetition prevention |
|---|---|---|
| SURVIVOR NEEDS | a survivor asks for a specific action (medicine / power / rescue / route) | one instance per need; resolved = removed from the queue (D015 §22 community); replaced only by a NEW authored need |
| SCAVENGING WINDOW | a collapsed cache / a wreck opens after a storm; loot is bounded and meaningful (D013 / D017 §42) | window closes (weather / wildlife / another force); cache is consumed |
| PATROL GAP | an under-strength route invites a crossing (D024 §11.1) | gap is a state (DEPLETED); filling it removes the gap; the player's own use may trigger reoccupation |
| RADIO CALL | a faction or survivor transmits a distress / traffic the player can intercept (D011 §7 comms) | message is a state; answered or expired |
| RESCUE OPPORTUNITY | a person in danger, bounded by location + threat | consequence-bearing (saved = in the world and remembered, D025/D017 §46; lost = remembered) |
| MEDICAL EMERGENCY | a survivor / companion / the Hand's own body needs treatment (D015 §13) | one instance; resolved = gone |
| ROUTE WARNING | community gossips a route risk (D024 §9.5 rumor) | rumor is state; truth may change (a real patrol moved) |
| WILDLIFE HAZARD | predation window (D024 §12) | hazard is a state; dissipated by time / action |
| FACTION CLASH | two forces grind each other (D022 faction goals) | bounded event; resolves with a consequence recorded (D024 §15) |
| AFTERMATH DISCOVERY | evidence found at a HOT/COLD site (D024 §11.4) | scene remains but the read-out is consumed |
| WEATHER-DRIVEN OPPORTUNITY | storm closes a route AND opens one (D024 §6.5) | one-time route event; the world settles |
| MEMORY-BLEED-TRIGGERED DETOUR | a trigger pulls the Hand aside (D015 §31 / D023 memory-bleed integration) | authored placement only; never ambient |

### 13.2 Content rules (frozen)

- CONTENT IS STATE, not a spawner: each instance is a re-composed reading of the island's state channels
  (D024 §4.1), not a random-drop generator. The island does not "spawn missions"; it presents what its
  state means.
- AUTHORED-COMPOSED: every instance must have a canon trail back to an authored source (a person, a place,
  a program remnant, a weather event, a faction goal). No content exists without provenance (D011
  provenance / BV-SKILL-027).
- NO repetition loops: scavenging windows, rescue opportunities, radio calls, and survivor needs do not
  repeat infinitely. When the authored supply is consumed, the class goes quiet until the campaign spine
  (D018) calls a new one.
- CONSEQUENCE: resolving content changes state (D024 §3 philosophy) — a rescue joins the world (D015 §22
  community / D023 kinship), a failed rescue darkens a community (D024 §8), a scavenged cache is gone.
- PERSISTENCE: resolved content is remembered (D024 §15 island memory) and observable through world state
  (the person is at the base; the cache is empty; the clash's aftermath is on the ground).
- FAILURE STATES are canonical and authored: the world continues when the player ignores or fails content
  (the person dies; the faction wins; the window closes). There is no "missed content" punishment beyond
  consequence honesty (D021 combat consequence; D023 moral consequences).
- PRIORITY: urgent world states (injury, direct threat, storm) crowd out ambient content naturally; the
  player is never forced to choose between content and survival by a timer UI (D019 §6 forbid; D017 §53
  calm under pressure).

---

## 14. Player-path world-response (frozen)

D024 §14 freezes how the WORLD RESPONDS to the player's accumulated path. This is the bounded layer that
satisfies "actions change the island" (D024 directive §impact) without becoming a global reputation sim.

### 14.1 The bounded response model (frozen)

- Response is LOCAL + RECORDED + COMMUNICATED, never a global reputation bar (D024 §4.2).
- The world responds through the state it already tracks: community trust index (D015 §22), faction
  presence (D022 §2), aftermath (D024 §11.4), wildlife (D024 §12), island memory (D024 §15).
- The player's path is read through OBSERVABLE DEEDS: who was saved, who was killed or spared, what was
  restored, what was destroyed, what was seen, what was said. Deeds are the currency; values are never
  numbers on screen (D019 §6 forbid).

### 14.2 Path archetypes (frozen — canonical, not exhaustive)

Player paths are not slots; they are the accumulated weight of deeds read by each community:

| Path character | World response (bounded) |
|---|---|
| COMPOUND (exploits the anomaly heavily, D016 §48 prevention matrix) | communities fear the visible change in him (D017 §22 visible-state); researchers / contractors read him with rising interest (D022 §2.4/§2.5 recognition); the anomaly's cost stays internal (D015 §31 memory bleed / D016 strain) |
| INDEPENDENT (solves alone, keeps distance) | communities stay respectful-but-distant; trust grows slower (D015 §22); capability is respected not welcomed |
| MERCIFUL (spares, rescues, restores) | trust rises; community index rises; faction memory marks him unpredictable-and-soft (D022 §2 memory) or redeemed (Pillar 3 RESPONSIBILITY per D011 §29 / D016 §41) |
| BRUTAL (kills, destroys, leaves fear) | trust falls; communities fear; BH remnants class him a top threat and adapt (D022 §2.1); his own body bears what the world saw (D017 §46 permanent consequences) |
| VISIBLE-FEARED (his deeds are spoken of, D024 §9.5 rumor) | factions adjust tactics toward the LEGEND; rooms empty when he walks in; some people test him (D022 §3) |
| TRUSTED-QUIET (a reputation of reliability, spoken quietly, D024 §9.5) | communities open paths, hide him, trade fairly (D015 §22; D017 §15 ally curve); factions underrate him until contact |

### 14.3 What the world never does (frozen)

- Never flips the whole island to "hostile" or "friendly" (D024 §4.2 — no global faction reputation).
- Never spits dialog-tags ("known murderer / known savior") at the player (D019 §6 forbid).
- Never rewards good deeds with a lobby/achievement layer (D024 §21 island-as-progression).
- Never erases the record: a deed done is remembered by the place it happened (D024 §15) even when no one
  else learns of it (D024 §8.2 awareness bounds).

---

## 15. Island memory — the world remembers (frozen)

D024 §15 freezes the island-memory layer. The world remembers what the player did, what was repaired,
what was destroyed, who survived, who died, and what was seen — WITHOUT a global reputation sim (D024 §4.2)
and WITHOUT a dialog-tagged value system (D024 §14.3).

### 15.1 What the world records (frozen)

The world records DEEDS against the state channels it already tracks (D024 §4.1 + D017 §11 LIVING SAVE
FILE). Recorded kinds:

| Record | Answer the world gives itself | Persistence |
|---|---|---|
| WHERE THE PLAYER HAS BEEN | discovered / disturbed / calmed / cleared zones (patrol state + aftermath) | save-persistent |
| WHAT WAS REPAIRED | facility + community states (power / heat / comms / med / workshop per D015 §16-§21, D024 §10 causal maps) | save-persistent (a restored facility STAYS restored until damaged AUTHENTICLY) |
| WHAT WAS DESTROYED | aftermath + patrol + community states (what is gone; what remains) | save-persistent (no off-screen rebuild without a cause, D024 §11.4) |
| WHO SURVIVED | community / companion / ally roster states (D015 §22 / D023) — a saved person remains in the world | save-persistent until real death |
| WHO DIED | removal from the world; aftermath records the evidence; memory bleeds (D015 §31) and community reactions carry the fact | save-persistent (no revival; the world does not un-remember a death) |
| WHAT REPUTATION EXISTS | bounded per-region interpretation of deeds (D024 §14.2 path read) | save-persistent but LOCAL and decaying with information latency (D011 §7 / D024 §8.4) |

### 15.2 How memory is expressed (frozen)

The world is the memory surface (D019 §5 WORLD-AS-HUD; doctrine §31). Memory is read through:

- WORLD-STATE CHANGES (lights lit, doors repaired, routes quiet, aftermath left on the ground — D024 §9.3/
  §9.4 visible examples; D024 §11.4)
- LIVING PEOPLE (the survivor at the base; the ally who remembers; the community that knows — D023)
- SPOKEN/RADIO WORD (rumor spread D024 §9.5; faction communication D011 §7)
- THE HAND'S OWN BODY AND SOUND (scar tissue, weapon history, animation-evolution ladder — D017 §36/§46;
  memory bleeds D015 §31) — the island changed him as he changed it (D024 §16)
- PROGRAM GROUND (facility state and archives are a second memory: what the program recorded about the
  island and about him — D012 / D016 — layered over what he did)

### 15.3 Memory bounds (frozen)

- Memory is NOT omniscient: a deed is remembered by the place it happened and, if legitimately
  communicated (D011 §7 latency / degraded comms), by whom the word reaches (D024 §8.2 awareness bounds).
- Memory DECAYS for routine things (a quiet patrol past a quiet zone leaves no scar) and PERSISTS for
  significant ones (a death, a restoration, a legend — D024 §14.2).
- The world does not hold grudges globally or worship globally; each region re-reads the player through
  its own local record (D015 §22 community per-cluster / D024 §9.6 fear is per-region).
- SAVE is the player's record of the world (D017 §11 LIVING SAVE FILE); island memory is the world's
  record of the player. They are the same file system — the HAND and the ISLAND are one living state.

### 15.4 Memory bleeds & island memory (frozen)

- Memory Bleeds are the PLAYER's memories recutting with the present (D015 §31 / D023 §memory-bleed
  integration), not the island's. The island memory and the Hand's memory are two surfaces that OCCASION
  LLY meet: a place he changed triggers a bleed about what he was; a person he saved triggers a bleed about
  what he lost. Blends are AUTHORED moments (D019 §12 / D024 §18), never ambient triggers.

---

## 16. Restoration & the island changing hands (frozen)

D024 §16 freezes the restoration layer: the player permanently changes the island by restoring or taking
ground, and the campaign respects that permanence (doctrine §31 Restorable Facilities; D015 §16-§21; D024
§10 facility causal maps).

### 16.1 Restoration permanence (frozen)

- A restored facility is a PERMANENT world change (power stays on; heat stays on; comms stay up) UNTIL a
  credible world force breaks it (storm, faction raid, sabotage, attrition). Restoration is not a quest
  reward; it is a world edit with lasting consequences both ways (more light = more exposure D022 §2.1; more
  infrastructure = recovery teams gravitate toward it D022 §2.3).
- The player early-lands safe routes (D015 §28 SAFE / ACTIVE coarse model): a restored cannery (F1) makes
  the coastal zone measurably calmer (D019 §5 / D024 §7.2 safer regions).
- REGRESSION exists only through AUTHENTIC cause (D024 §11.4 cleanup; D022 faction retaliation); the world
  does not "lose progress" as a difficulty hook.

### 16.2 Consequence of restoration for factions (frozen)

- Restoration is visible and READS: restored facilities attract attention (D022 §2.3 recovery teams, D022
  §2.1 BH remnants reassert, D022 §2.4 researchers creep back). The consequence law (D015 §16-§21) means
  restoring is GOOD and exposes — the island is not a kindness checkbox (D024 §3 philosophy; D021
  consequence honesty).
- Restoration rebalances patrol state (D024 §11.1): the player must hold what he made safe, or it becomes
  someone else's post (REPLACED-WEAK / REPLACED-ESCALATED).

### 16.3 Taking ground (frozen)

- Clearing a zone (destroying a post, ending an occupation) has the same permanence rules as restoration:
  the ground stays cleared until a real force moves in; the world records it (D024 §11.4 aftermath).
- Clearing is never "capturing a flag": it is removing danger from a place, and the place responds
  (wildlife returns D024 §12; survivors relax D015 §22; program territory is NOT restorable — D024 §7.6
  deep-program remnant is permanent).

---

## 17. Time & the island's daily rhythm (frozen consolidation)

D024 §17 consolidates the day-night-island rhythm. Time rules were frozen in D024 §5; here the RHYTHM is
frozen as a world-feel contract: the island has a daily pulse the player can read and exploit (D025
observation advantage; D024 §5/§6/§9/§11/§12).

### 17.1 Daily rhythm (frozen)

- The island's DAY is the primary rhythm unit (D024 §5.1): dawn wakes wildlife (D024 §12.1), day runs full
  patrols (D024 §11.1 / §12), dusk shifts behavior (wildlife + patrol transition), night suppresses patrols
  and opens the world to the operator who uses darkness (D024 §5.5 nighttime benefits).
- COMMUNITY rhythm is real but never a chore list: lights at night (D024 §9.3), watch rotas, and rest
  slots are DIEJETIC (D019 §6 forbid; D015 §45 HUD ownership) — the player reads a settlement's aliveness
  through its light, sound, and movement, not through schedule panels.
- WEATHER punctuates the rhythm (D024 §6.1 systemic punctuation): storms temporarily override the daily
  pattern (wildlife silent D024 §6.8 / §12.2, patrols retreat D024 §6.7/§11.1), then the rhythm resumes.
- The player's REST threads the rhythm (D024 §5.7): rest is a tactical choice that advances time and pays
  for sleep in what the world does meanwhile (patrols move, windows close, aftermath cools D024 §11.4).

### 17.2 Seasonal / longevity feel (frozen)

- The island has a LONG BODY (high-latitude season feel, D015 §14 weather machine; D004 §7 regional
  distribution): the world reads colder, darker, harsher as the player travels north toward the program
  core (D018 §10 facility sequencing; D024 §7.1 region categories).
- Season is NOT an on-screen timer; it is expressed through sun angle, snow depth, wildlife behavior,
  and route states (D015 §14 / D019 §11 / D024 §6).
- No in-fiction "day counter" or "night counter" UI (D019 §6 forbid): the sky, the temperature, and the
  wildlife are the clock.

---

## 18. Observability & diagnostic layer for the world (frozen — SOP-006 / BV-SKILL-015)

D024 §18 freezes the debug/observability contract for the dynamic-world layer, consistent with SOP-006
debug-observability and BV-SKILL-015 gameplay-debugging-instrumentation.

- Every world channel (D024 §4.1) is INSPECTABLE in the dev shell: current band, last transition, last
  cause, reason trace (who/what caused the transition, when, through what leg of the consequence law) —
  the world must be able to ANSWER why a region is SILENT, why a facility is DEPLETED, why a faction is
  REPLACED-ESCALATED.
- Deeds logged: the island-memory surface (D024 §15) writes an inspectable log (tombstone) of what the
  world recorded and WHY, so QA/design can read the world's reasoning and verify D024 §14/.3 (bounded
  response) is not leaking a global reputation sim.
- Deterministic playback: the world layer is a deterministic function of (authored state + player deeds +
  seed), so a recorded slice can be replayed to confirm consequence laws (D020 §9 fixture determinism;
  SINCE D024 is world-behavior, fixture = deterministic scenario at ACT I-II scale exercising one region
  under a scripted deed, verifying BAND transitions + NO global propagation leakage).
- NEVER visible in the shipped game: these channels are dev-only (SOP-006); the island's inner workings
  are never a screen (D019 §6 forbid meters; D015 §45 ownership).

---

## 19. Camera / narrative layering of the world (frozen consolidation)

D024 §19 freezes how the world PRESENTS itself across cameras/reads (D019 §3–§5; D015 §45; D017 §40
mirror moments). Hand-offs only — no duplication, no IPC (D007 §9 / BV-SKILL-013).

### 19.1 World information surfaces (frozen)

| Surface | Reads | Owns |
|---|---|---|
| 3P operational view (D019 §3) | the world as terrain + occupancy: what to read is in the world (camp smoke, dark windows, tracks, wildlife silence) | BV-SKILL-032 / D019 */
| helmet passive (D019 §4.1) | bounded environmental state the HAND CAN legitimately read with worn gear: temperature band, wind, route risk derived read, comms | D019 §5 equipment-owned; D024 reads ONLY through that law |
| wrist glance (D019 §5.1) | deliberate read: facility/community/faction state summaries the HAND would track (D024 §10 causal maps / §11 patrol state / §15 island memory), accessed like a device, not an overlay | D019 §5.1 owns |
| world / diegetic (D015 §45 WORLD) | everything else: first-class info lives in the world (a dead post's aftermath, a restored light, a rumor overheard) | D024 §15/§9.5 compose; D019 §6 forbid floating markers |

### 19.2 The world never renders what the HAND could not read (frozen)

- No faction-colored map overlays; no objective compass hacks into the HUD; no mission-select screen that
  abstracts the island (D024 §21 island-as-progression). Progression is READ from the world (D019 §5 WORLD;
  doctrine §31 continuous world; D024 §21).
- The island's dynamic state enters gameplay through OBSERVATION (D025 observation advantage; D024 §17
  rhythm; D011 §7 truthful sensing) — the operators sees the world change because he was part of making it
  change (D024 §16).

---

## 20. World-state codex & vocabularies (frozen consolidation)

D024 §20 freezes the shared vocabulary so the dynamic-world layer composes cleanly across the fleet:

| Term | Definition (frozen) | Authority |
|---|---|---|
| BAND | a per-region measured state (SILENT / CLEAN / X etc.) | D024 §11/§12 |
| COARSE STATE | SAFE / ACTIVE / THREATENED / DISPLACED / LOST off-screen model | D015 §28 |
| DEED | an authored player action the world can record (restore / kill / spare / save / destroy / reveal) | D024 §14/§15 |
| CONSEQUENCE LAW | restored <- benefit/cost/failure/dependency/secondary | D015 §16-§21 |
| CAUSAL MAP | per-facility action -> local change / propagation / info / risk / attracts | D024 §10 |
| ISLAND MEMORY | the world's recorded record of deeds + world changes; the world-side of the LIVING SAVE FILE | D024 §15 / D017 §11 |
| AFTERMATH | physical evidence left by a conflict; HOT/COLD persistent scene | D024 §11.4 |
| LEGEND | the communicated reputation that travels (rumor D024 §9.5 / radio D011 §7), bounded and decaying | D024 §14.2 |

- Every vocabulary term is READOUT of the same deterministic state (D024 §18); no term is a new subsystem
  with hidden simulation cost (D024 §4.3 tablet-feasibility law).

---

## 21. Island as the primary game space — no lobby / no mission select / no artificial levels (frozen)

D024 §21 freezes the world-as-game-space principle. The island itself is the game's progression system.
The world changes; progression is the change the player reads, not a score screen or mission list.

### 21.1 No lobby / no mission select / no level map (frozen)

- The lobby / mission-select fiction is explicitly rejected (D024 §1 no-loading-screen rule; D004 §5 anti-
  architecture rule): there is no "safe screen" that abstracts the island away. The island is always the
  game; the player is always *somewhere on it* (D015 §28; D019 §5 WORLD-AS-HUD).
- Route between regions is TRAVEL on foot (with compose: BV-SKILL-013 large-world-sector-architecture; D024
  §7.7 travel risk): travel is not a map click; it is a decision inside the dynamic world (D024 §7 region-
  state).
- There is no world-map screen, no faction-conquest screen, no upgrade tree (D017 §39 base-as-identity;
  D024 §16 restoration permanence): these abstracts kill the continuous-world promise (D004 §5, doctrine
  §5).

### 21.2 The island is the progression system (frozen)

- Progression is READ from the island's changes: things look different later. Things that were hostile are
  calmer. Things that were dark are lit. Places that were empty are occupied. People who were unknown are
  known (D024 §15 island memory).
- Progression is also READ from what is lost: some places are darker; some people are gone; some ground is
  permanently taken by a force (D024 §7.6 never fully recovers). Progress is not an upward arrow (D017 §46
  permanent consequences).
- The world's changes answer the question "what happened here?" (D024 §15) and "who was here?" (D024 §14)
  and "what do I do next?" (D024 §13) without a HUD quest panel: the surviving person at the cannery who
  tells you the relay is down (D015 §22 community / D024 §9.5 rumor); the dark facility you passed that is
  now buzzing with radio chatter (D024 §10 F3 / D019 §4 helmet); the dead patrol's aftermath that says
  "someone was here before you, and they were better" (D024 §11.4; D018 §11 threat escalation).
- The player's progression through the 5-stage reclamation arc (D017 §3 / D024 §16) is the island's
  progression: his body changes (D017 §36), his position in the world changes (D024 §16), and the island
  responds (D024 §14).

### 21.3 How the player knows where to go next — without a waypoint (frozen)

- Diegetic guidance: the wrist-device shows facility states (D024 §10 causal maps); the helmet passive shows
  comms / route state (D024 §19.1); communities speak (D024 §9.5); aftermath tells (D024 §11.4); wildlife
  tells (D024 §12).
- ALL guidance is DIEJECTIC (D019 §5 WORLD; D024 §19); no "golden path" arrows (D019 §6 forbid).
- The world is dense enough that the player ALWAYS has a reason to move (D024 §13 dynamic side-content;
  D024 §11 patrol gaps; D024 §12 wildlife reads) but never feels herded (D024 §3 philosophy; D017 §53
  calm under pressure).

---

## 22. SYSTEM LAW vs CANDIDATE CONTENT separation (frozen — canonical)

D024 §22 freezes the separation between what is SYSTEM LAW (this section) and what is CANDIDATE CONTENT
(into implementation / authoring). This separation is REQUIRED by D001 (doctrine scope); D024 adopts it.

### 22.1 SYSTEM LAW (D024 §4 through §21 — frozen, locked)

Every law in D024 §4–§21 is FROZEN. These laws do not move in implementation, authoring, or future
directives unless D024 is reopened (or a specific canon-correction packet arrives per established
process — see D023 shade correction packet). System laws include:

- All D024 §4 world-state channel definitions (what is tracked, what is not)
- All D024 §5 time-of-day rules (what changes with time, what does not, sleep/rest)
- All D024 §6 weather-as-driver rules (route open/close, patrol changes, wildlife reads, drone
  degradation, shelter pressure)
- All D024 §7 region-state and travel-state (what can become safer / more dangerous / blocked / recovers /
  never fully recovers; travel-risk bands)
- All D024 §8 faction-reaction rules (awareness bounds, propagation rules, memory bounds, retaliation /
  avoidance / exploitation)
- All D024 §9 community-state evolution (visible improvements / degradations, rumor / fear spread, what
  improves / degrades communities)
- All D024 §10 facility causal maps (F1–F5; restoration permanence per D024 §16)
- All D024 §11 patrol / occupation / aftermath (occupation states, patrol elements, alert escalation,
  aftermath, quiet windows)
- All D024 §12 wildlife signal model (bands, drivers, recovery, as-information)
- All D024 §13 dynamic side-content structure (taxonomy, content rules)
- All D024 §14 player-path world-response (bounded model, archetypes, what the world never does)
- All D024 §15 island memory (what the world records, how it is expressed, memory bounds, bleeds)
- All D024 §16 restoration & ground changes (permanence, faction consequences, taking ground)
- All D024 §17 time & daily rhythm (consolidated rhythm, seasonal feel, no HUD clock)
- All D024 §18 observability / diagnostic layer (SOP-006 contract)
- All D024 §19 camera / narrative layering (world information surfaces, no abstracted screens)
- All D024 §20 world-state codex & vocabularies
- All D024 §21 island-as-game-space (no lobby, no mission select, island IS progression, diegetic guidance)

### 22.2 CANDIDATE CONTENT (OPEN — assigned only by design)

The following are CANDIDATE CONTENT (not frozen) and will be authored during implementation / game writing /
fleets:

- The specific authored causes behind every state transition (who moved where, what the radio says, what
  the aftermath looks like in a specific location)
- The specific weighted lists behind every patrol route, every guard post, every alert escalation
- The exact curves behind band decay (patrol repopulation delay, alert escalation cooldown, wildlife
  recovery clock)
- The authored roster of side-content instances (survivor needs, radio calls, rescue opportunities,
  memory-bleed detours)
- The specific causality of island memory (what is said, how it travels, which rumor text)
- The specific diegetic content of the wrist-device and helmet state readouts (UI text layout, data
  intervals)
- The authored opening content of the dynamic system in Act I (D018 §9 first-slice content: what the
  player sees, hears, and reads at Strand/Cannery first time)

All candidate content must COMPLY with system laws (§22.1) — they are bounded by them. Candidate content
can be written by any skill that composes D024 (BV-SKILL-013, -015, -017, -020, -027, -029, -031, -033).

### 22.3 Implementation vs authoring boundary (frozen)

- "Implementation" (game code) means: the band-transition engine, the consequence-law graph, the state-
  persistence wiring (save/load of channels), the observability shell. This is D020/D027 vertical slice
  territory (not part of D024).
- "Authoring" (game writing / world design) means: placing the specific instances of patrol routes, guard
  posts, radio calls, survivor needs, side-content triggers, community vignettes. This is SOP-002 game-
  writing territory.
- D024 provides neither implementation nor authored content; D024 provides the LAW that both must obey.

---

## 23. Contradiction check vs D001–D026

| # | D### / doctrine section | Potential tension | Resolution | Verdict |
|---|---|---|---|---|
| 1 | doctrine §5 (no lobby, continuous world) | D024 §21 (no lobby, no mission select) | Same direction; D024 extends the principle explicitly | CLEAN |
| 2 | D004 §5 (no abstracted maps) | D024 §21 (no world-map screen, no mission screen) | Same direction; D024 adds diegetic guidance | CLEAN |
| 3 | D017 §11 (LIVING SAVE FILE) | D024 §15 (island memory) | Same: world records and the save file stores them; one living system | CLEAN |
| 4 | D017 §46 (permanent consequences) | D024 §16 (restoration permanence) | Same direction; restoration persists; death persists; regression requires real cause | CLEAN |
| 5 | D022 §2 (7-faction taxonomy) | D024 §8 (faction reaction model uses 7 factions) | Same; criminal networks optional | CLEAN |
| 6 | D023 (Shade is not the Hand, no summon) | D024 §16 mentions Shade-world interaction, §15 mentions Shade is a read | Consistent; Shade reads as a separate person in the world; D023 rules hold | CLEAN |
| 7 | D015 §31 (Memory Bleed taxonomy) | D024 §15.4 (bleeds as player's memory, not the world's memory) | Distinction explicit; bleeds are the Hand's memory intersecting world state | CLEAN |
| 8 | D016 §48 (anomaly prevention matrix) | D024 §12.2 (anomaly zones drive wildlife) | Consistent; wildlife is a readout of the anomaly's presence, not a UI for it | CLEAN |
| 9 | D018 (Season 1 spine) | D024 §13 (side-content is authored-compose, not spawner) | Consistent; dynamic side-content is composed of state channels + authored sources; no infinite spawn | CLEAN |
| 10 | D019 §6 (forbid HUD meters / quest arrows) | D024 §19.2 (no faction-color map overlays, no objective compass) | Same direction; D024 constrains further | CLEAN |
| 11 | D020 §9 (fixture determinism) | D024 §18 (world layer deterministic under seed) | Same direction; D024 world behavior must be deterministic per fixture | CLEAN |
| 12 | D025 (operator identity, military discipline) | D024 §14 (player-path archetypes are read, not earned) | Consistent; player-path read through deeds; identity is internal discipline; both are read through behavior | CLEAN |
| 13 | D026 (touchscreen, minimum input) | D024 §21 (diegetic guidance, no touch HUD panels) | Consistent; touch layer composes (D024 §19.1 wrist glance is touch-accessible without duplicating world) | CLEAN |
| 14 | BV-D123 (vertical slice = Strand → Cannery) | D024 dynamic system must work at Slice scale | Consistent; Slice tests ONE region + ONE facility, bounded dynamic-state test (D024 §18 diagnostic layer is Slice-ready) | CLEAN |

**Total: 14 checks, 0 contradictions, 0 silent repairs required.**

---

## 24. Deferred decisions

These decisions are FROZEN IN SCOPE but their specific values are deferred to implementation / authoring
(design lead discretion):

| Deferred decision | Note |
|---|---|
| Precise band-transition curves (patrol repopulation delay, alert cooldown, wildlife recovery clock) | Tuned at implementation; cannot contradict bounds (patrol is never instant, recovery is never instant, cooldown is never zero) |
| Weather-storm punctuation timing per season | Authored during D018 campaign writing (D018 §20 weather pacing) |
| Radio call content and voice templates | Authored during game-writing (SOP-002) |
| Wrist-device state readout layout (facility-state lists, route-risk display) | D019 §5.1 device-owned; authored at implementation |
| Helmet passive environmental summary | D019 §4.1; authored at implementation |
| Exact patrol-route shapes per region | Authored at implementation; requires D022 squad behavior + terrain pass |
| Moral-consequence example scenes for specific kills/saves | D023 authoring territory |
| Memory-bleed trigger placements in Season 1 | D015 §31 authoring territory |
| Facility restoration content (what the player sees/hears when restoring) | Authored per D015 §16-§21; implementation-level beats |
| Season 2+ dynamic system expansion | Out of D024 scope; D024 covers Season 1 only |
| Vocal companion call lines for Shade | D023 territory; deferred to authoring |

---

## 25. Skill review & validation status

### 25.1 Skills authored

No new methodology skill was created for D024. The dynamic-world architecture composes skills that already
exist and cover the specialist layers:

- BV-SKILL-013 (large-world-sector-architecture): spatial structure, one-world activation
- BV-SKILL-015 (gameplay-debugging-instrumentation): SOP-006 observability
- BV-SKILL-017 (survival-wilderness-systems): cold, wetness, fatigue, injury, shelter, weather internals
- BV-SKILL-020 (facility-ally-support): facility operations, ally support, restoration mechanics
- BV-SKILL-027 (island-population-threat-ecology): population, faction roster, NPC authoring
- BV-SKILL-029 (simse-island-systems): world-system substrate, propagation, community state, facility
  anchors, off-screen coarse model
- BV-SKILL-031 (persistent-character-state-architecture): player persistent channels, LIVING SAVE FILE
- BV-SKILL-033 (enemy-architecture): AI faction behavior, squad behavior, tactical perception
- BV-SKILL-034 (companion-relationship-architecture): Shade in the world, community relationships

D024 is a CANONICAL-REFERENCE layer (like D018, D013, D011): it provides laws, not a reusable design
procedure. The design procedures belong to the specialist skills above. D024 COMPOSES them; none of them
need to be modified.

### 25.2 Validation status

- **Contradiction check vs D001–D026:** PASS (14 checks, 0 contradictions, 0 silent repairs — see §23)
- **Static game verification:** CLEAN (24 ok / 0 fail) — no game/ changes (unmodified)
- **Methodology validator:** PASSED (2 governing + 36 BV skills, 6 SOPs, registry consistent)
- **Consistency with established fleet numbering:** OK — D024 is the frozen canonical reference for the
  world-state layer; fleet remains 2 governing + 36 BV + 6 SOP; no new skill needed

---

# DIRECTIVE 024 — FINAL REPORT

**DYNAMIC WORLD, ISLAND STATE & PERSISTENT SIMULATION BIBLE**

**Files inspected:** doctrine §5 (Environment), §6 (Stealth), §10 (Platform/Renderer), §23 (Horror
Model), §24 (Biblical Horror), §26 (Ally Role), §27 (Other Hidden Hand), §29 (Opening Structure), §30
(Wilderness/Survival), §31 (Restorable Facilities), §34 (Narrative Pillars); D004 §3–§5/§10; D011 §3–
§32; D012 provenance; D014; D015 §6/§9–§16/§22/§28/§31/§33–§34/§40/§45; D016 §4/§7/§22/§30–§31/
§48–§49; D017 §3/§11/§22/§36/§39/§46/§51; D018 §5/§10–§11/§15/§18/§20/§35/§37/§55; D019 §3–§6/
§11–§16; D020 §4.5–§4.7/§7/§9; D021 §3/§5/§7; D022 §2–§10; D023 §8/§11–§14; D025; D026. Skills
reviewed: BV-SKILL-006, -008, -012, -013, -014, -015, -017, -019, -020, -021, -027, -029, -031, -032,
-033, -034, -035, -036.

**Files created:** `docs/design/DYNAMIC_WORLD_ISLAND_STATE_PERSISTENT_SIMULATION_BIBLE.md`
(1307 lines, 25 sections + final report — assembled from fixed chunk A + continuations B–D).

**Doctrine:** No new doctrine row needed. The existing BV-D128 row (frozen-paused) now references this
bible; the row's content is canonical reference for the world-state layer. No new BV numbers consumed.

**Fleet impact:** 0 new skills. The dynamic-world architecture is a CANONICAL-REFERENCE layer; the design
procedures it uses are owned by existing specialist skills (BV-SKILL-013, -015, -17, -20, -27, -29, -31,
-33, -34). Fleet remains at 2 governing + 36 BV skills + 6 SOPs. Registry, validator, and README
unchanged.

**Control philosophy:** (D024 is not a controls bible — D026 owns controls. D024 defines the world the
controls serve.) The world presents itself through diegetic surfaces only (D024 §19): the 3P operational
view, the wrist glance, the helmet passive, the world itself. No lobby, no mission select, no abstracted
map. The island IS the game. The player reads it with observation (D025 advantage), not with HUD panels.

**Dynamic-world architecture:**
- **World-state model (§4):** 11 channels tracked (TIME_OF_DAY / WEATHER / STORM_EVENT / FACILITY_STATE /
  FACTION_PRESENCE / PATROL_STATE / COMMUNITY_STATE / TRAVEL_RISK / WILDLIFE_SIGNAL / RESOURCE_PRESSURE /
  LOCAL_AFTERMATH); 6 categories NOT tracked (per-NPC schedules, per-NPC hunger, per-animal hunger, per-
  resource depletion per pickup, per-building interior weather, per-player reputation per faction). State
  tracker + authored consequence injector, not continuous simulation. Tablet-feasibility law frozen.
- **Time (§5):** The in-fiction day is the primary unit. DAWN/DAY/DUSK/NIGHT windows; patrol / wildlife /
  visibility / community / facility behaviors change; nighttime benefits (stealth, patrol gaps) and costs
  (visibility, cold, hazard). Rest = player choice to advance time at cost of world change. Off-screen = coarse
  states, not continuous simulation.
- **Weather-as-driver (§6):** Weather punctuates the campaign (D018 §20); creates route closure/opening,
  patrol changes, wildlife reads, shelter pressure, drone degradation; storms are systemic punctuation with
  authored consequences.
- **Region-state (§7):** 7 canonical region categories with safe / dangerous / blocked / recoverable /
  permanent profiles. Travel-risk bands; region-state composes with weather / patrol / wildlife / facility
  state.
- **Faction reaction (§8):** 7 factions (D022 §2); awareness bounded; propagation bounded (squad/sector /
  information latency / degraded comms / desynchronization); memory bounded (decays, per-tier depth);
  retaliation / avoidance / exploitation patterns frozen.
- **Community-state evolution (§9):** warmth / safety / medicine / trust / access / threat pressure;
  visible improvements (lights, doors, dead zones, trade) and degradations; rumor and fear spread, bounded.
- **Facility causal maps (§10):** F1–F5 per-facility action -> local change / propagation / info / risk /
  attracts. Restoration permanence (D024 §16); F5 restoration = ACT IV climax (D018 §35).
- **Patrol / aftermath (§11):** Per-region occupation band (FULL / DEPLETED / ABSENT / REPLACED-WEAK /
  REPLACED-ESCALATED); patrol elements (route / guard post / sweep / quiet / command); alert escalation
  (QUIET / ELEVATED / HOT); aftermath scene persistence (corpses / wreck / blood); quiet windows.
- **Wildlife signal (§12):** CALM / SILENT / DISTURBED / AVOIDING / AGITATED per region; drivers = weather /
  human occupation / corpses / deep-program / anomaly / safe-traveled paths / abandoned routes; wildlife as
  environmental information (D015 §40); recovery clock.
- **Dynamic side-content (§13):** 12-instance taxonomy (survivor needs / scavenging windows / patrol gaps /
  radio calls / rescue opportunities / medical emergencies / route warnings / wildlife hazards / faction clashes
  / aftermath discoveries / weather-driven opportunities / memory-bleed detours); all STATE-DRIVEN, BOUNDED,
  CONSEQUENCE-BEARING, NON-REPETITIVE. No spawner / no infinite content loop.
- **Player-path world-response (§14):** Bounded; read through observable deeds, not global reputation bars;
  6 archetypes (COMPOUND / INDEPENDENT / MERCIFUL / BRUTAL / VISIBLE-FEARED / TRUSTED-QUIET); world never
  flips globally hostile/friendly or tags.
- **Island memory (§15):** The world records deeds through the state channels it already tracks; memory is
  LOCAL, DECAPS, and expressed through world-state / living people / spoken word / the Hand's own body and
  sound; memory bleeds are the player's memory, not the island's.
- **Restoration & ground changes (§16):** Permanent with authentic cause for regression; restoration attracts
  attention; clearing is permanent with repopulation delay; taking ground = removing danger from a place.
- **Time & daily rhythm (§17):** Daily pulse (dawn/day/dusk/night); community rhythm; storm punctuation;
  rest = tactical choice; seasonal / longevity feel; no HUD clock.
- **Observability (§18):** Every channel inspectable in dev shell; deed log; deterministic playback for
  fixtures (D020 §9); dev-only, never in shipped game.
- **World information surfaces (§19):** 3P operational / wrist glance / helmet passive / world-diegetic;
  no abstracted map / no HUD quest panel / no waypoint; progression read from world state.
- **World-state codex (§20):** BAND / COARSE STATE / DEED / CONSEQUENCE LAW / CAUSAL MAP / ISLAND MEMORY /
  AFTERMATH / LEGEND — shared vocabularies for clean composition.
- **Island-as-game-space (§21):** No lobby / no mission select / no artificial levels; the island IS the
  progression system; progression read through world changes; diegetic guidance only (wrist, helmet, community,
  aftermath, wildlife).
- **SYSTEM LAW vs CANDIDATE CONTENT (§22):** D024 §4–§21 are FROZEN system laws; specific patrol routes,
  authored scene content, decay curves, side-content instances are CANDIDATE CONTENT (authored per D020 / D018
  / SOP-002).
- **Contradictions:** 14 checks vs D001–D026; 0 contradictions; 0 silent repairs.
- **Deferred decisions:** 11 recorded.
- **Validation:** METHODOLOGY PASSED (2 governing + 36 BV skills, 6 SOPs); STATIC GAME CLEAN (24 ok / 0
  fail, no game/ changes).
- **GAME IMPLEMENTATION STARTED: NO.**
- **game/ files changed: NO.**
- **commit made: NO.**

**Fleet status:** 2 governing + 36 BV skills + 6 SOPs (unchanged from D026).

---

**D024 COMPLETE — STOPPED, AWAITING APPROVAL.**

The dynamic-world layer is now frozen. The island is alive, persistent, and responsive — without becoming
a sim monster. The world changes because the player changed it, and it remembers.