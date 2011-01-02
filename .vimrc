" ~/.vimrc
" Configuration put together by Tim Monks, after reading a few other .rcs ^_^

" Use Vim extensions and fix screen issues "
""""""""""""""""""""""""""""""""""""""""""""
set nocompatible "compatible mode == emulate vi's problems
if &term =~ "screen"
	set term=xterm
endif
set history=50 "keep 50 lines of command line history
set autowrite " Automatically save before commands like :next and :make
set showcmd
set wildmenu " shows tab completion menu during a command
set backspace=2 "mean that you can always backspace

" Tweak VIM's search "
""""""""""""""""""""""
set showmatch "highlight match as you type
"set hlsearch  "show matches from last search
set ignorecase
set incsearch "search as you type!

" Appearance "
""""""""""""""
set nu " line numbers
colorscheme elflord
if has("syntax")
	syntax on
endif
filetype indent on
set showcmd
set listchars=tab:`\ ,trail:.
set list "list mode displays all your special characters, define them above
set linebreak
set showbreak=>>

" Indentation "
"""""""""""""""
set tabstop=4
set st=4
set shiftwidth=4 "when using << and >> to indent, this value is used
set autoindent
set smartindent "can't remember whether you need both of these. I think yes. :)

" Turn on Mouse "
"""""""""""""""""
"set mouse=a

" Tab shortcuts "
"""""""""""""""""
""irssi like tab changing - can't get this working in PuTTY :\
nmap <A-Right> :tabnext<cr>
nmap <A-Left> :tabprevious<cr>

nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>

" Expand tabs in .py files "
""""""""""""""""""""""""""""
augroup pygroup
	autocmd BufRead *.py set et
augroup END
