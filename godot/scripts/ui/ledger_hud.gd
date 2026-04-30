extends CanvasLayer
class_name LedgerHUD

## Two-column ledger (Sin left, Redemption right). Hidden by default.
## Pulled open/closed with Tab key (toggle). Small column-flash when
## ledger events fire, even if panel hidden. Glyphs instantiated as
## each sin/redemption event is recorded.

var _ledger_panel: PanelContainer
var _sin_column: VBoxContainer
var _redemption_column: VBoxContainer
var _visible_toggle: bool = false
var _sin_flash_tween: Tween
var _redemption_flash_tween: Tween
var _sin_flash_rect: ColorRect
var _redemption_flash_rect: ColorRect

const GLYPH_SCENE: String = "res://scenes/ui/ledger_glyph.tscn"


func _ready() -> void:
	_setup_ui()
	_connect_signals()


func _setup_ui() -> void:
	# Main panel container (hidden by default)
	_ledger_panel = PanelContainer.new()
	_ledger_panel.custom_minimum_size = Vector2(300, 400)
	_ledger_panel.anchor_left = 0.05
	_ledger_panel.anchor_top = 0.1
	_ledger_panel.anchor_right = 0.3
	_ledger_panel.anchor_bottom = 0.7
	_ledger_panel.visible = false
	add_child(_ledger_panel)

	# Internal layout: HBox for two columns
	var hbox: HBoxContainer = HBoxContainer.new()
	hbox.add_theme_constant_override("separation", 20)
	_ledger_panel.add_child(hbox)

	# Sin column (left)
	var sin_vbox: VBoxContainer = VBoxContainer.new()
	sin_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.add_child(sin_vbox)

	var sin_label: Label = Label.new()
	sin_label.text = "Sin"
	sin_label.add_theme_font_size_override("font_size", 14)
	sin_vbox.add_child(sin_label)

	_sin_column = VBoxContainer.new()
	_sin_column.size_flags_vertical = Control.SIZE_EXPAND_FILL
	sin_vbox.add_child(_sin_column)

	# Redemption column (right)
	var redemption_vbox: VBoxContainer = VBoxContainer.new()
	redemption_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hbox.add_child(redemption_vbox)

	var redemption_label: Label = Label.new()
	redemption_label.text = "Redemption"
	redemption_label.add_theme_font_size_override("font_size", 14)
	redemption_vbox.add_child(redemption_label)

	_redemption_column = VBoxContainer.new()
	_redemption_column.size_flags_vertical = Control.SIZE_EXPAND_FILL
	redemption_vbox.add_child(_redemption_column)

	# Flash rects (edge flashes when ledger events fire). Hue choice is
	# colorblind-considerate per ui-ux-pro-max accessibility priority:
	# warm amber for Sin and cool teal for Redemption — distinct in both
	# hue and luminance so red-green color-vision-deficient players read
	# the affordance from the column position plus the color shift.
	_sin_flash_rect = ColorRect.new()
	_sin_flash_rect.color = Color(0.85, 0.55, 0.15, 0.6)
	_sin_flash_rect.anchor_left = 0.0
	_sin_flash_rect.anchor_top = 0.1
	_sin_flash_rect.anchor_right = 0.02
	_sin_flash_rect.anchor_bottom = 0.7
	_sin_flash_rect.modulate.a = 0.0
	add_child(_sin_flash_rect)

	_redemption_flash_rect = ColorRect.new()
	_redemption_flash_rect.color = Color(0.15, 0.65, 0.75, 0.6)
	_redemption_flash_rect.anchor_left = 0.98
	_redemption_flash_rect.anchor_top = 0.1
	_redemption_flash_rect.anchor_right = 1.0
	_redemption_flash_rect.anchor_bottom = 0.7
	_redemption_flash_rect.modulate.a = 0.0
	add_child(_redemption_flash_rect)

	# Populate columns from existing ledger state
	var ledger: Ledger = RunStateRegistry.run_state.ledger
	if ledger:
		for _event in ledger.sins:
			_add_glyph_to_column(_sin_column)
		for _event in ledger.redemptions:
			_add_glyph_to_column(_redemption_column)

	# Note: ledger_toggle input action is registered in project.godot


func _connect_signals() -> void:
	if LedgerState:
		LedgerState.sin_recorded.connect(_on_sin_recorded)
		LedgerState.redemption_recorded.connect(_on_redemption_recorded)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ledger_toggle"):
		_visible_toggle = !_visible_toggle
		_ledger_panel.visible = _visible_toggle
		get_tree().root.set_input_as_handled()


func _on_sin_recorded(_event: LedgerEvent) -> void:
	_add_glyph_to_column(_sin_column)
	_flash_column(_sin_flash_rect)


func _on_redemption_recorded(_event: LedgerEvent) -> void:
	_add_glyph_to_column(_redemption_column)
	_flash_column(_redemption_flash_rect)


func _add_glyph_to_column(column: VBoxContainer) -> void:
	var glyph_scene: PackedScene = load(GLYPH_SCENE)
	if not glyph_scene:
		return
	var glyph: Node = glyph_scene.instantiate()
	column.add_child(glyph)


func _flash_column(flash_rect: ColorRect) -> void:
	# Brief edge flash
	if _sin_flash_tween and flash_rect == _sin_flash_rect:
		_sin_flash_tween.kill()
	elif _redemption_flash_tween and flash_rect == _redemption_flash_rect:
		_redemption_flash_tween.kill()

	var tween: Tween = create_tween()
	flash_rect.modulate.a = 1.0
	tween.tween_property(flash_rect, "modulate:a", 0.0, 0.3)

	if flash_rect == _sin_flash_rect:
		_sin_flash_tween = tween
	else:
		_redemption_flash_tween = tween
