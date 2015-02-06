Eric Turner's dotfiles
===================

Requirements
------------

Set zsh as your login shell:

    chsh -s $(which zsh)

Recommended
-----------

* [The silver searcher](https://github.com/ggreer/the_silver_searcher)
* Vim 7.4+ compiled with python support
* [Homebrew](http://brew.sh/) if you're using OS X.

Install
-------

Clone onto your laptop:

    git clone git://github.com/etdev/dotfiles.git

Install [rcm by thoughtbot](https://github.com/thoughtbot/rcm):

    brew tap thoughtbot/formulae
    brew install rcm

Install the dotfiles:

    env RCRC=$HOME/dotfiles/rcrc rcup

This command will create symlinks for config files in your home directory.
Setting the `RCRC` environment variable tells `rcup` to use standard
configuration options:

You can safely run `rcup` multiple times to update:

    rcup

Make your own customizations
----------------------------

Put your customizations in dotfiles appended with `.local`:

* `~/.aliases.local`
* `~/.git_template.local/*`
* `~/.gitconfig.local`
* `~/.gvimrc.local`
* `~/.psqlrc.local` (we supply a blank `.psqlrc.local` to prevent `psql` from
  throwing an error, but you should overwrite the file with your own copy)
* `~/.tmux.conf.local`
* `~/.vimrc.local`
* `~/.vimrc.bundles.local`
* `~/.zshenv.local`
* `~/.zshrc.local`
* `~/.zsh/configs/*`

To extend your `git` hooks, create executable scripts in
`~/.git_template.local/hooks/*` files.

What's included?
-------------

[vim](http://www.vim.org/) configuration:

* [Ctrl-P](https://github.com/kien/ctrlp.vim) for fuzzy file/buffer/tag finding.
* [Rails.vim](https://github.com/tpope/vim-rails) for enhanced navigation of
  Rails file structure via `gf` and `:A` (alternate), `:Rextract` partials,
  `:Rinvert` migrations, etc.
* Run [RSpec](https://www.relishapp.com/rspec) specs from vim.
* Set `<leader>` to a single space.
* Switch between the last two files with space-space.
* Syntax highlighting for CoffeeScript, Textile, Cucumber, Haml, Markdown, HTML, Sass, and
  HTML.
* Use [Ag](https://github.com/ggreer/the_silver_searcher) instead of Grep when
  available.
* Use [Exuberant Ctags](http://ctags.sourceforge.net/) for tab completion.
* Use [Solarized colorscheme](https://github.com/altercation/vim-colors-solarized).
* Use [vim-mkdir](https://github.com/pbrisbin/vim-mkdir) for automatically
  creating non-existing directories before writing the buffer.
* Use [Vundle](https://github.com/gmarik/Vundle.vim) to manage plugins.

[tmux](http://robots.thoughtbot.com/a-tmux-crash-course)
configuration:

* Improve color resolution.
* Remove administrative debris (session name, hostname, time) in status bar.
* Soften status bar color from harsh green to light gray.

[git](http://git-scm.com/) configuration:

* Add a `create-branch` alias to create feature branches.
* Add a `delete-branch` alias to delete feature branches.
* Add a `merge-branch` alias to merge feature branches into master.
* Add an `up` alias to fetch and rebase `origin/master` into the feature
  branch. Use `git up -i` for interactive rebases.
* Add `post-{checkout,commit,merge}` hooks to re-index your ctags.
* Add `pre-commit` and `prepare-commit-msg` stubs that delegate to your local
  config.

[Ruby](https://www.ruby-lang.org/en/) configuration:

* Add trusted binstubs to the `PATH`.
* Load rbenv into the shell (if installed), adding shims onto our `PATH`.

Shell aliases and scripts:

* `b` for `bundle`.
* `g` with no arguments is `git status` and with arguments acts like `git`.
* `git-churn` to show churn for the files changed in the branch.
* `m` for `rake db:migrate && rake db:rollback && rake db:migrate && rake db:test:prepare`.
* `mcd` to make a directory and change into it.
* `replace foo bar **/*.rb` to find and replace within a given list of files.
* `rk` for `rake`.
* `tat` to attach to tmux session named the same as the current directory.
* `v` for `$VISUAL`.
