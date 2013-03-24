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

" xterm bracketed paste mode "
"""""""""""""""""""""""""""""
let &t_ti .= "\e[?2004h"
let &t_te .= "\e[?2004l"
let &pastetoggle = "\e[201~"

function XTermPasteBegin(ret)
    set paste
    return a:ret
endfunction

noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
cnoremap <special> <Esc>[200~ <nop>
cnoremap <special> <Esc>[201~ <nop>


