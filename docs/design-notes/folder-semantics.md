# Folder semantics

Where things live, and — more importantly — why they live there. Read this
before you propose a structural change.

## Top-level

- `Nala_Project_Design_Bible.docx` — canonical content. Edit only with
  intent. Every change is a change to game truth.
- `CLAUDE.md` — read-first directive for any agent or contributor. Maps the
  repo, names the agents, restates the tonal rules.
- `README.md` — public-facing. Brief. Points at the bible, the trilogy
  structure, and the GitHub repo.
- `SETUP.md` — environment walkthrough. Git, Godot 4, Aseprite, VS Code,
  Bfxr, Audacity, ElevenLabs.
- `.gitignore`, `.gitattributes` — version-control hygiene. Godot 4 +
  Aseprite + IDE/OS exclusions; line endings and binary handling.

## `.claude/agents/`

The seven specialist prompts. Each carries a FIRST ACTION directive at the
top instructing the agent to read CLAUDE.md before starting. The boundary
between specialists is intentional: the aseprite-expert animates,
the pixel-art-sprite-expert draws static frames, the coding-expert wires
them into Godot, the ui-ux-expert designs the surfaces the player reads,
the two ElevenLabs agents own audio, and the lead PM dispatches.

## `.agents/skills/`

Installed skill bundles. Five skills are wired here:
`sound-effects`, `music`, `pixel-art-animator`, `pixel-art-sprites`,
`ui-ux-pro-max`. Each agent prompt names which skill it uses. Skills are
treated as third-party dependencies — keep them under
`.agents/skills/` and read their `SKILL.md` before invoking them.

## `godot/`

The Godot 4 project root. `project.godot` lives here. Subfolders for
`scenes/`, `scripts/`, `resources/`. Tunable values (mortality bleed
rates, ledger thresholds, rescue probability tables — all flagged in
§24.4) live as `.tres` resources under `resources/tunables/`, not as
hardcoded constants. Playtest data replaces them without code changes.

The directory currently holds a `.gitkeep` placeholder. The
`coding-expert` lands the first real scene.

## `assets/`

Source-of-truth for art and audio. Not consumed directly by the engine —
the engine reads exports. Specifically:

- `assets/sprites/` holds `.aseprite` sources alongside their `.png`
  exports. The sources are the truth; the exports are artifacts.
  `assets/sprites/_palette/nala_project.gpl` is the project palette.
- `assets/audio/music/` holds bounced WAV masters and Ogg engine
  companions. Audacity project bundles are not committed.
- `assets/audio/sfx/` same convention.

Every leaf folder under `assets/` either has content or carries a
`.gitkeep`. Every category folder has a `manifest.md` listing what's in
it, what bible section it serves, and what's still placeholder.

## `build/`

Export targets — Godot's compiled outputs for desktop, web, etc. Payloads
are gitignored; the directory is tracked via `.gitkeep` so the structure
is visible in fresh clones.

## `docs/`

Long-form prose that isn't the bible.

- `docs/devlog/` — sequential journal. One file per meaningful change,
  numbered `NNN-slug.md`. The `?` suffix flags open questions.
- `docs/design-notes/` — durable design rationale. This file lives here.
  Future entries will accumulate as design decisions get made: protagonist
  naming logic, pronoun handling, save format, tunable defaults, etc.

## What does *not* live in this repo

- The mental health consultant's notes, sensitivity-read feedback, and
  any voice-actor session takes that contain real names. Those go in a
  separate, access-controlled space. The bible mentions §24.2's reads
  but does not store the readers' words.
- Real Shiba reference recordings, until the partnership is formalized
  and licensing is clear (§24.3).
- Any private contact information for collaborators.

## Why these boundaries

Two reasons. First, source-of-truth separation: a sprite source is not the
same artifact as an exported sprite, and code and content are not the
same artifact as either. Second, agent ownership: each specialist has one
folder family they own and a manifest that documents their work. When the
lead PM hands a task off, the boundary tells everyone where the work
lands.
