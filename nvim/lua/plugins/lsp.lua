return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        -- Setup nvim-cmp (autocompletion engine)
        local cmp = require'cmp'

        cmp.setup({
            snippet = {
                expand = function(args)
                end,
            },
            mapping = {
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- Accept currently selected item

                -- C-n and C-p for navigating completion suggestions
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),

                -- Tab for completion or spaces
                ['<Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()  -- Navigate suggestions
                    else
                        fallback()
                    end
                end,

                -- Shift-Tab for going backward in the suggestion list
                ['<S-Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end,
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },  -- LSP completions
                { name = 'buffer' },    -- Buffer completions
            })
        })

        -- Setup LSP with nvim-lspconfig
        local lspconfig = require'lspconfig'

        -- LSP keybindings (for diagnostics, navigation, etc.)
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            -- Mappings (replace with your preferred bindings)
            local opts = { noremap=true, silent=true }
            buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        end

        -- Capabilities (for nvim-cmp)
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- LSP servers
        lspconfig.ccls.setup {
            init_options = {
                index = {
                    threads = 0;
                    initialBlacklist = {"."};
                    initialWhitelist = {"hcl", "synapse", "specs", "specs_external", "hl-thunk"};
                },
                clang = {
                    excludeArgs = {"-frounding-math"};
                },
                cache = {
                    directory = "/tmp/ccls"
                },
                highlight = {
                    lsRanges = true;
                },
            },
            on_attach = on_attach,
            capabilities = capabilities,
        }

        lspconfig.pyright.setup {  -- Python
            on_attach = on_attach,
            capabilities = capabilities,
        }

        vim.cmd([[
            let g:go_def_mode = 'gopls'
            let g:go_info_mode = 'gopls'
            let g:go_echo_command_info = 0
        ]])
        require'lspconfig'.gopls.setup{}
    end,
}
