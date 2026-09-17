---
name: visual-presentation-architecture
description: Reusable design procedure for visual production, HUD, and presentation systems — camera system methodology (3P shoulder + FP body-presence + transitions + weather/injury effects), helmet/visor three-layer methodology (passive/tactical/anomalous + hardware identity), HUD-as-equipment ownership philosophy + per-surface ownership table, signature-moment methodology + catalog-extension discipline, animation-priority tiering for production ordering, tablet-performance law for visual production. Pure methodology: NO per-character or per-campaign canon lives here (canon lives in the bible + doctrine). Load when designing any camera system, helmet/visor system, HUD-as-equipment ownership layer, signature-moment catalog, animation-priority tier set, or visual-production tablet-feasibility law.
---

# VISUAL PRESENTATION ARCHITECTURE (BV-SKILL-032)

## NAME
VISUAL PRESENTATION ARCHITECTURE

## PURPOSE
Own the REUSABLE design procedure for visual production, HUD, and presentation systems. This is METHODOLOGY,
not canon — it tells future directives how to design a camera system, a helmet/visor system, a HUD-as-equipment
ownership layer, a signature-moment catalog, an animation-priority tier set, and a tablet-performance law for
visual production. It does not state what a specific character sees on a specific visor in a specific campaign;
those statements live in the per-character bible (e.g.
`docs/design/VISUAL_PRODUCTION_HUD_PRESENTATION_BIBLE.md`) and in doctrine (BV-D### rows). This separation
keeps the skill fleet from collapsing into duplicated lore.

## WHEN TO LOAD
- Designing or extending any camera system (3P / FP / transitions / weather effects / injury effects).
- Designing a helmet / visor three-layer system or hardware identity.
- Designing or extending a HUD-as-equipment ownership layer (wrist device, helmet passive, world HUD).
- Authoring a signature-moment catalog or signature-moment production principles.
- Setting animation-priority tiers for production ordering.
- Setting a tablet-performance law for visual / HUD / presentation layers.

## DO NOT LOAD WHEN
- Implementing equipment visual language (BV-SKILL-022 owns armor/weapons/gear silhouette).
- Implementing persistent character-state channels or animation-evolution ladder (BV-SKILL-031 methodology
  owns channels, body-presence; D019 §14 animation priorities are a per-character overlay this skill does
  not duplicate).
- Implementing weather state machine or shared atmospheric state (BV-SKILL-014 owns SHARED weather state
  / lighting / LOD / atmosphere).
- Implementing observability contract (BV-SKILL-015).
- Designing world-systems substrate (BV-SKILL-029).
- Per-character visual canon, per-campaign HUD layout, or per-scene moment authoring — those live in the
  per-character bible and in doctrine.

## PRECONDITIONS
- Governing set loaded.
- Existing doctrine read: §5 (Environment), §6 (Stealth), §9 (Weapon Doctrine), §10 (Platform/Renderer —
  GL Compatibility, Android-tablet first), §29 (Opening Structure), §34 (Narrative Pillars), §41 /
  §41.1-§41.16 (Visual & Equipment Doctrine — BV-D042..D052), §41.11 (Wear/Damage states).
- D004 §10 edge-device budget (Android/tablet target; GL Compatibility; <1,200 active nodes per sector;
  baked lightmaps + 1 directional + fog; ~200–260 MB working set).
- D010 / D015 §45 / D016 §41-§45 / D017 §10-§53 / D018 §10-§39 all current.
- Existing skills read: 022 (equipment visual), 031 (persistent-state methodology), 014 (graphics/
  atmosphere), 028 (prologue), 029 (world-systems), 015 (observability).
- Existing per-character bible (the canonical Season-1 example is `docs/design/VISUAL_PRODUCTION_HUD_PRESENTATION_BIBLE.md`)
  read so methodology does not duplicate per-canon limits.

## GOVERNING INVARIANTS
1. METHODOLOGY ONLY: this skill defines HOW to design a visual production / HUD / presentation layer; it
   does not state what a specific character sees on a specific visor at a specific campaign point. Per-
   character/per-campaign canon lives in the per-character bible and in doctrine. A future directive that
   wants to amend a character's visual layer does not edit this skill.
2. HUD-AS-EQUIPMENT LAW: the HUD exists because the character has EQUIPMENT, not because the player needs
   a videogame overlay. Every HUD element must trace to equipment the character is wearing (D019 §5).
3. NO MMO METER / NO FLOATING NUMBERS / NO HAPPY-GAUGE: forbidden in any visual production layer (doctrine
   §36.1; D015 §45; D016 §45; D019 §6).
4. CAMERA MUST PRESERVE BODY-PRESENCE: FP camera is NEVER an invisible floating lens; the body is the
   medium of feedback (doctrine §36.4 diegetic-first; D017 §37; D019 §3.2).
5. HELMET/VISOR NEVER A WALLHACK: passive = diegetic readings; tactical = opt-in with signature cost;
   anomalous = late, authored, budget-controlled (D011 §7 truthful sensing; D016 §20 intent sensitivity;
   D019 §4).
6. SIGNATURE-MOMENT METHODOLOGY: identity moments must be RECOGNIZABLE in five seconds (D019 §2 / §15);
   AUTHORED; tied to doctrine §34 pillars; not skippable for performance.
7. ANIMATION-PRIORITY TIERS: production ordering is BOUNDED (Tier 1 movement/weapons/stealth/injury/
   climbing/interaction; Tier 2 grooming/equipment adjustments/environmental actions; Tier 3 rare cinematic
   states). Tablet budget respects the tiering.
8. TABLET-PERFORMANCE LAW: every visual system must have SCALABILITY, FALLBACK STATE, LOW-COST
   REPRESENTATION; preferred techniques include shader/material parameters, masks + decals, state-driven
   swaps, animation layer blending, pooled effects, authored triggers, bounded lighting/draw calls/LOD,
   coarse off-screen simulation (D019 §16; D004 §10; D015 §28; D017 §50).
9. NO FUTURE-SAGA CONTAMINATION: designing for the current saga must not import future-saga material into
   the current canon. Defer with CANDIDATE flags; do not promote.
10. NO COSMETIC CASH-SHOP LOGIC: rarity colors, cosmetic loot showers, disconnected costumes, immersion-
    breaking skins are forbidden (D017 §42; D019 §8.6).
11. CHARACTER IDENTITY PROTECTION: visual layer shapes PRESENTATION and EVOLUTION, not face identity,
    tattoos, core body identity, established scars, narrative history (D017 §54; D019 §8.6).
12. ACCESSIBILITY OVERRIDES REQUIRED: hair obstruction · heavy visual injury effects · excessive tremor ·
    camera interference · grime/blood overlays all have EXPRESSION toggles (D017 §53; D019 §3 weather shake
    override aligned).
13. OBSERVABILITY: every visual system must declare the debug surfaces it will need (state, last change
    reason, performance budget consumption, accessibility toggle state) so SOP-006 / BV-SKILL-015 contracts
    are honored at implementation time.
14. COMPOSITION DISCIPLINE: this skill composes with BV-SKILL-022 (equipment visual), 031 (persistent-state
    methodology), 014 (graphics/atmosphere), 028 (prologue visual reference), 029 (world-systems), 015
    (observability). It does not duplicate any of them; it does not replace any of them.

## WORKFLOW
1. Read the per-character / per-campaign bible to confirm the visual production / HUD / presentation
   layer's canonical scope; confirm no design will duplicate canon.
2. Define the CAMERA SYSTEM: 3P shoulder behavior + FP body-presence + aiming transition + stealth camera
   + injury camera + weather camera effects. Confirm FP body-presence per D017 §37.
3. Define the HELMET / VISOR three-layer system: passive (always-on, diegetic readings) + tactical (opt-in,
   signature cost) + anomalous (late, authored, budget-controlled). Confirm hardware identity (worn /
   repaired / dirty / cracked). Confirm NEVER a wallhack.
4. Define the HUD-AS-EQUIPMENT OWNERSHIP PHILOSOPHY: wrist device / helmet passive / world HUD mapping.
   Every surface traces to equipment. Confirm no MMO meter / no floating numbers / no happy-gauge.
5. Define the SURVIVAL HUD presentation rules per state variable (CONDITION / CORE TEMP / EXERTION /
   CONTROL / NEURAL STRAIN). Provide a small bounded set of diegetic cues per variable. The overlay
   confirms; the body communicates.
6. Define the CHARACTER VISUAL EVOLUTION ladder (5-stage arc to visual evolution; D017 §35-§36). Confirm
   the ladder is STAGE-SHIFT, not ambient drift.
7. Define the CLOTHING / ARMOR / WEAPON VISUAL LANGUAGE: material rules, layering, repair visibility,
   weather effects, armor progression phases, customization boundaries. Confirm BV-SKILL-022 ownership.
8. Define the GROOMING PRESENTATION: hair states, beard states, washing, shaving, injury inspection,
   mirror interactions. Confirm grooming = CHARACTERIZATION, not a stat.
9. Define the ENVIRONMENT VISUAL BIBLE per facility (F1 / F2 / F3 / F4 / F5): identity contract + visual
   reads. Confirm per-facility IDENTITY is frozen; visual specifics are CANDIDATE per scene-authoring.
10. Define the WEATHER PRESENTATION per state: lighting, sound, particle, traversal feel. Confirm weather-
    as-punctuation role (D018 §20).
11. Define the HORROR PRESENTATION language: uncertainty, environmental evidence, sound, memory bleed,
    human cruelty, impossible moments. Confirm Suffering + Silent Hill + grounded military thriller
    reference tone. Confirm fairness law (D015 §30).
12. Define the SOUND LANGUAGE per channel: environment, combat, anomaly. Confirm shared truth with stealth
    + horror (D015 §43). Confirm audio contamination discipline (D015 §44).
13. Define the ANIMATION-PRIORITY TIERS: Tier 1 / Tier 2 / Tier 3 production ordering. Confirm tablet budget
    respects the tiering.
14. Define the SIGNATURE-MOMENT CATALOG + production principles: identity-moment catalog (5-second
    recognizable; authored; tied to pillars; not skippable for performance).
15. Define the TABLET-PERFORMANCE LAW for visual production: scalability, fallback state, low-cost
    representation. Confirm D004 §10 budgets preserved; D015 §28 off-screen model; D017 §50 architecture.
16. Validate against: HUD-AS-EQUIPMENT; NO MMO METER; CAMERA BODY-PRESENCE; NO WALLHACK; NO CASH-SHOP;
    CHARACTER IDENTITY PROTECTION; TABLET FEASIBILITY; NO FUTURE-SAGA CONTAMINATION; ACCESSIBILITY
    OVERRIDES; OBSERVABILITY.

## IMPLEMENTATION GUIDANCE
- For CAMERA: 3P default is shoulder offset (not behind-back only). FP is a held window for precision /
  psychological moments; FP camera must render hands / sleeves / gloves / hair / breath / dirt / blood /
  equipment.
- For HELMET/VISOR: passive layer is FREE diegetic readings. Tactical layer activation is a SIGNATURE
  event (lighting / audio / brief visual feedback). Anomalous layer is authored per true-unknown /
  horror-event scope.
- For HUD: each surface (wrist / helmet / world) maps to a piece of equipment. Wrist device is a worn /
  repaired piece of gear. World HUD is the world.
- For STATE VARIABLES: each carries a small bounded set of diegetic cues (animation, audio, peripheral
  effect, wrist-device warning). The overlay CONFIRMS; the body COMMUNICATES.
- For ANIMATION-EVOLUTION LADDER: state shifts are AUTHORED events (a moment, a beat, a chapter), not
  ambient drift.
- For SIGNATURE MOMENTS: each is RECOGNIZABLE in five seconds; each is AUTHORED; each has a CLEAR visual
  / audio signature; not skippable for performance.
- For TABLET: prefer shader/material parameters, masks + decals, state-driven swaps, animation layer
  blending, pooled effects, authored triggers, bounded lighting/draw calls/LOD, coarse off-screen
  simulation.

## ANTI-PATTERNS
- Re-stating per-character / per-campaign canon inside this skill (creates duplicated lore).
- MMO meters / floating numbers / happy-gauges (forbidden).
- HUD that exists because the player needs a videogame overlay (must trace to equipment).
- FP camera as invisible floating lens.
- Helmet/visor wallhack (omniscient enemy outlines, through-wall perception, guaranteed future knowledge).
- Cinematic-only effects that cannot run interactively.
- Per-frame "spooky passes" or any per-frame visual pass without authored trigger.
- Rarity colors, cosmetic loot showers, disconnected costumes, immersion-breaking skins.
- Per-character content in the skill (the lore-duplication anti-pattern).
- Future-saga material imported into Season-1 canon (the contamination anti-pattern).
- Player customization that erases face identity, tattoos, core body identity, established scars, or
  narrative history (the character-erasure anti-pattern).
- Generic apocalypse aesthetics (zombie shooter / generic horror tropes).

## KNOWN FAILURE MODES
- Camera drift to cinematic-only: pair every camera effect with a STATE-OWNED TRIGGER and a LOW-COST
  FALLBACK.
- HUD drift to MMO meters: pair every HUD surface with an EQUIPMENT TRACE.
- Animation volume blow-up: enforce the Tier 1 / 2 / 3 priority ordering + tablet budget.
- Tablet performance blow-up: enforce the §16.1-§16.4 architecture.
- Signature moments drifting to "atmospheric": enforce the 5-second recognizable test + AUTHORED trigger.
- Lore duplication: per-character HUD/camera/signature details in the skill instead of the bible — strip
  and reference.

## VERIFICATION
- Static: camera system declared (3P + FP + transitions + per-state effects); helmet/visor three-layer
  system declared with hardware identity; HUD-as-equipment ownership table complete; survival HUD
  presentation rules per variable with small bounded diegetic cues; character visual evolution ladder
  mapped to reclamation stages; clothing/armor/weapon visual language with BV-SKILL-022 ownership; grooming
  presentation system with mirror-moment discipline; environment visual bible per facility with IDENTITY
  contract frozen; weather per-state presentation; horror presentation language; sound language per
  channel; animation priority tiers declared; signature-moment catalog with 5-second recognizable test;
  tablet-performance law per §16.1-§16.4; no per-character canon in the skill.
- Cross-skill: no parallel visual-language, persistent-state, equipment, weather, world-system, or
  observability systems invented; existing owners consumed.
- Tooling: run `tools/validate_methodology.py` and `tests/static_verify_game.py` after any canon change.
  Per-character bible's contradiction ledger should remain at zero contradictions.

## STOP CONDITIONS
If a designed visual production / HUD / presentation system relies on MMO meters / floating numbers / happy-
gauges, ignores body-presence, becomes a wallhack, becomes tablet-implausible, erases authored character
identity, imports future-saga material, or duplicates per-character canon inside this skill — stop and re-
anchor to this skill's invariants and the per-character bible.

## RELATED SKILLS
- BV-SKILL-022 visual-equipment-doctrine (equipment visual language; this skill composes for the visual
  production layer but does not duplicate)
- BV-SKILL-031 persistent-character-state-architecture (state channels + animation-evolution methodology;
  this skill composes for body-presence and animation-evolution but does not duplicate)
- BV-SKILL-014 mobile-graphics-atmosphere (weather SHARED state / lighting / LOD / atmosphere / VFX budget;
  this skill composes for atmosphere but does not duplicate)
- BV-SKILL-028 prologue-narrative-architecture (opening visual reference)
- BV-SKILL-029 simse-island-systems (world-systems substrate for visual systems)
- BV-SKILL-018 psychological-horror-perceptual-events (horror authoring contract)
- BV-SKILL-015 gameplay-debugging-instrumentation (observability surfaces; SOP-006)
- D019 canonical bible = `docs/design/VISUAL_PRODUCTION_HUD_PRESENTATION_BIBLE.md`
- developers-way, black-vector-project-doctrine (governing)
- BV-SKILL-035 operator-discipline-architecture (D025 — physical character evolution visual transitions + weapon visual history + animation priority Tier 1 compose with visual-presentation methodology; this skill retains visual production ownership; composition); SOP-005/006
- BV-SKILL-036 touchscreen-input-architecture (D026 — input layer is NOT the HUD; mastery dissolves the touch layer via opacity; this skill retains HUD-as-equipment + camera methodology; composition)