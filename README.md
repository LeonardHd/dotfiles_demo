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

## Documentation

See [docs/README.md](docs/README.md) for additional guides on Codespaces, Dev Containers, and more.
