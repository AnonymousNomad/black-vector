---
name: black-vector-project-doctrine
description: The canonical project doctrine for BLACK VECTOR — identity (survival/stealth/tactical-action/psychological-horror, Alaska wilderness), pillars (KNOWLEDGE, SIGNATURE, CONSEQUENCE), The Hand / Hidden Hand canon, psionics and neural load, three-threat-class horror model, memory progression, starting lock, renderer decision, scope doctrine, narrative pillars. ALWAYS loaded as item 2 of the governing set. Canon: doctrine/BLACK_VECTOR_DOCTRINE.md.
---

# BLACK VECTOR — PROJECT DOCTRINE (BV-DOCTRINE)

## NAME
BLACK VECTOR PROJECT DOCTRINE — canonical governing doctrine for the project. Canon text lives in `doctrine/BLACK_VECTOR_DOCTRINE.md`; this skill is the always-loadable embodiment.

## PURPOSE
Bind every BLACK VECTOR decision to the project's permanent identity and doctrine (reconciled under Directives 002 and 003): what the game is, who the protagonist is, which constraints are inviolable, and which reference influences are mapped to which areas. Loaded as item 2 of the governing set (after developers-way, before any SOP or domain skill).

## WHEN TO LOAD
ALWAYS, as part of the governing set, before any directive execution, SOP application, or domain-skill loading. Re-load whenever project identity, canon, or doctrine is under discussion.

## DO NOT LOAD WHEN
Never skip it when performing BLACK VECTOR work. (Governing-set member with no skip condition.)

## PRECONDITIONS
- `developers-way` loaded first (governing order).

## GOVERNING INVARIANTS
1. BLACK VECTOR is a SEPARATE project from NOMADIC CREED: independent code, engine config, canon, directives, and structure. Nothing is carried over without an explicit directive (doctrine §1).
2. Genre is LOCKED (BV-D011): third-person survival / stealth / tactical-action / psychological-horror, edge-device-first, smaller than NOMADIC CREED. NOT a universal military simulation, NOT a mission-lobby shooter (doctrine §1).
3. Setting (BV-D012): one continuous fictional Alaska-inspired coastal wilderness region; world is the mission/progression/survival/exploration/narrative interface; sector activation keeps only the relevant region simulated; transitions concealed (doctrine §5, §31).
4. Pillars: KNOWLEDGE (no global truth; knowledge has a source; the Hand's own memory is a source with damaged reliability), SIGNATURE (multi-channel detectability; NO `hidden = true`), CONSEQUENCE (causal, remembered — including moral consequence) (doctrine §2).
5. Progression is MEMORY: EXPERIENCE→TRIGGER→MEMORY→RECOGNITION→CAPABILITY RESTORED. No XP trees/levels/skill points/stat progression (doctrine §3). Eight recovered capability FAMILIES (disciplines), not RPG trees (doctrine §32).
6. The Hand is both guilty AND manipulated — never absolved; the institution may have been false, the BROTHERHOOD was not; all conspiracy exec/government figures are fictional (doctrine §14, §17, §18, §34, BV-D014/D022). Photograph is a persistent narrative artifact, NEVER loot (doctrine §28).
7. Starting lock: compact sidearm + 1 loaded mag + 1 spare mag + fixed-blade boot knife + Hidden Hand photograph; NO rifle/carbine at start (doctrine §4).
8. Stealth is multi-channel signature reduction, computationally bounded, legible; NOT a military sensor simulator; ENVIRONMENTAL channel includes Alaska weather as designed play (doctrine §6).
9. Assassination and combat are DISTINCT states: UNSEEN→POSITION→OPPORTUNITY→ASSASSINATION vs DETECTED→ENGAGEMENT→EXCHANGE→…→ADVANTAGE→FINISH|ESCAPE. Close-combat vocabulary is fixed; NO enormous combo lists (doctrine §7, §8).
10. Psionics MULTIPLY, never replace existing capabilities; neural-load cost pipeline (action→load→pain/distortion→vulnerability→possible memory/perception event); NO mana bar; no unlimited flight/destruction/magic-spam (doctrine §21, §22, BV-D015).
11. Horror model (BV-D016): three threat classes (HUMAN / EXPERIMENTAL / PARANORMAL). Paranormal is rare, disruptive, partially unexplained, and NEVER routine enemy content; biblical imagery is symbolism/classification, ambiguity mandatory, no real-world religion proven (doctrine §23, §24).
12. Survival and restoration are BOUNDED: survival creates decisions, not meters/busywork (BV-D018); exactly ~5 curated restorable facilities, no freeform building, restore pipeline DISCOVER→INVESTIGATE→SECURE→RESTORE→CLAIM→IMPROVE (BV-D019, doctrine §30-31).
13. Ally (ex-second-in-command) provides BASE-ANCHORED CAPABILITIES, never a constant follower, never a stat aura; not perfectly reliable (BV-D020, doctrine §25-26).
14. Renderer (BV-D001): initial target GL Compatibility; Mobile only via measured gate; Forward+ FORBIDDEN on Android. GDScript-first; local-first/offline; Android tablet design center (doctrine §10).
15. Scope: complexity spent where the player perceives it; smaller systemic footprint; hierarchy Developer's Way → Doctrine → SOPs → Skills → Directive → Implementation; lower layers never silently override (doctrine §11, §12).

## WORKFLOW
1. State the decision/question at hand.
2. Verify it against the doctrine invariants above, and against the canon file for depth (doctrine §14-34 for canon detail).
3. Where doctrine is silent, treat as UNAUTHORIZED-BY-DEFAULT; do not improvise conflict (SOP-002).
4. Log actioned decisions in doctrine §13 decision log ONLY with a directive's authority.

## IMPLEMENTATION GUIDANCE
- Doctrine is canon; the skill is a loadable mirror. If they ever disagree, the canon file wins and the skill is updated.
- Bind every gameplay work item back to a doctrine section in its report line (e.g., "fsm: doctrine §8").
- Canon guards in play: The Hand vs Hidden Hand naming; Black Hand vs BLACK VECTOR; guilt never negated by victimhood; prologue competence vs later fragmentation; tactical realism vs paranormal ambiguity; bounded survival; one-world vs device budget; ally support vs isolation; psionic power vs vulnerability; curated bases vs freeform.
- When a directive conflicts with any invariant, STOP and report the conflict (doctrine §12).

## ANTI-PATTERNS
- Treating NOMADIC CREED canon/structure as reusable for BLACK VECTOR.
- Introducing XP, levels, skill trees, or stat progression in any form.
- Adding a `hidden = true` mechanic "just for this one case."
- Letting the rifle appear at start, or making direct combat universally optimal.
- Design work that makes stealth/assassination unreadable or perception telepathic.
- Turning paranormal into routine enemy content, or over-explaining anomalies (doctrine §23).
- Portraying the Hand as pure victim (absolution) OR as purely villainous (ignores the program) — doctrine §18 keeps both.
- Naming real administrations/officeholders in the conspiracy (doctrine §17).
- Base-building feature creep toward freeform voxel/building systems (doctrine §31).

## KNOWN FAILURE MODES
- Canon drift: skill and canon file diverge after directives edit doctrine → reconcile skill from canon at the end of every directive.
- Scope bloat disguised as "quality": cuts and merges follow doctrine §11, not feature lore.
- Naming collisions (Black Hand vs BLACK VECTOR; The Hand vs Hidden Hand) → always canonical spelling; the doctrine uses bold caps for programs and plain for the protagonist.

## VERIFICATION
- Static: skill section content matches canon file invariants (validator greps key invariants); decision log entries carry a directive ID + status; naming discipline (Hand/Hidden Hand/Black Hand/BLACK VECTOR) greps clean.

## STOP CONDITIONS
Stop if: the canon file cannot be located, the skill disagrees with canon without a recorded reconciliation, or a directive would breach an invariant — report and align before proceeding.

## RELATED SKILLS
- developers-way (governing, loaded first)
- SOP-001 verify-first; SOP-002 scope-authority; SOP-005 gameplay-verification (governing set)
- All BV domain skills (BV-SKILL-001..020) implement parts of this doctrine