# 003 — M0 dispatch: engine bones to coding-expert

Lead PM dispatched M0 (engine bones) to `coding-expert`. Scope: Godot 4
project boots from `godot/project.godot`, player movement, camera follow,
two test scenes with a transition harness, save/load roundtripping a stub
state, no content. Tunable values authored as `.tres` resources under
`godot/resources/tunables/` from day one so the §24.4 tuning pass slots in
later without refactoring. Estimated three to five days. Unblocks M1
(system scaffolds) and indirectly all later milestones in the Part 1
vertical slice (Prologue → Lust grotto). The two §24.5 calls flagged in
entries 001 and 002 are independent of M0 and target M2; surfacing them
now means they can be resolved while M0 and M1 are in flight. No new open
questions in this dispatch. The M0 brief itself was delivered to Hector
inline; if `coding-expert` finishes M0 fast and wants to bleed into M1,
file the next move as a separate dispatch rather than quietly grow scope.
