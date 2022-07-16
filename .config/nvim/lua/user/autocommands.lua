--[[ TODO understand how to write lua autocommands
vim.api.nvim_create_autocmd( {"User", "VimtexEventInitPost"}, {
    command = "call vimtex#compiler#start()"
})
--]]
vim.cmd [[
augroup vimtex
    autocmd!
    au User VimtexEventInitPost call vimtex#compiler#start()
augroup END
]]
