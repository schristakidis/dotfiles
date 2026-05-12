M = {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			disable_inline_completion = true,
			ignore_filetypes = { "markdown", "norg", "json", "text", "log" },
      -- condition = function ()
      --   return true
      -- end
		})
	end,
}

return M

-- return {}
