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

" Let dein manage dein
call dein#add('Shougo/dein.vim')

" Themes
call dein#add('nanotech/jellybeans.vim')

" Bundles!! :)
call dein#add('ctrlpvim/ctrlp.vim')

" General - change surrounding..., three way merger, tab completion, marks toggle
call dein#add('scrooloose/nerdcommenter.git')
call dein#add('justinmk/vim-sneak')
call dein#add('matze/vim-move')

" Auto completion
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neoinclude.vim')
call dein#add('davidhalter/jedi')
call dein#add('zchee/deoplete-jedi')
call dein#add('zchee/deoplete-clang')

" Airline
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" Ag
call dein#add('rking/ag.vim')

" Dev Bundles
" call dein#add('jschwarz89/shared-session-vim')

" Required:
call dein#end()

if dein#check_install()
    call dein#install()
endif

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

" CtrlP
let g:ctrlp_map = '<F3>'
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Ag
let g:ag_prg="ag --vimgrep"

" vim-move
let g:move_key_modifier = 'C'

" }}}


" Common settings --------------------------------------------------------- {{{

filetype plugin indent on

syntax on
colorscheme jellybeans

set wildmenu
set nofoldenable
set modelines=0
set suffixes+=.pyc

set mouse=a
set equalalways
set visualbell
set scrolloff=3         "Start scrolling when we're 8 lines away from margins

set nowrap

set showmatch
set ignorecase
set smartcase
set incsearch
set hlsearch

set autowrite

set shiftwidth=4
set textwidth=4
set tabstop=4
set noexpandtab
set copyindent
set autoindent
set smartindent
set cindent
set cino=L-1,:0,t0,i8,g0,N-4,(0,U1,m1,W4
set cink+=*;

set undofile
set backup
set noswapfile
set undodir=~/.config/nvim/tmp/undo/
set backupdir=~/.config/nvim/tmp/backup/
set directory=~/.config/nvim/tmp/swap/

" Linux Kernel development variables - set to 1 to enable
"let g:load_linuxsty = 1

" Resize => rearrange windows
au VimResized * exe "normal! \<c-w>="

" Set norelativenumber on non-active windows only
set number
set relativenumber
augroup rnumber
    au!
    au WinLeave * setlocal norelativenumber
    au WinEnter * setlocal relativenumber
augroup END

" Set cursorline on current window and normal mode only
set cursorline
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
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

" common typos
command! Qa qa
command! Q :q
command! W :w
command! Y y$

" visual on last pasted region
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

" visual on last inserted region
nnoremap gv `[v`]

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

" use jk to exit insert mode
inoremap jk <esc>

" terminal support! :>
let g:terminal_scrollback_buffer_size=100000
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>te :terminal<CR>

" Make X an operator that removes text without placing text in the default
" registry
nmap X "_d
nmap XX "_dd
vmap X "_d
vmap x "_d

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

" }}}
