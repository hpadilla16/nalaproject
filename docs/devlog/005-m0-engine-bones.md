# 005 — M0 engine bones

Coding-expert landed M0 per the dispatch in 003. The Godot 4 project boots
from `godot/project.godot` into `scenes/main.tscn`, which loads the
mortality tunables, decides between resume-from-save and fresh-descent,
then hands off to `SceneRouter`. Five autoload singletons own the
run-time concerns: `RunStateRegistry` holds the in-memory `RunState`,
`MortalityClock` drives passive bleed at the rate set by
`MortalityTunables` (`.tres` per §24.4), `LedgerState` is the only writer
to the append-only Sin and Redemption arrays per §4.3, `SaveSystem`
round-trips the whole `RunState` to `user://savegame.tres`, and
`SceneRouter` centralizes scene transitions and saves at every door. The
protagonist (top-down 2D `CharacterBody2D` with a `Camera2D` child,
8-direction normalized movement, 140 px/s placeholder) lives at
`scenes/characters/protagonist/protagonist.tscn`; two test scenes
(`scenes/test/scene_a.tscn` and `scene_b.tscn`) plus a reusable
`scenes/world/portal.tscn` validate the transition harness. The
Bond-Scarf is intentionally absent per §4.6; names and pronouns default
to empty / `UNDEFINED` per §22, since character-create lands in M2+.
Verify by opening `godot/project.godot` in Godot 4.6.2 and pressing F5:
scene_a should load, WASD or arrows move the player, walking into the
blue portal switches to scene_b. Closing and reopening the editor should
resume in whichever scene the player last left. Next move belongs to the
lead PM: file M1 (Mortality HUD, Ledger HUD, dialogue runner skeleton).
