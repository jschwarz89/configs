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
                "jsonc",
                "bash",
                "diff",
                "proto",
                "vimdoc",
            },
            sync_install = false,
            auto_install = false,
            ignore_install = { "javascript" },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-s>',
                    node_incremental = '<c-s>',
                    node_decremental = '<c-x>',
                },
            },
        }
    end,
}
