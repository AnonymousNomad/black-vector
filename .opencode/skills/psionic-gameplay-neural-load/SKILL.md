---
name: psionic-gameplay-neural-load
description: Psionic gameplay and neural load — psionics MULTIPLY the Hand's existing capabilities, never replace them; neural-load pipeline (ACTION→LOAD→PAIN/DISTORTION→VULNERABILITY→POSSIBLE MEMORY/PERCEPTION EVENT); bounded capability list; no mana bar, no superpower spam. Load when implementing/tuning psionics or their costs.
---

# PSIONIC GAMEPLAY AND NEURAL LOAD (BV-SKILL-019)

## NAME
PSIONIC GAMEPLAY AND NEURAL LOAD

## PURPOSE
Implement the Hand's limited psychokinetic/anomalous capability (doctrine §21) and its cost identity (doctrine §22): psionics MULTIPLY his existing assassin/survival skills, never replace them; every use flows through the neural-load pipeline; cost and gain are inseparable. This is horror-adjacent power with vulnerability built in — never a superhero system, never a mana-bar game.

## WHEN TO LOAD
- Implementing/tuning any psionic capability, cost, distortion, or the load pipeline.
- Reasoning about how psionics interact with positioning, assassination, combat, or survival.

## DO NOT LOAD WHEN
- Authoring the perceptual/paranormal CONTENT of distortion events (BV-SKILL-018 owns authored events; this skill owns the cost machinery that triggers them).
- Normal weapon/close-combat internals (BV-SKILL-011/010) — psionics are multipliers layered on, not replacements.

## PRECONDITIONS
- Governing set loaded.
- Capability & discipline model (doctrine §3, §32 — PSIONICS is one of the eight recovered families) and starting lock (doctrine §4) understood.
- Distortion-event authoring contract available (BV-SKILL-018): heavy-use memory/perception events are authored events with ids.
- Observability contract (BV-SKILL-015) — neural load and distortion are WORLD/PERCEIVED separable.

## GOVERNING INVARIANTS
1. MULTIPLY, NEVER REPLACE: «Psionics multiply the Hand's existing assassin/survival capabilities rather than replacing them» (doctrine §21). A psionic action that substitutes for a whole system (e.g., "just push the enemy, no combat/stealth needed") is a scope violation.
2. BOUNDED CAPABILITY LIST: pulling small objects, pushing objects, limited kinetic manipulation, recall/manipulating knives in play, temporarily moving heavier environmental objects at high cost, brief restraint/interruption of enemies, limited anomalous perception. FORBIDDEN: unlimited flight, superhero-scale destruction, magic-combat spam (doctrine §21).
3. NEURAL-LOAD PIPELINE IS THE COST MODEL (doctrine §22): PSIONIC ACTION → NEURAL LOAD → PAIN/DISTORTION → TEMPORARY VULNERABILITY → POSSIBLE MEMORY/PERCEPTION EVENT. Not a mana bar, not stamina-as-reskin. Load is a state the rest of the body and the horror layer read.
4. PROPORTIONALITY: small uses → small consequences; heavy uses → severe pain, tinnitus, motor instability, disorientation, flashbacks, hallucinations, temporary vulnerability (doctrine §22). Capability rank and cost rank are co-designed data, never "bigger power, same cost."
5. NO FULL MEMORY SEQUENCE ON EVERY USE: memory/perception events fire only on the heavy/edge path (doctrine §22); routine use must not turn the game into a cinema queue.
6. VULNERABILITY IS REAL AND OBSERVABLE: heavy-load temporary vulnerability affects locomotion and weapon handling (BV-SKILL-011/003 respect the same body state) — the overlay must show load and its mechanical consequences (BV-SKILL-015).
7. PSIONICS DO NOT BYPASS OTHER SYSTEMS' GATES: they expand positional/opportunity resolvers (BV-SKILL-009) and survival levers (BV-SKILL-017), but they never read perception internals, never auto-win assassinations, never grant stealth "hidden" (doctrine §6, §21).
8. ANOMALY SYNERGY: heavy distortion events are handed to the horror layer (BV-SKILL-018) as authored perceptual events — psionics are a CAUSE, not a "we need more horror" button.
9. DISCIPLINE-GATED: PSIONICS is a recovered capability FAMILY (doctrine §32) — it is part of memory progression; it is not present at wilderness start (prologue shows no supernatural, doctrine §29).

## WORKFLOW
1. Read current capability/cost handling in current form; confirm no mana/stamina-reskin.
2. Define the capability list as data (capability, rank, load cost class, behavioral effect, positional/survival lever).
3. Implement the neural-load state machine: action → load accrual → pain/distortion curve → vulnerability window → (heavy-only) authored memory/perception event request.
4. Wire load/vulnerability into locomotion (BV-SKILL-003), weapon handling (BV-SKILL-011), and the horror layer (BV-SKILL-018).
5. Wire psionic levers into existing resolvers (positioning/assassination BV-SKILL-009; survival BV-SKILL-017) — they multiply, never replace.
6. Fixture-verify proportionality and gate-respect; static verify; behavioral/device when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Representative use patterns: knife recall = small load; brief enemy restraint = medium; moving a heavy environmental object = high; anomalous perception = medium-perceived (perception costs its own distortion weight, doctrine §22).
- Model neural load as a fading accumulation with a hysteresis (load recovers over rest), and an active VULNERABLE window on heavy uses with a clear mechanical signature.
- Distortion events (heavy path): raise a request to BV-SKILL-018 with load class + cause; never autoroll long cinematics on medium use.
- The overlay (BV-SKILL-015) exposes: current load, last action class, vulnerability window, and the human-verifiable reason chain — load must never be a hidden number with visible-only misery.
- Keep psionic input touch-ergonomic (gesture or wheel-of-abilities), small in count (a handful of capabilities, not a spellbook).

## ANTI-PATTERNS
- A mana bar (or reskinned "psi energy" that behaves like one) as the primary cost fantasy (doctrine §22).
- "Push = instant kill / fly = map skip" powers that replace traversal/stealth/combat (doctrine §21).
- Superhero-scale destruction or magic-combat spam.
- Full memory-cinema on every activation (doctrine §22).
- Psionics giving a free "unseen" bypass (a hidden-flag in disguise, Pillar 2 / doctrine §6).
- Unbounded capability creep into a spellbook of dozens of powers.

## KNOWN FAILURE MODES
- Cost-proportionality drift (medium raises to heavy silently) → data-driven rank/cost pairing audited in fixture.
- Vulnerability ignored by weapon/locomotion systems → the body-state contract is shared; overlay verifies.
- Distortion floods horror with events → heavy-only throttling + authored event budget (BV-SKILL-018).
- Gate-bypass creep (psionics "reading" enemy position) → invariant 7; reviewer tests leverage points.

## VERIFICATION
- Static: capability list ⊆ bounded list; cost classes pair rank; pipeline states present; heavy-only event request path; no mana-pattern (single-pooled renewable resource with no load/consequence); gate-respect (psionics never auto-win).
- Behavioral (when authorized): small vs heavy fixture shows proportional load+consequence; heavy use opens vulnerability window affecting locomotion/weapons; memory/perception event fires only on heavy path with authored id; knife recall resolves within resolver rules (BV-SKILL-009).

## STOP CONDITIONS
If a psionic action replaces a whole system, costs a generic pool, or triggers memory events on routine use — stop and re-anchor to doctrine §21-22.

## PERFORMANCE
- Psionic actions are discrete events; load curves are cheap; distortion events are authored and rare. No per-frame psionic passes (SOP-004).

## DEVICE
- Touch mapping for the few ability slots and the vulnerability telegraph validated on tablet; visual/audio feedback legible in darkness (BV-SKILL-014/018).

## RELATED SKILLS
- BV-SKILL-021 cqc-combat-architecture (TK-in-CQC boundaries; Control/Neural Strain framing — Neural Strain is the active combat-governing layer this pipeline feeds)
- BV-SKILL-030 anomalous-capability-architecture (D016 methodology for mass/range/complexity, discovery progression, prevention matrix, presentation — this skill retains cost/pain/vulnerability pipeline ownership)
- BV-SKILL-018 psychological-horror-perceptual-events (distortion authoring)
- BV-SKILL-009 contextual-assassination (levers expand resolvers)
- BV-SKILL-017 survival-wilderness-systems (survival levers)
- BV-SKILL-011 weapon-handling-ballistics / BV-SKILL-003 third-person-character-controller (vulnerability consumer)
- BV-SKILL-012 diegetic-memory-progression (memory events, discipline gating)
- BV-SKILL-015 gameplay-debugging-instrumentation (load observability)
- developers-way (governing)