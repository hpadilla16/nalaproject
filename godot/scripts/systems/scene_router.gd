extends Node

## Autoload. The only thing that calls get_tree().change_scene_to_*().
## Centralizing scene transitions here means:
##   1. We can save the run state at every transition without scattering
##      SaveSystem.save() calls all over the codebase.
##   2. We can play transition effects (fade-out, fade-in) in one place
##      later without rewiring every door.
##   3. The "spawn at this Marker2D after the transition" pattern works
##      consistently across every scene.
##
## Doors / portals call `transition_to(path, spawn_marker_name)` and trust
## this autoload to handle the rest.

signal transition_started(target_scene_path: String)
signal transition_completed(target_scene_path: String)

## Persistent across scene changes -- where to put the player after the
## next scene loads. Read by the protagonist's _ready(). Empty means
## "fall through to saved position or scene-authored default." Portals
## set this to "PlayerSpawn" (or a custom marker name) before triggering
## the transition.
var pending_spawn_marker: String = ""

## Engine-internal: the path we are currently transitioning to. Used to
## suppress duplicate transitions if a portal fires twice in the same frame.
var _in_flight_target: String = ""


func transition_to(scene_path: String, spawn_marker_name: String = "") -> void:
	if scene_path == _in_flight_target:
		return
	_in_flight_target = scene_path
	pending_spawn_marker = spawn_marker_name
	# Persist before we tear down the current scene.
	RunStateRegistry.run_state.current_scene_path = scene_path
	SaveSystem.save()
	emit_signal("transition_started", scene_path)
	# Defer the actual change so callers (e.g. portal Area2D body_entered)
	# get to finish their frame first. Without this, Godot will yell about
	# changing scene from inside a physics callback.
	call_deferred("_do_change_scene", scene_path)


func _do_change_scene(scene_path: String) -> void:
	var err: int = get_tree().change_scene_to_file(scene_path)
	if err != OK:
		push_error("SceneRouter: change_scene_to_file failed for %s with error %d" % [scene_path, err])
		_in_flight_target = ""
		return
	# change_scene_to_file is itself deferred; emit completion on the next frame.
	await get_tree().process_frame
	_in_flight_target = ""
	emit_signal("transition_completed", scene_path)
