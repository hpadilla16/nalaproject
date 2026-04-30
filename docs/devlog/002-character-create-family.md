# 002 — Character-create family composition (open)

Lead PM is dispatching M0 to `coding-expert`. M2 will ship the
character-create flow (§22), which asks the player for name, pronouns, and
family composition. The family composition matters specifically because
Caina (§10) reflects whichever family the player describes — only mother,
only parents, parents and siblings, chosen family, etc. §24.5 is open on
the granularity: a free-text "describe your family briefly" field, a small
set of preset options, or a hybrid (presets plus an "other" free-text). The
choice affects how Caina's family-in-the-ice scene generates its sprites
(via `pixel-art-sprite-expert`) and its dialogue (§25). Decision needed
before M2 wires character-create. Sub-question worth flagging: whether
"chosen family" is a preset — the protagonist's wound is family abandonment
(§2), and a chosen-family option carries its own resonance in Caina that
the bible has not yet specified. Recommend bringing this to a writer-led
review alongside the family-composition decision.

**Resolved 2026-04-30:** Family composition uses a preset list, no
free-text input. The exact preset roster is finalized in the M2
character-create dispatch (writer + ui-ux call), but the working set is:
mother only, father only, both parents, parents and siblings, chosen
family. Each preset maps to a known Caina (§10) sprite combination
authored by `pixel-art-sprite-expert` and a dialogue branch authored
under §25.3. No free-text fallback — every Caina branch needs specific
sprites and specific mouthed-words variants per §23.3, and free-text
entries cannot be authored on the fly.

**Sub-question resolved 2026-04-30:** "Chosen family" (close friends
instead of blood relatives) IS included as a preset. This is a small
bible expansion: §10 (Caina) and §25.3 (Caina dialogue script) need a
chosen-family branch in which the figures frozen in the ice are friends,
not relatives — and the protagonist's wound (§2) widens from "abandoned
by blood family" to "abandoned by the people who should have stayed."
Flag for the next writer-led pass on §10 and §25 to draft the
chosen-family ice scene and the four mouthed-words variants per §23.3
(kind / hard / cruel / refused). Until that writer pass lands, the
chosen-family preset ships in M2 character-create with placeholder
sprites and a placeholder dialogue branch that mirrors blood-family
shape with friend-coded mouthed words.

Bible §24.5 should mark both this question and the chosen-family
sub-question closed when next updated. M2 character-create can wire the
family-composition step with the preset list above.
