extends Resource
class_name DialogueResource

## A linear dialogue run. No branching in M1. Just an ordered sequence of
## DialogueLine records. DialogueRunner consumes these and displays them
## one at a time with typewriter effect.

@export var lines: Array[DialogueLine] = []
