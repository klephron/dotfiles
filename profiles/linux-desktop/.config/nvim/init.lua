local config = require("config")

assert(config.profile.valid,
  string.format('Invalid profile: %s, Expected oneof: %s',
    config.profile.name,
    vim.json.encode(config.profile.available)
  )
)

require('profiles.' .. config.profile.name)

vim.lsp.enable("mals")
