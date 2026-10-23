# BLACK VECTOR — KNOWN LOCAL DELTA

## Status

LOCAL SOURCE DELTA NOT PRESENT IN GITHUB AT HANDOFF.

Latest known supplied local production candidate:

`1292c67`

GitHub lookup for that commit failed. This document records evidence from the recovered 2026-10-17 production handoff so Cloud can reconcile intentionally instead of rolling the game backward.

Do not call reconstruction byte-identical to the missing local source.

## Known Phase-02 state at 1292c67

The local line had moved beyond the September procedural visual proof into a production-character/presentation repair phase.

Known facts:

- primitive/procedural Corley was being retired toward a real production character pipeline;
- Corley target: adult woman, dark hair, athletic/credible build, practical dark aesthetic, human rather than superhero;
- opening state remains minimal/tank-style upper garment, medical/prison lower clothing, poor initial footwear/equipment, wet/cold/weathered;
- long-term character foundation expected skeleton, skinning, idle, walk, run, crouch idle/move, turning, interaction, hurt/recoil, evade, combat stance, equipment attachments, clothing layers, hair state and injury presentation;
- gameplay/physics state remains authoritative over animation.

## Lighting repair evidence

Original character:
- mean 0.854
- clipped 79.5%

After incomplete assumed sun/ambient cuts:
- mean 0.855
- clipped 79.6%

All managed lights/ambient zeroed:
- mean 0.522
- clipped 0%

Ambient source fully disabled:
- mean 0.113
- clipped 0%

Final controlled-light state:
- mean 0.646
- clipped 1.89%

Three root causes were identified:

1. `AMBIENT_SOURCE_BG` under GL Compatibility flooded the character.
   - local repair used explicit COLOR ambient;
   - controlled ambient energy approximately 0.30.

2. Legacy sun property parsing was broken by an illegal `#` comment inside a `.tscn` section.
   - comment removed;
   - boot state verified at actual 0.00 light energy.

3. Interior/unmanaged light leakage.
   - Cannery omni still emitted despite `visible=false`;
   - off state explicitly zeroed light energy;
   - unmanaged `DeepBayLight` was zeroed.

Do not reopen these causes without contradictory evidence.

## Material / hero review evidence

A neutral character-review fixture separated material correctness from environmental lighting.

Known evidence names:
- `hero_review_00_front.png`
- `hero_review_01_threequarter.png`
- `hero_review_02_side.png`
- `hero_review_03_rear.png`

Known measurements:
- character framing approximately 66–73% of frame height;
- measured clipping 0.00%.

## Motion / presentation evidence

Known Phase-02 evidence:
- approximately 17 deterministic motion captures;
- family `phase02_00..16_*.png`;
- crouch front/side/rear;
- walk sequence;
- start/mid/opposite/recovery phases;
- transitions;
- comparable-scale views;
- normal play overview/closer/cabin captures;
- motion report `phase02_motion_report.json`;
- grounding in roughly the 1 cm class.

Known verification at 1292c67:
- static 37/0;
- foundation 15/15;
- crouch verification PASS on both presentations;
- hero load gate PASS;
- deterministic 17-shot motion capture PASS;
- normal-play evidence 3/3;
- grounding approximately 1 cm class;
- pipeline preserved;
- no rollback.

Do not weaken these gates.

## Wardrobe

Known local wardrobe at that checkpoint:

`female_casualsuit01`

Status:

NONCANONICAL PLACEHOLDER.

It was not the final Corley visual design.

## Pending acceptance

The final Phase-02 critic verdict was still known as pending.

Acceptance questions:

- normal-play readability;
- motion silhouette/grounding/coherence;
- whether remaining 1.89% clipping was legitimate localized highlight;
- loading/motion/grounding/pipeline/scene regression.

Valid verdict must be evidence based:

`PHASE-02 REPAIR ACCEPTED`

or

`PHASE-02 REPAIR REJECTED`

A rejection must identify exact evidence and defect.

## Reconciliation rule

Cloud Phase 0 must:

1. inspect the GitHub source it actually has;
2. determine which local-delta behaviors are absent;
3. reimplement only absent behavior where exact source is unavailable;
4. preserve newer GitHub evidence if repository truth is ahead in any area;
5. recreate verification evidence;
6. clearly label reconstructed behavior as reconstruction, not byte-identical recovery;
7. stop treating the delta as open only after the documented behaviors and gates have been independently re-established.

If exact `1292c67` or a descendant is later pushed, reconcile against it and prefer exact source truth.
