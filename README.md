# dotfiles

`dotfiles` stores a collection of configuration files for various programs.

## Prerequisites

- Install [git](https://git-scm.com/downloads)
- Install [brew](https://brew.sh/)
- Install [oh-my-zsh](https://ohmyz.sh/)
- [Connect to GitHub over SSH](https://github.com/Zhunio/notes/blob/main/git/connect-to-github-over-ssh.md)

## Clone the repo

```bash
git clone https://github.com/Zhunio/dotfiles ~/dotfiles
```

## Install

```bash
/bin/bash ~/dotfiles/install.sh
```

## Uninstall

```bash
/bin/bash ~/dotfiles/uninstall.sh
```

# FAQ

## tmux-sessionx zoxide session manager not opening?

Go to tmux-sessionx

```bash
cd ~/bin/tmux-plugins/tmux-sessionx
```

Checkout the following commit

```bash
git checkout 0711d03
```

## How to enable GitHub Copilot and GitHub Copilot Chat?

Authenticate using the GitHub CLI

```bash
gh auth login
```
