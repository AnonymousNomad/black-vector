# BLACK VECTOR — SESSION RECOVERY HANDOFF

**Recovery date:** 2026-10-17

This is the BLACK VECTOR game project.

Do **not** confuse this project with:

- Covert Coder / Covert platform
- NOMADIC CREED Strategy
- AnythingLLM / ToolNeuron
- other game experiments

The purpose of this handoff is to recover the current BLACK VECTOR production state without restarting work, rolling back accepted systems, or rebuilding already verified material.

---

# 1. FIRST ACTION — ESTABLISH LIVE REPOSITORY TRUTH

Before modifying anything:

1. Locate the actual BLACK VECTOR repository on the authorized workstation.
2. Run:
   - `git status --short --branch`
   - `git rev-parse HEAD`
   - `git branch --show-current`
   - inspect configured remotes
3. Determine whether the tree is clean or contains intentional WIP.
4. Locate `docs/production/`.
5. Confirm whether commit `1292c67` exists in the current lineage.
6. Preserve anything newer than this handoff.
7. Do **not** blind reset, clean, checkout, rebase, merge, or stage the whole tree.

Repository truth outranks stale session memory.

If repository evidence contradicts this handoff because newer verified work exists, preserve the newer work and update the handoff rather than rolling production backward.

---

# 2. ENGINE / PLATFORM

BLACK VECTOR is currently a **Godot** project.

Important production constraints established in the existing build program include:

- Android target
- `arm64-v8a`
- GL Compatibility renderer
- stable application signing
- application package:

`com.blackvector.development`

Historical Android current-build location:

`/sdcard/Download/BLACK_VECTOR_CURRENT.apk`

Historical archive location:

`/sdcard/Download/BLACK_VECTOR_BUILDS/`

Naming pattern:

`BLACK_VECTOR_TACTICAL_PRESSURE_<SHORTSHA>.apk`

Do not assume an APK currently on the tablet is the newest build without comparing hashes/commit provenance.

---

# 3. PRODUCT DIRECTION

BLACK VECTOR is intended to become a grounded tactical-survival experience rather than a collection of disconnected systems.

Established gameplay loop:

**SURVIVE  
→ EXPLORE  
→ OBSERVE  
→ LEARN  
→ CHOOSE APPROACH  
→ ACT  
→ WORLD RESPONDS  
→ LIVE WITH CONSEQUENCES**

The game should reward observation, environmental understanding, preparation, deception, tactical choices and accepting consequences.

The game should not become a superhero power fantasy.

Movement, combat, stealth and human behavior are intended to remain grounded.

---

# 4. CORLEY — PLAYER CHARACTER DIRECTION

The primitive/procedural Corley representation was explicitly being retired in favor of a real production character pipeline.

Established Corley direction:

- adult woman
- dark hair
- athletic / credible human build
- practical presentation
- dark practical aesthetic
- tattoos/piercings may be incorporated where technically appropriate
- human, not superhero

Opening-state direction:

- minimal/tank-style upper garment
- medical/prison-type lower clothing
- poor initial footwear/equipment
- wet/cold/weathered
- later clothing recovery/change through the cabin progression

Long-term character foundation is expected to support:

- skeleton
- skinning
- idle
- walk
- run
- crouch idle
- crouch movement
- turning
- interaction
- hurt/recoil
- basic evade
- basic combat stance
- equipment attachment points
- future clothing layers
- future hair state
- injury presentation

Gameplay/physics state remains authoritative over animation.

---

# 5. CURRENT PHASE-02 CHARACTER/PRESENTATION CHECKPOINT

The latest supplied repair candidate is:

`1292c67`

This commit completed a measured lighting repair loop after the character was being badly washed out.

Do not treat earlier screenshots as representative of the repaired state.

## Measured lighting diagnosis

Original:

- character mean: `0.854`
- clipped: `79.5%`

After assumed legacy-sun + ambient cuts:

- character mean: `0.855`
- clipped: `79.6%`

This essentially changed nothing and proved the presumed cause was incomplete.

With managed lights/ambient zeroed:

- character mean: `0.522`
- clipped: `0%`

After ambient source was fully disabled:

- character mean: `0.113`
- clipped: `0%`

Final controlled-light state:

- character mean: `0.646`
- clipped: `1.89%`

This repair was based on pixel attribution rather than subjective screenshot judgment.

---

# 6. LIGHTING ROOT CAUSES FOUND

Three separate defects were identified and repaired.

## Root cause 1 — Ambient source

`AMBIENT_SOURCE_BG` under GL Compatibility was not behaving as expected relative to `ambient_light_energy`.

The bright sky/background contribution flooded the character.

Repair:

- use explicit COLOR ambient
- controlled ambient energy approximately `0.30`

## Root cause 2 — Legacy sun property parse

The old pre-NatureCell sun was expected to have:

`light_energy = 0.0`

but was still contributing.

Cause:

A `#` comment had been inserted illegally inside the relevant `.tscn` section and broke property parsing.

Repair:

- illegal comment removed
- boot state verified as actual `0.00` energy

## Root cause 3 — Interior/unmanaged light leakage

The Cannery interior omni was still emitting despite:

`visible=false`

Visibility did not disable light emission.

Repair:

- the "off" state now explicitly zeros light energy
- unmanaged `DeepBayLight` was also zeroed

Do not reopen lighting diagnosis merely because an image looks different unless current evidence contradicts these findings.

---

# 7. MATERIAL ISOLATION / HERO REVIEW

A neutral character-review fixture was added to separate:

**material correctness**

from:

**environmental lighting**

Evidence files under:

`docs/production/phase02/`

Known review captures:

- `hero_review_00_front.png`
- `hero_review_01_threequarter.png`
- `hero_review_02_side.png`
- `hero_review_03_rear.png`

Character framing:

approximately `66–73%` of frame height.

Measured clipping:

`0.00%`

This means the earlier widespread washout was not adequately explained by the material stack itself.

Do not blame character materials again without contradictory controlled evidence.

---

# 8. PHASE-02 MOTION / PRESENTATION EVIDENCE

Current evidence includes approximately 17 phase/motion captures under:

`docs/production/phase02/`

Known sequence family:

`phase02_00..16_*.png`

Coverage includes:

- crouch front
- crouch side
- crouch rear
- walk sequence
- start
- mid
- opposite phase
- recovery
- transitions
- comparable-scale views

Normal-play captures include:

- `normal_play_overview.png`
- `normal_play_closer.png`
- `normal_play_cabin.png`

Motion report:

`phase02_motion_report.json`

The motion report records deterministic crouch positioning and grounding in roughly the **1 cm class**.

---

# 9. CURRENT VERIFICATION BATTERY AT 1292c67

At the supplied repair checkpoint:

- static: `37/0`
- foundation: `15/15`
- crouch verification: PASS on both presentations
- hero load gate: PASS
- deterministic 17-shot motion capture: PASS
- normal-play evidence: `3/3`
- grounding: approximately 1 cm class
- pipeline preserved
- no rollback

Do not weaken these gates.

If current live repository results differ, rerun and record the discrepancy.

---

# 10. CURRENT WARDROBE STATUS

Current character wardrobe:

`female_casualsuit01`

Status:

**NONCANONICAL PLACEHOLDER**

This was intentionally documented as temporary.

Do not treat it as Corley's final visual design.

However, do not casually replace it during lighting/motion acceptance because that would introduce another visual variable.

Finish the relevant acceptance gate first unless newer production work has already superseded it.

---

# 11. CURRENT ACCEPTANCE QUESTION

`1292c67` should be treated as the repaired Phase-02 candidate, not as another exploratory lighting pass.

The critic/acceptance review was supposed to answer:

### A. Normal-play readability

Does Corley remain readable under actual gameplay compositions rather than only the neutral fixture?

### B. Motion readability

Do crouch, walk and transitions retain:

- silhouette clarity
- grounding
- coherent motion
- comparable presentation across angles?

### C. Highlight behavior

Is the remaining `1.89%` clipping limited to legitimate localized highlights rather than broad surface saturation?

### D. Regression

Did the repair introduce any:

- loading regression
- motion regression
- grounding regression
- pipeline regression
- scene/presentation regression?

Expected critic verdict:

`PHASE-02 REPAIR ACCEPTED`

or

`PHASE-02 REPAIR REJECTED`

A rejection must identify:

- exact evidence file
- exact visible defect
- defect category
- why existing controlled evidence fails to resolve it

Do not accept vague "needs polish" rejection language.

---

# 12. HUMAN AI / STEALTH ARCHITECTURE DIRECTION

Existing production direction called for moving humans beyond stationary/bounded watcher behavior.

Human actors should eventually support:

- routine
- idle
- travel
- inspect
- interaction/conversation hooks
- perception
- suspicion
- investigation
- search
- alert
- coordination
- plausible return to routine

NPCs should exist for reasons independent of Corley.

Do not simply spawn every actor because the player crossed a trigger.

## Human knowledge must remain separated

Distinguish:

- what actually happened
- what the NPC perceived
- what the NPC believes happened
- confidence
- suspected actor
- whether Corley's identity is actually known

No omniscient NPC truth.

---

# 13. PERCEPTION / STEALTH DIRECTION

Perception was intended to use actual world conditions such as:

- line of sight
- distance
- movement
- stance
- lighting
- terrain
- occlusion
- vegetation
- sound
- surface
- weather
- water/noise masking
- recent evidence

Example bounded awareness progression:

**unaware  
→ noticed anomaly  
→ suspicious  
→ investigating  
→ possible person  
→ confirmed person  
→ alert**

Identity confidence remains separate from detection.

Do not replace this with a magic universal visibility number.

---

# 14. COMBAT / PHYSIOLOGY DIRECTION

The v0.2 program called for grounded first-pass combat.

Combat should:

- exist
- be avoidable where appropriate
- interact with injury/physiology
- not collapse all human condition into a universal arcade HP abstraction
- affect subsequent world state and decisions

The player's choice after an encounter should matter.

Do not widen this into a complete firearms/combat simulator unless explicitly authorized.

---

# 15. WORLD / ALASKA GEOGRAPHY LOCK

The world uses **real Alaska geography as structural inspiration**, but the primary playable world remains the dense main island.

Do **not** physically stretch the main island merely to connect every future location.

Broader operational geography currently includes:

### Fairbanks

Initial farthest inland operational boundary.

### Nome

Major western:

- logistics node
- aviation node
- shipping node

### Koyuk region

Remote:

- relay
- recovery
- supply

area.

### Wainwright region

Extreme Arctic environment suitable for:

- research
- communications
- remote operations
- black-site type activity

These are part of the larger operational network.

They do not mean the whole of Alaska should become one continuous open-world landmass.

The primary island remains the dense main playable world.

---

# 16. CONCEPT / REFERENCE ASSETS KNOWN TO EXIST

User Library contains BLACK VECTOR visual reference material including:

- `Black Vector: Northern Survivor.png`
- `Black Vector: The Shade Concept Sheet.png`
- `Black Vector: The Hand.png`

Treat these as design/reference material unless repository documentation explicitly promotes them to production assets.

Do not assume image-generation provenance equals legal/production asset provenance.

---

# 17. SHADE STATUS

A detailed Shade concept exists.

However, older production law explicitly deferred the full Shade production arc.

Therefore:

**concept exists ≠ current gameplay authorization**

Do not begin implementing the full Shade system merely because visual references exist.

Check newer canon/production directives before changing this restriction.

---

# 18. HISTORICAL AUTONOMOUS-PRODUCTION LINEAGE

An older BLACK VECTOR production directive recorded:

Branch:

`production/autonomous-v1`

Historical starting candidate:

`5a1c391ed13ae0a6d496e6a7b639cbd822c5a600`

Milestone at that time:

`FIRST PLAYABLE CHAPTER v0.1`

Target milestone:

`TACTICAL SURVIVAL PLAYABLE v0.2`

This information is historical.

Do **not** reset current Git state to this SHA.

Use it only to understand project lineage.

---

# 19. HISTORICAL V0.2 PRODUCTION TARGET

The larger v0.2 program aimed to:

1. retire the primitive Corley proxy;
2. establish a production character pipeline;
3. deepen human AI;
4. build real stealth;
5. establish grounded combat;
6. connect combat to physiology;
7. build evidence discovery;
8. model imperfect human information;
9. expand institutional/regional pressure;
10. create a substantial multi-solution tactical objective;
11. expand geography only where gameplay requires it;
12. preserve wilderness-life freedom;
13. produce an installable Android build.

Do not assume all of these were completed merely because they were in the production program.

Distinguish:

**DESIGNED / DIRECTED**

from:

**IMPLEMENTED**

from:

**VERIFIED**

---

# 20. PREVIOUSLY DEFERRED FEATURES

Historical production law explicitly said not to prematurely implement:

- telekinesis
- Brain Agony
- underground-complex discovery
- Katie active support
- full Shade production arc
- Shadow runtime
- Falcon runtime
- Wildfire runtime
- full Hidden Hand reconstruction
- full firearms system
- island-wide institutional war
- settlement simulation
- whole-island expansion
- feral swine unless independently accepted

Before implementing any of these, check for a later explicit authorization.

---

# 21. OPERATING METHOD

Use the project's established verify-first production discipline.

For bounded failures:

**observe  
→ reproduce  
→ isolate  
→ root cause  
→ repair  
→ rerun  
→ verify  
→ continue**

Do not return after every small repair.

Do not make the operator manually debug Godot when tools can establish machine/runtime truth.

Use:

- repository inspection for source truth
- runtime capture for visual/runtime claims
- deterministic tests where possible
- current Godot documentation when APIs are uncertain
- exact commit SHAs for acceptance boundaries

Do not describe something as VERIFIED merely because source code looks correct.

---

# 22. NEXT SESSION — REQUIRED STARTING SEQUENCE

The resumed session should:

1. identify the live BLACK VECTOR repository;
2. establish branch / HEAD / dirty state;
3. locate `1292c67`;
4. inspect `docs/production/phase02/`;
5. inspect the current acceptance/critic receipt if one exists after `1292c67`;
6. determine whether Phase-02 repair was subsequently accepted or superseded;
7. rerun only the verification necessary to establish current truth;
8. preserve newer work;
9. continue from the latest accepted/candidate boundary.

Do not restart the game.

Do not rebuild the character pipeline from scratch.

Do not redo the lighting diagnosis unless current evidence contradicts it.

Do not confuse placeholder wardrobe with final Corley art.

Do not begin unrelated future systems merely because they exist in the design bible.

---

# 23. RECOVERY VERDICT

Latest known supplied production candidate:

`1292c67`

Known state at that candidate:

**LIGHTING ROOT CAUSE — CORRECTED**

**MATERIAL VISIBILITY — CONTROLLED FIXTURE PROVEN**

**MOTION/PRESENTATION TEST BATTERY — GREEN**

**PIPELINE REGRESSION — NONE REPORTED**

**PHASE-02 FINAL VISUAL ACCEPTANCE — LAST KNOWN PENDING CRITIC VERDICT**

That is the correct point from which repository truth should now be recovered.