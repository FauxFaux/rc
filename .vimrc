runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" The traditionally "Tim Monks" vimrc, after vim-sensible

set nocompatible "compatible mode == emulate vi's problems
set autowrite " Automatically save before commands like :next and :make

set ignorecase " for search

" Appearance "
""""""""""""""
set nu
colorscheme elflord
" non-unicode vim-sensible option; fonts aren't around for the unicode one
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set list " display tabs, trailing space etc. by default
set linebreak " mark that lines have been wrapped with showbreak:
set showbreak=>>


" Indentation "
"""""""""""""""
set tabstop=4
set st=4
set shiftwidth=4 "when using << and >> to indent, this value is used
set expandtab

let g:localvimrc_persistent=2 " remember that localvimrcs are okay

let g:slime_target="tmux" " hah screen

let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed=0

