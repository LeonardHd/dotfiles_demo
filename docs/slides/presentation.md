---
marp: true
title: Dotfiles — Your Portable Dev Environment
paginate: true
footer: "dotfiles with chezmoi"
theme: default
style: |
  section { font-size: 1.4rem; }
  h1 { font-size: 2.2rem; }
  h2 { font-size: 1.7rem; }
  code { font-size: 0.95rem; }
---

# Dotfiles
## Your Portable, Parameterized AI-powered Dev Environment

---

## What Are Dotfiles?

Files (and folders) starting with `.` that configure your tools:

- `.bashrc` / `.zshrc` — shell aliases, prompt, exports
- `.gitconfig` — Git identity, aliases, diff tool
- `.vimrc` / Neovim config — editor behaviour
- `.config/*` — modern XDG-style configs

**Problem:** These are locked to one machine. 
**Solution:** Version them in Git & apply them everywhere.

---

## Why Manage Dotfiles?

| Scenario | Benefit |
|----------|---------|
| New laptop | Up and running in minutes |
| WSL distro | Same shell experience as macOS/Linux |
| Dev Container (local) | Personal aliases, git config inside container |
| GitHub Codespaces | Cloud dev with your muscle memory |

> One repo → consistent experience **everywhere**.

---

## The Evolution: From Shell to AI Workflows

Dotfiles have always been about **personal productivity**:

- Custom bash aliases & shell prompts
- Editor keybindings tuned to your muscle memory
- CLI tools like `gh`, `jq`, `fzf` configured just right

**Now, with AI-assisted engineering, the scope expands:**

- **Custom prompts** — your personal prompt library beyond shared team prompts
- **Instruction files** — `.github/copilot-instructions.md`, agent configs
- **MCP settings** — tool integrations that power your AI workflows

> Each developer has their own "HVE workflow" — the secret sauce that makes them productive. Your prompts may rely on specific CLI tools, custom configs, or unique patterns.

**Dotfiles aren't just convenience anymore — they're your AI-assisted engineering foundation.**

---

## Alternatives: Similar but Incomplete

**VS Code Settings Sync**
- Syncs settings, keybindings, extensions via Microsoft/GitHub account
- ⚠️ VS Code only — doesn't help with Neovim, JetBrains, terminal tools
- ⚠️ Static values — no templating for machine differences
- ⚠️ Cloud-only — no Git history, diffs, or PR workflows

**Custom Agents in VS Code Profile**
- Store `.agent.md` files in your VS Code user profile folder
- ⚠️ IDE-specific — won't follow you to other editors
- ⚠️ Not version-controlled by default
- ⚠️ Can't parameterize per project or OS

These are **useful features**, but they solve only part of the problem or are not as customizable.

---

## Why Dotfiles + chezmoi Wins

- ✅ **IDE Independent** — works with VS Code, Neovim, JetBrains, Emacs, any tool
- ✅ **OS Independent** — full templating for macOS / Linux / Windows / WSL differences
- ✅ **Version Controlled** — Git history, diffs, branches, PRs
- ✅ **Templating** — conditionals, variables, includes
- ✅ **Secret Management** — 1Password, Bitwarden, age, gpg integrations
- ✅ **Reproducible** — deterministic applies, no cloud merge conflicts
- ✅ **Shareable** — fork patterns, team conventions, public examples

---

## When to Use What

**VS Code Settings Sync works well when:**
- You only use VS Code across similar machines
- You want zero-effort sync of UI state, themes, extensions
- You don't need machine-specific customizations

**Custom Agents in Profile work when:**
- You want quick personal agents without repo commits
- You're prototyping before sharing with a team

**chezmoi dotfiles shine when:**
- You use multiple IDEs or terminal-based tools
- You work across macOS, Linux, WSL, Codespaces, containers
- You want **one source of truth** for your entire dev environment

> 🎯 **Dotfiles aren't just config — they're your portable AI-assisted engineering platform.**

---

## Local Machine (e.g., Unix / Mac)

```bash
# Classic approach — bare git repo
git init --bare $HOME/.dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotfiles add ~/.bashrc && dotfiles commit -m "add bashrc"
```

Works, but:

- No templating for machine-to-machine differences
- Secrets (tokens, keys) stored in plain text
- No scripting lifecycle (pre-install, post-apply)

---

## WSL (Windows Subsystem for Linux)

WSL gives you a full Linux userland on Windows.

- Your Linux dotfiles apply **as-is**
- But paths, fonts, or tools may differ from a native Linux box

> You need *conditional logic* — e.g., `{{ if eq .chezmoi.os "linux" }}`.

---

## Dev Containers (locally with Docker)

VS Code's **Dev Containers** spin up a containerised environment from `devcontainer.json`.

Personalize with a dotfiles repo:

```json
{
  "dotfiles": {
    "repository": "https://github.com/you/dotfiles",
    "targetPath": "~",
    "installCommand": "install.sh"
  }
}
```

Or set VS Code user setting:

```json
"dotfiles.repository": "your-github-id/your-dotfiles-repo"
```

> NOTE: For private repos you must add a PAT (readonly, repospecific, can be clear text ⚠️ - no the risk!)

Your shell & git config follow you **into every container**.

---

## GitHub Codespaces

Codespaces = Dev Containers **in the cloud**.

Enable dotfiles in **github.com → Settings → Codespaces**:

1. Check **Automatically install dotfiles**
2. Select your dotfiles repo
3. Optionally specify an `install.sh`

Codespaces clones your repo and runs the install script on creation.

> Result: Cloud IDE with your aliases, your prompt, your Git identity.

--- 

Demo

---

## Why chezmoi Instead of a Bare Git Repo?

| Feature | Bare Git | chezmoi |
|---------|----------|---------|
| Version control | ✅ | ✅ |
| Templates (conditionals) | ❌ | ✅ |
| Password-manager integration | ❌ | ✅ (1Password, Bitwarden, etc.) |
| Secret encryption (age, gpg) | ❌ | ✅ |
| Lifecycle scripts | ❌ | ✅ (`run_once_`, `run_onchange_`) |
| Multi-machine diffs | Manual | Built-in |

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

One command → dotfiles applied, templated, secrets decrypted.

---

## Templating Example

```bash
# dot_gitconfig.tmpl
[user]
    name = {{ .name }}
    email = {{ .email }}
{{ if eq .chezmoi.os "darwin" }}
[credential]
    helper = osxkeychain
{{ end }}
```

chezmoi evaluates templates at **apply time**, adapting to each machine.

---

## chezmoi for VS Code Settings

Store `settings.json` as a **chezmoi template**:

```jsonc
// AppData/Roaming/Code/User/settings.json.tmpl
{
  "editor.fontSize": {{ if eq .chezmoi.os "darwin" }}14{{ else }}12{{ end }},
  "terminal.integrated.shell.linux": "/bin/zsh"
}
```

- Parameterize font sizes, paths, feature flags per machine
- Mix with Settings Sync if you want — chezmoi wins for customization

---

## Recap

| Layer | Tool | Key Benefit |
|-------|------|-------------|
| Dotfiles | **chezmoi** | Templated, encrypted, scriptable |
| VS Code settings | Settings Sync **+** chezmoi | Static sync + conditional overrides |
| AI prompts | chezmoi or VSCode Settings | Versioning, git tracking |
| Environments | Dev Containers / Codespaces | Auto-apply dotfiles on creation |

---

## Getting Started

```bash
# Install chezmoi & init from your repo
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME

# Add a file
chezmoi add ~/.bashrc

# Edit the source (opens in $EDITOR)
chezmoi edit ~/.bashrc

# See what would change
chezmoi diff

# Apply changes
chezmoi apply
```

---

## Resources

- **chezmoi docs:** https://www.chezmoi.io/
- **VS Code Dev Containers:** https://code.visualstudio.com/docs/devcontainers/containers
- **GitHub Codespaces personalization:** https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account
- **This repo:** feel free to fork & customize!

---

# Questions?

<!-- Speaker notes: open the floor, demo chezmoi diff if time allows -->
