Eric Turner's dotfiles
===================

Required
------------

Set zsh as your login shell:

    chsh -s $(which zsh)

Recommended
-----------

* Install [The silver searcher](https://github.com/ggreer/the_silver_searcher)
* Use [Vim version 7.4+](http://www.vim.org/download.php), ideally compiled with python support
* Install [Prezto](https://github.com/sorin-ionescu/prezto/tree/master/modules/prompt/external) (in order to use included custom prompt)
* Install [rbenv](https://github.com/sstephenson/rbenv) if you use Ruby
* Install [Homebrew](http://brew.sh/) (OS X only)
* Install [iTerm 2](http://iterm2.com/) (OS X only)
* Install a [patched font](https://github.com/powerline/fonts) if you want the [vim-airline statusbar](https://github.com/bling/vim-airline) to look its best

Install
-------

Clone the repo:

    git clone git://github.com/etdev/dotfiles.git

Install [rcm by thoughtbot](https://github.com/thoughtbot/rcm) (dotfile management scripts)

Install the dotfiles with rcm:

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
* Syntax highlighting for CoffeeScript, Textile, Cucumber, Haml, Markdown, HTML, Sass, Handlebars, and
  HTML.
* Use [Ag](https://github.com/ggreer/the_silver_searcher) instead of Grep when
  available.  Uses python when available to increase speed.
* Use [Exuberant Ctags](http://ctags.sourceforge.net/) for tab completion.
* Use [Solarized colorscheme](https://github.com/altercation/vim-colors-solarized) (I then set a dark background in iTerm)
* Use [vim-mkdir](https://github.com/pbrisbin/vim-mkdir) for automatically
  creating non-existing directories before writing the buffer.
* Use [Vundle](https://github.com/gmarik/Vundle.vim) to manage plugins.
* Switch between vim/Tmux panes with ``<C-h>``,``<C-j>``,``<C-k>``,``<C-l>``, even within Tmux ([vim-tmux-navigator]https://github.com/christoomey/vim-tmux-navigator))
* Use [vim-airline statusbar](https://github.com/bling/vim-airline)
* Add [nerdcommenter](https://github.com/scrooloose/nerdcommenter) for quickly commenting/uncommenting

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
* Add `gg` alias for ``git grep``

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
* `tls` to view the list of open tmux sessions
* `v` for `vim`.
* `l` for `ls`
* `j` for `jobs`
* `bers` for `bundle exec rails server`
* `berc` for `bundle exec rails console`
* `berspec` for `bundle exec rspec`
* Automatically run ``ls`` after ``cd``
* Set sane values for LS_COLORS and zsh completion (for both Linux and OS X)

Todo
---------
* Automate prezto installation and replacing of prompt setup file
* Add homebrew scripts for mac osx
* Add iTerm2 settings, my custom color scheme, non-ugly icon, etc.
