return {
	"cenk1cenk2/schema-companion.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim" },
	},
	config = function()
		require("schema-companion").setup({
			-- enable_telescope = true,
			sources = {
				-- your sources for the language server
				require("schema-companion").sources.matchers.kubernetes.setup({
					version = "master",
				}),
			},
		})
	end,
}
