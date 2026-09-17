---
name: island-population-threat-ecology
description: Simse Sound population, threat ecology and Shade network bible — population families, military roles, Black Hand security ladder, Shade architecture + information-truth network model, doctor/scientist and prisoner/subject taxonomies, experimental human lines, cybernetic subjects, Hidden Hand survivor framework, civilians/community archetypes, contractors, wildlife, paranormal taxonomy, regional distribution, relationship model, compositional NPC architecture, horror rarity budget, and boss doctrine. Load for ANY population, enemy, faction, Shade, experiment, detainee, wildlife, regional-ecology, relationship, or NPC-authoring work.
---

# ISLAND POPULATION AND THREAT ECOLOGY (BV-SKILL-027)

## NAME
ISLAND POPULATION AND THREAT ECOLOGY

## PURPOSE
Own the canonical population and threat-ecology architecture of Simse Sound (Directive 011): the population
families and their seven-question contracts, the military role families and Black Hand security ladder, the
Shade architecture and its information-truth network model (no omniscience), doctor/scientist and
prisoner/subject taxonomies, the six experimental human lines, cybernetic-subject boundaries, the Hidden Hand
survivor framework, civilian/community archetypes, contractors, wildlife, paranormal taxonomy, regional
distribution, the non-binary relationship model, the compositional NPC content model, the horror rarity budget,
and boss doctrine. This skill is the routing gate for any future D013+ NPC/enemy/encounter work so that every
population stays provenance-backed and never degenerates into a monster catalogue or a generic faction list.
It consumes `docs/design/SIMSE_SOUND_POPULATION_THREAT_ECOLOGY.md` (canonical bible) and D012 `BLACK_HAND_PROVENANCE.md`.

## WHEN TO LOAD
- Designing or authoring any population family, NPC, enemy, faction, Shade, experiment, detainee, civilian,
  contractor, wildlife, or regional-ecology content.
- Reasoning about relationship dispositions, compositional NPC architecture, horror rarity, or boss doctrine.
- Verifying that a proposed faction/NPC has a credible origin (generation tag + world function) before canon.
- Shade network truth, information propagation, commander externalization, or companion-Shade work.

## DO NOT LOAD WHEN
- Individual weapon/platform design (BV-SKILL-025 owns role-first weapon families + provenance ecology).
- AI sensing/behavior internals (BV-SKILL-008 owns the D007 truthful-perception pipeline; this skill consumes it).
- Visual/equipment identity of a family (BV-SKILL-022 owns silhouettes/materials; this skill defines WHAT they are).
- Horror/perceptual-event authoring and the three-class ledger (BV-SKILL-018) — this skill cross-references, does not own them.
- Combat architecture / AI-facing interfaces (BV-SKILL-021).

## PRECONDITIONS
- Governing set loaded.
- `docs/design/SIMSE_SOUND_POPULATION_THREAT_ECOLOGY.md` present (Directive 011 bible).
- `docs/lore/BLACK_HAND_PROVENANCE.md` present (D012) for generation tags and provenance rules.
- Cross-consume when authoring a concrete NPC: BV-SKILL-025 (weapon), BV-SKILL-022 (visual),
  BV-SKILL-021 (combat interfaces), BV-SKILL-008 (sensing) as applicable.

## GOVERNING INVARIANTS
1. POPULATION FAMILY CONTRACT (D011 §1): every family answers WHO / WHY HERE / GENERATION / WANT NOW /
   PERCEIVE PLAYER / FIGHT-SURVIVE / NARRATIVE FUNCTION. No family exists without all seven answered.
2. TAG DISCIPLINE (D012 §2, D011 §2): generation tags (G0–G8) attach to Black Hand-derived populations and
   technologies only; they explain provenance, never grant power or excuse world rules. Civilians and natural
   wildlife carry no tag.
3. PRIMARY ECOLOGY RULE (D011 §3): most encounters stay human / natural / military / technological /
   human-adjacent; the genuinely impossible remains uncommon and provenance-gated. Progression is
   people-dangerous -> soldiers-different -> experiments-should-not-exist -> something-experiments-don't-explain
   -> the-island-may-be-involved.
4. NO OMNISCIENCE (D011 §7, doctrine §6/§8, BV-D029): Shade/AI knowledge flows individual observation ->
   local -> network -> controller -> response; every belief has source+channel+timestamp; a Shade cannot know
   the player's location merely because another system does; bounds = squad/sector/latency/degraded/jamming/
   controller-loss/desync/fallback; no universal master controller (D011 §8).
5. COMMANDER EXTERNALIZATION (D012 §17/D011 §8): commanders use no subordinate implant; bounded-domain command
   hardware; death -> degraded coordination/sharing + fallback + confusion + individual behavior, never instant
   mass shutdown.
6. HUMAN-FIRST ABILITY RULE (D011 §21-§22): most special enemies derive threat from training/gear/coordination/
   psychology/environment/experimental-condition/sensory advantage — NOT powers; strong anomalous abilities are
   rare, provenance-gated, and must pass the six-field ability contract
   (ORIGIN/TELL/RULE/LIMIT/COUNTERPLAY/COST). No arbitrary boss magic (doctrine §23 3-of-5, §35.6 TK boundary).
7. HORROR BUDGET (D011 §30): qualitative rarity classes COMMON / SPECIALIZED / RARE / EXCEPTIONAL; the
   impossible is never normalized; EXCEPTIONAL content needs ability contract + provenance and stays within the
   BV-SKILL-018 paranormal-scarcity ledger.
8. RELATIONSHIP MODEL (D011 §24): dispositions are per-NPC (unaware/cautious/territorial/suspicious/frightened/
   cooperative/desperate/conditioned/compromised/hostile), not a global FRIENDLY/HOSTILE flag; individuals within
   a faction CAN differ.
9. COMPOSITIONAL MODEL (D011 §25): NPC = BASE PERSON + FACTION + ROLE + EQUIPMENT + BEHAVIOR + CONDITION +
   OPTIONAL EXPERIMENTAL MODIFIER + GENERATION TAG (when applicable). Design architecture only; no procedural
   generator yet.
10. COMPATIBILITY (D011 §27-§29): conventional AI honestly senses per BV-SKILL-008 (D007); enemies consume the
    D008 AI-facing combat interfaces (BV-SKILL-021) — never internals, never a separate combat-ownership model;
    visual identity goes through BV-SKILL-022 with no silent visual retcon (D010 freeze).

## WORKFLOW
1. Identify the population/encounter in scope by FUNCTION (what the fiction needs now).
2. Check the ecology bible §1 checklist + §23 region table; confirm the family or a compositional combination §25
   covers it (if a genuinely new family is owed, route an architecture change through this skill + directive, do
   not silently add).
3. Set the GENERATION TAG (or explicitly none for civ/wild), the RELATIONSHIP disposition(s), and the HORROR
   BUDGET class.
4. For any special ability, write the six-field ABILITY CONTRACT (§21) and provenance; for exceptional content,
   verify scarcity against BV-SKILL-018's ledger.
5. Compose the NPC via §25 (base+faction+role+equipment+behavior+condition+modifier+tag) and hand visual/weapon/
   combat/sensing specifics to BV-SKILL-022/025/021/008 as needed.
6. Static verify (below), then report findings + any doctrine cross-links.

## IMPLEMENTATION GUIDANCE
- Always open with provenance: the question "which generation and what problem were they solving?" (D012) decides
  whether an entity is a guard, a desync Shade, or a G8 convergence case.
- Keep the military baseline loud: role differences come from mission/equipment/movement/range/info-access —
  never a hidden HP tier (D011 §4).
- Shade network content: model it as REPORTED knowledge with cost (BV-SKILL-008 cooperative bound), not telepathy;
  base a scene's information realism on the §7 boundary table.
- Bosses: fill the doctrine checklist (identity/provenance/motive/rule/visual/narrative/env/tell/counterplay) and
  always allow completely-human bosses; ground rare anomalistic powers in the surrounding world so they land.
- Civilians: never soda-pop cultists — strangeness traces to survival/age/isolation (§15-§16).
- Experimental subjects: many should look completely normal; the disturb reading beats the monster reading (§12).
- Every encounter descends to D007/D008/D010 compatible primitives (perception events, combat surface events,
  silhouette) — verify that the composed NPC spells out which skills feed it.

## ANTI-PATTERNS
- A faction with no provenance or no world function (stop: the seven-question contract is unanswered).
- Omniscient Shade/AI knowledge (telepathy; "another system knows, so it knows") — violates D007/§7.
- Paranormal content overwhelming the military baseline; routine mutant bestiary (doctrine §23; §30 budget).
- Converting a documented historical claim into an in-world fact without classification (D012 §0).
- Contradicting D012 generation history (tag misuse, generation misorder, Hand given a neural implant — never).
- Hidden Hand used as a generic reusable faction (it is character-events + 1–2 survivors, §14/doctrine §27).
- Scope-creep taxonomy: new families outside the §25 composition or new rarity classes outside §30.
- Bestiary-thinking: bosses as high-HP fights without the doctrine checklist (§31).

## KNOWN FAILURE MODES
- Family sprawl: authoring "new factions" instead of composing from §25 — reconcile to the compositional model.
- Provenance rust: a population starts answering "want now" but loses its WHY/GENERATION — re-check the seven.
- Network drift toward omniscience as content grows — re-verify §7 boundaries and BV-SKILL-008 beliefs-with-source.
- Rarity inflation: EXCEPTIONAL classes appearing at COMMON density — gate against the horror budget and the
  BV-SKILL-018 scarcity ledger per slice (BV-SKILL-016).
- Tag leaks: civilians/wildlife tagged G-something by habit — enforce the tag discipline.
- Encounter content bypassing D007/D008 compatibility (a scene that assumes the enemy "just knows") — route through
  BV-SKILL-008/021 primitives.

## VERIFICATION
- Static: every population family/encounter documented in the bible passes the 7-question contract; tags conform to
  D012; relationship dispositions are per-NPC; compositional form (base+faction+role+equipment+behavior+condition+
  modifier+tag) is used; horror budget respected; ability contracts (six fields) present on special abilities;
  no omniscience language; no visual/weapon/combat overrides.
- Cross-skill: any authored NPC maps to BV-SKILL-022 visual, BV-SKILL-025 weapon, BV-SKILL-021 combat interfaces,
  BV-SKILL-008 sensing resources without inventing parallel systems.
- Tooling: run `tools/validate_methodology.py` + `tests/static_verify_game.py` after any canon change.

## STOP CONDITIONS
Stop if: a population has no provenance or world function; Shade knowledge becomes omniscient; paranormal content
overwhelms the military baseline; a real historical claim is converted into BLACK VECTOR fact without classification;
D012 generation history is contradicted; The Hand is accidentally given a neural implant; Hidden Hand becomes a
generic reusable faction; taxonomy grows uncontrolled; or static validation fails. Re-anchor to this skill and
report the conflict.

## RELATED SKILLS
- BV-SKILL-023 historical-provenance-research (provenance/tag ground truth)
- BV-SKILL-026 anomalous-consciousness-research (threshold/anomalous boundary, divergence)
- BV-SKILL-025 weapon-platform-role-design (weapon families + provenance ecology; canon = D013 bible `docs/design/WEAPON_RIFLE_FAMILY_BIBLE.md`, BV-D064–D070)
- BV-SKILL-022 visual-equipment-doctrine (visual identity of families)
- BV-SKILL-021 cqc-combat-architecture (combat interfaces; D008/D009 compatibility)
- BV-SKILL-008 tactical-ai-perception (D007 sensing truth; network propagation bound)
- BV-SKILL-018 psychological-horror-perceptual-events (horror budget, rarity ledger)
- BV-SKILL-017 survival-wilderness-systems (wildlife as non-HUMAN sensing actors)
- BV-SKILL-020 facility-and-ally-support (ally/companion anchors)
- BV-SKILL-028 prologue-narrative-architecture (D014 opening bible: Hidden Hand team as archetypal placeholders, encounter/context seeding for fall-from-grace)
- BV-SKILL-029 simse-island-systems (D015 community systemic state + liability law the population families inhabit)
- BV-SKILL-031 persistent-character-state-architecture (D017 player-authored presentation + visible-state consequence — cleanliness/bleed social reactions compose without duplicating ecology)
- BV-SKILL-032 visual-presentation-architecture (D019 visual production / HUD / presentation — environment visual bible per facility composes with ecology without duplicating)
- BV-SKILL-033 enemy-architecture (D022 AI / faction / enemy architecture methodology — this skill retains population taxonomy + faction roles; 7-faction taxonomy + archetypes compose without duplicating)
- BV-SKILL-034 companion-relationship-architecture (D023 community relationship system + survivor trust progression; this skill retains population taxonomy + community archetypes D011 §16; composition)
- BV-SKILL-033 enemy-architecture (D022 AI / faction / enemy architecture methodology — this skill retains population taxonomy + faction roles; 7-faction taxonomy + archetypes compose without duplicating)
- BV-SKILL-034 companion-relationship-architecture (D023 community relationship system + survivor trust progression; this skill retains population taxonomy + community archetypes D011 §16; composition)
- BV-SKILL-032 visual-presentation-architecture (D019 visual production / HUD / presentation — environment visual bible per facility composes with ecology without duplicating)
- BV-SKILL-033 enemy-architecture (D022 AI / faction / enemy architecture methodology — this skill retains population taxonomy + faction roles; 7-faction taxonomy + archetypes compose without duplicating)
- BV-SKILL-034 companion-relationship-architecture (D023 community relationship system + survivor trust progression; this skill retains population taxonomy + community archetypes D011 §16; composition)
- BV-SKILL-033 enemy-architecture (D022 AI / faction / enemy architecture methodology — this skill retains population taxonomy + faction roles; 7-faction taxonomy + archetypes compose without duplicating)
- BV-SKILL-034 companion-relationship-architecture (D023 community relationship system + survivor trust progression; this skill retains population taxonomy + community archetypes D011 §16; composition)
- developers-way, black-vector-project-doctrine (governing); SOP-005 gameplay verification