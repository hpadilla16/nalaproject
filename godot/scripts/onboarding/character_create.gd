extends Control

## Character creation screen. Three sections: name, pronouns, family.
## Continues disabled until all required fields are filled.

@onready var _name_field: LineEdit = %NameField
@onready var _pronouns_option: OptionButton = %PronounsOption
@onready var _pronouns_custom_field: LineEdit = %PronounsCustomField
@onready var _pronouns_custom_container: Control = %PronounsCustomContainer
@onready var _family_option: OptionButton = %FamilyOption
@onready var _continue_button: Button = %ContinueButton

var _pronouns_selected: CharacterProfile.Pronouns = CharacterProfile.Pronouns.UNDEFINED
var _family_selected: CharacterProfile.FamilyComposition = CharacterProfile.FamilyComposition.UNDEFINED


func _ready() -> void:
	# Setup name field
	_name_field.text_changed.connect(_on_name_changed)

	# Setup pronouns option
	_pronouns_option.add_item("he / him", CharacterProfile.Pronouns.HE_HIM)
	_pronouns_option.add_item("she / her", CharacterProfile.Pronouns.SHE_HER)
	_pronouns_option.add_item("they / them", CharacterProfile.Pronouns.THEY_THEM)
	_pronouns_option.add_item("other", CharacterProfile.Pronouns.OTHER)
	_pronouns_option.item_selected.connect(_on_pronouns_selected)

	# Setup pronouns custom field
	_pronouns_custom_field.text_changed.connect(_on_pronouns_custom_changed)
	_pronouns_custom_container.visible = false

	# Setup family option
	_family_option.add_item("mother only", CharacterProfile.FamilyComposition.MOTHER_ONLY)
	_family_option.add_item("father only", CharacterProfile.FamilyComposition.FATHER_ONLY)
	_family_option.add_item("both parents", CharacterProfile.FamilyComposition.BOTH_PARENTS)
	_family_option.add_item("parents and siblings", CharacterProfile.FamilyComposition.PARENTS_AND_SIBLINGS)
	_family_option.add_item("chosen family", CharacterProfile.FamilyComposition.CHOSEN_FAMILY)
	_family_option.item_selected.connect(_on_family_selected)

	# Setup continue button
	_continue_button.pressed.connect(_on_continue_pressed)
	_check_form_valid()


func _on_name_changed(_new_text: String) -> void:
	_check_form_valid()


func _on_pronouns_selected(idx: int) -> void:
	# add_item(text, id) stores the enum in the item's id, not metadata.
	# get_item_metadata would return null and trip the form to permanently
	# disabled — read get_item_id() instead.
	_pronouns_selected = _pronouns_option.get_item_id(idx)
	_pronouns_custom_container.visible = (_pronouns_selected == CharacterProfile.Pronouns.OTHER)
	_check_form_valid()


func _on_pronouns_custom_changed(_new_text: String) -> void:
	_check_form_valid()


func _on_family_selected(idx: int) -> void:
	_family_selected = _family_option.get_item_id(idx)
	_check_form_valid()


func _check_form_valid() -> void:
	var name_valid: bool = _name_field.text.strip_edges() != ""
	var pronouns_valid: bool = _pronouns_selected != CharacterProfile.Pronouns.UNDEFINED
	var pronouns_custom_valid: bool = (
		_pronouns_selected != CharacterProfile.Pronouns.OTHER or
		_pronouns_custom_field.text.strip_edges() != ""
	)
	var family_valid: bool = _family_selected != CharacterProfile.FamilyComposition.UNDEFINED

	_continue_button.disabled = not (name_valid and pronouns_valid and pronouns_custom_valid and family_valid)


func _on_continue_pressed() -> void:
	# Write to profile
	RunStateRegistry.run_state.profile.name = _name_field.text.strip_edges()
	RunStateRegistry.run_state.profile.pronouns = _pronouns_selected
	RunStateRegistry.run_state.profile.pronouns_custom = (
		_pronouns_custom_field.text.strip_edges() if _pronouns_selected == CharacterProfile.Pronouns.OTHER else ""
	)
	RunStateRegistry.run_state.profile.family = _family_selected

	# Persist and advance
	SaveSystem.save()
	SceneRouter.transition_to("res://scenes/onboarding/class_stone.tscn")
