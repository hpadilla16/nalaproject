extends Node

## Boot scene script. Runs once at game start (project.godot points
## run/main_scene at scenes/main.tscn). Decides whether to resume a saved
## descent or to start a fresh one, then hands off to SceneRouter and
## leaves the tree.

const TUNABLES_PATH: String = "res://resources/tunables/mortality_tunables.tres"
const DEFAULT_FIRST_SCENE: String = "res://scenes/test/scene_a.tscn"


func _ready() -> void:
	var tunables: MortalityTunables = load(TUNABLES_PATH) as MortalityTunables
	if tunables == null:
		push_error("Main: failed to load mortality tunables at %s" % TUNABLES_PATH)
		return

	# M0 has no per-circle awareness, so use the prologue bleed rate as the
	# baseline. M1+ will set this per-scene as the player crosses circle
	# thresholds.
	MortalityClock.set_bleed_rate(tunables.bleed_prologue)

	if SaveSystem.has_save():
		SaveSystem.load_save()
		var saved_scene: String = RunStateRegistry.run_state.current_scene_path
		if saved_scene != "":
			SceneRouter.transition_to(saved_scene)
			return
		# Save existed but had no scene path. Fall through to a fresh descent.

	RunStateRegistry.reset_for_new_descent(tunables)
	SceneRouter.transition_to(DEFAULT_FIRST_SCENE)
