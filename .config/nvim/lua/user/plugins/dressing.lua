return function()
  local dressing = require("dressing")
  dressing.setup({
    input = {
      insert_only = false,
      winblend = 5,
      mappings = {
        n = {
          ["<Esc>"] = false,
        }
      }
    },
  })

  -- set nowait
  us.augroup("_DressingInput", {
    {
      event = "FileType",
      pattern = "DressingInput",
      description = "DressingInput nowait",
      command = function()
        us.set_keynomap("n", "<Esc>", ":close<cr>", { nowait = true, buffer = 0 })
      end
    }
  })

end
