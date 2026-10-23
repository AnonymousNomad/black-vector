# BLACK VECTOR — PROJECT-LOCAL COVERT HARNESS CONTRACT

The full Covert desktop stack is not embedded into this game repository. This contract imports the working discipline needed for autonomous cloud production.

The Black Vector repo already contains project-native:
- `doctrine/`;
- `sop/`;
- `skills/`;
- `.opencode/`;
- `tests/`;
- `tools/`;
- design, lore, research and verification docs.

Those remain authoritative for project-specific behavior.

## Pipeline

MISSION ENVELOPE
→ bounded context
→ relevant skill/SOP selection
→ builder
→ deterministic tools/tests
→ Veritas-style verification
→ Ghost-style adversarial review for risky/integration work
→ repair loop
→ checkpoint
→ mission receipt
→ next mission

## The Developer's Way

For bounded failures:

OBSERVE
→ REPRODUCE
→ ISOLATE
→ ROOT CAUSE
→ REPAIR
→ RERUN
→ VERIFY
→ CONTINUE

Do not hide failures.
Do not substitute intent for observation.
Do not claim VERIFIED because source code looks plausible.

## Mission envelope

Every substantial slice records:
- mission id;
- objective;
- allowed scope;
- denied scope;
- starting SHA;
- relevant design/canon contracts;
- required tests;
- stop conditions;
- expected player-visible outcome.

## Verification tiers

### FAST — continuously
- `git diff --check`;
- Godot parse/project-load gate where available;
- changed-script/static checks;
- focused self-checks;
- changed-file secret/credential scan;
- scene/resource path validation;
- contract/invariant checks;
- deterministic fixture checks.

### SLICE — at gameplay/visual feature closure
- all relevant existing tests;
- focused runtime scenario;
- save/load or restart check for stateful work;
- input path check when touched;
- normal-play visual capture when presentation changes;
- performance sanity for changed region/system;
- failure/recovery path;
- fresh-context Veritas/Ghost review;
- no known P0/P1 in the changed player journey.

### RELEASE — integrated candidate only
- broad regression;
- full continuous tactical chapter;
- save/load/restart continuity;
- Android export;
- package/version/ABI identity;
- APK SHA-256;
- signing identity if configured;
- physical device acceptance only when actual hardware exists;
- crash/runtime-log review;
- performance and thermal evidence;
- visual acceptance in normal play;
- release receipt.

Do not spend RELEASE ceremony on every small slice.

## Builder vs verifier

A builder may not self-accept risky/integration work solely because it compiles or looks correct.

Fresh review must actively search for:
- stale state;
- one-shot effects replaying after load;
- silent fallback;
- scene/resource breakage;
- false success;
- impossible NPC knowledge;
- accidental omniscience;
- save schema corruption;
- visual test-scene-only success;
- touch/input regressions;
- performance cliffs;
- asset-license uncertainty;
- broken consequence propagation.

Return PASS or concrete defects. Repair and rerun.

## Evidence

Player-visible claims require player-visible evidence.

Visual claims:
- normal gameplay captures;
- controlled comparison when useful;
- quantitative checks where practical;
- no isolated hero shot accepted as proof of whole-game quality.

Gameplay claims:
- reproduce;
- record state transition;
- prove consequence;
- prove persistence if stateful.

AI claims:
- prove perception inputs;
- prove knowledge bounds;
- prove behavior transition;
- prove no omniscient shortcut.

## Recovery

After each accepted slice:
- commit;
- push to cloud branch;
- append `cloud/WORK_LOG.md`;
- record start/end SHA;
- record tests/evidence;
- record unresolved items;
- leave the next mission recoverable from GitHub alone.

## Authority

The Cloud worker has broad bounded production authority inside this branch.

It does not have authority to:
- merge to main;
- publish externally;
- invent credentials;
- weaken evidence gates;
- redefine canon silently;
- import ambiguous-license assets;
- claim physical-device results that were not run.

Capability availability is not proof of authorization.
Unknown conditions fail truthfully.
