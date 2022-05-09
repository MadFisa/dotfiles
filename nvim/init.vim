set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber
set wildmode=longest,list   " get bash-like tab completions
"set cc=80                  " set an 80 column border for good coding style
filetype plugin on
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
let mapleader=","           "Change the leder key
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/vim-easy-align'

"Next few lines are for a taskbar and icons for it
"Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
"Plug 'kyazdani42/nvim-web-devicons' " lua
"Plug 'ryanoasis/vim-devicons' " vimscript 

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Dracula Theme
Plug 'dracula/vim'
"Gruvbox themes
Plug 'morhetz/gruvbox'


"Syntax Highlighter
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Commenting
Plug 'scrooloose/nerdcommenter'


"Code Completion
Plug 'davidhalter/jedi-vim'

"Vim REPL
Plug 'https://github.com/jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

"Vim Tmux navigator
Plug 'christoomey/vim-tmux-navigator'

"Vim texPlugin
Plug 'lervag/vimtex'
call plug#end() 

lua require('config')
set termguicolors
set background=dark
"colorscheme dracula
"colorscheme gruvbox


" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#smart_auto_mappings = 1

" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Set target for vim-slime
let g:slime_target = "tmux" 
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}
let g:slime_python_ipython = 1

" map [c and ]c to jump to the previous and next cell header
nnoremap [c :IPythonCellPrevCell<CR>
nnoremap ]c :IPythonCellNextCell<CR>

" map <Leader>r to run script
nnoremap <Leader>rr :IPythonCellRun<CR>
" map <Leader>c to execute the current cell


" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
"let g:vimtex_compiler_method = 'latexrun'

nnoremap <leader>rc :IPythonCellExecuteCell<CR>
