# Step-by-step Guide:

### Clone the Git repository to your home directory:

First, you need to clone your Git repository containing your dotfiles into the $HOME/.dotfiles directory. This is where your configuration files will be stored.

```bash
git clone --bare git@github.com:jeerawatboe/.dotfiles.git $HOME/.dotfiles
```

The --bare option is important because it ensures that the repository is cloned in a bare format, which means it will not have a working directory. This setup is useful for dotfiles management because it keeps your files organized without affecting the rest of your system.

### Create an alias for git to interact with the dotfiles repository:

To make it easier to manage your dotfiles, you'll create an alias for git commands, so you can use config instead. This alias is used to tell Git to operate on your dotfiles repository located in $HOME/.dotfiles, while the working directory is $HOME.

Add the following alias to your shell configuration file (e.g., .bashrc, .zshrc, or .bash_profile):

```bash
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

This makes config behave like git but will only affect your dotfiles.

### Checkout the dotfiles:

Once the repository is cloned and the alias is set, you need to check out your dotfiles into your home directory. This step will ensure that all the files in the dotfiles repository are placed in the correct locations within your home directory.

```bash
config checkout
```

This will restore the dotfiles to their respective places in the home directory.

### Hide untracked files:

After checking out the files, it's essential to hide any untracked files (files that aren't part of the Git repository). This step will prevent Git from showing you unnecessary files that you don’t want to track.

```bash
config config --local status.showUntrackedFiles no
```

This setting ensures that Git won’t flood your terminal with untracked files, which can happen if your home directory contains other files that aren’t part of your dotfiles repository.

### install script
```bash
bash jb_install.sh
```
