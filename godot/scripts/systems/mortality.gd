extends Resource
class_name Mortality

## The protagonist's bleeding clock. The unified currency of the game
## (Bible §4.4). There is no HP, no MP, no stamina, no gold -- combat damage,
## compassion, rescue costs all subtract from this value. There is no item
## that recovers it. The only things that increase it are scripted narrative
## beats (e.g. the wager in Beat 8.5).
##
## Stored as a Resource so it serializes cleanly into save files via
## ResourceSaver. The actual bleeding loop lives in the MortalityClock
## autoload; this class just holds the value.

## Current mortality value. Starts at the value defined by MortalityTunables
## for the prologue and decreases as the descent progresses.
@export var current: float = 1000.0

## The all-time peak. We expose this so the end-of-run weighing in §10.8 can
## compute "how much life he spent on rescues vs. how much was bled away by
## the descent itself."
@export var peak: float = 1000.0
