if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.local/share/nvim/plugged')

" General plugin section
Plug 'tpope/vim-eunuch' " nice unix commands inside vim
Plug 'tpope/vim-surround' " nice surrounding plugin
Plug 'w0rp/ale' " linting/fixing for the future!
" ? mattn/emmet-vim ?
" ? editorconfig/editorconfig-vim ?
" ? terryma/vim-multiple-cursors ?
Plug 'tpope/vim-fugitive' " Git from the Vim!
Plug 'tpope/vim-vinegar'

" JS/Typescript/React plugins section
Plug 'pangloss/vim-javascript'
Plug 'jason0x43/vim-js-indent'
Plug 'mxw/vim-jsx'
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" theme
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

syntax on
color dracula

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
