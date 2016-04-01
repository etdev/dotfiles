" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible
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
autocmd FileType java :setlocal sw=4 ts=4 sts=4 " Two spaces for HTML files "

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" CtrlP
"  auto cache clearing.
function! SetupCtrlP()
  if exists("g:loaded_ctrlp") && g:loaded_ctrlp
    augroup CtrlPExtension
      autocmd!
      autocmd FocusGained  * CtrlPClearCache
      autocmd BufWritePost * CtrlPClearCache
    augroup END
  endif
endfunction
if has("autocmd")
  autocmd VimEnter * :call SetupCtrlP()
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  "Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

   "ag is fast enough that CtrlP doesn't need to cache
   let g:ctrlp_use_caching = 0
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

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" configure syntastic syntax checking to check on open as well as save
 let g:syntastic_check_on_open = 0
 let g:syntastic_check_on_wq = 1
 let g:syntastic_check_on_w = 1
 let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
 let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
 let g:syntastic_javascript_checkers = ['eslint']
 let g:syntastic_ruby_checkers = ['ruby', 'reek']

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

" Set strict backspace behavior
set backspace=

" Case-insensitive search
set smartcase
set ignorecase

" For tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-w> :TmuxNavigatePrevious<cr>

" Switch quickly between buffers (matches tmux window switching)
map <C-w>n :bnext<cr>
map <C-w>p :bprevious<cr>

" Re-map command to open new horizontal split, which we just overwrote (matches Ctrlp)
map <C-w>x :new<cr>

" Re-color ag output when using :grep
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --color
endif

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
set noesckeys

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

augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Nvim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

autocmd BufRead,BufNewFile *.erb set filetype=eruby.html

" Search ag.vim with leader + a
nnoremap <Leader>a :Ag 

" Rubocop
let g:vimrubocop_keymap = 0
nmap <Leader>ru :RuboCop<CR>
nnoremap <Leader>sy :SyntasticCheck<CR>

" Insert binding.pry call
let @p = "Orequire 'pry'; binding.pry; nil.nil?"
" Delete binding Pry calls in file
nmap <silent> <Leader>dp :g/binding.pry/d<CR>
" Delete binding Pry calls in All open buffers
nmap <silent> <Leader>dpa :bufdo g/binding.pry/d<CR>

" Swap (rotate)windows
nmap <silent> <Leader>sp :wincmd r<CR>

" Like :e but starting in current directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>
