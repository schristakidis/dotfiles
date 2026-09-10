return {
	"ggml-org/llama.vim",
	init = function()
		vim.g.llama_config = {
			endpoint_fim = "http://localhost:8080/infill",
			endpoint_inst = "http://localhost:8080/v1/chat/completions",
			keymap_fim_trigger = "<A-y>",
			keymap_fim_accept_full = "<C-y>",
			keymap_fim_accept_line = "<C-u>",
			show_info = 0,
		}
	end,
}
