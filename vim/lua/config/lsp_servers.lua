-- local lsp_installer = require("nvim-lsp-installer")
-- local servers = {
-- 	"bashls",
--     "pyright",
--     "pylsp",
--     "dockerls",
--     "jsonls",
--     "sumneko_lua",
--     "terraformls",
-- 	"yamlls",
-- }
--
-- for _, name in pairs(servers) do
-- 	local ok, server = lsp_installer.get_server(name)
-- 	-- Check that the server is supported in nvim-lsp-installer
-- 	if ok then
-- 		if not server:is_installed() then
-- 			print("Installing " .. name)
-- 			server:install()
-- 		end
-- 	end
-- end
--
-- lsp_installer.on_server_ready(function(server)
-- 	-- Specify the default options which we'll use for pyright and solargraph
-- 	-- Note: These are automatically setup from nvim-lspconfig. See https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
-- 	local default_opts = {
-- 		on_attach = on_attach,
-- 		capabilities = capabilities,
-- 	}
--
-- 	-- Now we'll create a server_opts table where we'll specify our custom LSP server configuration
-- 	local server_opts = {}
-- 	-- 	["efm"] = function()
-- 	-- 		default_opts.cmd = {
-- 	-- 			vim.fn.stdpath("data") .. "/lsp_servers/efm/efm-langserver",
-- 	-- 			"-c",
-- 	-- 			"/Users/Oli/.config/efm-langserver/config.yaml",
-- 	-- 		}
-- 	-- 		default_opts.flags = {
-- 	-- 			debounce_text_changes = 150,
-- 	-- 		}
-- 	-- 		default_opts.filetypes = {
-- 	-- 			"css",
-- 	-- 			"html",
-- 	-- 			"javascript",
-- 	-- 			"python",
-- 	-- 		}
-- 	-- 		default_opts.init_options = {
-- 	-- 			documentFormatting = true,
-- 	-- 		}
--     --
-- 	-- 		default_opts.on_attach = on_attach
-- 	-- 		default_opts.capabilities = capabilities
--     --
-- 	-- 		return default_opts
-- 	-- 	end,
-- 	-- }
--
-- 	-- We check to see if any custom server_opts exist for the LSP server, if so, load them, if not, use our default_opts
-- 	server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
-- 	vim.cmd([[ do User LspAttachBuffers ]])
-- end)
