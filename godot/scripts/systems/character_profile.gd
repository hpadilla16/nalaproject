extends Resource
class_name CharacterProfile

## The player's character-create choices. Bible §22 (Protagonist Naming) and
## §24.5 (open: family composition granularity).
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

## The protagonist's chosen name. Empty string means character-create has
## not run yet. Display strings should fall back to "He" / "She" / "They"
## as appropriate when the name is empty.
@export var name: String = ""

## Pronoun set. UNDEFINED means character-create has not run yet.
@export var pronouns: Pronouns = Pronouns.UNDEFINED

## When pronouns == OTHER, this holds the player-supplied set as a single
## free-text string (e.g. "ze/zir"). Empty otherwise.
@export var pronouns_custom: String = ""

## Family composition for Caina. §24.5 is open on the granularity. For now
## this is a simple array of free-text descriptors -- "mother", "father",
## "younger brother", "best friend (chosen family)", etc. Caina sprite
## generation reads these, dialogue substitution reads these.
@export var family: Array[String] = []
