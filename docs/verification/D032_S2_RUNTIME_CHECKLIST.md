# BLACK VECTOR — D032 S-2 Gyle Cannery Runtime Acceptance Checklist

**Authority:** D032 Runtime Acceptance Gate (repository-owned verification authority).
**Branch:** `work/d031-production-spine` (DO NOT merge to main).
**Initial instrumentation baseline:** `396dabd` (S-2 runtime gate instrumentation + bounded pre-runtime repairs).
**Status:** STATIC ACCEPTED / RUNTIME UNVERIFIED. Do not advance playable gameplay until this gate is green.

This document is the canonical, repository-owned runtime acceptance procedure for D032 Slice 1.
It supersedes any machine-local copy or out-of-repository notes. Running the device gate means
executing **every** gate in this document, in order, and recording every result.

---

## Runtime Acceptance Rule

D032 Slice 1 is accepted only when the device proves ALL of the following:

- project parses in Godot;
- foundation self-check completes all 15 rows successfully;
- Strand regression is clean;
- Cannery is reachable;
- door/light/gate behavior is correct;
- `presence_f1` does not depenetrate or manufacture hostility;
- gate seam cannot be bypassed unintentionally;
- narrative beats fire only once;
- starting equipment is correct;
- save/reload restores world + narrative state;
- no parser/resource/runtime error appears.

If ANY runtime failure occurs:

1. record the exact symptom and evidence (do not guess — capture the actual message/node/scene);
2. do NOT broaden scope;
3. repair the root cause only;
4. re-run the complete runtime checklist.

No D032 gameplay expansion until this gate is green.

---

## Gate 1 — Repository / commit identity

1. Confirm the checkout is `work/d031-production-spine`.
2. `git rev-parse HEAD` — record the SHA. The acceptance run must be at a head that includes the
   S-2 instrumentation commit `396dabd` (or a later commit that inherits it). Record `local` vs `origin`
   sync state.
3. Confirm `git status --short` is clean (no unexplained working-copy drift before the run).
4. Confirm the tree contains the S-2 instrumentation:
   - `game/scripts/slice/foundation_self_check.gd` — rows 11–15 D032 probes present;
   - `game/scenes/slice/sector_f1_gyle_cannery.tscn` — LightSwitch/InteriorLight/DeepGate/PresenceF1;
   - `game/scripts/slice/beat_staging.gd` — once-gated `beat_cannery_unsealed`.

## Gate 2 — Foundation self-check (`foundation_self_check.tscn`)

Run scene `res://scenes/slice/foundation_self_check.tscn`. **All 15 rows must PASS**
(boot state, no interaction required). Expected rows:

| # | Check name | Pass condition |
|---|-------------|----------------|
| 1 | project boot | Godot launches, version reported |
| 2 | main scene | main_scene resolves to `slice_main.tscn` |
| 3 | autoloads | InputManager + Settings autoloads live |
| 4 | input abstraction | all abstract actions bound; touch adapter live |
| 5 | touch movement | adapter injected (finger test manual) |
| 6 | keyboard/controller | adapters present (functional test manual) |
| 7 | game world | GameWorld + WorldState live |
| 8 | camera structure | CameraRig present on player |
| 9/10 | save round trip + persistence | write→verify→load restores world+body+seed+player |
| 10 | gl compatibility | rendering_method = gl_compatibility |
| 11 | D032 cannery structure | CanneryState + BeatStaging + EntryDoor + InteriorLight + LightSwitch + DeepGate present |
| 12 | D032 starting kit | sidearm(INSPECT)+magazines+photograph(INSPECT)+boot_knife, tool equipped |
| 13 | D032 narrative keys | `inner_strand_awakening`, `inner_photograph`, `inner_cannery_unsealed`, `reality_gyle_cannery` present |
| 14 | D032 presence_f1 | `presence_f1` live in `human_presence` group |
| 15 | D032 firearm absent | no `func fire` / `func shoot` definitions in `res://scripts` |

Pass → proceed. Any FAIL → record symptom + the failing row, stop, do not proceed to runtime walkthrough.

## Gate 3 — Slice load

Launch `game/project.godot` normally (main_scene `slice_main.tscn`).
Expect: strand loads, camera follows, input works (keyboard/controller; touch on tablet).
Record any parser/resource/runtime error printed to console — ANY such error is a failure.

## Gate 4 — Starting equipment runtime truth

1. Inspect equipment. Expect exactly: boot knife (tool, default equipped), sidearm (weapon,
   INSPECT only), magazines (ammo, "one loaded, one spare"), photograph (personal, INSPECT only),
   plus baseline medical/supplies/observation.
2. **Negative gate:** confirm the sidearm affords NO FIRE/SHOOT action on any input. No
   projectile/hitscan/damage behavior exists. (Backed by self-check row 15.)

## Gate 5 — Strand regression

1. Exercise the strand's existing surface on device just as at the D031 freeze.
2. Expect baseline behavior unchanged — D032 must not regress the Strand.
3. `presence_f1` is inside Bay A behind the closed door — confirm it does not trigger from the strand
   side at approach distances the door blocks.

## Gate 6 — Cannery reachability

Walk east off the strand floor onto the cannery approach pad (world edge x≈10, z≈0 axis).
Expect a continuous floor (no gap/pit at the seam); IntroSign, ApproachCrate, ApproachCoverF1 reachable.

## Gate 7 — EntryDoor (`f1_gyle_cannery_door`)

1. INSPECT the covered door from the front → press OPEN.
2. Expect: door collision layer drops (walk through), mesh hides, one-time side effects fire exactly
   once — single field entry (`f1_gyle_cannery_door` "entry opened"), single POI, FACILITY_STATE
   DORMANT → ENTRY_OPEN. No beat spam.
3. Walk through into Bay A.

## Gate 8 — Bay A walkthrough

Walk Bay A (the entry room, west of the DeepGate). Interact with the inspectable prop in Bay A:
Machinery01 (`f1_cannery_machinery_01`). Expect no collision issues, no stuck spots, no camera
clipping.

Bay B props (Vat01, CollectCrateF1 `f1_cannery_crate_01`, Conveyor01, Vat02, CrateStack02) are
placed east of the INSPECT-only DeepGate (`f1_gyle_cannery_gate`, local x≈0.1) and are intentionally
sealed in S-2; they are not part of this gate and are not to be relocated to satisfy it.

## Gate 9 — InteriorLight / LightSwitch (canonical path)

1. Confirm InteriorLight starts OFF (Bay A lit by scene directional; DeepBayLight stays off).
2. Interact with LightSwitch → OPEN. Expect InteriorLight turns ON **through the canonical event
   path** (world state `f1_gyle_cannery_light` → CanneryState applies to the OmniLight3D). No
   local-only state.
3. Interact again → turns OFF. World state and node state never contradict.

## Gate 10 — DeepGate (`f1_gyle_cannery_gate`)

1. INSPECT the DeepGate → inspect trace only; affordance must be INSPECT (never OPEN).
2. DeepBayLight stays disabled and unreachable from Bay A.

## Gate 11 — Side-access / seam bypass attempt (containment proof)

Attempt to reach Bay B from **all** sides:

- left/right seam where the gate meets the walls (z=±4.8 flush joint);
- over the top; under the bottom; from the front sides.

Expect: **no path into Bay B from any direction** and no unintentional bypass.
A seam bypass at the gate/wall flush joint is a PROVEN containment defect — stop and record it
(bounded repair: widen the gate to overlap the walls), then re-run the complete checklist.

## Gate 12 — presence_f1 behavior

1. Enter Bay A. Expect one generic presence (`presence_f1`), posture SIT / activity SHELTERING at
   (−4.5, 0, 3.5).
2. **No depenetration:** the presence must spawn in clear floor space and NOT be physics-shoved /
   depenetrated by overlapping props (this is why PresenceF1 was moved off Machinery01 at `396dabd`).
3. **No manufactured hostility:** no identity reveal, no SECOND references, no hostility/faction/
   dialogue options, no supernatural/sensor behavior. Corley's awareness FSM may react to player
   proximity/sound as existing evidence-driven behavior — observe and record what actually happens.

## Gate 13 — Narrative once-gates

1. Beat 1 `inner_strand_awakening` and beat 2 `inner_photograph` fire at boot, each exactly once.
2. Beat 3 `inner_cannery_unsealed` fires on first door opening; observable `reality_gyle_cannery` fires
   with it.
3. Re-approach, re-enter, re-interact, traverse away/back — expect NO repeat of any beat.
   `narrative_seen` wins (the `396dabd` instrumentation routes `beat_cannery_unsealed` through the
   once path).

## Gate 14 — Save

At a canonical state (door open, light toggled to a known state, beats fired, player moved):
perform a Save (slot as used by the device run).

## Gate 15 — Exit / full reload

**Fully terminate the application** (not a return-to-menu). Relaunch the project.

## Gate 16 — Persistence restoration

Load the saved slot. Verify **independently** (through the UI/state surfaces, not the save file alone):

- door open state (`world.objects["f1_gyle_cannery_door"]["open"] == true`, collision off);
- InteriorLight on/off state matches what was saved;
- FACILITY_STATE (ENTRY_OPEN if the door was unsealed before save);
- narrative seen-set — NO replayed beats on load;
- equipment (all items + equipped slot);
- POI + field entries.

Expect every item restored and internally consistent after relaunch + load.

## Gate 17 — Firearm-absence confirmation (runtime)

Confirm through the running game: the sidearm inspect surface exposes INSPECT only; no input path
produces a shot/fire/payload. (`func fire` / `func shoot` scan = self-check row 15; runtime confirms
no such path is reachable via inputs or interactions.)

---

## Failure capture requirements

For ANY failed gate, capture and record:

- exact symptom text (console output, error message, scene/node name, row number);
- evidence (timestamped log, screenshot, or file-hash of the failing save/asset);
- the reopen-able reproduction step (what action produced it);
- root-cause attribution (only after investigation — never assumed);
- the bounded repair applied (root cause only, no scope broadening);
- the verification that the repair closes the failure.

## Final result classification

Return the D032 S-2 report with the sections:

- **A Baseline:** start/end commit SHAs, branch, local vs origin sync state.
- **B Foundation self-check:** 15 rows, PASS/FAIL; warnings classified (pre-existing / harmless / D032-introduced).
- **C Runtime walkthrough:** gates 3–11 outcomes.
- **D Narrative beats:** once-gating evidence.
- **E Equipment proof:** kit truth + firearm-absence evidence.
- **F Persistence:** pre-save vs post-relaunch state comparison.
- **G Defects:** symptom / root cause / owner / repair / verification.
- **H Tests:** static verification (37 OK / 0 FAIL), methodology (PASS), `git diff --check` (clean).
- **I Final classification:** exactly one of `RUNTIME ACCEPTED` **or** `RUNTIME REJECTED — <reason>`
  (never "mostly passed").