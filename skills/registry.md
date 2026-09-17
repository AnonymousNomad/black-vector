# BLACK VECTOR — SKILL REGISTRY

> Routing index: **task → skill(s)** and **skill number → slug**.
> The registry is the agent's map for choosing which domain skills to load for a directive. It does not override
> the load-order rule: the governing set (Developer's Way, Project Doctrine, Verify-First, Scope/Authority,
> Gameplay System Verification) is ALWAYS loaded before any domain skill.

## Governing Set (always loaded, in this order)

1. `developers-way` (doctrine/DEVELOPERS_WAY.md canon)
2. `black-vector-project-doctrine` (doctrine/BLACK_VECTOR_DOCTRINE.md canon) — see note below
3. SOP-001 Verify-First (`sop/verify-first.md`)
4. SOP-002 Scope & Authority (`sop/scope-authority.md`)
5. SOP-005 Gameplay System Verification (`sop/gameplay-verification.md`)

Then task-relevant domain skills only. SOP-003, SOP-004, SOP-006 load on demand per task type
(Godot changes / performance work / debugging).

> NOTE: the doctrine canon lives in `doctrine/BLACK_VECTOR_DOCTRINE.md`, mirrored by the framework skill
> `black-vector-project-doctrine` (always loaded with the governing set). The registry below maps tasks to the
> domain skills.

## BV-SKILL Inventory (BV-SKILL-001..036)

| # | Slug | Name | Load when working on |
|---|------|------|----------------------|
| BV-SKILL-001 | `godot-android-edge` | Godot Android Edge Development | On-device tooling, GABE exports, renderer/editor constraints, Android packaging |
| BV-SKILL-002 | `scene-composition` | Scene Composition | Scene trees, node structure, prefab/scene instancing, organization, relationships |
| BV-SKILL-003 | `third-person-character-controller` | Third-Person Character Controller | Player character movement, CharacterBody3D, camera rig, input handoff |
| BV-SKILL-004 | `stance-system` | Stance System | Stand/crouch/prone/sprint locomotion states, movement signature |
| BV-SKILL-005 | `systemic-traversal` | Systemic Traversal | Climb, mantle, ledge, tree-climb arc (future), traversal affordances, movement budget |
| BV-SKILL-006 | `environmental-affordances` | Environmental Affordances | Terrain-as-gameplay surfaces, interactive world props, one-world composability |
| BV-SKILL-007 | `stealth-and-concealment` | Stealth and Concealment | Multi-channel signature reduction, cover/concealment/illumination/movement-sound surfaces, NO hidden=true |
| BV-SKILL-008 | `tactical-ai-perception` | Tactical AI Perception | Bounded, simulation-cheap, non-omniscient sensory AI; suspicion; last-known-position; knowledge-with-source |
| BV-SKILL-009 | `contextual-assassination` | Contextual Assassination | Assassination vs combat states; contextual drop assassination (future); positioning → opportunity |
| BV-SKILL-010 | `close-combat-exchange` | Deflection and Close-Combat Exchange | READ→ENGAGE→EXCHANGE→…→FINISH/ESCAPE state vocabulary; deflection/counter/evade |
| BV-SKILL-011 | `weapon-handling-ballistics` | Weapon Handling and Game Ballistics | Weapons-as-tools tradeoffs, handling/ballistics, sidearm lock, signature (report) |
| BV-SKILL-012 | `diegetic-memory-progression` | Diegetic Memory Progression | EXPERIENCE→TRIGGER→MEMORY→RECOGNITION→CAPABILITY RESTORED; no XP |
| BV-SKILL-013 | `large-world-sector-architecture` | Large-World Sector Architecture | One-world sectoring, loading discipline, streaming OUT of scope (no implementation now) |
| BV-SKILL-014 | `mobile-graphics-atmosphere` | Mobile Graphics and Atmosphere | Renderer contracts, baked lighting, LOD, draw-call/transparency discipline, atmosphere and presentation on tablet |
| BV-SKILL-015 | `gameplay-debugging-instrumentation` | Gameplay Debugging and State Instrumentation | Observability, debug overlay, transition-reason logging, reproducibility |
| BV-SKILL-016 | `vertical-slice-discipline` | Vertical-Slice Discipline | Scoping a playable slice, fortune through depth over breadth, QA criteria for a slice |
| BV-SKILL-017 | `survival-wilderness-systems` | Survival and Wilderness Systems | Cold, wetness, fatigue, injury, shelter, hunting, fishing, navigation, weather, wildlife; bounded decision-driven survival |
| BV-SKILL-018 | `psychological-horror-perceptual-events` | Psychological Horror and Perceptual Events | Three threat classes (HUMAN/EXPERIMENTAL/PARANORMAL), ambiguity-by-design, hallucination/perceptual events, no routine paranormal bestiary |
| BV-SKILL-019 | `psionic-gameplay-neural-load` | Psionic Gameplay and Neural Load | Capability list that MULTIPLIES (never replaces) existing skills; neural-load pipeline ACTION→LOAD→PAIN/DISTORTION→VULNERABILITY→EVENT; no mana bar |
| BV-SKILL-020 | `facility-and-ally-support` | Facility and Ally Support | ~5 curated restorable facilities (DISCOVER→…→IMPROVE), no freeform building; base-anchored ally capabilities, no follower/aura |
| BV-SKILL-021 | `cqc-combat-architecture` | Close-Quarters Combat Architecture | Frozen CQC architecture: battle-state CONTACT model + SPATIAL ranges, Control & Neural Strain (2×2), rage, reclamation gating, Compound vs independent path, TK-in-CQC boundaries, minimal injury/stamina/posture scope, AI-facing combat interfaces, CQC input/observability |
| BV-SKILL-022 | `visual-equipment-doctrine` | Visual and Equipment Doctrine | Frozen armor/equipment visual language (Directive 010/doctrine §41): military-first hierarchy, Shade baseline + tiers + companion evolution, role families, digital-camo/soft-suit, cybernetic augmentation limits, faction separation, Alaska serviceability, wear/damage spectrum, tech ladder T0–T4, color/material discipline, originality boundary |
| BV-SKILL-023 | `historical-provenance-research` | Historical Provenance Research | Real-history research gate: source hierarchy, DOCUMENTED/DISPUTED/FICTIONALIZED-DERIVATION/PURE-FICTION classification, archive workflow, institutional-absorption + folding + records-destruction patterns, Black Hand/Compound/Shade provenance chains. Load for ANY history/timeline/program/lineage work before a fact enters canon |
| BV-SKILL-024 | `alaska-site-environment-reference` | Alaska Site and Environment Reference | Real Alaska installation templates (neck-airfield, troposcatter ridge, berth-isthmus, company town, cannery/bush airstrip), layout→fiction transformation rules, seasonal logistics clock, anti-misrepresentation (BV-D012). Load for any site/installation/sector-base/cold-logistics design |
| BV-SKILL-025 | `weapon-platform-role-design` | Weapon Platform and Role Design | Role-first weapon families + provenance ecology (who kept what and why), island serviceability, faction identity, underrepresented-real traditions (bullpup/roller-delayed/Czech/scout), Hand marksman kit (skill not superhuman), networked rifle stays fiction; zero actionable content. Design-layer owner of the D013 weapon/rifle bible (BV-D064–D070) |
| BV-SKILL-026 | `anomalous-consciousness-research` | Anomalous Consciousness Research | Real anomalous-intelligence program family (STAR GATE cluster, Gateway, Soviet assessments): existence≠capability, official negative conclusion = known world, handoff to the single labeled divergence; rarity/bounds law, no growth-curve powers |
| BV-SKILL-027 | `island-population-threat-ecology` | Island Population and Threat Ecology | Canonical Simse Sound ecology bible (Directive 011, BV-D059-BV-D063): population family contracts, military roles, Black Hand security ladder, Shade network information-truth model (no omniscience), doctors/scientists, prisoners/subjects, experimental human lines, cybernetic subjects, Hidden Hand survivor framework, civilians/community archetypes, contractors, wildlife, paranormal taxonomy, regional distribution, relationship model, compositional NPC architecture, horror rarity budget, boss doctrine. Load for ANY population/enemy/faction/Shade/experiment/NPC-authoring work |
| BV-SKILL-028 | `prologue-narrative-architecture` | Prologue Narrative Architecture | Canonical opening structure (Directive 014, icon→brother→fractured-veteran→killer→prisoner→subject→survivor): Layered Overwatch peak loop (primary/remote support/drone/fused picture + attention limit), gameplay-vs-cinematic ownership allocation (FULLY/LIMITED/INTERACTIVE/NONINTERACTIVE), player-information gating across the fall (knowledge-gate table), prologue pacing, replay-mode law, observability precedence. Load for ANY work on the opening experience, the fall-from-grace through-line, or knowledge-boundary design in the first hour |
| BV-SKILL-029 | `simse-island-systems` | Simse Sound Island Systems | Canonical systemic-island law (Directive 015, BV-D079-BV-D086): the four overlapping islands, consequential world interaction, infrastructure consequence law + bounded interaction classes, electrical abstraction/power priority, bounded event-driven world-state propagation, lightweight community state + liability law, the five-facility systemic anchors (F1..F5) as a restoration network, edge-device off-screen coarse model, and survival-HUD information ownership. Load for ANY world-system / infrastructure / propagation / community / facility-network / survival-HUD ownership work |
| BV-SKILL-030 | `anomalous-capability-architecture` | Anomalous Capability Architecture | Reusable anomalous-capability design procedure (Directive 016, BV-D087-BV-D095): METHODOLOGY ONLY — no per-character or per-campaign canon lives here (canon lives in `docs/design/ANOMALOUS_CAPABILITY_BIBLE.md` + doctrine). Owns the procedure for mass/range/complexity bounding, discovery/acquisition progression, capability ceiling design, superhero-prevention matrices, path persistence/switching, presentation/failure integration, cross-system integration rules, observability requirements. Load when designing any anomalous/power/psi capability system or reconciling a capability against the prevention matrix |
| BV-SKILL-031 | `persistent-character-state-architecture` | Persistent Character-State Architecture | Reusable persistent-character-state and reclamation-progression design procedure (Directive 017, BV-D096-BV-D104): METHODOLOGY ONLY — no per-character or per-campaign canon lives here (canon lives in `docs/design/PLAYER_RECLAMATION_PERSISTENT_CHARACTER_STATE_BIBLE.md` + doctrine). Owns the procedure for reclamation stages, persistent visual-state channels, persistence law, visible-state→consequence→response, grooming system, quick-radial, base-grooming facilities, clothing/armor/weapon progression shapes, animation-evolution ladder, body-presence methodology, tablet-feasible persistent-state architecture, save-data shape, accessibility overrides, observability requirements. Load when designing any reclamation arc or persistent visual-state system |
| BV-SKILL-032 | `visual-presentation-architecture` | Visual Presentation Architecture | Reusable visual production / HUD / presentation design procedure (Directive 019, BV-D114-BV-D122): METHODOLOGY ONLY — no per-character or per-campaign canon lives here (canon lives in `docs/design/VISUAL_PRODUCTION_HUD_PRESENTATION_BIBLE.md` + doctrine). Owns the procedure for camera system (3P shoulder + FP body-presence + transitions + weather/injury effects), helmet/visor three-layer methodology (passive/tactical/anomalous + hardware identity), HUD-as-equipment ownership philosophy + per-surface ownership table, signature-moment methodology + catalog-extension discipline, animation-priority tiering for production ordering, tablet-performance law for visual production. Load when designing any camera system, helmet/visor system, HUD-as-equipment layer, signature-moment catalog, or visual-production tablet-feasibility law |
| BV-SKILL-033 | `enemy-architecture` | Enemy Architecture | Reusable AI / faction / enemy architecture design procedure (Directive 022, BV-D125): METHODOLOGY ONLY — no per-character or per-campaign canon lives here (canon lives in `docs/design/AI_FACTION_ENEMY_ARCHITECTURE_BIBLE.md` + doctrine). Owns the procedure for per-faction profile design (goals / resources / leadership / tactics / equipment / morale / weaknesses), AI perception state machine (UNAWARE → SUSPICIOUS → SEARCHING → TRACKING → ENGAGED → LOSING CONTACT → RETREATING), squad behavior (communication / radio dependency / command structure / panic when leaders die / fallback / mistakes), per-role archetype design (frightened survivor / desperate scavenger / disciplined security operator / tracker / sniper / medic / engineer / commander), Black Hand / Shade distinction (information / coordination / sensory integration / discipline — NOT armor / damage), boss philosophy (unique people / unique situations / history / preparation / consequences — no health bars / no bullet sponges / no arena fights), wildlife / human / threat ecology interaction, slice enemy package (INCLUDED / EXCLUDED). Load when designing any enemy / faction / squad / perception / archetype / boss / wildlife-interaction system |
| BV-SKILL-034 | `companion-relationship-architecture` | Companion Relationship Architecture | Reusable companion / relationship / Shade reclamation architecture design procedure (Directive 023, BV-D126): METHODOLOGY ONLY — no per-character or per-campaign canon lives here (canon lives in `docs/design/COMPANION_RELATIONSHIP_SHADE_RECLAMATION_BIBLE.md` + doctrine BV-D126 + D023 §2 canon correction in BV-D127). Owns the procedure for Companion Shade architecture (control chain + visual identity + relationship progression + companion rules + psychological tone references — the Shade is a SEPARATE VICTIM of the same machine, NOT a failed version of The Hand, per BV-D127), community relationship system (survivor trust progression + relationship-index + community reactions), Second-in-Command bond architecture, Hand's guilt architecture, moral-consequences architecture, memory bleed integration with relationships, base relationships architecture, Companion personality evolution. Load when designing any companion / relationship / reclamation / community-bond / memory-bleed-integration / base-relationship system |
| BV-SKILL-035 | `operator-discipline-architecture` | Operator Discipline Architecture | Reusable operator identity / military discipline / combat expression design procedure (Directive 025, BV-D130): METHODOLOGY ONLY — no per-character or per-campaign canon lives here (canon lives in `docs/design/OPERATOR_IDENTITY_COMBAT_DISCIPLINE_BIBLE.md` + doctrine). Owns the procedure for operator identity philosophy (the seven advantages; the foundation; "the Hand wins fights BEFORE they begin"), military discipline architecture (the six competencies — NOT RPG classes — with four levels UNTRAINED / DEVELOPING / PROFICIENT / MASTERED), player expression model (variation through USE not class selection — three example expressions), no-XP progression (use / experience / training / mentorship / recovered memory / equipment familiarity / surviving situations / relationships), combat technique architecture (behaviors not abilities; technique examples; techniques compose; techniques integrate with foundation + anomaly), weapon relationship system (familiarity / maintenance / history / modification / emotional attachment / field adaptation — weapons tell stories and persist in the living save file), anomaly integration with competencies (recon + anomaly / sniper + anomaly / CQC + anomaly / FO + anomaly / covert + anomaly / direct action + anomaly — bounded by D016 §48 + §49; does NOT create new skills), physical character evolution (the body channel; visual transitions BROKEN PRISONER → SURVIVOR → RECOVERED OPERATOR → UNIQUE PLAYER EXPRESSION aligned with D017 §3 ladder), touchscreen action priority list (informs D026). Load when designing any operator identity / military discipline / combat expression / player expression / no-XP progression / combat technique / weapon relationship / anomaly-integration / physical-character-evolution system |
| BV-SKILL-036 | `touchscreen-input-architecture` | Touchscreen Input Architecture | Reusable touchscreen input / mobile control layout / interaction architecture design procedure (Directive 026, BV-D131): METHODOLOGY ONLY — no per-game canon lives here (canon lives in `docs/design/TOUCHSCREEN_INPUT_INTERACTION_ARCHITECTURE_BIBLE.md` + doctrine). Owns the procedure for input layer architecture (one simulation layer, different input layers; abstract action vocabulary; no layer-specific rules), touch ergonomics (two-thumb foundation; placement law; adjustable size/position/opacity; left-handed mirroring; safe areas), control-cluster budgets (minimum-set; absorption before addition), contextual action standards (one surface many meanings; context-lock; priority; diegetic prompts), gesture vocabulary design (hold / select / directional / recall / focus; discovery-gated; interruption priority), strain-vs-input-trust reconciliation, equipment access tiers (glance / radial / wheel / base; time-live field law), companion command-layer methodology (request-not-order; ≤6; person-preservation), accessibility input design (scaling / repositioning / opacity / colorblind / one-handed / controller parity / assist boundaries), hardware scaling + performance + input-profile save separation, input observability. Load when designing any input layer / touch layout / contextual action / gesture vocabulary / equipment access / companion command / mobile ergonomics system |

## Task → Skill Routing (quick index)

| Task class | Skills to load (beyond governing set) |
|------------|---------------------------------------|
| Create/edit Godot project settings or assets | godot-android-edge, scene-composition, mobile-graphics-atmosphere |
| Player movement/camera | third-person-character-controller, stance-system, systemic-traversal |
| Player body states / survival-driven locomotion | survival-wilderness-systems, third-person-character-controller (+ biomechanics of depth/fatigue) |
| Stealth / enemies / sensing | stealth-and-concealment, tactical-ai-perception |
| Assassination / combat | contextual-assassination, close-combat-exchange, weapon-handling-ballistics |
| CQC architecture / Control / Neural Strain / rage / reclamation / Compound / TK-in-CQC | cqc-combat-architecture (+ close-combat-exchange for window internals; + psionic-gameplay-neural-load for TK levers) |
| Cold/wetness survival, hunting, fishing, navigation, wildlife | survival-wilderness-systems |
| Restorable base / facility progression | facility-and-ally-support |
| Companion / ally behaviors and base support | facility-and-ally-support |
| Psionic action or capability | psionic-gameplay-neural-load |
| Neural-load consequence (pain/distortion/vulnerability) | psionic-gameplay-neural-load |
| Memory trigger / memory or capability restoration | diegetic-memory-progression |
| Paranormal / anomalous / horror events | psychological-horror-perceptual-events |
| Encounter with a former Hidden Hand member | contextual-assassination, close-combat-exchange, psychological-horror-perceptual-events |
| World-sector loading / activation | large-world-sector-architecture |
| Progression / narrative memory | diegetic-memory-progression |
| World building / one-world structure | large-world-sector-architecture, environmental-affordances |
| Performance on tablet | mobile-graphics-atmosphere, godot-android-edge (+ SOP-004) |
| Debugging a system | gameplay-debugging-instrumentation (+ SOP-006) |
| Vertical slice / milestone | vertical-slice-discipline |
| Armor / uniform / headgear / gear visual design | visual-equipment-doctrine |
| Faction or enemy-family visual identity / silhouettes / material signatures | visual-equipment-doctrine |
| Shade visual (any tier), companion Shade visual evolution | visual-equipment-doctrine |
| Translating an external/reference image into an original design | visual-equipment-doctrine (+ mobile-graphics-atmosphere when rendering is involved) |
| ANY historically-grounded claim / timeline / program / lineage / provenance work | historical-provenance-research (+ anomalous-consciousness-research for paranormal/anomalous investigation boundary; + alaska-site-environment-reference for site-derivations) |
| Site / installation / sector-base / installation logistics / cold-region architecture | alaska-site-environment-reference (+ historical-provenance-research for site back-stories; + BV-D043 sector geography) |
| Weapon family / role design / faction armament / Hand marksman kit / any gun entering canon | weapon-platform-role-design (canon = D013 bible `docs/design/WEAPON_RIFLE_FAMILY_BIBLE.md`, BV-D064–D070; + weapon-handling-ballistics for gameplay data; + visual-equipment-doctrine for silhouette) |
| Anomalous capability / consciousness-program / paranormal-science boundary / Shade network writing | anomalous-consciousness-research (+ psionic-gameplay-neural-load for player-facing mechanics; + psychological-horror-perceptual-events for rarity) |
| ANY population/enemy/faction/Shade/experiment/detainee/civilian/contractor/wildlife/regional ecology/NPC authoring | island-population-threat-ecology (+ BV-SKILL-025 for weapons, BV-SKILL-022 for visual, BV-SKILL-021 for combat, BV-SKILL-008 for sensing) |
| Opening experience / prologue / peak-mission loop / fall-from-grace / knowledge gating / first-hour pacing | prologue-narrative-architecture (+ BV-SKILL-025 for the Layered Overwatch kit, BV-SKILL-018 for atrocities/horror beats, BV-SKILL-012 for memory/photograph thread, BV-SKILL-021 for prison/control degradation, BV-SKILL-011 for the starting lock, BV-SKILL-008 for no-omniscience telemetry) |
| World/infrastructure system, power/heat/comms, propagation, community state, facility network, survival-HUD ownership | simse-island-systems (+ BV-SKILL-017 for survival internals, BV-SKILL-018 for horror cadence, BV-SKILL-020 for facility RESTORE pipeline, BV-SKILL-013 for sectors, BV-SKILL-027 for population/community) |
| Any anomalous/power/psi capability system design, capability ceiling, prevention-matrix reconciliation, capability presentation | anomalous-capability-architecture (+ BV-SKILL-019 for cost/pain/vulnerability pipeline, BV-SKILL-021 for CQC/Strain/TK-in-CQC, BV-SKILL-018 for horror authoring, BV-SKILL-022 for equipment visual, BV-SKILL-029 for world-systems integration) |
| Reclamation arc, persistent character-state system, persistent visual-state architecture, player-authored presentation, visible-state consequence design | persistent-character-state-architecture (+ BV-SKILL-022 for equipment visual, BV-SKILL-012 for memory gates, BV-SKILL-020 for facility/ally + base-as-identity anchor, BV-SKILL-028 for prologue gates, BV-SKILL-029 for world-systems, BV-SKILL-030 for anomaly methodology, BV-SKILL-018 for horror authoring) |
| Camera system, helmet/visor three-layer system, HUD-as-equipment ownership, signature-moment catalog, animation-priority tier set, visual-production tablet-feasibility | visual-presentation-architecture (+ BV-SKILL-022 for equipment visual, BV-SKILL-031 for persistent-state/body-presence, BV-SKILL-014 for graphics/atmosphere, BV-SKILL-028 for prologue visual reference, BV-SKILL-029 for world-systems, BV-SKILL-015 for observability) |
| Per-faction profile, AI perception state machine, squad behavior, per-role archetype, Black Hand / Shade distinction, boss philosophy, wildlife / human / threat ecology interaction, slice enemy package | enemy-architecture (+ BV-SKILL-008 for tactical AI sensing, BV-SKILL-021 for CQC / AI-facing interfaces, BV-SKILL-027 for population taxonomy, BV-SKILL-028 for prologue gates, BV-SKILL-029 for world-systems, BV-SKILL-015 for observability) |
| Companion Shade architecture (control chain + visual identity + relationship progression + companion rules), community relationship system, Second-in-Command bond, Hand's guilt architecture, moral consequences, memory bleed integration with relationships, base relationships, Companion personality evolution | companion-relationship-architecture (+ BV-SKILL-012 for memory progression gates, BV-SKILL-020 for facility / ally base role, BV-SKILL-021 for combat / AI-facing interfaces, BV-SKILL-027 for population / community archetypes, BV-SKILL-028 for prologue, BV-SKILL-031 for persistent-state / animation-evolution, BV-SKILL-033 for Shade control chain, BV-SKILL-015 for observability) |
| Operator identity / military discipline / combat expression / no-XP progression / combat technique / weapon relationship / anomaly-integration-with-competencies / physical character evolution / touchscreen action priority | operator-discipline-architecture (+ BV-SKILL-012 for memory progression gates / recovered memory, BV-SKILL-016 for vertical-slice discipline, BV-SKILL-019 for anomaly cost, BV-SKILL-021 for CQC architecture, BV-SKILL-028 for prologue, BV-SKILL-030 for anomaly methodology, BV-SKILL-031 for persistent state channels / animation-evolution, BV-SKILL-032 for visual production, BV-SKILL-034 for companion / relationship progression) |
| Touchscreen input / mobile control layout / contextual actions / gesture vocabulary / equipment access tiers / companion command layer / accessibility input / hardware scaling | touchscreen-input-architecture (+ BV-SKILL-003 for controller / input handoff, BV-SKILL-004 for stance state mapping, BV-SKILL-007 for stealth signature coupling, BV-SKILL-014 for mobile performance, BV-SKILL-021 for combat verbs / defensive choice, BV-SKILL-030 for anomaly gesture grammar, BV-SKILL-032 for HUD-as-equipment / presentation, BV-SKILL-034 for companion person-preservation, BV-SKILL-035 for the action priority list) |

## Quality Gate (few strong skills > many shallow skills)

Before a proposed new skill is added: ask "Does this alter execution methodology enough to justify being
independently selectable?" If no → merge into an existing skill. Target fleet: ~20 strong skills (BV-SKILL-017..020
added under Directive 003 because each changes execution methodology independently of the rest; BV-SKILL-021 added
under Directive 008 because the frozen CQC architecture/Control-Strain layer governs every combat-facing system and
is selectable on its own authority; BV-SKILL-022 added under Directive 010 because the visual/equipment doctrine
governs every character/enemy visual decision and no existing skill owned it — it merges none).
Skills must never duplicate each other; overlap is resolved by merging into the deeper skill and cross-referencing.
BV-SKILL-023..026 (added under Directive 011-R) each change EXECUTION methodology: research-before-canon
(023), site-template-to-fiction transformation (024), role-first weapon design with provenance ecology (025),
and the existence-never-equals-capability anomalous boundary (026). 023/024/025/026 merge nothing and are each
selectable on their own authority; research skills load before any fact enters canon.
BV-SKILL-027 (added under Directive 011) owns the Simse Sound population/threat-ecology layer and is the routing
gate for any NPC/enemy/encounter work; it inherits no other skill's authority — 023/024/025/026 each remain the
load for their own domain (provenance, sites, weapons, anomalous research), with 027 composing across them.
BV-SKILL-028 (added under Directive 014) owns the opening structure / gameplay-narrative contrast / player-information
gating / prologue-pacing authority because no existing skill held it; it composes the specialists (025 Layered
Overwatch kit, 018 atrocity/horror, 012 memory/photograph, 021 prison degradation, 011 starting lock, 008
no-omniscience) — it merges none and is selectable on its own authority for opening-scope work only.
BV-SKILL-029 (added under Directive 015) owns the systemic-island law (consequence law, interaction classes,
world-state propagation, community state, facility network, survival-HUD ownership) because nothing owned the
directive's stated combination — systemic survival + interactive environment + psychological horror + world-state
propagation; it composes 017/018/006/013/020/027/028 and merges none, keeping the fleet strong (few strong skills).
BV-SKILL-030 (added under Directive 016) owns the REUSABLE design procedure for anomalous capability systems
(mass/range/complexity, discovery progression, ceiling/prevention, path persistence, presentation/failure,
cross-system integration, observability) — METHODOLOGY ONLY, no per-character canon; it composes 019 (cost
pipeline), 021 (CQC/Strain), 018 (horror), 022 (equipment visual), 017/029 (world/survival), and 028 (opening
gates), and merges none. Canon lives in `docs/design/ANOMALOUS_CAPABILITY_BIBLE.md` + doctrine BV-D087–D095.
BV-SKILL-031 (added under Directive 017) owns the REUSABLE design procedure for persistent character-state
and reclamation-progression systems (reclamation stages, persistent channels, persistence law, visible-state
consequence, grooming, quick-radial, base-grooming, clothing/armor/weapon progression shapes, animation-evolution
ladder, body-presence, tablet-feasible architecture, save-data shape, accessibility overrides) — METHODOLOGY
ONLY, no per-character canon; it composes 022 (equipment visual), 012 (memory gates), 020 (facility/ally), 028
(prologue gates), 029 (world-systems), 030 (anomaly methodology), 018 (horror authoring), 015 (observability),
and merges none. Canon lives in `docs/design/PLAYER_RECLAMATION_PERSISTENT_CHARACTER_STATE_BIBLE.md` +
doctrine BV-D096–D104.
BV-SKILL-032 (added under Directive 019) owns the REUSABLE design procedure for visual production / HUD /
presentation systems (camera system methodology, helmet/visor three-layer methodology, HUD-as-equipment
ownership philosophy, signature-moment methodology, animation-priority tiering, tablet-performance law for
visual production) — METHODOLOGY ONLY, no per-character canon; it composes 022 (equipment visual), 031
(persistent-state methodology), 014 (graphics/atmosphere), 028 (prologue visual reference), 029 (world-systems),
015 (observability), and merges none. Canon lives in `docs/design/VISUAL_PRODUCTION_HUD_PRESENTATION_BIBLE.md`
+ doctrine BV-D114–D122.
BV-SKILL-033 (added under Directive 022) owns the REUSABLE design procedure for AI / faction / enemy
architecture systems (per-faction profile design, AI perception state machine, squad behavior, per-role
archetype design, Black Hand / Shade distinction, boss philosophy, wildlife / human / threat ecology
interaction, slice enemy package) — METHODOLOGY ONLY, no per-character canon; it composes 008 (tactical AI
sensing), 021 (CQC / AI-facing interfaces), 027 (population taxonomy), 028 (prologue), 029 (world-systems),
031 (persistent-state), 032 (visual-presentation), 015 (observability), and merges none. Canon lives in
`docs/design/AI_FACTION_ENEMY_ARCHITECTURE_BIBLE.md` + doctrine BV-D125.
BV-SKILL-034 (added under Directive 023) owns the REUSABLE design procedure for companion / relationship /
Shade reclamation architecture systems (Companion Shade architecture — control chain + visual identity +
relationship progression + companion rules + psychological tone, with the canon correction in BV-D127 that
the Shade is a SEPARATE VICTIM of the same machine, not a failed version of The Hand, per the user's
correction packet — this intentionally SUPERSEDES D022 §7.4-§7.5 narrow Shade framing), community
relationship system (survivor trust progression + relationship-index + community reactions), Second-in-Command
bond architecture, Hand's guilt architecture, moral-consequences architecture, memory bleed integration
with relationships, base relationships architecture, Companion personality evolution — METHODOLOGY ONLY,
no per-character canon; it composes 012 (memory progression gates), 020 (facility / ally base role),
021 (combat / AI-facing interfaces), 027 (population / community archetypes), 028 (prologue), 031
(persistent-state / animation-evolution), 033 (Shade control chain), 015 (observability), and merges none.
Canon lives in `docs/design/COMPANION_RELATIONSHIP_SHADE_RECLAMATION_BIBLE.md` + doctrine BV-D126 +
BV-D127 (Shade Reclamation Correction).
BV-SKILL-035 (added under Directive 025) owns the REUSABLE design procedure for operator identity /
military discipline / combat expression architecture systems (operator identity philosophy with the seven
advantages; military discipline architecture with the six competencies and four levels; player expression
model with three example expressions; no-XP progression with eight sources; combat technique
architecture; weapon relationship system with six dimensions; anomaly integration with competencies;
physical character evolution with body channel and visual transitions; touchscreen action priority
list informing D026) — METHODOLOGY ONLY, no per-character canon; it composes 012 (memory progression
gates / recovered memory), 016 (vertical-slice discipline), 019 (anomaly cost), 021 (CQC architecture),
028 (prologue), 030 (anomaly methodology), 031 (persistent state channels / animation-evolution), 032
(visual production), 034 (companion / relationship progression), and merges none. Canon lives in
`docs/design/OPERATOR_IDENTITY_COMBAT_DISCIPLINE_BIBLE.md` + doctrine BV-D130.
BV-SKILL-036 (added under Directive 026) owns the REUSABLE design procedure for touchscreen input /
mobile control layout / interaction architecture systems (input layer architecture with the abstraction
law; touch ergonomics with adjustable-everything; control-cluster budgets with absorption-before-addition;
contextual action standards with the context-lock law; gesture vocabulary design with discovery gating
and interruption priority; strain-vs-input-trust reconciliation; equipment access tiers with the
time-live field law; companion command-layer methodology with request-not-order; accessibility input
design with bounded assists; hardware scaling + performance + input-profile save separation; input
observability) — METHODOLOGY ONLY, no per-game canon; it composes 003 (controller / input handoff),
004 (stance state mapping), 005 (traversal affordances), 006 (world tags), 007 (stealth signature
coupling), 008 (suspicion feedback), 009 (takedown resolve), 014 (mobile performance), 021 (combat
verbs / defensive choice), 030 (anomaly gesture grammar), 032 (HUD-as-equipment / presentation), 034
(companion person-preservation), 035 (action priority list), 015 (observability), and merges none.
Canon lives in `docs/design/TOUCHSCREEN_INPUT_INTERACTION_ARCHITECTURE_BIBLE.md` + doctrine BV-D131.

## Consistency Rules

- Every `BV-SKILL-###` in the registry maps to exactly one slug and one `.opencode/skills/<slug>/SKILL.md`.
- Every skill file must carry the required sections (see skill template requirements in the project directive).
- Registry is validated statically by `tools/validate_methodology.py` — missing/mismatched skills fail the check.