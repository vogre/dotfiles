set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'thalesmello/vim-textobj-multiline-str'
Plug 'sgur/vim-textobj-parameter'
Plug 'fvictorio/vim-textobj-backticks'
Plug 'Yggdroot/LeaderF'
Plug 'itchyny/lightline.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'machakann/vim-swap'
Plug 'tpope/vim-surround'
Plug 'qpkorr/vim-bufkill'
Plug 'chrisbra/NrrwRgn'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'vimwiki/vimwiki'
Plug 'airblade/vim-rooter'
Plug 'matze/vim-move'
Plug 'tpope/vim-fugitive'
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
set belloff=all
let g:vimwiki_ext2syntax = {'.wiki': 'media'}
let maplocalleader = ","
let mapleader = ","
set fileencodings=ucs-bom,utf-8,latin1
if has('gui_running')
    set go-=m "remove menubar
    set go-=T "remove toolbar
    set go-=r "remove right scroll
    set guifont=Source\ Code\ Pro\ Medium\ 10
    colorscheme PaperColor
else
    colorscheme PaperColor
end

" kitty FAQ
if &term == "xterm-kitty"
    let &t_ut=''
endif

set laststatus=2
nmap <Leader><space> :noh<CR>
vnoremap <leader>y "+y
" Make Y behave like other capitals
nnoremap Y y$


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
let g:ctrsf_position = 'bottom'
" Do not interfere with leaderf keys
let g:BufKillCreateMappings = 0
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//
" as seen in https://github.com/vim/vim/issues/549
" make Ctrl-G consistently show relative path if available
autocmd BufReadPost * silent! lcd .

" Dev icons require hacker font and are distracting anyway
let g:Lf_ShowDevIcons = 0
" Less tiring to F5
let g:Lf_UseCache = 0
let g:Lf_UseMemoryCache = 0

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    " if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Trigger configuration. You need to change this to something other than <tab>
" if you use one of the following:
" " - https://github.com/Valloric/YouCompleteMe
" " - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

let g:rooter_manual_only = 1
let g:rooter_cd_cmd = 'lcd'

let g:lsp_settings_enable_suggestions = 0
