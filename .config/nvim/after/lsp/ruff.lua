return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	init_options = {
		settings = {
			lineLength = 88, -- Black
			showSyntaxErrors = false, -- Redundant (handled by Pyright)
			configuration = {
				lint = {
					preview = true,
					-- ["extend-select"] = {
					-- 	"ALL", -- enable all
					-- 	"ARG", -- unused arguments
					-- 	"F", -- Pyflakes rules
					-- 	"W", -- PyCodeStyle warnings
					-- 	"E", -- PyCodeStyle errors
					-- 	"I", -- Sort imports properly
					-- 	"UP", -- Warn if certain things can changed due to newer Python versions
					-- 	"C4", -- Catch incorrect use of comprehensions, dict, list, etc
					-- 	"FA", -- Enforce from __future__ import annotations
					-- 	"ISC", -- Good use of string concatenation
					-- 	"ICN", -- Use common import conventions
					-- 	"RET", -- Good return practices
					-- 	"SIM", -- Common simplification rules
					-- 	"TID", -- Some good import practices
					-- 	"TC", -- Enforce importing certain types in a TYPE_CHECKING block
					-- 	"PTH", -- Use pathlib instead of os.path
					-- 	"TD", -- Be diligent with TODO comments
					-- 	"NPY", -- Some numpy-specific things
					-- },
					select = {
						-- pycodestyle
						"E",
						-- pycodestyle
						"W",
						-- Pyflakes
						-- "F",
						-- pyupgrade
						-- "UP",
						-- flake8-bugbear
						"B",
						-- flake8-simplify
						"SIM",
						-- isort
						"I",
					},
				},
				format = {
					["quote-style"] = "preserve",
				},
			},
		},
	},
}
