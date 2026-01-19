local M = {
	"hrsh7th/nvim-cmp",
	lazy = false,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-calc",
		"lukas-reineke/cmp-rg",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"andersevenrud/cmp-tmux",
		"tzachar/cmp-fuzzy-path",
		"tzachar/cmp-fuzzy-buffer",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-cmdline",
		"tzachar/fuzzy.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		lspkind.init({
			symbol_map = {
				Supermaven = "",
			},
		})

		local luasnip = require("luasnip")

		local has_words_before = function()
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		vim.o.completeopt = "menuone,noselect"

		cmp.setup({
			formatting = {
				-- fields = { 'abbr', 'icon', 'kind', 'menu' },
				fields = { 'abbr', 'kind' },
				format = lspkind.cmp_format({
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- menu = function() return math.floor(0.45 * vim.o.columns) end,
						menu = 50, -- leading text (labelDetails)
						abbr = 50, -- actual suggestion item
					},
				}),
			},
			mapping = {
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-y>"] = cmp.mapping(
					cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),
					{ "i", "c" }
				),
				["<C-f>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				--   ['<C-Space>'] = cmp.mapping.complete(),
				--   ['<C-e>'] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				--
				--   ["<S-Tab>"] = cmp.mapping(function(fallback)
				--     if cmp.visible() then
				--       cmp.select_prev_item()
				--     elseif luasnip.jumpable(-1) then
				--       luasnip.jump(-1)
				--     else
				--       fallback()
				--     end
				--   end, { "i", "s" }),
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "buffer", keyword_length = 5 },
				{ name = "luasnip" },
				{ name = "calc" },
				{ name = "path" },
				{ name = "supermaven" },
			},
		})

		luasnip.config.set_config({
			history = false,
			updatevents = "TextChanged,TextChangedI",
		})

		vim.keymap.set({ "i", "s" }, "<C-k>", function()
			if luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-j>", function()
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { silent = true })

		-- cmp.setup.cmdline("/", {
		--   mapping = cmp.mapping.preset.cmdline(),
		--   sources = {
		--     { name = "buffer" },
		--   },
		-- })

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}

return M
