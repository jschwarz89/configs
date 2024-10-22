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

require('nightfox').setup({
  options = {
    transparent = false,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    styles = {               -- Style to be applied to different syntax groups
      comments = "italic",     -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
  },
  palettes = {
    carbonfox = {
      bg1 = "#070707",
    },
  },
})

vim.cmd([[colorscheme carbonfox]])

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
vim.opt.undodir = "~/.config/nvim/tmp/undo/"
vim.opt.backupdir = "~/.config/nvim/tmp/backup/"
vim.opt.directory = "~/.config/nvim/tmp/swap/"

vim.opt.shortmess = vim.opt.shortmess + "c"
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.hidden = true

vim.opt.expandtab = true

-- Linux Kernel development variables - set to 1 to enable
-- vim.g.load_linuxsty = 1

-- Resize => rearrange windows
vim.cmd [[ au VimResized * exe "normal! \<c-w>=" ]]

-- Set norelativenumber on non-active windows only
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd([[
augroup rnumber
    au!
    au WinLeave,FocusLost * setlocal norelativenumber expandtab
    au WinEnter,FocusGained * setlocal relativenumber expandtab
augroup END
]])

-- Set cursorline on current window and normal mode only
--vim.opt.cursorline = true
--vim.cmd([[
--augroup cline
    --au!
    --au WinLeave,InsertEnter * set nocursorline expandtab
    --au WinEnter,InsertLeave * set cursorline expandtab
--augroup END
--]])

-- Colors for 120-chars-per-line column
vim.opt.cursorline = true
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