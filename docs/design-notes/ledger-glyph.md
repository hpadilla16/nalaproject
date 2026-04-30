# Ledger Glyph Specification — M1

## Visual Spec

A small etched mark used to represent one sin or redemption event. Each glyph is identical; the column reads as accumulation.

**Base Shape:** Small crossed-lines 'X' on a subtle background square.
- Size: 16px × 16px (displayed at ~24px with padding)
- Background: dark semi-transparent square (0.15, 0.15, 0.2, 0.5)
- Mark color: light gray (0.6, 0.6, 0.65, 1.0)

**Placeholder Implementation:**
- Scene: `godot/scenes/ui/ledger_glyph.tscn`
- Script: `godot/scripts/ui/ledger_glyph.gd`
- Built with `ColorRect` (background) and `Polygon2D` (etched lines)
- No animation in M1

**Design Intent:** The glyph should feel etched or carved—a permanent mark. Not a hash-mark, not a number. The repetition of identical marks in a column visually encodes "accumulation over time."

## M2+ Art Replacement

The `pixel-art-sprite-expert` will replace the placeholder with a final etched rune or symbol that:
- Fits the game's visual language (Bible §23.8 — plain, no cartoon)
- Reads distinctly for sin vs. redemption (or relies on column position alone)
- Scales cleanly from 16px base to display sizes
- Exports as a `.png` sprite sheet and loads via `preload()` instead of vector shapes

Once art replaces the placeholder, delete the `Polygon2D` logic from `ledger_glyph.gd` and substitute an `AtlasTexture` or `TextureRect`.
