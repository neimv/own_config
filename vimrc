"" General
set number                                              " Show line numbers
set relativenumber                                      " number relative line select
set encoding=utf-8                                      " Enconding of vim
set linebreak                                           " Break lines at word (requires Wrap lines)
set showbreak=###                                       " Wrap-broken line prefix
set textwidth=80                                        " Line wrap (number of cols)
set colorcolumn=72,79,120,140                           " color columns to limit
highlight ColorColumn ctermbg=238                       " color by columns
set showmatch                                           " Highlight matching brace

" Splits
set splitbelow                                          " Set split below
set splitright                                          " Set split to right
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
 
set hlsearch                                            " Highlight all search results
set smartcase                                           " Enable smart-case search
set ignorecase                                          " Always case-insensitive
set incsearch                                           " Searches for strings incrementally
 
set autoindent                                          " Auto-indent new lines
set expandtab                                           " Use spaces instead of tabs
set shiftwidth=4                                        " Number of auto-indent spaces
set smartindent                                         " Enable smart-indent
set smarttab                                            " Enable smart-tabs
set softtabstop=4                                       " Number of spaces per Tab
 
"" Advanced
set ruler                                               " Show row and column ruler information
set showtabline=2                                       " Show tab bar
 
set undolevels=1000                                     " Number of undo levels
set backspace=indent,eol,start                          " Backspace behaviour
set cursorline                                          " Cursor line horizontal
set clipboard=unnamed
let mapleader=","                                       " Set mapleader to ,

"" Plugins
call plug#begin()

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
"-------------------=== Code/Project navigation ===-------------
Plug 'scrooloose/nerdtree'                              " Project and file navigation
Plug 'majutsushi/tagbar'                                " Class/module browser
Plug 'kien/ctrlp.vim'                                   " Fast transitions on project files
Plug 'jistr/vim-nerdtree-tabs'

"-------------------=== Other ===-------------------------------
Plug 'bling/vim-airline'                                " Lean & mean status/tabline for vim
Plug 'vim-airline/vim-airline-themes'                   " Themes for airline
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}                 " Powerline fonts plugin
Plug 'fisadev/FixedTaskList.vim'                        " Pending tasks list
Plug 'rosenfeld/conque-term'                            " Consoles as buffers
Plug 'tpope/vim-surround'                               " Parentheses, brackets, quotes, XML tags, and more
Plug 'rafi/awesome-vim-colorschemes'
Plug 'tpope/vim-fugitive'
Plug 'tmhedberg/SimpylFold'

"-------------------=== Snippets support ===--------------------
" Plug 'garbas/vim-snipmate'				" Snippets manager
Plug 'MarcWeber/vim-addon-mw-utils'                     " dependencies #1
Plug 'tomtom/tlib_vim'                                  " dependencies #2
Plug 'honza/vim-snippets'                               " snippets repo
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'tibabit/vim-templates'

"-------------------=== Languages support ===-------------------
Plug 'tpope/vim-commentary'                             " Comment stuff out
Plug 'mitsuhiko/vim-sparkup'                            " Sparkup(XML/jinja/htlm-django/etc.) support
Plug 'Rykka/riv.vim'                                    " ReStructuredText plugin

"-------------------=== Langs  ===-----------------------------
Plug 'klen/python-mode'                                 " Python mode (docs, refactor, lints...)
Plug 'jmcantrell/vim-virtualenv'
Plug 'scrooloose/syntastic'                             " Syntax checking plugin for Vi
Plug 'nvie/vim-flake8'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-scripts/indentpython.vim'
Plug 'rust-lang/rust.vim'


call plug#end()

let python_highlight_all=1
syntax on

" NerdTREE configs
nnoremap <leader>n :NERDTreeFocus<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
nnoremap <C-n> :NERDTree<CR>
nnoremap <leader><C-t> :NERDTreeToggle<CR>
nnoremap <leader><C-f> :NERDTreeFind<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>

set background=dark
colorscheme solarized8

"" Autoclose
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


