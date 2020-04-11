call plug#begin('~/.vim/plugged')

Plug 'jlanzarotta/bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhartington/oceanic-next'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Shougo/vimproc.vim'
Plug 'kshenoy/vim-signature'
Plug 'tmux-plugins/vim-tmux'

Plug '~/.vim/myplugin'

call plug#end()

set nofixendofline
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
" ******* Solarized ******
" colorscheme solarized
let g:solarized_termcolors=256
" let g:solarized_contrast="high"
" let g:solarized_visibility="high"
" let g:solarized_bold=0
" set background=dark

" ******* Snazzy Color Scheme *******
" set t_Co=256
" hi javaRepeat ctermfg = green
" hi javaType ctermfg = green
" hi javaStorageClass ctermfg = green cterm=bold
" hi javaDocTags ctermfg = green
" hi Conditional ctermfg = green
" hi LineNr ctermfg = magenta
" hi Comment ctermfg = red
" hi Statement ctermfg = blue
" hi Function ctermfg = blue
" hi Identifier ctermfg = blue
" hi Exception ctermfg = green
" hi Special ctermfg = green
" hi String ctermfg = yellow
" hi MatchParen ctermbg=none cterm=underline ctermfg=magenta

set t_Co=256
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 0
colorscheme OceanicNext

set mouse=a
" sgr support more than 223 columns
set ttymouse=sgr
set clipboard=unnamedplus
set guifont=Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline:h14
set number
" let g:airline_theme='oceanicnext'
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#fnamemod = ':p:~:.' " ':p:.'
" buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1
set backspace=indent,eol,start
set laststatus=2
set smarttab
set nrformats-=octal
" key timeout
set ttimeout
set ttimeoutlen=100
set incsearch
set hlsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
set ruler
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif

if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

" save and restore session
" Quick write session with F2
map <F2> :mksession! ~/vim_session<cr>
" And load session with F3
map <F3> :source ~/vim_session<cr>:silent exec "!rm ~/vim_session"<cr><C-L>


" Switch tab
nnoremap <silent> <LocalLeader>[ gT
nnoremap <silent> <LocalLeader>] gt

" View diff between current buffer and original file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! UpdateDisplay()
  let $DISPLAY=system('/bin/bash -c "tmux showenv DISPLAY | sed \"s/DISPLAY=//\" | tr -d \"\n\""')
endfunction
com! UpdateDisp call UpdateDisplay()

" menu
set wildchar=<Tab> wildmenu wildmode=full
" buffer switch
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>
nnoremap <silent> <F12> :BufExplorer<CR>
" Disabled because Meta Key can not be used
" nnoremap <silent> <M-F12> :bn<CR>
" nnoremap <silent> <S-F12> :bp<CR>
" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>l :BufExplorer<CR>
" Used by switching tabs
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" Horizontal Scroll
" Disabled because shortcut conflicting
" map <C-L> 20zl " Scroll 20 characters to the right
" map <C-H> 20zh " Scroll 20 characters to the left

" Folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" YouCompleteMe
let g:ycm_auto_trigger = 0
let g:ycm_autoclose_preview_window_after_completion = 1

" Allow saving of files as sudo when I forgot to start vim using sudo.
cnoremap w!! execute 'write !sudo tee % >/dev/null' <bar> edit!

