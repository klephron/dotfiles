local colors = l_require("darkplus.colors")

local darkplus = {}

darkplus.normal = {
  a = { fg = colors.light_gray, bg = colors.line, gui = "bold" },
  b = { fg = colors.light_gray, bg = colors.line, gui = "bold" },
  c = { fg = colors.light_gray, bg = colors.line, gui = "bold" },
  x = { fg = colors.light_gray, bg = colors.line, gui = "bold" },
  y = { fg = colors.light_gray, bg = colors.line, gui = "bold" },
  z = { fg = colors.light_gray, bg = colors.line, gui = "bold" },
}

darkplus.insert = {
  a = { fg = colors.light_gray, bg = colors.line, gui = "bold" },
}

darkplus.visual = {
  a = { fg = colors.light_gray, bg = colors.line, gui = "bold" },
}

darkplus.replace = {
  a = { fg = colors.light_gray, bg = colors.line, gui = "bold" },
}

darkplus.inactive = {
  a = { fg = colors.light_gray, bg = colors.line, gui = "bold" },
}

return darkplus
