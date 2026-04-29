extends Node

## Autoload. The only writer to the Sin and Redemption ledgers. The
## append-only invariant from Bible §4.3 lives here -- there is no
## delete API, no edit API, no rollback. Sin marks cannot be erased.
## Redemption marks do not retroactively cancel Sin marks.
##
## Read access is via RunStateRegistry.run_state.ledger -- callers should
## never write to that array directly. Always go through these methods.

signal sin_recorded(event: LedgerEvent)
signal redemption_recorded(event: LedgerEvent)


func record_sin(tag: String, mortality_cost: float = 0.0, note: String = "") -> LedgerEvent:
	var event: LedgerEvent = _build_event(LedgerEvent.Kind.SIN, tag, mortality_cost, note)
	RunStateRegistry.run_state.ledger.sins.append(event)
	emit_signal("sin_recorded", event)
	return event


func record_redemption(tag: String, mortality_cost: float = 0.0, note: String = "") -> LedgerEvent:
	var event: LedgerEvent = _build_event(LedgerEvent.Kind.REDEMPTION, tag, mortality_cost, note)
	RunStateRegistry.run_state.ledger.redemptions.append(event)
	emit_signal("redemption_recorded", event)
	return event


func _build_event(kind: LedgerEvent.Kind, tag: String, mortality_cost: float, note: String) -> LedgerEvent:
	var event: LedgerEvent = LedgerEvent.new()
	event.kind = kind
	event.engine_ticks_usec = Time.get_ticks_usec()
	event.real_time_iso = Time.get_datetime_string_from_system(true)
	event.tag = tag
	event.mortality_cost = mortality_cost
	event.note = note
	return event
