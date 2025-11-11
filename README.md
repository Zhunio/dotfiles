# dotfiles

`dotfiles` stores a collection of configuration files for various programs.

## Prerequisites

- Install [git](https://git-scm.com/downloads)
- [Connect to GitHub over SSH](https://github.com/Zhunio/notes/blob/main/git/connect-to-github-over-ssh.md)

## Install

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/install.sh)"
```

## Uninstall

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/uninstall.sh)"
```

# FAQ

## tmux-sessionx zoxide session manager not opening?

Go to tmux-sessionx

```bash
cd ~/.config/tmux/plugins/tmux-sessionx
```

Checkout the following commit

```bash
git checkout 3a1911e
```

## How to enable GitHub Copilot and GitHub Copilot Chat?

Authenticate using the GitHub CLI

```bash
gh auth login

```
