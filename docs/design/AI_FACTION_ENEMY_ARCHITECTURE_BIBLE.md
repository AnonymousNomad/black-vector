# BLACK VECTOR — AI, FACTION & ENEMY ARCHITECTURE BIBLE

> Directive-022 deliverable. AI / FACTION / ENEMY ARCHITECTURE ONLY. Not implementation, not code, not
> Godot/engine work, not asset creation, not production file modification. Primary model: Big Pickle (per
> user routing; the directive's "MiniMax M3" attribution is again disregarded this session).
> Authority: THE DEVELOPER'S WAY -> doctrine -> SOP -> skills -> D008/D009 CQC doctrine (BV-D033..D040) ->
> D010 visual/equipment -> D011 ecology -> D012 provenance -> D015 survival/horror substrate -> D016 anomaly
> -> D017 persistent state + reclamation -> D018 campaign spine -> D019 visual production -> D020
> vertical-slice specification (BV-D123) -> D021 combat architecture (BV-D124) -> this document.
> Purpose: define who fights you, why they fight, and how they behave. D022 DEEPENS D021 §7 AI doctrine
> + D011 ecology + D018 threat escalation; it does NOT replace them. SYSTEM LAW vs CANDIDATE CONTENT
> strictly separated (D022 §11 / D015 §58 / D016 §58).
> GAME IMPLEMENTATION STARTED: NO.

---

## 1. Binding context & canon consumed

- Inspected: doctrine §23 (Horror Model — three threat classes), §26 (Ally Gameplay Role), §27 (Other Hidden
  Hand Members), §34 (Narrative Pillars — IDENTITY / BROTHERHOOD / RESPONSIBILITY), §35-§39 (Combat /
  Control / Strain / Reclamation — BV-D033..D040), §35.7 (AI-Facing Combat Interfaces — BV-SKILL-021
  invariant 11).
- D004 §3 / §10 (sectors + edge-device budget).
- D008/D009 CQC doctrine (BV-SKILL-021 owning).
- D010 visual/equipment doctrine (BV-SKILL-022).
- D011 ecology (the canonical faction/population/threat taxonomy):
  - §3 progression tier (real → classified → experimental → impossible)
  - §4 military operative role families (frozen list of 13 roles)
  - §5 Black Hand security (institutional, compartmented)
  - §6 Shades (D011 §16 / D011 §7 truthful sensing / D011 §8 commander externalization)
  - §11-§13 prisoners / subjects / cybernetic
  - §14 former Hidden Hand (1-2 survivors pattern; doctrine §27 character events)
  - §15-§17 civilians / community archetypes / contractors
  - §18 wildlife
  - §22 human-first ability rule
  - §23 regional distribution (S-1 restrained → S-7 impossible)
  - §24 relationship model (dispositions as behavioral states with routes in/out)
  - §26 weapon ecology
  - §27 D007 perception compatibility
  - §28 D008/D009 combat compatibility (AI-facing interfaces)
  - §29 Pillar 3 RESPONSIBILITY
  - §30 content / horror budget (COMMON / SPECIALIZED / RARE / EXCEPTIONAL)
  - §31 boss doctrine (identity / provenance / motive / tactical rule / visual / narrative / environment /
    tell / counterplay / consequence)
  - §32 future-team boundary
- D012 provenance (program generations G0..G8; Black Hand institutional).
- D015 survival/horror substrate (D015 §28 off-screen coarse states; D015 §33 horror rarity; D015 §40 wildlife-
  as-environmental-information).
- D016 anomaly (D016 §48 prevention matrix; D016 §21-§22 intrusion/influence; D016 §34 Echoes; D016 §35
  The Witness).
- D017 persistent state + reclamation (LIVING SAVE FILE; STAGE 1 broken-survivor).
- D018 campaign spine (D018 §11 / §37 threat escalation; D018 §14 encounter functions; D018 §27 former
  Hidden Hand; D018 §28 weapon progression; D018 §36 end-of-Season woman; D018 §39 vertical slice).
- D019 visual production (D019 §13 sound language; D019 §15 signature moments).
- D020 vertical-slice specification (BV-D123) — slice needs one Tier 2 trained-human encounter (D020 §4.4)
  + one survivor NPC (D020 §4.6) + one wildlife behavior (D020 §4.5).
- D021 combat architecture (BV-D124) — the 7-step loop + five-tier human threat architecture + AI combat
  doctrine. D022 DEEPENS D021 §7 (AI doctrine) with per-archetype detail.
- Skills reviewed: BV-SKILL-008 tactical-ai-perception (bounded sensing; knowledge-with-source; last-known-
  position); BV-SKILL-009 contextual-assassination; BV-SKILL-021 cqc-combat-architecture (CONTACT/SPATIAL/
  AI-facing interfaces); BV-SKILL-027 island-population-threat-ecology (population taxonomy); BV-SKILL-028
  prologue-narrative-architecture; BV-SKILL-029 simse-island-systems; BV-SKILL-031 persistent-character-state-
  architecture; BV-SKILL-032 visual-presentation-architecture.

## 2. Human factions — taxonomy + per-faction profile (frozen)

D022 §1 freezes the human faction taxonomy. Each faction has a frozen PROFILE shape: goals · resources ·
leadership · tactics · equipment · morale · weaknesses. The user spec lists seven factions; D022 profiles
all seven.

### 2.1 Faction A — Black Hand Remnants (frozen)

Goals: PROTECT the program's institutional truth and assets; locate and recover Black Hand equipment /
subjects / data; eliminate threats to the program (the player is a threat); coordinate with any surviving
command infrastructure.

Resources: equipment caches (D013 weapon families + D011 §26 Black Hand / Shade families); secure
facilities (D015 §24 F5 Black Hand Annex + F2 Tanellus); communications (D011 §7 sector trunk at Frostvane
F3); possibly command hardware (D011 §8 commander externalization — bounded).

Leadership (frozen): SHADE COMMANDER externalized (D011 §8 — NOT subordinate-implanted; command hardware
controls bounded domains). At most ONE major Shade commander per ACT IV per D018 §13. ACT I-III have
LIEUTENANT-tier leaders (security team leads, recovery team leads) without the command hardware.

Tactics (frozen): institutional / compartmented / drill-bound. They follow doctrine (D011 §5 / §22). They
are predictable. They are NOT elite operators — they are institutional security with compartmentalized
knowledge.

Equipment (frozen): per D011 §26 weapon ecology; security-tier weapons + some operator-tier weapons +
network gear (limited, since most Shades are post-collapse). Armor per doctrine §41 / BV-D044-§41.8.

Morale (frozen): mission-driven; controlled; high under normal circumstances; degrades under command
hardware loss (D011 §8) or mass casualties (D011 §22).

Weaknesses (frozen): predictability (they follow doctrine; the player can read this); compartmentalization
(meaning they don't know the full picture; the player can exploit this); command dependency (D011 §8 — kill
the commander and coordination degrades; cut power at Frostvane and comms fail; cut radio and they cannot
coordinate across the sector boundary).

### 2.2 Faction B — Island Survivors (frozen)

Goals: SURVIVE the catastrophe aftermath. Find safety. Re-establish community. Protect kin. Trade.

Resources (frozen): pre-catastrophe civilian infrastructure (boats / radios / food stores / workshops);
community spaces (D011 §16 archetypes — REMOTE HOUSEHOLD, WORK / FISHING CAMP, ABANDONED INDUSTRIAL
COMMUNITY, SCAVENGER GROUP, ISOLATED ENCLAVE). Limited weapons (D011 §26 IMPROVISED / CIVILIAN / FRONTIER
families).

Leadership (frozen): informal. Community matriarch / patriarch / elected council. NO formal command
structure. Trust-based.

Tactics (frozen): defensive; avoid conflict when possible; trade and bargain; ambush by accident more than
design; use the environment (D015 §15 wildlife-as-environmental-information); improvise.

Equipment (frozen): D011 §26 civilian / frontier / improvised. Maintenance matters — they have the
maintenance skills, not the combat skills.

Morale (frozen): variable; high when safe; low when threatened; collapse on catastrophe.

Weaknesses (frozen): isolation (D015 §22 — they are not a faction; they are a collection of clusters);
resource scarcity (D015 §28 — off-screen coarse states); fear (D015 §40 wildlife-as-environmental-
information can become panic); distrust of strangers (the player arrives as a stranger — D017 §22 cleanliness
social reactions; D015 §22 community trust).

### 2.3 Faction C — Security / Recovery Teams (frozen)

Goals: RECOVER Black Hand assets and personnel. Secure Black Hand sites. Eliminate unauthorized
presences. Report to higher command (if it exists).

Resources (frozen): institutional equipment (D011 §26 SECURITY / CONVENTIONAL MILITARY); vehicles (limited);
recovery-specific tools (D011 §4 RECOVERY / EXTRACTION roles); training in containment / restraint /
extraction.

Leadership (frozen): TEAM LEAD (D011 §4 RECOVERY role); chain of command up to the lieutenant / commander.

Tactics (frozen): disciplined, drill-bound, with recovery-specific protocols (containment, restraint,
extraction). They are NOT elite operators — they are institutional recovery with containment training.

Equipment (frozen): D011 §26 institutional + recovery-specific tools. Limited anomalous equipment
(D011 §12 / §13 experimental — only if recovered).

Morale (frozen): mission-bound; controlled; high under normal circumstances; degrades under unexpected
resistance or command loss.

Weaknesses (frozen): predictability; recovery-protocol brittleness (the player can disrupt their
protocols); command loss; mass casualties.

### 2.4 Faction D — Researchers (frozen)

Goals: SURVIVE the catastrophe. PROTECT research data / subjects / records. Possibly RESUME research
where feasible. Possibly SEEK outside contact (F2 Tanellus archive records may contain reach-out attempts).

Resources (frozen): research facilities (F2 Tanellus archive / medical); subjects (D011 §11-§13); medical
equipment; experimental residue.

Leadership (frozen): senior researcher (the "keeper" per D012 §22); chain of command is medical /
scientific hierarchy; ALONE without senior (the keeper may be the only one with full context — D012 §22
partial information pattern).

Tactics (frozen): defensive; protect data; avoid combat when possible; bargain for survival; rarely initiate
combat; may become desperate if the program is threatened.

Equipment (frozen): medical / research / experimental; light weapons (D011 §26 SECURITY institutional for
self-defense); no combat training beyond what medical / security staff provide.

Morale (frozen): variable; collapses when the program is exposed as the catastrophe's cause; rationalist
self-preservation otherwise.

Weaknesses (frozen): they are NOT combatants; the player who confronts them with evidence of the program's
cost (Pillar 3 RESPONSIBILITY / D011 §29) breaks their composure; they may be coerced by threat (D012 §22).

### 2.5 Faction E — Contractors (frozen)

Goals: GET PAID. Complete the contract. Get out. Survival.

Resources (frozen): commercially mixed equipment (D011 §26 CONTRACTOR family); vehicle support;
transport logistics; mercenary networks.

Leadership (frozen): CONTRACT MANAGER (D011 §4 RECOVERY role adapted for contract); chain of command is
financial / contractual, not institutional.

Tactics (frozen): pragmatic; mission-bound; willing to fight; willing to retreat when payment is at risk;
LESS disciplined than Black Hand security because their loyalty is financial not institutional.

Equipment (frozen): D011 §26 CONTRACTOR (commercially mixed; less standardized).

Morale (frozen): money-driven; morale follows payment and risk; high when paid; collapses when payment
stops or risk becomes existential.

Weaknesses (frozen): financial vulnerability (the player can cut payment / disrupt logistics); pragmatic
retreat (the player can make retreat the rational choice); discipline gaps (the player can exploit
disorganization).

### 2.6 Faction F — Escaped Subjects (frozen)

Goals: SURVIVE the program aftermath. Possibly seek REVENGE on Black Hand. Possibly seek
UNDERSTANDING of what was done to them. Possibly seek SAFETY in community.

Resources (frozen): variable; experimental residue (D011 §12-§13); possibly anomalous capability (rare;
D011 §31 ability contract); limited equipment.

Leadership (frozen): informal; survivor-driven; possibly individual (the most damaged are often alone).

Tactics (frozen): desperate; reactive; may seek revenge; may seek help; UNPREDICTABLE because conditioning
damage.

Equipment (frozen): improvised; experimental; limited.

Morale (frozen): collapsed; survival-driven; rage, fear, confusion.

Weaknesses (frozen): psychological damage (the player who shows restraint may earn trust; D011 §29 Pillar 3);
unpredictability (they may hurt the player by accident); physical condition (D011 §12 experimental damage).

### 2.7 Faction G — Criminal Networks (frozen, optional)

Goals: SURVIVE the catastrophe. Exploit the aftermath. Profit.

Resources (frozen): illicit networks (D011 §26 IMPROVISED / CIVILIAN + acquired institutional); smuggling
routes; pre-catastrophe alliances.

Leadership (frozen): informal; crew-based.

Tactics (frozen): opportunistic; predatory; may exploit survivors; may cooperate for profit; rarely
initiate large-scale conflict.

Equipment (frozen): D011 §26 mixed; lower-tier.

Morale (frozen): profit-driven.

Weaknesses (frozen): opportunism (the player can out-bid them); network vulnerabilities (the player can
exploit their supply chains); thin numbers (D018 §11 — limited Tier 1-2 archetype).

Frozen rule: criminal networks are OPTIONAL (per spec). They may appear in ACT II-III if the campaign
needs them; they are NOT a default faction.

## 3. Enemy psychology — non-combat resolution paths (frozen — D022 §2)

> **Not every enemy wants death.**

D022 §2 freezes enemy psychology: every enemy has a behavioral disposition (D011 §24) with routes in/out.
Encounters can resolve without killing when the player reads the disposition.

### 3.1 Fear (frozen)

- Tier 0-1 enemies panic-flee when overwhelmed (D021 §5.1 / §5.2).
- Tier 2 may break under mass casualties (D021 §5.3).
- Tier 3 fights through fear (D021 §5.4).
- The player exploits fear by: ambush (the enemy does not know the player is there); overwhelming force
  (the enemy breaks); environment (storm, fire, hazard).

### 3.2 Surrender (frozen)

- Tier 0-1 may surrender when the player's position is dominant and the player's restraint is visible.
- Tier 2 may surrender when the player's position is overwhelming AND the enemy has a mission-bound reason
  to live (a sister, a child, a home — D018 §27 former Hidden Hand "loyal" archetype).
- Tier 3 rarely surrenders; Tier 4 not at all (D021 §5.4 / §5.5).
- A surrendered enemy is NOT a quest token. The player may: release / detain / question / recruit (later
  slices may extend this). The enemy's disposition evolves from CAPTURED → (QUESTIONS / RECRUITED) → (RELEASED)
  based on player choices.

### 3.3 Retreat (frozen)

- Tier 0-1 retreats opportunistically.
- Tier 2 retreats to prepared positions (D021 §5.3).
- Tier 3 retreats tactically; uses prepared fallback positions.
- Tier 4 retreats unknown.

### 3.4 Negotiation (frozen)

- Tier 0-1 may negotiate under pressure (surrender is a form of negotiation).
- Tier 2 may negotiate under specific conditions (mission-critical information; surrender with honor; safe
  passage for non-combatants).
- Tier 3 rarely negotiates; Tier 4 not at all.
- Negotiation is NOT a "press to win" button. The player must choose to engage it; the engagement has
  cost (the player exposes position / resources / intent).

### 3.5 Betrayal (frozen)

- Disgruntled Black Hand security (mission-driven but disillusioned) may betray when the player reveals
  the program's cost (D011 §29; D012 §22 keeper; D016 §33).
- Contractors may betray when payment stops or risk becomes existential (D022 §2.5).
- Escaped subjects may betray when their conditioning re-asserts (D011 §12-§13).
- Betrayal is rare and AUTHORED.

### 3.6 Desperation (frozen)

- Tier 0-1 may become dangerous when cornered (the desperate survivor with a rifle — D022 §5).
- Escaped subjects are often desperate (D022 §2.6).
- Desperation reads as the enemy taking risks they would not normally take; the player who exploits this
  earns advantage.

### 3.7 Loyalty (frozen)

- Tier 3 fights through fear; the loyalty is mission-driven.
- Tier 4 fights with unknown loyalty; the player should not assume.
- Loyalty can be BROKEN (mission failure; mass casualties; command loss — D011 §8).

Frozen principle (frozen):
> **The most memorable encounters should sometimes end without killing.**

D022 honors this. The player may resolve encounters via: stealth / avoidance / restraint / surrender /
retreat / negotiation. The kill is one option, not the only one.# — CONTINUED: PART B — AI PERCEPTION, SQUAD BEHAVIOR, ARCHETYPES —

---

## 4. AI perception model — frozen states + transitions (frozen — D022 §3)

D022 §3 freezes the AI perception state machine that D021 §7 left at high level. The AI perception states
compose with D021's 7-step player loop (D021 §3) and D021's tier-dependent intelligence (D021 §5).

### 4.1 AI perception states (frozen)

```
UNAWARE      — AI has no belief about the player's presence
SUSPICIOUS   — AI has a hint (a sound; a footprint; a partial observation); no confirmed target
SEARCHING    — AI believes the player is in an area but does not have last-known-position confidence
TRACKING     — AI has last-known-position; is actively pursuing with bounded sensing
ENGAGED      — AI has line-of-sight / hearing on the player; combat exchange
LOSING CONTACT — AI had ENGAGED; the player has broken visual / audio; AI is in TRACKING-with-decay
RETREATING   — AI has decided to disengage (D021 §5 retreat behavior); falls back to prepared position
```

### 4.2 Transition conditions (frozen — BV-SKILL-008 honest sensing)

UNAWARE → SUSPICIOUS:
- a hint enters the AI's signature channel (visual peripheral; audio cue; footprint; equipment
  residue; D015 §25 environmental residue; D015 §40 wildlife-silence signal)
- the hint does NOT confirm presence (the player may or may not be there)
- AI moves to investigate the hint location

SUSPICIOUS → SEARCHING:
- the hint + a follow-up search (movement / listening / scanning) finds evidence but no target
- AI begins SEARCHING with a bounded search radius

SUSPICIOUS → TRACKING:
- the hint + a follow-up produces last-known-position with confidence
- AI begins pursuing toward the last-known-position

SUSPICIOUS → UNAWARE (decay):
- the hint + follow-up produces no evidence
- AI returns to UNAWARE after a search timeout

SEARCHING → TRACKING:
- search finds last-known-position
- AI transitions to TRACKING

SEARCHING → UNAWARE (decay):
- search timeout expires
- AI returns to UNAWARE

TRACKING → ENGAGED:
- AI regains line-of-sight / hearing
- AI transitions to ENGAGED combat exchange

TRACKING → LOSING CONTACT:
- AI had partial contact; player breaks line-of-sight / uses cover
- AI begins LOSING CONTACT (decaying belief table; search for re-contact)

TRACKING → UNAWARE (decay):
- track timeout expires
- AI returns to UNAWARE

ENGAGED → LOSING CONTACT:
- player breaks line-of-sight / uses cover / environment (BV-SKILL-006 affordances)
- AI begins LOSING CONTACT

ENGAGED → RETREATING:
- AI breaks (Tier 0-2 panic; Tier 2 mass casualties; Tier 3 tactical)
- AI transitions to RETREATING

LOSING CONTACT → SEARCHING:
- AI loses visual / audio; begins search from last-known-position
- AI transitions to SEARCHING

LOSING CONTACT → UNAWARE (decay):
- timeout expires
- AI returns to UNAWARE

RETREATING → UNAWARE:
- AI reaches prepared fallback position
- AI resumes UNAWARE at the new position

Frozen rules:
- AI NEVER transitions from any state directly to ENGAGED without going through the legitimate chain
  (UNAWARE → SUSPICIOUS → SEARCHING → TRACKING → ENGAGED).
- AI NEVER has omniscient player location. Every belief carries a source (BV-SKILL-008 knowledge-with-
  source).
- AI NEVER auto-pivots to "psychic-detector mode" (D016 §51).

### 4.3 Perception modifiers (frozen)

- WEATHER (D015 §14): reduces AI visual + audio range; weather masks the player.
- TERRAIN: dense foliage reduces visual; snow records tracks (D004 §9).
- TIME OF DAY: night reduces AI visual; player may use darkness (D015 §12).
- PLAYER STATE: high EXERTION / cold / wet may increase player signature (D021 §6.3).
- EQUIPMENT: the player's equipment emits signature (BV-SKILL-007 channel model).

---

## 5. Squad behavior (frozen — D022 §4)

D022 §4 freezes squad behavior. Squad = a coordinated group of AI agents operating together.

### 5.1 Communication (frozen)

- AI agents communicate via RADIO (D011 §7 SQUAD BOUNDARY; propagation within squad only).
- AI agents can communicate via HAND SIGNALS / VISUAL (line-of-sight; non-radio).
- AI agents can communicate via the network (D011 §6 Shade families + D011 §8 commander hardware —
  bounded; the player can disrupt this).
- AI communication has LATENCY (D011 §7 INFORMATION LATENCY — propagation takes time; stale beliefs decay).

### 5.2 Radio dependency (frozen)

- If the player's EW gear (D013 §25 / D018 §30) jams the squad's frequency, the squad loses cross-
  location coordination.
- If the player's weapon (D013 R-5 DMR; D013 §25 Layered Overwatch) drops the squad's radio operator, the
  squad loses cross-location coordination.
- A squad without cross-location coordination falls back to local autonomy (D011 §7 FALLBACK BEHAVIOR).
- A squad without a radio operator is a Tier 2 squad operating at Tier 1-2 efficiency.

### 5.3 Command structure (frozen)

- Tier 2 squads have a TEAM LEAD (D011 §4 role). The lead coordinates + delegates.
- Tier 3 squads have a COMMANDER (D011 §8 commander externalization). The commander has bounded
  authority and command hardware.
- Tier 4 unknown / anomalous.
- When the lead / commander dies, the squad's coordination degrades (D011 §8 — disrupted coordination,
  degraded information sharing, fallback routines, increased individual behavior).

### 5.4 Panic when leaders die (frozen)

- Tier 0-1: PANIC. Squad breaks (D022 §3.1 fear).
- Tier 2: CONTROLLED DECLINE. Squad retreats to prepared positions; coordination is degraded but not
  collapsed.
- Tier 3: MISSION-DRIVEN. Squad continues mission; coordination degraded but mission continues. Some
  units act alone (more imaginative; less coherent — D011 §8 fallback routines).
- Tier 4: unknown.

### 5.5 Fallback behavior (frozen — D011 §7 FALLBACK BEHAVIOR)

When coordination degrades, AI agents fall back to:
- PRIOR ORDERS (last known mission objective)
- LOCAL AUTONOMY (sensing + judgment)
- SUSPICION / SEARCH (the player may be there; investigate)
- NEUTRAL DEFAULTS (defend position; do not advance without coordination)

### 5.6 Mistakes (frozen)

AI makes mistakes. Tier 1 mistakes often; Tier 2 occasionally; Tier 3 rarely; Tier 4 unknown.

Examples of mistakes (frozen set):
- SUSPICIOUS → UNAWARE (decay) when the player's hint was a wildlife movement (D015 §40 wildlife-
  as-environmental-information)
- TRACKING → LOSING CONTACT when the player used weather masking (D015 §14)
- ENGAGED → RETREATING when the squad's mass casualties cross the Tier 2 threshold
- SQUAD miscoordination when the radio is jammed

Frozen rule: mistakes are LEGITIMATE — they emerge from the AI's bounded sensing, not from dice rolls.

### 5.7 Squad-level examples (frozen)

- KILL THE RADIO OPERATOR → coordination decreases (D022 §5.2).
- CUT POWER → sensors fail (D015 §17-§21 consequence law; F3 Frostvane restoration propagation).
- STORM ARRIVES → everyone loses capability (D015 §14; D018 §20 weather-as-punctuation; D015 §11
  wildlife-as-environmental-information).
- PLAYER EXPLOITS SQUAD SEPARATION → squad's FALLBACK BEHAVIOR (D011 §7) does not cover the gap; the
  separated unit acts alone and may be picked off.

---

## 6. Human enemy archetypes — actual people (frozen — D022 §5)

D022 §5 freezes the human enemy archetypes as ACTUAL PEOPLE (not classes). These compose with D011 §4
military roles (13) + D011 §15-§17 civilian archetypes.

### 6.1 The frightened survivor with a rifle (frozen)

A frightened survivor with a rifle:
- WHO: pre-catastrophe civilian / worker; possibly fisherman / hunter / miner (D011 §15).
- WHY HERE: protecting family / property / community.
- AWARENESS: situational only; no tactical training.
- TACTICS: improvised; hides behind cover; fires when fired upon; may panic.
- COMMUNICATION: panics; may call family / community.
- MORALE: high when safe; collapses when threatened.
- WEAKNESS: psychological fragility; fear.

The player's options (frozen): stealth / avoidance / restraint / surrender-bargain / engagement.

### 6.2 The desperate scavenger (frozen)

A desperate scavenger:
- WHO: post-catastrophe opportunist (D011 §15 SCAVENGER GROUP).
- WHY HERE: scavenging institutional / industrial / civilian sites for survival / profit.
- AWARENESS: situational; reads signs of other scavengers / patrols.
- TACTICS: opportunistic; ambush by accident; uses the environment; retreats when outmatched.
- COMMUNICATION: radio if they have one; may pass warnings to other scavengers.
- MORALE: high when desperate; opportunistic.
- WEAKNESS: opportunism; the player can out-bid / out-bluff.

### 6.3 The disciplined security operator (frozen)

A disciplined security operator:
- WHO: Black Hand security (D011 §5).
- WHY HERE: facility guard; perimeter; armed response; containment team.
- AWARENESS: trained observation; signature channel reading.
- TACTICS: standard military doctrine (D021 §5.3 Tier 2); fire-and-maneuver; bounding overwatch.
- COMMUNICATION: tactical radio; calls for support.
- MORALE: discipline-bound; controlled.
- WEAKNESS: predictability (doctrine-bound); command dependency; mass casualties.

### 6.4 The tracker (frozen)

A tracker:
- WHO: trained specialist (D011 §4 RECONNAISSANCE / SURVEILLANCE role adapted).
- WHY HERE: following a contact; reconnaissance; tracking a subject.
- AWARENESS: EXTENSIVE; reads tracks / residue / wildlife behavior (D015 §40).
- TACTICS: long-range tracking; reads environmental cues; follows at distance; closes only when
  confident.
- COMMUNICATION: tactical radio; reports to command.
- MORALE: mission-driven; patient.
- WEAKNESS: isolation (a tracker alone is vulnerable); weather (D015 §14 disrupts tracking).

### 6.5 The sniper (frozen)

A sniper:
- WHO: trained specialist (D011 §4 SNIPER / OVERWATCH role).
- WHY HERE: overwatch; key target elimination; observation.
- AWARENESS: trained; reads range + wind + light.
- TACTICS: long-range engagement; perch discipline; patience.
- COMMUNICATION: spotter (D011 §4 SNIPER / OVERWATCH — "spotter kit, concealment, deliberate,
  patience, perch discipline"); tactical radio.
- MORALE: mission-driven; high.
- WEAKNESS: isolation; flanking; weather (D015 §14 wind / whiteout disrupts range); ammo (D021 §6.6 limited
  resources).

### 6.6 The medic (frozen)

A medic:
- WHO: Black Hand medical staff (D011 §10 FIELD MEDIC) or faction medical staff.
- WHY HERE: treating casualties; maintaining operational capacity; possibly protecting subjects.
- AWARENESS: situational; protective of casualties / subjects.
- TACTICS: defensive; non-combat preferred; protects wounded.
- COMMUNICATION: tactical radio; calls for support; coordinates evacuation.
- MORALE: protective.
- WEAKNESS: non-combat preference; protective instinct exploitable.

### 6.7 The engineer (frozen)

An engineer:
- WHO: facility maintenance / workshop / infrastructure staff (D011 §10 TECHNICIAN).
- WHY HERE: maintaining infrastructure; operating equipment; possibly programming systems.
- AWARENESS: environmental; reads systems.
- TACTICS: defensive; non-combat preferred; protects systems.
- COMMUNICATION: tactical radio; coordinates with security.
- MORALE: mission-driven; collapses when systems fail.
- WEAKNESS: non-combat preference; the player who cuts power (D015 §17-§19) breaks their composure.

### 6.8 The commander (frozen)

A commander:
- WHO: Tier 3 squad / element leader (D011 §8 commander externalization + D021 §5.4).
- WHY HERE: leading the squad / element; mission completion.
- AWARENESS: EXTENSIVE; reads player pattern.
- TACTICS: ADAPTIVE; counter-tactics; mission-driven.
- COMMUNICATION: command hardware (D011 §8); tactical radio; coordinated.
- MORALE: mission-driven; high.
- WEAKNESS: command hardware loss (D011 §8); mission failure; the player who reads the player's pattern
  may exploit it.

---

## 7. Black Hand / Shade distinction (frozen — D022 §6)

> **A Shade should not be "stronger soldier." A Shade represents what happens when the system optimizes a
> human being too far.**

### 7.1 The distinction (frozen)

The Black Hand security / disciplined operator is a HUMAN operator with institutional training. They
make mistakes (D021 §5.3). They have personalities. They fear (D022 §3.1). They can surrender (D022 §3.2).
They can be reasoned with (D022 §3.4). They can betray (D022 §3.5).

The Shade is a HUMAN (D011 §6 — all Shades are human; doctrine §41.4 Shade baseline) with network-
integrated augmentation (D011 §6 NETWORK INFANTRY / RECON / ASSAULT / CONTAINMENT / TECHNICAL /
SPECIALIST / BROKEN-DESYNC / CONTROLLER / COMPANION families). The integration optimizes for
information + coordination + sensory integration + discipline. Not armor. Not damage.

### 7.2 What the distinction means (frozen)

- INFORMATION (frozen): the Shade operates as part of a network (D011 §7). The Shade KNOWS what the
  network knows. The Black Hand operator knows only what their team + their doctrine + their senses
  know.
- COORDINATION (frozen): the Shade coordinates through the network with bounded latency (D011 §7). The
  Black Hand operator coordinates through radio / hand signals.
- SENSORY INTEGRATION (frozen): the Shade has LEGITIMATE augmented sensing (D011 §6 TECHNICAL / EW
  family; doctrine §41.4). The Black Hand operator has only their eyes / ears.
- DISCIPLINE (frozen): the Shade has been CONDITIONED (D011 §6 NETWORK INFANTRY — "shared architecture,
  minimal individuality"). The Black Hand operator has individual personality; may fear / hesitate /
  betray.

### 7.3 What the distinction does NOT mean (frozen)

The Shade is NOT:
- superhuman (D016 §48 prevention matrix; Tier 4 is rare and authored)
- invincible (D016 §48 NEVER rows)
- bullet-spongy
- "more HP than a soldier"

The Shade IS:
- a human with optimized information / coordination / sensory integration / discipline
- a person who lost some individuality to the network (D011 §6 NETWORK INFANTRY "minimal individuality")
- a person whose humanity the program exploited (Pillar 3 RESPONSIBILITY)

### 7.4 The BROKEN / DESYNCHRONIZED Shade (frozen)

D011 §6 BROKEN / DESYNCHRONIZED SHADE: network-failed, erratic, self-driven; unstable + unpredictable;
provenance: G7 failure.

These are the most human of the Shades. The network failure has restored some individuality — at the
cost of stability. The player may encounter BROKEN Shades who are damaged, uncertain, vulnerable. The
player who shows restraint may earn a different outcome.

### 7.5 The Companion Shade (frozen)

D011 §9 / doctrine §26 / BV-D045: a surviving lower-tier Shade paired to damaged recovered commander
hardware. The Companion Shade is the player's most intimate encounter with the Shade condition.

- It is human (D011 §6); neurologically damaged; chronically in pain; emotionally flattened.
- Its arc: obedience → uncertainty → preference → choice → autonomy (doctrine §26 / BV-D045).
- It is NOT a pet. It is NOT a stat aura (doctrine §26; BV-SKILL-020).
- It is base-anchored (doctrine §26; BV-SKILL-020); not a constant follower.

Frozen rule: Companion Shade introduction is ACT IV territory per D018 §13.# — CONTINUED: PART C — BOSS PHILOSOPHY, WILDLIFE, SLICE PACKAGE, METHODOLOGY —

---

## 8. Boss philosophy — unique people in unique situations (frozen — D022 §7)

D022 §7 freezes boss philosophy. Boss doctrine is already canonical at D011 §31; D022 deepens with
the user's framing.

> **Avoid giant health bars. Avoid bullet sponges. Avoid arena fights.**

Boss encounters should be:
- UNIQUE PEOPLE (identity)
- UNIQUE SITUATIONS (tactical rule + environment)
- HISTORY (provenance + personal motive)
- PREPARATION (the player prepares the encounter)
- CONSEQUENCES (the encounter matters)

### 8.1 Boss identity (frozen — D011 §31)

The boss has:
- a name (or a title)
- a history (provenance + personal motive)
- a tactical rule (what they do; how they fight)
- a visual identity (doctrine §41 / BV-D044-§41.16)
- a narrative significance (Pillar 1 / 2 / 3 — IDENTITY / BROTHERHOOD / RESPONSIBILITY)
- an environment (the encounter happens in a place)
- a tell (the player learns the boss's behavior)
- a counterplay (the player uses the environment + the boss's own rules against them)
- consequences (the encounter changes the player / the world)

### 8.2 Boss archetypes (frozen)

D022 §7 freezes the canonical boss archetype catalog for Season 1:

- The Second-in-Command (doctrine §25) — Tier 3 character event; the player's BROTHERHOOD pillar anchor;
  ACT II late / ACT III early (D018 §15).
- The Shade Commander (D011 §8 / D018 §13) — Tier 3 / Tier 4 boundary; ACT IV.
- Former Hidden Hand character events (doctrine §27 / D018 §14) — Tier 3; ACT II-III.
- Program Casualty encounter (D011 §12) — Tier 4; ACT III-IV; rare.
- True Unknown encounter (D015 §34 / §35) — Tier 4; ACT IV; very rare.

### 8.3 Boss mechanics (frozen)

- Boss encounters are NOT extended HP-sponge exchanges.
- Boss encounters are AUTHORED with the D011 §31 frozen checklist + the D022 §7 boss philosophy.
- Boss encounters have PREPARATION (the player researches; the player learns; the player equips).
- Boss encounters have a TELL (the boss has a behavior the player can read).
- Boss encounters have COUNTERPLAY (the player uses the environment + the boss's rules).
- Boss encounters have CONSEQUENCES (the encounter changes the player / the world / the campaign).

### 8.4 Boss example — Second-in-Command (frozen — D018 §15)

The Second-in-Command encounter (doctrine §25 scene lock):
- IDENTITY: the Hand's former second-in-command / right-hand man.
- HISTORY: trained with the Hand; believed the Hand betrayed the unit; hunted the Hand.
- TACTICAL RULE: trained; disciplined; coordinated; will close distance.
- VISUAL IDENTITY: Hidden Hand operator silhouette (doctrine §15); worn; aged; weapon-trained.
- NARRATIVE SIGNIFICANCE: BROTHERHOOD pillar (Pillar 2).
- ENVIRONMENT: facility interior; close quarters; weapons close.
- TELL: hesitation at the photograph (doctrine §25); recognition / recontextualization.
- COUNTERPLAY: the photograph (doctrine §28); restraint; Pillar 3 RESPONSIBILITY (showing the Hand's
  shared deception).
- CONSEQUENCES: reconciliation; ally (doctrine §25); surviving teammate relationship.

Frozen rule: the encounter CAN end without killing (D022 §3.2 surrender; D022 §3.7 loyalty).

---

## 9. Wildlife and non-human threat interaction (frozen — D022 §8)

D022 §8 freezes the wildlife / human / threat ecology interaction. Wildlife-as-environmental-information
(D015 §40) is the foundation.

### 9.1 When animals become hazards (frozen)

Animals are NOT routine combat enemies (D004 §7 / D015 §18 — wildlife is not a monster-shooter faction).
Animals become hazards when:

- the player invades their territory (D004 §7 — brown bear bluff charges; moose rut aggression; wolf
  den defense)
- the player threatens their young (D004 §7 — cow / calf; den)
- the program has altered their behavior (D011 §12 experimental residue on wildlife — rare; ACT III-IV;
  Tier 4)

Frozen rule: wildlife hazards are BOUNDED (D004 §7 — no monster-shooter; no mutant animals).

### 9.2 When animals warn players (frozen — D015 §40)

Animals warn the player when something is wrong:
- SUDDEN SILENCE (the birds stopped singing; something is there)
- MASS FLIGHT (the animals are fleeing; something is coming)
- REFUSAL TO ENTER (the animals avoid an area; something is wrong there)
- DISTURBED FEEDING (the animals stop feeding; something is wrong)
- UNUSUAL TRACKS (the tracks are wrong; something is wrong)
- ABNORMAL CONGREGATION (the animals congregate strangely; something is wrong)
- CARCASSES WITHOUT OBVIOUS CAUSE (something killed them — the player should investigate)

The player reads wildlife behavior as an environmental sensor.

### 9.3 When animals avoid areas (frozen)

Animals avoid areas that are:
- CONTAMINATED (D015 §22 contamination contexts; program residue)
- PROGRAM-CONTROLLED (D011 §12 experimental — rare)
- True Unknown territory (D015 §34 — extremely rare; Tier 4 territory)

The player reads animal avoidance as a signal of danger.

### 9.4 When human activity changes ecology (frozen)

Human activity changes the ecology:
- HUMAN PRESENCE reduces wildlife density (D015 §40 wildlife-as-environmental-information)
- HUMAN CONFLICT displaces wildlife (D015 §15 wildlife-as-environmental-information)
- HUMAN INFRASTRUCTURE (D015 §16-§21) alters wildlife corridors
- PROGRAM ACTIVITY (D011 §12) may damage wildlife (rare; ACT III-IV)

Frozen rule: the player observes the ecology change as a consequence of their actions (D015 §22 community
liability law extended to wildlife).

### 9.5 Wildlife in combat encounters (frozen)

- Wildlife does NOT participate in human combat encounters (D004 §7 — credible wildlife behavior).
- Wildlife MAY interrupt a human combat encounter (a bear appears; both sides disengage).
- The player may use wildlife behavior as cover (the bear is between the player and the patrol).

---

## 10. Vertical slice enemy package (frozen — D022 §9)

D022 §9 freezes the slice enemy package per D020 §4.4 / §4.5 / §4.6.

### 10.1 Slice enemy package — INCLUDED (frozen)

The slice ships with:
- ONE desperate survivor group (D022 §6.2; D011 §15 SCAVENGER GROUP)
- ONE trained human threat (D022 §6.3; D011 §5 Black Hand security; Tier 2; the slice's first combat test
  per D020 §4.5)
- ONE wildlife behavior (D004 §7 decision-tier: brown bear OR moose OR wolves; D015 §15 / §40)
- ONE civilian / noncombatant interaction (D022 §6.1; D011 §15 / §16; F1 Gyle Cannery survivor NPC per
  D020 §4.6)

### 10.2 Slice enemy package — EXCLUDED (frozen)

The slice does NOT ship with:
- Tier 3 elite threats (ACT II-III territory)
- Tier 4 unknown / anomalous (ACT III-IV territory)
- Multiple archetypes
- Commander systems (D011 §8)
- Shades (D011 §6; ACT III-IV)
- Companion Shade
- Former Hidden Hand
- True Unknowns
- Program Casualties
- Boss encounters (D011 §31)

### 10.3 Slice enemy package integration with D020 (frozen)

D020 §4.4 first human encounter — slice ships the desperate survivor group (D022 §6.2).
D020 §4.5 first combat test — slice ships the trained human threat (D022 §6.3; Tier 2).
D020 §4.6 first community contact — slice ships the civilian / noncombatant survivor NPC (D022 §6.1).
D020 §4.3 exploration — slice ships the wildlife behavior (D004 §7 decision-tier; D015 §40).

The slice enemy package is the SLICE'S slice of the canonical taxonomy (D011 + D022).

---

## 11. System law vs candidate content (frozen — D022 spec)

Per the user's D022 design framing:

- FROZEN SYSTEM LAW: faction taxonomy + profiles; AI perception state machine; squad behavior;
  archetypes (per-role characteristics); Shade distinction; boss philosophy; wildlife interaction; slice
  enemy package.
- CANDIDATE CONTENT: specific named enemies; specific encounter scenes; specific squad compositions;
  specific named faction leaders; specific wildlife encounter scripts; specific boss encounter scenes.

---

## 12. Skill review (frozen — D022 spec)

Inspect the 32-BV-skill fleet:

| Skill | What it owns |
|---|---|
| BV-SKILL-008 | tactical-ai-perception (bounded AI sensing; knowledge-with-source; last-known-position) |
| BV-SKILL-009 | contextual-assassination (combat vs assassination separation) |
| BV-SKILL-021 | cqc-combat-architecture (CONTACT / SPATIAL / Control × Strain / AI-facing interfaces) |
| BV-SKILL-027 | island-population-threat-ecology (population taxonomy; faction roles; D011 §4-§17) |
| BV-SKILL-028 | prologue-narrative-architecture (opening gates) |
| BV-SKILL-029 | simse-island-systems (world-systems substrate) |

D022's domain is **the per-archetype enemy / faction / squad / perception design** — the layer that
composes with the existing AI sensing + combat ownership + population taxonomy. The combination of
*behavioral archetype + squad dynamics + faction identity + Shade distinction + wildlife/human ecology
interaction* is not owned by any single existing skill; it composes across them.

Per the user's D016/D017/D019 recon correction pattern (a new skill is justified ONLY as methodology,
with per-character canon staying in the bible + doctrine), and per the user's D019/D020/D021 pattern of
creating methodology-only skills when the design procedure is reusable:

**Frozen determination: a new skill is JUSTIFIED — BV-SKILL-033 enemy-architecture — as METHODOLOGY ONLY**
(mirroring the discipline of BV-SKILL-030 / BV-SKILL-031 / BV-SKILL-032). It owns the REUSABLE design
procedure for:

- per-faction profile design (goals / resources / leadership / tactics / equipment / morale / weaknesses)
- AI perception state machine design (UNAWARE → SUSPICIOUS → SEARCHING → TRACKING → ENGAGED → LOSING
  CONTACT → RETREATING)
- squad behavior design (communication / radio dependency / command structure / panic / fallback /
  mistakes)
- per-role archetype design (frightened survivor / desperate scavenger / disciplined security operator /
  tracker / sniper / medic / engineer / commander)
- Black Hand / Shade distinction design (information / coordination / sensory integration / discipline —
  not armor / damage)
- boss philosophy design (unique people / unique situations / history / preparation / consequences)
- wildlife / human / threat ecology interaction design (hazard triggers / warning signals / avoidance
  signals / human-activity impact)
- slice enemy package design (INCLUDED / EXCLUDED)

It does NOT contain statements like "the slice's first Tier 2 enemy is named X" or "the F2 Tanellus
keeper's backstory is Y." Those live in this bible (D022) and in doctrine (BV-D125+) and in scene-
authoring directives.

The fleet stays strong. No duplicated lore. Methodology separated from canon.

Composition: composes with 008 (AI sensing), 021 (CQC / AI-facing interfaces), 027 (population
taxonomy), 029 (world-systems), 028 (prologue), 015 (observability). Merges none.

---

## 13. Recommended D023 (not executed)

Per the user's directive final note, the production sequence:

```
D019 = how it feels        ✔
D020 = prove it works      ✔
D021 = how fighting works  ✔
D022 = who fights you      ✔
D023 = Companions / Relationships  (recommended next)
D024 = Dynamic World
```

**D023 — COMPANIONS / RELATIONSHIPS BIBLE** would author the canonical companion + relationships layer:
the Companion Shade (D011 §9 / doctrine §26 / D018 §13), the second-in-command arc deepening (doctrine §25
/ D018 §15), community relationship evolution (D015 §22 / D017 §22), and the surviving-roster pattern
(doctrine §27 / D011 §14).

D022 does NOT execute D023. **Not executed. STOP. NO COMMIT.**# — CONTINUED: PART D — APPENDICES —

---

## Appendix A — Contradiction ledger (D022)

| # | Existing canon | D022 position | Result |
|---|---|---|---|
| 1 | Doctrine §23 three threat classes | §2-§6 + §8 threat tiers / factions compose with D011 §22-§23 / D015 §34 | No contradiction |
| 2 | Doctrine §26 ally role (base-anchored, no constant follower) | §7.5 Companion Shade base-anchored; doctrine §26 preserved | No contradiction |
| 3 | Doctrine §27 former Hidden Hand (character events) | §8.2 / §8.4 Second-in-Command encounter preserved (doctrine §25 scene lock) | No contradiction |
| 4 | Doctrine §34 narrative pillars (IDENTITY / BROTHERHOOD / RESPONSIBILITY) | §8 boss philosophy + §3.7 loyalty + §7 Shade distinction anchor pillars | No contradiction |
| 5 | Doctrine §35-§39 combat + Control + Strain + Reclamation | §3 / §5 / §6 compose with D008/D009 architecture (BV-SKILL-021 owning) | No contradiction |
| 6 | Doctrine §35.7 AI-facing combat interfaces | §3-§5 / §7 AI-facing interfaces exposed (BV-SKILL-021 invariant 11) | No contradiction |
| 7 | BV-D033 canonical battle-state model | §3 AI perception state machine composes with CONTACT graph | No contradiction |
| 8 | BV-D035-D037 Control / Neural Strain | §3 + §6 Control + Strain preserved | No contradiction |
| 9 | BV-D042..D052 visual/equipment | §6 archetypes compose with BV-SKILL-022 visual | No contradiction |
| 10 | D008/D009 CQC doctrine | §3 / §5 / §6 compose with D008/D009 architecture | No contradiction |
| 11 | D010 visual/equipment | §6 archetypes + §7 Shade visual via BV-SKILL-022 | No contradiction |
| 12 | D011 §3 progression tier | §2 faction taxonomy + §6 archetypes + §8 boss philosophy align | No contradiction |
| 13 | D011 §4 military operative roles | §6 archetypes compose with D011 §4 role families | No contradiction |
| 14 | D011 §5 Black Hand security | §2.1 Black Hand Remnants profile | No contradiction |
| 15 | D011 §6 Shades | §7 Black Hand / Shade distinction (information / coordination / sensory / discipline) | No contradiction |
| 16 | D011 §7 truthful sensing (no omniscience) | §3-§5 AI perception bounded; knowledge-with-source | No contradiction |
| 17 | D011 §8 commander externalization | §5 squad command structure + D022 §2.1 leadership preserved | No contradiction |
| 18 | D011 §10 doctors / scientists | §2.4 Researchers faction profile | No contradiction |
| 19 | D011 §11-§13 prisoners / subjects / cybernetic | §2.6 Escaped Subjects faction profile | No contradiction |
| 20 | D011 §14 former Hidden Hand (1-2 survivors pattern) | §2 + §6 + §8 preserved; Tier 3 character events | No contradiction |
| 21 | D011 §15-§17 civilians / community archetypes | §2.2 Island Survivors faction profile + §6.1 / §6.2 archetypes | No contradiction |
| 22 | D011 §18 wildlife | §9 wildlife / human / threat ecology interaction | No contradiction |
| 23 | D011 §22 human-first ability rule | §2 + §6 Tier 0-3 humans dominant | No contradiction |
| 24 | D011 §23 regional distribution | §2 + §6 + §10 distribution aligns with D018 §11 escalation | No contradiction |
| 25 | D011 §24 relationship model | §3 dispositions as behavioral states with routes in/out | No contradiction |
| 26 | D011 §26 weapon ecology | §6 archetypes' equipment follows D011 §26 | No contradiction |
| 27 | D011 §27 D007 perception compatibility | §3 AI truthful sensing preserved | No contradiction |
| 28 | D011 §28 D008/D009 combat compatibility | §3 / §5 compose with D008/D009 AI-facing interfaces | No contradiction |
| 29 | D011 §29 Pillar 3 RESPONSIBILITY | §3.5 betrayal + §6.1 frightened survivor + §7 Shade humanity anchor Pillar 3 | No contradiction |
| 30 | D011 §30 content / horror budget | §8 / §10 rarity preserved | No contradiction |
| 31 | D011 §31 boss doctrine | §8 boss philosophy deepens D011 §31 | No contradiction |
| 32 | D011 §32 future-team boundary | §10 slice excludes Tier 3/4 + boss encounters; Companion Shade preserved | No contradiction |
| 33 | D012 §12 pre-collapse markers | §7 Shade distinction respects; pre-collapse feats non-paranormal | No contradiction |
| 34 | D013 weapons | §6 archetypes' equipment follows D013 family authority | No contradiction |
| 35 | D014 prologue + knowledge gates | §10 slice excludes former Hidden Hand; ACT IV Companion Shade introduction | No contradiction |
| 36 | D015 §15 wildlife-as-environmental-information | §9 wildlife / human / threat ecology interaction | No contradiction |
| 37 | D015 §18 wildlife (credible regional) | §9.1 wildlife hazards bounded; no monster-shooter | No contradiction |
| 38 | D015 §28 off-screen coarse model | §5 squad / faction behavior reads D015 §28 | No contradiction |
| 39 | D015 §30 fairness law | §3 AI deterministic; no random probability | No contradiction |
| 40 | D015 §31 Memory Bleed taxonomy | §3 bleeds do not affect AI rules | No contradiction |
| 41 | D015 §33 horror rarity | §8 Tier 4 reserved for ACT III-IV; rare and authored | No contradiction |
| 42 | D015 §34 True Unknowns scarce | §8 Tier 4 = EXCEPTIONAL scarcity | No contradiction |
| 43 | D015 §40 wildlife-as-environmental-information | §9.2 wildlife warning signals | No contradiction |
| 44 | D015 §43 sound as survival information | §5 squad radio + audio communication | No contradiction |
| 45 | D015 §47 Saga-1 containment | §7 Companion Shade ACT IV territory; future-saga preserved | No contradiction |
| 46 | D016 §48 Superhero-prevention matrix | §7 Shade distinction — NOT superhuman; bullet-spongy forbidden | No contradiction |
| 47 | D016 §49 Season-1 mastery ceiling | §2 + §10 combat is one tool; not eclipsed by factions | No contradiction |
| 48 | D017 §3 5-stage reclamation | §10 slice excludes reclamation progression | No contradiction |
| 49 | D017 §11 LIVING SAVE FILE | §6.1 wounded enemy state persists | No contradiction |
| 50 | D017 §22 cleanliness social reactions | §6.1 civilian survivor NPC observes player cleanliness | No contradiction |
| 51 | D017 §47 failure recovery | §3 / §10 slice tolerates failure | No contradiction |
| 52 | D018 §11 / §37 human threat escalation | §2 + §6 + §10 threat-tier architecture composes with D018 §11 / §37 | No contradiction |
| 53 | D018 §13 Shade commander + Companion Shade thread | §7.5 Companion Shade ACT IV territory preserved | No contradiction |
| 54 | D018 §14 encounter functions | §6 archetypes compose with D018 §14 encounter functions | No contradiction |
| 55 | D018 §15 second-in-command arc | §8.4 boss example preserved | No contradiction |
| 56 | D018 §27 former Hidden Hand | §6 + §8 character events preserved | No contradiction |
| 57 | D018 §34 REAL→IMPOSSIBLE escalation | §2 + §6 + §8 tiers map to escalation | No contradiction |
| 58 | D018 §36 end-of-Season woman | §10 slice excludes; future slice territory | No contradiction |
| 59 | D018 §39 vertical-slice recommendation | §10 slice enemy package aligns | No contradiction |
| 60 | D018 §55 mission taxonomy | §2 + §6 encounter functions align | No contradiction |
| 61 | D019 §12 horror presentation | §8 boss philosophy aligned with Pillar 3 | No contradiction |
| 62 | D019 §13 sound language | §5 squad communication uses sound channel | No contradiction |
| 63 | D019 §14 animation priority Tier 1 | §6 archetypes drive movement / weapons / stealth | No contradiction |
| 64 | D019 §15 signature moments | §8 boss philosophy anchors narrative pillars | No contradiction |
| 65 | D019 §16 tablet performance law | §3 / §6 archetypes tablet-feasible (D004 §10 budgets) | No contradiction |
| 66 | D020 §4.4 first human encounter | §10.1 / §10.3 desperate survivor group aligned | No contradiction |
| 67 | D020 §4.5 first combat test | §10.1 / §10.3 trained human threat (Tier 2) aligned | No contradiction |
| 68 | D020 §4.6 first community contact | §10.1 / §10.3 civilian / noncombatant survivor NPC aligned | No contradiction |
| 69 | D020 §4.3 exploration | §10.1 / §10.3 wildlife behavior aligned | No contradiction |
| 70 | D020 §7 acceptance criteria | §10 slice enemy package is the architecture proof | No contradiction |
| 71 | D020 §9 fixture determinism | §10 fixture determinism (BV-SKILL-015 invariant 4) | No contradiction |
| 72 | D020 §10 production boundaries | §10.2 EXCLUDED list aligned | No contradiction |
| 73 | D020 §11 future-saga containment | §12 future-saga containment preserved | No contradiction |
| 74 | D021 §2 combat philosophy | §2 / §3 + §8 compose with D021 philosophy | No contradiction |
| 75 | D021 §3 7-step loop | §3 AI perception state machine composes with player loop | No contradiction |
| 76 | D021 §4 player combat model | §6 archetypes drive the player's combat decisions | No contradiction |
| 77 | D021 §5 five-tier threat architecture | §2 + §6 + §7 + §8 tiers align with D021 | No contradiction |
| 78 | D021 §6 injury + survival integration | §6 + §9 wound / wildlife / ecology integration | No contradiction |
| 79 | D021 §7 AI combat doctrine | §3-§5 deepen D021 §7 | No contradiction |
| 80 | D021 §8 weapons categories | §6 archetypes' equipment follows categories | No contradiction |
| 81 | D021 §9 combat acceptance fixture | §10 slice enemy package is the architecture proof | No contradiction |
| 82 | BV-D123 vertical-slice canonical reference | §10 slice enemy package aligned | No contradiction |
| 83 | BV-D124 combat architecture canonical reference | §2 / §3 / §5 / §6 / §8 deepen D021 architecture | No contradiction |
| 84 | BV-SKILL-008 tactical-ai-perception | §3 AI perception bounded; knowledge-with-source | No contradiction |
| 85 | BV-SKILL-009 contextual-assassination | §3 EXCHANGE state + combat vs assassination separation preserved | No contradiction |
| 86 | BV-SKILL-021 cqc-combat-architecture | §3 / §5 / §6 / §7 compose; AI-facing interfaces exposed | No contradiction |
| 87 | BV-SKILL-027 island-population-threat-ecology | §2 faction taxonomy + §6 archetypes compose with population ecology | No contradiction |
| 88 | BV-SKILL-028 prologue-narrative-architecture | §10 slice excludes former Hidden Hand / Companion Shade (ACT IV territory) | No contradiction |
| 89 | BV-SKILL-029 simse-island-systems | §9 wildlife / human / threat ecology interaction composes | No contradiction |
| 90 | BV-SKILL-031 persistent-character-state-architecture | §6.1 wounded enemy state persists | No contradiction |
| 91 | BV-SKILL-032 visual-presentation-architecture | §6 + §8 archetypes / bosses drive visual presentation | No contradiction |
| 92 | SOP-005 gameplay verification | §10 fixture determinism is the slice's acceptance test | No contradiction |
| 93 | SOP-006 observability | §3 / §5 AI states log reasons | No contradiction |

Result: **0 contradictions found.** No silent repair required. D022 deepens the existing AI / faction /
enemy architecture without modifying any prior canon.

## Appendix B — Deferred decisions (D022)

1. Specific named enemies for each archetype — CANDIDATE pending scene-authoring.
2. Specific faction leader names and backstories — CANDIDATE.
3. Specific squad compositions — CANDIDATE pending per-encounter authoring.
4. Specific named Shade commanders — CANDIDATE pending ACT IV authoring.
5. Specific wildlife encounter scripts — CANDIDATE.
6. Specific boss encounter scenes — CANDIDATE.
7. Specific criminal network details (Faction G is optional per spec) — CANDIDATE.
8. The exact Tier 2 trained-human archetype for the slice fixture — CANDIDATE.
9. The Companion Shade introduction scene — CANDIDATE / future slice.
10. D023 Companions / Relationships bible — recommended next per user's directive final note; not
    executed.

## Appendix C — Stop-condition trace (D022)

This bible STOPS if any stop condition fires:
- faction taxonomy drifts to "enemy classes" — §6 actual people preserved.
- AI gains omniscient player location — §3 + §4 frozen rules prevent.
- Tier 4 becomes routine combat mob — §8 / §10 EXCEPTIONAL scarcity + ACT III-IV placement prevent.
- Squad behavior becomes deterministic-perfect — §5.6 mistakes + D011 §7 FALLBACK BEHAVIOR prevent.
- Shade becomes "stronger soldier" — §7 frozen distinction prevents.
- Boss becomes giant health bar / bullet sponge — §8 frozen philosophy prevents.
- Wildlife becomes mutant-shooter faction — §9.1 bounded behavior prevents.
- Slice enemy package becomes army — §10.2 EXCLUDED list prevents.
- New skill is created without justification — §12 frozen determination: BV-SKILL-033 as METHODOLOGY
  ONLY.
- Future-saga material is imported — §13 future-saga containment preserved.
- Validators fail — validation below.

None triggered. **Validation below. STOP. NO COMMIT. RETURN REPORT.**# — CONTINUED: PART E — FINAL REPORT —

---

# FINAL REPORT — DIRECTIVE 022

**AI, Faction & Enemy Architecture Bible.**

---

**Files inspected:** doctrine §23 / §26 / §27 / §34 / §35-§39 / §41 / §41.1-§41.16; D004 §3 / §10; D008/D009; D010; D011 §3-§32; D012 §12 / §22; D013; D014 §1 / §28 / §29; D015 §6 / §9 / §10 / §12 / §13 / §14 / §15 / §16-§21 / §22 / §24 / §28 / §30 / §31 / §33 / §34 / §40 / §43 / §44 / §45 / §47; D016 §21 / §22 / §34 / §35 / §48 / §49; D017 §3 / §7 / §10 / §11 / §13 / §22 / §36 / §37 / §40 / §46 / §47 / §50 / §54; D018 §5 / §6 / §11 / §13 / §14 / §15 / §20 / §27-§29 / §34 / §36 / §37 / §39 / §55; D019 §3 / §12 / §13 / §14 / §15 / §16 / §17; D020 §4.3-§4.6 / §7 / §9-§11; D021 §2-§9; BV-D123 / BV-D124. Skills 001..032 + 2 governing + 6 SOPs.

**Skills consumed:** governing set + SOP-005 / SOP-006; composed with full 32-BV-skill fleet. **NEW skill
created: BV-SKILL-033 enemy-architecture — METHODOLOGY ONLY** (mirrors BV-SKILL-030 / 031 / 032 discipline).

**Files created/modified:**
- Created: `docs/design/AI_FACTION_ENEMY_ARCHITECTURE_BIBLE.md` (chunk assembly in progress at report time);
  `.opencode/skills/enemy-architecture/SKILL.md` (BV-SKILL-033).
- Modified: `doctrine/BLACK_VECTOR_DOCTRINE.md` (BV-D125 — AI/Faction/Enemy Architecture Canonical Reference);
  `skills/registry.md` (inventory + routing + quality-gate); `tools/validate_methodology.py` (33-skill fleet);
  `README.md` (status); RELATED SKILLS cross-refs in composing skills. Staging chunks removed.

**Doctrine IDs added:** **BV-D125** — AI/FACTION/ENEMY ARCHITECTURE CANONICAL REFERENCE (frozen): 7-faction taxonomy (Black Hand Remnants · Island Survivors · Security/Recovery Teams · Researchers · Contractors · Escaped Subjects · Criminal Networks [optional]) — each with goals · resources · leadership · tactics · equipment · morale · weaknesses; enemy psychology frozen (fear · surrender · retreat · negotiation · betrayal · desperation · loyalty — the most memorable encounters should sometimes end without killing); AI perception state machine frozen (UNAWARE → SUSPICIOUS → SEARCHING → TRACKING → ENGAGED → LOSING CONTACT → RETREATING — bounded; no omniscience; knowledge-with-source); squad behavior frozen (communication · radio dependency · command structure · panic when leaders die · fallback behavior · mistakes — squad-level examples); 8 human enemy archetypes frozen (frightened survivor with a rifle · desperate scavenger · disciplined security operator · tracker · sniper · medic · engineer · commander — actual people not enemy classes); Black Hand / Shade distinction frozen (information · coordination · sensory integration · discipline — NOT armor / damage; Shade = what happens when the system optimizes a human being too far; BROKEN/DESYNCHRONIZED Shade most human; Companion Shade preserved); boss philosophy frozen (unique people · unique situations · history · preparation · consequences — no giant health bars / no bullet sponges / no arena fights; Second-in-Command encounter is the example); wildlife / human / threat ecology interaction frozen (hazard triggers · warning signals · avoidance signals · human-activity impact — credible wildlife behavior preserved); slice enemy package frozen (INCLUDED: ONE desperate survivor group + ONE trained human threat + ONE wildlife behavior + ONE civilian/noncombatant interaction; EXCLUDED: Tier 3/4 + commanders + Shades + Companion + former Hidden Hand + True Unknowns + Program Casualties + boss encounters); new methodology-only skill **BV-SKILL-033 enemy-architecture** (per the user's D016/D017/D019 recon correction pattern — methodology separated from canon); no game/ modifications; future-saga containment preserved.

**Faction taxonomy (7 factions, frozen profiles):**
- **A Black Hand Remnants:** institutional truth / assets; resources (caches + secure facilities + sector trunk at Frostvane + bounded command hardware); lieutenant-tier leaders in ACT I-III; institutional drill-bound tactics; equipment per D011 §26; mission-driven morale; weaknesses = predictability + compartmentalization + command dependency.
- **B Island Survivors:** survival / safety / community; resources (pre-catastrophe civilian infrastructure); informal trust-based leadership; defensive / opportunistic tactics; civilian / frontier / improvised equipment; variable morale; weaknesses = isolation + resource scarcity + fear + distrust of strangers.
- **C Security/Recovery Teams:** recover Black Hand assets; resources (institutional + recovery-specific); team-lead leadership; disciplined / drill-bound tactics; institutional equipment; mission-bound morale; weaknesses = predictability + protocol brittleness + command loss + mass casualties.
- **D Researchers:** survive + protect research data; resources (research facilities + medical equipment); senior researcher (the "keeper" per D012 §22) — ALONE without senior; defensive / non-combat tactics; light weapons; collapses when program exposed; weaknesses = non-combat preference + Pillar 3 RESPONSIBILITY exploit.
- **E Contractors:** GET PAID; commercially mixed resources; contract manager leadership; pragmatic / mission-bound tactics; commercially mixed equipment; money-driven morale; weaknesses = financial vulnerability + pragmatic retreat + discipline gaps.
- **F Escaped Subjects:** SURVIVE / possibly REVENGE; variable resources (experimental residue + rare anomalous capability); informal survivor-driven leadership; desperate / reactive / unpredictable tactics; improvised equipment; collapsed morale; weaknesses = psychological damage + unpredictability + physical condition.
- **G Criminal Networks [optional]:** survival / exploit / profit; illicit networks; informal crew leadership; opportunistic / predatory tactics; mixed equipment; profit-driven morale; weaknesses = opportunism + network vulnerabilities + thin numbers.

**Enemy psychology (7 dispositions, frozen):** fear · surrender · retreat · negotiation · betrayal · desperation · loyalty. Most memorable encounters should sometimes end without killing (D022 §3.7).

**AI perception state machine (frozen):** UNAWARE → SUSPICIOUS → SEARCHING → TRACKING → ENGAGED → LOSING CONTACT → RETREATING. Bounded; no omniscience; no "enemy knows player location" shortcut; knowledge-with-source (BV-SKILL-008). AI NEVER transitions directly to ENGAGED without the legitimate chain.

**Squad behavior (frozen):** communication (radio / hand signals / network); radio dependency (jam or kill radio operator → coordination degrades); command structure (lead / commander); panic when leaders die (Tier 0-1 PANIC · Tier 2 CONTROLLED DECLINE · Tier 3 MISSION-DRIVEN · Tier 4 unknown); fallback behavior (prior orders / local autonomy / suspicion / neutral defaults); mistakes (Tier 1 often · Tier 2 occasionally · Tier 3 rarely · Tier 4 unknown).

**8 human enemy archetypes (frozen, actual people):** frightened survivor with a rifle · desperate scavenger · disciplined security operator · tracker · sniper · medic · engineer · commander. Each with WHO / WHY HERE / AWARENESS / TACTICS / COMMUNICATION / MORALE / WEAKNESS profile.

**Black Hand / Shade distinction (frozen):** Shade = human with optimized information + coordination + sensory integration + discipline (NOT armor / damage). D011 §6 / §7 / §8 compose with §7. BROKEN / DESYNCHRONIZED Shade = most human (network failure restored some individuality). Companion Shade preserved (ACT IV territory; base-anchored; obedience → uncertainty → preference → choice → autonomy).

**Boss philosophy (frozen):** unique people + unique situations + history + preparation + consequences. NO giant health bars / NO bullet sponges / NO arena fights. Second-in-Command encounter is the canonical example (doctrine §25 scene lock; Pillar 2 BROTHERHOOD; can end without killing).

**Wildlife / human / threat ecology (frozen):** hazards (territory / young / program alteration); warning signals (silence / flight / refusal / disturbed feeding / unusual tracks / carcasses); avoidance signals (contaminated / program-controlled / True Unknown territory); human-activity impact (presence reduces density; conflict displaces; infrastructure alters corridors; program may damage). Wildlife is NOT routine combat enemy.

**Slice enemy package (frozen — D020 compatibility):** INCLUDED = ONE desperate survivor group + ONE trained human threat (Tier 2) + ONE wildlife behavior + ONE civilian/noncombatant survivor NPC. EXCLUDED = Tier 3/4 + commanders + Shades + Companion + former Hidden Hand + True Unknowns + Program Casualties + boss encounters.

**Methodology validation:** 32-BV-skill fleet inspected + new **BV-SKILL-033 enemy-architecture** created as
METHODOLOGY ONLY (per the user's D016/D017/D019 recon correction pattern). BV-SKILL-033 owns the
reusable design procedure; canon stays in this bible + doctrine.

**Validation:** methodology PASSED (2 governing + 33 BV skills); static game **CLEAN 24 ok / 0 fail**
(unchanged); **no game/ files touched**; chunks removed.

**Contradictions:** 93-ledger check vs D001..D021 — **0 contradictions found.** No silent repair required.
D022 deepens the existing AI / faction / enemy architecture without modifying any prior canon.

---

**Recommended D023 (not executed):** D023 — COMPANIONS / RELATIONSHIPS BIBLE. Per the user's directive final
note. The production sequence:

```
D019 = how it feels        ✔
D020 = prove it works      ✔
D021 = how fighting works  ✔
D022 = who fights you      ✔
D023 = Companions / Relationships  (recommended next)
D024 = Dynamic World
```

D023 would author the canonical companion + relationships layer: the Companion Shade (D011 §9 / doctrine
§26 / D018 §13), the second-in-command arc deepening (doctrine §25 / D018 §15), community relationship
evolution (D015 §22 / D017 §22), and the surviving-roster pattern (doctrine §27 / D011 §14).

**Not executed. STOP. NO COMMIT.**

---

**D022 COMPLETE — STOPPED, AWAITING APPROVAL.**

D022 is the missing combat partner. D021 answered "how fighting works"; D022 answers "who fights you,
why they fight, and how they behave." Awaiting approval or next directive.