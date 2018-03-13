" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible
set exrc " allow project-specific settings
"
" Leader
let mapleader = " "

set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

if has("autocmd")
  filetype plugin indent on
endif

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.py set filetype=python
  autocmd BufRead,BufNewFile *.js set filetype=javascript

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

set sw=2 ts=2 sts=2                             " Defaults: four spaces per tab "
autocmd FileType java :setlocal sw=4 ts=4 sts=4 " Four spaces for java files "
autocmd FileType php :setlocal sw=4 ts=4 sts=4 " Four spaces for php files "

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" CtrlP auto cache clearing.
"function! SetupCtrlP()
  "if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    "augroup CtrlPExtension
      "autocmd!
      "autocmd FocusGained  * CtrlPClearCache
      "autocmd BufWritePost * CtrlPClearCache
    "augroup END
  "endif
"endfunction
"if has("autocmd")
  "autocmd VimEnter * :call SetupCtrlP()
"endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-rspec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>ta :call RunAllSpecs()<CR>

"let g:rspec_command = "!rspec {spec}"
let g:rspec_runner = "os_x_iterm"
"let g:rspec_command = 'call Send_to_Tmux("spring rspec {spec}\n")'
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
set spellfile=$HOME/.vim-spell-en.utf-8.add

" Always use vertical diffs
set diffopt+=vertical

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" Set colorscheme
let g:solarized_termcolors = 256
set background=dark
colorscheme solarized

" Case-insensitive search
set smartcase
set ignorecase

" For tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
"nnoremap <silent> <C-w> :TmuxNavigatePrevious<cr>

" Switch quickly between buffers (matches tmux window switching)
map <C-w>n :bnext<cr>
map <C-w>p :bprevious<cr>

" Re-map command to open new horizontal split, which we just overwrote (matches Ctrlp)
map <C-w>x :new<cr>

" Set scrolloff to 2 lines
set scrolloff=2

" Enable use of patched fonts for Airline
let g:airline_powerline_fonts = 1

" Set airline theme
let g:airline_theme='base16'

" Don't show git info in statusbar
let g:airline_section_b=""
let g:airline_section_y=""
let g:airline_section_warning=""

" Leaders
nmap <leader>c :%s/^\s*#.*$//g<CR>:%s/\(\n\)\n\+/\1/g<CR>:nohl<CR>gg
nmap <leader>V :tabe ~/.vimrc.local<CR>
map <Leader>i mmgg=G`m<CR>
map <Leader>p :%s/\s\+$//<CR>
nnoremap <silent> <leader>sc :w<CR>:SyntasticCheck<CR>
nnoremap <silent> <leader>sr :w<CR>:SyntasticReset<CR>

" Don't append the comment prefix when hitting o/O on a comment line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Tab Completion
set complete=.,w,t
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Persisted undo
if v:version > 702
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" Open ctags in new vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Resize vim panes
autocmd VimResized * wincmd =

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
  if &wrap
    return "g" . a:movement
  else
    return a:movement
  endif
endfunction
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

" Fix slow esc + O command (experimental)
if exists(':noesckeys')
  set noesckeys
endif

" Add syntax coloring for code blocks within markdown
au BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html', 'java']

" Set scratch file type to markdown
let g:scratch_filetype = 'markdown'

" Allow mousewheel scrolling, don't select line numbers
set mouse=a

" Automatically store yanked content to system clipboard
set clipboard=unnamed

" required to select ruby blocks as text objects
runtime macros/matchit.vim

" Turn off annoying syntastic error in ERB files
let g:syntastic_eruby_ruby_quiet_messages =
      \ {'regex': 'possibly useless use of a variable in void context'}
" Make Syntastic check against rbenv-set ruby
let g:syntastic_ruby_mri_exec='/Users/eric/.rbenv/shims/ruby'

" Show 80-char limit
set colorcolumn=80
highlight ColorColumn ctermbg=235
" Make gutter clear (for syntastic etc)
highlight clear SignColumn

augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Nvim
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"NeoVim handles ESC keys as alt+key, set this to solve the problem
if has('nvim')
    set ttimeout
    set ttimeoutlen=0
endif

set timeout timeoutlen=1000 ttimeoutlen=100

autocmd BufRead,BufNewFile *.erb set filetype=eruby.html

" Search ag.vim with leader + a
nnoremap <Leader>a :Ag

" Rubocop
let g:vimrubocop_keymap = 0
nmap <Leader>ru :RuboCop<CR>
nnoremap <Leader>sy :SyntasticCheck<CR>


" Swap (rotate)windows
nmap <silent> <Leader>sp :wincmd r<CR>

" Like :e but starting in current directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" Like :e but starting in current directory
nnoremap <Leader>sp :sp <C-R>=expand('%:p:h') . '/'<CR>

" Like :e but starting in current directory
nnoremap <Leader>vsp :vsp <C-R>=expand('%:p:h') . '/'<CR>

au FileType xml exe ":silent %!xmllint --format --recover - 2>/dev/null"
au FileType javascript setl sw=2 sts=2 et

" prettify json
nmap =j :%!python -m json.tool<CR>
" prettify sql
vmap <silent>sf        <Plug>SQLU_Formatter<CR>
nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR>

set shell=bash

" python allow up to 99 characters per line
" let g:syntastic_python_pylint_post_args="--max-line-length=99"

set backspace=2 " make backspace work like most other apps

vnoremap <Leader>rpm :call ExtractPrivateMethod()<CR>
set secure

" Redraw!
au FocusGained * :redraw!
nnoremap <Leader>r :redraw!<CR>

" Fix vue.js
autocmd BufNewFile,BufRead *.vue set filetype=html

" Livedown
nmap <Leader>md :LivedownPreview<CR>

let g:ag_prg = 'ag --vimgrep'

" Remove splitbar
set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE

" Copy current file
nnoremap <silent> <Leader>cf :let @+ = expand("%:p")<CR>
nnoremap <silent> <Leader>cp :let @+ = expand("%")<CR>
nnoremap <silent> <Leader>ct :let @+ = expand("%:t")<CR>
nnoremap <Leader>o :!open %<CR><CR>

" Fuzzy file finder
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_colors ={
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Statement'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'Normal'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
\ }

let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <c-p> :FZF<cr>
nnoremap <leader>h :History<CR>
nnoremap <leader>b :Buffers<CR>

" prefer rg for FZF
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
endif
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages'
endif

" force the block cursor
let $VTE_VERSION="100"

"This unsets the 'last search pattern' register by hitting return
set nohlsearch

"let g:airline#extensions#branch#enabled = 0
let g:loaded_python_provider = 1
let g:loaded_python3_provider = 1
let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

if !empty(matchstr($MY_RUBY_HOME, 'jruby'))
  let g:ruby_path = join(split(glob($MY_RUBY_HOME.'/lib/ruby/*.*')."\n".glob($MY_RUBY_HOME.'/lib/rubysite_ruby/*'),"\n"),',')
endif

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:block-Cursor/lCursor-blinkon0,r-cr:hor20-Cursor/lCursor
au VimLeave * set guicursor=a:block-blinkon0

" speed up syntax highlighting (IMPORTANT)
set re=1

" Insert debugger calls based on file type
autocmd BufRead,BufNewFile *.rb nnoremap <leader>pr obinding.pry<esc>k<CR>
autocmd BufRead,BufNewFile *.rb nnoremap <leader>dp :g/^ *binding\.pry$/d<CR>
autocmd BufRead,BufNewFile *.rb nnoremap <leader>dpa :silent bufdo g/^ *binding.pry$/d<CR> :silent bufdo w!<CR>
autocmd BufRead,BufNewFile *.js, *.jsx , *.ts, *.vue nnoremap <leader>pr odebugger;<esc>k<CR>
autocmd BufRead,BufNewFile *.js, *.jsx , *.ts, *.vue nnoremap <leader>dp :g/^ *debugger;$/d<CR>
autocmd BufRead,BufNewFile *.js, *.jsx , *.ts, *.vue nnoremap <leader>dpa :silent bufdo g/^ *debugger;$/d<CR> :silent bufdo w!<CR>
autocmd BufRead,BufNewFile *.coffee nnoremap <leader>pr odebugger<esc>k<CR>
autocmd BufRead,BufNewFile *.coffee nnoremap <leader>dp :g/^ *debugger$/d<CR>
autocmd BufRead,BufNewFile *.coffee nnoremap <leader>dpa :silent bufdo g/^ *debugger$/d<CR> :silent bufdo w!<CR>

" save all buffers
nnoremap <leader>sa :silent bufdo w!<CR>

let g:tslime_always_current_session = 1

" these depend on the etdev/tslime.vim package
let g:tslime_window = 2
let g:tslime_pane = 2

" ale
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'coffee': ['coffeelint'],
\}

let g:ale_fixers = {
\   'javascript': ['eslint'],
\}

let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 0

set spell

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>
