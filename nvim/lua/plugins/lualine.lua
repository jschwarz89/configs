local config = function()
	local current_colorscheme = "carbonfox"
	local lazy_status = require("lazy.status")

	require("lualine").setup({
		options = {
			theme = require("lualine.themes." .. current_colorscheme),
		},
		tabline = {},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{ "filename", path = 1 },
				function()
					return require('lsp-progress').progress()
				end,
				function()
					local msg = 'No Active Lsp'
					local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
					local clients = vim.lsp.get_active_clients()
					if next(clients) == nil then
						return msg
					end
					for _, client in ipairs(clients) do
						local filetypes = client.config.filetypes
						if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
							return client.name
						end
					end
					return msg
				end,
			},
			lualine_x = {
				"encoding",
				"filetype",
				"fileformat",
				{
					"lazy_status.updates",
					cond = lazy_status.has_updates,
					color = { fg = "#ff9e64" },
				},
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_c = { { "filename", path = 1 } },
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = config,
}