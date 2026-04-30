# 006 — M1 dispatch: system scaffolds to coding-expert + ui-ux-expert

Lead PM dispatched M1 (system scaffolds) jointly to `coding-expert` and
`ui-ux-expert`. Three deliverables. First, a Mortality HUD per §4.4 — a
bleeding clock, persistent on the player HUD, no numeric readout, three
visual states (passive bleed, active bleed during compassion or rescue,
critical under ~10%) distinguished by gradient and shape per the §23.8
colorblind-considerate rule; tick SFX deferred to `elevenlabs-sfx-expert`.
The autoload already emits `mortality_changed`, `mortality_low`, and
`mortality_exhausted` — M1 just listens. Second, a Ledger HUD per §4.3 —
two columns of repeated abstract glyphs (Sin left, Redemption right),
button-pulled with a single hotkey, small column-flash when `LedgerState`
emits `sin_recorded` or `redemption_recorded`, no auto-pop in M1 (the §10.7
Mirror Moment auto-surface is M3 work). Third, a dialogue runner skeleton
under `godot/scripts/systems/dialogue/` consuming `.tres`
`DialogueResource` files from `godot/resources/dialogue/`: typewriter at
readable pace (no hammer-confirm), discreet speaker label that can be
suppressed for the Tree, the Family, and the Self-Blasphemer per
§11/§10/§29, advances on input, emits `dialogue_finished` on completion.
Coding-expert owns the GDScript wiring, the runner script, and the
`DialogueResource` schema; ui-ux-expert owns layout, motion, typography,
and the placeholder glyph spec under `godot/scenes/ui/`. Acceptance is a
debug panel inside the existing `scene_a` test scene that proves all three:
mortality bleeds visibly and crosses into the critical state when forced;
sin and redemption hotkeys flash the appropriate column and add a glyph;
a two-line `_test.tres` plays through the runner and emits its finished
signal. Out of scope: character-create (§22, M2), Bond-Scarf rendering
(§4.6 — must stay invisible until Limbo), the Class Stone overlay (§4.8),
the Wager prompt (§13.1), the wake-up title card (§31), the pre-game
content note (§26), final UI raster art (deferred to
`pixel-art-sprite-expert`), and audio. Estimate four to six days, with
ui-ux-expert and coding-expert work parallelizable. Unblocks M2
(character-create + Class Stone overlay + Wager prompt) and the Prologue
blockout. The two long-parked open questions (`001-class-stone-default`,
`002-character-create-family`) remain M2-targeted; resolving them is not
required to start M1. No new open questions in this dispatch.
