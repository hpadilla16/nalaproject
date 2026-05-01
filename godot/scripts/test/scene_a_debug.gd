# DEBUG HOTKEY HANDLERS FOR SCENE A — M1 temporary, will be removed when
# proper game triggers (dialogue, rescue, etc.) exist.

extends Node2D

var _dialogue_runner: DialogueRunner


func _ready() -> void:
	_dialogue_runner = $DialogueRunner


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_drain_mortality"):
		# F1: Force a large drain (30% of peak) to cross thresholds
		var mortality: Mortality = RunStateRegistry.run_state.mortality
		var drain: float = mortality.peak * 0.3
		MortalityClock.apply_cost(drain)
		get_tree().root.set_input_as_handled()

	elif event.is_action_pressed("debug_add_sin"):
		# F2: Record a sin event
		LedgerState.record_sin("debug_f2", 0.0)
		get_tree().root.set_input_as_handled()

	elif event.is_action_pressed("debug_add_redemption"):
		# F3: Record a redemption event
		LedgerState.record_redemption("debug_f3", 0.0)
		get_tree().root.set_input_as_handled()

	elif event.is_action_pressed("debug_play_dialogue"):
		# F4: Play test dialogue
		_dialogue_runner.play(load("res://resources/dialogue/_test.tres"))
		get_tree().root.set_input_as_handled()

	elif event.is_action_pressed("debug_log_profile"):
		# F5: Log current profile and class choice to console
		var profile: CharacterProfile = RunStateRegistry.run_state.profile
		var class_choice: RunState.ClassChoice = RunStateRegistry.run_state.class_choice
		print("=== CharacterProfile ===")
		print("Name: %s" % profile.name)
		print("Pronouns: %s (custom: %s)" % [profile.pronouns, profile.pronouns_custom])
		print("Family: %s" % profile.family)
		print("ClassChoice: %s" % class_choice)
		get_tree().root.set_input_as_handled()

	elif event.is_action_pressed("debug_reset_save"):
		# F6: Clear save and exit to main (boot flow)
		if SaveSystem.has_save():
			var err: int = DirAccess.remove_absolute(SaveSystem.SAVE_PATH)
			if err != OK:
				push_error("Scene_a_debug: failed to delete save (error %d)" % err)
		get_tree().change_scene_to_file("res://scenes/main.tscn")
		get_tree().root.set_input_as_handled()
