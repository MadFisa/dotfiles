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
set cc=80                  " set an 80 column border for good coding style
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
set termguicolors

call plug#begin('~/.config/nvim/plugged')
"---------- Plugins for syntax,lsp and code completion---------
"Syntax Highlighter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Vim nvil-lspconfig
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
"Autocompletion using cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
"Snippets for creating template
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
"gitsigns on gutter
Plug 'lewis6991/gitsigns.nvim'

"-----------Telescope stuff------------------------
" Telescope for fuzzy finding
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

"----------- For looks(UI) ;)--------------------------
"Dracula colorshceme
Plug 'Mofiqul/dracula.nvim'"
"Next few lines are for a taskbar and icons for it
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


" Plug 'ryanoasis/vim-devicons' Icons without colours
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

"For showing indentation and newlines
Plug 'lukas-reineke/indent-blankline.nvim'
" File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Dracula Theme
Plug 'dracula/vim'
"nvim dap for debugging
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python'
Plug 'rcarriga/nvim-dap-ui'

"Commenting
Plug 'scrooloose/nerdcommenter'

"------Moving around: Navigation and execution--------
"Vim REPL
Plug 'https://github.com/jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

"Vim Tmux navigator
Plug 'christoomey/vim-tmux-navigator'

"Vim texPlugin
Plug 'lervag/vimtex'

"Plugin for moving around faster
Plug 'phaazon/hop.nvim'
call plug#end() 
set completeopt=menu,menuone,noselect "cmp made me do this
colorscheme dracula
" show the '~' characters after the end of buffers
let g:dracula_show_end_of_buffer = 1
" use transparent background
let g:dracula_transparent_bg = v:true
"set italic comment
let g:dracula_italic_comment = 1
"-------------------------------------------------------------------------------
"Load bufferline config
lua require("bufferline").setup{options = { mode = "tabs"}}
"-------------------------------------------------------------------------------
"Show Indentations
lua vim.opt.list = true
lua vim.opt.listchars:append("eol:↴")
lua vim.opt.listchars:append("space:⋅")

lua require("indent_blankline").setup {show_end_of_line = true,space_char_blankline = " ",}
"-------------------------------------------------------------------------------
"Load lsp server
lua require("lsp")
"-------------------------------------------------------------------------------
"NVimTree file explorer configs
lua require('tree')
nnoremap \tt :NvimTreeToggle<CR>
nnoremap \r :NvimTreeRefresh<CR>

"-------------------------------------------------------------------------------
"nvim dap config
lua require('dap-python').setup('~/anaconda3/bin/python')
lua require('nvim-dap-ui')

"dap key maps
nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

"nvim dap python binding
nnoremap <silent> \dn :lua require('dap-python').test_method()<CR>
nnoremap <silent> \df :lua require('dap-python').test_class()<CR>
vnoremap <silent> \ds <ESC>:lua require('dap-python').debug_selection()<CR>
nnoremap <silent> \td :lua require('dapui').toggle()<CR>
"-------------------------------------------------------------------------------
" Snippet configuration 
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Set the documentation style as numpy
let g:ultisnips_python_style="numpy"


"-------------------------------------------------------------------------------
"NERDComment configuration
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

"-------------------------------------------------------------------------------
"vim slime config
" Set target for vim-slime
let g:slime_target = "tmux" 
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}
let g:slime_python_ipython = 1

"-------------------------------------------------------------------------------
"Ipthon cell config
" map [c and ]c to jump to the previous and next cell header
nnoremap [c :IPythonCellPrevCell<CR>
nnoremap ]c :IPythonCellNextCell<CR>

nnoremap <leader>rc :IPythonCellExecuteCell<CR>
" map <Leader>r to run script
nnoremap <Leader>rr :IPythonCellRun<CR>
" map <Leader>c to execute the current cell


"-------------------------------------------------------------------------------
"VimTex config
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

"-------------------------------------------------------------------------------
"hope.nvim configuration
lua require'hop'.setup()
lua require('misc')
"-------------------------------------------------------------------------------
"Telescop config Using Lua functions
lua require('telescope').load_extension('fzf')
nnoremap <space>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <space>f<space> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <space>fd <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap <space>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <space>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <space>fk <cmd>lua require('telescope.builtin').keymaps()<cr>
"-------------------------------------------------------------------------------
"Gitsign config
lua require('git')
