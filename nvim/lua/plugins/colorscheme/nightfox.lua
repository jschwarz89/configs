return {
	"EdenEast/nightfox.nvim",
	lazy = true,
	config = function()
		require("nightfox").setup({
			options = {
				tranparent = true,
			},
		})
		vim.cmd('colorscheme carbonfox')
	end,
}
