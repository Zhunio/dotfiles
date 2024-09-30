# Connect to GitHub over SSH

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

Clone the repo using the ssh format

```bash
git clone git@github.com:Zhunio/dotfiles.git
```
