extends Resource
class_name LedgerEvent

## A single entry in the Sin or Redemption ledger. Once written, it is never
## edited and never deleted (Bible §4.3, "Save data is append-only").
## Redemption events do not cancel Sin events; both persist to the
## end-of-run weighing.

enum Kind { SIN, REDEMPTION }

## SIN or REDEMPTION. Determines which ledger array this event lands in.
@export var kind: Kind = Kind.SIN

## Engine timestamp at write time, in microseconds since engine start
## (Time.get_ticks_usec()). For wall-clock time use real_time_iso.
@export var engine_ticks_usec: int = 0

## ISO 8601 wall-clock timestamp at write time. Optional but useful for
## post-mortem analysis of long runs that span real-world breaks.
@export var real_time_iso: String = ""

## A short tag identifying the in-world cause. Examples:
##   "abandon:hound"  (sin: abandoned the Gluttony dog)
##   "rescue:hound"   (redemption: descended back for the Gluttony dog)
##   "mercy:tomb"     (redemption: kindness at a Heresy tomb)
##   "wager:caina"    (sin or redemption: outcome of the final wager)
## The grammar is "{verb}:{object}" where verb is short and lowercase.
@export var tag: String = ""

## How much Mortality this event consumed (positive number). Zero is valid
## for events that record a moral act with no time cost.
@export var mortality_cost: float = 0.0

## Optional free-form context for debugging. Not gameplay-load-bearing.
@export var note: String = ""
