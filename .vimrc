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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'kshenoy/vim-signature'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ekalinin/Dockerfile.vim'

if has('nvim')
  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
endif

if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
else
    Plug 'chrisbra/vim-diff-enhanced'
    " started In Diff-Mode set diffexpr (plugin not loaded yet)
    if &diff
        let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
    endif
endif
Plug 'rickhowe/diffchar.vim'

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
if has("gui_running")
    let g:oceanic_next_terminal_italic = 1
endif
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

if exists('g:started_by_firenvim')
  let g:airline_powerline_fonts = 0
  let g:airline_theme='bubblegum'
endif

" =============== CONFIGS ================

set nofixendofline
set tabstop=4
set shiftwidth=4
set expandtab
autocmd FileType vim setlocal tabstop=2 shiftwidth=2 expandtab

set mouse=a

if !has('nvim')
  " sgr support more than 223 columns
  set ttymouse=sgr
endif
" on mac and win, use unnamed; on linux use unnamedplus
" https://stackoverflow.com/questions/30691466
set clipboard^=unnamed,unnamedplus

set guifont=MesloLGS\ NF:h14
if exists('g:started_by_firenvim')
  set guifont=MesloLGS\ NF:h18
  au BufEnter github.com_*.txt set filetype=markdown
endif

set number

" save and restore session
" Quick write session with F2
map <F2> :mksession! ~/vim_session<cr>
" And load session with F3
map <F3> :source ~/vim_session<cr>:silent exec "!rm ~/vim_session"<cr><C-L>

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

" auto completion
set wildchar=<Tab> wildmenu wildmode=longest:full,full

" Switch tab
nnoremap <silent> <LocalLeader>- gT
nnoremap <silent> <LocalLeader>= gt

" buffer switch
set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>
nnoremap <silent> <F12> :BufExplorer<CR>
" Disabled because Meta Key can not be used
" nnoremap <silent> <M-F12> :bn<CR>
" nnoremap <silent> <S-F12> :bp<CR>
" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \b       : list buffers
" \[ \] \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>b :BufExplorer<CR>
nnoremap <Leader>[ :bp<CR>
nnoremap <Leader>] :bn<CR>
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

nmap <F6> :NERDTreeToggle<CR>

" =========== EasyMotion ===========
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" =========== haya14busa/incsearch.vim ===========
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzyword#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" diffchar.vim
let g:DiffColors = 3

