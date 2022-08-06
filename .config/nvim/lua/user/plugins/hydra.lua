local M = {}

local hydra = require("hydra")

M.hydras = {
  dap = function()
    local kmps = require("user.keymaps").dap.hydra
    hydra({
      name = "Dap hydra",
      mode = "n",
      body = kmps.body,
      -- hint = [[
      --
      -- ]],
      config = {
        exit = false,
        foreign_keys = "run",
        buffer = false,
        invoke_on_body = true,
        on_enter = function()

        end,
        on_exit = function()

        end,
        timeout = false,
        hint = {
          type = "window",
          position = "bottom",
          offset = 0,
          border = "none",
          show_name = true,

        }

      },
      heads = {
        -- {"c", , {exit = true}},
        {"p", "<cmd>echo 'HELLO!'<cr>", {silent = false, desc="HEHE"}},
      }
    })
  end,
}

return M
