# dotfiles

`dotfiles` stores a collection of configuration files for various programs.

## Prerequisites

- Install [git](https://git-scm.com/downloads)

## Install

Linux/macOS `core` profile:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/install.sh)"
```

macOS `full` profile:

```bash
DOTFILES_PROFILE=full /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/install.sh)"
```

## Setup GitHub CLI

```bash
gh auth login
```

## Uninstall

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/uninstall.sh)"
```
