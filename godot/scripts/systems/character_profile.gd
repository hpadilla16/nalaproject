extends Resource
class_name CharacterProfile

## The player's character-create choices. Bible §22 (Protagonist Naming) and
## §24.5 (resolved: family composition uses preset list per 002-character-create-family).
##
## The coding-expert house rule: never hardcode "he/him", never hardcode the
## protagonist's name. Read from this resource. The dialogue runner and the
## Caina family-in-the-ice scene (§10) both read from the same source of
## truth here.

enum Pronouns {
	UNDEFINED,   ## Not yet chosen at character-create.
	HE_HIM,
	SHE_HER,
	THEY_THEM,
	OTHER,       ## Free-text, see pronouns_custom.
}

enum FamilyComposition {
	UNDEFINED,
	MOTHER_ONLY,
	FATHER_ONLY,
	BOTH_PARENTS,
	PARENTS_AND_SIBLINGS,
	CHOSEN_FAMILY,
}

## The protagonist's chosen name. Empty string means character-create has
## not run yet. Display strings should fall back to "He" / "She" / "They"
## as appropriate when the name is empty.
@export var name: String = ""

## Pronoun set. UNDEFINED means character-create has not run yet.
@export var pronouns: Pronouns = Pronouns.UNDEFINED

## When pronouns == OTHER, this holds the player-supplied set as a single
## free-text string (e.g. "ze/zir"). Empty otherwise.
@export var pronouns_custom: String = ""

## Family composition preset for Caina scene. Each preset maps to known sprite
## combinations and dialogue branches. Per §2 and §10, chosen-family option
## represents friends instead of blood relatives, widening the wound from
## "abandoned by family" to "abandoned by the people who should have stayed."
## Chosen-family sprites and dialogue awaits writer-led pass on §10/§25.3.
@export var family: FamilyComposition = FamilyComposition.UNDEFINED
