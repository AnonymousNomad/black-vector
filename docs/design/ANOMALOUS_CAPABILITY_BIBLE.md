# BLACK VECTOR — ANOMALOUS CAPABILITY, NEURAL STRAIN & PLAYER-POWER BIBLE

> Directive-016 deliverable. GAMEPLAY / POWER-SYSTEM / PRESENTATION ARCHITECTURE ONLY. Not implementation, not VFX
> production, not netcode. Primary model: Big Pickle (per user routing; the directive's "MiniMax M3 / MiniMax"
> attribution is disregarded this session — design lead identity waived).
> Authority: THE DEVELOPER'S WAY -> doctrine -> SOP -> skills -> D008/D009 Combat-Control -> D012 provenance ->
> D014 prologue -> D015 substrate -> this document. Existing Control, Neural Strain, Compound, Reclamation,
> psionic pipeline, prologue knowledge-gates, Memory-Bleed taxonomy, and survival/horror substrate are PRESERVED.
> This bible freezes Season-1 capability law and presentation; event/encounter authoring remains CANDIDATE until a
> later directive acts on it.
> GAME IMPLEMENTATION STARTED: NO.

---

## 1. Binding context & canon consumed

- Inspected: `doctrine/BLACK_VECTOR_DOCTRINE.md` §14–§18 (Hand), §21 (Psionics), §22 (Psionic Cost), §23 (Horror),
  §29 (Opening), §35–§39 (Combat/Control/Strain/Reclamation, BV-D033..D040), §36.3 (Control × Strain 2×2,
  BV-D037), §37 (Compound Branch, BV-D038), §37.3 (Independent Path).
- `docs/design/HIDDEN_HAND_PROLOGUE_BIBLE.md` (D014): grounded-first law, knowledge-gate table, Layered Overwatch
  conventionality.
- `docs/lore/BLACK_HAND_PROVENANCE.md` (D012) §12 pre-collapse markers.
- `docs/design/SIMSE_SOUND_SURVIVAL_ENVIRONMENT_HORROR_BIBLE.md` (D015) environmental coupling substrate.
- `docs/design/WEAPON_RIFLE_FAMILY_BIBLE.md` (D013) Layered Overwatch + psionic weapon boundary (BV-D070).
- Skills inspected: BV-SKILL-019 psionic-gameplay-neural-load (cost pipeline owner), BV-SKILL-021 cqc-combat-architecture
  (Combat/Control/Strain/TK-in-CQC owner), BV-SKILL-018 psychological-horror-perceptual-events (distortion events),
  BV-SKILL-022 visual-equipment-doctrine (visual language owner), BV-SKILL-017 survival-wilderness-systems (env
  coupling), BV-SKILL-028 prologue-narrative-architecture (opening gates), BV-SKILL-029 simse-island-systems (world
  coupling), BV-SKILL-012 diegetic-memory-progression (Memory-Bleed source / discipline gating).

Reconciliation rule applied (per D016 §1):
- **No silent replacement of established law.** Control/Strain 2×2, Compound/Independent, Reclamation bands, the
  psionic pipeline (ACTION → LOAD → PAIN/DISTORTION → VULNERABILITY → POSSIBLE MEMORY/PERCEPTION EVENT), the
  no-mana law, and the prologue knowledge-gates stand as written. D016 ADDS Season-1 capability law (mass/range/
  complexity, discovery curve, ceiling, presentation, cross-system rules, superhero-prevention table, observability
  requirements, methodology skill BV-SKILL-030). It does not redefine Control/Strain internals.

## 2. Governing capability identity (frozen)

> **The Hand can dominate moments, not battlefields.**

He remains: human · shootable · injurable · exhaustible · cold-sensitive · vulnerable while distracted · vulnerable
while concentrating · dangerous because of training first.

Anomalous capability MULTIPLIES skill; it does not replace it. Conceptual capability model (frozen):

> **HUMAN SKILL × ANOMALOUS ASSISTANCE × CONTEXT**

- HUMAN SKILL = the operator's training, discipline, situational awareness, weapon handling, CQC, stealth, gear,
  environmental reading — the baseline that earned him the legend.
- ANOMALOUS ASSISTANCE = the bounded, costly capability the system grants; never a substitute for a whole system
  (doctrine §21 / BV-D036; BV-SKILL-019 invariant 1).
- CONTEXT = weather, light, position, intent, distance, mass class, current Neural Strain, current Control,
  exhaustion, presence of the Compound, terrain, support — the modifiers that turn a capability from "useful" to
  "defining" or to "disastrous."

The product reads as: **a moment-of-moments operator, not a battlefield-clearer.** A capability that, in fiction,
would let him clear a room with one wave is forbidden. A capability that lets him *end one moment* in a room he
already understood is canon.

## 3. No mana (frozen)

BLACK VECTOR does not use a conventional magic/mana bar. Power is constrained through INTERCONNECTED HUMAN COSTS:

```
NEURAL STRAIN    — the principal physiological consequence (BV-D036; BV-SKILL-019)
CONTROL          — governance of self under load (BV-D035; BV-SKILL-021)
EXERTION         — short-term physical work capacity (D015)
INJURY           — the body taking consequence (D015)
CONCENTRATION    — required for clean outputs; breaks under pressure
ENVIRONMENTAL PRESSURE — cold, wetness, exhaustion, wind, storm, terrain
MASS             — qualitative class of the target (this bible)
RANGE            — qualitative band of distance (this bible)
COMPLEXITY       — multi-object/trajectory/distance/vision-load (this bible)
TARGET COUNT     — how many simultaneous things
DURATION         — how long the effect is sustained
```

- The list is NOT a pool. These costs are coupled: cold worsens concentration; concentration worsens Control decay
  under high Strain; high Strain worsens weapon handling; weapon handling failure is injury risk; injury raises
  Strain (BV-SKILL-019 pipeline).
- **No "psychic energy points."** No reskinned mana. No "rage bar that fills and you spend it." No talent tree of
  do-buttons.
- A Compound-relative note (frozen): the Compound (doctrine §37; BV-D038) may later alter the *relationships*
  among the costs (e.g., faster Control recovery, lower Strain accrual under sustained TK), but it does not turn
  them into a spendable resource.

## 4. Neural Strain — graded, not "bar full = no cast" (frozen)

Define Neural Strain (per BV-D036 / BV-SKILL-019) as the principal anomalous physiological consequence, with four
graded bands (qualitative; numeric curves pending device validation):

| Band | Reads as | Game-facing consequences |
|---|---|---|
| LOW | clear | fine motor nominal; perception nominal; recoil/posture nominal |
| ELEVATED | pressure | slight tremor in fine motor; tightened breathing; mild audio narrowing; intentional use begins to cost |
| HIGH | duress | noticeable tremor; visual tearing begins; audio contamination; moments of unreliable perception; recall/judgment delay |
| CRITICAL | crisis | involuntary manifestation risk; perceptual event risk (Memory Bleed); severe motor/cognitive degradation; temporary inability to sustain clean output |

Symptom catalog (frozen set — the bands modulate, the symptoms stay in this menu): tinnitus · pressure · tremor ·
visual tearing · focus disruption · migraine-like pain · memory intrusion · auditory contamination · motor
disruption · involuntary anomalous activity · reality/memory overlap. Authored combos are allowed; the menu is the
law (BV-SKILL-018 governs when a symptom pair becomes a perceptual event).

- Strain is a CONTINUOUS curve (BV-D036) with BANDED player readability; it is not a discrete step counter.
- Critical-band decay requires not just rest but a RE-AUTHORED recovery channel (sleep / shelter / medical / low
  stimulation / Compound depending on path; see §46). It is not a 30-second breather.
- Strain recovery and acquisition are **class-authored**, not numbers-game. Each capability has a CLASS (small /
  medium / heavy / extreme) tied to a strain accrual and consequence window (BV-SKILL-019 invariant 4).

## 5. Control × Neural Strain — the four play states (frozen)

Control and Neural Strain remain SEPARATE systems (BV-D037; BV-SKILL-021 invariant 6). Their interaction is the
canonical 2×2 of play states — each cell is a *different way to play*, not stacked penalties:

```
                        Neural Strain LOW        Neural Strain HIGH
Control HIGH       deliberate operator         disciplined-but-overloaded
                   (precise; restrained;       (execution held; perception/
                   clean windows)              motor unreliable; intermittent
                                               distortion)

Control LOW        angry/unfocused             dangerous instability
                   (violent and                (tunnel vision; memory
                   overcommitted, but          contamination; TK instability;
                   perception intact)          poor judgment)
```

Frozen rules:
- **High Control + High Strain** = precise but physiologically endangered. The Hand can execute a clean window, but
  his body and perception are leaking; the danger is real but the action can still land. This is the *best* S1
  ceiling for deliberate use.
- **Low Control + Low Strain** = violent-but-tactically-worse. No supernatural factor; rage does not grant focus.
- **Low Control + High Strain** = highest-risk state. The most authored memory/perception events and involuntary
  manifestations occur here. The Hand is dangerous to himself and to bystanders.
- **High Control + Low Strain** = optimal deliberate operation. The Hand is a legend again — for the moment.

INTERDEPENDENCY (frozen, doctrine §36.3):
- High Strain feeds Control DECAY. Strain destabilizes → volatility rises → Control drops.
- Low Control raises the LIKELIHOOD of actions that themselves raise Strain (violence, TK misuse, bad decisions).
- Control recovery is easier at LOW Strain and harder at HIGH Strain, unless the Compound is active (§29).
- Rage emerges at Control threshold AND a host event (BV-D034); it is emergent and never a spendable resource.

## 6. Environmental coupling (frozen, anchored to D015)

Powers are not vacuum-bound. The D015 substrate shapes what every capability costs:

| Substrate | Effect on capabilities |
|---|---|
| COLD (D015 §9) | degrades fine motor, concentration, recovery; raises involuntary-tremor probability; widens Strain accrual for delicate work; reduces perception reads |
| WETNESS (D015 §10) | compounds cold; degrades focus and grip; reduces sustained output reliability |
| EXHAUSTION (D015 Exertion) | reduces sustained Control; limits multi-object bursts; slows recovery |
| INJURY (D015 §13) | narrows concentration; raises Strain on the same action; can produce involuntary outputs near the wounded site |
| STORM / ELECTRICAL (D015 §14–15) | degrades visual reads and drone reach; may briefly aid electrical-interaction capabilities (subtle, not a buff); widens environmental perception noise |
| SHELTER / REST | materially matters to recovery (sleep + low-stimulation inside a HEATED structure is the cleanest recovery beat); open-air recovery is a different and slower curve |

Rule (frozen): the D015 substrate is the SINGLE TRUTH for environmental inputs to capability; capabilities do not
maintain their own weather, exposure, or fatigue counters.

## 7. Discovery progression — FIVE phases (frozen; canonical, not four)

Per recon correction, the discovery curve is **AMBIGUOUS → DENIAL → CONTROLLED EXPERIMENTATION → INTEGRATION →
MASTERY.** Five phases; none is skippable; the player's *understanding* of the anomalous must arrive as a story
the world tells them, never a popup that names itself.

### Phase 0 — AMBIGUOUS
Events may be interpreted as coincidence · reflex · environmental movement · trauma · hallucination. The player
should be uncertain — and reasonably so. The capability is invisible: no UI, no system name, no moment of "now
you're psionic." Early pre-collapse feats the Hand may have exhibited in retrospect read as extreme intuition,
not overt TK (D012 §12; D014 §2).

### Phase 1 — DENIAL
Small repeatable effects occur — a door latch that shouldn't have moved; a dropped knife sliding back without a
hand reaching; a tray sliding when the Hand only meant to glare. The Hand still doubts what is happening. The
player should also doubt. Each event is a *diegetic* moment, never narrated.

### Phase 2 — CONTROLLED EXPERIMENTATION
The player (and the Hand) gain DELIBERATE LOW-LEVEL USE. The first undeniable telekinetic event is reserved for
this transition — and it must be EARNED, not menu-driven (see §11; "the first undeniable event").

### Phase 3 — INTEGRATION
Capabilities begin combining with: stealth · firearms · CQC · traversal · environmental interaction. The capability
stops being a separate verb and becomes a multiplier on the verbs the operator already had. Each capability must
support at least two of combat/stealth/traversal/investigation/survival/narrative-horror (D016 §50).

### Phase 4 — MASTERY (Season-1 mature state)
The Hand reaches the first meaningful mature state. Still FAR below future franchise ceilings (D016 §49, §48 matrix).
Recommended Season-1 placement: LATE-MID to near-end of the campaign — when the operator has survived enough to
know what he is, but not so much that the season ceiling breaks. (Concrete placement pending slice/scenario
authoring under BV-SKILL-016.)

## 8. Telekinesis — core family (frozen)

Telekinesis is the principal physical anomalous capability. It MUST remain:

```
LOW-MASS BIASED           — TRIVIAL and LIGHT classes dominate the season
CONCENTRATION DEPENDENT    — fine work costs focus; distraction breaks it
LINE/CONTEXT DEPENDENT     — line-of-effect, cover, occlusion, weather all matter
EXPENSIVE AT HIGHER LOADS  — cost class escalates non-linearly above LIGHT
UNSTABLE UNDER STRAIN      — Critical-band strain introduces jitter and failure
```

- Not every movable physics body is a weapon. Telekinesis is a multiplier on the Hand's choices, not a substitute
  for them (doctrine §21; BV-SKILL-019 invariant 1).
- Telekinesis actions always cost Neural Strain; cost class is co-authored with capability rank (BV-SKILL-019
  invariant 4). There is no "free" telekinesis.

## 9. Object recall (frozen)

Early signature use. Candidate targets: knife · dropped tool · small object · compact equipment.

Core fantasy (frozen):
> **The Hand reaches — and something returns to his hand.**

Hard limitations (frozen, all seasons):
- Short-range early; range grows but only within TACTICAL or less.
- Imperfect early: dropped-object recall requires concentration and proximity; broken recall refunds partial
  recovery and accrues Strain.
- Moving-object recall is HARDER than resting-object recall. A falling object's recall costs more and risks
  jitter at high Speed.
- Interrupted recall: a recall interrupted by contact/Strain spike/the object being obstructed leaves the object
  where it was and costs the FULL action's Strain — *not* a partial refund. The cost was the action.
- Weapon integration: a recalled weapon's action cost REPLACES the Holster/Equip action; this is the multiplier,
  not a duplicate.
- No recall through solid obstacles. Line-of-effect is required.

## 10. Thrown-blade manipulation (frozen)

The Hand's blade style may eventually include limited psychokinetic support. Allowed functions (frozen):

```
trajectory correction      (D016 §18 governs hard rules; PURE FICTION, post-launch PK)
recall                     (overlaps §9, shared cost class)
brief suspension           (a moment of "freeze," high cost, single-target, short duration)
redirection                (post-release; bounded; the post-launch projectile-correction law applies)
next-attack angle change   (a melee lever; small; used to open a window, not to land a kill)
```

Forbidden:
- Continuously orbiting weapons.
- Multi-blade simultaneous control beyond the season ceiling.
- Blades replacing the knife as primary engagement — physical combat remains primary (doctrine §22; BV-SKILL-019).

## 11. The first undeniable telekinetic event (frozen design constraint)

The user-flagged design point. Frozen constraints:

- The first undeniable event is NOT "press psychic button to move crate." It is FORCED OUT OF HIM by an
  emotionally or physically desperate circumstance that the player cannot solve by skill alone.
- The event must be UNDENIABLE — a diegetic moment that both the Hand and the player know happened and cannot
  explain by reflex, technology, or environment. The world around the event must REACT: a sound, an object flight,
  a body response, a witness, a physical consequence.
- The event must be EARNED: the player must have exhausted the conventional answer first. The moment is a
  failure of options, not a checklist.
- AFTER the event, deliberate control becomes possible (Phase 2 entry); the player EARNED it through the cost,
  not through a level-up.
- The event MUST be designed against the post-launch / no-mana / Stealth-of-the-Canon laws: it must not turn the
  Hand into a hero; it must turn him into a person whose body has done something impossible.

Recommended candidates (CANDIDATE — a later directive authors the actual content):
- An object that no human strength could have moved, in a moment when moving it is the only way out.
- A weapon or tool redirected at the last possible instant when no aim/skill answer exists.
- A door/latch/seal that requires a moment of impossible force at the cost of clear physical collapse.

Frozen rule: the event is NOT scripted in this bible. It is a constraint the directive files.

## 12. Small-object control (frozen)

Permit bounded control of: tools · debris · switches/levers where appropriate · small weapons · loose environmental
objects.

- The player should be able to SOLVE situations creatively (the multiplier is the freedom), but physics chaos is
  forbidden on tablet hardware (D016 §54; BV-SKILL-019 invariant 1).
- Effects: a small-object change is a deliberate micro-decision with a cost class, not an ambient particle show.
- Hard ceiling for ambient "things jittering near the Hand": zero. If something moves near the Hand it is because
  he moved it.# — CONTINUED: PART B — DIMENSIONS, RANGE, FIREARM INTEGRATION, PERCEPTUAL —

---

## 13. Person-scale ceiling (frozen — qualitative mass classes)

Per D016 §13, define qualitative mass classes rather than kilograms:

| Class | Reads as | Examples |
|---|---|---|
| TRIVIAL | trivial mass; near-no-cost fine work | cartridge, magazine, small stone, dropped tool, pen, knife |
| LIGHT | small object; deliberate cost | firearm by holster, brick, helmet, knife, boot, lantern, single chair |
| MODERATE | human-scale object; meaningful cost | car door, chair-with-person, propane tank, large crate, room divider |
| HUMAN-SCALE | a person, fully encumbered; high cost, season-ceiling | one human (no armor / light armor / wounded), a human with a small pack |
| EXTREME / GENERALLY PROHIBITED | above the human-scale ceiling for Season 1 | armored combatant, large vehicle, mounted equipment, structural element |

Rules (frozen):
- Moving a person is MUCH HARDER than moving a knife. The cost-class jump from LIGHT to HUMAN-SCALE is the
  largest cost gap in Season 1 (a designed non-linearity).
- Duration matters: a sustained human-scale lift is impossible; a brief displacement (a few meters, with
  meaningful effort) is the Season-1 upper end (D016 §12).
- Acceleration matters: a faster, longer, or repeated displacement escalates cost class.
- Mass and resistance matter: an unwilling or armored human is a full class higher than an unconscious/unarmored
  one. A still-resisting human in armor is generally EXTREME in Season 1.

## 14. Range (frozen — qualitative bands)

| Band | Reads as | Cost / certainty |
|---|---|---|
| TOUCH / IMMEDIATE | within reach | cheapest, most certain; cleanest |
| NEAR | a few meters, "across the table" | low cost, high certainty |
| TACTICAL | room-scale, "down the hall / across the space" | medium cost; line-of-effect and cover matter |
| EXTENDED / RARE | facility-scale / sightline-rare | high cost; uncertainty rises sharply; not a Season-1 normal |

- Range INCREASES difficulty and uncertainty. There is no kilometre-scale telekinesis. There is no remote
  omnipotence.
- A capability's EFFECTIVE range is typically one band shorter than its EFFECT range — if the action reaches TACTICAL,
  the *reliable* reach is NEAR. Reliability is the design language; reach is the bragging number.
- Line-of-effect (D016 §18) governs firearm-related range; line-of-sight governs recall; obstruction breaks the
  effect silently (a diegetic fade, not a system reject popup).

## 15. Complexity (frozen)

Complexity rises with: object count · independently changing trajectories · distance · speed · mass · visual
obstruction · divided attention · simultaneous conventional combat.

Complexity law (frozen): complexity is **multiplicative** with mass and range for cost-class purposes. A
TACTICAL-range LIGHT recall while the Hand is in a CQC ENGAGE state is *already* HEAVY. A NEAR-range TRIVIAL
recall while the Hand is in a HEATED STRUCTURE in a calm is small.

This is the formal reason no "object cloud" emerges from Season 1: every axis the player adds multiplies.

## 16. Multi-object control (frozen — advanced, path-leaning)

Multi-object control is advanced. Early: one object. Later: several small objects.

- Compound path (D016 §30): cleaner sustained multi-object management at the cost of dependency.
- Independent path (D016 §31): rougher, shorter, more adaptive bursts at the cost of reliability ceiling.
- The HARD CAP for Season 1 is small (a handful at most; never "a cloud"). The exact number is CANDIDATE pending
  slice profiling on tablet (D016 §54).
- Multi-object control is governed by the complexity law (§15) — every added object is a multiplier on cost.

## 17. Firearms interaction (frozen)

Psychic capability ENHANCES firearm play without replacing shooting skill. Potential compatibility:

```
weapon recall                          (replaces a holster/equip action, costs recall class)
retrieve dropped magazine/equipment    (TACTICAL-range max; small class; concentration)
stabilize momentarily                  (single-shot, brief window; reduces sway/timing variance — small class)
disrupt opponent weapon alignment      (close, contested; small class; the opponent's hold is the difficulty)
manipulate environmental cover         (a lever/door/grate; small class)
retrieve sidearm                       (NEAR range; small class; replaces the equip)
limited projectile correction          (D016 §18 governs; PURE FICTION; never free)
```

Forbidden: auto-aim magic · guaranteed headshots · bullet steering · "I shoot, it homes."

The firearms interaction is one of the most important multiplier surfaces: the Hand's marksmanship remains the
decisive factor; the capability gives him small, momentary edges that turn exchanges, not fights.

## 18. Projectile correction (frozen — PURE FICTION)

Post-launch psychokinetic trajectory influence, not a real firearm technique. D013 §25/§26 + BV-D070 govern the
fiction. Season-1 behavior is CONSERVATIVE.

Variables (frozen set): distance · projectile speed · correction angle · target motion · sensor confidence ·
concentration · Neural Strain.

Hard rules (frozen, non-negotiable):
- **One projectile** at a time, or extremely limited volume — never "spray-and-correct."
- **Small corrections initially**, growing marginally with mastery. "Small" means: a few degrees of angle, a
  marginal drift, not a homing curve.
- **No steering automatic-fire streams.** The Hand's weapon discipline is what steers auto-fire.
- **No impossible turns.** The bullet cannot reverse, double back, or take a corner a real projectile could not.
- **No seeing through solid objects.** Legitimate target information is required (the Hand's marksmanship and
  senses, not psychokinesis).
- **Legitimate target information required.** The Hand must know where the target IS, in the world, in a way a
  marksman without powers could know. PK does not grant vision.
- **Severe strain at difficult corrections** (large angles, moving targets at range, obstructed shooters). The cost
  escalates non-linearly with difficulty.

Frozen anti-rule: **no real-world shooting instruction.** This is PURE FICTION; do not provide shooter technique.
The capability is a diegetic cost, not a coaching guide.

## 19. Perceptual acceleration (frozen)

Do not implement literal time-stopping. The Hand may experience heightened perception under extreme focus.

Concept (frozen):
> **The world did not slow down; his processing accelerated.**

Possible representation:
- selective temporal presentation
- expanded reaction window
- enhanced threat readability
- short-duration decision assistance

Cost and limits (frozen):
- Carries Neural Strain (medium-class entry; cost rises with duration).
- Costs Control (concentration is not free; sustained use degrades the operator's restraint).
- Post-use recovery is non-trivial — the Hand is slower, less accurate, and more strain-sensitive for a window
  after a perceptual-acceleration peak.
- Sensory distortion: heightened perception does not clean perception; it can also hear/see more than the
  surroundings warrant. (Memory Bleeds can ride this.)
- No endless bullet-time. Burst duration is bounded.

## 20. Intent / threat sensitivity (frozen)

Evolve The Hand's old battlefield intuition (D012 §12 "extreme intuition") carefully.

Early reads:
- uneasy feeling
- attention pull
- unexplained anticipation

Later reads:
- better threat-direction sensitivity
- subtle hostile-intent recognition
- limited prediction-like perception

Forbidden: omniscience · enemy outlines through walls · guaranteed future knowledge. **D007 sensing truth remains
authoritative** (D011 §7/§27 / BV-SKILL-008); the capability reads what a real operator could read with extraordinary
sensitivity, never what a real operator could not.

## 21. Perceptual intrusion (frozen, later candidate)

Later capability candidate. The Hand may influence another person's immediate perception. Allowed bounded effects:

```
momentary distraction
hesitation
failure to notice something obvious
brief directional confusion
emotional pressure
```

Forbidden:
- complete personality rewrite
- permanent mind control
- effortless interrogation
- forcing arbitrary actions
- controlling crowds

- This ability is PSYCHOLOGICALLY UNCOMFORTABLE. The Hand's body reads it as a violation — strain symptom
  cluster, a sense of wrong, a recoil.
- Cost class: high. A successful intrusion is one of the most expensive actions in Season 1.
- Effects decay quickly. A held intrusion is generally outside Season 1 ceiling.# — CONTINUED: PART C — INFLUENCE, MEMORY, ELECTRICAL, TRAVERSAL, CQC, RAGE, PATHS —

---

## 22. Influence (frozen — kept separate from intrusion)

Influence is not mind control (D016 §22). Allowed bounded effects:

```
amplify fear · create unease · impose momentary pressure · encourage hesitation
```

Hardening rules (frozen):
- Targets with training · awareness · distance · competing stimuli are HARDER (cost escalates).
- Effect decays quickly (a presence, not a state change).
- No dialogue "win button." Influence never replaces conversation; it modifies the cost of speaking.
- Influence NEVER grants the Hand information about the target's mind.

Influence and intrusion (§21) are separated: intrusion affects immediate perception; influence affects emotional
state. Their cost classes are distinct; both are bounded.

## 23. Memory phenomena — critical separation (frozen)

Critically separate:
- **THE HAND'S ABILITY** (what he can do)
- **THINGS HAPPENING TO THE HAND** (what the world does to him)

Memory Bleeds from D015 §31 / D014 Appendix B are NOT automatically his power. Some phenomena may be:
- neurological (post-Compound withdrawal / conditioning artifact)
- Compound-related (acute state interactions)
- location-related (the island's role, D012 §19-§20)
- Darkness-related (BV-D058 / doctrine §23)
- external
- unknown

**Do not collapse the horror mystery into a skill tree.** A bleed is an authored horror event (BV-SKILL-018), not a
trigger that levels a capability. The Hand's anomalous capability may *participate* in a bleed (he sees something
move because it moved), but the bleed is the world's content, not his ability.

This rule binds doctrine §23 horror rarity: PARANORMAL events are scarce (D015 §33; BV-SKILL-018 invariant 2).
Anomalous capability usage does NOT spawn bleeds — bleeds are authored.

## 24. Electrical / electromagnetic interaction (frozen; RECOMMENDATION)

Determination (frozen, returned as requested by D016 §24):

**Recommendation: NOT in Season 1 baseline.** Reasons:
- The Hand's pre-collapse profile (D012 §12) reads as psychokinetic / perceptual, not electromagnetic.
- D015 weather/storms already modulate electronics legibly (drone, comms, F3 relay). Adding EM capability
  competes with that substrate rather than composing with it.
- The Superhero Prevention Matrix (§48) lists "electricity / electronics interference" as POSSIBLE LATER. The
  cleanest Season-1 design respects the deferral.
- Forcing it in Season 1 risks (a) cheap superhero-cape content, (b) redundant drone/relay effects, (c) a
  capability that satisfies one fantasy (lightning) at the cost of the multiplier identity.

If a later directive brings it in, the entry shape must be: small interference, brief sensor disruption, sensing
unusual electromagnetic activity — NOT lightning, NOT grid control, NOT magical hacking.

## 25. Traversal interaction (frozen)

Subtle traversal assistance (Season-1 mature band). Allowed:

```
retrieve climbing aid
manipulate latch
reduce fall severity  (see §26)
brief directional correction (a step, not a launch)
move small obstacle
```

Forbidden:
- flight
- sustained levitation
- superhero rooftop traversal
- large gap crossings as a normal capability

The Hand is still a man climbing a tree, falling down a slope, sliding on ice. The capability helps his EDGES,
not his path.

## 26. Fall mitigation (frozen — late, bounded)

Very late capability; reduces a damaging fall. Requirements (frozen):

```
awareness         (a moment to recognize the fall is bad)
reaction          (the Hand's reflex fires; this isn't auto)
strain            (cost-class medium-to-heavy depending on height)
remaining capability  (his TK precision is enough to absorb force reliably)
```

Not immunity to falling. A fall that exceeds the capability's safe band is still injury.

## 27. CQC integration (frozen — D008/D009 authoritative)

D008/D009 remain authoritative (BV-SKILL-021). Power INTEGRATES into existing CQC states; it does not replace them.

Allowed CQC uses (frozen):

```
interrupt                (small class)
imbalance                (medium; opens a window)
retrieve weapon          (overlaps §9/§17; small class)
open brief angle         (small/medium)
change spacing           (small/medium)
protect recovery         (small; a leverage, not a heal)
environmental interaction  (lever, debris; small class)
```

Forbidden: telekinetic spam loop · physical combat bypass · "I just push them." The Hand's combat is built on
positioning, timing, restraint, and recoil. PK is an interceptor, not a substitute.

Frozen alignment with doctrine/BV-SKILL-019/021: TK-IN-CQC remains BOUNDED (§35.6). Power augments, never replaces;
every use costs Strain.

## 28. Rage interaction (frozen)

Low Control may make anomalous output (frozen, four-axis):

```
POWER GAIN         — output rises (more force, faster recovery, harder recall)
PRECISION LOSS     — output wobbles; jitter increases; targets slip
STRAIN COST        — Strain accrual is sharper; pain reads harder
FAILURE RISK       — failure-state window widens (involuntary, recall break, projection drift)
```

Rage creates TEMPTATION. A low-Control peak may move the table farther, faster. The cost is what comes after.

Frozen anti-rule: rage is NEVER a simple damage buff. It is an emergent state with a four-axis cost.

## 29. Involuntary manifestation (frozen)

At HIGH/CRITICAL Strain + LOW Control, anomalous effects may occur unintentionally.

Examples (frozen set):
- nearby object shifts
- weapon jumps in hand
- lights fail
- something is pulled (small class only)
- environmental debris reacts

Rules (frozen):
- Used SPARINGLY. Each involuntary event is authored, not ambient.
- NEVER randomly kills the player. The events communicate INSTABILITY, not punishment.
- These events EARN the horror budget; they are NOT free horror.
- A Low-Control + High-Strain passage through an authored space can produce an event; an ordinary moment cannot.

## 30. Compound path (frozen)

The Compound is a genuine progression branch (doctrine §37; BV-D038; D012 §10-§11). Frozen role:

```
POTENTIAL BENEFITS:
  - faster Control recovery
  - reduced Control volatility
  - increased telekinetic precision
  - reduced Neural Strain accumulation
  - access to higher sustained telekinetic output
  - easier recovery of old Hidden Hand execution quality

POTENTIAL COSTS:
  - dependency
  - progressively worse instability when unavailable
  - severe fictional withdrawal/crash
  - greater reliance on the system that originally controlled him
  - narrative consequences
```

Frozen rules:
- NEVER reduced to a binary morality choice (doctrine §37.2).
- NEVER treated as a consumable combat potion (D016 §30).
- Discovery is diegetic (doctrine §37.4). The player encounters the Compound through a recognizable dose during a
  severe destabilization event; the unmistakable transition (noise recedes, vision stabilizes, motor control
  improves, rage becomes manageable, telekinesis becomes clean, former operator precision resurfaces) precedes the
  cost being understood.
- After sustained Compound use, the player MAY see multi-object control cleaner; before Compound, the same
  multi-object work is rougher (Independent, §31).

## 31. Independent path (frozen)

Refusing/reducing Compound reliance is HARDER INITIALLY (doctrine §37.3). Frozen role:

```
POTENTIAL STRENGTHS:
  - genuine self-regulation
  - deeper anomalous sensitivity
  - adaptive CQC integration
  - less institutional dependency
  - greater long-term autonomy
  - unusual / less orderly manifestations

POTENTIAL WEAKNESSES:
  - rougher early control
  - lower sustained raw ceiling
  - more immediate strain
  - harder recovery
```

Frozen rules:
- Neither branch is OBJECTIVELY SUPERIOR (D016 §31). The paths trade different things at different times.
- The late-game Independent Hand does NOT recreate his old self; he becomes something the original Hidden Hand
  operator never was (doctrine §37.3).
- Path expression bleeds into capability availability: cleaner sustained TK and multi-object are easier on
  Compound; rarer, more adaptive spontaneous effects (and a harder recovery) characterize Independent.

## 32. Under-hood variables (frozen — ownership + visibility)

Variables to evaluate (D016 §32):

```
COMPOUND SATURATION
DEPENDENCY
SELF-MASTERY
NEURAL STRAIN
```

Frozen recommendation (per D016 §32 "ownership and visibility"):

| Variable | Player visibility | Lives in |
|---|---|---|
| COMPOUND SATURATION | surfaced as a CONDITION (wet/shivered equivalent), not a meter; symptoms at high saturation | Compound path internals (BV-SKILL-019 cost pipeline + D016 §30) |
| DEPENDENCY | surfaced as a CONDITION and as an authored event when withdrawal is imminent (symptoms, not numbers) | Compound/Independent path internals |
| SELF-MASTERY | surfaced via the Control band (D015/BV-D035) — the player sees the band, not a stat | Control architecture (BV-SKILL-021) |
| NEURAL STRAIN | surfaced via the D015 strain band (§4); deliberately introduced AFTER Phase 1 (D016 §44) | Strain architecture (BV-D036; BV-SKILL-019) |

Frozen rule: no numeric exposure of these four to the player. The Hand and the world read them through
diegetic feedback (BV-SKILL-015/021; doctrine §36.4). The overlay exposes the BAND, not the number.# — CONTINUED: PART D — PATHS, CHOICE, CROSS-SYSTEM, PRESENTATION, HUD, RECOVERY, MATRIX —

---

## 33. Path switching (frozen)

Switching is NOT an instant loadout swap (D016 §33). Frozen rules:

```
- Changes require TIME, ADAPTATION, WITHDRAWAL/RECOVERY, and CONSEQUENCES
- The player may not optimize "Compound for boss fight, Independent for exploration"
- Path choice needs PERSISTENCE — a session-long or campaign-long identity
```

Path expression may DRIFT (e.g., a player who has been off-Compound for a long arc may not recover Compound muscle
immediately on a single dose), but the *cost axis* of each path stays distinct.

## 34. Mutual exclusivity (frozen — small set)

Identify a SMALL number of genuinely path-favored or mutually exclusive expressions. Frozen list (not a full
forking — this is one game, not two):

| Path | Expression | Description |
|---|---|---|
| Compound | SUSTAINED PRECISION | cleaner multi-object control; lower immediate strain; cleaner sustained TK |
| Compound | STABILIZER | recovery from strain is faster; Control is steadier under load |
| Independent | DEEPER INTUITION | subtler threat/intent reads; more adaptive spontaneous effects |
| Independent | SHARPER EDGE | extreme moments cleaner at the cost of recovery; more moment-defining outputs |

These are EXPRESSIONS, not separate games. The player does not select one of four buttons. Their accumulation of
choices narrows their path expression over time.

## 35. Ability acquisition (frozen — diegetic pattern)

Avoid conventional RPG "+1 Telekinesis unlocked." Frozen diegetic pattern:

> **EVENT → ACCIDENTAL MANIFESTATION → RECOGNITION → EXPERIMENTATION → DELIBERATE USE → MASTERY**

- Some capabilities can be triggered by: story · stress · location · memory · Compound state.
- Player PRACTICE improves reliability — diegetic rehearsal, not a level-up.

Examples (frozen set, all diegetic):
- A desperate moment forces the first undeniable telekinetic event (§11).
- A trained moment of stillness under fire opens a perceptual-acceleration peak (§19).
- A memory bleed reveals a use-pattern the Hand now recognizes (D015 §31; BV-SKILL-018).
- The Compound dose (if encountered) opens deliberate-use bandwidth (§30).
- Practice in shelter improves reliability of small-class capabilities (Phase 2 onward).

## 36. Player choice (frozen — not blank-class)

Season 1 remains THE HAND'S authored character. The player does not become a blank-class protagonist. Frozen rules:

- The player may prefer: precision TK · environmental manipulation · perception · CQC integration · weapon
  integration · influence — but they are PREFERENCES within one character's identity, not class selection.
- The Hand's authored character limits what the player can express. The player does not get to be a different
  person.

## 37. Power + stealth (frozen)

Abilities should create stealth OPPORTUNITIES and RISKS. Frozen balance:

```
BENEFITS:
  quiet retrieval
  remote distraction
  small-object manipulation
  brief perceptual disruption (intrusion boundary)

COSTS:
  anomalous signature  (a sensory readable; D011 §7 territory for trained/Black Hand detection)
  Neural Strain
  involuntary effects (§29)
  wildlife / environment reaction
  Black Hand detection where appropriate
```

Frozen rule: NO invisible psychic god mode. A capability that solves every detection problem is a contradiction.

## 38. Power + horror (frozen)

The stronger the Hand becomes, horror must NOT disappear. Frozen rules:

- Some threats are UNAFFECTED by anomalous capability (the human layer remains).
- Some threats are POORLY UNDERSTOOD by the player (capability doesn't explain the world).
- Some threats are MADE WORSE by anomalous contact (intrusion, bleed amplification, perception tearing).
- Some threats are DETECTABLE BUT NOT CONTROLLABLE (True Unknowns).
- True Unknowns are NOT telekinetic punching bags. They are scarce and irreducible (D015 §34).
- Power should occasionally let The Hand PERCEIVE MORE HORROR, not less.

## 39. Power + community (frozen)

Using abilities openly affects how people perceive The Hand. Frozen compatibility — not implementation:

```
Potential reactions:
  fear · awe · suspicion · recognition · hostility · religious interpretation · Black Hand interest
```

- NO reputation system implemented here.
- Freeze compatibility: the Hand's visibility (presence at base, on missions, in public space) intersects with
  community-state disposition (D015 §22) and survival/HUD ownership (D015 §45). Future community directives may
  surface these reactions without redesigning the capability architecture.

## 40. Power + wildlife (frozen)

D015 wildlife is an environmental-information system. Anomalous use may occasionally cause:

```
silence · flight · agitation · avoidance
```

Frozen rules:
- Animals are NOT psychic detectors with perfect truth (D015 §28, §40).
- Wildlife reactions are READABLE signals, not confirmation of the capability's existence.
- Wildlife's reaction is one of several reasons anomalous use has a detectable signature.

## 41. Visual language — presentation principles (frozen; not VFX assets)

Power should generally appear (frozen):
- restrained
- physical
- unsettling
- close to invisible at low levels

Forbidden (frozen):
- glowing hands (constant)
- colored magic beams (constant)
- giant energy circles
- superhero auras

Preferred cues (frozen menu — a capability author picks; no single cue is mandatory):
- subtle object vibration
- pressure distortion
- particulate movement (dust, condensation, breath)
- audio shift
- brief focus deformation
- physiological reaction (the Hand's body reacts)
- environmental response (the world reacts)

Principle: at LOW Strain the capability should be AMBIGUOUS to a bystander (Phase 0–1). At HIGH Strain, the cue set
widens. At CRITICAL Strain, the cue set becomes the cost — the player sees what the operator pays.

## 42. Body feedback (frozen)

The Hand's body visibly pays for power. Frozen symptom menu:

```
eye strain · nosebleed (sparingly, never repetitive comedy) · trembling · facial tension ·
balance loss · hand tremor · posture degradation · breathing change · migraine response ·
involuntary muscle tension
```

Rules (frozen):
- No single symptom becomes REPETITIVE COMEDY.
- Symptoms ROTATE by capability class and phase.
- A symptom at HIGH Strain is a HARDER expression than the same symptom at ELEVATED.
- Symptoms are WORLD-layer (the body is genuinely reacting) — they are honest, not theatrical (BV-SKILL-018
  invariant 4: WORLD vs PERCEIVED separation; this stays clean).

## 43. Visual-state compatibility (frozen)

Preserve future persistent character-state design (D016 §43). Anomalous overuse may leave TEMPORARY or PERSISTENT
visible evidence.

- Do NOT yet design grooming, hair growth, or clothing-dirt architecture here — these belong to a future reclamation
  / persistence directive.
- ENSURE power presentation can COEXIST with those later visual systems: body reactions and skin signs stay
  observable through clothing layers and weather states; persistent signs integrate into the wear/damage
  spectrum (doctrine §41.11).

## 44. Audio language (frozen)

Power needs an identifiable but restrained audio vocabulary. Frozen layers:

```
pressure · low-frequency distortion · tinnitus · environmental creak · object resonance ·
heartbeat · breathing interruption
```

- Avoid generic fantasy spell sounds.
- Audio is SHARED truth with stealth (D015 §43; BV-SKILL-007) and horror (BV-SKILL-018). Audio cues belong to the
  same channel architecture.
- LOW Strain = subtle. HIGH Strain = layered. CRITICAL = the audio is the warning.

## 45. HUD — discovery presentation (frozen — D015 ownership preserved)

Do not fully redesign D015 HUD ownership. Frozen rules:

- NEURAL STRAIN should not appear immediately as a "psychic meter." It enters as symptoms first (D016 §4, §42),
  then as a BAND on the diagnostic / contextual surface, then as a near-permanent visible band late in the
  campaign.
- Discovery presentation: Phase 0–1 invisible. Phase 2 contextual symptom icons. Phase 3+ diagnostic screen
  readable. Phase 4 band visible.
- HUD should REINFORCE the body, not replace it (D016 §45).
- CRITICAL state warnings use body reactions + audio + light, not a flashing color.

## 46. Failure states (frozen)

Power failure should be INTERESTING, not punitive. Frozen outcomes:

```
object drops             (recall/release failure)
incomplete movement      (the action half-lands)
mistimed effect          (the action lands but later or earlier than intended)
increased strain         (a failed action costs more)
Control destabilization  (the failure nudges the 2×2 toward danger)
temporary inability      (a small window where the capability is unavailable)
sensory contamination    (the failure carries a perceptual symptom)
involuntary manifestation  (D016 §29 — at low Control)
```

Forbidden (frozen): arbitrary instant death · random permanent failure · opaque probability. Every failure has a
REASON (logged, observable; BV-SKILL-015).

## 47. Recovery (frozen)

Define recovery channels. Frozen list:

```
time · reduced exertion · shelter · sleep · low stimulation · medical support ·
Compound (depending on path; only relevant when path presence exists)
```

Rules (frozen):
- NO effortless regeneration between encounters. Recovery is a curve, not a heartbeat.
- SLEEP + HEATED STRUCTURE is the cleanest recovery beat (D015 §12, §22).
- LOW STIMULATION is a real recovery condition (silence, low light, no threats); this is diegetic, not a flag.
- MEDICAL SUPPORT exists at F2 Tanellus (D015 §24) and through the ally (doctrine §26; BV-SKILL-020). It is not a
  casual resource.
- COMPOUND-recovery is path-dependent; off-Compound players do not gain the same recovery profile.

## 48. Superhero-prevention table (frozen — mandatory)

Authoritative matrix. NEVER = forbidden in any BLACK VECTOR design pass. NOT IN SEASON 1 = locked out for the
campaign, possible later. POSSIBLE LATER = explicit future-franchise space. SEASON-1 ALLOWED = bounded to Season-1
capability ceilings.

| Capability | Status |
|---|---|
| Car lifting (free-standing, sustained) | NOT IN SEASON 1 · POSSIBLE LATER |
| Person lifting (free-standing, sustained) | NOT IN SEASON 1 · POSSIBLE LATER |
| Crowd throwing | NEVER |
| Flight | NEVER |
| Sustained levitation | NEVER |
| Projectile stop (in-flight halts) | NOT IN SEASON 1 · POSSIBLE LATER |
| Projectile correction | SEASON-1 ALLOWED (frozen, D016 §18) |
| Automatic-fire steering | NEVER |
| Mind control (permanent / personality rewrite) | NEVER |
| Influence | SEASON-1 ALLOWED (frozen, D016 §22) |
| Telepathy (sustained / deep read) | NEVER |
| Future sight (literal guaranteed prediction) | NEVER |
| Through-wall perception | NEVER |
| Electricity (lightning attack / grid control) | NOT IN SEASON 1 · POSSIBLE LATER (D016 §24) |
| Electronics interference (small) | NOT IN SEASON 1 · POSSIBLE LATER (D016 §24) |
| Multi-object control | SEASON-1 ALLOWED (bounded; D016 §16) |
| Body transformation (demonic / threshold hybrid) | NEVER |
| Regeneration (rapid, combat-useful) | NEVER |
| Invulnerability | NEVER |
| Recall | SEASON-1 ALLOWED (frozen, D016 §9) |
| Small-object manipulation | SEASON-1 ALLOWED (frozen, D016 §12) |
| Push/Pull (human-scale, brief, costly) | SEASON-1 ALLOWED (frozen, D016 §12/§13) |
| Blade manipulation (bounded) | SEASON-1 ALLOWED (frozen, D016 §10) |
| Perceptual acceleration (bounded) | SEASON-1 ALLOWED (frozen, D016 §19) |
| Intent/threat sensitivity (bounded) | SEASON-1 ALLOWED (frozen, D016 §20) |
| Perceptual intrusion (bounded) | SEASON-1 ALLOWED (frozen, D016 §21) |
| Fall mitigation (bounded) | SEASON-1 ALLOWED (frozen, D016 §26) |

Frozen rules:
- NEVER rows are absolute: a future directive may only lift a NEVER by amending this table explicitly.
- NOT IN SEASON 1 rows are a per-campaign gate; a Season-2 directive could lift them.
- POSSIBLE LATER rows remain future-franchise architecture (D015 §47).
- SEASON-1 ALLOWED rows are bounded by the per-capability D016 section. The matrix is the table-of-contents;
  each row's section is the law.

## 49. Season-1 ceiling (frozen)

By the end of Season 1, The Hand may be HIGHLY DANGEROUS but must still fundamentally require:

```
firearms · knives · CQC · stealth · cover · planning · allies · shelter · medical care
```

If powers make those OBSOLETE, the design has failed (D016 §49).

The Season-1 mastery state is a person, not a god: a man who has rebuilt enough of himself to dominate
*moments*, who still chooses to bring a rifle and a knife and a plan, and who still needs shelter when the cold
bites him and ally support when the recovery window widens.# — CONTINUED: PART E — ENCOUNTERS, AI, OBSERVABILITY, MOBILE, ACCESSIBILITY, SCOPE, SKILL, APPENDICES —

---

## 50. Encounter design rule (frozen)

Every anomalous capability must support at least TWO of:

```
combat · stealth · traversal · investigation · survival · narrative/horror
```

- Avoid abilities that exist ONLY to fill a combat tree (D016 §50).
- A capability that supports only combat is a combat-spell violation (BV-SKILL-019 invariant 1; doctrine §21).
- A capability that supports six of these may still be too generous — the rule is a floor, not a ceiling.

## 51. AI response to anomalous behavior (frozen)

Human AI responds BELIEVABLY to witnessed anomalous behavior. Frozen dispositions:

```
disbelief · hesitation · fear · tactical adaptation · retreat · reporting · escalation
```

Rules (frozen):
- Not every guard immediately understands what happened.
- Some witnesses FREEZE (a real reaction); others FLEE (a real reaction); a few TACTICALLY ADAPT (rare; trained
  response).
- A patrol that witnessed something anomalous may REPORT it — the propagation graph (D015 §21) and the
  Black Hand recognition (§52) read that report.
- AI does NOT auto-pivot to "psychic-detector mode." Detection through PROVENANCE, with all the
  boundedness that implies (D011 §7/§27; BV-SKILL-008).

## 52. Black Hand response (frozen)

Black Hand insiders may recognize more than ordinary humans. Frozen rules:

- Their reaction can help communicate: "They have seen something like this before."
- DO NOT use them for exposition dumps. They have seen it; they do not lecture.
- Their recognition is a SIGNAL (D015 §21) that feeds faction pressure, not an answer that resolves the mystery.

## 53. Observability requirements (frozen — design contract)

Future implementation needs debug surfaces for:

```
current anomalous state
active capability
target validation
mass class
range class
complexity
strain delta
control delta
path state
Compound modifiers
failure reason
involuntary trigger reason
```

Frozen shape (SOP-006; BV-SKILL-015):
- One overlay pane per system; not a wall of numbers.
- Each transition logs a reason.
- WORLD vs PERCEIVED separation preserved (BV-SKILL-018 invariant 4).
- Replayable fixture: a deterministic seed must reproduce the capability use (BV-SKILL-015 invariant 4).

## 54. Mobile / Godot boundary (frozen)

Design for Android/tablet; GL Compatibility remains baseline.

Avoid:
- hundreds of active physics bodies
- persistent high-cost deformation
- huge particle counts
- constant full-scene postprocessing
- large-scale destructibility

Prefer:
- authored interactables
- bounded physics
- selective VFX
- event-driven behavior
- pooled effects
- short high-value presentation bursts

Frozen micro-rules:
- Multi-object control is bounded (D016 §16). The Hard-cap is set by slice profiling on tablet.
- Particle / dust / pressure effects are event-triggered and budgeted.
- Cap on concurrent active "force application" objects is small (single digits), to be validated under
  simulated stress.

## 55. Accessibility (frozen)

Power effects must not rely SOLELY on:
- screen shake
- flashing
- chromatic aberration
- high-frequency visual distortion

Recommendations (frozen):
- Provide alternatives for players who reduce: motion effects · flashes · camera shake.
- Neural Strain still needs readable feedback — use audio + body language + lighting shifts.
- The diagnostic screen and the Control/Strain bands (D016 §45) must remain readable.

## 56. No future-saga contamination (frozen)

D016 does not implement or canonize:
- Saga-3 island-born protagonist
- body-weapon transformation
- demonic/threshold hybrid form
- player-created supernatural classes
- lunar systems
- aliens / nonhuman civilizations
- final-saga technology

D016 is THE HAND, Season 1. Future-franchise content stays future-franchise (D015 §47).

---

## 57. Skill review & ownership (frozen result)

Per D016 §59 inspection of the 29-BV-skill fleet (plus 2 governing):

| Skill | What it owns |
|---|---|
| BV-SKILL-019 psionic-gameplay-neural-load | cost/pain/vulnerability pipeline; bounded capability list; no-mana/no-spellbook discipline |
| BV-SKILL-021 cqc-combat-architecture | Control/Strain combat internals; TK-in-CQC boundaries; rage; reclamation gating |
| BV-SKILL-018 psychological-horror-perceptual-events | authored distortion events; scarcity/ambiguity contract |
| BV-SKILL-012 diegetic-memory-progression | memory gates; discipline recovery; photograph thread |
| BV-SKILL-022 visual-equipment-doctrine | visual language of equipment/armor (NOT power VFX) |
| BV-SKILL-028 prologue-narrative-architecture | opening knowledge gates; knowledge-table |
| BV-SKILL-029 simse-island-systems | world-systems substrate; environment coupling |
| BV-SKILL-017 survival-wilderness-systems | survival internals |

Per the user's recon correction: a new skill is JUSTIFIED **only as methodology**, not as D016 canon. Reasoning:

- 019 owns the cost pipeline and the bounded-capability law; it does not own the methodology for designing
  capability ceilings, complexity laws, mass/range bounding, the five-phase discovery curve, the path
  persistence/switching rules, the superhero-prevention matrix, presentation integration, cross-system rules, or
  observability requirements.
- 021 owns Control/Strain internals and CQC integration; it does not own the design procedure for the capability
  system as a whole.
- 018 owns authored horror events; it does not own power-presentation methodology.

Conclusion (frozen): **BV-SKILL-030 is created as METHODOLOGY ONLY** — anomalous-capability architecture. It owns
the REUSABLE DESIGN PROCEDURE (mass/range/complexity methodology, acquisition/discovery progression methodology,
capability ceiling design, superhero-prevention matrices, path persistence/switching methodology, presentation/
failure integration, cross-system integration, observability requirements). It does NOT contain statements like
"The Hand can move X object in Season 1" — those statements live in this bible (D016) and doctrine (BV-D087+).

The fleet stays strong (few strong skills, no duplicated lore).

---

## Appendix A — Contradiction ledger (D016)

| # | Existing canon | D016 position | Result |
|---|---|---|---|
| 1 | Doctrine §21 psionics multiply, never replace | §2 "HUMAN SKILL × ANOMALOUS ASSISTANCE × CONTEXT" + §8–§27, §48 matrix | No contradiction |
| 2 | Doctrine §22 psionic cost pipeline | §3, §4 strain bands; §46 failure states | No contradiction |
| 3 | BV-D035 Control = continuous numeric core, player-facing bands, NOT morality | §5 2×2; §32 SELF-MASTERY ownership; rage §28 | No contradiction |
| 4 | BV-D036 Neural Strain = independent, no mana, TK always present | §3 no-mana; §4 strain bands; §32 ownership | No contradiction |
| 5 | BV-D037 Control × Strain = 2×2 of play states | §5 verbatim 2×2 | No contradiction |
| 6 | BV-D038 Compound benefits/costs, non-binary | §30 Compound path; §33 path-switching | No contradiction |
| 7 | BV-D040 Reclamation bands | §7 Phase 4 MASTERY; §49 Season-1 ceiling | No contradiction |
| 8 | BV-SKILL-019 psionic pipeline ownership | §57 ownership preserved (cost/pain/vulnerability pipeline) | No contradiction |
| 9 | BV-SKILL-021 Combat-Control/Strain/TK-in-CQC | §27 CQC integration; §5 2×2; rage §28; reconfirmed ownership | No contradiction |
| 10 | BV-SKILL-018 horror authoring contract | §23 memory phenomena separation; §38 horror preservation | No contradiction |
| 11 | D012 §12 pre-collapse markers stay non-paranormal | §11 "first undeniable event" + §48 + doctrine note | No contradiction |
| 12 | D014 §2 grounded-first opening law | §11 frozen constraint; §48 matrix; knowledge gates preserved (D015 §28 reference) | No contradiction |
| 13 | D014 §28 player-knowledge gate table | §44 HUD discovery presentation; §45 symptom-first | No contradiction |
| 14 | D015 environmental substrate (cold/wetness/exertion/injury) | §6 environmental coupling (anchored to D015 §9-§15) | No contradiction |
| 15 | D015 §31 Memory Bleed taxonomy (not Hand's power) | §23 separation; authored-event discipline | No contradiction |
| 16 | D015 §34 True Unknowns scarce | §38 True Unknowns untouched; §48 NEVER on mind control/future sight/etc. | No contradiction |
| 17 | D015 §47 Saga-1 containment + seam budget | §56 no future-saga contamination | No contradiction |
| 18 | D013 BV-D070 psionic weapon boundary | §10 thrown-blade, §17 firearms, §18 projectile correction | No contradiction |
| 19 | Doctrine §35.6 TK-in-CQC boundary | §27 CQC integration explicit | No contradiction |
| 20 | BV-D052 design-language freeze only (no models/VFX) | §41 visual language = principles only, no VFX assets | No contradiction |

Result: **0 contradictions.** No silent repair required. D016 ADDS Season-1 capability law, presentation
methodology, and the superhero-prevention table; it does not modify existing doctrine.

## Appendix B — Deferred decisions (D016)

1. Concrete Season-1 placement of PHASE 4 MASTERY within the campaign spine (slice/scenario authoring).
2. The first undeniable telekinetic event (§11) — specific content authored later; constraint frozen.
3. Exact numerical thresholds for strain/control bands (deferred to device validation).
4. The micro-rules for EM/electrical entry if a future directive brings it in (§24 recommendation).
5. The hard-cap on multi-object count for Season 1 (slice profiling on tablet).
6. The path-favored/mutually-exclusive expression catalog (§34) — extend with later authored entries.
7. Specific power-vocabulary entries (per-capability phrasing) authored later.
8. Future-franchise capability rows (BV-SKILL-030 reusable for those).

## Appendix C — Stop-condition trace (D016)

This bible STOPS if any stop condition listed in D016 §STOP fires: telekinesis replaces firearms/CQC · powers
become mana-based · The Hand dominates battlefields · D007 sensing truth is bypassed · D008/D009 combat is
replaced · Memory Bleeds become "The Hand's spell" · Compound becomes a consumable buff · path switching is
instant · projectile correction becomes real shooting instruction · True Unknowns become ordinary power targets ·
powers trivialize cold/injury/survival · Saga 3+ contaminates Season 1 · tablet feasibility ignored · validation
fails.

None triggered. **Validation below. STOP. NO COMMIT. RETURN REPORT.**

---

## Appendix D — Recommended D017 (not executed)

Per D016 §62, expected recommendation: **OPTION A — PLAYER RECLAMATION / PROGRESSION BIBLE.** This is the user's
preferred next slice: physical recovery · old military skill return · weapon familiarity · survival mastery ·
Control · anomalous capability · Compound/Independent development · gear progression · visual evolution · base/
grooming/persistent appearance compatibility. The visible-state → physical-consequence → natural-response principle
becomes formal here. BV-SKILL-030's methodology (capability ceiling design, cross-system integration, presentation)
composes with the reclamation skill (likely a future BV-SKILL-031) into the persistent-character-state layer.
**Not executed.**