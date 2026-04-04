# dotfiles

`dotfiles` stores a collection of configuration files for various programs.

## Prerequisites

- Install [git](https://git-scm.com/downloads)

## Install

Linux/macOS core:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/install.sh)"
```

Linux/macOS full:

```bash
PROFILE=full /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/install.sh)"
```

`PROFILE=full` installs the shared full toolset on both Linux and macOS, plus macOS-only extras where available.

## Setup GitHub CLI

```bash
gh auth login
```

## Setup Claude

```bash
claude
```

## Uninstall

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/uninstall.sh)"
```
