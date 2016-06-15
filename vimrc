let g:python3_host_prog = '/usr/local/bin/python3'

source $VIMRUNTIME/vimrc_example.vim

let g:load_linuxsty = 1

syntax on
colorscheme ron

if &compatible
  set nocompatible               " Be iMproved
endif


" Required:
source ~/.config/nvim/paths.vim

" Let NeoBundle manage NeoBundle
" Required:
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

" Required:
call neobundle#end()
filetype plugin indent on


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


" PyFlakes configurations
let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8'
let g:PyFlakeDisabledMessages = 'E125,E126,E128,E129,E265,E309,H404,H405,E731'
let g:PyFlakeCWindow = 0
let g:PyFlakeMaxLineLength = 80

" Airline configurations
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

filetype plugin indent on     " required!

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

if !has('nvim')
    set t_Co=256
    set t_vb=".
endif

au BufRead,BufNewFile *.rst setlocal spell
au BufRead,BufNewFile *COMMIT_*MSG setlocal spell
au BufRead,BufNewFile * if &ft == 'python' | set keywordprg=pydoc | endif
au BufRead,BufNewFile *.jack setlocal filetype=java

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

" Colors for 80-chars-per-line column
let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight CursorLineNr ctermfg=255
highlight LineNr ctermfg=grey

" Colors for sign column (pyflakes)
highlight SignColumn ctermbg=red
highlight SignColumn ctermfg=white

cmap w!! W|
command! W :execute ':silent w !sudo tee % > /dev/null' | :edit!
augroup MyNoReadOnly
  autocmd!
  autocmd BufRead * setlocal noreadonly
augroup END

cmap Qa :qa
cmap Qa! :qa!
command! W :w
command! Q :q

cmap Q q
cmap Y y$
cmap v$ v$h

nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

map <Leader>tt :tabnew<CR>
map <Leader>tc :tabclose<CR>
map <Leader>tm :tabmove<CR>
map <Leader>tn :tabnext<CR>
map <Leader>tp :tabprevious<CR>

nmap <F3> :FufFileWithCurrentBufferDir<CR>
nmap <Leader>r :FufRenewCache<CR>
nnoremap <F2> :!ctags --recurse=yes --line-directives=yes --exclude=.tox --exclude=.git<CR>

inoremap <silent> <C-a> <C-o>

nmap <leader>yy :%y+<CR>
nmap <leader>dd :%d+<CR>

ia #d #define
ia #i #include

let g:EasyMotion_leader_key = '<Leader>'
let g:EasyMotion_mapping_j = '<Leader><Leader>j'
let g:EasyMotion_mapping_k = '<Leader><Leader>kj'

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


let g:fuf_file_exclude = '\v\~$|\.o$|\.bak$|\.swp$|\.class$|\.git/$'

" Java!
set tags+=/home/john/.vim/tags

"let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabLongestHighlight = 1
if has("autocmd")
    autocmd FileType java set completeopt-=preview
    autocmd Filetype java setlocal omnifunc=javacomplete#Complete
    autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
endif

au VimResized * exe "normal! \<c-w>="

set undodir=~/.config/nvim/tmp/undo//
set backupdir=~/.config/nvim/tmp/backup//
set directory=~/.config/nvim/tmp/swap//
set backup
set noswapfile

set hlsearch
noremap <leader><space> :noh<CR>:call clearmatches()<CR>
noremap <leader>hs :set hlsearch<CR>

nnoremap # :normal! #zzzv<CR>
nnoremap * :normal! *zzzv<CR>
nnoremap n :normal! nzzzv<CR>
nnoremap N :normal! Nzzzv<CR>
nnoremap <expr> G '<C-U>:normal!' . (v:count > 0 ? v:count : '') . 'Gzz<CR>'

nnoremap <expr> k (v:count > 1 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : "") . 'j'
nnoremap <expr> <up> (v:count > 1 ? "m'" . v:count : "") . 'k'
nnoremap <expr> <down> (v:count > 1 ? "m'" . v:count : "") . 'j'

nnoremap <silent> <leader>gl :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR><C-w><C-p><C-o><C-w><C-p>
nnoremap <silent> <leader>gw :execute 'vimgrep /' . expand('<cword>') . '/g %'<CR>:copen<CR><C-w><C-p><C-o><C-w><C-p>

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

command Pdbp :normal oimport ipdb;ipdb.set_trace()<ESC>
command PdbP :normal Oimport ipdb;ipdb.set_trace()<ESC>
nnoremap <silent> <leader>p :Pdbp<CR>
nnoremap <silent> <leader>P :PdbP<CR>

command Tracebacko :normal oimport traceback;traceback.print_stack()<ESC>
command TracebackO :normal Oimport traceback;traceback.print_stack()<ESC>
nnoremap <silent> <leader>o :Tracebacko<CR>
nnoremap <silent> <leader>O :TracebackO<CR>

inoremap <C-r><C-r> <C-r>*
