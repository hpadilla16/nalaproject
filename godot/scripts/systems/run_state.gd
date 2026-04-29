extends Resource
class_name RunState

## The full serializable state of a single descent. Saved to
## user://savegame.tres at every scene transition; reloaded on game boot.
##
## Composition by reference -- this class owns nothing directly; it just
## bundles the four resources whose lifecycle is "the run." When the player
## starts a new descent, a new RunState is constructed; when they finish a
## run (any of the three endings, §5), the RunState is archived and a new
## one begins.

@export var mortality: Mortality = Mortality.new()
@export var ledger: Ledger = Ledger.new()
@export var profile: CharacterProfile = CharacterProfile.new()

## The scene_path the player was in when state was last saved. SceneRouter
## uses this to restore the world on boot.
@export var current_scene_path: String = ""

## The player's position within the current scene at last save. SceneRouter
## passes this to the protagonist after the scene loads.
@export var current_position: Vector2 = Vector2.ZERO

## Engine version that wrote this save. Lets us migrate if the resource
## shape changes between releases.
@export var schema_version: int = 1
