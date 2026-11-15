local config = require("config")
local profiles = require("profiles")

profiles.load(config.profile.name)

vim.lsp.enable("mals")
