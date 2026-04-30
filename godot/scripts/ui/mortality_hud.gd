extends CanvasLayer
class_name MortalityHUD

## Bleeding clock HUD. Renders a fill-based mortality readout with three
## visual states: passive bleed (descent baseline), active bleed (when
## compassion/rescue cost mortality), critical (under ~10% remaining).
## States are distinguished by gradient AND shape per §23.8 colorblind-
## considerate design. Persistent top-right.

@export var hud_offset: Vector2 = Vector2(1260, 60)
@export var clock_radius: float = 40.0
@export var critical_threshold: float = 0.1

var _clock_container: Control
var _background: Polygon2D
var _fill: Polygon2D
var _droplet: Polygon2D
var _pulse_tween: Tween
var _active_bleed_tween: Tween

var _current_state: String = "passive"  # passive, active, critical
var _fill_ratio: float = 1.0


func _ready() -> void:
	_setup_ui()
	_connect_signals()
	_update_fill_from_mortality()


func _setup_ui() -> void:
	# Container for the clock (anchored to top-right)
	_clock_container = Control.new()
	_clock_container.position = hud_offset
	_clock_container.custom_minimum_size = Vector2(clock_radius * 2.5, clock_radius * 2.5)
	add_child(_clock_container)

	# Background circle (passive state baseline)
	_background = Polygon2D.new()
	_background.color = Color(0.3, 0.3, 0.35, 1.0)
	_setup_circle_polygon(_background, clock_radius, 32)
	_clock_container.add_child(_background)

	# Fill circle (changes with mortality)
	_fill = Polygon2D.new()
	_fill.color = Color(0.8, 0.2, 0.2, 1.0)  # Starts red; gradient applied in state changes
	_setup_circle_polygon(_fill, clock_radius, 32)
	_clock_container.add_child(_fill)

	# Droplet shape (appears in active/critical states)
	_droplet = Polygon2D.new()
	_droplet.color = Color(0.9, 0.1, 0.1, 0.8)
	_droplet.visible = false
	_setup_droplet_polygon(_droplet)
	_clock_container.add_child(_droplet)

	# Start passive pulse
	_start_passive_pulse()


func _setup_circle_polygon(poly: Polygon2D, radius: float, segments: int) -> void:
	var points: PackedVector2Array = []
	for i in range(segments):
		var angle: float = (TAU * i) / segments
		var x: float = cos(angle) * radius
		var y: float = sin(angle) * radius
		points.append(Vector2(x, y))
	poly.polygon = points


func _setup_droplet_polygon(poly: Polygon2D) -> void:
	# Simple teardrop shape: circle top, point bottom
	var points: PackedVector2Array = [
		Vector2(0, -20),      # top
		Vector2(15, -5),      # right curve
		Vector2(10, 10),      # right bulge
		Vector2(0, 25),       # point bottom
		Vector2(-10, 10),     # left bulge
		Vector2(-15, -5),     # left curve
	]
	poly.polygon = points


func _connect_signals() -> void:
	if not MortalityClock:
		return
	MortalityClock.mortality_changed.connect(_on_mortality_changed)
	MortalityClock.mortality_low.connect(_on_mortality_low)
	MortalityClock.mortality_exhausted.connect(_on_mortality_exhausted)


func _on_mortality_changed(_new_value: float, _delta: float) -> void:
	# Large delta = active bleed (compassion/rescue cost)
	if abs(_delta) > 50.0:
		_set_state("active")
	_update_fill_from_mortality()


func _on_mortality_low(_value: float) -> void:
	# Transition to critical state without overriding if already critical
	if _current_state != "critical":
		_set_state("critical")


func _on_mortality_exhausted() -> void:
	_set_state("critical")


func _update_fill_from_mortality() -> void:
	var mortality: Mortality = RunStateRegistry.run_state.mortality
	if not mortality:
		return

	_fill_ratio = clamp(mortality.current / mortality.peak, 0.0, 1.0)

	# Update fill polygon as a pie/circle segment
	_update_fill_circle(_fill, _fill_ratio)


func _update_fill_circle(poly: Polygon2D, fill_ratio: float) -> void:
	# Draw a filled circle segment (0 = empty, 1 = full)
	# Start at top, sweep clockwise
	var segments: int = 32
	var filled_segments: int = int(segments * fill_ratio)

	var points: PackedVector2Array = [Vector2.ZERO]  # Center
	for i in range(filled_segments + 1):
		var angle: float = -(TAU * i) / segments + TAU / 4  # Start from top, sweep clockwise
		var x: float = cos(angle) * clock_radius
		var y: float = sin(angle) * clock_radius
		points.append(Vector2(x, y))

	if filled_segments < segments:
		# Close with center point again for partial fill
		points.append(Vector2.ZERO)

	poly.polygon = points


func _set_state(new_state: String) -> void:
	if new_state == _current_state:
		return

	_current_state = new_state

	# Kill existing tweens
	if _pulse_tween:
		_pulse_tween.kill()
	if _active_bleed_tween:
		_active_bleed_tween.kill()

	match new_state:
		"passive":
			_fill.color = Color(0.7, 0.15, 0.15, 1.0)
			_droplet.visible = false
			_start_passive_pulse()

		"active":
			_fill.color = Color(0.9, 0.1, 0.1, 1.0)
			_droplet.visible = true
			_start_active_pulse()
			# Auto-revert to passive after ~1 second if no further drain
			await get_tree().create_timer(1.5).timeout
			if _current_state == "active":
				_set_state("passive")

		"critical":
			_fill.color = Color(0.95, 0.05, 0.05, 1.0)
			_droplet.visible = true
			_background.color = Color(0.4, 0.2, 0.2, 1.0)  # Darken background in critical
			_start_critical_pulse()


func _start_passive_pulse() -> void:
	# Slow, calm pulse
	_pulse_tween = create_tween()
	_pulse_tween.set_loops()
	_pulse_tween.tween_property(_fill, "modulate:a", 0.7, 2.0)
	_pulse_tween.tween_property(_fill, "modulate:a", 1.0, 2.0)


func _start_active_pulse() -> void:
	# Faster, more agitated pulse
	_pulse_tween = create_tween()
	_pulse_tween.set_loops()
	_pulse_tween.tween_property(_fill, "modulate:a", 0.6, 0.5)
	_pulse_tween.tween_property(_fill, "modulate:a", 1.0, 0.5)

	# Droplet animate: scale up/down
	_active_bleed_tween = create_tween()
	_active_bleed_tween.set_loops()
	_droplet.scale = Vector2(0.8, 0.8)
	_active_bleed_tween.tween_property(_droplet, "scale", Vector2(1.2, 1.2), 0.3)
	_active_bleed_tween.tween_property(_droplet, "scale", Vector2(0.8, 0.8), 0.3)


func _start_critical_pulse() -> void:
	# Irregular, urgent pulse
	_pulse_tween = create_tween()
	_pulse_tween.set_loops()
	_pulse_tween.tween_property(_fill, "modulate:a", 0.5, 0.3)
	_pulse_tween.tween_property(_fill, "modulate:a", 1.0, 0.2)
	_pulse_tween.tween_callback(func(): pass)
	_pulse_tween.tween_property(_fill, "modulate:a", 0.7, 0.4)

	# Droplet rapid flicker
	_active_bleed_tween = create_tween()
	_active_bleed_tween.set_loops()
	_droplet.scale = Vector2(1.0, 1.0)
	_active_bleed_tween.tween_property(_droplet, "scale", Vector2(1.3, 1.3), 0.2)
	_active_bleed_tween.tween_property(_droplet, "scale", Vector2(0.9, 0.9), 0.1)
	_active_bleed_tween.tween_property(_droplet, "scale", Vector2(1.2, 1.2), 0.1)


func _process(_delta: float) -> void:
	# Update fill every frame in case mortality changes
	_update_fill_from_mortality()
