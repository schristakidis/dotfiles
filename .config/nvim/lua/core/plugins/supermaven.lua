vim.g.supermaven_enabled = false

return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			disable_inline_completion = true,
			ignore_filetypes = { "markdown", "norg", "json", "text", "log" },
			condition = function()
				return not vim.g.supermaven_enabled
			end,
		})

		vim.keymap.set("n", "<localleader>sm", function()
			vim.g.supermaven_enabled = not vim.g.supermaven_enabled
			require("supermaven-nvim.api").toggle()
		end, { desc = "Toggle Supermaven" })
	end,
}
