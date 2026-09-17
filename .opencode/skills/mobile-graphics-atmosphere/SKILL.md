---
name: mobile-graphics-atmosphere
description: Mobile graphics and atmosphere — renderer contract discipline (GL Compatibility default, Mobile gate), baked lighting, LOD/visibility, instance/batching, transparency costs, and high-fidelity presentation within tablet budgets. Load when working on rendering, lighting, materials, or atmosphere.
---

# MOBILE GRAPHICS AND ATMOSPHERE (BV-SKILL-014)

## NAME
MOBILE GRAPHICS AND ATMOSPHERE

## PURPOSE
Deliver BLACK VECTOR's high-fidelity presentation (doctrine §1) on the tablet by respecting renderer contracts and the performance procedure — spending visual quality exactly where the player perceives it (mood, lighting, environment, WEATHER), never exceeding device budgets (SOP-004), and never importing desktop assumptions. The Alaska winter wilderness is a PRIMARY atmosphere surface: snow, storms, frost, darkness, and visibility collapse are presentation AND gameplay (doctrine §5, §30) — atmosphere and legibility are engineered together, not at odds.

## WHEN TO LOAD
- Lighting, materials, shaders, atmosphere, post-processing, transparency, LOD, instancing, or draw-call work.
- Any performance-tied visual reasoning on the renderer path.

## DO NOT LOAD WHEN
- Pure gameplay-logic work with no visual concern.

## PRECONDITIONS
- Governing set loaded.
- Renderer decision current (BV-D001: GL Compatibility default; Mobile behind measured gate) and documented in project settings context.
- Sector budgets exist (BV-SKILL-013 handoff docs) where available.

## GOVERNING INVARIANTS
1. RENDERER CONTRACTS ARE LAWS: currently targeting **GL Compatibility** (OpenGL; no compute shaders, no normal/roughness buffer, no VRS/DOF/decals; depth pre-pass ON by default). If/on the Mobile renderer path (Vulkan, half-float → strong tablet perf), contracts change — depth pre-pass is NOT default there; re-validate transparency/overdraw. Forward+ is FORBIDDEN on Android (BV-D001). Contract knowledge comes from authoritative docs, and changes between renderers are re-validations, not side plans.
2. MEASURE-FIRST (SOP-004): every visual feature ships with a device measurement attached or is explicitly deferred debt. No "optimize later" negligence.
3. BUDGET-DRIVEN VISUALS: spend where perceived — atmosphere (mood lighting, readable darkness, environment shapes) gets budget; invisible bookkeeping and unperceived effects get none (doctrine §11).
4. APPROPRIATE TECHNIQUES: static/baked lighting (lightmaps) for scenery; Dynamic DirectionalLight3D with omni/spot static; visibility ranges + LOD (and billboard/impostor options) for distant geometry; MultiMesh/instancing where the renderer lacks automatic instancing (compat: manual; forward+: automatic).
5. TRANSPARENCY DISCIPLINE: transparent objects are back-to-front sorted and cost fill rate — few, purposeful, never everywhere; keep the overdraw story measured on device.
6. ATMOSPHERE IS SIGNATURE-ADJACENT: darkness/blind spots are stealth-relevant (illumination channel, BV-SKILL-007) — visual quality must not accidentally break fair stealth (shadows must be legible, light pools readable). Weather that collapses visibility must ALSO collapse targeting/navigation legibility symmetrically (doctrine §6) — a blizzard is not free invisibility with perfect optics.
7. WEATHER IS A BUDGETED SYSTEM: snow particle/visibility uniforms are legitimate atmosphere spend, but they are measured like any FX (SOP-004) — storm states are cheap global conditions (uniforms, fog, wind), not per-flake heavy systems, and never environments that tax the tablet needlessly.
8. THE WINTER LOOK IS LEGIBILITY-CRITICAL: snow/white-out and night must still read as designed spaces (escape routes, cover, landmarks visible in the right states) — presentation serves survival and navigation decisions (doctrine §30).

## WORKFLOW
1. Read current visual setup as-built (scene + resources + project settings as current form).
2. Budget-declare: for the visual task, state budget (draw, memory, fill) and where the spend is perceived.
3. Choose technique set from contract (compat-legal: lightmap, LOD, instancing, no compute).
4. Implement smallest change; measure on device (SOP-004/BV device rule); re-tune or cut by evidence.
5. Static verify + device evidence recorded in report.

## IMPLEMENTATION GUIDANCE
- Baked lighting: use lightmaps/strong static lighting for large scenery; keep dynamic lighting for the player-light and minimal interactives.
- LOD/visibility: set visibility ranges per major piece (distant silent LODs); HLOD for heavy props; billboards/impostors for far vegetation.
- Instancing: MultiMesh for grass/repeating props on compat; verify draw call savings by measurement.
- Particles: effect count + lifetime budgeted (snow/blizzards included); screen-space cost measured on tablet GPU. Prefer a few layered global weather layers over thousands of flakes.
- Post: avoid/skip heavy post on compat; atmosphere comes from lighting/materials, not a full-screen stack (contract limits memory cost discipline).
- Weather data first: storm/snow/visibility are authored as reusable global states (fog density, wind noise, light dimming) so stealth (BV-SKILL-007), survival (BV-SKILL-017), and graphics consume the SAME state.
- Keep a small scene-stats overlay (draw calls, frame time, light count) as dev tool (SOP-006) for shipping checks.

## ANTI-PATTERNS
- Desktop-forward demos (Forward+ features on tablet — forbidden; and a lie to the budget).
- Every-light dynamic everywhere (fill/overdraw spikes) — bake first.
- Unlimited LoD-less prop duplication (instance when possible, LOD when not).
- "Run it on desktop, it's fine" as a verdict (BV device rule, SOP-005).
- Buildings/shadows that break stealth legibility (unfair darkness) — atmosphere tuned with perception in loop.
- Snowstorms as pure FX with no gameplay/sensing effect (one-sided masking, doctrine §6/§30).
- Weather implemented as heavy particle systems scraping the tablet budget (doctrine §30, SOP-004).

## KNOWN FAILURE MODES
- GL Compatibility feature omission (e.g., shader uses incompatible feature) → visual breaks subtler — contract check at import/fixture level.
- Half-precision/F16 differences if/when on Mobile renderer — numbers round, near/far artifacts; re-test after gate.
- Draw-call growth via props → instancing/LOD by measurement, not hope.
- Transparent overdraw frame spike → enforce few transparency, measure.

## VERIFICATION
- Static: feature set ⊆ contract; instance/LOD/range fields set; transparency count small; project settings match BV-D001 unless gating evidence exists.
- Performance/device: before/after frame & draw measurements on tablet; recorded in report.

## STOP CONDITIONS
If a visual can't be delivered within budget under its contract, cut scope (doctrine §11 smaller-system) instead of silently weakening quality elsewhere; if stealth legibility would break, stop and re-stage with the stealth skill.

## PERFORMANCE
- See SOP-004. Concretely: draw calls, vertex cost, fill/overdraw, memory per sector, particle spend all measured.

## DEVICE
- All validation on target tablet family (GPU/driver recorded). GL Compatibility driver variance is real — validate on more than one device before releasing claims.

## RELATED SKILLS
- BV-SKILL-001 godot-android-edge (editor/export/renderer facts)
- BV-SKILL-007 stealth-and-concealment (dark/light legibility)
- BV-SKILL-013 large-world-sector-architecture (sector budgets)
- SOP-004 mobile-performance; developers-way (governing)
- BV-SKILL-032 visual-presentation-architecture (D019 — this skill retains weather SHARED state / lighting / LOD / atmosphere / VFX budget; camera/helmet/HUD compose without duplicating)
- BV-SKILL-036 touchscreen-input-architecture (D026 — tablet baseline + GL Compatibility + touch-primary ergonomics compose with this skill's mobile budgets; input adds no simulation cost; composition)