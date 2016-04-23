"-----------------------------------------------------------------------------
" Vim Configuration (Dotfiles)
"
" Eric Williamson
"-----------------------------------------------------------------------------

set nocompatible
let &t_Co=256

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
Bundle 'L9'
Bundle 'Gundo'
Bundle 'flazz/vim-colorschemes'

" Vim file tree explorer
Bundle 'scrooloose/nerdtree'
" syntax checking plugin for Vim
Bundle 'scrooloose/syntastic'
" Syntax checking for puppet
Bundle 'hunner/vim-puppet'
" Tabular
Bundle 'godlygeek/tabular'
" Indentation guide
Bundle 'nathanaelkane/vim-indent-guides'
" Coffeescript support
Bundle 'kchmck/vim-coffee-script'
" Airline
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'

" Installing plugins the first time
" If exists, skip
if has_vundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

syntax enable
filetype plugin indent on

" Gundo mapping
nnoremap <silent> <C-U> :GundoToggle<CR>


"-----------------------------------------------------------------------------
" Color scheme
"-----------------------------------------------------------------------------
colorscheme 256_jungle

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
"set wildmenu
"set wildmode=list:longest
set ttyfast
set ruler
set backspace=indent,eol,start

" Line numbering
set number

" Vim window stuff
set guifont=Inconsolata:h15

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

" Auto reload vim config anytime i make changes
autocmd! BufWritePost *vimrc source %

" Omnifunction
set omnifunc=syntaxcomplete#Complete

" Enable spell check for markdown, git commits
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell
"-----------------------------------------------------------------------------
" Spacing
"-----------------------------------------------------------------------------

set autoindent
set smartindent
set tabstop=2 shiftwidth=2 expandtab

" Set line width to 90 when writing markdown
autocmd BufRead,BufNewFile *.md setlocal tw=90

autocmd VimEnter * :IndentGuidesEnable
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=235

"-----------------------------------------------------------------------------
" Buffers
"-----------------------------------------------------------------------------

" Delete all buffers with \da
nmap <silent> <leader>da :exec "1," . bufnr('$') . "bd"<cr>

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" Map for omnicomplete
inoremap <F8> <C-X><C-O>

" Access .vimrc with \vi
nmap <silent> <leader>vi :e $MYVIMRC<CR>
nmap <silent> <leader>vh :e ~/Documents/References/vim.txt<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"-----------------------------------------------------------------------------
" NERD Tree
"-----------------------------------------------------------------------------

" Invoke NERD Tree with \nt
nmap <leader>nt :NERDTree<CR>

" Toggle the NERD Tree on an off with F7
nmap <F7> :NERDTreeToggle<CR>

" Close the NERD Tree with Shift-F7
nmap <S-F7> :NERDTreeClose<CR>

" Auto show NERD Tree
let NERDTreeShowHidden=1
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

"-----------------------------------------------------------------------------
" Custom commands
"-----------------------------------------------------------------------------
" typing :w!! will auto exapnd to :w !sudo tee % so you can save a readonly file
cmap w!! w !sudo tee >/dev/null %
command! -nargs=1 -range TabFirst exec <line1> . ',' . <line2> . 'Tabularize /^[^' . escape(<q-args>, '\^$.[?*~') . ']*\zs' . escape(<q-args>, '\^$.[?*~')

let g:puppet_align_hashes=0
