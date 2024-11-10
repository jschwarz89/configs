return {
	"EdenEast/nightfox.nvim",
	lazy = true,
	config = function()
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
        --vim.cmd('colorscheme carbonfox')
	end,
}
