local M = {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "https://github.com/nvim-neotest/nvim-nio",
  },
  config = function()
    local dapui = require("dapui")
    local funcs = require("utils.funcs")
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      expand_lines = true,
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "stacks",      size = 0.15 },
            { id = "scopes",      size = 0.30 },
            { id = "watches",     size = 0.40 },
            { id = "breakpoints", size = 0.15 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.15,
          position = "bottom",
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
      }
    })

    -- Listeners
    local dap = require("dap")

    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    -- Restore size after VimGained focus
    funcs.augroup("_dapui_resize", {
      {
        event = "VimResized",
        pattern = "*",
        command = function()
          local windows = require("dapui.windows")
          for _, layout in ipairs(windows.layouts) do
            if layout:is_open() then layout:resize({ reset = true }) end
          end
        end
      }
    })
  end
}
return M
