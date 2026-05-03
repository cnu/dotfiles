# dotfiles

Personal dotfiles for an Arch Linux + Hyprland (Omarchy) setup, tracked with the
[Atlassian bare-repo method](https://www.atlassian.com/git/tutorials/dotfiles).

No symlinks, no `stow`, no moving files around. The bare repo lives at `~/.cfg/`
and a `config` alias runs git with `$HOME` as the work tree, so files stay where
applications expect them.

## Install on a new machine

```bash
# 1. Get the alias into the current shell
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# 2. Don't show the rest of $HOME as untracked
echo ".cfg" >> .gitignore

# 3. Clone the bare repo
git clone --bare <repo-url> $HOME/.cfg

# 4. Check out into $HOME (move any conflicts aside first)
mkdir -p .config-backup
config checkout 2>&1 | grep -E "\s+\." | awk '{print $1}' \
  | xargs -I{} sh -c 'mkdir -p .config-backup/$(dirname {}) && mv {} .config-backup/{}'
config checkout

# 5. Make status quiet about untracked files
config config --local status.showUntrackedFiles no

# 6. Persist the alias
echo "alias config='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'" >> ~/.bashrc
```

## Day-to-day usage

```bash
config status                       # what changed
config diff                         # review changes
config add <path>                   # stage a new/changed file
config commit -m "tweak hyprland binds"
config push                         # if a remote is configured

config ls-files                     # everything tracked
config log --oneline
```

`config` is just `git` — every git subcommand works.

## What's tracked

| Group | Paths |
|---|---|
| Shell | `.bashrc`, `.bash_profile`, `.bash_logout`, `.profile`, `.zshrc`, `.XCompose` |
| Desktop | `.config/{hypr,omarchy,waybar,walker,mako,fontconfig,environment.d}` |
| Terminals | `.config/{alacritty,kitty,ghostty}` |
| Editors / prompt | `.config/{nvim,tmux,fish,starship.toml}` |
| CLI tools | `.config/{btop,fastfetch,lazygit,lazydocker,mise}` |
| Git | `.config/git/config` |

## What's not tracked

See `.gitignore`. In short: secrets (`~/.ssh`, `.config/gh`, keyrings),
caches and regenerable state (`.cache`, `.cargo`, `.vscode`, Steam, npm),
browser/IDE state (Chromium, Brave, VS Code, Zed, OBS), shell history files,
and externally-sourced theme repos under `.config/omarchy/themes/`
(reinstall via the omarchy theme command after a fresh checkout).

## Adding a remote later

```bash
gh repo create dotfiles --private --source=$HOME/.cfg --remote=origin --push
# or
config remote add origin git@github.com:<you>/dotfiles.git
config push -u origin master
```
