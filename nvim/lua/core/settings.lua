local M = {}

-- theme: nightfox, tokyonight, tundra, kanagawa; default is catppuccin
-- refer to the themes settings file for different styles
-- M.theme = "onedark"
-- Toggle global status line
M.global_statusline = true
-- enable or disable listchars
M.list = false
-- which list chars to schow
M.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<"
-- treesitter parsers to be installed
-- one of "all", "maintained" (parsers with maintainers), or a list of languages
M.treesitter_ensure_installed = {
    "bash",
    "cmake",
    "css",
    "dockerfile",
    "go",
    "hcl",
    "html",
    "java",
    "javascript",
    "json",
    "kotlin",
    "ledger",
    "lua",
    "markdown",
    "markdown_inline",
    "query",
    "python",
    "regex",
    "terraform",
    "toml",
    "vim",
    "yaml",
}

-- Tools that should be installed by Mason(-tool-install)
M.mason_tool_installer_ensure_installed = {
    -- LSP
    "bash-language-server",
    "dockerfile-language-server",
    "json-lsp",
    "marksman",
    "typescript-language-server",
    "texlab",
    "ltex-ls",
    "lua-language-server",
    "pyright",
    "terraform-ls",
    "yaml-language-server",
    -- Formatter
    "black",
    "prettier",
    "stylua",
    "shfmt",
    -- Linter
    "eslint_d",
    "shellcheck",
    "tflint",
    "yamllint",
    -- DAP
    "debugpy",
}

-- enable greping in hidden files
M.telescope_grep_hidden = true

-- which patterns to ignore in file switcher
M.telescope_file_ignore_patterns = {
    "%.7z",
    "%.JPEG",
    "%.JPG",
    "%.MOV",
    "%.RAF",
    "%.burp",
    "%.bz2",
    "%.cache",
    "%.class",
    "%.dll",
    "%.docx",
    "%.dylib",
    "%.epub",
    "%.exe",
    "%.flac",
    "%.ico",
    "%.ipynb",
    "%.jar",
    "%.jpeg",
    "%.jpg",
    "%.lock",
    "%.mkv",
    "%.mov",
    "%.mp4",
    "%.otf",
    "%.pdb",
    "%.pdf",
    "%.png",
    "%.rar",
    "%.sqlite3",
    "%.svg",
    "%.tar",
    "%.tar.gz",
    "%.ttf",
    "%.webp",
    "%.zip",
    ".git/",
    ".gradle/",
    ".idea/",
    ".settings/",
    ".vale/",
    ".vscode/",
    "__pycache__/*",
    "build/",
    "env/",
    "gradle/",
    "node_modules/",
    "smalljre_*/*",
    "target/",
    "vendor/*",
}

return M
