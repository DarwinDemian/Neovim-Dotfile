" Credits go to the_primeagen for the delicous cocunut oil initial setup!
" Also credits to all the giga vim chads on the interwebs who made all the
" tutorials and documentation that helped me make this vim setup possible

" Sets
set tabstop=2 softtabstop=2
set shiftwidth=2
set expandtab
set scrolloff=8
set smartindent
set relativenumber
set nu
set nohlsearch
set incsearch
set colorcolumn=80
set signcolumn=yes
highlight ColorColumn ctermbg=7 guibg=lightgrey

set undodir=~/.vim/undodir
set undofile
set noswapfile
set hidden
set noerrorbells
set exrc
set timeout
set timeoutlen=500
set termguicolors


" Plugins
call plug#begin('~/.vim/plugged')
" Easy grep
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" See changes
Plug 'mbbill/undotree'
" Startup page
Plug 'mhinz/vim-startify'
" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'terryma/vim-multiple-cursors'
" Show available commands
Plug 'liuchengxu/vim-which-key'
" File explorer
Plug 'preservim/nerdtree'
" Prettier
Plug 'gruvbox-community/gruvbox'
Plug 'norcalli/nvim-colorizer.lua'
" Commentary
Plug 'tpope/vim-commentary'
" Better tab
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Syntax highlight
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
" Vim inside browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" Git integration
Plug 'tpope/vim-fugitive'
" Emmet
Plug 'mattn/emmet-vim'
" Indent Line
Plug 'Yggdroot/indentLine'
Plug 'andreshazard/vim-freemarker'
Plug 'rustushki/JavaImp.vim'
call plug#end()

lua require'colorizer'.setup()
colorscheme gruvbox
autocmd FileType scss setl iskeyword+=@-@

" Remaps
let mapleader = " "

" Tab shortcuts
" New Tab
nnoremap <leader>tn :tabnew<CR>

" Move Tab
nnoremap <leader>tm :tabmove

" Set filetype to Java
nnoremap <leader>fj :set filetype=java<CR>

" Run Java file
nnoremap <leader>rj :!java %<CR>

" Fold
" Enable foldable
nnoremap <leader>sfe :set foldenable <bar> set foldmethod=indent<CR>
" Disable foldable
nnoremap <leader>sfd :set nofoldenable<CR>
" Close all folds
nnoremap <leader>fc zM
" Open all folds
nnoremap <leader>fo zR
" Use za to open/close fold

" Save file
nnoremap <leader>s :w<CR>

" Compile with sass
nnoremap <leader>rs :!sass % %:r.css<CR>

" Run with node
nnoremap <leader>rn :!node %<CR>

" Source init.vim
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" Commentary
nnoremap <leader>/ :Commentary<cr>
vnoremap <leader>/ :Commentary<cr>

" Indent all lines
nnoremap <leader>ia gg=g

" Yank to the end of the line
nnoremap Y y$

" Copy to clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$

" Select all
nnoremap <leader>sa gg V G

" Undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Move line up and down
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==
inoremap <C-k> <esc>:m .-2<CR>==

" Move through windows
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Resize window
nnoremap <leader>= :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>

" New window
nnoremap <leader>nw :wincmd v<bar> :vertical resize 45<cr>

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Whichkey
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" NERDTree
nnoremap <F3> :NERDTreeToggle<CR>

" Vim-closetag
nnoremap <leader>ct :CloseTagToggleBuffer<CR>

" Telescope Grep For
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

" Git integration
" Git Status
nmap <leader>gs :G<CR>
" Git difference side rigth
nmap <leader>gl :diffget //3<CR>
" Git difference side left
nmap <leader>gh :diffget //2<CR>

" Remove white space on save
fun! TrimWhiteSpace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

augroup CallTrim
  autocmd!
  autocmd BufWritePre * :call TrimWhiteSpace()
augroup END

" Emmet Vim config
" Only enable normal mode functions.
" let g:user_emmet_mode='n'
" Enable just for html/css
" let g:user_emmet_install_global = 0
" autocmd FileType html,css EmmetInstall

" COC Config
" Use tab to autocomplete
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')
nnoremap <leader>f :Format<CR>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-pairs',
      \ 'coc-tsserver',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-prettier',
      \ 'coc-json',
      \ ]

"" END COC CONFIG

" Vim-close-tag config
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.

let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.

let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.

let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.

let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)

let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)

let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'

let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''

let g:closetag_close_shortcut = '<leader>>'
" VIM-CLOSE-TAGS END

lua << EOF
require('telescope').setup{
	defaults = {
		path_display={"smart"}
	}
}
EOF

" COC Java auto-import
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 OR :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files <cr>
nnoremap <leader>ffh <cmd>Telescope find_files hidden=true<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:NERDTreeChDirMode = 2

