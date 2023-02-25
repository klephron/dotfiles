local M = {}

table.insert(M, conf_require("lsp.lspconfig"))
table.insert(M, conf_require("lsp.null-ls"))
table.insert(M, conf_require("lsp.lspsaga"))
table.insert(M, conf_require("lsp.lsp-signature"))
table.insert(M, conf_require("lsp.extensions"))

return M
