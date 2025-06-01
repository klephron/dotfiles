local M = {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  config = function(_, opts)
    local marks_utils = require("marks.utils")

    -- Tweak from https://github.com/chentoast/marks.nvim/blob/a69253e4b471a2421f9411bc5bba127eef878dc0/lua/marks/utils.lua#L9
    marks_utils.add_sign = function(bufnr, text, line, id, group, priority)
      priority = priority or 10
      local sign_name = "Marks_" .. text
      if not marks_utils.sign_cache[sign_name] then
        marks_utils.sign_cache[sign_name] = true
        -- disable numhl
        vim.fn.sign_define(sign_name, { text = text, texthl = "MarkSignHL" })
      end
      vim.fn.sign_place(id, group, sign_name, bufnr, { lnum = line, priority = priority })
    end

    require("marks").setup(opts)
  end,
  opts = {
    default_mappings = false,
    mappings = {
      set = "m",
      set_next = "m,",
      delete = "dm",
      delete_line = "dm,",
      delete_buf = "dm<space>",
      next = "m]",
      prev = "m[",
    }
  }
}

return M
