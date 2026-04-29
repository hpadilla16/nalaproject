extends Resource
class_name MortalityTunables

## Placeholder bleed rates per circle, per Bible §24.4 (Mechanical Tuning).
## Authored as a Resource so the §24.4 tuning pass can edit values in the
## Godot inspector without touching code.
##
## All values in mortality-units-per-second. The starting Mortality value
## (1000.0 by default) is set in `starting_mortality`; how fast it bleeds in
## each circle is set in the per-circle fields. Combat hits, compassion
## costs, and rescue costs are NOT in this resource -- those are tunables
## owned by the relevant systems (combat, dialogue, rescue mechanic).

@export_group("Starting state")

@export var starting_mortality: float = 1000.0


@export_group("Passive bleed rates per circle (units/sec)")

## Apartment + Limbo. Slow bleed so the player can read.
@export var bleed_prologue: float = 0.10

## Circle 2 -- Lust.
@export var bleed_lust: float = 0.20

## Circle 3 -- Gluttony.
@export var bleed_gluttony: float = 0.25

## Circle 4 -- Greed.
@export var bleed_greed: float = 0.30

## Circle 5 -- Wrath / Sullenness.
@export var bleed_wrath: float = 0.35

## Circle 6 -- Heresy.
@export var bleed_heresy: float = 0.40

## Circle 7 -- Violence (all three rings).
@export var bleed_violence: float = 0.50

## Circle 8 -- Fraud (Malebolge).
@export var bleed_fraud: float = 0.60

## Circle 9 -- Treachery (Cocytus).
@export var bleed_treachery: float = 0.75
