extends Control

## Class Stone choice scene per §4.8. Three weathered stone shapes.
## Sword is default-highlighted per resolved 001. Selection model: arrow keys
## move focus, Enter / click commits. Confirm overlay before persisting choice.
##
## Class Stone is in M2 boot flow as a temporary placement; M3 will reposition
## it inside Limbo Beat 8.5 per §4.8 once the Prologue scene content lands.

@onready var _sword_stone: Control = %SwordStone
@onready var _staff_stone: Control = %StaffStone
@onready var _shield_stone: Control = %ShieldStone
@onready var _confirm_dialog: ConfirmationDialog = %ConfirmDialog

var _stones: Array[Control]
# The HBox in class_stone.tscn lays the stones out left-to-right as
# Staff, Sword, Shield. Mirror that order here so arrow keys move focus in
# the visual direction the player presses. Sword sits at index 1, the
# default-highlighted center per resolved 001.
var _current_selection: int = 1
var _pending_choice: RunState.ClassChoice = RunState.ClassChoice.UNDEFINED


func _ready() -> void:
	_stones = [_staff_stone, _sword_stone, _shield_stone]

	for i in range(_stones.size()):
		_stones[i].gui_input.connect(_on_stone_gui_input.bindv([i]))

	_confirm_dialog.confirmed.connect(_on_confirm_yes)
	_confirm_dialog.canceled.connect(_on_confirm_cancel)

	_update_focus()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		_current_selection = maxi(_current_selection - 1, 0)
		_update_focus()
		get_tree().root.set_input_as_handled()

	elif event.is_action_pressed("ui_right"):
		_current_selection = mini(_current_selection + 1, _stones.size() - 1)
		_update_focus()
		get_tree().root.set_input_as_handled()

	elif event.is_action_pressed("ui_accept"):
		_on_stone_selected(_current_selection)
		get_tree().root.set_input_as_handled()


func _on_stone_gui_input(event: InputEvent, idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		_current_selection = idx
		_update_focus()
		_on_stone_selected(idx)


func _on_stone_selected(idx: int) -> void:
	# Indices match the visual left-to-right layout in class_stone.tscn:
	# 0 = Staff (left), 1 = Sword (center), 2 = Shield (right).
	match idx:
		0:
			_pending_choice = RunState.ClassChoice.STAFF
		1:
			_pending_choice = RunState.ClassChoice.SWORD
		2:
			_pending_choice = RunState.ClassChoice.SHIELD

	_confirm_dialog.popup_centered()


func _on_confirm_yes() -> void:
	RunStateRegistry.run_state.class_choice = _pending_choice
	SaveSystem.save()
	SceneRouter.transition_to("res://scenes/test/scene_a.tscn")


func _on_confirm_cancel() -> void:
	_pending_choice = RunState.ClassChoice.UNDEFINED


func _update_focus() -> void:
	for i in range(_stones.size()):
		_stones[i].modulate = Color.WHITE if i == _current_selection else Color(0.5, 0.5, 0.5)
