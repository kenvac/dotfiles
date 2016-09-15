set nocompatible

if $TERM =~ 'screen'
    if $TERM =~ '\dcolor'
        if $TERM =~ '256'
            set term=xterm-256color
        elseif $TERM =~ '88'
            set term=xterm-88color
        endif
    else
        set term=xterm
    endif
endif

set showmatch
set showmode
set showcmd
set scrolloff=3
set writebackup
"set incsearch
set autoread
set autowrite
"set autowriteall
set autochdir

set number
set wildmenu
set expandtab
set autoindent
set linebreak
set nojoinspaces

set display+=lastline
set background=dark

syntax on
filetype plugin indent on

set softtabstop=4
set tabstop=4
set shiftwidth=4
set shiftround
set backspace=indent,eol,start
set wildmode=longest,list:longest,list:full
"set mouse=a

"analogous to D
nnoremap Y y$

" formatting instead of Ex mode
map Q gq

" search commands re-center the screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

"continue on new line
inoremap <A-Space> <C-O>o
inoremap <C-F> <C-O>zc
inoremap <C-G> <C-O>zo
imap     <C-BS> <C-W>

"tab handling
nnoremap <M-Right>  :tabnext<CR>
nnoremap <M-Left>   :tabprev<CR>
nnoremap <M-Up>     <C-w>w
nnoremap <M-Down>   <C-w>W

augroup syntax
    au! BufNewFile,BufReadPost *.smv
    autocmd  BufNewFile,BufReadPost *.smv  so ~/.vimrc.cadsmv.vim
augroup END

set foldmethod=syntax
autocmd  BufNewFile,BufReadPost *.sh   setlocal foldmethod=marker
autocmd  BufNewFile,BufReadPost *.py   setlocal foldmethod=indent
let python_highlight_all=1

let g:xml_syntax_folding=1

augroup syntax
    autocmd  BufNewFile,BufReadPost wscript   setlocal ft=python
augroup END

autocmd  BufNewFile,BufReadPost *.txt,*.md,*.rst,*.tex  setlocal textwidth=80
autocmd  BufNewFile,BufReadPost *.txt,*.md,*.rst,*.tex  setlocal foldmethod=manual
autocmd  BufNewFile,BufReadPost *.txt,*.md,*.rst,*.tex  setlocal spell
autocmd  BufNewFile,BufReadPost diary.txt     inoremap <C-T> <C-R>=strftime("%H.%M")<CR>
autocmd  BufNewFile,BufReadPost diary.txt     setlocal textwidth=0
autocmd  BufNewFile,BufReadPost diary.txt     highlight Done ctermbg=22
autocmd  BufNewFile,BufReadPost diary.txt     highlight Todo ctermbg=136
autocmd  BufNewFile,BufReadPost diary.txt     highlight Todo ctermfg=15
autocmd  BufNewFile,BufReadPost diary.txt     highlight SpellBad ctermbg=88
autocmd  BufNewFile,BufReadPost diary.txt     call matchadd('Done', '✓.*')
autocmd  BufNewFile,BufReadPost diary.txt     call matchadd('Todo', '→.*')

autocmd  BufNewFile,BufReadPost *.py          inoremap <C-T> import ipdb; ipdb.set_trace()
autocmd  BufNewFile,BufReadPost *.js          inoremap <C-T> debugger;

let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat = "pdf"

" Reread configuration of Vim if .vimrc is saved
augroup VimConfig
    au!
    autocmd BufWritePost ~/.vimrc       so ~/.vimrc
    autocmd BufWritePost vimrc          so ~/.vimrc
augroup END

autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd FileType help nnoremap <buffer> <BS> <C-T>

autocmd FileType xml let b:surround_45 = "<!-- \r -->"
autocmd FileType mail setlocal spell

" Programming Keys:
"   F9  = Make
"   F10 = Next Error
"   F11 = Prev Error
inoremap <F9> <C-O>:w<CR><C-O>:make<CR>
inoremap <F10> <C-O>:cnext<CR>
inoremap <F11> <C-O>:cprev<CR>
nnoremap <F9> :w<CR>:make<CR>
nnoremap <F10> :cnext<CR>
nnoremap <F11> :cprev<CR>

" F5 = execute the file
nnoremap <F5> <Esc>:w<CR>:!%:p<CR>
inoremap <F5> <C-O>:w<CR><C-O>:!%:p<CR>

" Meta-Up/Down - previous/next window
nnoremap <M-Up> <C-W>W
inoremap <M-Up> <C-O><C-W>W
nnoremap <M-Down> <C-W>w
inoremap <M-Down> <C-O><C-W>w
" Meta-Left/Right - previous/next tab
nnoremap <M-Left> gT
inoremap <M-Left> <C-O>gT
nnoremap <M-Right> gt
inoremap <M-Right> <C-O>gt

" run pdflatex
augroup Execution
    au!
    au FileType tex inoremap <F5> <C-O>:w<CR><C-O>:!pdflatex %:p<CR><CR>
    au FileType tex nnoremap <F5> :w<CR>:!pdflatex %:p<CR><CR>
augroup END

" automatically give executable permissions if file begins with #! and contains
" '/bin/' in the path

function! ModeChange()
  if getline(1) =~ "^#!"
    if getline(1) =~ "/bin/"
      silent !chmod +x <afile>
    endif
  endif
endfunction

au BufWritePost * call ModeChange()

" make diff highlight actually usable
hi DiffChange ctermbg=235
hi DiffText ctermbg=52

"let g:clang_library_path="/usr/lib/x86_64-linux-gnu/"
let g:clang_library_path="/usr/lib/llvm-3.6/lib/"

set tags=./tags,./TAGS,tags,TAGS,.tags,./.tags,./.git/tags,.git/tags
set wildignore=*~,*.jpg,*.log,*.out,*.png,*.pdf,*.ps,*.gif,*.bmp,*.jpeg,*.tgz,*.tbz,*gz,*.bz2,*.zip,*.tif,*.xcf,*.doc,*.o,*.pyc
