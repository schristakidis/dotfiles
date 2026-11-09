M = {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},   -- Enhances `ask()`
        picker = {    -- Enhances `select()`
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    -- autochdir=true reverts any temporary :lcd, so instead of changing cwd we
    -- patch the plugin's session lookup to query the project root directly.
    local function project_root()
      local dir = vim.fn.getcwd()
      for _ = 1, 20 do
        if vim.uv.fs_stat(dir .. "/.git") then return dir end
        if vim.uv.fs_stat(dir .. "/pyproject.toml") then return dir end
        local parent = vim.fs.dirname(dir)
        if parent == dir then break end
        dir = parent
      end
      return nil
    end

    -- Patch Server:get_sessions to scope by project root (nearest .git, else
    -- pyproject.toml) rather than the literal cwd. Falls back to original.
    do
      local ok, Server = pcall(require, "opencode.server")
      if ok and Server and Server.get_sessions then
        Server.get_sessions = function(self)
          local root = project_root() or vim.fn.getcwd()
          local Promise = require("opencode.promise")
          local path = "/api/session?directory=" .. vim.uri_encode(root) .. "&order=desc&parentID=null"
          return self:request(path, "GET"):next(function(response)
            return Promise.resolve(response and response.data or {})
          end)
        end
      end
    end

    -- OpenCode sends edit filepaths relative to the project root, but the plugin
    -- resolves them against nvim's cwd (fnamemodify ":p"). From a subdirectory that
    -- misses, so wrap diff() to retry with the path resolved against the project root.
    do
      local ok, edits = pcall(require, "opencode.events.permissions.edits")
      if ok and edits and edits.diff then
        local orig_diff = edits.diff
        edits.diff = function(event)
          local Promise = require("opencode.promise")
          return orig_diff(event):catch(function(err)
            if type(err) ~= "string" or not err:find("Cannot resolve OpenCode edit target file") then
              return Promise.reject(err)
            end
            local preview = edits.preview(event)
            local root = project_root()
            if not (preview and preview.filepath and root) then
              return Promise.reject(err)
            end
            local candidate = vim.fs.normalize(vim.fs.joinpath(root, preview.filepath))
            if vim.fn.isdirectory(vim.fs.dirname(candidate)) == 1 then
              local patched = vim.deepcopy(event)
              local files = patched.data.metadata and patched.data.metadata.files
              if files and files[1] then files[1].file = candidate end
              if not (patched.data.resources and patched.data.resources[1]) then
                patched.data.resources = { candidate }
              end
              return orig_diff(patched)
            end
            return Promise.reject(err)
          end)
        end
      end
    end

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<localleader>a", function() require("opencode").ask("@this: ") end,
      { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<localleader>aa", function() require("opencode").select() end,
      { desc = "Select opencode…" })

    vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
      { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
      { desc = "Add line to opencode", expr = true })
  end,
}


return M
