# 004 — Dev environment setup

Hector's Windows machine: Git and VS Code were already in place from the
initial bootstrap. This entry covers the rest. Global Git settings filled
in (`core.autocrlf=true`, `init.defaultBranch=main`). Installed via winget:
Godot 4.6.2 (standard build, GDScript) and Audacity 3.7.7. Installed VS Code
extensions: `geequlim.godot-tools`, `EditorConfig.EditorConfig`,
`streetsidesoftware.code-spell-checker`, `eamodio.gitlens`. The
GDScript-tabs block from SETUP.md §4 was merged non-destructively into the
existing `settings.json`; pre-existing user keys (Copilot, Python interp,
mcpServers, claudeCode) were preserved. Aseprite v1.3.17.1 was purchased
and installed to `C:\Program Files\Aseprite\`. Bfxr was used in its web form
at bfxr.net — the "downloadable desktop build" SETUP.md §5 references is no
longer linked from the site, so SETUP.md should be updated. The ElevenLabs
API key is deferred until audio work begins, per §24.3. The toolchain is
live. The next move belongs to `coding-expert`: `project.godot` does not
exist yet, and the M0 dispatch in entry 003 is what will bring it into
being.
