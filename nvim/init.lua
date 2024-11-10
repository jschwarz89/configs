require("config")

vim.cmd([[
call serverstart(tempname())
let &titlestring="nvim %F -- [" . v:servername . "]"
set title

if &term == 'xterm-kitty'
    set termguicolors
    let &t_ut=''
endif
]])
