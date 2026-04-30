# DEBUG PLACEHOLDER — replaced by ui-ux-expert in M1 visual pass.

extends CanvasLayer
class_name DebugHUD

## Temporary debug panel showing mortality state and ledger counts.
## Listens to MortalityClock and LedgerState autoloads and renders
## their state in real-time. M1-scoped; will be removed when proper
## UI is designed.

var _mortality_label: Label
var _sin_count_label: Label
var _redemption_count_label: Label
var _flash_timer: float = 0.0
var _sin_flash: bool = false
var _redemption_flash: bool = false


func _ready() -> void:
	_setup_ui()
	_connect_signals()


func _setup_ui() -> void:
	# Container panel
	var panel = Panel.new()
	panel.anchor_left = 0.0
	panel.anchor_top = 0.0
	panel.anchor_right = 0.2
	panel.anchor_bottom = 0.15
	add_child(panel)

	# Mortality label
	_mortality_label = Label.new()
	_mortality_label.anchor_left = 0.05
	_mortality_label.anchor_top = 0.05
	_mortality_label.text = "Mortality: --"
	_mortality_label.add_theme_font_size_override("font_size", 14)
	panel.add_child(_mortality_label)

	# Ledger label container
	var ledger_container = HBoxContainer.new()
	ledger_container.anchor_left = 0.05
	ledger_container.anchor_top = 0.5
	ledger_container.custom_minimum_size = Vector2(200, 40)
	panel.add_child(ledger_container)

	_sin_count_label = Label.new()
	_sin_count_label.text = "Sin: 0"
	_sin_count_label.add_theme_font_size_override("font_size", 12)
	ledger_container.add_child(_sin_count_label)

	_redemption_count_label = Label.new()
	_redemption_count_label.text = "Redemption: 0"
	_redemption_count_label.add_theme_font_size_override("font_size", 12)
	ledger_container.add_child(_redemption_count_label)

	_update_mortality()
	_update_ledger()


func _connect_signals() -> void:
	MortalityClock.mortality_changed.connect(_on_mortality_changed)
	MortalityClock.mortality_low.connect(_on_mortality_low)
	MortalityClock.mortality_exhausted.connect(_on_mortality_exhausted)
	LedgerState.sin_recorded.connect(_on_sin_recorded)
	LedgerState.redemption_recorded.connect(_on_redemption_recorded)


func _on_mortality_changed(_new_value: float, _delta: float) -> void:
	_update_mortality()


func _on_mortality_low(_value: float) -> void:
	_mortality_label.add_theme_color_override("font_color", Color.YELLOW)


func _on_mortality_exhausted() -> void:
	_mortality_label.add_theme_color_override("font_color", Color.RED)


func _on_sin_recorded(_event: LedgerEvent) -> void:
	_sin_flash = true
	_flash_timer = 0.3
	_update_ledger()


func _on_redemption_recorded(_event: LedgerEvent) -> void:
	_redemption_flash = true
	_flash_timer = 0.3
	_update_ledger()


func _update_mortality() -> void:
	var mortality: Mortality = RunStateRegistry.run_state.mortality
	_mortality_label.text = "Mortality: %.0f" % mortality.current


func _update_ledger() -> void:
	var ledger: Ledger = RunStateRegistry.run_state.ledger
	_sin_count_label.text = "Sin: %d" % ledger.sins.size()
	_redemption_count_label.text = "Redemption: %d" % ledger.redemptions.size()


func _process(delta: float) -> void:
	# Flash only the column whose ledger event just fired, per dispatch §4.3
	# ("small column-flash when LedgerState appends"). Both flags get cleared
	# when the timer expires.
	if _flash_timer > 0.0:
		_flash_timer -= delta
		var alpha: float = fmod(_flash_timer * 3.0, 1.0)
		var flash_color: Color = Color.WHITE
		flash_color.a = 0.5 + (alpha * 0.5)
		if _sin_flash:
			_sin_count_label.modulate = flash_color
		if _redemption_flash:
			_redemption_count_label.modulate = flash_color
	else:
		_sin_count_label.modulate = Color.WHITE
		_redemption_count_label.modulate = Color.WHITE
		_sin_flash = false
		_redemption_flash = false
