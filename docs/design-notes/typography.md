# Typography Choice — M1

## Font Selection: Default Godot Font

**Placeholder Choice (M1):** Default Godot sans-serif system font. No custom `.ttf` loaded.

**Rationale:** M1 scope is visual structure, not final typography polish. The default font is legible, supports all characters needed for dialogue and UI labels, and has good contrast at the sizes used (12–14px for body, 16px+ for labels).

**Accessibility:** The font meets minimum legibility at intended sizes. Contrast against panel backgrounds is acceptable for M1 (dark text on light panels, or light text on dark).

**M2+ Migration Plan:** Select a humane, free-licence sans-serif (e.g., Atkinson Hyperlegible or Inter) and place the `.ttf` binary under `assets/fonts/`. Update dialogue_runner.tscn and all UI scenes to load via `[ext_resource]` and apply via theme overrides. Typography will be the first M2 UI polish task.

## Font Sizes (Established)

- Body text (dialogue): 12–14px
- Speaker label: 12px
- Ledger column headers: 14px
- Mortality HUD: implicit (vector-drawn)

## Notes

- The Tonal Rules (§23.8) apply: brevity and clarity trump decoration.
- No decorative fonts or hand-written styles in-game.
- All typography must pass colorblind-considerate contrast checks (4.5:1 normal text minimum).
