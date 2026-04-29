extends Area2D
class_name Portal

## A reusable scene-transition trigger. When the protagonist's
## CharacterBody2D enters this Area2D, it calls SceneRouter.transition_to()
## with the configured target. Authored as one scene so doors / circle
## entrances / pocket exits can all instance it and override the target
## via the inspector.

## res:// path to the scene to load when the player enters this portal.
## Required -- portals with no target push a warning at runtime.
@export_file("*.tscn") var target_scene_path: String = ""

## Marker2D name in the target scene where the protagonist should appear
## after transition. Defaults to "PlayerSpawn", which every test scene
## provides; circles will provide named markers ("FromLimbo", "FromGreed",
## etc.) so the player arrives at the appropriate threshold.
@export var target_spawn_marker: String = "PlayerSpawn"


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return
	if target_scene_path == "":
		push_warning("Portal at %s has no target_scene_path set" % str(get_path()))
		return
	SceneRouter.transition_to(target_scene_path, target_spawn_marker)
