# Sprites Manifest

This manifest tracks every sprite asset in the project — its source, its
status, and the bible section it serves. Maintain it religiously. The
animator and the engineer both read this file before they touch a sprite
they didn't make.

The format below is the contract. New entries get appended in the
appropriate table.

---

## Conventions

- All sources are `.aseprite`. All exports are `.png` next to the source.
- Project palette: `assets/sprites/_palette/nala_project.gpl`. No
  off-palette pixels.
- Filenames: lowercase, hyphenated, scene- or character-tagged.
- Status vocabulary: `concept`, `blockout`, `final`, `animated`. The
  aseprite-expert flips a sprite to `animated` after handoff is complete.

---

## Characters

| Character        | Source                                                      | Status | Bible §       | Notes |
| ---------------- | ----------------------------------------------------------- | ------ | ------------- | ----- |
| Protagonist      | `characters/protagonist/protagonist.aseprite`               | —      | §2, §22       | Posture: exhausted, slumped. Class affects posture, not bravado. |
| Nala             | `characters/nala/nala.aseprite`                             | —      | §3            | Warmth anchor. Body-language warning system. Bond-Scarf is a separate layer. |
| The Beauty       | `characters/circle_dogs/beauty/beauty.aseprite`             | —      | §8.5, §14.2   | Afghan Hound. Cap 4. Magnetic silhouette. |
| The Hound        | `characters/circle_dogs/hound/hound.aseprite`               | —      | §12.5, §14.2  | Saint Bernard / Mastiff. Cap 4. |
| The Watcher      | `characters/circle_dogs/watcher/watcher.aseprite`           | —      | §15, §14.2    | Doberman. Cap 5. |
| The Snarl        | `characters/circle_dogs/snarl/snarl.aseprite`               | —      | §16.4, §14.2  | Cane Corso / Pit Bull. Cap 5. |
| The Skeptic      | `characters/circle_dogs/skeptic/skeptic.aseprite`           | —      | §17.6, §14.2  | Greyhound. Cap 4. |
| The Rending      | `characters/circle_dogs/rending/rending.aseprite`           | —      | §18.5, §14.2  | Dire-wolf shape. Cap 6. |
| The Charmer      | `characters/circle_dogs/charmer/charmer.aseprite`           | —      | §19.5, §14.2  | Border Collie. Cap 6. |
| The Last         | `characters/circle_dogs/last/last.aseprite`                 | —      | §14.2, §20.4  | No fixed breed. Cap 8. |

## Bosses

| Boss        | Source                                          | Status | Bible §  | Notes |
| ----------- | ----------------------------------------------- | ------ | -------- | ----- |
| Cerberus    | `characters/bosses/cerberus.aseprite`           | —      | §12.3    | 64×64. |
| Plutus      | `characters/bosses/plutus.aseprite`             | —      | §15.3    | 64×64. |
| Phlegyas    | `characters/bosses/phlegyas.aseprite`           | —      | §16.3    | 64×64. Refusal posture. |
| Geryon      | `characters/bosses/geryon.aseprite`             | —      | §18.10   | 64×64. |
| The Last    | (see characters table)                          | —      | §20.4    | Final fight has three forms. |

## Environments

| Environment            | Source                                           | Status | Bible §  | Notes |
| ---------------------- | ------------------------------------------------ | ------ | -------- | ----- |
| Prologue apartment     | `environments/prologue_apartment/`               | —      | §6       | The kitchen, the floor, the friend's voicemail device. No Bond-Scarf visible. |
| Limbo                  | `environments/limbo/`                            | —      | §6 Beat 7, §4.8 | The Class Stone variants. |
| Lust grotto            | `environments/lust_grotto/`                      | —      | §8.2     | Warmest hue in the game. |
| Gluttony feast hall    | `environments/gluttony_feast_hall/`              | —      | §12.2    | Wet, brass, rotten. |
| Greed vault            | `environments/greed_vault/`                      | —      | §15.2    | Anomalous gold. |
| Wrath / Styx           | `environments/wrath_styx/`                       | —      | §16.2    | Surface and sullen deep. |
| Heresy plain of tombs  | `environments/heresy_tombs/`                     | —      | §17.2    | Empty cathedral feel. |
| Wood of Suicides       | `environments/violence_wood/`                    | —      | §11.4, §11.3 | Restraint per §11.3 — non-negotiable. |
| Burning Sand           | `environments/violence_sand/`                    | —      | §18.7    | |
| Malebolge              | `environments/fraud_malebolge/`                  | —      | §19.2    | Ten bridges. |
| Cocytus / Caina        | `environments/treachery_caina/`                  | —      | §10.2    | One step away from B&W. |
| Wake-up apartment      | `environments/wakeup_apartment/`                 | —      | §31      | Same room as prologue, different light. |

## Props

| Prop         | Source                                   | Status | Bible §   | Notes |
| ------------ | ---------------------------------------- | ------ | --------- | ----- |
| Bond-Scarf   | `props/bond_scarf/bond_scarf.aseprite`   | —      | §4.6      | Single specific color, project palette. **Never appears in prologue.** |
| Class Stones | `props/class_stones/`                    | —      | §4.8      | Sword, Staff, Shield variants. |
| The Phone    | `props/phone/`                           | —      | §6 Beat 1, §31.1 | Realistic, not stylized. |

## UI art

UI raster art (icons, glyphs, frames, the Mortality clock visual, the
Ledger glyphs) is requested by the `ui-ux-expert` and lives under
`ui_art/`. See `assets/sprites/ui_art/manifest.md` (or its absence — file it
when the first piece of UI art lands).

---

## Palette additions

When a sprite needs a color the project palette doesn't carry, propose the
addition here before sampling it. The palette grows by deliberate choice,
not by accident.

| Proposed color | Hex | Proposed by | For | Approved? |
| -------------- | --- | ----------- | --- | --------- |
| —              | —   | —           | —   | —         |
