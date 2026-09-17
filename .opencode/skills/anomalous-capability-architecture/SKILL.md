---
name: anomalous-capability-architecture
description: Reusable design procedure for anomalous capability systems — mass/range/complexity bounding, acquisition/discovery progression, capability ceiling design, superhero-prevention matrices, path persistence/switching, presentation/failure integration, cross-system integration rules, observability requirements. Pure methodology: NO per-character or per-campaign canon lives here (those live in the bible and doctrine). Load when designing any anomalous/power/psi capability system, when proposing a new capability ceiling, or when reconciling an authored capability against the prevention matrix.
---

# ANOMALOUS CAPABILITY ARCHITECTURE (BV-SKILL-030)

## NAME
ANOMALOUS CAPABILITY ARCHITECTURE

## PURPOSE
Own the REUSABLE design procedure for the anomalous capability layer. This is METHODOLOGY, not canon — it tells
future directives how to design a capability system (mass/range/complexity bounding, acquisition progression,
ceiling design, prevention matrices, path persistence, presentation, cross-system integration, observability). It
does not state what a specific character can or cannot do; those statements live in the per-character/per-campaign
bible (e.g. `docs/design/ANOMALOUS_CAPABILITY_BIBLE.md` for The Hand / Season 1) and in doctrine (BV-D### rows).
This separation keeps the skill fleet from collapsing into duplicated lore.

## WHEN TO LOAD
- Designing or extending any anomalous / power / psi capability system for a BLACK VECTOR character or saga.
- Proposing a new capability ceiling, prevention-matrix row, or path expression.
- Reconciling an authored capability against the prevention matrix (does this row cross a NEVER? does it
  trivialize an existing layer?).
- Reasoning about mass/range/complexity tradeoffs and the cost-class model.
- Designing the discovery / acquisition pattern (diegetic progression).
- Defining presentation language (visual / audio / body feedback / HUD) for a power layer.

## DO NOT LOAD WHEN
- Implementing the cost / pain / vulnerability pipeline (BV-SKILL-019).
- Implementing combat / Control / Strain internals or TK-in-CQC (BV-SKILL-021).
- Authoring horror / perceptual / Memory-Bleed CONTENT (BV-SKILL-018).
- Writing per-character capability canon, per-campaign ceiling, or per-capability limits — those live in the
  per-character bible and doctrine.
- Designing weapon / equipment / visual identity (BV-SKILL-022/025/011).

## PRECONDITIONS
- Governing set loaded.
- Existing doctrine read: §21 (Psionics), §22 (Psionic Cost), §23 (Horror), §35-§39 (Combat), §36.3 (Strain 2×2),
  §37 (Compound Branch).
- Existing skills read: 019 (cost pipeline), 021 (CQC/Strain), 018 (horror authoring), 028 (opening gates),
  029 (world-systems), 022 (visual language of equipment — distinct from power language).
- Existing per-character bible (the canonical Season-1 example is `docs/design/ANOMALOUS_CAPABILITY_BIBLE.md`)
  read so methodology does not duplicate per-canon limits.

## GOVERNING INVARIANTS
1. METHODOLOGY ONLY: this skill defines HOW to design a capability layer; it does not state what any specific
   character or campaign permits. Per-character / per-campaign limits live in the per-character bible and in
   doctrine. A future directive that wants to lift a limit does not edit this skill.
2. MULTIPLY, NEVER REPLACE: every capability must compose with the operator's existing skills (doctrine §21;
   BV-SKILL-019). Capability design must list the human skills it multiplies and confirm it does not substitute
   for any whole system.
3. NO MANA: cost design must couple NEURAL STRAIN × CONTROL × EXERTION × INJURY × CONCENTRATION × ENVIRONMENT ×
   MASS × RANGE × COMPLEXITY × TARGET COUNT × DURATION, never a single renewable pool. Cost is INTERCONNECTED,
   not a bar (doctrine §22; BV-SKILL-019 invariant 1+3).
4. GRADED STRAIN: Strain design must be banded (LOW / ELEVATED / HIGH / CRITICAL or equivalent) with authored
   symptoms per band — never "bar full = cannot cast" (BV-D036; D016 §4).
5. INDEPENDENT CONTROL × STRAIN: the 2×2 of play states is the canonical interaction model (BV-D037;
   BV-SKILL-021 invariant 6). Capability design must list what each cell reads like for the capability under
   design.
6. MASS / RANGE / COMPLEXITY BOUNDING: every capability carries qualitative mass class, qualitative range band,
   and a complexity assessment against the canonical complexity law. No kilogram numerals unless the implementation
   contract demands them; the DESIGN uses qualitative bands (D016 §13–§16).
7. DISCOVERY PROGRESSION: capability acquisition must follow a diegetic pattern
   (EVENT → ACCIDENTAL MANIFESTATION → RECOGNITION → EXPERIMENTATION → DELIBERATE USE → MASTERY or equivalent
   for the saga). The first undeniable use must be EARNED, not menu-driven (D016 §11). Phase count may vary by
   saga but must be explicit and cannot be skipped.
8. SUPERHERO-PREVENTION MATRIX: every designed capability must be classified against the canonical
   NEVER / NOT-IN-SAGA / POSSIBLE-LATER / SAGA-ALLOWED matrix (or saga-equivalent). NEVER rows are absolute;
   NOT-IN-SAGA rows are per-campaign; the matrix is the table of contents, the per-capability section is the law.
9. PATH PERSISTENCE: when a system has progression branches (Compound / Independent or equivalent), switching
   must NOT be instant, must carry costs, and the branches must NOT be objectively superior (doctrine §37.3;
   D016 §30-§34). Each branch expresses a different identity through the SAME capabilities.
10. PRESENTATION INTEGRATION: visual, audio, body-feedback, and HUD presentation must reinforce the operator's
    body, not replace it (D016 §41–§45; BV-SKILL-022 owns equipment visual, not power VFX). LOW Strain = subtle;
    HIGH Strain = layered; CRITICAL = the cost becomes the visual.
11. CROSS-SYSTEM INTEGRATION: capabilities must compose with the existing systems and NOT bypass their gates
    (stealth honesty BV-SKILL-007; perception honesty BV-SKILL-008; combat ownership BV-SKILL-021; survival
    substrate BV-SKILL-017/029; horror budget BV-SKILL-018; world-state propagation BV-SKILL-029).
12. OBSERVABILITY: every capability must declare the debug surfaces it will need (current state, target
    validation, mass/range/complexity, strain delta, control delta, path state, modifiers, failure reason,
    involuntary trigger reason) so SOP-006 / BV-SKILL-015 contracts are honored at implementation time.
13. NO FUTURE-SAGA CONTAMINATION: designing for the current saga must not import future-saga material into the
    current canon. Defer with CANDIDATE flags; do not promote.
14. TABLET FEASIBILITY: capability designs must remain compatible with Android/tablet + GL Compatibility
    (BV-D001 / D016 §54): authored interactables, bounded physics, selective VFX, event-driven behavior, pooled
    effects, short high-value presentation bursts.

## WORKFLOW
1. Read the per-character / per-campaign bible to confirm the capability layer's canonical scope; confirm no
   design will duplicate canon.
2. Define or extend the COST model: which costs apply, how they couple, how bands map to player-visible feedback.
3. Define MASS / RANGE / COMPLEXITY bands for the system; confirm the COMPLEXITY LAW (multiplicative with mass
   and range) is preserved.
4. Author DISCOVERY PROGRESSION: enumerate the phases (5+ recommended), the diegetic trigger pattern, and the
   EARNED first-use rule.
5. Author the SUPERHERO-PREVENTION MATRIX rows for the capabilities under design; resolve every row against the
   canonical NEVER / NOT-IN-SAGA / POSSIBLE-LATER / SAGA-ALLOWED status.
6. Define PATH PERSISTENCE / SWITCHING rules if the system has branches; confirm non-superiority.
7. Define PRESENTATION language (visual / audio / body feedback / HUD) and ensure it composes with the operator's
   body, not replaces it.
8. Define CROSS-SYSTEM integration: which existing skills consume the capability, which gates the capability
   cannot bypass, which world-systems the capability interacts with.
9. Define OBSERVABILITY surfaces and the failure / recovery channels (SOP-006 / BV-SKILL-015).
10. Validate against TABLET FEASIBILITY and the per-character bible's contradiction ledger.

## IMPLEMENTATION GUIDANCE
- Use qualitative bands (TRIVIAL / LIGHT / MODERATE / HUMAN-SCALE / EXTREME for mass; TOUCH / NEAR /
  TACTICAL / EXTENDED-RARE for range). Translate to numbers at implementation time if required by SOP-005.
- The complexity law (D016 §15) is multiplicative: every axis the player adds multiplies. Honor it in the design
  table before any per-capability wording.
- Discovery progression always has a FIRST UNDENIABLE EVENT. That event must be:
  - forced by an emotionally or physically desperate circumstance
  - undeniable to operator and player (the world reacts)
  - earned (conventional answers must be exhausted)
  - followed by deliberate-use entry
- Path-switching design must specify time / adaptation / withdrawal / consequence for every switch.
- Presentation cues belong to the same channel architecture as stealth / horror (no parallel "magic" channel).
- HUD discovery presentation must enter as SYMPTOMS first, then BAND late; never as a psychic meter on day one.

## ANTI-PATTERNS
- Re-stating per-character / per-campaign canon inside this skill (creates duplicated lore).
- Designing a capability that bypasses a known system gate (perception honesty, combat ownership, world-state
  propagation, no-mana law).
- A single renewable cost pool (mana reskin).
- A capability the player unlocks by button-press with no diegetic trigger.
- Instant path-switching that lets the player optimize for encounter type.
- A prevention-matrix NEVER lifted silently by a new directive.
- Power VFX that replaces the operator's body reaction (operator becomes a glow-stick, not a person).
- Future-saga material imported as canon to make a current capability "feel cooler."

## KNOWN FAILURE MODES
- Capability creep: more rows, no prevention — re-run the prevention-matrix check before adding any new row.
- Cost / feedback drift: costs that look small but feel large (or vice versa) — pair cost-class with feedback-class
  in the same row.
- Discovery leak: an early capability that announces itself instead of being EARNED — re-anchor to D016 §11.
- Cross-system drift: a capability that "just reads enemy position" because the bypass is convenient — re-anchor
  to BV-SKILL-008 honesty.
- Lore duplication: capability canon copied into the skill instead of staying in the per-character bible — strip
  and reference.

## VERIFICATION
- Static: every capability under design carries cost class, mass class, range band, complexity assessment,
  discovery phase placement, prevention-matrix classification, path-state rule (if applicable), presentation
  cues, observability surfaces, failure/recovery channels, cross-system references.
- Cross-skill: no parallel cost, perception, combat, or propagation systems invented; existing owners consumed.
- Tooling: run `tools/validate_methodology.py` and `tests/static_verify_game.py` after any canon change. Per-
  character bible's contradiction ledger should remain at zero contradictions.

## STOP CONDITIONS
If a designed capability replaces a whole system, costs a generic pool, is acquired by button-press without
earned trigger, lifts a prevention-matrix NEVER silently, trivially resolves a survival/horror/world layer, or
imports future-saga material — stop and re-anchor to this skill's invariants and the per-character bible.

## RELATED SKILLS
- BV-SKILL-019 psionic-gameplay-neural-load (cost / pain / vulnerability pipeline — methodology owns NOTHING of
  this skill's internals)
- BV-SKILL-021 cqc-combat-architecture (Combat / Control / Strain internals + TK-in-CQC boundary)
- BV-SKILL-018 psychological-horror-perceptual-events (horror authoring contract the methodology must compose
  with)
- BV-SKILL-022 visual-equipment-doctrine (equipment visual language; power presentation is a separate methodology
  concern but composes with this)
- BV-SKILL-017 survival-wilderness-systems (survival substrate capabilities compose with)
- BV-SKILL-029 simse-island-systems (world-systems propagation capabilities compose with)
- BV-SKILL-028 prologue-narrative-architecture (opening knowledge-gate compatibility)
- BV-SKILL-012 diegetic-memory-progression (memory / discipline gates)
- BV-SKILL-015 gameplay-debugging-instrumentation (observability surfaces)
- D016 canonical bible = `docs/design/ANOMALOUS_CAPABILITY_BIBLE.md` (per-character canon this skill does not
  duplicate)
- developers-way, black-vector-project-doctrine (governing); SOP-005/006
- BV-SKILL-035 operator-discipline-architecture (D025 — anomaly integrates with six competencies (recon+sniper+CQC+FO+covert+direct action); this skill retains anomaly methodology; composition)