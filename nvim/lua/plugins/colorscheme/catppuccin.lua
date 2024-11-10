return {
    "catppuccin/nvim",
    lazy = false,
    opts = {
        transparent_background = true,
    },
    config = function()
        require('catppuccin').setup({
                flavour = "mocha",
                color_overrides = {
                    all = {
                        base = "#070707"
                },
                default_integrations = true,
                transparent_background = false,
            }
        })
        vim.cmd("colorscheme catppuccin-mocha")
    end,
}
