# BLACK VECTOR — CLOUD COMPLETION HANDOFF

Status: CLOUD HANDOFF PACKAGE — SOURCE RECONCILIATION REQUIRED BEFORE COMPLETION CLAIMS

Repository: AnonymousNomad/black-vector
Cloud branch: cloud-handoff-black-vector
Branch base: ebdeb7abf10cdeb67b1365e12f98319d8a71ab65
Base lineage: work/visual-wilderness-proof-1
Engine: Godot
Android package: com.blackvector.development
Renderer target: GL Compatibility
Android ABI target: arm64-v8a

## Read this first

This branch exists so a Cloud worker can continue BLACK VECTOR as a production game rather than restart it.

Required reading order:

1. `cloud/START_HERE.md`
2. `cloud/KNOWN_LOCAL_DELTA.md`
3. `cloud/COVERT_HARNESS_CONTRACT.md`
4. `cloud/AUTONOMOUS_EXECUTION.md`
5. `cloud/VISUAL_QUALITY_BAR.md`
6. `cloud/FINAL_ACCEPTANCE.md`
7. `cloud/reference-stack.json`
8. `cloud/harness/mission_queue.json`
9. existing `doctrine/`, `sop/`, `skills/`, `.opencode/`, `docs/`, `tests/`, `tools/`

## Critical source truth

GitHub does NOT currently contain the latest known laptop-local production candidate.

Latest known local candidate from the recovered production record:

`1292c67`

GitHub cannot resolve that commit. The newest GitHub visual branch available at handoff is:

`ebdeb7abf10cdeb67b1365e12f98319d8a71ab65`

Therefore this branch is NOT evidence that the October local game source was uploaded byte-for-byte.

Do not claim otherwise.

`cloud/KNOWN_LOCAL_DELTA.md` describes the verified facts known about the missing local line. If the exact local commit later appears in GitHub, prefer exact source reconciliation over reconstruction.

## Product identity

BLACK VECTOR is a grounded tactical-survival game.

Canonical gameplay loop:

SURVIVE
→ EXPLORE
→ OBSERVE
→ LEARN
→ CHOOSE APPROACH
→ ACT
→ WORLD RESPONDS
→ LIVE WITH CONSEQUENCES

The player character Corley is human, vulnerable, practical and grounded. The game rewards observation, environmental understanding, preparation, deception, tactical choices and consequences. It must not become a superhero power fantasy.

## Cloud mission

Produce the strongest truthful, playable, polished BLACK VECTOR milestone that the approved design and current engine support.

Do not optimize for:
- commit count;
- number of systems;
- speculative future lore;
- hidden infrastructure;
- screenshots that only look good in isolated test scenes.

Optimize for:
- real gameplay depth;
- visual quality in normal play;
- believable human AI;
- grounded stealth and combat;
- persistence and consequence;
- coherent content;
- reliable Android runtime;
- the amount of real BLACK VECTOR the operator can experience in one session.

## Authority

Cloud may execute the bounded production queue autonomously.

Cloud may:
- inspect;
- implement;
- repair;
- verify;
- commit;
- push to this cloud branch;
- create evidence and build artifacts.

Cloud must NOT:
- rewrite canon because implementation is inconvenient;
- silently discard accepted systems;
- merge to main;
- publish externally;
- use questionable-license assets;
- claim physical Android acceptance without a real device;
- claim the missing local `1292c67` source was present when it was not.

Unknown conditions remain UNKNOWN until proven.
