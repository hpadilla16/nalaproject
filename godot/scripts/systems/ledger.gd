extends Resource
class_name Ledger

## The Sin and Redemption ledgers. Append-only arrays of LedgerEvent
## (Bible §4.3). Sin marks cannot be erased. Redemption marks do not
## retroactively cancel Sin marks. Both persist to the end-of-run weighing.
##
## Read-only accessors on this resource expose the arrays for inspection.
## Writes happen exclusively through the LedgerState autoload, which is
## the only thing that knows how to append correctly without violating the
## no-edit invariant.

## Append-only array of SIN events.
@export var sins: Array[LedgerEvent] = []

## Append-only array of REDEMPTION events.
@export var redemptions: Array[LedgerEvent] = []


func sin_count() -> int:
	return sins.size()


func redemption_count() -> int:
	return redemptions.size()


## Total Mortality the player has spent on Sin acts. Useful for the end-of-run
## weighing (the heavier this is, the deeper the descent has cost him).
func sin_mortality_total() -> float:
	var total: float = 0.0
	for e in sins:
		total += e.mortality_cost
	return total


## Total Mortality the player has spent on Redemption acts. The Caina wager
## (§10.8) reads this.
func redemption_mortality_total() -> float:
	var total: float = 0.0
	for e in redemptions:
		total += e.mortality_cost
	return total
