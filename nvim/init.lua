require("config")

vim.cmd([[
call serverstart(tempname())
let &titlestring="nvim %F -- [" . v:servername . "]"
set title
]])
