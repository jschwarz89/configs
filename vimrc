source $VIMRUNTIME/vimrc_example.vim

let g:load_linuxsty = 1

syntax on
colorscheme ron

filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Bundles!! :)
Bundle 'L9'
Bundle 'FuzzyFinder'

" General - change surrounding..., three way merger, tab completion, marks toggle
Bundle 'https://github.com/scrooloose/nerdcommenter.git'
Bundle 'Splice'
Bundle 'SuperTab'

" Python
Bundle 'pyflakes'
Bundle 'pyflakes.vim'

" Airline
Bundle 'bling/vim-airline'

call vundle#end()

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
set t_Co=256
set number
set relativenumber
set showcmd
set showmatch
set autowrite
set hidden
set equalalways
set vb t_vb=".
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
" set statusline=\[%n\]\ \%<%f\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %P
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

au BufRead,BufNewFile *.rst setlocal spell
au BufRead,BufNewFile *COMMIT_*MSG setlocal spell
au BufRead,BufNewFile * if &ft == 'python' | set ed | endif
au BufRead,BufNewFile * if &ft == 'python' | set keywordprg=pydoc | endif
au BufRead,BufNewFile *.jack setlocal filetype=java

cmap w!! w !sudo tee % >/dev/null
command! W :w
command! Q :q

map Q q
map Y y$
map v$ v$h

nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

map <c-K> m`o<Esc>"_cc<Esc>"
map <c-J> m`O<Esc>"_cc<Esc>"
map <c-L> i <Esc>l
map <c-H> a <Esc>h

map <Leader>tt :tabnew<CR>
map <Leader>tc :tabclose<CR>
map <Leader>tm :tabmove<CR>
map <Leader>tn :tabnext<CR>
map <Leader>tp :tabprevious<CR>

nmap <F3> :FufFileWithCurrentBufferDir<CR>
nmap <Leader>r :FufRenewCache<CR>
nnoremap <F2> :!ctags --recurse=yes --line-directives=yes --exclude=.tox --exclude=.git<CR>

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

"nnoremap <Leader>1 :1b<CR>
"nnoremap <Leader>2 :2b<CR>
"nnoremap <Leader>3 :3b<CR>
"nnoremap <Leader>4 :4b<CR>
"nnoremap <Leader>5 :5b<CR>
"nnoremap <Leader>6 :6b<CR>
"nnoremap <Leader>7 :7b<CR>
"nnoremap <Leader>8 :8b<CR>
"nnoremap <Leader>9 :9b<CR>
"nnoremap <Leader>0 :10b<CR>

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

set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
set noswapfile

set hlsearch
noremap <leader><space> :noh<CR>:call clearmatches()<CR>
noremap <leader>hs :set hlsearch<CR>

nnoremap # #zzzv
nnoremap * *zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<cr>

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

let &colorcolumn="80,".join(range(120,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

highlight LineNr ctermfg=grey
highlight CursorLineNr ctermfg=255

inoremap <silent> <C-a> <C-o>
