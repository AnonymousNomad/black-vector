---
name: alaska-site-environment-reference
description: Alaska installation and remote-site reference discipline — real military/civil site templates (Adak-style necks, White Alice troposcatter ridges, Dutch Harbor isthmus garrisons, AC&W/Nike earth-bermed posts, Kennecott company towns, cannery/mine/bush-airstrip sites), layout-to-fiction transformation rules, weather/logistics serviceability derived from real Alaska constraints, and anti-misrepresentation guards (doctrine BV-D012). Load for ANY site layout, installation architecture, sector/base placement, or cold-region logistics design work.
---

# ALASKA SITE AND ENVIRONMENT REFERENCE (BV-SKILL-024)

## NAME
ALASKA SITE AND ENVIRONMENT REFERENCE

## PURPOSE
Own the reference layer between real Alaska infrastructure and Simse Sound's fictional architecture. It
distills documented real sites (remote military/civil installations, communications grids, cold-war sites,
extraction/industry towns, bush logistics) into reusable DESIGN TEMPLATES: layout logic, material language,
seasonal logistics, and physical constraints — then transforms them into original fiction under doctrine §16/§17
and BV-D012 (Alaska geography never conflicts with Simse Sound). It is the spatial/environmental half of the
research ledger (ALASKA_SITES.md); historical/experiment provenance stays with BV-SKILL-023; gameplay surfaces
stay with BV-SKILL-006 and BV-SKILL-003; visual-equipment stays with BV-SKILL-022.

## WHEN TO LOAD
- Designing any Simse Sound structure, installation, camp, site, or sector base (D011/§6 regional distribution,
  BV-D043 onward).
- Placing platforms/wharfs/antennas/windbreaks/berthing relative to terrain (neck, isthmus, muskeg, ridge).
- Authoring seasonal logistics (barge, air-taxi, weather windows) or civilian-military separation (tech vs
  lower camp) stories.
- Adapting a documentary/existing real Alaska site into fiction safely (BV-D012 template transform).

## DO NOT LOAD WHEN
- Gameplay surfaces or player-environment interactions (BV-SKILL-006/003).
- Pack valuable visual-detail rendering (BV-SKILL-014, BV-SKILL-022).
- Historical/experiment lineage authoring (BV-SKILL-023).

## PRECONDITIONS
- Governing set loaded; SOP-002 routing confirms site/architecture scope.
- `docs/research/ALASKA_SITES.md` available (template source); BV-D043 (or future D012) defines Simse Sound
  sector geography the fiction maps onto.
- If resembling a real site, the transformation rule (rename → re-shape → re-purpose) is applied consciously
  and is disclosed in the design note.

## GOVERNING INVARIANTS
1. TEMPLATE OVER COPY (doctrine BV-D012): real sites ARE templates for layout/material/logistics LOGIC, never
   reproduced. A transformed site must not be identifiable as a named real installation.
2. DESIGN LAW MINIMALISM: sustain a SMALL set of rich, re-useable site templates (neck-airfield, troposcatter
   ridge, berth-isthmus, company-town seam, seasonal cannery), each with layout/materials/logistics/story beats —
   not a sprawling real-site catalogue.
3. TERRAIN DECIDES FIRST: siting follows terrain hydrology/morphology that "pulled" the real site (level ground on
   a neck; flat ground only at the isthmus); fiction uses the same physics every time.
4. SYSTEMS ARE CLOCKWORK, NOT SCENERY: access windows (freeze/breakup, barge season, flight weather), fuel,
   generators, supply dependence are plot pacing and survival stakes (BV-SKILL-017/018), never set dressing.
5. SEPARATION IS A FEATURE: military technical core vs support/"downtown" camp (upper/lower split), enclave
   isolation, and "crews live ON mission" environments are deliberate; they produce the fiction's class/security
   and faction dynamics (D011).
6. LEGACY OF OPERATION IS LITERAL: fuel contamination, munitions debris, earth-bermed remains, abandoned
   experiment sites (Project Chariot precedent) linger physically and narratively — the world keeps its receipts.
7. NO OVER-SPECIFICITY: cite the real precedent generically (e.g., "after the AJAX-WHITE pattern") and keep
   fiction nomenclature; no real Aleutian/Aleut geography imported into Simse Sound coordinates or maps.

## WORKFLOW
1. If a directive targets a NEW site type not represented in ALASKA_SITES.md, either (a) extend the ledger with a
   template record OR (b) transform from an existing template. Adding a probe: verify against documented
   precedent before canonizing layout/material claims.
2. Define site card: LOCATION-LOGIC (what terrain/morphology it anchors) → MATERIALS (structure, generator core,
   power, fuel legacy) → LOGISTICS (barge/flight/winter windows, resupply cadence) → STORY BEATS (separation,
   isolation, decay, what "went wrong here" in-fiction).
3. Map to Simse Sound sector geography (BV-D043/D011 §6): place the template, note what survives transformation.
4. Apply transformation rule (rename → re-shape → re-purpose); disclose in the design note that this is an
   ORIGINAL derivative, not a real site.
5. Cross-fuel with D011 §6 population/factions (company town vs technical camp vs cannery laborers) and with
   seasonal systems in WILDLIFE_ECOLOGY (the same clock links wildlife and infrastructure).
6. Verify (below) and commit design notes; re-run methodology validation.

## IMPLEMENTATION GUIDANCE
- Neck/muskeg airfield logic (Adak): a LONG, level, narrow strip between water bodies with both-ends sea access —
  perfect for Simse Sound platforms, and cheap to defend because terrain concentrates approaches.
- Troposcatter billboard ridge (White Alice): antennas on skyline + generator-backed shelters + upper/lower camp
  split is the "nervous system" archetype; pair it with wiring/radio-redundancy storytelling.
- Berth-isthmus garrison (Dutch Harbor): flat ground only at the isthmus → density pressure, defended waterfront,
  seaplane ramp; works as a defendable bottleneck that ALSO fills with civilian works.
- Earth-bermed radar/AA posts (AC&W/Nike): half-buried magazines, antenna on the locally-highest point, crews
  living on-site; read as "ears of the world" (can merge naturally with anomalous/warning storytelling).
- Kennecott-style company town: stacked timber/composite buildings, powerhouse + mess + bunkhouse cores, decline
  follows the vein — the exact generator of D011's civilian-vs-military hierarchy and the "peak then rot" arcs.
- Cannery/wharf: seasonal labor surge, tide-scheduled shipping, pilings, small power plant — the fiction's
  "work-weekend" civilian population and its fragile supply line.
- CHERISH the exception: an abandoned, fully packaged, never-detonated experimental site (Chariot) is
  genre-perfect as a Dead-Face SETTING, but its UN-firing is the point — no explosions implied, ever.

## ANTI-PATTERNS
- Reproducing a real installation by map, name, or recognizable silhouette.
- Inventing a site logic with no terrain rationale ("the facility is where we wanted it") — terrain decides first.
- Porting dozens of real sites; the template set stays small (design-law minimalism).
- A site that reads as "idle scenery" — every site carries pacing stakes (supply, warn, defend, discover).
- Over-specific construction detail that could be used to locate or replicate the real thing.

## KNOWN FAILURE MODES
- "Flavor drift": a transformed site re-imports real geography (a real island's name, a real sector boundary) —
  stop and re-apply rename → re-shape → re-purpose.
- Logistics modeled without the seasonal clock (freeze/break-up/barge) → sites feel permanent, killing stakes.
- The exception template (Chariot-style) leaking a detonation story beat — the site never fired; keep it that way.
- Template creep: ledger grows by catalogue additions instead of by reused template depth.

## VERIFICATION
- Static: every site design maps to a template in ALASKA_SITES.md; transformation disclosure present when any real
  precedent is alluded to; no real location/map identifiers imported; methodology validation passes.
- Geometric sanity: siting satisfies the terrain rationale it cites (level strip on a neck, flat ground on an
  isthmus, technical camp above support camp, etc.).
- Logistics: every site has a seasonal access path (barge/flight/winter window) and a supply cadence; none reads
  as permanent city logistics.

## STOP CONDITIONS
If a design would reproduce a real installation, import real Aleutian geography, add an imploded experiment
blast (Chariot precedent), or build a facility with no terrain/logistics rationale — stop and re-anchor to this
skill's invariants and BV-D012 before continuing.

## RELATED SKILLS
- BV-SKILL-023 historical-provenance-research (experiment/history lineage for site back-stories)
- BV-SKILL-006 environmental-affordances / BV-SKILL-003 third-person-character-controller (gameplay surfaces)
- BV-SKILL-017 survival-wilderness-systems (seasonal clock shared with wildlife)
- BV-SKILL-022 visual-equipment-doctrine (site + equipment visual cohesion)
- developers-way, black-vector-project-doctrine (governing); BV-D043 et al. sector geography