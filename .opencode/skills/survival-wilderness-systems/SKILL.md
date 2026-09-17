---
name: survival-wilderness-systems
description: Bounded Alaska wilderness/survival systems — cold, wetness, fatigue, injury, shelter, hunting, fishing, navigation, weather, wildlife. Survival creates DECISIONS, not constant meter maintenance. Built on the same signature/weather data as stealth and graphics. Load when implementing or tuning survival/environment gameplay.
---

# SURVIVAL AND WILDERNESS SYSTEMS (BV-SKILL-017)

## NAME
SURVIVAL AND WILDERNESS SYSTEMS

## PURPOSE
Deliver the Alaska wilderness as a gameplay domain (doctrine §30, BV-D018) with BOUNDED systems — cold, wetness, fatigue, injury, shelter, hunting, fishing, navigation, weather, wildlife — that create DECISIONS rather than constant meter maintenance. Alaska is not backdrop and not survival-busywork. The survival layer speaks the same weather/signature data as stealth (BV-SKILL-007), graphics (BV-SKILL-014), and the environment (BV-SKILL-006) — one authored truth, many consumers.

## WHEN TO LOAD
- Implementing/tuning cold/wetness/fatigue/injury, shelter, hunting, fishing, navigation, weather, or wildlife.
- Any work where the wild is a pressure (travel, resting, exposure decisions).

## DO NOT LOAD WHEN
- Stealth sensing/emission internals (BV-SKILL-007/008) — though this skill consumes and feeds them.
- Weapon internals (BV-SKILL-011) — hunting tools are survival objects used by this skill's economy.

## PRECONDITIONS
- Governing set loaded.
- Weather-state model exists or is being designed alongside (BV-SKILL-014 + this skill share the same global weather state).
- Signature emission contract (BV-SKILL-007) — survival state feeds MOVEMENT/ENVIRONMENTAL channels (shivering noise, slowed motion, thermal state).
- Affordance tags (BV-SKILL-006) provide SHELTER/HAZARD/cover surfaces.

## GOVERNING INVARIANTS
1. DECISIONS, NOT METERS: survival is a bounded set of interacting systems that produce meaningful choices (rest vs travel; burn fuel vs conserve; hunt vs fish vs shelter). Any "constant-meter-watch" pattern is a scope violation (doctrine §30, BV-D018).
2. BOUNDED SYSTEMS: a fixed list — cold, wetness, fatigue, injury, shelter, hunting, fishing, navigation, weather, wildlife. Fewer, deeper; no onboarding of parallel survival mini-games.
3. ONE WEATHER TRUTH: storm/snow/cold state is authored once (BV-SKILL-014) and consumed by survival, stealth, graphics, and navigation. Never three parallel copies of "weather."
4. SIGNATURE-TIED: shivering (cold), slowed movement (fatigue), water-soaked clothing (wetness) emit through the SAME channel system as everything else (BV-SKILL-007) — survival choices are stealth choices, with both costs and benefits (a storm hides noise AND empties navigation).
5. WILDLIFE IS CREDIBLE: regional, bounded animal behavior (hunting me, hunting itself, fleeing) — never endlessly-spawning monsters with telepathic sight (doctrine §30; sensing contract from BV-SKILL-008).
6. INJURY IS CONSEQUENCE: injury is a causal effect of the world (falls, attacks, cold exposure), not a periodic tax; treatment is decision-rich (improvise vs shelter vs seek the ally's support, doctrine §26).
7. NAVIGATION IS DIEGETIC: landmarks, weather, terrain reading — not GPS crumb trails. Navigation ties to the world-as-interface principle (doctrine §5).
8. SCOPE-HONEST: a survival system that cannot be made simulation-cheap and legible is cut, not shipped opaque (doctrine §11).

## WORKFLOW
1. Read current weather/survival handling in current form; confirm decision-architecture (not meters).
2. Define the bounded system set and their single-sourced data (cold/wetness curves, weather presets, wildlife archetypes).
3. Build the shared weather-state first (BV-SKILL-014 alignment) as THE source other systems read.
4. Implement each survival system as a bounded consumer of that state, wired to signature emission.
5. Fixture-verify decisions: each state pair-crisis must have two+ viable answers with real differences.
6. Static verify; behavioral/device verify when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Model cold/wetness/fatigue as slow-moving coupled curves, not instant percentages with ticking drains; the pain is in DECISION points (fire vs dark hole vs pushed travel), not in watching bars.
- Shelter is the decision hub: a warm shelter resets exposure, but uses fuel/time and may expose the player (signature) or consume a day (navigation/time loop).
- Hunting/fishing: bounded spawn-of-record behavior (signed, seeded), realistic payoff, and always a tradeoff (noise, time, weather) — never an arcade drop farm.
- Weather presets (calm, snow, storm) are authored global states with per-consequence tables (visibility, noise floor, warmth loss, drift risk) — sim-cheap.
- Injury is event-caused and layered on the same signature/consequence model (a leg wound slows movement → louder, slower → survival pressure).
- Wildlife uses the sensing contract: archetype senses (scent/sound/vision) bounded, no world-telepathy.
- Keep the whole layer DEBUGGABLE (BV-SKILL-015): exposure curves, weather state, animal states visible in overlay.

## ANTI-PATTERNS
- Ten parallel health/hunger/thirst/cold bars ticking constantly (meter-busywork, doctrine §30).
- Weather operating as its own mini-game with a separate "storm meter."
- Wildlife that spawns on a respawn timer like loot or patrols with guaranteed X-in-area bait (doctrine §30).
- Survival decoupled from stealth (cold shivers with no signature consequence, doctrine §6).
- Non-diagetic minimap directions replacing landmark navigation.
- Survival systems that spiral into a full economy sim (scope doctrine §11).

## KNOWN FAILURE MODES
- Decision collapse: one option strictly dominates (shelter always wins) — fixture-verify pair-crises and rebalance costs.
- Cold/wetness curve drift making death-perfectly-prey outcomes feel random → deterministic curves with device-validated pacing.
- Weather states desyncing between survival/graphics/stealth consumers → single-owner weather state (SOP-003 relationship rule).
- Wildlife overpopulating or vanishing from save state → wildlife is save-state data with bounded signed behavior.

## VERIFICATION
- Static: bounded system list; weather single-sourced; signature hookups present; no meter-spam UI; wildlife archetypes bounded and seeded.
- Behavioral (when authorized): pair-crisis fixtures (shelter vs travel vs fire) produce ≥2 distinct viable outcomes; storm raises noise floor AND emissive cost; cold shiver raises movement/audio signature; injury slows locomotion and is treatable by ≥1 decision path.

## STOP CONDITIONS
If survival becomes meter-watching, weather splits into parallel copies, or any system silently outgrows the bounded list — stop and re-scope (doctrine §30/§11) before it grows.

## PERFORMANCE
- Survival is event-sampled + slow coupled curves; weather is global state propagated by read, not per-object sim (SOP-004).

## DEVICE
- Tablet: curve pacing and overlap with touch input (long-rest prompts), weather FX budget measured on device (BV-SKILL-014).

## RELATED SKILLS
- BV-SKILL-014 mobile-graphics-atmosphere (weather SHARED state)
- BV-SKILL-007 stealth-and-concealment (signature coupling)
- BV-SKILL-006 environmental-affordances (SHELTER/HAZARD surfaces)
- BV-SKILL-011 weapon-handling-ballistics (hunting tools, ammo scarcity)
- BV-SKILL-008 tactical-ai-perception (wildlife bounded sensing)
- BV-SKILL-020 facility-and-ally-support (base/heal/support recovery)
- BV-SKILL-029 simse-island-systems (island-system law: weather/storms/infrastructure/world-state that survival reads)
- SOP-004 mobile-performance; SOP-006 debug-observability; developers-way (governing)