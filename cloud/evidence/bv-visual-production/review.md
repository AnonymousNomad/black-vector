# BLACK VECTOR Visual Production Gate — Internal Review

## Review scope

Fresh internal pass over the ten 1280×720 normal-play captures in this folder, including actual player traversal, an activated cannery gate interaction, an opening combat stance, weather state, and the playable interior. The captures use `slice_main.tscn`, the production Corley scene, the real gameplay camera, and live world systems; they are not isolated model views.

No Veritas/Ghost endpoint or supplied external review harness was available. This is an internal visual review and is not represented as independent approval.

## Required visual questions

| Question | Result | Evidence and qualification |
|---|---|---|
| Does this still look like blocks? | **NO** | The normal-play slice is framed by authored conifers and deadfall, varied ground, a coastal waterline and distant ridges, and a ribbed gable-roof cannery with doors, windows, sign, machinery, props, and an interior. Low-poly facets remain visible by design, but cube/cylinder proxy geometry no longer dominates gameplay. |
| Does Corley look like a production character? | **YES — production-capable, stylized** | The proxy is retired in the playable scene. The original GLB contains a skinned 18-bone humanoid, 68 skinned meshes, separate skin/hair/cloth/shoe materials, opening-state tank top and worn medical/prison trousers with poor slip-ons, 15 clips, bone attachment points, and injury presentation. She reads as an adult human at normal third-person scale. The style is deliberately low-poly and is not photoreal. |
| Does the environment look intentionally authored? | **YES, for the opening slice** | A forest corridor leads from Corley to the cannery; vegetation clusters frame the route, deadfall and rocks break the ground plane, a beach/shoreline opens to island ridges, and the industrial landmark and interior provide navigation and contrast. |
| Do the materials look distinct? | **YES** | Skin, dark hair, worn cloth, canvas footwear, soil, damp gravel, wet earth, rock, conifer foliage, timber, painted/rusted steel, concrete, and water use different values and roughness responses. |
| Is the Alaska atmosphere convincing? | **YES, in a stylized presentation** | Cold coastal light, conifer stands, shoreline and distant islands, fog, wind/rain state, wet ground, and a dark cannery interior communicate an isolated northern coast. |
| Do vegetation and terrain have believable variation? | **YES, with a stylized limitation** | Species groups, scale and placement vary; ground tint/texture, terrain elevation, beach, creek, rocks, grasses, shrubs, and deadfall differ. Most tree silhouettes remain within the conifer family and the relief is mild around the opening route. |
| Do buildings look like buildings rather than cubes? | **YES** | The cannery has a gabled roof and ends, ribbed siding, structural posts, window frames and glazing, a working door, gutters/downspouts, sign, and interior machinery. |
| Does lighting create depth? | **YES** | Directional key light and restrained ambient fill preserve silhouettes and ground shadows; the interior stays darker than the exterior; fog and storm/night states change the sky and light energy. |
| Is the game significantly closer to the BLACK VECTOR concept? | **YES, against the supplied cues** | The evidence is materially closer to the requested Alaska survival/industrial-horror direction than the initial graybox state. No separate concept-art reference was supplied for a pixel-by-pixel comparison. |

## Decision

**Opening-slice visual gate: PASS (internal).** `DOES_IT_STILL_LOOK_LIKE_BLOCKS = NO`.

This closes the requested visual production gate for the first playable area, not every area in the project. Remaining work is refinement: broader world coverage, more tree-silhouette variation, richer close-range/normal-map material detail, target-device frame-time and memory measurements, and acoustic review on hardware. The normal-play renders were captured on software OpenGL (`llvmpipe`) with the cloud audio server falling back to Godot’s dummy driver; neither is presented as target-device performance or listening acceptance.

## Evidence files

1. `01-opening-wide-1280x720.png`
2. `02-corley-rear-gameplay-1280x720.png`
3. `03-corley-front-three-quarter-1280x720.png`
4. `04-wilderness-traversal-1280x720.png`
5. `05-shoreline-water-1280x720.png`
6. `06-industrial-exterior-1280x720.png`
7. `07-cannery-interior-1280x720.png`
8. `08-low-light-storm-1280x720.png`
9. `09-interaction-gameplay-1280x720.png` — live activation logged `INSPECT f1_gyle_cannery_gate`.
10. `10-tactical-gameplay-1280x720.png` — live combat-stance presentation.

`captures.sha256` records the SHA-256 digest of each image.
