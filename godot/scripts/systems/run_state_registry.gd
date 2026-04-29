extends Node

## Autoload. Owns the in-memory RunState for the current descent.
## SaveSystem reads from here to write to disk and writes here on load.
## MortalityClock, LedgerState, and SceneRouter all read/mutate the
## sub-resources owned by `run_state`. Centralizing ownership here keeps
## the systems composable and means there is exactly one thing to swap
## when the player starts a new descent.

signal run_state_replaced(new_state: RunState)

var run_state: RunState = RunState.new()


func replace(new_state: RunState) -> void:
	run_state = new_state
	emit_signal("run_state_replaced", new_state)


## Construct a fresh RunState for a new descent. Used on first boot when
## no save exists, and (later) when the player chooses "new game" from the
## main menu.
func reset_for_new_descent(tunables: MortalityTunables) -> void:
	var fresh: RunState = RunState.new()
	fresh.mortality.current = tunables.starting_mortality
	fresh.mortality.peak = tunables.starting_mortality
	# Profile starts blank -- character-create fills it. Bible §22.
	# Ledger starts empty.
	# current_scene_path / position get set when SceneRouter transitions in.
	replace(fresh)
