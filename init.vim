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
" Better visuals
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Syntax highlight
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
" Vim inside browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

lua require'colorizer'.setup()
colorscheme gruvbox
autocmd FileType scss setl iskeyword+=@-@


" Remaps
let mapleader = " "
" Telescope Grep For
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

" Commentary
nnoremap <leader>/ :commentary<cr>

" Save file
nnoremap <leader>s :w<CR>

" Move line up and down
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

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

" Source init.vim
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>

" Copy to clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>P "+P
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+y$

" Indent all lines
nnoremap <leader>ia gg=g

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Whichkey
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" NERDTree
nnoremap <F3> :NERDTreeToggle<CR>

" Vim-closetag
nnoremap <leader>ct :CloseTagToggleBuffer<CR>



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