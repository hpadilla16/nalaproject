extends CharacterBody2D

## The protagonist (Bible §2). Top-down 2D, 8-direction movement.
##
## M0 placeholder behavior. The Bond-Scarf is intentionally NOT a child of
## this scene -- per coding-expert house rules and §4.6, it must not exist
## as an in-scene node during the prologue. It first appears when Nala
## drops it in Limbo (Beat 8.5, §6).
##
## Movement speed is hardcoded at M0 because there is no tunable yet for
## locomotion. When the §24.4 mechanical-tuning pass lands, this becomes
## a value on a LocomotionTunables resource.

const MOVE_SPEED: float = 140.0   ## pixels/sec -- placeholder, see note above.

@onready var _camera: Camera2D = $Camera2D


func _ready() -> void:
	_camera.make_current()
	_apply_spawn()


func _physics_process(_delta: float) -> void:
	var input_vector: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down"),
	)
	# Normalize so 8-direction input does not move faster diagonally.
	if input_vector.length_squared() > 1.0:
		input_vector = input_vector.normalized()
	velocity = input_vector * MOVE_SPEED
	move_and_slide()
	# Keep RunStateRegistry's idea of where we are in sync, so that if the
	# game crashes between transitions the next save still has a sane spawn.
	# Cheap: one Vector2 write per physics tick.
	RunStateRegistry.run_state.current_position = global_position


## Decide where this protagonist instance starts. Three cases, in order:
##   1. SceneRouter has a pending spawn marker -> we just came through a portal.
##   2. The saved current_scene_path matches this scene -> resume from save.
##   3. Otherwise -> trust whatever position the .tscn placed us at, falling
##      back to a "PlayerSpawn" Marker2D if one exists.
func _apply_spawn() -> void:
	var marker_name: String = SceneRouter.pending_spawn_marker
	if marker_name != "":
		if _try_snap_to_marker(marker_name):
			SceneRouter.pending_spawn_marker = ""
			return
	var saved_scene: String = RunStateRegistry.run_state.current_scene_path
	var current_path: String = ""
	var sn: Node = get_tree().current_scene
	if sn != null:
		current_path = sn.scene_file_path
	var saved_pos: Vector2 = RunStateRegistry.run_state.current_position
	if saved_scene == current_path and saved_pos != Vector2.ZERO:
		global_position = saved_pos
		return
	_try_snap_to_marker("PlayerSpawn")


func _try_snap_to_marker(marker_name: String) -> bool:
	var sn: Node = get_tree().current_scene
	if sn == null:
		return false
	var spawn: Node = sn.find_child(marker_name, true, false)
	if spawn is Marker2D:
		global_position = (spawn as Marker2D).global_position
		return true
	return false
