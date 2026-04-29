extends Node

## Autoload. Drives the passive bleed described in Bible §4.4.
## Mortality bleeds while the protagonist is in a circle; the rate per
## circle is read from MortalityTunables (a .tres in
## resources/tunables/). Discrete costs (combat hits, compassion, rescue)
## are NOT applied here -- they are applied directly by the systems that
## know about them (combat, dialogue, rescue mechanic). This autoload only
## owns the passive ticking.
##
## The actual mortality value lives on RunStateRegistry.run_state.mortality.
## This singleton is stateless except for the active bleed rate.

signal mortality_changed(new_value: float, delta: float)
signal mortality_low(value: float)        ## Crossed below low_threshold (descending).
signal mortality_exhausted()              ## Reached 0. The dying ends. (Lost Forever, §5.3.)

const LOW_THRESHOLD: float = 100.0

var _bleed_rate: float = 0.0
var _was_low: bool = false


func set_bleed_rate(units_per_second: float) -> void:
	_bleed_rate = units_per_second


func _process(delta: float) -> void:
	if _bleed_rate <= 0.0:
		return
	var mortality: Mortality = RunStateRegistry.run_state.mortality
	if mortality.current <= 0.0:
		return
	var consumed: float = _bleed_rate * delta
	apply_cost(consumed)


## Subtracts a cost from current mortality. Used by combat, compassion,
## and rescue systems. Does not allow current to go negative; clamps at 0
## and emits mortality_exhausted once.
func apply_cost(amount: float) -> void:
	if amount <= 0.0:
		return
	var mortality: Mortality = RunStateRegistry.run_state.mortality
	var prev: float = mortality.current
	mortality.current = max(0.0, mortality.current - amount)
	var delta: float = prev - mortality.current
	if delta == 0.0:
		return
	emit_signal("mortality_changed", mortality.current, -delta)
	if not _was_low and mortality.current <= LOW_THRESHOLD:
		_was_low = true
		emit_signal("mortality_low", mortality.current)
	if mortality.current == 0.0:
		emit_signal("mortality_exhausted")
