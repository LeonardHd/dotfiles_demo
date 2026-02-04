#!/bin/sh

############################################################
# This script installs the dotfiles and is used
# by codespaces to set up the dev container.
############################################################

# -e: exit on error
# -u: exit on unset variables
set -eu

if ! chezmoi="$(command -v chezmoi)"; then
  bin_dir="${HOME}/.local/bin"
  chezmoi="${bin_dir}/chezmoi"
  echo "Installing chezmoi to '${chezmoi}'" >&2
  mkdir -p "${bin_dir}"
  if command -v curl >/dev/null; then
    chezmoi_install_script="$(curl -fsSL https://raw.githubusercontent.com/twpayne/chezmoi/v2.69.3/assets/scripts/install.sh)"
  elif command -v wget >/dev/null; then
    chezmoi_install_script="$(wget -qO- https://raw.githubusercontent.com/twpayne/chezmoi/v2.69.3/assets/scripts/install.sh)"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
  sh -c "${chezmoi_install_script}" -- -b "${bin_dir}"
  unset chezmoi_install_script bin_dir
fi

workspace_dir=""

# Prefer the first directory under /workspaces (common in devcontainers/Codespaces).
if [ -d /workspaces ]; then
  for d in /workspaces/*; do
    if [ -d "$d" ]; then
      workspace_dir="$d"
      break
    fi
  done
fi


# Default to the script's directory.
# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# If running in Codespaces on the dotfiles repo, use /workspaces/dotfiles.
if [ -d /workspaces/dotfiles ] && [ "${CODESPACES:-}" = "true" ]; then
  script_dir="/workspaces/dotfiles"
fi

echo "script_dir=$script_dir"
echo "workspace_dir=$workspace_dir"

# Build the chezmoi arguments.
set -- init --apply --source="${script_dir}"

# Check if we have a .dotfile_chezmoi_data.json file present in the workspace.
# If so, we use it as data source to override any existing data.
if [ -f "${workspace_dir}/.dotfile_chezmoi_data.json" ]; then
  set -- "$@" --override-data-file="${workspace_dir}/.dotfile_chezmoi_data.json"
  echo "Using override data file: ${workspace_dir}/.dotfile_chezmoi_data.json"
fi

echo "Running 'chezmoi $*'" >&2
"$chezmoi" "$@"

# Symlink the .gcplhd/ directory into the workspace from `${HOME}/.gcplhd/` if it exists.
if [ -d "${HOME}/.gcplhd" ] && [ -n "$workspace_dir" ]; then
  ln -s "${HOME}/.gcplhd" "${workspace_dir}/.gcplhd"
  echo "Symlinked ${HOME}/.gcplhd to ${workspace_dir}/.gcplhd"
fi
