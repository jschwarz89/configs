return {
    "catppuccin/nvim",
    lazy = false,
    config = function()
        require('catppuccin').setup({
                flavour = "mocha",
                color_overrides = {
                    all = {
                        base = "#070707"
                },
                default_integrations = true,
            }
        })
        vim.cmd("colorscheme catppuccin-mocha")
    end,
}
