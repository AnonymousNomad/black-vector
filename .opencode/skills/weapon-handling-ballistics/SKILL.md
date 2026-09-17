---
name: weapon-handling-ballistics
description: Weapon handling and game ballistics — weapons as tools with tradeoffs, data-driven handling/ballistics, report-and-signature, and the starting sidearm lock. Load when implementing or tuning weapons, handling, ballistics, or recoil.
---

# WEAPON HANDLING AND GAME BALLISTICS (BV-SKILL-011)

## NAME
WEAPON HANDLING AND GAME BALLISTICS

## PURPOSE
Implement weapons as tools with tradeoffs (doctrine §9): data-driven handling and game ballistics (mass, handling, stability, capacity, projectile, recoil, optics, report/signature, mobility). No rarity tiers, no arbitrary RPG damage. The starting lock — compact sidearm + 1 loaded mag + 1 spare mag + boot knife, no rifle (photograph is narrative, not gear) — is a designed state, not a limitation to optimize away (doctrine §4). Hunting/fishing/primitive tools are instantiated as SURVIVAL tools (doctrine §30); ranged combat weapons beyond the sidearm are recovered capability, gated by memory/disciplines such as MARKSMAN (doctrine §3, §32).

## WHEN TO LOAD
- Implementing/tuning weapons, handling, recoil, ballistics, optics, or their signatures.
- Balancing the sidearm-first opening and the doctrine that direct combat is never universally optimal.

## DO NOT LOAD WHEN
- Melee exchange (BV-SKILL-010) or memory progression (BV-SKILL-012) — weapons are data, progression restores access.

## PRECONDITIONS
- Governing set loaded.
- Signature emission contract (BV-SKILL-007) — weapons emit REPORT signature (acoustic/visual/thermal) through the same channel system.
- Ammo/loadout data resource schema exists (or is being designed with this skill).

## GOVERNING INVARIANTS
1. Weapons are tools, not stat-sticks: every weapon is a bundle of tradeoffs across HANDLING (draw, aim, ADS, recoil control, mobility), BALLISTICS (projectile behavior, falloff, stop, penetration), CAPACITY, RELIABILITY, OPTICS, REPORT/SIGNATURE, and POSITION. No unused attribute.
2. Data-driven, single-sourced: weapon stats live in Resources; gameplay never hardcodes weapon numbers. Tuning = editing data + fixture, not touching logic.
3. Damage model: game ballistics (projectile/damage), not arbitrary RPG numbers. Damage emerges from weapon/ammo data, not a "weapon damage stat" — document its derivation. No rarity tiers.
4. Signature is inherent: every shot emits REPORT through the signature system — acoustic, visual (muzzle), thermal (heat), social (an explosion in the world is an event). Silencing is a designed tradeoff with cost, never a free default (Pillar 2/3, doctrine §7/§9).
5. The sidearm is a constrained tool: low capacity, real handling/mobility tradeoffs; the boot knife is the premier close tool; rifles/carbines are later (memory/discipline-restored, BV-SKILL-012) — early exchanges punish shooting-through vs manipulation. Direct combat never becomes the universal optimal (doctrine §4).
6. Ammo economy is meaningful: loaded mag + spare only at start; everything else is found/recovered — scarcity is a design fact, tracked as such.
7. Hunting/fishing/primitive implements (traps, fire starters, shelter tools, snares, improvised takes) are gameplay objects owned by the senses of survival (BV-SKILL-017): they have real handling/report data where it matters (a rifle-shot report IS a signature event; a snare is silent), but they are NEVER balanced as a combat arsenal (doctrine §30).
8. Discipline gating: weapon families unlock through memory/capability restoration (MARKSMAN restores rifle familiarity, doctrine §32) — weapons do not appear from loot tables.
9. Vulnerability is real: psionic heavy-use (BV-SKILL-019) can impose temporary motor instability — weapons must respect the same vulnerability state as the rest of the body (doctrine §22).

## WORKFLOW
1. Read current weapon/ballistics handling in current form; map against invariants.
2. Define/update weapon data schema (single source) for the weapons in scope (start: sidearm + knife; rifle schema only for future).
3. Implement handling (draw/ADS/recoil) and ballistics sampling event-driven; wire report emission to signature system.
4. Wire ammo state (capacity, loaded, spare) as observable state (SOP-006).
5. Balance by fixture (TTK vs flanking/spacing) ensuring tradeoff doctrine; verify statically, behaviorally when authorized (SOP-005).

## IMPLEMENTATION GUIDANCE
- Ballistics in game terms: ray/velocity projectile, distance falloff from data, penetration vs material tags (resources in BV-SKILL-006 taxonomy) — keep deterministic for legibility.
- Recoil = curve data (up + random-offset bound) applied to camera viewmodel; recovery time from handling stats — data-driven, not magic constants in code.
- Muzzle report event → signature emitter (radius/texture/loudness); suppressor = modifier with durability/heat tradeoff EVENTUALLY, never assumed.
- Ammo as observable: magazine count, reserve, per-round states (loaded/spare/stripped) exposed for debug and HUD.
- Keep sidearm honest: controls are the same engine, but stats make it tactically distinct — a sidearm fight is a flanking fight, not a gunfight.

## ANTI-PATTERNS
- Weapon "rarity" tiers or arbitrary numeric damage stats (doctrine §9).
- Hardcoded per-weapon numbers in scripts instead of data resources.
- Shooting as a screen-saver (recoil cosmetic only, no report/signature, no ballistics consequence).
- Free full-auto everywhere including start (breaks starting lock).
- Balancing weapons in isolation from ammo/scarcity reality.
- Weapons from loot tables instead of memory/discipline gates (doctrine §32).
- Treating survival tools (traps/snares/fire) as combat weapons (doctrine §30).

## KNOWN FAILURE MODES
- Sidearm feels useless → players skip direct combat entirely (also a failure of doctrine if universal-optimal skew) → rebalance via handling/trade tools, then re-test tradeoff triangulation with stealth.
- Report events not loud enough to matter → perception never reacts → world consequence hollow; fixture asserts witness reactions.
- Recoil/recovery input-vs-output delay mismatch on touch input — tablet-validation needed.

## VERIFICATION
- Static: weapon data in resources; no router hardcodes; report emission wired; sidearm/knife-only start constraints hold; no rarity/damage-stat patterns.
- Behavioral (when authorized): fixture fires sidearm at ranges → data-derived damage/falloff outcomes; report event triggers expected perception reaction; ammo scarcity path exercised.

## STOP CONDITIONS
If a weapon behaves unlike its data, or direct combat becomes the default best answer, stop and align with doctrine before tuning forward.

## PERFORMANCE
- Ballistics sampling is event-driven + cheap physics (ray / simple simulate); no per-frame heavy integration per round in flight (budget pooled when clustered).

## DEVICE
- Recoil/recovery and ADS touch ergonomics are tablet-critical; validate aim precision & responsiveness on device.

## RELATED SKILLS
- BV-SKILL-007 stealth-and-concealment (report/signature channel)
- BV-SKILL-009 contextual-assassination (the knife/close path)
- BV-SKILL-012 diegetic-memory-progression (rifle recovery, later)
- BV-SKILL-008 tactical-ai-perception (world reacts to reports)
- D013 canonical weapon bible = `docs/design/WEAPON_RIFLE_FAMILY_BIBLE.md` (11 frozen families + 10 handling axes;
  numbers derived from family READ when implementation is authorized, never invented here)
- developers-way (governing)