set nocompatible
call pathogen#infect()
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

nmap <UP> :call BufMove("bn")<CR>
nmap <DOWN> :call BufMove("bp")<CR>

let maplocalleader = ","
let mapleader = ","
set hidden

nmap <LEFT> :NERDTreeToggle <CR>

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
        colorscheme kalisi
	set guifont=Source\ Code\ Pro\ Medium\ 10
        set lines=55
else
        set background=light
	colorscheme kalisi
end

nmap <leader>i :set background=light <cr> :colorscheme zellner<CR>
nmap <leader>d :set background=dark <cr> :colorscheme molokai<CR>

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

" Force Saving Files that Require Root Permission
cmap w!! %!sudo tee > /dev/null %

set expandtab
autocmd BufRead,BufNewFile *.cljs setlocal filetype=clojure
" au BufNewFile,BufRead *.cpp set syntax=cpp11
set nofoldenable

set nu

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif


let g:indexer_ctagsCommandLineOptions = "--fields=+iaS --extra=+q"

let g:pandoc_no_empty_implicits = 1
let g:pandoc_no_spans = 1

nmap <leader>m :call SaveMake()<cr>
nmap <f9> :call SaveMake()<cr>
imap <f9> <Esc>:call SaveMake()<cr>
nmap <F8> :TagbarToggle<CR>


let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }

set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set laststatus=2

let g:ctrlp_by_filename = 0

let g:ctrlp_extensions = ['tag']

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯЖ;ABCDEFGHIJKLMNOPQRSTUVWXYZ:,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set cmdheight=2

function SaveMake()
        wall
        echo "Running makefile"
        make!
        redraw!
        cw
endfunction

function BufMove(bufMoveDir)
        if (match(bufname('%'), 'NERD_tree*') == 0)
                echo bufname("%")
                echo match(bufname('%'), 'NERD_tree*')
                echo "NERD detected, not moving."
        else
                exec a:bufMoveDir
        endif
endfunction


" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 3

" Define file-type dependent dictionaries.
"let g:neocomplcache_dictionary_filetype_lists = {
    "\ 'default' : '',
    "\ 'vimshell' : $HOME.'/.vimshell_hist',
    "\ 'scheme' : $HOME.'/.gosh_completions'
    "\ }

" Include PATHs
"let g:neocomplcache_include_paths = {
"        \ 'cpp' : '.,,/usr/include,/usr/local/include,/usr/include/qt4',
"        \ }

" Include patterns
"let g:neocomplcache_include_patterns = {
        "\ 'cpp' : '^\s*#\s*include',
        "\ }


" Define keyword, for minor languages
"if !exists('g:neocomplcache_keyword_patterns')
  "let g:neocomplcache_keyword_patterns = {}
"endif
"let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()
"
" <TAB>: completion.
"inoremap <expr><C-space> neocomplcache#start_manual_complete()
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
"" SuperTab like snippets behavior.

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
        "return neocomplcache#smart_close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
"endfunction
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

nmap <silent> <Leader>of :FSHere<cr>

nmap <Leader>rl :set rightleft<cr>
nmap <Leader>lr :set norightleft<cr>

set path+=/usr/local/include
set path+=/usr/include/qt4

"cfdg
"julia
set columns=80

au FileType clojure let b:delimitMate_quotes = "\""

nmap <Leader>t :CommandT<CR>
nmap <Leader>b :CommandTBuffer<CR>

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

au BufNewFile,BufRead prlist setf prman

if &diff
  " double the width up to a reasonable maximum
  let &columns = ((&columns*2 > 172)? 172: &columns*2)
endif


let g:localvimrc_whitelist='/home/vogre/dev/\(dshtoy\|gen_obj\|bar\|daud-js\)/.*'
let g:localvimrc_sandbox=0

au! BufNewFile,BufRead *.glslf,*.glslv set filetype=glsl

nnoremap <silent> <leader>b :CommandTMRU<CR>
let g:CommandTFileScanner='find'
let g:rust_doc#downloaded_rust_doc_dir='/usr/local/'
