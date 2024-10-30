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

-- Bufferline configuration
nmap("<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>")
nmap("<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>")
nmap("<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>")
nmap("<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>")
nmap("<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>")
nmap("<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>")
nmap("<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>")
nmap("<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>")
nmap("<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>")
--nmap("<leader>1", "<Cmd>lua require('bufferline').go_to(1, true)<CR>")
--nmap("<leader>2", "<Cmd>lua require('bufferline').go_to(2, true)<CR>")
--nmap("<leader>3", "<Cmd>lua require('bufferline').go_to(3, true)<CR>")
--nmap("<leader>4", "<Cmd>lua require('bufferline').go_to(4, true)<CR>")
--nmap("<leader>5", "<Cmd>lua require('bufferline').go_to(5, true)<CR>")
--nmap("<leader>6", "<Cmd>lua require('bufferline').go_to(6, true)<CR>")
--nmap("<leader>7", "<Cmd>lua require('bufferline').go_to(7, true)<CR>")
--nmap("<leader>8", "<Cmd>lua require('bufferline').go_to(8, true)<CR>")
--nmap("<leader>9", "<Cmd>lua require('bufferline').go_to(9, true)<CR>")

nmap("<leader>`", "<Cmd>BufferLineCyclePrev<CR>")
nmap("<leader>0", "<Cmd>BufferLineCycleNext<CR>")

nmap("<C-PageUp>", "<Cmd>BufferLineMoveNext<CR>")
nmap("<C-PageDown>", "<Cmd>BufferLineMovePrev<CR>")

-- Telescope
nmap("<F3>", "<cmd>Telescope find_files<cr>")
nmap("<F5>", "<cmd>Telescope live_grep<cr>")
nmap("<leader>l", "<cmd>Telescope buffers<cr>")

nmap("<F6>", "<cmd>CopilotChatToggle<cr>")
vmap("<F6>", "<cmd>CopilotChatToggle<cr>")

nmap("<F4>", "<cmd>ToggleTerm<cr>")

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
nmap('gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
nmap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
nmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
