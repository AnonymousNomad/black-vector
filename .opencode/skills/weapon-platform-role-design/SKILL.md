---
name: weapon-platform-role-design
description: Weapon platform and role design research discipline — role-led platform families (CQB carbine, GPC, recon, battle rifle, DMR, precision, heavy precision, PDW, shotgun, civilian hunting rifle, speculative networked), handling abstraction, provenance ecology (where and why a platform exists in-fiction), faction identity, reliability-in-isolation logistics, underrepresented-but-real traditions (bullpup, roller-delayed, Czech/European, scout-rifle), and strict originality/no-actionable-content guards. Load for any weapon/equipment family design, role differentiation, or fiction-weapon identity work — before any platform enters canon, shape it.
---

# WEAPON PLATFORM AND ROLE DESIGN (BV-SKILL-025)

## NAME
WEAPON PLATFORM AND ROLE DESIGN

## PURPOSE
Own the RESEARCH+DESIGN layer of the fiction's weapon families and the role thinking behind them. This skill
turns "we need a weapon/role for faction X" into a role-led platform decision: which family the platform belongs
to, what handling CHARACTER it needs (not its ballistics), why it exists IN THIS FICTION (provenance ecology),
how it maps across factions and the wear/logistics of an isolated island (D010, BV-D043), and where the fiction
deliberately borrows underrepresented-but-real small-arms traditions (bullpup/roller-delayed/Czech-scout flavors)
for originality — always with the guardrails that prevent actionable fabrication content and silent real-model
reproduction. It is the DESIGN counterpart to BV-SKILL-011 (which owns gameplay/ballistics DATA) and
BV-SKILL-022 (which owns the visual language those families wear).

## WHEN TO LOAD
- Creating any weapon platform family, role family, faction armament, or the Hand's marksman kit (doctrine §8).
- Assigning weapons to D011 enemy families or rostering a boss/miniboss loadout (D011 §13 composition).
- Authoring the speculative networked rifle line or any "future" gear (the psychic-interface-adjacent fiction).
- Choosing which underrepresented-but-real tradition flavors a family's ergonomics/silhouette (art/history flavor).
- Any rework of provenance ecology or the wear/logistics of the island's gun-culture (D010/D043).

## DO NOT LOAD WHEN
- Gameplay ballistics or handling data/progression (BV-SKILL-011 owns the mechanics).
- Visual-equipment/faction silhouette work (BV-SKILL-022).
- Real-history/archive claims for the gear's real origin (BV-SKILL-023).

## PRECONDITIONS
- Governing set loaded; SOP-002 routing confirms weapon-design scope.
- `docs/research/WEAPON_REFERENCE_FAMILIES.md` present (family catalogue) + `MILITARY_ROLES.md` for the
  role-facing pairings.
- D011 §6 (civilian population/hunting) and §8 (The Hand) available for faction assignment.
- BV-SKILL-011 and BV-SKILL-022 loaded for data/visual cross-checks when authoring interference is possible.

## GOVERNING INVARIANTS
1. ROLE FIRST, PLATFORM SECOND: a platform is selected because a FUNCTION needs it (CQB carbine for Breacher;
   precision rifle for Overwatch; etc.), not because "this looks cool." The final loadout is
   role + faction + equipment + behavior + condition + modifier (D011 §13), never a level-locked list.
2. HANDLING-CHARACTER OVER SPEC: design the READ of a weapon as a character (short, hot, calm, weighty) — not its
   inch/percent numbers. Numbers, if ever shown, are gameplay-data's job (BV-SKILL-011).
3. PROVENANCE ECOLOGY IS MANDATORY: every family carries an in-fiction "where it comes from / who kept it"
   assignment lineage (institution-standardized vs Hand-compartment vs civilian/seized) — no freehand
   wave/level gate that ignores faction identity.
4. ISLAND SERVICEABILITY: an isolated gun-culture rewards reliable-to-fix, low-exotic-parts platforms (no
   "resupply line" fiction); wear, repair culture, and local gunsmith relationships are storytelling systems.
5. UNDERREPRESENTED-REAL TRADITIONS ARE INSIDE BASE: bullpup layouts, roller-delayed actions, Czech/European
   leaf, scout-rifle weight/walkability — are ART/HISTORY flavors available to any family to defeat the
   "everyone holds the same AR" monotone (BV-SKILL-022), WITHOUT stat swings.
6. ZERO ACTIONABLE CONTENT: no dimensions, no function mechanics enabling manufacture/mod/use; no real model
   reproduced under a rename (doctrine §16); the networked rifle is EXPLICITLY FICTION (no real integrated
   optics/sensor/display rifle of that integration exists) and stays labeled.
7. THE HAND'S EDGE IS SKILL, NOT SUPERHUMAN: their overwatch/marksman capability is extended professional
   practice (extraordinary patience, observation, load discipline) — never supernatural marksmanship, never an
   augmented-vision system (doctrine §8, §23; MILITARY_ROLES.md).

## WORKFLOW
1. Take the required ROLE/THREAT (from D011 §3-8/§13 or faction brief): identify the FUNCTION (breach, overwatch,
   counter-sniper, area denial, close, support, hunting).
2. Choose a FAMILY from the reference catalogue (CQB carbine, GPC, recon, battle, DMR, precision, heavy precision,
   PDW, shotgun, civilian hunting, speculative networked[r]). Cross-check it against the faction's provenance
   ecology (institution vs Hand-compartment vs civilian) and island serviceability.
3. Write the platform's HANDLING-CHARACTER parcel: name (fiction), read (short/hot/calm/weighty), provenance tale,
   faction signature, any deliberate tradition-flavor choice.
4. Pair it with a visual read via BV-SKILL-022 (family = silhouette/materials); hand numbers, if any, to
   BV-SKILL-011 — never duplicate.
5. Assign model loadouts (boss/roster) with tell/rule/limit/counterplay hooks only where relevant (D011 §13 boss
   contract).
6. Update the ledger (WEAPON_REFERENCE_FAMILIES / MILITARY_ROLES) as needed and cross-link; verify (below).

## IMPLEMENTATION GUIDANCE
- Keep the family set finite: reuse families across factions with cosmetic variance (institution-maintained same-rig)
  vs mixed inventory (garrison) vs legacy civilian single long-guns — resolution happens at the role/faction layer,
  not by inventing a new platform per enemy.
- For the Hand: a disciplined, low-signature, patience-first package (recon + precision) with a "quiet overwatch"
  kit; NOT a gimmick gun. Edge comes from reads the player can study (patience windows), not from aim powerup.
- The speculative networked rifle: integrate optics/sensor/display through the SHADE/psionic-interface fiction
  (BV-SKILL-019/026), stay explicit that real integrated-rifle capability is absent; it exists only at the
  fiction's rear edge of the tech ladder (T3/T4, BV-SKILL-022).
- Civilians: legacy hunting rifles with visible upkeep (stock wear, tape, mismatch shoulder slings) — family-dna
  sharing without institutional standardization; weapon is the LAST-resort survival object (BV-SKILL-017).
- Write EVERY original-fiction platform with a one-line "fiction provenance" so the design note can be audited.

## ANTI-PATTERNS
- Defining a platform by real calibers/dimensions/action mechanics (actionable, and contradicts no-real-model).
- A new platform added to answer a cosmetic need instead of a role need.
- Plan rounds where weapons are a level-gated checklist rather than role/provenance-driven choices.
- The Hand "aimbot/psychic-scope" read of marksman capability (doctrine §8).
- Slapping a real model name onto a renamed fiction platform (no silent real reproduction).
- Making the networked rifle appear Near-Future-real instead of fiction.

## KNOWN FAILURE MODES
- Family bloat: catalogue grows by whim; enforce role-first + provenance ecology discipline.
- Data creep: numbers start leaking into design parcels; re-delegate to BV-SKILL-011, keep parcel to character.
- Actionable leak: a plot line mentions specific ammunition/parts that someone could use to build or modify — scrub.
- Flavor self-homogenization: faction signals become "weapon palette swap"; fight it with provenance ecology beats.
- Isolation-forgotten: a faction gets "resupply pipeline" fiction that the island can't support; re-anchor to
  serviceability invariant.

## VERIFICATION
- Static: every new platform is the child of a listed family in WEAPON_REFERENCE_FAMILIES.md; role-function is
  recorded; provenance ecology + faction signature present; no real model/spec/quantity lies in the design note;
  networked rifle flagged PURE FICTION; validator runs clean.
- Read-through: an unfamiliar player can infer the weapon's behavior/read from its parcel without numbers.
- Contradiction-check: nothing contradicts BV-SKILL-011 data, BV-SKILL-022 visual, or D011 faction/roster rules.

## STOP CONDITIONS
If a design calls for real specifications/action mechanics, a silent real-model reproduction, an unlabeled
near-future networked rifle, or a superhuman marksman read that contradicts doctrine §8 — stop and re-anchor to
this skill's invariants and BV-SKILL-011/022 before continuing.

## RELATED SKILLS
- BV-SKILL-011 weapon-handling-ballistics (gameplay data/ballistics; numbers live there)
- BV-SKILL-022 visual-equipment-doctrine (visual/faction silhouette language)
- BV-SKILL-023 historical-provenance-research (real-history provenance seams for gear)
- BV-SKILL-021 cqc-combat-architecture (fighting-system interplay when weapon enters CQC)
- D013 canonical bible = `docs/design/WEAPON_RIFLE_FAMILY_BIBLE.md` (11 frozen families, BV-D064–D070; this
  skill is design-layer owner; 011 data / 022 visual / 023 seams)
- BV-SKILL-028 prologue-narrative-architecture (D014 opening bible: Layered Overwatch peak kit, hand-off starting-lock use in line 26)
- developers-way, black-vector-project-doctrine (governing); SOP-002 scope & authority