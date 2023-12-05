vim.cmd('noremap <C-b> :noh<cr>:call clearmatches()<cr>') -- clear matches Ctrl+b

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

function cmap(shortcut, command)
  map('c', shortcut, command)
end

function tmap(shortcut, command)
  map('t', shortcut, command)
end

-- Disable bad habits
nmap("<up>", "<nop>")
nmap("<down>", "<nop>")
nmap("<left>", "<nop>")
nmap("<right>", "<nop>")

vmap("<up>", "<nop>")
vmap("<down>", "<nop>")
vmap("<left>", "<nop>")
vmap("<right>", "<nop>")

imap("<up>", "<nop>")
imap("<down>", "<nop>")
imap("<left>", "<nop>")
imap("<right>", "<nop>")

-- Airline configuration
nmap("<leader>1", "<Plug>AirlineSelectTab1")
nmap("<leader>2", "<Plug>AirlineSelectTab2")
nmap("<leader>3", "<Plug>AirlineSelectTab3")
nmap("<leader>4", "<Plug>AirlineSelectTab4")
nmap("<leader>5", "<Plug>AirlineSelectTab5")
nmap("<leader>6", "<Plug>AirlineSelectTab6")
nmap("<leader>7", "<Plug>AirlineSelectTab7")
nmap("<leader>8", "<Plug>AirlineSelectTab8")
nmap("<leader>9", "<Plug>AirlineSelectTab9")

-- Telescope
nmap("<F3>", "<cmd>Telescope find_files<cr>")
nmap("<F5>", "<cmd>Telescope live_grep<cr>")
nmap("<leader>l", "<cmd>Telescope buffers<cr>")

vim.api.nvim_create_user_command('Qa', "qa", {bang = true})
vim.api.nvim_create_user_command('Q', ":q", {bang = true})
vim.api.nvim_create_user_command('W', ":w", {bang = true})

-- Clean trailing whitespaces
vim.cmd([[nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<cr>]])

-- <C-w>x should also switch to other window
nmap("<C-w>x", "<C-w>x<C-w><C-w><CR>")

-- Clean searches and re-set them
nmap("<leader><space>", ":noh<CR>:call clearmatches()<CR>")

-- Make sure searches places result in center
nmap("#", ":normal! #zzzv<CR>")
nmap("*", ":normal! *zzzv<CR>")
nmap("n", ":normal! nzzzv<CR>")
nmap("N", ":normal! Nzzzv<CR>")

-- Highlight Searches with Colors
vim.cmd([[
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
]])

-- Zoom / Restore window.
vim.cmd([[
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
nnoremap <silent> <Leader><Leader> :ZoomToggle<CR>]])


nmap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
nmap('<leader>rn', '<cmd>Lspsaga rename ++project<CR>', opts)
nmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
nmap('<leader>e', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
