set nocompatible
syntax on
filetype plugin indent on
set completeopt-=preview
set ignorecase
set smartcase
set hlsearch
set incsearch
set showcmd
set gdefault
set nowrap
set noshowmatch
set list listchars=tab:»\ ,trail:·

let maplocalleader = ","
let mapleader = ","
set hidden

set directory=/tmp
set backupdir=/tmp

set fileencodings=ucs-bom,utf-8,latin1

nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

nmap <Leader><space> :noh<CR>
nmap <Leader>co :copen<CR>
nmap <Leader>cc :cclose<CR>
nmap <Leader>n :cn<CR>
nmap <Leader>p :cp<CR>

if has('gui_running')
        set go-=m "remove menubar
        set go-=T "remove menubar
        set go-=L
        set go-=l
        set go-=r
        set go-=b
        colorscheme zenburn
        set guifont=Source\ Code\ Pro\ Medium\ 10
end

function! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr()) "we havent moved
    if (match(a:key,'[jk]')) "were we going up/down
      wincmd v
    else 
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfunction

map <leader>h              :call WinMove('h')<cr>
map <leader>k              :call WinMove('k')<cr>
map <leader>l              :call WinMove('l')<cr>
map <leader>j              :call WinMove('j')<cr>

if has('unix')
        set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/target/*,*/.ensime_lucene/*,*/bin/*,target/*   " for Linux/MacOSX
else
        set wildignore+=.git\*,.hg\*,.svn\*,target\*,.ensime_lucene\*,bin\*         " for Windows
end

" Reselect visual block after indent:
vnoremap < <gv
vnoremap > >gv

" Make Y behave like other capitals
nnoremap Y y$

set expandtab
set nofoldenable

set nu

nmap <leader>m :call SaveMake()<cr>
nmap <f9> :call SaveMake()<cr>
imap <f9> <Esc>:call SaveMake()<cr>

set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set laststatus=2

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set cmdheight=2

function SaveMake()
        wall
        echo "Running makefile"
        make!
        redraw!
        cw
endfunction

nmap <Leader>rl :set rightleft<cr>
nmap <Leader>lr :set norightleft<cr>

nmap <Leader>t :CommandT<CR>
nmap <Leader>b :CommandTBuffer<CR>

if &diff
  " double the width up to a reasonable maximum
  let &columns = ((&columns*2 > 172)? 172: &columns*2)
endif

let g:CommandTFileScanner='find'

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0

let g:ale_linters = {'rust': ['cargo']}

