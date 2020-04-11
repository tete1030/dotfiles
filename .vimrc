call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'

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
Plug 'tmux-plugins/vim-tmux-focus-events'

Plug '~/.vim/myplugin'

call plug#end()

" =============== THEMES ================
set t_Co=256

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

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 0
colorscheme OceanicNext

" let g:airline_theme='oceanicnext'
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#fnamemod = ':p:~:.' " ':p:.'
" buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1

" =============== CONFIGS ================

set nofixendofline
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
" sgr support more than 223 columns
set ttymouse=sgr
" on mac and win, use unnamed; on linux use unnamedplus
" https://stackoverflow.com/questions/30691466
set clipboard^=unnamed,unnamedplus
set guifont=Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline:h14
set number


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

