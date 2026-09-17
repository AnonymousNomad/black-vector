# SOP-004 — MOBILE PERFORMANCE PROCEDURE

## Purpose
Keep BLACK VECTOR playable and battery-sane on the tablet. Performance work is driven by measurement against explicit budgets, never by guesswork and never deferred as an afterthought.

## When Mandatory
- At the start of any feature that touches rendering, simulation, physics, AI, or assets.
- As part of every performance-related verification claim.

## Workflow
1. MEASURE FIRST: profile the current state (frame time, draw calls, vertex/fragment cost, physics steps, script time) on the target device class before any optimization. A target that is not profiled is a guess.
2. SET BUDGETS: assign explicit budgets per area, front to back: simulation + physics + AI + draw + memory/assets. Total must leave headroom under frame budget (e.g., target total far below the frame cap; the remainder is battery and thermal margin).
3. ARCHITECT FOR THE BUDGET: design the system so its cost is bounded by design (see skills: bounded perception, sectorized world, bounded physics) — not tuned in later.
4. OPTIMIZE ONLY WHERE MEASURED: profile → identify the real hotspot → apply the smallest justified optimization → re-profile. Premature optimization is discouraged; optimizing an unprofiled suspect is prohibited.
5. RENDERER-CONSCIOUS: respect the selected rendering path's contracts — GL Compatibility has no compute shaders, no normal/roughness buffer, no VRS/decals/DOF, and depth pre-pass is enabled by default (unlike the Mobile renderer). Transparent objects cost more (sort order, fill rate) — keep them few. Forward+ is FORBIDDEN on Android.
6. APPROPRIATE ASSETS: mesh LOD / visibility ranges, baked lighting and lightmaps for static scenery, instancing (MultiMesh) where the renderer lacks automatic instancing, keep dynamic lights scarce, DirectionalLight3D dynamic but omni/spot static.
7. DEVICE VALIDATE: all performance claims are DEVICE claims. A desktop run is not a tablet run.

## Budgets (initial reference, revise by measurement)
- Frame: every slice fits with headroom beneath the device frame budget.
- AI perception: bounded — update fans out over time; no global per-frame heavy scans (see `tactical-ai-perception`).
- Draw calls: prefer batching/instancing; track per-area during dev.
- Memory: profile project size and allocs; keep asset weights managed from the start.

## Invariants
- Every optimization claim carries a before/after measurement.
- No "we'll optimize later" dismissal of a known cost; pending optimization is tracked as debt, never silence.

## Stop Conditions
If the current feature cannot meet budgets without compromising intent, stop and redesign scope (smaller systemic scope is doctrine), do not degrade quality silently.