# BLACK VECTOR — C0 Source Reconciliation

C0 status: **`BV-C0_RECONCILED_WITH_KNOWN_LOCAL_DELTA`**.

Phase-02 verdict: **NOT ACCEPTED** — the historical visual and motion evidence is unavailable, and the current proxy fails the visual bar.

## Source truth

- Repository: `AnonymousNomad/black-vector`
- Working branch: `cloud-handoff-black-vector`
- Handoff branch HEAD when work began: `cb039485d5f673ebde2f6340dae19d22e705ccf6`
- Accessible visual source line named by the handoff: `ebdeb7abf10cdeb67b1365e12f98319d8a71ab65`
- Expected laptop-local candidate: `1292c67`

`git cat-file -e 1292c67^{commit}` fails: the candidate object is not present in this checkout. The working tree therefore cannot establish byte identity with the recovered laptop build. The handoff also records that the referenced concept-image binaries and original Phase-02 captures were not included. The repository has only `game/assets/README` under `game/assets/` and `game/resources/stances.tres` under `game/resources/`; it contains no production character model or texture set. No external asset was imported and no license is inferred from a reference name.

## Behaviors re-established

- The wilderness environment now assigns its `ProceduralSkyMaterial` through `Sky.sky_material` and uses explicit COLOR ambient at energy `0.30`, rather than the previous SKY ambient at `0.72`.
- Disabled cannery lights start at energy `0`; the owned light-state projection now sets both visibility and energy when toggled. The sealed Deep Bay light remains dark.
- The third-person spring arm and camera point behind Corley and toward the player. The runtime check confirms active camera, 4 m spring length, `0.99` forward alignment, and `-0.93` behind-player alignment.
- The generated wilderness mesh is a presentation overlay. Its collision layer is disabled because its overlapping terrain collider trapped the CharacterBody against the authored Strand floor. The authored floor remains the gameplay collision surface.
- The foundation self-check now verifies light-energy projection, ambient settings, camera direction, movement, grounding, crouch/stand restoration, and the nonblocking overlay collider.

These are re-established behaviors in the accessible source line, not a byte-for-byte restoration of `1292c67`. The recovered local character, wardrobe, motion, and visual evidence were not reproduced here.

## Verification evidence

- Godot: `4.7.2-stable.official.ed1daf0bf`; the official release archive SHA-512 was verified as `9aa00f7a605200940bce3027a567b782f49bd8e940dd06ae9e987bd65aee1b1467edd56ed84fcdcbdd44354bf613bdbb4e5d2913e925850368e150c59ed54c65`.
- Foundation harness: **23 pass / 0 fail** with the above Godot binary. Four ObjectDB leak warnings remain at shutdown; they are recorded and were not treated as a passing product check.
- `python3 tests/static_verify_game.py`: **39 OK / 0 fail**.
- Godot editor parser gate: passed; no `SCRIPT ERROR`, `Parse Error`, or `ERROR:` output.
- `tools/validate_methodology.py`: passed with its hardcoded `ROOT` adjusted in-memory to this checkout (`/workspace/black-vector`). The repository checker itself was not changed; its default `/black-vector` path does not match this cloud workspace.
- Normal-play capture: [current-normal-play-llvmpipe-1280x720.png](evidence/bv-c0/current-normal-play-llvmpipe-1280x720.png), SHA-256 `a5a06eed1332a265aad3421a7ffe9dbe255d95cfc74cdf10923315c26653667b`. Captured at 1280×720 with Godot GL Compatibility through Mesa llvmpipe (software rendering) on X11.

The screenshot confirms that the camera now frames Corley from behind, and also shows why the visual gate remains open: Corley is still a primitive proxy, while the trees, terrain, and props read as simple geometry. This is not Android performance evidence. No physical Android device was available or tested.

## Unclosed acceptance

The historical `hero_review_*.png`, `phase02_00..16_*.png`, and `phase02_motion_report.json` cited by the recovery handoff are absent. The original 17-shot motion gate, hero-material measurements, production-character load gate, and Phase-02 critic verdict cannot be independently verified. The current proxy and world fail the stated normal-play visual quality bar. **Do not mark C0 complete or claim `PHASE-02 REPAIR ACCEPTED`.**

Next: close C1 with a provenance-checked production character and repeat the normal-play character, motion, and grounding review. Continue C2 environment work with licensed/original assets. Keep Android device acceptance marked pending until tested on hardware.
