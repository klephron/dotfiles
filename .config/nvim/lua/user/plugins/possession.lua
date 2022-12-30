local M = {
  "jedrzejboczar/possession.nvim",
  enabled = false,
}

function M.config()
  local possession = require("possession")
  possession.setup({
    silent = true,
    load_silent = true,
    autosave = {
      current = true,  -- or fun(name): boolean
      tmp = false,  -- or fun(): boolean
      on_load = true,
      on_quit = true,
    },
    plugins = {
      delete_buffers = true
    }
  })

  if not pcall(function() require("telescope").load_extension("possession") end) then
    vim.notify("module 'telescope' for possession is not present", vim.log.levels.WARN, { title = "config" })
  end
end

return M
