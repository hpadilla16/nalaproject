extends Node

## Autoload. Owns I/O for the run state. Reads/writes a single .tres at
## user://savegame.tres -- one save slot, no manual save UI in M0. Future
## work (per §24.5 open question) is whether to allow multiple slots; for
## now there is one save and any new descent overwrites it.
##
## Resource-based saves are clean for typed data: ResourceSaver handles the
## serialization, ResourceLoader handles deserialization, and the schema
## migration field (RunState.schema_version) is the hook for future
## breaking changes.

signal save_completed()
signal save_failed(error: int)
signal load_completed(state: RunState)
signal load_failed(error: int)
signal no_save_found()

const SAVE_PATH: String = "user://savegame.tres"


func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)


## Snapshot the current RunState (from RunStateRegistry) and write it.
## Called at every scene transition by SceneRouter. Cheap -- one disk write
## per door is fine for a top-down 2D narrative game.
func save() -> void:
	var state: RunState = RunStateRegistry.run_state
	var err: int = ResourceSaver.save(state, SAVE_PATH)
	if err == OK:
		emit_signal("save_completed")
	else:
		emit_signal("save_failed", err)


## Read the save into RunStateRegistry. Emits no_save_found if the file
## does not exist; callers should treat that as "start a fresh descent."
func load_save() -> void:
	if not has_save():
		emit_signal("no_save_found")
		return
	var resource: Resource = ResourceLoader.load(SAVE_PATH, "RunState", ResourceLoader.CACHE_MODE_IGNORE)
	if resource == null or not resource is RunState:
		emit_signal("load_failed", FAILED)
		return
	var state: RunState = resource as RunState
	RunStateRegistry.replace(state)
	emit_signal("load_completed", state)
