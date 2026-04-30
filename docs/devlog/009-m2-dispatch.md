# 009 — M2 dispatch: content note, character-create, Class Stone

Lead PM dispatched M2 (boot flow up to Limbo Class Stone) jointly to
`coding-expert` and `ui-ux-expert`. The two open questions filed under
M0 (`001-class-stone-default`, `002-character-create-family`) are now
resolved and feed directly into this scope. Three deliverables. First,
the pre-game content note per §26 — single-screen, plain background,
no music, single "I understand." continue button, shipping with §26's
drafted text verbatim as a placeholder; the §24.2 sensitivity-read pass
with a mental health consultant is still owed and may tighten the
wording before final ship. Second, character-create per §22 — name
(text entry, name displays as typed, no Continue until something is
filled), pronouns (he/him, she/her, they/them, plus "other" backed by
the existing `CharacterProfile.Pronouns.OTHER` enum and `pronouns_custom`
free-text field), family composition as a preset list per resolved 002
(mother only, father only, both parents, parents and siblings, chosen
family — coding-expert migrates `CharacterProfile.family: Array[String]`
to a typed preset enum, with the chosen-family preset shipping with a
placeholder Caina branch pending the writer-led §10/§25.3 pass).
Defaults gentle, not assertive. Third, the Class Stone overlay per §4.8
— three weathered stone shapes (Sword default-highlighted per resolved
001, Staff and Shield flanking in symmetric framing), confirm overlay
before commit, chosen shape dissolves into the protagonist on select,
choice persists into `RunState`. The boot flow chains together: launch
→ continue-or-new-run picker (one save slot per §24.6) → content note
(new run only) → character-create → Class Stone → hand off to a `scene_a`
placeholder until M3 produces the actual Prologue Beats 1–10. Acceptance
is a fresh-descent boot that captures and persists every choice across
save and reload. Out of scope: voice acting and any audio (deferred to
`elevenlabs-sfx-expert` in M3+), the Wager prompt (§13.1, deferred to
M3 with the rescue mechanic in Gluttony), the wake-up cinematic title
card (§31), the Bond-Scarf (§4.6, must stay invisible until Limbo Beat
8.5 in actual content production), Caina chosen-family sprites (need
the writer pass on §10/§25.3 first), and the Prologue scene content
itself (§6, M3 content production). Coding-expert owns the
`CharacterProfile` schema migration, the boot-flow scene chain, the
save/continue picker, and the Class Stone selection persistence;
ui-ux-expert owns the content note layout, the character-create flow
typography and motion, and the three-stone overlay visuals. Estimate
four to six days, parallelizable. Unblocks M3 (Prologue scene
production + Lust grotto vertical slice). No new open questions; the
chosen-family bible expansion remains parked pending the writer-led
pass on §10 and §25.3.
