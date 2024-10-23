vim.cmd([[
augroup rnumber
    au!
    au WinLeave,FocusLost * setlocal norelativenumber expandtab
    au WinEnter,FocusGained * setlocal relativenumber expandtab
augroup END
]])

-- Colors for 120-chars-per-line column
vim.cmd([[
let &colorcolumn="119"
au BufRead,BufNewFile *.c,*.cpp,*.h,*.hpp let &colorcolumn="120"
highlight ColorColumn ctermbg=235 guibg=#2c2d27
highlight CursorLineNr ctermfg=255
highlight LineNr ctermfg=grey

" Colors for sign column (pyflakes)
highlight SignColumn ctermbg=red
highlight SignColumn ctermfg=white
highlight CursorLine guibg=#101010
]])

-- Remember position
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])

-- Set trailing line marking, except for insert mode
vim.cmd([[
highlight Trailing guibg=red
match Trailing / \+$/
autocmd InsertEnter * match Trailing //
autocmd InsertLeave * match Trailing / \+$/
]])

