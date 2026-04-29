# CLAUDE.md — Read This First

> **Read-first directive.** Any agent or Claude session that opens this repo
> reads this file before doing anything else, then opens
> `Nala_Project_Design_Bible.docx` and skims the table of contents and
> Section 24 (Production Roadmap) before touching code, art, audio, prose, or
> tooling. The bible is canonical. This file is a map; the bible is the
> territory.

---

## What this project is

A narrative-driven action game about a young man dying in his apartment from
emotional collapse. He descends in a dream-state through Dante's nine circles
of hell, guided by his real-world Shiba Inu, Nala. His choices — especially
whether he stays loyal to her or abandons her for new dogs found in each
circle — determine which of three fates he earns: Return to Life, Heaven, or
Lost Forever.

The mechanic is the morality. Every betrayal of his dog is a small act of
treachery in a hell where treachery is the deepest sin. Every rescue is a
costly act of repentance. The system delivers theme without ever speaking it
out loud.

The single most important sentence in the bible: **the game does not lecture.
The lines are triggers, not explanations.**

---

## Trilogy structure

The descent ships as a trilogy. Part divisions follow Dante's three macro
categories of sin.

**Part 1 — Sins of Incontinence**
Prologue + Circle 2 (Lust) + Circle 3 (Gluttony) + Circle 4 (Greed) + Circle 5
(Wrath / Sullenness). Establishes the protagonist, Nala, the Bond-Scarf, the
ledger, mortality, the wager, the rescue mechanic. Ends at the gates of Dis.

**Part 2 — Sins of Violence**
Circle 6 (Heresy) + Circle 7 (Violence: Phlegethon, the Wood of Suicides,
the Burning Sand). The Wood of Suicides is the most sensitive beat in the
trilogy and is gated by the sensitivity-read process described in §24.2.

**Part 3 — Sins of Fraud**
Circle 8 (Malebolge) + Circle 9 (Cocytus: Caina, Antenora, Ptolomaea,
Judecca). The Caina family-in-the-ice encounter is the keystone (§10). The
final fight has three forms (§20.4) and the wake-up cinematic (§31) is the
last thing the player sees in the Return-to-Life ending.

---

## Tonal rules — non-negotiable (Bible §23.8)

These are the three rules every dialogue line, every UI string, every
in-game prompt, and every devlog entry honors.

1. **No therapy-textbook language.** "You are valid." "Your feelings matter."
   are forbidden. They are correct but they are not how this game speaks.
   The game speaks in specific, slightly awkward, real-sounding sentences.
2. **No villain monologues.** The game has no villain. Every cruel option
   in dialogue is something the player chooses; nothing in the world delivers
   a speech against the protagonist.
3. **Brevity above all.** Every line is short. The game does not lecture.
   The player has been doing the work of meaning-making for thirty hours by
   the time these lines land. The lines are triggers, not explanations.

If a line you are about to write would also fit on a self-help bookmark, cut
it.

---

## Repository layout

```
Nala_Project/
├── CLAUDE.md                       ← you are here
├── README.md                       ← public-facing
├── SETUP.md                        ← environment walkthrough
├── Nala_Project_Design_Bible.docx  ← canonical reference
├── .gitignore
├── .gitattributes
├── .claude/
│   └── agents/                     ← specialist agent prompts
│       ├── lead-project-manager.md
│       ├── coding-expert.md
│       ├── elevenlabs-sfx-expert.md
│       ├── elevenlabs-music-agent.md
│       ├── aseprite-expert.md
│       ├── pixel-art-sprite-expert.md
│       └── ui-ux-expert.md
├── .agents/
│   └── skills/                     ← installed skill bundles (sound-effects,
│                                     music, pixel-art-animator,
│                                     pixel-art-sprites, ui-ux-pro-max)
├── godot/                          ← Godot 4 project root (project.godot,
│                                     scenes/, scripts/, resources/)
├── assets/
│   ├── sprites/                    ← Aseprite sources + exported PNGs
│   │   └── manifest.md
│   └── audio/
│       ├── music/                  ← stems + bounced tracks
│       │   └── manifest.md
│       └── sfx/                    ← Bfxr/ElevenLabs SFX
│           └── manifest.md
├── build/                          ← export targets (gitignored payloads)
└── docs/
    ├── devlog/
    │   ├── README.md
    │   └── 000-genesis.md
    └── design-notes/
        └── folder-semantics.md
```

The `godot/`, `assets/sprites/`, `assets/audio/`, and `build/` directories
contain a `.gitkeep` while empty so the structure tracks before content
arrives.

---

## How to work in this repo

**For any agent picking up a task:**

1. Read this file (you are doing it).
2. Open `Nala_Project_Design_Bible.docx`. Skim the TOC. Read Section 24
   (Production Roadmap) — it lists what needs drafting, deciding, or building.
3. Read the section relevant to your task. If your task touches the Wood of
   Suicides, the Self-Blasphemer, the Take-His-Place ending, or the
   Lie-Down ending, also re-read §24.2 and §11. Those four beats are gated by
   sensitivity reads.
4. Read your specialist prompt at `.claude/agents/<your-role>.md`.
5. Do the smallest correct version of the work. Brevity applies to code and
   prose alike.
6. Append a one-paragraph devlog entry to `docs/devlog/` describing what you
   changed and why. Number it sequentially after `000-genesis.md`.

**Default tools (see `SETUP.md` for install steps):**
- Engine: Godot 4 (latest stable 4.x).
- Pixel art: Aseprite (sources committed, exports auto-generated).
- Code editor: VS Code with the `godot-tools` extension.
- SFX: Bfxr for retro chip-style; ElevenLabs SFX skill for cinematic /
  organic / Nala vocalizations.
- Music: Audacity for editing and bouncing; ElevenLabs music skill for
  composition drafts.
- Source control: Git, origin = `https://github.com/hpadilla16/nalaproject`.

**Default agents (in `.claude/agents/`):**

| Agent                       | Owns                                                          |
| --------------------------- | ------------------------------------------------------------- |
| `lead-project-manager`      | Roadmap, sequencing, agent dispatch, devlog hygiene           |
| `coding-expert`             | Godot 4 / GDScript, scene graph, save system, ledger logic    |
| `elevenlabs-sfx-expert`     | Diegetic SFX, Nala vocalizations, environmental audio         |
| `elevenlabs-music-agent`    | Score and silence — sparingly, per §24.3                      |
| `aseprite-expert`           | Animation, frame timing, walk cycles, idles                   |
| `pixel-art-sprite-expert`   | Static sprites, tilesets, characters, environments            |
| `ui-ux-expert`              | Dialogue boxes, Mortality clock, Ledger UI, character-create, wake-up cinematic title card |

---

## Design conventions

**Mortality is the unified currency.** No HP/MP/stamina/gold parallel
systems. Time is the only thing.

**The Bond-Scarf does not appear in the prologue.** It first appears when
Nala brings it to the protagonist in Limbo. Its persistence into the
Return-to-Life ending is the proof that everything down there was real. Do
not leak it earlier.

**Nala's warnings are body language, never UI.** No "Nala disapproves"
prompt, ever. A growl, a stare, a refusal to advance. The player must read
her like a real dog. (Bible §4.2.)

**Score is sparse.** Music absent in the Wood, in Caina, in the wake-up.
Music is a reward we use sparingly. (Bible §24.3.)

**Names belong to the player.** The protagonist is named at character-create.
Pronouns selectable. Family composition selectable. UI / dialogue scaffolding
must accommodate this.

---

## When you are done with a task

Commit with a message that describes the change in plain language. Push to
`origin/main`. Append your devlog entry. If you opened a question that needs
a human decision, file it in `docs/devlog/` with an `-open` suffix in the
filename (e.g. `005-foo-question-open.md`) and call it out in the commit
body. (`?` is not a legal Windows filename character — `-open` is the
portable equivalent.)
