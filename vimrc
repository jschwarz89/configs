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
let g:python3_host_prog = '/usr/local/bin/python3'
source ~/.config/nvim/paths.vim

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Bundles!! :)
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'

" General - change surrounding..., three way merger, tab completion, marks toggle
NeoBundle 'scrooloose/nerdcommenter.git'
NeoBundle 'Splice'
NeoBundle 'Shougo/deoplete.nvim'

" Python
NeoBundle 'andviro/flake8-vim', {
\  'lazy' : 1,
\  'autoload' : {
\    'filetypes' : ['python']
\  }
\}

" Airline
NeoBundle 'bling/vim-airline'

" Dev Bundles
NeoBundle 'prabirshrestha/async'
NeoBundle 'jschwarz89/shared-session-vim'

call neobundle#end()

" }}}


" Plugins configurations ---------------------------------------------------{{{

" Deoplete
let g:deoplete#enable_at_startup = 1
" Bindings to make deoplete work like SuperTab :)
im <Tab> <C-n>
ino <C-n> <C-R>=<SID>SuperTab('n')<CR>
ino <C-p> <C-R>=<SID>SuperTab('p')<CR>
fu! <SID>SuperTab(command)
if (strpart(getline('.'),col('.')-2,1)=~'^\s\?$')
  return "\<Tab>"
else
  return "\<C-N>"
endif
endf


" PyFlakes
let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8'
let g:PyFlakeDisabledMessages = 'E125,E126,E128,E129,E265,E309,H404,H405,E731'
let g:PyFlakeCWindow = 0
let g:PyFlakeMaxLineLength = 80

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#left_sep = ' > '
let g:airline#extensions#tabline#left_alt_sep = ' > '
let g:airline#extensions#tabline#formatter = 'default'
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" FuzzyFinder
let g:fuf_file_exclude = '\v\~$|\.o$|\.bak$|\.swp$|\.class$|\.git/$|__pycache__/$|\.pyc$'
nmap <F3> :FufFileWithCurrentBufferDir<CR>
nmap <Leader>r :FufRenewCache<CR>

" }}}


" Common settings --------------------------------------------------------- {{{

filetype plugin indent on

syntax on
colorscheme ron

set modelines=0
set nowrap
set suffixes+=.pyc
set mouse=a
set background=dark
set number
set relativenumber
set showcmd
set showmatch
set autowrite
set hidden
set equalalways
set ruler
set ic
set scs
set is
set sw=4
set ts=4
set autoindent
set cindent
set cino=L,:0,b1,t0,(s,U1,m1
set cink+=*;
set laststatus=2
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set vb
set undofile
set undodir=~/.config/nvim/tmp/undo/
set backupdir=~/.config/nvim/tmp/backup/
set directory=~/.config/nvim/tmp/swap/
set backup
set noswapfile

set hlsearch
if !has('nvim')
    set t_Co=256
    set t_vb=".
endif

" Linux Kernel development variables - set to 1 to enable
let g:load_linuxsty = 0

" Resize => rearrange windows
au VimResized * exe "normal! \<c-w>="

" Spelling for commits/rst files
au BufRead,BufNewFile *.rst setlocal spell
au BufRead,BufNewFile *COMMIT_*MSG setlocal spell

au BufRead,BufNewFile * if &ft == 'python' | set keywordprg=pydoc | endif
au BufRead,BufNewFile *.jack setlocal filetype=java " nand2tetris

" Allow wrapping automatically when reaching more than 79 chars, except in
" git commit
au BufRead,BufNewFile *COMMIT_*MSG let b:is_commit=1
fun! SetTextwidth()
    if exists('b:is_commit')
        setlocal textwidth=72
    else
        setlocal textwidth=79
    endif
endfun
au BufRead,BufNewFile * call SetTextwidth()

" }}}


" Columns and colorings --------------------------------------------------- {{{

" Colors for 80-chars-per-line column
let &colorcolumn="80"
highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight CursorLineNr ctermfg=255
highlight LineNr ctermfg=grey

" Colors for sign column (pyflakes)
highlight SignColumn ctermbg=red
highlight SignColumn ctermfg=white
" }}}


" Key Mappings ------------------------------------------------------------ {{{

" sudo write file with no warnings
cmap w!! W|
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
augroup MyNoReadOnly
  autocmd!
  autocmd BufRead * setlocal noreadonly
augroup END

" common typos
cmap Qa qa
cmap Qa! qa!
command! Q :q
command! W :w
cmap Y y$
cmap v$ v$h

" visual on last pasted region
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" tabs
map <Leader>tt :tabnew<CR>
map <Leader>tc :tabclose<CR>
map <Leader>tm :tabmove<CR>
map <Leader>tn :tabnext<CR>
map <Leader>tp :tabprevious<CR>

" ctags for the riches
nnoremap <F2> :!ctags --recurse=yes --line-directives=yes --exclude=.tox --exclude=.git<CR>

" yank entire files
nmap <leader>yy :%y+<CR>
nmap <leader>dd :%d+<CR>

" clear searches and re-set them
noremap <leader><space> :noh<CR>:call clearmatches()<CR>
noremap <leader>hs :set hlsearch<CR>

" make sure searches places result in center
nnoremap # :normal! #zzzv<CR>
nnoremap * :normal! *zzzv<CR>
nnoremap n :normal! nzzzv<CR>
nnoremap N :normal! Nzzzv<CR>

" traversing up and down should modify context mark
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : "") . 'j'
nnoremap <expr> <up> (v:count > 1 ? "m'" . v:count : "") . 'k'
nnoremap <expr> <down> (v:count > 1 ? "m'" . v:count : "") . 'j'

" vimgrep
nnoremap <silent> <leader>gl :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR><C-w><C-p><C-o><C-w><C-p>
nnoremap <silent> <leader>gw :execute 'vimgrep /' . expand('<cword>') . '/g %'<CR>:copen<CR><C-w><C-p><C-o><C-w><C-p>

" pdb / traceback bindings
command Pdbp :normal oimport ipdb;ipdb.set_trace()<ESC>
command PdbP :normal Oimport ipdb;ipdb.set_trace()<ESC>
nnoremap <silent> <leader>p :Pdbp<CR>
nnoremap <silent> <leader>P :PdbP<CR>

command Tracebacko :normal oimport traceback;traceback.print_stack()<ESC>
command TracebackO :normal Oimport traceback;traceback.print_stack()<ESC>
nnoremap <silent> <leader>o :Tracebacko<CR>
nnoremap <silent> <leader>O :TracebackO<CR>

" use C-r C-r to paste from "+
inoremap <C-r><C-r> <C-r>*

" terminal support! :>
let g:terminal_scrollback_buffer_size=100000
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>te :terminal<CR>

" disable bad habits
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" }}}


" Buffer Switching -------------------------------------------------------- {{{

function! BufSel()
	execute ":buffers"
	let pattern = input("Enter Buffer Number: ")
	echo "-"

	let selection = str2nr(pattern)
	if (selection != 0)
		execute ":buffer ". selection
		return
	endif
endfunction
command! Bs :call BufSel()<CR>
nnoremap <Leader>l :Bs<CR>
nnoremap <Leader><C-b> :Bs<CR>

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

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

" }}}
