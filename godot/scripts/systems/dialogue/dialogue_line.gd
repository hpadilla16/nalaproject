extends Resource
class_name DialogueLine

## A single line of dialogue in a dialogue run.
## The speaker can be nameless (for the Tree, Family, Self-Blasphemer per
## Bible §11/§10/§29) by setting speaker_label to an empty string; in that
## case, the runner does not render any label.

@export var speaker_id: StringName = ""
@export var speaker_label: String = ""
@export var text: String = ""
