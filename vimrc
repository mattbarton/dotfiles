"-----------------------------------------------------------------------------
" Vim Configuration (Dotfiles)
"
" Brian Cain
"-----------------------------------------------------------------------------

set nocompatible
let &t_Co=256

let mapleader=","

"-----------------------------------------------------------------------------
"
" Markdown Syntax
"
"-----------------------------------------------------------------------------

au BufRead,BufNewFile *.md set filetype=markdown

"-----------------------------------------------------------------------------
" Vundle Config
"-----------------------------------------------------------------------------

" Setting up Vundle
" Found here: http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
let has_vundle=1
let vundle_readme=expand('~/.dotfiles/vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.dotfiles/vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.dotfiles/vim/bundle/vundle
    let has_vundle=0
endif

" Vundle setup config
set rtp+=~/.dotfiles/vim/bundle/vundle/
call vundle#rc()

" Required Bundle
Bundle 'gmarik/vundle'
" Additional Bundles go here"
"Bundle 'L9'
"Bundle 'Gundo'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'kchmck/vim-coffee-script'
Bundle 'pangloss/vim-javascript'
Bundle 'einars/js-beautify'
Bundle 'maksimr/vim-jsbeautify'
Bundle 'helino/vim-json'
Bundle 'mxw/vim-jsx'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
Bundle 'Valloric/YouCompleteMe'
Bundle 'rking/ag.vim'
Bundle 'fatih/vim-go'
" Installing plugins the first time
" If exists, skip
if has_vundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

" Shortcuts for CtrlP
let g:ctrlp_map = '<c-p>'


" Airline tabs
let g:airline#extensions#tabline#enabled = 1

"-----------------------------------------------------------------------------
" Encoding and general usability
"-----------------------------------------------------------------------------
nnoremap <Space> :

set splitbelow
set splitright

set modeline
set ls=2

" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#important-vimrc-lines
set encoding=utf-8
set scrolloff=3
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start

" Line numbering
set number

" Vim window stuff
set linebreak
set guifont=Inconsolata:h15

" http://vimdoc.sourceforge.net/htmldoc/usr_45.html
let &termencoding = &encoding

" Show tabs and trailing whitespace visually
if (&termencoding == "utf-8") || has("gui_running")
  if v:version >= 700
    set list listchars=tab:»·,trail:·,extends:…,nbsp:‗
  else
    set list listchars=tab:»·,trail:·,extends:…
  endif
else
  if v:version >= 700
    set list listchars=tab:>-,trail:.,extends:>,nbsp:_
  else
    set list listchars=tab:>-,trail:.,extends:>
  endif
endif

"-----------------------------------------------------------------------------
" Search, highlight, spelling, etc.
"-----------------------------------------------------------------------------

" Improved searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase

set incsearch

" Enable syntax highlighting, if one exists
if has("syntax")
    syntax on
endif

" Paragraph formatting stuff:
set formatprg=par

" Store temporary files in a central location
set backupdir=~/.vim/vim-tmp,~/.tmp,~/tmp,~/var/tmp,/tmp
set directory=~/.vim/vim-tmp,~/.tmp,~/tmp,~/var/tmp,/tmp


" Omnifunction
set omnifunc=syntaxcomplete#Complete

" If a file has been changed outside of Vim, reload it inside of Vim
set autoread

"-----------------------------------------------------------------------------
" Spacing
"-----------------------------------------------------------------------------

set autoindent
set smartindent
set tabstop=2 shiftwidth=2 expandtab

"-----------------------------------------------------------------------------
" Buffers
"-----------------------------------------------------------------------------

" Delete all buffers with \da
nmap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

" Let me switch buffers with unsaved changes
set hidden

"-----------------------------------------------------------------------------
" Folds and folding
"-----------------------------------------------------------------------------

set foldcolumn=0
set foldmethod=marker "alternatives: indent, syntax, marker

" Change what folded lines show (currently disabled)
function! MyFoldText()
    let nl = v:foldend - v:foldstart + 1
    let comment = substitute(getline(v:foldstart),"^ *","",1)
    let linetext = substitute(getline(v:foldstart+1),"^ *","",1)
    let txt = '+ ' . linetext . ' : "' . comment . '" : length ' . nl
    return txt
endfunction
" set foldtext=MyFoldText()

" map <leader>mv :mkview<CR>
" map <leader>lv :loadview<CR>

"-----------------------------------------------------------------------------
" Keymap stuff
"-----------------------------------------------------------------------------

" noremap <Up> gk
" noremap <Down> gj

" Toggle text wrapping with \w {{{
noremap <silent> <Leader>w :call ToggleWrap()<CR>

function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction
" }}}

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$
set mouse=a

" Keymappings for :e
map <leader>ew :e <C-R>=expand("%:p:h")."/"<CR>
map <leader>es :sp <C-R>=expand("%:p:h")."/"<CR>
map <leader>ev :vsp <C-R>=expand("%:p:h")."/"<CR>
map <leader>et :tabe <C-R>=expand("%:p:h")."/"<CR>

" Map for omnicomplete
inoremap <F7> <C-X><C-O>

" Access .vimrc with \vi
nmap <silent> <leader>vi :e $MYVIMRC<CR>
nmap <silent> <leader>vh :e ~/Documents/References/vim.txt<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Relative Number toggle (\rn)
setlocal relativenumber
nmap <silent> <leader>rn :call RelativeNumberToggle()<CR>
function! RelativeNumberToggle()
  if &number
    echo "relativenumber ON"
    setlocal relativenumber
  else
    if &relativenumber
      echo "relativenumber OFF"
      setlocal norelativenumber
      setlocal number
    endif
  endif
endfunction

"-----------------------------------------------------------------------------
" NERD Tree
"-----------------------------------------------------------------------------

" Invoke NERD Tree with \nt
nmap <leader>nt :NERDTree<CR>

" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>


"-----------------------------------------------------------------------------
" Syntastic
"-----------------------------------------------------------------------------

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']


"-----------------------------------------------------------------------------
" JSX syntax highlighting
"-----------------------------------------------------------------------------
let g:jsx_ext_required = 0

colorscheme solarized
set cursorline


"-----------------------------------------------------------------------------
" vim-go
"-----------------------------------------------------------------------------
" https://robots.thoughtbot.com/writing-go-in-vim
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go set nolist
nmap <leader>gt :w<CR>:GoTest<CR>
nmap <leader>gr :w<CR>:GoRun<CR>

inoremap jj <ESC>
" http://stackoverflow.com/questions/5602767/why-is-vim-not-detecting-my-coffescript-filetype
filetype off
syntax enable
filetype plugin indent on
