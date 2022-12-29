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
