vim.cmd([[
filetype plugin indent on
syntax on
]])

vim.g.cpp_class_scope_highlight = 1
vim.g.cpp_member_variable_highlight = 1
vim.g.cpp_class_decl_highlight = 1
vim.g.cpp_posix_standard = 1

vim.opt.termguicolors = true
vim.opt.background = "dark"


--vim.cmd([[colorscheme carbonfox]])

vim.opt.exrc = true
vim.opt.secure = true

vim.opt.path = vim.opt.path + "**,/usr/include,/opt/ros/melodic/include"
vim.opt.wildmenu = true
vim.opt.foldenable = false
vim.opt.modelines = 0
vim.opt.suffixes = vim.opt.suffixes + ".pyc"

vim.opt.mouse = "a"
vim.opt.equalalways = true
vim.opt.visualbell = false
vim.opt.scrolloff = 3

vim.opt.wrap = false

vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.autowrite = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

vim.opt.copyindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.indentexpr = ""
vim.opt.cindent = true
vim.opt.cino = "L-1,:0,t0,i8,g0,N-4,(0,U1,m1,W4"
vim.opt.cink = vim.opt.cink + "*"
vim.opt.eol = false
vim.opt.binary = true

vim.opt.undofile = true
vim.opt.backup = true
vim.opt.swapfile = false
vim.opt.undodir = vim.fs.normalize("~/.config/nvim/tmp/undo/")
vim.opt.backupdir = vim.fs.normalize("~/.config/nvim/tmp/backup/")
vim.opt.directory = vim.fs.normalize("~/.config/nvim/tmp/swap/")

vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.hidden = true

vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
