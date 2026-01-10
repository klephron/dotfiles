vim.cmd("cnoreabbrev ea EasyAlign")

vim.api.nvim_create_user_command("Pwd", function()
  local reg_cmd = "" ..
      ":redir @+ \n" ..
      ":echon getcwd()\n" ..
      ":redir end"
  vim.cmd(":echo '' | redraw")
  vim.cmd(reg_cmd)
end, { nargs = 0 })


vim.api.nvim_create_user_command("Fdir", function()
  local reg_cmd = "" ..
      ":redir @+ \n" ..
      ":echon expand('%:h')\n" ..
      ":redir end"
  vim.cmd(":echo '' | redraw")
  vim.cmd(reg_cmd)
end, { nargs = 0 })
