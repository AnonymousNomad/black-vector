---
name: vertical-slice-discipline
description: Vertical-slice discipline — scoping a playable, provable slice of BLACK VECTOR for milestones; depth over breadth, slidable scope, QA criteria, and honest acceptance. Load when planning or evaluating a milestone/slice.
---

# VERTICAL-SLICE DISCIPLINE (BV-SKILL-016)

## NAME
VERTICAL-SLICE DISCIPLINE

## PURPOSE
Ensure every BLACK VECTOR milestone is a scoped, playable, verifiable vertical slice — proven systems, not promises — following depth-over-breadth (doctrine §1, §11). A slice is the unit the team ships and QA-gates against. Slices speak the reconciled canon: survival/stealth/tactical-action/psychological-horror in the Alaska wilderness (doctrine §1, §5) — a slice's one-sentence experience must serve the project's identity, not a generic sandbox fantasy.

## WHEN TO LOAD
- Planning a directive/milestone slice.
- Evaluating whether a slice is complete or acceptably slidable.
- Any "is this enough?" judgment call on scope.

## DO NOT LOAD WHEN
- Deep single-system mechanics work (that's the domain skill; this governs slice shape, not internals).

## PRECONDITIONS
- Governing set loaded.
- Slice target intent stated in ONE sentence (e.g., "player sneaks through X, assassinates Y from cover").

## GOVERNING INVARIANTS
1. DEPTH OVER BREADTH: a slice proves FEW systems DEEPLY. Do not string 6 half-systems into a "bigger" slice (doctrine §11).
2. THE SLICE IS AN EXPERIENCE, NOT A LIST: its acceptance is "the intended one-sentence fantasy is playable and legible," not "all subsystems exist."
3. SCALE-OUT-HEART: every system in the slice is implemented at production quality (observable, budgeted, verified) but only the portion the slice touches — no "fill directories for later."
4. SLIDABLE SCOPE, DECLARED: the slice has a mastered core plus optional garnish; when time-bounded, the agent cuts GARNISH first (documented as cut), never core, never by silently degrading systems.
5. QA CRITERIA ARE VERIFICATION CRITERIA (SOP-005 applied to slices): slice passes when its stated behavioral/performance/device checks pass on target. A slice that "feels fine" on desktop is NOT done.
6. EVERY SLICE SHIPS A ONE-LINE ELEVATOR PROOF: how to replay the intended fantasy deterministically (fixture/script route).

## WORKFLOW
1. Convert milestone intent to a one-sentence playable fantasy + its elevator proof (“launch X, do Y”).
2. Inventory needed systems; mark each in-slice (production) vs out-of-slice (defer) vs garnish (optional).
3. Declare the cut list explicitly BEFORE implementation (what we intentionally leave out and why).
4. Implement in-slice systems only; verify per system (SOP-005) as you go.
5. Run slice QA: behavioral fixture + device perf + observability pass on target.
6. Report: elevator proof replayable, cuts declared, QA evidence, known debt.

## IMPLEMENTATION GUIDANCE
- Slice heart candidates, in reconciled-canon terms: (a) the SIGNATURE/WEATHER micro-loop (walk/crouch/prone/sprint + light/conceal + ONE storm-driven masking state before ONE bounded observer) — proves BV-SKILL-003/004/007 and the weather coupling cheap; (b) a survival-decision micro-slice (cold/wetness/fatigue decision loop in a single piece of terrain, no combat) — proves bounded survival (BV-SKILL-017) creates decisions, not meters; (c) a single-walled assassination arc (UNSEEN→POSITION→OPPORTUNITY→ASSASSINATION with photograph-consequence). Do NOT scope more than one of these plus combat in a single slice unless the directive demands (doctrine §11).
- Keep garnish cheap (appearance, intro sound) — cut list is the health signal, not dead weight.
- The fixture/route used for elevator proof must be deterministic and rerunnable (BV-SKILL-015).
- Prefer proving the signature/stance/weather micro-loop (BV-SKILL-003/004/007) before big world work — that is the franchise core; survival and horror deepen it (BV-SKILL-017/018), they do not precede it.
- Prologue awareness: if the slice touches the opening, the prologue shows PEAK competence and wilderness start shows LOST competence (doctrine §29) — a slice that only builds "peak" or only "broken" without the contrast is not yet the product.

## ANTI-PATTERNS
- "20% of 5 systems" slices (breadth-only) — fails invariant 1.
- Slice without a one-sentence fantasy (steamrolls).
- QA by "it played OK on my machine."
- Cutting CORE silently at the end (unstating scope cuts).
- Adding garnish at the end because there is time (spend on depth/QA instead when time-bounded).

## KNOWN FAILURE MODES
- Slice expands as implementation progresses (core creep) → re-anchor on the elevator proof sentence.
- Systems verified structurally but never run on device → device step blocked → report as pending debt, do not call slice done.
- One system (e.g., traversal) swallows the whole budget → cut traversal depth to slice machinery, keep core stealth/assassination honest.

## VERIFICATION
- Slice acceptance = elevator-proof replayable + in-slice systems passing their static + behavioral (+device where authorized) checks + cuts declared + no hidden debt.
- Static: no out-of-scope directories/system files present; cut list honored.

## STOP CONDITIONS
If the slice cannot be stated in one experiential sentence, or its core can't be verified on target, stop and re-scope the slice smaller before implementing more.

## PERFORMANCE
- Slice QA runs under SOP-004 budgets with device measurement; headroom reported.

## DEVICE
- Slice acceptance always includes a device-verified run on the tablet when the runtime is authorized.

## RELATED SKILLS
- BV-SKILL-015 gameplay-debugging-instrumentation (fixture/route discipline)
- BV-SKILL-003/004/007 (signature sandbox core)
- BV-SKILL-009 contextual-assassination (assassination arc)
- SOP-005 gameplay-verification; SOP-002 scope-authority; developers-way (governing)