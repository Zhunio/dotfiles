# dotfiles

`dotfiles` stores a collection of configuration files for various programs.

## Prerequisites

- Install [git](https://git-scm.com/downloads)

## Install

### macOS (Apple Silicon)

```bash
curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/install.sh | /bin/bash
```

### macOS (Intel)

Homebrew's latest installer no longer accepts Intel Macs. Install Homebrew using
the last official installer revision before Intel support was removed, then add
it to your shell:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/df3c2556141c012eaba0453ede7a1bd4f05b824c/install.sh)"
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
brew --version
```

Then install the dotfiles (the installer will skip Homebrew installation):

```bash
curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/install.sh | /bin/bash
```

Only the Homebrew installer is pinned; it downloads the latest Homebrew release.
Intel Macs are [Tier 3](https://docs.brew.sh/Support-Tiers): unsupported, with
possible source builds and package failures.

## Setup GitHub CLI

```bash
gh auth login
```

## Uninstall

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/refs/heads/main/uninstall.sh)"
```
