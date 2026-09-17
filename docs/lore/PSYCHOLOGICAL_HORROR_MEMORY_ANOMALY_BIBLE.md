# BLACK VECTOR — PSYCHOLOGICAL HORROR, INNER VOICE,
# MEMORY RELIABILITY & ANOMALY RECONCILIATION BIBLE
### D030 — Psychological Canon Lock

> **Design / canon only.** This bible changes no gameplay code, implements no systems, and creates no
> combat, anomaly powers, Shade code, AI, dialogue, memory mechanic, sanity mechanic, or UI. It freezes
> the *rules of experience* the later implementation must obey.

**Ownership**
- **D028 / BV-D152** owns Corley Alexandra Ferrell (identity, life, fall, reclamation).
- **D029 / BV-D153** owns BLACK HAND generations, Hidden Hand synchronization, the Shade program, and the
  surviving teammate's program history and relationship.
- **D030 (this bible)** owns psychological horror rules · perception reliability · inner voice architecture ·
  Memory Bleed philosophy · anomaly interpretation · the surviving teammate's psychological/perceptual
  architecture · and the relationship between what Corley experiences and what is objectively true.
- **D031** owns the Season-1 reveal staging.

**Composes, does not replace**
- D001–D016 (world, sensing truth, anomaly taxonomy), D008/D009 (combat), D014 (prologue),
  D015 (`SIMSE_SOUND_SURVIVAL_ENVIRONMENT_HORROR_BIBLE`), D016 (`ANOMALOUS_CAPABILITY_BIBLE`),
  D017 (`PLAYER_RECLAMATION_PERSISTENT_CHARACTER_STATE_BIBLE`), D018 (`SEASON_1_CAMPAIGN_MISSION_SPINE`),
  D023 (`COMPANION_RELATIONSHIP_SHADE_RECLAMATION_BIBLE`), D028, D029.

---

## 0. Reading Rules

1. **Locked** statements are canon. **REQUIRES_FUTURE_DECISION** statements are intentionally open and must
   not be silently answered by later drafts.
2. Corley is a **woman**; this bible uses **she/her**. The SECOND and the Shade are **he/him**. Any legacy
   male-coded protagonist prose elsewhere is **non-authoritative** where it conflicts (D028/BV-D152).
3. This bible is about **experience rules**, not capability rules. Where the anomaly is concerned, the D016
   taxonomy is authoritative and this bible must not add capability.
4. Every horror, memory, or intrusion event is **authored**. An unnarrated ambient horror event is a bug, not
   a design. "A horror event with no authored trace is a bug wearing a costume" (D015 §33).
5. **The tools never lie; the world may.** (D015 §30/§32; BV-D151.)

---

## 1. Core Horror Principle

BLACK VECTOR horror is **not**:

> *"The player cannot trust anything."*

That produces frustration, not dread, because it converts mystery into noise.

The locked principle is:

> **The player can trust the world, but must question interpretation.**

The game **may** challenge:

- memory
- identity
- motive
- meaning
- causality
- perception

The game **must not** randomly invalidate:

- controls
- saves
- physical interactions
- established mechanics
- player agency

**Corollary.** Dread comes from *ambiguity about meaning*, never from *unreliability of the interface between
player and game*. If the player cannot trust that a door is a door or that a jump will land, the horror has
failed and the bug-hunt has begun.

---

## 2. Four Truth Layers

The four-layer separation is already frozen (BV-D151) and already compiled
(`narrative_channels.gd`). D030 **adopts the canonical four channels verbatim** and adds their psychological
semantics. The canonical token is `INTRUSION_OR_UNKNOWN`.

### 2.1 OBSERVABLE REALITY

What physically exists: environment · objects · injuries · weather · other people · recorded evidence.

- This is the foundation. All other layers are interpreted *against* it.
- It is the world's truth, recorded in world state, and it does not bend to flatter or torment Corley.
- Per the `WORLD` / `PERCEIVED` observability split (BV-SKILL-015 / BV-SKILL-018), **OBSERVABLE REALITY is
  always technically intact even when Corley's experience of it is deceived.**

### 2.2 SPOKEN CORLEY

What Corley chooses to communicate. Other characters hear this.

- May be honest, defensive, incomplete, manipulative, or emotionally guarded.
- **Interaction is not compliance; speech is not truth.** Spoken Corley can lie to people.
- Spoken Corley is **world-consequential**: NPCs may react, remember, refuse, or withdraw.

### 2.3 INNER CORLEY

The player's private access to Corley's internal experience. NPCs never hear this.

- Contains tactical thought · fear · guilt · suppressed memory · humor · doubt · emotional reaction.
- Player-only sink; channel isolation is **absolute** (BV-D151 / D028 §14).
- INNER CORLEY is **not another entity.** It is the part of her that still speaks when the armor is on
  (D028 Four Faces).
- INNER CORLEY is where she still exists uncensored — **and where she can be wrong about herself.**

### 2.4 INTRUSION_OR_UNKNOWN

Experiences whose **origin is unresolved**. Possible sources:

- memory
- trauma
- Compound effects
- anomaly
- external manipulation
- neurological interference

- The game **does not immediately label the source.** Unresolved origin is the content.
- INTRUSION is a **presentation/narrative channel**, not the D016 "PERCEPTUAL INTRUSION" capability and not
  the Compound "memory intrusion" strain symptom. Same word, different domain — do not conflate (see §15.4).
- INTRUSION content may be `PERCEIVED`-layer or, rarely, may carry `WORLD`-truth consequence
  (a REALITY BREACH, §7.3). Either way it is authored, budgeted, and has a reason.

### 2.5 Composition table

| Layer | Who hears | Truth status | May affect world? | May lie to the player? |
|---|---|---|---|---|
| OBSERVABLE REALITY | everyone | WORLD truth | yes | no |
| SPOKEN CORLEY | nearby humans | her choice | yes (social/world) | yes (diegetic) |
| INNER CORLEY | player only | her interpretation | no | about *interpretation*, not mechanics |
| INTRUSION_OR_UNKNOWN | player only | unresolved | only via authored REALITY BREACH | about *origin/meaning*, never mechanics |

The four channels are a **narrative-awareness axis**. The `WORLD`/`PERCEIVED` overlay split is a separate
**observability axis**. Both are always true simultaneously: an INTRUSION line may be logged `PERCEIVED`
while the world layer stays honest, and a REALITY BREACH may move the world layer while the character still
does not understand it.

---

## 3. Player Trust Contract

**Locked fairness law** (D015 §30, preserved):

- input remains trustworthy
- saving remains trustworthy
- critical HUD state remains functionally trustworthy
- bugs must never be intentionally mimicked
- death cannot arbitrarily occur from unknowable fake rules
- mechanics never silently flip

Extensions for D030:

- **Retrospective legibility.** The player must always be able to look back and understand *"the clues were
  there."* Ambiguity is allowed; cheating is not.
- **Authored ambiguity.** Every deception is an authored, greppable fact with a reason.
- **The interface is a promise.** The game may make Corley doubt reality; it must never make the *player*
  doubt whether the game is working.
- **No sanity meter, no diagnostic labeling.** There is no "sanity bar," no "psychosis level," and no
  on-screen diagnosis. The instruments that exist are Control and Neural Strain (D016), which are read
  qualitatively and diegetically — never as a visible psychic meter on day one.
- **Overlay honesty.** The dev/debug overlay separates `WORLD` and `PERCEIVED`, and remains truthful about
  both even when the fiction deceives the character.

Player emotional targets: **confusion · curiosity · fear · sadness · discovery.**
Never: **frustration from arbitrary deception.**

---

## 4. Corley's Psychological State

Corley is **not defined by insanity.** She is a person in extreme psychological conflict after catastrophic
loss, imprisonment, experimentation, neurological alteration, and identity destruction.

Her mind contains competing truths — **four internal layers** (distinct from the four truth channels):

### 4.1 The Soldier

Mission · control · discipline · analysis. The trained self that still functions when everything else is
chaos. This layer is not a mask; it is genuinely her — but it cannot carry grief.

### 4.2 The Mother

Protection · attachment · love · responsibility. The center of the old unit and of her life. The layer most
wounded by the family killings and most dangerous to her because it makes her visitable.

### 4.3 The Prison Survivor

Suspicion · detachment · self-preservation · procedural violence. Forged on death row. It kept her alive and
it lies to her about what she deserves.

### 4.4 The Woman Beneath

Grief · fear · humor · need for connection. The part that was there before the legend and survived the
prison. This is the layer the reclamation arc is trying to reach without collapsing the others.

**Law.** The game should show the **conflict between these layers**, not one layer winning. A person who is
only The Soldier is a weapon; only The Mother is a wound; only The Prison Survivor is a monster; only The
Woman Beneath cannot survive the island. Reclamation = these layers authored into one person again.

**Frozen:** these are **not** multiple personalities and not dissociation-as-disorder. They are contextual
identities and defenses of one person (D028 §13), with visible seams and no implication of illness.

---

## 5. Inner Voice Doctrine

### 5.1 Not a constant narrator

Corley's inner voice is not a running commentary. **Silence is important.** The most powerful inner line is
often the one she does not say.

Use inner voice especially during:

- emotionally significant discoveries
- moral conflict
- memory triggers
- moments of isolation
- moments where SPOKEN CORLEY and INNER CORLEY contradict each other

### 5.2 Spoken vs inner contradiction (frozen device)

The signature move is the **gap between the two channels**:

> **Spoken:** *"Leave it."*
> **Inner:** *Don't touch it.*

> **Spoken:** *"I'm fine."*
> **Inner:** *I'm not sure I can keep standing.*

> **Spoken:** *(silence)*
> **Inner:** *Say her name. Say it.*

The player is given the truth of the interior **precisely because no one else can hear it.** This is the
inverse of the social-horror channel (§21): the player knows Corley better than any character on the island,
and that knowledge is a burden, not a power.

### 5.3 Reliability of INNER CORLEY

- INNER CORLEY is honest about how she feels.
- INNER CORLEY is **not** an omniscient narrator and can be wrong about facts, about others' motives, and
  about what she remembers.
- **Never** make INNER CORLEY lie about mechanical reality (BV-D151 truth rule). It may question
  interpretation, memory, identity, and causality; it may never mislead the player about input, save,
  inventory, damage, or interaction truth.
- The D015 "unreliable self-accounting" seed — Corley composing the story of a scene before it happens — is
  **kept faint and non-mechanical.** It must read as a character habit that *later* can be re-read as
  construction, never as a persistent liar-narrator.

### 5.4 Voice texture (D028 §14 preserved)

- **Spoken (early island):** concise · controlled · hard · emotionally withholding · dry · selectively
  profane · rarely explains herself.
- **Inner:** fear · tenderness · guilt · tactical cognition · suppressed maternal instinct · self-disgust ·
  dark humor · intrusive memory · doubt.
- The two voices must be **distinguishable in register**, so that silence, contradiction, and eventual
  convergence all land.

---

## 6. Corley's Humor

Humor is a **sign of identity persistence.** It is not decoration; it is evidence that the person before the
armor is still alive.

- Early island Corley has **almost none externally.**
- Humor **returns gradually.** The player should be able to notice, in sequence:
  1. the first dry remark
  2. the first sarcastic response
  3. the first genuine laugh
  4. the first time she jokes **without immediately suppressing it**
- Humor represents **the person before the armor returning.**

**Doctrine (D028 §15 preserved).** Humor arises from military culture, character, brutal timing, logical
absurdity, dry observation, later Shade literalism, and old-team familiarity. FORBIDDEN: Marvel-style
constant quips · tension-breaking comedy routines · self-aware genre jokes. Desired reaction: the player
unexpectedly laughs once, shakes their head, and the darkness resumes.

Humor is a **reclamation indicator**, not a mitigation of horror. A joke does not lower the tension; it
sharpens the loss when the tension returns.

---

## 7. Memory Bleed Doctrine

### 7.1 Definition

Memory Bleeds are **not traditional flashbacks.** They are ambiguous experiences in which **past and present
overlap**. The player must ask:
> **"What happened?"**
not:
> **"Was it fake?"**

### 7.2 Triggers (frozen anchors — D023 §14)

- PLACE (coastal approach corridor · F1 Gyle Cannery · the program facility)
- OBJECT (weapon · recording · uniform · the photograph)
- PERSON (the SECOND · a former teammate · a program casualty)
- SOUND (gunshot · radio transmission · a voice)
- CONDITION (cold · exhaustion · **Neural Strain HIGH**)

The trigger is **diegetic**; the player's relationship to the trigger shapes the bleed's content (a PERSON
the player saved yields different content than a PERSON the player killed).

### 7.3 Bleed categories (D015 §31 / D018 §21 — preserved)

| Bleed | Duration | Player experience |
|---|---|---|
| **MICRO BLEED** | seconds | present intact; a fragment intrudes — voice, face, gunshot, family fragment, prison sound, old teammate, replacement of a detail |
| **WALK-THROUGH BLEED** | minutes | movement/control kept while the present environment transforms (hospital→home; facility→prison; mine→old mission) |
| **INTERACTIVE BLEED** | event-length | walk / interact / speak / choose inside the event |
| **REALITY BREACH** | extremely rare | something from the bleed has **physical consequence afterward** — an object, a wound, new information, a changed environment, another witness |

Season pacing is a **significance curve, not a frequency curve**: ACT I MICRO → ACT II MICRO + early
WALK-THROUGH → ACT III WALK-THROUGH + INTERACTIVE → ACT IV INTERACTIVE + rare REALITY BREACH (BV-D111/D018).

### 7.4 A bleed is both a horror event and a character moment

D015 presents bleeds as authored **horror events**; D023 frames them as **character moments** (Pillar 1
IDENTITY). **D030 reconciles the two by holding both simultaneously:**

- The D015 §39 event contract still applies to every bleed: TRIGGER · PLAYER AGENCY · REALITY STATUS ·
  INFORMATION GAINED · REPLAY BEHAVIOR · CAN IT REPEAT · PHYSICAL AFTERMATH · NARRATIVE PURPOSE · COST TO
  HORROR BUDGET.
- Its **narrative purpose must always be Pillar IDENTITY** (or a pillar it serves): the bleed tells Corley —
  and the player — something about who she is or was. A bleed that is only frightening is a failure.

### 7.5 Bleeds are never a power

**Locked (D016 §23 / BV-D111):** bleeds are authored horror events the world authors. They are **never
Corley's ability.** Anomalous capability may *participate* in a bleed or ride its sensory distortion, but
**bleed content does not spawn from capability use** ("do not collapse the horror mystery into a skill
tree"). A bleed revealed as a usable "spell" is a stop-condition failure.

### 7.6 The mosaic rule

**Do not derive all bleeds from one mechanism.** Bleeds may originate from paranormal, conditioning, memory,
or anomalous substrates (D015 §31). The mosaic is deliberately open; the **origin of a given bleed stays
available to ambiguity** per §13.

---

## 8. Memory Rules (Reliability)

**Locked: Corley's memories are not randomly false.** The horror comes from:

- incomplete information
- manipulated context
- missing pieces
- unreliable interpretation

A memory may be **emotionally true while factually incomplete.**

> Corley remembers: *"I killed them."*
> Later, circumstances surface.
> The correct answer is **not** *"the memory was fake."*
> The correct answer is *"the memory was real, but she did not understand everything happening around it."*

### 8.1 Memory truth status (D015 §32 — preserved)

Every memory-bearing event is authored with an internal truth status of **REALITY / MEMORY / UNKNOWN**, and
with a **content status**:

- ACCURATE — happened as recalled
- CORRUPTED — happened, recalled wrongly
- INCOMPLETE — happened, key context missing (the default horror)
- IMPLANTED — did not happen, installed (rare, authored)
- MIXED TIMELINE — real fragments from different times fused

The player sometimes knows which layer they experienced, sometimes not. **This is contextual and diegetic,
never a UI label stamping every event.** When truth is determinable, the evidence is authored and legible;
when it cannot be, the ambiguity is the content.

### 8.2 The reliability bar (preserved)

D012's bar holds: **no later twist in which someone else did it, it was entirely hallucinated, or Corley was
framed for the killings.** Context may be revealed; exoneration may not. The family killings are real and
central (D028 §8). Guilt may be *complicated*; it may not be *cheaply erased*.

### 8.3 The damaged-source rule

> **Corley's memory is a damaged source, never an omniscient narrator.** (D014 preserved.)

This governs both the player's knowledge and Corley's self-accounting. The player is not handed a reliable
timeline; they reconstruct one, and the reconstruction is the experience.

---

## 9. The Compound

The Compound is **not a magical explanation.** It is a concrete fictional agent that affects:

- neurological adaptation
- perception
- stress response
- cognition
- anomalous capability emergence

**Rules:**

- Effects **vary by person**; different generations react differently (D029 §6.2).
- The Compound is **substrate and stabilizer**, never a psychic link and never telepathy (D029 §5).
- The Compound **explains a mechanism, not a moral absolution** (D028 §7). It does not erase
  responsibility.
- The Compound is **not a consumable buff.** It is a path with dependency and withdrawal cost (D016 §30).
- Withdrawal is a **generation-wide program failure** expressed individually; Corley's is the documented
  worst case, and she does not know the program caused it (D028 §7 / D029 §6.2).

---

## 10. Corley's Anomaly Origin

**D016 is preserved.** Corley did **not** have obvious telekinetic capability during Hidden Hand service.
Pre-collapse markers read as **latent sensitivity · extraordinary intuition · unresolved cause — never overt
TK** (D016 §11, D012 §12). OP HALF-LIGHT remains conventionally explainable (D014).

The anomaly **emerges from the interaction of**:

- long-term Compound exposure
- withdrawal
- Black Hand experimentation
- neurological adaptation
- extreme stress

The island environment may **accelerate or destabilize** expression.

**Locked boundaries:**
- The Hidden Hand photograph is the canon **trigger object** for the first undeniable anomalous event and the
  §25 SECOND confrontation (D028 / BV-D152). That is an in-world trigger, **not a causal power**.
- Corley's synchronization with her old unit was **emergent and relational** — the opposite of an anomaly
  power (D029 §5). The anomaly must never be retconned as the source of Hidden Hand synchronization.

---

## 11. Anomaly Philosophy

The ability should feel: **dangerous · unnatural · exhausting · intimate · frightening.**

It must **not** feel: superhero · magic · effortless.

The governing question is **not**:
> *"How powerful can she become?"*

It is:
> *"What does becoming this do to her?"*

**Preserved from D016 (do not restate as new):**
- "Dominate moments, not battlefields."
- HUMAN SKILL × ANOMALOUS ASSISTANCE × CONTEXT.
- The complete superhero-prevention matrix (NEVER / NOT-IN-S1 / POSSIBLE-LATER) and the Season-1 ceiling.
- Restrained, near-invisible visual language and audio vocabulary; no glowing hands, magic beams, giant
  energy circles, or superhero auras.
- **The stronger she becomes, the horror must not disappear.** Power should occasionally let her *perceive
  more horror*, not less.

**D030's addition is interpretive, not mechanical:** the anomaly is an **intimacy**, not an arsenal. Every
use is a small negotiation with a nervous system that was altered without consent. That is why the ability
belongs to the psychological-horror layer, not to the power-fantasy layer.

---

## 12. Neural Cost Philosophy

D016's cost model is authoritative; D030 adds the *experienced* reading. Three things must stay separate:

| Axis | Question | Experience |
|---|---|---|
| **CAPABILITY** | What can she influence? | "I can move that." |
| **CONTROL** | How precisely can she influence it? | "I can almost hold it." |
| **STRAIN** | What does using it do to her? | "This is taking something from me." |

**Locked:** no mana, no psychic energy points, no spendable rage bar. Costs are interconnected axes
(mass, range, complexity, target count, duration, environment, injury, concentration), read as a curve,
banded LOW / ELEVATED / HIGH / CRITICAL.

**High strain may cause (authored menu):** pain · exhaustion · sensory distortion · emotional instability ·
temporary loss of confidence · **increased intrusion vulnerability.**

**The bridge to horror (locked):** high Strain is when the psychological layer leaks — perceptual distortion
can carry a bleed, memory contamination, or an authored intrusion. **The cost is the mechanism by which the
inner world becomes intrusive.** It is authored and earned, never random.

**No exact mechanics here.** Numeric tuning, recovery curves, and capability classes are D016 territory.

---

## 13. Reality Ambiguity Rule

When strange events happen, **preserve multiple plausible interpretations. Do not immediately answer.**

> Corley hears: *"You should have died."*
> Possible interpretations: **memory · trauma · anomaly · external voice · manipulation.**

The game does not resolve the source at the moment of occurrence. Resolution, if any, is rare, late, and
authored.

**Rules:**

- Every ambiguous event carries **authored evidence** a player can later use — never a shrug, never a cheat.
- The mosaic (paranormal / conditioning / memory / anomalous) stays open; a given event may be unresolvable.
- The ultimate nature of the Darkness is **never resolved**, including at the Season-1 ending (D018 §35).
- Ambiguity is never used to **invalidate** the layers of §2 or the contract of §3.

---

## 14. Surviving Teammate (SECOND) — Architecture

D029 §26 owns his program history and relationship; **D030 owns his deep perceptual architecture.**

The SECOND is **not simply "crazy."** His damage is **different in kind** from Corley's and from the Shade's.

**Three wounds (frozen, D029 §26.2):**

| Who | Wound | The question they carry |
|---|---|---|
| **CORLEY** | identity and memory manipulated | *who am I?* |
| **SHADE** | agency and control stolen | *what does choice even mean?* |
| **SECOND** | perception and reality interpretation damaged | *which reality / present layer can I trust?* |

**Preserved traits (D029 §26):** the closest to The Hand historically · knew both Corley the woman and The
Hand the legend · survived BLACK HAND recovery/reconditioning but is profoundly altered · exceptionally
dangerous · capable of reading Corley's old habits · knows pieces of the truth before she does · appears
unstable/cryptic because his relationship to perception is damaged · buried loyalty and attachment · can hate
her and love her simultaneously · one of the only living people who can verify that the woman in the
photograph existed.

**Name: unresolved.** Do not casually name him (D029).

---

## 15. SECOND's Perception Damage

His BLACK HAND recovery process damaged his ability to **correctly integrate**:

- memory
- sensory information
- emotional state
- present environment

**He may experience:**

- overlapping memories
- pattern recognition beyond normal ability
- incorrect associations
- moments where past and present merge
- certainty about things he cannot prove

**The locked rule of his character:**

> **Sometimes he is wrong. Sometimes he is the only person who sees the truth.**
> **The player must learn not to dismiss him.**

### 15.1 What his damage is NOT

- It is **not** generic madness, evil, or villainy.
- It is **not** the same wound as Corley's (identity/memory) or the Shade's (agency).
- It is **not** an anomaly power he wields; his altered perception is a **wound first**.
- He is **not** a "mystery-perception plot device" that duplicates Corley's identity arc (D029 §26.2).

### 15.2 How his perception works as a design instrument

- His certainty is **evidence of experience, not proof of fact.** The player must weigh him.
- His pattern-recognition can surface true structure others miss; his incorrect associations can manufacture
  false structure with equal conviction. **The player cannot tell which from his delivery alone** — only from
  the world.
- When he contradicts OBSERVABLE REALITY, the conflict is the content; the world layer stays authoritative
  for mechanics, while *meaning* stays contested.
- He may be the **only** witness to a truth, which forces the player to hold an unresolved claim in trust.

### 15.3 His limit

His perception is **damaged, not omniscient.** He does not become a reliable oracle, cannot see through walls
or time, and cannot guarantee prediction. D007 sensing truth remains authoritative.

### 15.4 Disambiguation (word discipline)

- **"perceptual intrusion"** = a D016 anomalous **capability** — not his damage.
- **"memory intrusion"** = a Neural Strain **symptom** — not his damage.
- **"intrusion channel" (`INTRUSION_OR_UNKNOWN`)** = the D030 narrative **layer** — not his damage.
- His condition is described as **"perception/reality-integration damage"** to avoid all three collisions.

---

## 16. SECOND and Corley

Their relationship should **hurt because both are right and wrong.**

**He remembers:** who she was · what she meant · what happened to the unit.
**He also believes:** she abandoned them · she failed them · she became something else.

**Corley believes:** she failed everyone · she caused destruction · she cannot trust herself.

Their conflict is **not** hero vs villain. It is:

> **two damaged survivors carrying incomplete truths.**

**Rules:**

- Neither is simply correct. The scene must let both positions be partially true.
- He is the **old mirror** (D023): he reflects the person she was, which is precisely what she cannot look at.
- His hate and his love are simultaneous and real.
- Reconciliation is not a switch; it is sequential and partial (D029 / doctrine §25 scene-lock preserved:
  UNRESOLVED → HOSTILE → RECOGNITION → RECIPROCITY → RECONCILIATION → BROTHERHOOD).
- The **photograph** is the recognition object: the physical proof that the woman and the team existed, held
  by both of them (D028 / D029 §26.1).

---

## 17. Anomaly and SECOND Connection

**Do not finalize whether their conditions share a direct origin.**

Preserve the possibilities:

- same Compound adaptation, different expressions
- Black Hand experimentation with different outcomes
- unknown island factor
- coincidence (two damaged people whose damage rhymes)

**The uncertainty is intentional.** It is a standing `REQUIRES_FUTURE_DECISION`. D030 must not assert a
shared substrate, because doing so would resolve a mystery the horror layer depends on.

**Contrast preserved (D029 §26.2):** their arcs **complement, not duplicate.** His is not locked to
"anomaly"; hers is not locked to "perception."

---

## 18. Shade Psychological Separation

D023 and D029 own the Shade; D030 states the psychological distinction so the three damage-model do not blur.

**Locked:** the Shade's wound is **agency and control stolen.** His question is *what does choice even mean?*

**Preserved from D023:**
- The Shade is **not a robot**; the person is still inside.
- Override **suppresses but does not destroy** sensory input, emotional response, memory storage, and
  preference.
- **The horror is the GAP** between the person's interior and the override: "The person is still inside. The
  armor is advanced. The weapon is real. The person is real. They are separate."
- "The Shade was never evil. He was OWNED."
- Reclamation stages (Awaiting command → Why did you spare me? → I don't understand choice → I am not your
  weapon → I choose) are **iterative, not linear.**
- The Shade is a **damaged person recovering identity**, not a summon, helper, or upgrade.
- Memory is **suppressed, not erased**: he may recognize people he cannot remember emotionally (§21).

**D030's distinction:** the Shade's damage is about **will and ownership**, not about the reliability of
reality. He and the SECOND are opposite instruments — the SECOND cannot trust *which* reality; the Shade
cannot trust *whether his own action was his.* Corley sits between them: she cannot trust *who she is.*

---

## 19. Horror Through Relationships

The strongest horror is not monsters. It is:

- seeing the Shade recognize people he cannot remember emotionally
- seeing the SECOND remember things Corley cannot
- seeing Corley discover her family was manipulated
- seeing old friends become strangers
- seeing human beings treated as replaceable systems

**Law.** Horror escalates through **relationship damage**, not threat volume. The human and human-adjacent
remain numerically dominant; the anomalous is punctuation, never the paragraph (D015 §40).

---

## 20. Psychological Horror Escalation

Season-1 question progression (locked):

| Stage | Question |
|---|---|
| **Beginning** | *"What happened to me?"* |
| **Middle** | *"What did they do to me?"* |
| **Later** | *"What parts of myself did they change?"* |
| **End** | *"Who am I choosing to become?"* |

**Law.** Escalation is in **knowledge, interpretation, and relationship**, not in frequency or power.
"Rising significance, not frequency" (D018 §21 / BV-D111). The anomalous pacing must never outrun
conventional reclamation (D018).

---

## 21. The Central Question

Every major arc reinforces:

> **If someone changes everything about you — your memories, your body, your purpose, your relationships —
> what remains that is truly yours?**

Answers (locked):

- **Corley:** *Choice.*
- **Shade:** *Choice.*
- **SECOND:** *Perception.*

**Reconciliation with the pillars (doctrine §34 — preserved, not replaced):**
IDENTITY (who was I / what did they change / which memories are real) · BROTHERHOOD (was the unit false, or
merely the institution controlling it) · RESPONSIBILITY (even if manipulated, what remains mine). The
central question is a **synthesis on Pillar IDENTITY**, extended to the two mirrors; it does not replace the
three pillars.

**Why the answers differ (locked):** Corley and the Shade both land on *choice* because both were remade and
both must author themselves anyway. The SECOND lands on *perception* because his wound is that the raw
material of choice — a stable reality — is what was taken. Their arcs must not collapse into one another.

---

## 22. Boundaries — What D030 Does Not Do

- No `game/` modifications, no systems, no combat, no anomaly powers, no Shade code, no AI.
- No dialogue implementation, no voice assets, no cinematics.
- No memory mechanic, no sanity mechanic, no meter, no diagnosis UI.
- No new anomaly capability; D016 taxonomy untouched.
- No resolution of the Darkness, the anomaly origin, or the anomaly/SECOND substrate.
- No naming of the SECOND.
- No new memory-truth disclosure that would exonerate Corley.

---

## 23. Canon Audit — Conflicts & Supersession Matrix

Classification: UNCHANGED / REINTERPRETED / SUPERSEDED / REQUIRES_FUTURE_DECISION.

### 23.1 Four layers / trust

| Item | Source | Old statement | D030 canon | Class |
|---|---|---|---|---|
| Four channels | BV-D151; `narrative_channels.gd` | OBSERVABLE_REALITY / SPOKEN_CORLEY / INNER_CORLEY / INTRUSION_OR_UNKNOWN | adopted verbatim + psychological semantics | UNCHANGED |
| Inner-channel isolation | BV-D151; D028 §14 | NPCs never hear inner Corley | preserved | UNCHANGED |
| Fairness law | D015 §30 | input/save/HUD trustworthy; never mimic bugs | preserved as master contract | UNCHANGED |
| WORLD/PERCEIVED overlay split | BV-SKILL-015/018 | tools never lie; world may | preserved; composes with four channels | UNCHANGED |
| Sanity meter | (absent) | — | explicitly forbidden | UNCHANGED (new, no conflict) |
| Inner-reliability | D015 §48 seam #5 | unreliable self-accounting (faint) | kept faint; inner may err on interpretation, never mechanics | REINTERPRETED |

### 23.2 Memory

| Item | Source | Old statement | D030 canon | Class |
|---|---|---|---|---|
| Bleed categories | D015 §31; D018 §21 | MICRO / WALK-THROUGH / INTERACTIVE / REALITY BREACH | preserved | UNCHANGED |
| Bleed ≠ power | D016 §23; BV-D111 | bleeds never the Hand's ability | preserved; capability may participate but not spawn | UNCHANGED |
| Bleed as character moment | D023 §14 | bleed is Pillar IDENTITY character moment, not horror event | reconciled: it is a horror event **whose purpose is the character moment** | REINTERPRETED |
| Memory not randomly false | D012 §23 bar; D014 | no hallucination/framing twist; damaged source | preserved; adds content-status taxonomy | UNCHANGED |
| Memory truth levels | D015 §32 | REALITY / MEMORY / UNKNOWN | preserved; adds ACCURATE/CORRUPTED/INCOMPLETE/IMPLANTED/MIXED | REINTERPRETED |
| Mosaic rule | D015 §31 | do not derive all bleeds from one mechanism | preserved | UNCHANGED |

### 23.3 Compound / anomaly

| Item | Source | Old statement | D030 canon | Class |
|---|---|---|---|---|
| Compound effects | doctrine §16–§20 | neurological/perceptual/cognitive; not magic | preserved; not absolution; varies by generation | UNCHANGED |
| Anomaly origin | D016; D012 §12 | Compound + withdrawal + experimentation + adaptation + stress | preserved; island may accelerate/destabilize | UNCHANGED |
| Anomaly taxonomy | D016 (BV-D087…BV-D095) | full taxonomy + prevention matrix | untouched; D030 adds interpretive layer only | UNCHANGED |
| Capability/Control/Strain | D016 §3–§5 | three-axis, no mana | preserved | UNCHANGED |
| First undeniable event | D016 §11; D018 §9 | earned, desperate, photograph-triggered | preserved; "intimacy not arsenal" reading added | REINTERPRETED |
| Anomaly origin resolution | BV-D057 | interpretations none canonical | preserved; unresolved | UNCHANGED |

### 23.4 Teammate / Shade

| Item | Source | Old statement | D030 canon | Class |
|---|---|---|---|---|
| SECOND's wound = perception | D029 §26.2 | perception/reality interpretation damaged | deep architecture defined (integration failure; overlapping memories; pattern recognition; false certainty) | REINTERPRETED |
| SECOND's deep mechanics | D029 (deferred) | deferred to D030 | now owned by D030 §15 | UNCHANGED (ownership fulfilled) |
| Anomaly ↔ SECOND substrate | D029 (deferred) | unresolved | intentionally left open | REQUIRES_FUTURE_DECISION |
| SECOND's name | D029 | deferred | remains deferred | REQUIRES_FUTURE_DECISION |
| Shade wound = agency | D023; D029 §26.2 | agency/control stolen; person still inside | preserved; psychological separation stated | UNCHANGED |
| Three-wound model | D029 §26.2 | Corley/Shade/SECOND distinct | preserved; used as organizing law | UNCHANGED |

### 23.5 Framing / gender

| Item | Source | Old statement | D030 canon | Class |
|---|---|---|---|---|
| Male-coded protagonist prose | D015/D017/D025 + doctrine §14–§41 | "he/him", "a broken man", beard channel | non-authoritative where conflicting; D030 uses she/her; legacy prose not edited | SUPERSEDED (by D028) |
| Central pillars | doctrine §34 | IDENTITY / BROTHERHOOD / RESPONSIBILITY | preserved; central question is a synthesis, not a replacement | UNCHANGED |
| "What remains truly yours" | (new) | — | adopted as the D030 central question | UNCHANGED (new, no conflict) |

---

## 24. Contradictions Unresolved (escalated, not silently resolved)

1. **Whether Corley's and the SECOND's conditions share a neurological substrate** (same Compound adaptation
   / different experiments / island factor / coincidence). → future authoring; intentionally open.
2. **The SECOND's name** and whether he was recovered/reconditioned vs escaped. → D031 / later.
3. **The full biological mechanism of the lineage/children program** and its psychological inheritance. →
   D031 / future saga.
4. **The origin of a given bleed's substrate** (paranormal vs conditioning vs memory vs anomalous) — mosaic
   deliberately open per event.
5. **The ultimate nature of the Darkness** — never resolved (D018 §35).
6. **Whether INNER CORLEY's "composed story before it happens" habit is ever re-read as construction** —
   kept faint; decision deferred.

---

## 25. Deliverable Checklist (self-verification against D030)

1. four truth layers — §2
2. Corley psychology — §4
3. inner voice doctrine — §5
4. Memory Bleed rules — §7
5. Compound interpretation — §9
6. anomaly origin — §10
7. anomaly philosophy — §11
8. neural cost philosophy — §12
9. SECOND perception architecture — §14, §15
10. Corley/SECOND relationship — §16
11. Shade psychological separation — §18
12. reality ambiguity rules — §13
13. horror escalation — §20
14. player trust contract — §3
15. contradiction matrix — §23, §24

**Completion test:**

> BLACK VECTOR has a consistent psychological framework where the player questions reality, memory, and
> identity while still trusting the game world and their own agency.

---

*Design/canon only. No gameplay code changed; no commit. D030 owns psychological horror / inner voice /
memory reliability / anomaly reconciliation and the SECOND's deep perceptual architecture. D031 owns the
Season-1 reveal staging. After D031, lore expansion stops and production resumes (Production Slice P1 —
Strand → Gyle Cannery).*
