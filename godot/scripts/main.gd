extends Node

## Boot scene script. Runs once at game start (project.godot points
## run/main_scene at scenes/main.tscn). Loads tunables, sets baseline
## bleed rate, then routes to onboarding (boot_picker if save exists,
## else content_note) or resumes a saved descent. Hands off to SceneRouter
## and leaves the tree.


func _ready() -> void:
	var tunables: MortalityTunables = load(RunStateRegistry.MORTALITY_TUNABLES_PATH) as MortalityTunables
	if tunables == null:
		push_error("Main: failed to load mortality tunables")
		return

	# M0 has no per-circle awareness, so use the prologue bleed rate as the
	# baseline. M1+ will set this per-scene as the player crosses circle
	# thresholds.
	MortalityClock.set_bleed_rate(tunables.bleed_prologue)

	# M2: check for a saved run. If one exists and has a scene path, resume it.
	# Otherwise, route to onboarding (boot_picker if save exists, else content_note).
	if SaveSystem.has_save():
		SaveSystem.load_save()
		var saved_scene: String = RunStateRegistry.run_state.current_scene_path
		if saved_scene != "":
			SceneRouter.transition_to(saved_scene)
			return

	# No valid save or save corrupted; start onboarding flow.
	SceneRouter.route_to_onboarding()
