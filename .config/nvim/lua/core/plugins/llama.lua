local function is_file_buffer()
	local b = vim.api.nvim_get_current_buf()
	if not b then
		return false
	end
	local name = vim.api.nvim_buf_get_name(b)
	local buftype = vim.api.nvim_buf_get_option(b, "buftype")
	return not name:match("^%[") and (buftype == "" or buftype == "acwrite")
end

local function sync()
	-- llama#disable() runs `autocmd! llama`, removing the *global* CursorMovedI
	-- completion autocmd — the only way to truly stop completions in a buffer
	-- (the auto_fim flag is read once at enable-time, never checked at runtime).
	-- We re-enable as soon as we're back in a real file buffer, so popups that
	-- bounce back (confirm dialogs, Telescope closed, ...) don't leave it dead.
	if is_file_buffer() then
		vim.cmd("silent! LlamaEnable")
	else
		vim.cmd("silent! LlamaDisable")
	end
end

return {
	"ggml-org/llama.vim",
	init = function()
		vim.g.llama_config = {
			endpoint_fim = "http://localhost:8080/infill",
			endpoint_inst = "http://localhost:8080/v1/chat/completions",
			keymap_fim_trigger = "<A-y>",
			keymap_fim_accept_full = "<C-y>",
			keymap_fim_accept_line = "<C-Space>",
			show_info = 0,
		}

		vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
			group = vim.api.nvim_create_augroup("llama_buffer_gate", {}),
			callback = sync,
		})
	end,
}
