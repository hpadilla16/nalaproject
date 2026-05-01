extends Control

## Pre-game content note per §26. Single screen, plain background, no music.
## Renders the §26 content verbatim from the Design Bible.
##
## §26 placeholder text. The §24.2 sensitivity-read pass with a mental
## health consultant is still owed and may tighten the wording before
## final ship. Do not edit this string without that pass.

@onready var _button: Button = %ContinueButton


func _ready() -> void:
	_button.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	SceneRouter.transition_to("res://scenes/onboarding/character_create.tscn")
