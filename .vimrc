set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'Yggdroot/LeaderF'
Plug 'itchyny/lightline.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'machakann/vim-swap'
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'
call plug#end()

set ignorecase
set smartcase
set hlsearch
set incsearch
set showcmd
set gdefault
set noshowmatch
set hidden
set list listchars=tab:»\ ,trail:·
let maplocalleader = ","
let mapleader = ","
set fileencodings=ucs-bom,utf-8,latin1
if has('gui_running')
        set go-=m "remove menubar
        set go-=T "remove menubar
        set go-=L
        set go-=l
        set go-=r
        set go-=b
        set guifont=Source\ Code\ Pro\ Medium\ 10
end

set laststatus=2
nmap <Leader><space> :noh<CR>
vnoremap <leader>y "+y


" https://github.com/dyng/ctrlsf.vim#use-your-own-map
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
" Do not interfere with leaderf keys
let g:BufKillCreateMappings = 0
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//
" as seen in https://github.com/vim/vim/issues/549
" make Ctrl-G consistently show relative path if available
autocmd BufReadPost * silent! lcd .
