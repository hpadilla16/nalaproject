# SETUP.md — Environment Walkthrough

This is the one-time setup for working on the Nala Project. Total time on a
fresh machine: ~30–45 minutes, mostly waiting for downloads.

If you only ever read prose / dialogue, you only need Git and a text editor.
The full toolchain below is for the engineering and asset side of the work.

---

## 1. Git

The repository lives at <https://github.com/hpadilla16/nalaproject>.

**macOS**: Git ships with the Xcode command-line tools. Run
`xcode-select --install` and accept the prompt.

**Windows**: Install [Git for Windows](https://git-scm.com/download/win).
Accept the defaults. Make sure "Git from the command line and also from
3rd-party software" is selected.

**Linux**: `sudo apt install git` (Debian/Ubuntu) or
`sudo dnf install git` (Fedora).

**Configure once:**

```bash
git config --global user.name  "Your Name"
git config --global user.email "your-email@example.com"
git config --global core.autocrlf input          # macOS / Linux
git config --global core.autocrlf true           # Windows
git config --global init.defaultBranch main
```

**Clone:**

```bash
git clone https://github.com/hpadilla16/nalaproject.git
cd nalaproject
```

If you have push access, set up an SSH key
(<https://docs.github.com/en/authentication/connecting-to-github-with-ssh>)
and switch the remote:

```bash
git remote set-url origin git@github.com:hpadilla16/nalaproject.git
```

---

## 2. Godot 4

The engine. Use the **latest stable 4.x** release.

Download: <https://godotengine.org/download> — pick the standard build, not
the .NET / C# build. Scripts are GDScript.

**macOS**: drag `Godot.app` into `/Applications`.
**Windows**: unzip and place `Godot_v4.x-stable_win64.exe` somewhere stable
(e.g. `C:\Tools\Godot\`). Optionally add it to PATH.
**Linux**: unzip and put the binary on PATH, e.g. `~/.local/bin/godot`.

**First run inside the repo:**

1. Open Godot.
2. Click "Import" and point at `<repo>/godot/project.godot`. (If that file
   does not exist yet, the project is still in pre-production — skip this
   step.)
3. Once imported, open it. Godot will rebuild its `.import` cache on first
   open; this is normal and is git-ignored.

**VS Code integration**: Editor → Editor Settings → Text Editor → External →
enable, and point at your VS Code binary. This makes "open in external
editor" work on script double-click.

---

## 3. Aseprite

Pixel art and animation. Aseprite is paid software (~$20) and worth it.

Download: <https://www.aseprite.org/>. License is per-machine, not
per-platform.

**Conventions for this repo (see `assets/sprites/manifest.md`):**

- `.aseprite` source files live alongside their exported `.png` and the
  exporter is responsible for keeping them in sync.
- We commit both the `.aseprite` source and the export. The source is the
  truth; the export is the artifact Godot consumes.
- Layer names matter — Godot's AnimationPlayer expects them. See the
  `pixel-art-animator` skill for the layer-name rules.

---

## 4. VS Code

Code editor. Free.

Download: <https://code.visualstudio.com/>.

**Required extensions:**

- `geequlim.godot-tools` — GDScript syntax, debugging, language server.
- `EditorConfig.EditorConfig` — honors line endings / indentation conventions
  the repo declares.

**Recommended extensions:**

- `streetsidesoftware.code-spell-checker` — catches typos in dialogue.
- `eamodio.gitlens` — git blame inline.

**Settings to set once** (Cmd/Ctrl-Shift-P → "Preferences: Open User
Settings (JSON)"):

```jsonc
{
  "editor.formatOnSave": true,
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true,
  "[gdscript]": {
    "editor.tabSize": 4,
    "editor.insertSpaces": false   // GDScript convention is tabs
  }
}
```

Then point Godot at VS Code as the external editor as described above.

---

## 5. Bfxr

Quick chip-style sound effects — UI clicks, ledger ticks, generic combat
hits. Free.

Download: <https://www.bfxr.net/>. There is a downloadable desktop build and
a web version. Either works; the desktop build saves presets.

Workflow: generate, tweak, export `.wav`, drop it in `assets/audio/sfx/`,
update `assets/audio/sfx/manifest.md`. For non-trivial diegetic SFX (Nala
vocalizations, environmental beds, anything that has to feel real) use the
ElevenLabs SFX skill instead.

---

## 6. Audacity

Audio editing — trimming, normalizing, fading, bouncing layered stems.
Free, cross-platform.

Download: <https://www.audacityteam.org/download/>.

**House conventions:**

- Bounce all final masters to 16-bit WAV at 44.1 kHz. Godot accepts MP3 and
  Ogg too, but we keep the master as WAV; an Ogg export goes in beside it
  for engine consumption when file size matters.
- Loop-able tracks must have a clean tail-into-head splice. Use the loop
  selection feature in Audacity to verify.

---

## 7. ElevenLabs (SFX + music)

The `elevenlabs-sfx-expert` and `elevenlabs-music-agent` Claude agents wrap
the ElevenLabs API. To use them you need an API key.

1. Sign up at <https://elevenlabs.io/>.
2. Generate an API key in your profile.
3. Export it where the agents can find it. The exact mechanism depends on
   how you are running the agents — typically an env var:

   ```bash
   export ELEVENLABS_API_KEY="sk-..."
   ```

   Add it to your shell rc (`~/.zshrc`, `~/.bashrc`, etc.).

The skills folders under `.agents/skills/sound-effects/` and
`.agents/skills/music/` carry their own installation notes if more setup is
needed at agent runtime.

---

## 8. Verify

From the repo root:

```bash
git status                    # clean working tree
godot --version               # 4.x.something
code --version                # any recent
```

If all three return cleanly, you are set up.

---

## Troubleshooting

**Godot says it can't find the project.** Make sure you opened the
`project.godot` file inside `godot/`, not the repo root.

**Line endings are fighting you.** Check `.gitattributes` is committed and
that `core.autocrlf` matches your platform (see Git step above).

**Aseprite exports look blurry in Godot.** Project Settings → Rendering →
Textures → Default Texture Filter → set to "Nearest". Pixel art needs
nearest-neighbor filtering.

**ElevenLabs agent errors with "API key not found".** The env var is unset
in the shell that launched the agent. Re-source your shell rc, or pass the
key explicitly per the agent skill's installation notes.
