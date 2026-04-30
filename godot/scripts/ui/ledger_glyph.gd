extends Control
class_name LedgerGlyph

## A small abstract etched shape used as a ledger mark.
## One identical glyph per event (sin or redemption).
## M1 placeholder: small crossed-lines shape. Pixel-art-sprite-expert
## will replace with final etched glyph art later.

@export var glyph_size: float = 16.0
@export var glyph_color: Color = Color(0.6, 0.6, 0.65, 1.0)

var _polygon: Polygon2D


func _ready() -> void:
	_setup_glyph()


func _setup_glyph() -> void:
	# Simple placeholder: an 'X' shape on a subtle background square.
	# Polygon2D coordinates are in the parent Control's local space; (0,0) is
	# the top-left of the glyph cell. Center the X by offsetting to the cell's
	# midpoint instead of letting the polygons draw at the corner.
	custom_minimum_size = Vector2(glyph_size * 1.5, glyph_size * 1.5)
	var center: Vector2 = custom_minimum_size * 0.5

	# Background (small square, drawn behind the X via z-index ordering by
	# being added first).
	var bg: ColorRect = ColorRect.new()
	bg.color = Color(0.15, 0.15, 0.2, 0.5)
	bg.custom_minimum_size = Vector2(glyph_size, glyph_size)
	bg.position = center - bg.custom_minimum_size * 0.5
	add_child(bg)

	# Etched mark (two crossed lines forming an X), centered in the cell.
	_polygon = Polygon2D.new()
	_polygon.color = glyph_color
	_polygon.position = center

	var half: float = glyph_size * 0.25
	var points: PackedVector2Array = [
		Vector2(-half, -half),
		Vector2(half, half),
		Vector2(half - 2, half),
		Vector2(-half, -half + 2),
	]
	_polygon.polygon = points
	add_child(_polygon)

	# Second line of X
	var poly2: Polygon2D = Polygon2D.new()
	poly2.color = glyph_color
	poly2.position = center

	var points2: PackedVector2Array = [
		Vector2(half, -half),
		Vector2(-half, half),
		Vector2(-half + 2, half),
		Vector2(half, -half + 2),
	]
	poly2.polygon = points2
	add_child(poly2)
