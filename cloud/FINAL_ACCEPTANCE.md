# BLACK VECTOR — FINAL CLOUD ACCEPTANCE CONTRACT

This contract defines what Cloud may call complete.

## Completion is not

- a green parser alone;
- a successful export alone;
- a long feature list;
- many commits;
- one beautiful screenshot;
- one scripted encounter;
- a systems sandbox;
- an untested APK;
- a rewritten game that ignores canon.

## Minimum product outcome

The player can enter BLACK VECTOR and experience a coherent tactical-survival session with:

1. a production-readable Corley character;
2. credible locomotion and interaction;
3. a visually cohesive Alaska wilderness/industrial setting;
4. exploration with purpose;
5. believable human routines;
6. perception-driven stealth;
7. evidence and imperfect NPC knowledge;
8. grounded, dangerous combat where appropriate;
9. injury/physiology consequence;
10. at least one substantial multi-solution tactical problem;
11. world-state consequence after the problem;
12. meaningful persistence across save/load/restart;
13. authored content beyond a systems demo;
14. coherent sound/feedback;
15. practical Android build path.

## Canonical loop acceptance

The continuous experience must demonstrate:

SURVIVE
→ EXPLORE
→ OBSERVE
→ LEARN
→ CHOOSE APPROACH
→ ACT
→ WORLD RESPONDS
→ LIVE WITH CONSEQUENCES.

If any arrow exists only in documentation, the loop is not complete.

## Character gate

Corley:
- no longer reads as a procedural proxy;
- remains human/grounded;
- opening story-state clothing is coherent;
- animation transitions are usable;
- ground contact is credible;
- normal-play lighting is readable;
- equipment/injury state is presented where implemented.

## AI gate

At least representative humans must prove:
- routine independent of player trigger;
- perception inputs;
- suspicion/investigation/search;
- bounded knowledge;
- identity confidence separate from detection;
- plausible coordination;
- return/de-escalation behavior where appropriate.

No omniscient shortcut.

## Stealth gate

Stealth outcome materially changes with:
- LOS;
- distance;
- movement/stance;
- lighting;
- cover/occlusion;
- environment/sound where implemented.

The player can learn and exploit the system without reading debug state.

## Combat gate

Combat:
- is playable;
- readable;
- dangerous;
- not mandatory in every designed problem;
- affects physiological/world state;
- persists appropriately.

## Tactical problem gate

At least one substantial objective must support multiple real solutions.

Different approaches must produce different evidence/world/knowledge/consequence state.

A choice that only changes dialogue text without material state is insufficient.

## Persistence gate

Verify:
- save;
- close;
- relaunch;
- load;
- current world state restored;
- once-only events do not replay;
- consequences persist;
- no item/state duplication from normal save/load.

## Visual gate

See `cloud/VISUAL_QUALITY_BAR.md`.

Required:
- normal-play capture set;
- no broad washout/clipping regression;
- coherent materials;
- production-readable character;
- credible environment;
- acceptable camera;
- no obvious prototype artifacts in the primary experience.

## Performance gate

Cloud:
- run available profiling/static/runtime tests;
- document build hardware;
- measure what can be measured;
- do not invent tablet FPS/thermal results.

Device acceptance, if no physical Samsung exists in Cloud:
`PHYSICAL_ANDROID_NOT_TESTED`.

## Android artifact gate

Expected product identity:
- package `com.blackvector.development`;
- arm64-v8a;
- Godot GL Compatibility;
- version/build provenance embedded or recorded;
- APK SHA-256 recorded;
- signer recorded where available.

If release signing secret is unavailable, produce a truthful debug/development candidate and classify production signing separately.

## Verification gate

Before final classification:
- FAST gates green;
- SLICE gates green for every completed production tranche;
- broad regression green;
- fresh Veritas-style review;
- fresh Ghost-style adversarial review;
- no known P0/P1 in the continuous player journey;
- tree clean;
- branch pushed;
- final receipt committed.

## Cloud-only classification

Allowed:
`BLACK_VECTOR_CLOUD_PRODUCTION_COMPLETE_PHYSICAL_PENDING`

only when all Cloud-verifiable production gates are satisfied and only physical device acceptance remains.

Allowed:
`BLACK_VECTOR_CLOUD_PRODUCTION_PARTIAL`

when material game-production gaps remain.

Do not use:
- RELEASE_READY;
- PRODUCTION_RELEASED;
- DEVICE_ACCEPTED;

without matching evidence.

## Final receipt

Create `cloud/FINAL_RECEIPT.md` containing:

A. starting source truth
B. local-delta reconciliation
C. branch / final SHA / clean state
D. character
E. animation/locomotion
F. environment/visuals
G. human AI/routines
H. perception/stealth
I. evidence/knowledge
J. heat/identity/consequence
K. combat
L. injury/physiology
M. equipment
N. tactical problem
O. consequence graph
P. authored content/world
Q. audio
R. persistence/save schema
S. performance
T. Android build
U. APK identity/hash/signing
V. tests by tier
W. internal reviews
X. known P0/P1/P2
Y. deferred canon
Z. physical-device status
AA. exact next operator action
