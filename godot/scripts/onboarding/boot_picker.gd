extends Control

## Continue / new-run picker. Shown at boot if a save exists.
## Two buttons: "Continue" resumes the saved run, "New run" resets state
## and starts character-create.

@onready var _continue_button: Button = %ContinueButton
@onready var _new_run_button: Button = %NewRunButton
@onready var _confirm_dialog: ConfirmationDialog = %ConfirmDialog


func _ready() -> void:
	_continue_button.pressed.connect(_on_continue_pressed)
	_new_run_button.pressed.connect(_on_new_run_pressed)
	_confirm_dialog.confirmed.connect(_on_new_run_confirmed)
	SaveSystem.load_completed.connect(_on_save_loaded)


func _on_continue_pressed() -> void:
	# Load the save and wait for load_completed signal to route.
	SaveSystem.load_save()


func _on_save_loaded(_state: RunState) -> void:
	# Resume at the saved scene.
	var saved_scene: String = RunStateRegistry.run_state.current_scene_path
	if saved_scene != "":
		SceneRouter.transition_to(saved_scene)
	else:
		# Fallback if save has no scene (shouldn't happen, but be safe)
		SceneRouter.transition_to("res://scenes/test/scene_a.tscn")


func _on_new_run_pressed() -> void:
	_confirm_dialog.popup_centered()


func _on_new_run_confirmed() -> void:
	# Delete the save and reset state.
	if SaveSystem.has_save():
		var err: int = DirAccess.remove_absolute(SaveSystem.SAVE_PATH)
		if err != OK:
			push_error("BootPicker: failed to delete save (error %d)" % err)
	RunStateRegistry.reset_for_new_descent(load(RunStateRegistry.MORTALITY_TUNABLES_PATH) as MortalityTunables)
	SceneRouter.transition_to("res://scenes/onboarding/content_note.tscn")
