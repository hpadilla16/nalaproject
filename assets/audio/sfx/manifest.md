# SFX Manifest

Every sound effect in the project. Maintained by the
`elevenlabs-sfx-expert`. Bfxr-sourced SFX are listed here too — the
manifest is engine-agnostic about source, just tags it.

---

## Conventions

- Master: 16-bit WAV, 44.1 kHz. Mono unless space matters.
- Cues: normalize to -12 LUFS. Ambient beds: -18 LUFS.
- Filenames: lowercase, hyphenated, scene-tagged
  (`lust_grotto_water-drip.wav`, `ui_ledger_mark.wav`).
- Source vocabulary: `bfxr`, `elevenlabs`, `recording`.
- `placeholder: true` flag is for any Nala vocalization generated before
  the real-Shiba reference partnership lands. (Bible §24.3.)

---

## UI

| SFX                  | File                            | Source | Bible § | Notes |
| -------------------- | ------------------------------- | ------ | ------- | ----- |
| Ledger mark — Sin    | `ui/ledger_sin.wav`             | bfxr   | §4.3    | Brief etch sound. |
| Ledger mark — Redem. | `ui/ledger_redemption.wav`      | bfxr   | §4.3    | Different etch tone. |
| Mortality tick       | `ui/mortality_tick.wav`         | bfxr   | §4.4    | Faint, not metronomic. |
| Dialogue advance     | `ui/dialogue_advance.wav`       | bfxr   | §23     | Discreet. |
| Class Stone select   | `ui/class_stone_select.wav`     | elevenlabs | §4.8 | Stone-on-stone resonance. |

## Nala vocalizations (placeholder until reference)

| SFX                  | File                            | Source | Placeholder | Bible § |
| -------------------- | ------------------------------- | ------ | ----------- | ------- |
| Growl                | `nala/growl.wav`                | elevenlabs | true | §3, §4.2 |
| Stare-cue (silent breath) | `nala/stare-cue.wav`       | elevenlabs | true | §4.2 |
| Refuse-to-advance whine   | `nala/refuse.wav`          | elevenlabs | true | §4.2 |
| Lead-ahead bark           | `nala/lead.wav`            | elevenlabs | true | §3 |
| Tug bark (illusion break) | `nala/tug.wav`             | elevenlabs | true | §3 |
| Wake-up lick              | `nala/wake-up_lick.wav`    | elevenlabs | true | §4.6, §31 |

> **All Nala vocalizations are placeholder until the real-Shiba reference
> partnership lands.** See bible §24.3.

## Combat verbs

| SFX                  | File                            | Source | Bible § | Notes |
| -------------------- | ------------------------------- | ------ | ------- | ----- |
| Throw — debris pickup| `combat/throw_pickup.wav`       | bfxr   | §4.7    | |
| Throw — impact       | `combat/throw_impact.wav`       | bfxr   | §4.7    | |
| Sic — Nala lunge     | `combat/sic_lunge.wav`          | elevenlabs | §4.7 | Nala-vocal placeholder. |
| Sic — kill bite      | `combat/sic_kill.wav`           | elevenlabs | §4.7 | Nala-vocal placeholder. |

## Environmental beds

| Bed                          | File                                  | Source | Bible § | Notes |
| ---------------------------- | ------------------------------------- | ------ | ------- | ----- |
| Apartment — prologue         | `beds/prologue_apartment.wav`         | recording? | §6 | Realistic room tone. |
| Limbo                        | `beds/limbo.wav`                      | elevenlabs | §6 B7 | |
| Lust grotto                  | `beds/lust_grotto.wav`                | elevenlabs | §8.5  | |
| Gluttony feast hall          | `beds/gluttony_feast_hall.wav`        | elevenlabs | §12.2 | |
| Greed vault                  | `beds/greed_vault.wav`                | elevenlabs | §15.5 | |
| Wrath surface                | `beds/wrath_surface.wav`              | elevenlabs | §16.5 | |
| Wrath sullen deep            | `beds/wrath_deep.wav`                 | elevenlabs | §16.6 | Underwater, muffled. |
| Heresy                       | `beds/heresy.wav`                     | elevenlabs | §17.2 | |
| Wood of Suicides             | `beds/wood.wav`                       | elevenlabs | §11.4 | Wind. Restraint per §11.3. |
| Burning Sand                 | `beds/burning_sand.wav`               | elevenlabs | §18.7 | |
| Malebolge                    | `beds/malebolge.wav`                  | elevenlabs | §19.2 | |
| Caina ice                    | `beds/caina_ice.wav`                  | elevenlabs | §10.2 | Cold. |
| Wake-up apartment            | `beds/wakeup_apartment.wav`           | recording? | §31 | Same room, different time. |

## Three high-stakes SFX (per agent prompt)

These three need particular care; flagged for repeated review:

| SFX                          | File                                  | Why |
| ---------------------------- | ------------------------------------- | --- |
| Wake-up phone ring           | `wakeup/phone_ring.wav`               | First sound outside the dream. Real, not stylized. (§31.1) |
| Kitchen-vision Nala bark     | `gluttony/nala_bark_kitchen.wav`      | Cuts the vision. Jarring vs. room tone. (§12.4 E2) |
| Wake-up lick (also above)    | `nala/wake-up_lick.wav`               | The proof. Wet, close-mic'd, real. (§4.6, §31) |
