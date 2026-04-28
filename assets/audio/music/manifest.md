# Music Manifest

Every music cue in the project. Maintained by the
`elevenlabs-music-agent`. The agent updates this file every time a track
lands, gets revised, or is consciously *not* delivered for a beat that
deserves silence.

The score is sparse on purpose (Bible §24.3). This manifest tracks the
silences as deliberately as it tracks the cues.

---

## Conventions

- Master: 16-bit WAV, 44.1 kHz, stereo, normalized to -18 LUFS.
- Engine companion: Ogg Vorbis, q5, same level.
- Filenames: lowercase, hyphenated, scene-or-cue-tagged
  (`lust_arrival.wav`, `endings_return-to-life.wav`).
- Status vocabulary: `concept`, `draft`, `final`, `intentional-silence`.

---

## Cues

| Cue                          | File                                | Status               | Length | Bible § | Notes |
| ---------------------------- | ----------------------------------- | -------------------- | ------ | ------- | ----- |
| Prologue hallucinations      | `prologue/hallucinations.wav`       | —                    | —      | §6 B3–5 | Recede on Nala's bark. |
| Limbo / Class Stone          | `limbo/class_stone.wav`             | —                    | —      | §4.8    | Three resolutions on player choice. |
| Lust arrival                 | `lust/arrival.wav`                  | —                    | —      | §8.1    | Warmth turning cloying. |
| Gluttony arrival             | `gluttony/arrival.wav`              | —                    | —      | §12.1   | Wet brass. |
| Greed arrival                | `greed/arrival.wav`                 | —                    | —      | §15.1   | Brittle metal. |
| Wrath arrival                | `wrath/arrival.wav`                 | —                    | —      | §16.1   | Water and iron. |
| Heresy arrival               | `heresy/arrival.wav`                | —                    | —      | §17.1   | Empty cathedral. |
| Violence Ring I bed          | `violence/phlegethon_bed.wav`       | —                    | —      | §18.4   | Blood-river drone. |
| Violence Burning Sand        | `violence/burning_sand_bed.wav`     | —                    | —      | §18.7   | Ambient bed; Self-Blasphemer himself unscored. |
| Malebolge bridges            | `fraud/bridges.wav`                 | —                    | —      | §19.3   | |
| Caina — final wager (rescued)| `treachery/final_wager.wav`         | —                    | —      | §10.8   | Only plays if dogs were rescued. |
| Ending I — Return to Life    | `endings/return-to-life.wav`        | —                    | —      | §21.1   | The only hopeful piece in the game. |
| Ending II — Heaven           | `endings/heaven.wav`                | —                    | —      | §21.2   | |
| Ending III — Lost Forever    | `endings/lost-forever.wav`          | —                    | —      | §21.3   | |

## Deliberate silences (do not score)

| Beat                                            | Bible § | Why |
| ----------------------------------------------- | ------- | --- |
| Wood of Suicides                                | §11     | Wind, harpies, the tree's voice. |
| Caina (until the rescued-dogs branch only)      | §10     | The cold and the tears. |
| Wake-up cinematic                               | §31     | The friend's voice and the lick. |
| Self-Blasphemer encounter (within Burning Sand) | §29     | Bed continues; blasphemer himself unscored. |

---

## Pending decisions affecting music

- Music absence in the **Lie-Down hidden run-ender** and the **Take-His-
  Place hidden run-ender**. Default assumption: silent. Confirm before
  scoring. (Bible §24.5.)
- Default highlighted Class at the Limbo Stone affects which resolution of
  the Class Stone cue plays first to the player. (§24.5.)
