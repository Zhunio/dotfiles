# dotfiles

`dotfiles` stores a collection of configuration files for various programs.

## Prerequisites

- Install [git](https://git-scm.com/downloads)
- Install [brew](https://brew.sh/)
- Install [nvm](https://github.com/nvm-sh/nvm)
- Install [oh-my-zsh](https://ohmyz.sh/)
- Install [ghostty](https://ghostty.org/)
- Install [vscode](https://code.visualstudio.com/)
- Install [raycast](https://www.raycast.com/)
- Install [shottr](https://shottr.cc/)
- Install [MesloLGL Nerd Font](https://www.nerdfonts.com/) 

## Connect to GitHub over SSH

Create new SSH key with your email.

```bash
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/zhunio-github
```

Create `~/.ssh/config` file (if it does not exists).

```bash
touch ~/.ssh/config
```

Modify `~/.ssh/config` file to automatically load keys into the ssh-agent.

```ssh
Host zhunio github.com
  HostName github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/zhunio-github
```

Start ssh-agent.

```bash
eval "$(ssh-agent -s)"
```

Add your SSH private key to the ssh-agent

```bash
ssh-add ~/.ssh/zhunio-github
```

Add the `~/.ssh/zhunio-github.pub` (public key) to your account in GitHub.

## Clone

```bash
git clone git@github.com:Zhunio/dotfiles.git
```

## Install

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Zhunio/dotfiles/main/install.sh)"
```

## Unisntall

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
