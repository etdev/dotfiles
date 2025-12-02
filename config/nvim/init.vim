" 1. Add your existing Vim folder to the runtime path
set runtimepath^=~/.vim runtimepath+=~/.vim/after

" 2. Point the 'packpath' to the same location
let &packpath = &runtimepath

" 3. Source your existing vimrc
" This will execute everything in your uploaded vimrc, 
" which in turn executes vimrc.bundles
source ~/.vimrc

if (has("termguicolors"))
  set termguicolors
endif

