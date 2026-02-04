# Codespaces & Dev Containers

## Codespaces

GitHub Codespaces uses the `install.sh` script to set up the environment.
So dotfiles are automatically installed when creating a new codespace (even in
this repository).

To apply local changes to the codespace, run the following command in the terminal
(assuming PWD is root of the dotfiles)

```bash
chezmoi init --apply --data=false --source=.
```

## Dev container VSCode Settings

VSCode allows customization of the development container via dotfiles.

Use the following user settings to enable dotfiles in the dev container:

```json
{
    "dotfiles.repository": "LeonardHd/dotfiles_demo",
    "dotfiles.targetPath": "~/dotfiles",
    "dotfiles.installCommand": "install.sh",
}
```

## Override Chezmoi data (Codespace + Dev container)

You can override the Chezmoi data used in this repository by creating a file
named `.dotfile_chezmoi_data.json` in the root of the repository.

An example file is provided in `.dotfile_chezmoi_data.json.example`.

### Additional information on Codespaces

- The `install.sh` script is run in the codespace environment.  
  See <https://docs.github.com/en/codespaces/setting-your-user-preferences/personalizing-github-codespaces-for-your-account#dotfiles> for more information.
- To see creation logs in the codespace, use the `View Creation Log` command or check the file `/workspaces/.codespaces/.persistedshare/creation.log`.
