# dotfiles

This repository contains personal dotfiles, configuration files, and helpful notes for various applications and tools and uses [chezmoi](https://www.chezmoi.io/).

## Configure for new environments

Install chezmoi via script (Unix-like systems):
```bash
cd ~
sh -c "$(curl -fsLS https://raw.githubusercontent.com/twpayne/chezmoi/v2.69.3/assets/scripts/install.sh)" -- init --apply --data=false https://github.com/LeonardHd/dotfiles_demo.git
```

Apply chezmoi via script (Windows):
```powershell
cd $HOME
iex "&{$(irm 'https://raw.githubusercontent.com/twpayne/chezmoi/v2.69.3/assets/scripts/install.ps1')} init --apply --data=false https://github.com/LeonardHd/dotfiles_demo.git"
```

Install chezmoi via script (Windows PowerShell):
```powershell
iex "&{$(irm 'https://raw.githubusercontent.com/twpayne/chezmoi/v2.69.3/assets/scripts/install.ps1')} -b '$HOME\bin'"
```

Then run (to access the `chezmoi` command later):
```powershell
$bin = Join-Path $HOME 'bin'
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')

if ($userPath -notlike "*$bin*") {
  [Environment]::SetEnvironmentVariable('Path', "$userPath;$bin", 'User')
}

# Optional: refresh PATH in the current session
$env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User')
```

> NOTE: if you're launching PowerShell from an already-running host (Windows Terminal, VS Code), new tabs/terminals inherit the host's old environment. Close/reopen the host to pick up the updated User `Path`.

## Configuration

### Git Configuration via chezmoidata

Git configuration is applied via **imperative `git config` commands** instead of a `.gitconfig` template file. This approach is used because VS Code in devcontainers writes to gitconfig, and running commands ensures the config is applied after VS Code's changes.

- User name and email from `.name` and `.email` (set in `.chezmoi.toml.tmpl` with defaults)
- Git aliases are dynamically generated from the `.git.aliases` map in chezmoidata

The `.chezmoi.toml.tmpl` uses an interactive prompt approach:
- Defaults for name/email are hardcoded in the template
- If running interactively, prompts for name and email
- Values are stored in the `[data]` section for use in templates

### Overriding Configuration with a local file 

Using a `.dotfile_chezmoi_data.json` file allows for easy customization of user-specific data without modifying the main dotfiles repository. This is particularly useful in shared or collaborative environments like Codespaces or Dev Containers.
Use a `.dotfile_chezmoi_data.json` in the workspace root (with devcontainer or codespace) with the following structure:

```json
{
    "name": "Your Name",
    "email": "your@email.com"
}
```

When this file exists in the workspace, `install.sh` uses the `--override-data-file` flag to apply these values.
Alternatively, you can manually specify a different data file when initializing chezmoi.

## Development

This project uses [Task](https://taskfile.dev/) as a task runner. Task is pre-installed in the dev container.

### Available Commands

| Command | Description |
|---------|-------------|
| `task` | List available tasks |
| `task local:init` | Initialize and apply chezmoi with default settings |
| `task local:init-with-data` | Initialize and apply chezmoi with custom data file |
| `task local:init-no-data` | Initialize and apply chezmoi without data prompts |

### Quick Start

```bash
# List all available tasks
task

# Apply dotfiles locally (standard)
task local:init

# Apply dotfiles with custom data override
task local:init-with-data

# Apply dotfiles without prompting for data
task local:init-no-data
```

## Documentation

See [docs/README.md](docs/README.md) for additional guides on Codespaces, Dev Containers, and more.
