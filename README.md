# dotfiles

`dotfiles` stores a collection of configuration files for various programs.

## Prerequisites

- Install [git](https://git-scm.com/downloads)

## Install

Linux/macOS `core` profile:

```bash
curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/install.sh | /bin/bash -s -- --profile core
```

macOS `full` profile:

```bash
curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/install.sh | /bin/bash -s -- --profile full
```

## Setup GitHub CLI

```bash
gh auth login
```

## Uninstall

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/uninstall.sh)"
```
