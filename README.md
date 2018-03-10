etdev's dotfiles
===================

### Install

Clone the repo into your home folder:

```
cd ~
git clone git://github.com/etdev/dotfiles.git
```

Run the install script:
```
cd ~/dotfiles
./install.sh
```

Follow the instructions.

### Make your own customizations

Put your customizations in dotfiles appended with `.local`:

* `~/.aliases.local`
* `~/.git_template.local/*`
* `~/.gitconfig.local`
* `~/.gvimrc.local`
* `~/.psqlrc.local` (There's a blank `.psqlrc.local` supplied to prevent `psql` from
  throwing an error, but you should overwrite the file with your own copy.)
* `~/.tmux.conf.local`
* `~/.vimrc.local`
* `~/.vimrc.bundles.local`
* `~/.zshenv.local`
* `~/.zshrc.local`
* `~/.zsh/configs/*`

To extend your `git` hooks, create executable scripts in
`~/.git_template.local/hooks/*` files.
