---
name: systemic-traversal
description: Systemic traversal — climbing, mantling, ledges, and the tree-climb arc (climb→conceal→observe→search→hidden→drop assassination, future). Terrain-as-gameplay movement over affordances; budget-bounded and observable. Load when implementing or reasoning about climbing/traversal.
---

# SYSTEMIC TRAVERSAL (BV-SKILL-005)

## NAME
SYSTEMIC TRAVERSAL

## PURPOSE
Turn the environment into movement gameplay: climb, mantle, ledge transit, and (future) the tree-climb arc, implemented as a legible, budget-bounded traversal system that composes with stances and produces expected movement signature.

## WHEN TO LOAD
- Implementing or extending climb/mantle/ledge/tree traversal.
- Reasoning about when terrain is traversable (environmental-affordances handoff).

## DO NOT LOAD WHEN
- Ground locomotion and stances (BV-SKILL-003/004 own those).
- World-layout/level design data (BV-SKILL-006 owns affordances' world placement).

## PRECONDITIONS
- Governing set loaded.
- Movement contract (BV-SKILL-003) and stance table (BV-SKILL-004) understood.
- Affordance tagging conventions (BV-SKILL-006) exist and are applied to the target surfaces.

## GOVERNING INVARIANTS
1. Traversal is affordance-driven: surfaces carry explicit affordance tags (climbable, mantleable, ledge, branch) — a surface is only traversable if the expectation of usefulness is intentional (doctrine §5).
2. Queries are bounded: affordance detection happens at contact/range points (raycasts, area probes), never per-frame full-scene searches.
3. Traversal is observable: every traversal state and its reason logged (SOP-006). Climb height/duration/entry conditions legible.
4. Traversal composes with stances: stance restricts what traverse steps are legal (e.g., prone cannot mantle high ledges).
5. Trees: the tree-climb arc CLIMB→CONCEAL→OBSERVE→SEARCH→HIDDEN→CONTEXTUAL DROP ASSASSINATION is the required future path (doctrine §5) — implement climb affordance so the arc can attach later; drop-assassination itself is future work, not now.
6. Traversal never produces free teleportation: every climb is a physics-respecting, observable motion (no arbitrary path offsets).

## WORKFLOW
1. Read current movement + surface setup in current form.
2. Audit thread-top affordance surface list for target area.
3. Add traversal states to the state vocabulary (entry, climb, ledge balance, exit) with guards per stance.
4. Implement bounded probes on entry/exit contacts.
5. Static verify; runtime/behavioral verify only when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Entry/grab detection: short forward/vertical probes at fixed timestep near surface; gate by stance + surface tag.
- Climb motion: move along surface normal-tangent plane using velocity per physics tick (respects CharacterBody3D contract; indirect BV-SKILL-003 rule).
- Ledge balance: capsule center-hold math with snap; distinct failure state (missed grip → hang-fall) that is observable.
- Tree climb: reuse climb core with per-branch segments; branch = affordance segment; expose "hidden in canopy" signature state later when the arc lands.
- Keep traversal tick cost O(1) per claimant; if a sweep is unavoidable, spread over frames (SOP-004).

## ANTI-PATTERNS
- Per-frame `get_overlapping_bodies/work areas` scanning the world for grasp targets.
- Climb as a cutscene/teleport (no physics, no detectable motion).
- One hero-climb method with 12 boolean branches instead of two composable rules.
- Climbable tags on decorative surfaces that gameplay expects to be climbable too (violates expectation doctrine).
- Ignoring stance gating (sprint-climbing walls).

## KNOWN FAILURE MODES
- Sticky corners at mantles (contact sliding) — probe spacing/padding tuning, verify in fixtures.
- Climb interrupting stance or vice versa (state-machine ordering) — one traversal owner; serialize with stance transitions.
- Branch segments bleeding into non-branch colliders — surface tag audit before ship of a world piece.

## VERIFICATION
- Static: states listed with guards; probes bounded; reason logging present; stance gating in table.
- Behavioral (when authorized to run): climb ledge failure → hang falls as specified; mantle rejection done; tree arc entry/exit reproducible.

## STOP CONDITIONS
If a traversal step cannot be explained from observable state (why did grab fail?), stop and add instrumentation; if the arc cannot attach cleanly, stop and redesign the climb core (do not bolt on).

## PERFORMANCE
- Probe budget per traversal actor; spread world queries; no per-frame scene scans (SOP-004).

## DEVICE
- Touch/gesture mapping for climb intent must be validated on tablet (discrete grip vs continuous move inputs stay separate).

## RELATED SKILLS
- BV-SKILL-003 third-person-character-controller (velocity contract)
- BV-SKILL-004 stance-system (stance gating)
- BV-SKILL-006 environmental-affordances (surface tagging)
- BV-SKILL-009 contextual-assassination (drop-assassination arc consumable, future)
- SOP-004 mobile-performance; developers-way (governing)