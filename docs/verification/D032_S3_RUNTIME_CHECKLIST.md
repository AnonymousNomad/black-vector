# BLACK VECTOR — D032 S-3 F1 First Restoration Beat Runtime Acceptance Checklist

**Authority:** D032 Runtime Acceptance Gate (repository-owned verification authority).
**Branch:** `work/d032-s3-first-restoration` (DO NOT merge to main).
**Accepted baseline:** `06601c458b56973961f755ba39ab612131030aa4` (D032 S-2 RUNTIME ACCEPTED).
**Scope:** ONE bounded restoration loop — seized machinery → dependency/failure → RESTORE → canonical
facility power → heat/light benefit → one signature consequence → persistence.
**Status:** IMPLEMENTED / RUNTIME UNVERIFIED.

This document is the canonical, repository-owned runtime acceptance procedure for D032 S-3. It supersedes
machine-local copies. Running the device gate means executing **every** gate in this document, in order, and
recording every result. S-2 acceptance (`docs/verification/D032_S2_RUNTIME_CHECKLIST.md`) remains historical
and its gates are re-run here as regressions.

---

## Runtime Acceptance Rule

D032 S-3 is accepted only when the device proves ALL of the following:

- the accepted S-2 baseline behavior still holds (door, light toggle, narrative once-gates, persistence,
  DeepGate containment);
- the canonical power object has one unambiguous truth and is owned by `CanneryState`;
- restoration is dependency-gated (not a free button press) and the failure is understandable;
- a successful restoration transitions facility state to POWERED and produces an observable light benefit
  and an observable heat/shelter benefit through the existing pressure/shelter ownership;
- one signature consequence is represented canonically in WorldState/observability;
- successful restoration occurs exactly once and never replays on load;
- DeepGate remains sealed and INSPECT-only, and Bay B remains inaccessible;
- no parser/resource/runtime error appears.

If ANY runtime failure occurs: record the exact symptom and evidence, do NOT broaden scope, repair the root
cause only, re-run the complete checklist.

---

## Gate 1 — Accepted baseline identity

1. Confirm branch `work/d032-s3-first-restoration`.
2. `git rev-parse HEAD` — record the SHA; must descend from accepted baseline
   `06601c458b56973961f755ba39ab612131030aa4`.
3. Confirm `git status --short` is clean before the run.
4. Confirm the accepted S-2 record is present and unchanged
   (`docs/verification/D032_S2_RUNTIME_CHECKLIST.md`, status RUNTIME ACCEPTED).

## Gate 2 — Foundation self-check

Run `res://scenes/slice/foundation_self_check.tscn`. All 15 S-2 rows plus the S-3 rows (16–20) must PASS:
16 canonical power contract (initial UNPOWERED, owner CanneryState); 17 dependency (machinery inspect-only,
fuel uncollected); 18 unpowered projection (no heat zone, light off); 19 DeepGate sealed/INSPECT-only;
20 first-restore marker absent. Any FAIL → record row and stop.

## Gate 3 — Strand regression

Exercise the Strand surface as at the S-2 freeze. Expect baseline behavior unchanged (movement, crate open,
supply collect, inspect surfaces, climb, rest, survey, record, presence awareness). No regression.

## Gate 4 — Cannery reachability

Walk east off the Strand onto the cannery approach pad (world edge x≈10, z≈0). Expect continuous floor (no
gap/pit at the seam); IntroSign, ApproachCrate (fuel cache), ApproachCoverF1 reachable.

## Gate 5 — EntryDoor regression

INSPECT the covered door from the front → OPEN. Expect door collision drops, mesh hides, exactly one
`entry opened` field entry, POI registered, FACILITY_STATE DORMANT → ENTRY_OPEN. Walk through into Bay A.

## Gate 6 — Machinery initial INSPECT state

Aim at Machinery01 (`f1_cannery_machinery_01`) before collecting fuel. Expect context action INSPECT only;
RESTORE must NOT be offered. Inspecting reports the seized/needs-fuel state (one `SEIZED` field entry).

## Gate 7 — Dependency / failure path

Attempt restoration without the fuel dependency. Expect: no RESTORE eligibility; failure understandable
(seized state recorded); no facility transition; no power state change. Collect the fuel from the approach
crate (COLLECT `f1_cannery_fuel`) and confirm the object marks collected.

## Gate 8 — RESTORE eligibility

After the fuel is collected, aim at Machinery01. Expect context action RESTORE; INSPECT is replaced while
the dependency is satisfied and the system is unpowered.

## Gate 9 — Successful restore transition

Perform RESTORE. Expect exactly one transition: fuel consumed (canonical), canonical power object set,
facility state POWERED, light benefit applied, signature consequence recorded, first-restore marker set.
Machinery context returns to INSPECT (RESTORE unavailable).

## Gate 10 — Canonical power state

Confirm `world.objects["f1_gyle_cannery_power"]` has exactly one canonical powered truth; no conflicting
verb flags; node/audiovisual state is not used as truth.

## Gate 11 — Light benefit

Confirm the powered interior lighting state is observable: `f1_gyle_cannery_light` canonical state and
`InteriorLight.visible` coherent. Manual LightSwitch toggle still works (S-2 canonical truth preserved).

## Gate 12 — Heat benefit

Confirm the powered Cannery is a heated/sheltered structure through the existing pressure/shelter
ownership: standing inside Bay A with power on reports `sheltered = true`; with power off it does not.
No second survival system.

## Gate 13 — Signature consequence

Confirm ONE consequence is represented canonically in WorldState/observability (heat/light signature) and
is recorded exactly once. No enemies, factions, or combat are spawned.

## Gate 14 — DeepGate containment

Confirm DeepGate remains sealed and INSPECT-only; collision layer unchanged; no open state; DeepBayLight
remains inaccessible/disabled; no Bay B gameplay exposed. Re-prove containment from the seam and sides.

## Gate 15 — Repeated interaction idempotence

Re-trigger the restore path (re-inspect, re-attempt state path). Expect no second transition, no duplicate
signature, no duplicate field entry, no duplicate facility change, no additional fuel consumption.

## Gate 16 — Save

At the restored canonical state (door open, power on, light state, signature, marker, player moved),
perform a Save.

## Gate 17 — Full process terminate / relaunch / load

Fully terminate the application (not a return-to-menu). Relaunch and load the saved slot.

## Gate 18 — No side-effect replay

After relaunch + load, verify: power state, facility POWERED, light projection, heat benefit, signature
state, first-restore marker, consumed fuel, player position, prior S-2 door state, and narrative seen-set
are restored — with NO replay of the restoration transition, signature, field entry, registration, or fuel
consumption. Load projects persisted truth only.

## Gate 19 — Prior narrative / equipment persistence regression

Confirm S-2 regressions: awakening/photograph/cannery-unsealed/reality beats once, no replay after reload;
exact starting kit; sidearm INSPECT-only; no fire/shoot input or method.

## Gate 20 — Native tablet touch/runtime observation

On the tablet, with native Godot 4.7.2 GL Compatibility: observe the dependency path, RESTORE, light/heat
benefit, and signature through the actual touch layout. Manual/device observation only — do not mark PASS
headlessly.

---

## Failure capture requirements

For ANY failed gate, capture and record: gate; scene; reproduction sequence; expected result; actual
result; exact Godot error/warning; affected node/object/state; reproducibility; evidence path; suspected
owner marked HYPOTHESIS. Then STOP — do not begin speculative repair without operator review.

## Final result classification

- `D032 S-3 — RUNTIME ACCEPTED` when all required runtime/device gates pass.
- `D032 S-3 — DEVICE ACCEPTANCE PENDING` when automated gates pass but native device acceptance is
  outstanding.
- `D032 S-3 — RUNTIME REJECTED — <specific defect>` when a real defect remains.
