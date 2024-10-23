return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/nvim-compe",
    },
    config = function()
        local lspconfig = require'lspconfig'
        lspconfig.ccls.setup {
            init_options = {
                index = {
                    threads = 0;
                    initialBlacklist = {"."};
                    initialWhitelist = {"hcl", "synapse", "specs", "specs_external", "hl-thunk"};
                };
                clang = {
                    excludeArgs = {"-frounding-math"};
                };
                cache = {
                    directory = "/tmp/ccls"
                };
                highlight = {
                    lsRanges = true;
                };
            }
        }

        require'lspconfig'.pyright.setup{}

        vim.cmd([[
        let g:go_def_mode = 'gopls'
        let g:go_info_mode = 'gopls'
        let g:go_echo_command_info = 0
        ]])
        require'lspconfig'.gopls.setup{}

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            --Enable completion triggered by <c-x><c-o>
            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            local opts = { noremap=true, silent=true }
        end

        -- Use a loop to conveniently call 'setup' on multiple servers and
        -- map buffer local keybindings when the language server attaches
        local servers = { "ccls" }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup { on_attach = on_attach }
        end

        require'compe'.setup {
            enabled = true;
            autocomplete = true;
            debug = false;
            min_length = 1;
            preselect = 'enable';
            throttle_time = 80;
            source_timeout = 200;
            incomplete_delay = 400;
            max_abbr_width = 100;
            max_kind_width = 100;
            max_menu_width = 100;
            documentation = true;

            source = {
                path = true;
                nvim_lsp = true;
            };
        }

        local t = function(str)
            return vim.api.nvim_replace_termcodes(str, true, true, true)
        end

        local check_back_space = function()
            local col = vim.fn.col('.') - 1
            if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                return true
            else
                return false
            end
        end

        -- Use (s-)tab to:
        --- move to prev/next item in completion menuone
        --- jump to prev/next snippet's placeholder
        _G.tab_complete = function()
            if vim.fn.pumvisible() == 1 then
                return t "<C-n>"
            elseif check_back_space() then
                return t "<Tab>"
            else
                return vim.fn['compe#complete']()
            end
        end
        _G.s_tab_complete = function()
            if vim.fn.pumvisible() == 1 then
                return t "<C-p>"
            else
                return t "<S-Tab>"
            end
        end

        vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
        vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
        vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
        vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

        vim.api.nvim_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true })
    end,
}
