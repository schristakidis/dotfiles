M = {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			disable_inline_completion = true,
			ignore_filetypes = { "markdown", "norg", "json", "text", "log" }
		})
	end,
}

return M
