# Dotfiles

My dotfiles, hopefully I don't change them too frequently. Used across macOS, Arch Linux, and other Linux distros. Some configs are platform-specific (e.g. AeroSpace on macOS, Hyprland on Linux).

## Setup

```sh
git clone git@github.com:vmiclott/dotfiles.git $HOME/.config
```

## Git

| Alias     | Command                 |
| --------- | ----------------------- |
| `co`      | checkout                |
| `cp`      | cherry-pick             |
| `dag`     | graph log               |
| `pushfwl` | push --force-with-lease |

Settings: rebase on pull, simple push default, auto-setup remote.

Add to `~/.gitconfig`:

```ini
[include]
    path = ~/.config/git/gitconfig
```

## Zsh

Requires ohmyzsh to be installed

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Uses `ZDOTDIR` to store config in `~/.config/zsh`. The home directory's `.zshenv` sources the config directory:

```sh
ZDOTDIR=$HOME/.config/zsh
source -- "$ZDOTDIR"/.zshenv
```

## Mise

Runtime version manager for all languages. Install [mise](https://mise.jdx.dev), then:

```sh
mise install
```

Managed tools: Node.js, Ruby, Python, Go, Java (Corretto).

## Ghostty

Minimal terminal config using the Catppuccin Macchiato theme.

## Atuin

Shell history with sync enabled. `UP` for session history, `C-r` for global history.

## AeroSpace

Tiling window manager for macOS. Starts at login, no gaps, tiling layout by default.

| Key                       | Action                    |
| ------------------------- | ------------------------- |
| `ALT + HJKL`              | Move focus (vim-style)    |
| `ALT + SHIFT + HJKL`      | Move window               |
| `ALT + /`                 | Toggle tiles layout       |
| `ALT + ,`                 | Toggle accordion layout   |
| `ALT + -/=`               | Resize                    |
| `ALT + SHIFT + F`         | Fullscreen                |
| `ALT + 1-9/A/P/V`         | Switch to workspace       |
| `ALT + SHIFT + 1-9/A/P/V` | Move window to workspace  |
| `CTRL + SHIFT + ←/→`      | Move workspace to monitor |
| `ALT + SHIFT + ;`         | Enter service mode        |

Service mode: `ESC` to reload config, `R` to reset layout, `ALT + SHIFT + HJKL` to join windows.

Auto-assigns Ghostty to workspace 5 and VS Code to workspace 6.

## Hyprland

Wayland compositor config with the following keybindings:

| Key                   | Action                      |
| --------------------- | --------------------------- |
| `SUPER + Q`           | Open terminal (ghostty)     |
| `SUPER + E`           | Open file manager (dolphin) |
| `SUPER + SPACE`       | Open app launcher (rofi)    |
| `SUPER + C`           | Close focused window        |
| `SUPER + M`           | Exit Hyprland               |
| `SUPER + V`           | Toggle floating mode        |
| `SUPER + P`           | Toggle pseudotiling         |
| `SUPER + T`           | Toggle split                |
| `SUPER + 1-0`         | Switch to workspace 1-10    |
| `SUPER + SHIFT + 1-0` | Move window to workspace    |
| `SUPER + HJKL`        | Move focus (vim-style)      |
| `SUPER + INSERT`      | Take screenshot (flameshot) |
| `SUPER + CTRL + Q`    | Lock screen (hyprlock)      |

## Neovim

Based on [LazyVim](https://github.com/LazyVim/LazyVim).

### Customizations

**Options** (`lua/config/options.lua`):

- Disable snacks animations: `vim.g.snacks_animate = false`
- Scroll offset: 10 lines

### Languages

Bash, C, C++, Go, Java, JavaScript, Lua, Python, Ruby, TypeScript

## Rofi

App launcher using Catppuccin Macchiato theme.

## Tmux

Terminal multiplexer with Catppuccin Macchiato theme.

### Installation

1. Install TPM: https://github.com/tmux-plugins/tpm
2. After installation, press `prefix I` to install all plugins defined in the config.

Prefix: `CTRL + SPACE`

| Key             | Action                              |
| --------------- | ----------------------------------- |
| `I`             | Install plugins (after TPM install) |
| `r`             | Reload config                       |
| `c`             | New window (keeps current path)     |
| `f`             | Zoom pane (toggle)                  |
| `H/J/K/L`       | Split pane (horizontal/vertical)    |
| `h/j/k/l`       | Navigate panes                      |
| `< / >`         | Swap windows                        |
| `v`             | Enter copy mode                     |
| `y`             | Copy previous command output        |
| `v` (copy mode) | Begin selection                     |
| `y` (copy mode) | Copy selection                      |

| Feature      | Setting              |
| ------------ | -------------------- |
| Mouse        | Enabled              |
| Scrollback   | 20k lines            |
| Git status   | Gitmux in status bar |
| Window index | Starts at 1          |

## Waybar

Wayland status bar with Catppuccin styling.

| Position | Modules                                                                         |
| -------- | ------------------------------------------------------------------------------- |
| Left     | Hyprland workspaces                                                             |
| Center   | Clock                                                                           |
| Right    | PulseAudio, Brightness, Battery, Network, CPU, Memory, Temperature, Tray, Power |

| Module     | Notes                    |
| ---------- | ------------------------ |
| Clock      | Shows full date on click |
| Brightness | Scroll to adjust         |

## Flameshot

| Setting        | Value            |
| -------------- | ---------------- |
| Save path      | `~/screenshots`  |
| Filename       | `%F_%H-%M-%S`    |
| Draw color     | Purple (#800080) |
| Draw thickness | 5px              |
| Startup        | Launches on boot |

Flameshot is bound to `SUPER + INSERT` and opens fullscreen pinned.

> **Note:** Update `flameshot/flameshot.ini` with the correct screenshot save path ($HOME is not supported).
