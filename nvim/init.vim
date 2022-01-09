syntax enable
set background=dark
colorscheme solarized

set number

set laststatus=0
set clipboard=unnamedplus

set ts=2
set expandtab
set shiftwidth=2
set autoindent
set smartindent
set list
set listchars=tab:··

" Netrw
" Inspired by: https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_keepdir = 0
nmap <leader>da :Lexplore %:p:h<CR>
nmap <leader>dd :Lexplore<CR>

packloadall
silent! helptags ALL

filetype plugin on
