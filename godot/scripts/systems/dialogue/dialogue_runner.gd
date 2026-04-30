extends CanvasLayer
class_name DialogueRunner

## Plays linear DialogueResource files with typewriter effect, input advance,
## and speaker labels (hidden when label is empty per Bible §11/§10/§29).
## Emits signals for integration with other systems.

signal line_started(line: DialogueLine)
signal line_completed(line: DialogueLine)
signal dialogue_finished()

@export var chars_per_second: float = 40.0

var _current_resource: DialogueResource = null
var _current_line_index: int = 0
var _current_line: DialogueLine = null
var _elapsed_time: float = 0.0
var _is_playing: bool = false
var _waiting_for_advance: bool = false

var _panel: Panel
var _speaker_label: Label
var _text_display: RichTextLabel


func _ready() -> void:
	_setup_ui()
	visible = false


func _setup_ui() -> void:
	# Create panel backdrop
	_panel = Panel.new()
	_panel.custom_minimum_size = Vector2(800, 200)
	_panel.anchor_left = 0.5
	_panel.anchor_top = 1.0
	_panel.anchor_right = 0.5
	_panel.anchor_bottom = 1.0
	_panel.offset_left = -400
	_panel.offset_top = -200
	add_child(_panel)

	# Create speaker label
	_speaker_label = Label.new()
	_speaker_label.anchor_left = 0.05
	_speaker_label.anchor_top = 0.1
	_speaker_label.text = ""
	_speaker_label.add_theme_font_size_override("font_size", 16)
	_panel.add_child(_speaker_label)

	# Create rich text display
	_text_display = RichTextLabel.new()
	_text_display.anchor_left = 0.05
	_text_display.anchor_top = 0.3
	_text_display.anchor_right = 0.95
	_text_display.anchor_bottom = 0.95
	_text_display.bbcode_enabled = true
	_text_display.custom_minimum_size = Vector2(750, 150)
	_panel.add_child(_text_display)


func play(res: DialogueResource) -> void:
	if _is_playing:
		return
	_current_resource = res
	# _advance_to_next_line() pre-increments before reading. Start at -1 so
	# the first line read is lines[0] rather than lines[1].
	_current_line_index = -1
	_is_playing = true
	_waiting_for_advance = false
	_elapsed_time = 0.0
	visible = true
	_advance_to_next_line()


func advance() -> void:
	if not _is_playing:
		return
	if not _waiting_for_advance:
		# Player pressed advance mid-line -- jump to end of current line.
		_elapsed_time = _get_line_duration(_current_line.text)
	else:
		# Player pressed advance after line completed -- move to next line.
		_advance_to_next_line()


func is_playing() -> bool:
	return _is_playing


func _process(delta: float) -> void:
	if not _is_playing or not _current_line:
		return

	if _waiting_for_advance:
		return

	_elapsed_time += delta
	var duration: float = _get_line_duration(_current_line.text)

	if _elapsed_time >= duration:
		_elapsed_time = duration
		_waiting_for_advance = true
		_render_text(_current_line.text, 1.0)
		emit_signal("line_completed", _current_line)
	else:
		var progress: float = _elapsed_time / duration
		_render_text(_current_line.text, progress)


func _advance_to_next_line() -> void:
	_current_line_index += 1
	if _current_line_index >= _current_resource.lines.size():
		# Dialogue finished
		_is_playing = false
		_waiting_for_advance = false
		visible = false
		emit_signal("dialogue_finished")
		return

	_current_line = _current_resource.lines[_current_line_index]
	_elapsed_time = 0.0
	_waiting_for_advance = false

	# Update speaker label; hide if empty
	if _current_line.speaker_label == "":
		_speaker_label.text = ""
	else:
		_speaker_label.text = _current_line.speaker_label

	emit_signal("line_started", _current_line)


func _get_line_duration(text: String) -> float:
	# Strip BBCode tags to count actual characters
	var clean_text: String = text
	# Simple regex: remove [tag] and [/tag]
	clean_text = clean_text.to_lower()
	var regex = RegEx.new()
	regex.compile("\\[/?[a-z0-9=]*\\]")
	clean_text = regex.sub(clean_text, "", true)
	return float(clean_text.length()) / chars_per_second


func _render_text(text: String, progress: float) -> void:
	# Strip BBCode and count clean length
	var clean_text: String = text
	var regex = RegEx.new()
	regex.compile("\\[/?[a-z0-9=]*\\]")
	clean_text = regex.sub(clean_text, "", true)

	# Truncate to progress
	var char_count: int = int(float(clean_text.length()) * progress)
	var visible_chars: String = clean_text.substr(0, char_count)

	# Rebuild with original BBCode, showing only up to visible_chars
	# For simplicity, just show truncated clean text for M1
	_text_display.text = visible_chars


func _input(event: InputEvent) -> void:
	if not _is_playing:
		return
	if event.is_action_pressed("dialogue_advance"):
		advance()
		get_tree().root.set_input_as_handled()
