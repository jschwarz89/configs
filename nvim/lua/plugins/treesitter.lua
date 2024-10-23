return {
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
        require'nvim-treesitter.configs'.setup {
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "python",
                "go",
                "json",
                "bash",
            },
            sync_install = false,
            auto_install = false,
            ignore_install = { "javascript" },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end,
}
