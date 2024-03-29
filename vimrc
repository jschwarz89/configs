" Enable folding for the vimrc ---------------------------------------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}


" NeoBundle configuration --------------------------------------------------{{{

" Required
if &compatible
  set nocompatible
endif

" Set some paths
source ~/.config/nvim/paths.vim

call plug#begin()
    " Themes
    Plug 'nanotech/jellybeans.vim'
    Plug 'morhetz/gruvbox'
    Plug 'octol/vim-cpp-enhanced-highlight'
    "Plug 'jackguo380/vim-lsp-cxx-highlight'

    " Bundles!! :)
    "call dein#add('ctrlpvim/ctrlp.vim')
    Plug 'junegunn/fzf', { 'build': './install', 'merged': 0 }
    Plug 'junegunn/fzf.vim'
    set rtp+=~/.fzf

    "Plug 'voldikss/vim-floaterm'
    Plug 'akinsho/nvim-toggleterm.lua'
    Plug 'qpkorr/vim-bufkill'

    " General - change surrounding..., three way merger, tab completion, marks toggle
    Plug 'scrooloose/nerdcommenter'
    Plug 'justinmk/vim-sneak'
    Plug 'matze/vim-move'

    " Auto completion
    "call dein#add('Shougo/deoplete.nvim')
    "call dein#add('Shougo/neoinclude.vim')
    "call dein#add('davidhalter/jedi')
    "call dein#add('zchee/deoplete-jedi')
    "call dein#add('zchee/deoplete-clang')
    "Plug 'neoclide/coc.nvim', { 'rev' : 'release' }
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'

    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Ag
    Plug 'rking/ag.vim'

    " C++
    Plug 'tpope/vim-dispatch'

    " tmux
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'benmills/vimux'
	Plug 'tpope/vim-obsession'
call plug#end()


lua << EOF
local lspconfig = require'lspconfig'
lspconfig.ccls.setup {
  init_options = {
    index = {
      threads = 0;
      initialBlacklist = {"."};
      initialWhitelist = {"hcl", "synapse", "specs", "specs_external", "hl-thunk"};
    };
    clang = {
      excludeArgs = {"-frounding-math"};
    };
    cache = {
      directory = "/tmp/ccls"
    };
    highlight = {
      lsRanges = true;
    };
  }
}

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  --buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "ccls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { on_attach = on_attach }
end

-- Compe setup
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<F4>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
}
EOF

" Dev Bundles
" call dein#add('jschwarz89/shared-session-vim')

" }}}


" Plugins configurations ---------------------------------------------------{{{

" Deoplete
"let g:deoplete#enable_at_startup = 1
"" Bindings to make deoplete work like SuperTab :)
"im <Tab> <C-n>
"ino <C-n> <C-R>=<SID>SuperTab('n')<CR>
"ino <C-p> <C-R>=<SID>SuperTab('p')<CR>
"fu! <SID>SuperTab(command)
"if (strpart(getline('.'),col('.')-2,1)=~'^\s\?$')
  "return "\<Tab>"
"else
  "return "\<C-N>"
"endif
"endf

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#left_sep = ' > '
let g:airline#extensions#tabline#left_alt_sep = ' > '
let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline#extensions#coc#enabled = 1
"let g:airline_section_x = '%{CocAction("getCurrentFunctionSymbol")}'
"%{b:coc_current_function}"
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" CtrlP
"let g:ctrlp_map = '<F3>'
"let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --cc --cpp --python --json --make --proto --shell -g ""'
"let g:ctrlp_working_path_mode = 0
"let g:fzf_preview_window = ''
map <F3> :Files<cr>
nnoremap <Leader>l :Buffers<CR>

" Ag
let g:ag_prg="ag --vimgrep"

" vim-move
let g:move_key_modifier = 'C'

" }}}


" Common settings --------------------------------------------------------- {{{

filetype plugin indent on

syntax on

"let g:lsp_cxx_hl_verbose_log = 1
"let g:lsp_cxx_hl_log_file = '/tmp/vim-lsp.log'
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1

set termguicolors
set background=dark
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_italic = 1
colorscheme gruvbox

set exrc
set secure

set path+=**,/usr/include,/opt/ros/melodic/include
set wildmenu
set nofoldenable
set modelines=0
set suffixes+=.pyc

set mouse=a
set equalalways
set novisualbell
set scrolloff=3         "Start scrolling when we're 8 lines away from margins

set nowrap

set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch

set autowrite

set tabstop=4
set softtabstop=0
set shiftwidth=4
set smarttab
set expandtab

set copyindent
set autoindent
set smartindent
set indentexpr
set cindent
set cino=L-1,:0,t0,i8,g0,N-4,(0,U1,m1,W4
set cink+=*;
set noeol
set binary

set undofile
set backup
set noswapfile
set undodir=~/.config/nvim/tmp/undo/
set backupdir=~/.config/nvim/tmp/backup/
set directory=~/.config/nvim/tmp/swap/

set shortmess+=c
set signcolumn=yes
"set cmdheight=2
set updatetime=300
set hidden

" Linux Kernel development variables - set to 1 to enable
"let g:load_linuxsty = 1

" Resize => rearrange windows
au VimResized * exe "normal! \<c-w>="

" Set norelativenumber on non-active windows only
set number
set relativenumber
augroup rnumber
    au!
    au WinLeave,FocusLost * setlocal norelativenumber expandtab
    au WinEnter,FocusGained * setlocal relativenumber expandtab
augroup END

" Set cursorline on current window and normal mode only
set cursorline
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline expandtab
    au WinEnter,InsertLeave * set cursorline expandtab
augroup END

" Spelling for commits/rst files
au BufRead,BufNewFile *.rst setlocal spell
au BufRead,BufNewFile *COMMIT_*MSG setlocal spell

au BufRead,BufNewFile * if &ft == 'python' | set keywordprg=pydoc | endif
au BufRead,BufNewFile *.jack setlocal filetype=java " nand2tetris

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
au BufReadPost *COMMIT_*MSG exe "normal! gg"

" Allow wrapping automatically when reaching more than 79 chars, except in
" git commit
au BufRead,BufNewFile *COMMIT_*MSG let b:is_commit=1
fun! SetTextWidth()
    if exists('b:is_commit')
        setlocal textwidth=72
    else
        "setlocal textwidth=79
    endif
endfun
au BufRead,BufNewFile * call SetTextWidth()

" }}}


" Columns and colorings --------------------------------------------------- {{{

" Colors for 120-chars-per-line column
let &colorcolumn="119"
au BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp let &colorcolumn="120"
"au BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp let &textwidth=119
highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight CursorLineNr ctermfg=255
highlight LineNr ctermfg=grey

" Colors for sign column (pyflakes)
highlight SignColumn ctermbg=red
highlight SignColumn ctermfg=white
" }}}


" Key Mappings ------------------------------------------------------------ {{{

" common typos
command! Qa qa
command! Q :q
command! W :w
command! Y y$

" visual on last pasted region
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" visual on last inserted region
"nnoremap gv `[v`]

" <C-w>x should also switch to other window
nnoremap <C-w>x <C-w>x<C-w><C-w><CR>

" tabs
map <Leader>tt :tabnew<CR>
map <Leader>tc :tabclose<CR>
map <Leader>tm :tabmove<CR>
map <Leader>tn :tabnext<CR>
map <Leader>tp :tabprevious<CR>

" yank entire files
nmap <leader>yy :%y+<CR>
nmap <leader>dd :%d+<CR>

" Clean traling whitespace
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<cr>

" clear searches and re-set them
noremap <leader><space> :noh<CR>:call clearmatches()<CR>
noremap <leader>hs :set hlsearch<CR>

" make sure searches places result in center
nnoremap # :normal! #zzzv<CR>
nnoremap * :normal! *zzzv<CR>
nnoremap n :normal! nzzzv<CR>
nnoremap N :normal! Nzzzv<CR>

" Use <C-\> to jump to tag in new split
nnoremap <c-\> <c-w>v<c-w><c-w><c-]>zz<cr>

" traversing up and down should modify context mark
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : "") . 'j'
nnoremap <expr> <up> (v:count > 1 ? "m'" . v:count : "") . 'k'
nnoremap <expr> <down> (v:count > 1 ? "m'" . v:count : "") . 'j'

" use C-r C-r to paste from "+
inoremap <C-r><C-r> <C-r>*

" use jk to exit insert mode
inoremap jk <esc>

" terminal support! :>
let g:terminal_scrollback_buffer_size=100000
"tnoremap <Esc> <C-\><C-n>
nnoremap <leader>te :terminal<CR>

" Make X an operator that removes text without placing text in the default
" registry
nmap X "_d
nmap XX "_dd
vmap X "_d
vmap x "_d

" Quickfix windows and Make
nnoremap <leader>m :Make all<CR>
nnoremap <leader>c :Make clean<CR>
nnoremap <leader>q :cclose<CR>
nnoremap <leader>f :cfirst<CR>
nnoremap <leader>p :cprevious<CR>
nnoremap <leader>n :cnext<CR>

" disable bad habits
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Allows you to visually select a section and then hit @ to run a macro on all
" lines.
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" }}}

" Highlight Searches with Colors ------------------------------------------ {{{
function! HiInterestingWord(n, is_visual)
    let view = winsaveview()
    let old_z = @z
    if a:is_visual
        normal! gv"zy
    else
        normal! "zyiw
    endif
    let mid = 68750 + a:n
    silent! call matchdelete(mid)
    let pat = escape(@z, '\')
    if !a:is_visual
        let pat = '\<' . pat . '\>'
    endif
    let pat = '\V' . pat
    call matchadd("InterestingWord" . a:n, pat, 1, mid)
    let @z = old_z
    call winrestview(view)
    if a:is_visual
        exec "normal! gv\<Esc>"
    endif
endfunction

for i in range(1,6)
    for mapmode in ['n', 'v']
        exec mapmode .'noremap <silent> <leader>h'. i .' :call HiInterestingWord('. i .', '. (mapmode == 'v').')<CR>'
    endfor
endfor

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214

" }}}


" Indent Guides ----------------------------------------------------------- {{{
let g:indentguides_state = 0
function! IndentGuides() " {{{
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction " }}}
hi def IndentGuides guibg=#303030 ctermbg=234
nnoremap <leader>i :call IndentGuides()<cr>

" }}}


" Change in next block ---------------------------------------------------- {{{
onoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>

function! s:NextTextObject(motion, dir)
    let c = nr2char(getchar())
    let d = ''

    if c ==# "b" || c ==# "(" || c ==# ")"
        let c = "("
    elseif c ==# "B" || c ==# "{" || c ==# "}"
        let c = "{"
    elseif c ==# "r" || c ==# "[" || c ==# "]"
        let c = "["
    elseif c ==# "'"
        let c = "'"
    elseif c ==# '"'
        let c = '"'
    else
        return
    endif

    " Find the next opening-whatever.
    execute "normal! " . a:dir . c . "\<cr>"

    if a:motion ==# 'a'
        " If we're doing an 'around' method, we just need to select around it
        " and we can bail out to Vim.
        execute "normal! va" . c
    else
        " Otherwise we're looking at an 'inside' motion.  Unfortunately these
        " get tricky when you're dealing with an empty set of delimiters because
        " Vim does the wrong thing when you say vi(.

        let open = ''
        let close = ''

        if c ==# "("
            let open = "("
            let close = ")"
        elseif c ==# "{"
            let open = "{"
            let close = "}"
        elseif c ==# "["
            let open = "\\["
            let close = "\\]"
        elseif c ==# "'"
            let open = "'"
            let close = "'"
        elseif c ==# '"'
            let open = '"'
            let close = '"'
        endif

        " We'll start at the current delimiter.
        let start_pos = getpos('.')
        let start_l = start_pos[1]
        let start_c = start_pos[2]

        " Then we'll find it's matching end delimiter.
        if c ==# "'" || c ==# '"'
            " searchpairpos() doesn't work for quotes, because fuck me.
            let end_pos = searchpos(open)
        else
            let end_pos = searchpairpos(open, '', close)
        endif

        let end_l = end_pos[0]
        let end_c = end_pos[1]

        call setpos('.', start_pos)

        if start_l == end_l && start_c == (end_c - 1)
            " We're in an empty set of delimiters.  We'll append an "x"
            " character and select that so most Vim commands will do something
            " sane.  v is gonna be weird, and so is y.  Oh well.
            execute "normal! ax\<esc>\<left>"
            execute "normal! vi" . c
        elseif start_l == end_l && start_c == (end_c - 2)
            " We're on a set of delimiters that contain a single, non-newline
            " character.  We can just select that and we're done.
            execute "normal! vi" . c
        else
            " Otherwise these delimiters contain something.  But we're still not
            " sure Vim's gonna work, because if they contain nothing but
            " newlines Vim still does the wrong thing.  So we'll manually select
            " the guts ourselves.
            let whichwrap = &whichwrap
            set whichwrap+=h,l

            execute "normal! va" . c . "hol"

            let &whichwrap = whichwrap
        endif
    endif
endfunction

" }}}


" Ack motions --------------------------------------------------------------{{{

" Motions to Ack for things.  Works with pretty much everything, including:
"   w, W, e, E, b, B, t*, f*, i*, a*, and custom text objects.
" Awesome.
"
" Note: If the text covered by a motion contains a newline it won't work.  Ack
" searches line-by-line.
nnoremap <silent> <leader>a :set opfunc=<SID>AgMotion<CR>g@
xnoremap <silent> <leader>a :<C-U>call <SID>AgMotion(visualmode())<CR>

function! s:CopyMotionForType(type)
    if a:type ==# 'v'
        silent execute "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'char'
        silent execute "normal! `[v`]y"
    endif
endfunction

function! s:AgMotion(type) abort
    let reg_save = @@

    call s:CopyMotionForType(a:type)

    execute "normal! :Ag! --literal " . shellescape(@@) . "\<cr>"

    let @@ = reg_save
endfunction

map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>

" }}}

" pdb / traceback bindings
command Pdbp :normal oimport ipdb;ipdb.set_trace()<ESC>
command PdbP :normal Oimport ipdb;ipdb.set_trace()<ESC>
nnoremap <silent> <leader>p :Pdbp<CR>
nnoremap <silent> <leader>P :PdbP<CR>

command Tracebacko :normal oimport traceback;traceback.print_stack()<ESC>
command TracebackO :normal Oimport traceback;traceback.print_stack()<ESC>
nnoremap <silent> <leader>o :Tracebacko<CR>
nnoremap <silent> <leader>O :TracebackO<CR>

nmap <F8> :TagbarToggle<CR>
nmap <silent> <F9> :TagbarTogglePause<CR>


if 0
let g:coc_global_extensions = [
 \ 'coc-yaml',
 \ 'coc-python',
 \ 'coc-git',
 \ ]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  "autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
endif

highlight clear SignColumn
au VimLeave * set guicursor=a:ver100-blinkon0

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader><Leader> :ZoomToggle<CR>

autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

let g:floaterm_keymap_toggle = '<F4>'
let g:floaterm_shell = 'zsh'

set expandtab
