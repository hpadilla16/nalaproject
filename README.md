# Nala Project

A narrative-driven action game about a young man dying in his apartment from
emotional collapse. He descends in a dream-state through Dante's nine circles
of hell, guided by his real-world Shiba Inu, Nala. His choices — especially
whether he stays loyal to her or abandons her for new dogs found in each
circle — determine which of three endings he earns: Return to Life, Heaven,
or Lost Forever.

The mechanic is the morality. Every betrayal of his dog is a small act of
treachery in a hell where treachery is the deepest sin. Every rescue is a
costly act of repentance.

Repository: <https://github.com/hpadilla16/nalaproject>

## Status

Pre-production. The design bible is complete; vertical-slice implementation
has not begun. Section 24 of the bible (`Nala_Project_Design_Bible.docx`)
tracks what is still being drafted, decided, or built.

## Trilogy structure

The descent ships as a trilogy.

- **Part 1 — Sins of Incontinence.** Prologue, Lust, Gluttony, Greed, Wrath
  (and Sullenness). Establishes the protagonist, Nala, the Bond-Scarf, the
  ledger, mortality, the wager, and the rescue mechanic.
- **Part 2 — Sins of Violence.** Heresy and Violence (Phlegethon, the Wood
  of Suicides, the Burning Sand).
- **Part 3 — Sins of Fraud.** Malebolge and Cocytus (Caina, Antenora,
  Ptolomaea, Judecca). The wake-up cinematic closes the Return-to-Life run.

## Tools

Godot 4, Aseprite, Bfxr, Audacity, ElevenLabs (SFX and music), VS Code with
the `godot-tools` extension. See `SETUP.md` for install steps.

## Layout

The `CLAUDE.md` file at the repo root is the read-first directive for any
agent or contributor sitting down with this codebase. It explains the layout,
the conventions, the tonal rules, and the agent dispatch model.

```
Nala_Project_Design_Bible.docx   canonical reference
CLAUDE.md                        read-first directive
SETUP.md                         environment walkthrough
.claude/agents/                  specialist agent prompts
godot/                           Godot 4 project
assets/sprites/                  Aseprite sources + exports
assets/audio/{music,sfx}/        bounced audio + sources
docs/devlog/                     sequential devlog
docs/design-notes/               folder semantics, design rationale
build/                           export targets
```

## Tonal rules

Three rules govern every line of dialogue, every UI string, every devlog
entry. They are pulled verbatim from §23.8 of the design bible.

1. No therapy-textbook language. "You are valid." or "Your feelings matter."
   are forbidden. The game speaks in specific, slightly awkward,
   real-sounding sentences.
2. No villain monologues. The game has no villain.
3. Brevity. The lines are triggers, not explanations.

## Content note

The game depicts depression, suicidal ideation, family abandonment, and
self-harm imagery. The Wood of Suicides, the Self-Blasphemer, and two hidden
run-enders specifically are sensitivity-gated and require reads from people
with lived experience before they ship. See bible §24.2.

## License

TBD. The design bible, prose, dialogue, art, and audio are not yet under any
public license. Do not redistribute without explicit permission from the
project owner.
