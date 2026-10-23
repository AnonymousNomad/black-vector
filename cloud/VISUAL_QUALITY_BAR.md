# BLACK VECTOR — VISUAL / PRESENTATION QUALITY BAR

The operator explicitly wants BLACK VECTOR to be high-quality, high-fidelity and visually substantial.

This does NOT mean blindly maximizing polygon count or effects.

The target is:

**cinematic, grounded, atmospheric tactical survival that still runs as a real game on the supported Android path.**

## Art-direction law

BLACK VECTOR should feel:
- cold;
- wet;
- remote;
- dangerous;
- believable;
- sparse where nature is sparse;
- dense where structures or vegetation justify density;
- tactile;
- weathered;
- human-scale;
- cinematic without becoming a cutscene-only experience.

Avoid:
- toy-like primitives in final presentation;
- flat uniform materials;
- broad overexposure;
- fluorescent game lighting;
- generic asset-store collage;
- exaggerated superhero silhouettes;
- excessive bloom;
- neon sci-fi language outside specific canon;
- detail that exists only for screenshots.

## Corley

Corley must become a believable production character.

Target:
- adult woman;
- dark hair;
- athletic/credible build;
- practical and weathered;
- grounded proportions;
- clothing consistent with current story state;
- visible equipment progression;
- readable injuries/state where implemented.

Opening presentation must not begin in final tactical gear.

The known `female_casualsuit01` local wardrobe was a NONCANONICAL PLACEHOLDER.

Character lighting must preserve facial/body/material readability in normal play.

Known accepted repair target from missing local delta:
- final character mean ~0.646;
- broad clipping reduced to ~1.89%;
- neutral hero fixture clipping 0.00%.

These are reference measurements, not immutable artistic constants.

## Environment

Production environment should use:
- varied terrain silhouettes;
- believable Alaska vegetation;
- coherent shoreline/water;
- rocks/deadfall/debris;
- surface breakup;
- wetness/snow/weather response where canonical;
- believable building materials;
- weathering;
- interior/exterior light logic;
- fog/haze for depth;
- distance composition;
- landmark readability;
- selective decals and small-scale storytelling.

Procedural generation may assist construction but must not leave the world looking procedurally generic.

## Lighting

Lighting must be measured and reviewed in normal gameplay.

Preserve lessons from the local Phase-02 repair:
- GL Compatibility ambient behavior must be verified, not assumed;
- `visible=false` does not prove a light emits no energy;
- scene-file syntax errors can silently invalidate expected properties;
- unmanaged lights must be accounted for;
- material diagnosis must be isolated from environmental lighting.

Use:
- intentional key/fill/environment balance;
- readable interiors;
- believable night/darkness;
- localized highlights;
- controlled contrast;
- practical sources.

Do not accept broad surface clipping.

## Materials

Production materials should communicate:
- wet fabric;
- worn metal;
- wood;
- concrete;
- soil;
- rock;
- vegetation;
- water;
- damaged industrial surfaces;
- practical clothing/equipment.

Use PBR-style material response within Godot/GL Compatibility constraints.

Avoid identical roughness/specular treatment across unrelated surfaces.

## Animation

Minimum production-readability standard:
- idle;
- walk;
- run;
- crouch;
- turning;
- interactions;
- recoil/hurt;
- evade where implemented;
- combat stance;
- transitions.

No obvious foot skating, hovering or large ground penetration.

Known local Phase-02 grounding target was roughly 1 cm class.

Animation quality is judged in continuous normal play, not only pose captures.

## Camera

Third-person camera should:
- preserve environmental awareness;
- support stealth;
- avoid clipping;
- avoid nausea;
- adapt to tight interiors;
- preserve character readability;
- support touch controls;
- avoid gratuitous cinematic obstruction.

## UI

UI should be:
- restrained;
- legible;
- mobile-aware;
- consistent with grounded tactical survival;
- useful without dominating the image.

No debug labels in player-facing release surfaces.

## Audio

Visual quality is incomplete without matching sound.

Prioritize:
- wind;
- forest;
- water;
- surface footsteps;
- interiors;
- machinery;
- weather;
- distant human/industrial cues;
- positional awareness;
- restrained music.

## Performance / quality scaling

High visual quality must be architected, not faked.

Use as appropriate:
- LOD;
- culling;
- visibility ranges;
- sensible texture budgets;
- batching/instancing;
- constrained dynamic lights;
- shadow-distance management;
- scalable effects;
- quality presets.

Cloud should preserve a high-quality reference configuration while maintaining a practical Android configuration.

Do not degrade the entire game to the weakest path when selective scaling can preserve identity.

## Acceptance evidence

For every major visual milestone capture normal play across:
- character close/medium/far;
- exterior day/low-light where implemented;
- vegetation-heavy view;
- water/shore;
- major structure;
- interior;
- stealth composition;
- combat/pressure composition;
- weather condition where implemented.

Review:
- exposure;
- clipping;
- silhouette;
- material response;
- depth;
- aliasing;
- obvious LOD pop;
- shadow failure;
- texture repetition;
- camera clipping;
- animation grounding;
- UI obstruction.

A beautiful isolated hero fixture does not prove the game looks good.

## Reference concepts known outside the current GitHub source

Recovered project context names these visual references:
- `Black Vector: Northern Survivor.png`;
- `Black Vector: The Shade Concept Sheet.png`;
- `Black Vector: The Hand.png`.

The binary files were not in the Black Vector GitHub repository at this handoff.

Use repository art/canon first.

Known Shade concept language:
- dark cinematic special-operations aesthetic;
- charcoal/black materials;
- restrained blue/steel accents;
- hooded/helmeted low-signature silhouette;
- environmental blend;
- weather adaptation;
- diegetic tactical HUD concepts;
- modular equipment.

IMPORTANT:
The full Shade production arc remains deferred unless newer canon explicitly authorizes it.
The concept may inform long-range art direction; it is not permission to introduce Shade gameplay prematurely.

## Quality verdict

Do not call visual production complete while:
- Corley still reads as a proxy;
- major materials read as primitives;
- lighting is broadly clipped/washed;
- animations visibly float/slide;
- the environment feels like a tech demo;
- normal-play screenshots contradict the claimed quality;
- Android performance makes the game impractical.

Final visual status must be evidence-backed.
