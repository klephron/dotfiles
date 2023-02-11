local fn = vim.fn
local api = vim.api

---------------------------------------------------------------------------------
-- Autocmds
---------------------------------------------------------------------------------
us.augroup("_nasm", {
  {
    event = "BufRead,BufNewFile",
    pattern = "*.inc,*.asm",
    command = "set filetype=nasm",
  }
})

-- Check reload file when changed
api.nvim_create_autocmd("FocusGained", { command = "checktime" })

us.augroup("ReloadFile", {
  {
    event = "BufWinEnter",
    pattern = "*",
    command = function()
      vim.cmd("if mode() != 'c' | checktime | endif")
    end
  }
})

-- Autosave after leaving insert mode
us.augroup("AutosaveAfterInsert", {
  {
    event = "InsertLeave",
    command = "silent update",
    nested = true
  }
})

-- :% - entire file; %!xxd - pass the entire content of file inside xxd and write in the same file
-- same in shell: cat $1 | xxd | tee $1
vim.cmd [[
  augroup _binary
    au! 
    au BufReadPre   *.bin,*.exe,*.out let &bin=1
    au BufReadPost  *.bin,*.exe,*.out if &bin | %!xxd
    au BufReadPost  *.bin,*.exe,*.out set ft=xxd | endif
    au BufWritePre  *.bin,*.exe,*.out if &bin | %!xxd -r
    au BufWritePre  *.bin,*.exe,*.out endif
    au BufWritePost *.bin,*.exe,*.out if &bin | %!xxd
    au BufWritePost *.bin,*.exe,*.out set nomod | endif
  augroup end
]]

-- Create directories when needed, when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    local file = vim.loop.fs_realpath(event.match) or event.match

    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    local backup = vim.fn.fnamemodify(file, ":p:~:h")
    backup = backup:gsub("[/\\]", "%%")
    vim.go.backupext = backup
  end,
})

-- Fix conceallevel for json & help files
api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 0
  end,
})

-- Go to last loc when opening a buffer
api.nvim_create_autocmd("BufReadPre", {
  pattern = "*",
  callback = function()
    api.nvim_create_autocmd("FileType", {
      pattern = "<buffer>",
      once = true,
      callback = function()
        vim.cmd(
          [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
        )
      end,
    })
  end,
})

api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
---------------------------------------------------------------------------------
-- User commands
---------------------------------------------------------------------------------
api.nvim_create_user_command("Pwd", function()
  local reg_cmd = "" ..
    ":redir @+ \n" ..
    ":echon getcwd()\n" ..
    ":redir end"
  vim.cmd(":echo '' | redraw") -- clear commandline
  vim.cmd(reg_cmd)
end, { nargs = 0 })

api.nvim_create_user_command("Fdir", function()
  vim.cmd('echo expand("%")')
end, { nargs = 0 })
---------------------------------------------------------------------------------
-- Funny thing from folke
---------------------------------------------------------------------------------
-- local id
-- for _, key in ipairs({ "h", "j", "k", "l" }) do
  -- local count = 0
--   vim.keymap.set("n", key, function()
--     if count >= 10 then
--       id = vim.notify("Hold it Cowboy!", vim.log.levels.WARN, {
--         icon = "🤠",
--         replace = id,
--         keep = function()
--           return count >= 10
--         end,
--       })
--     else
--       count = count + 1
--       vim.defer_fn(function()
--         count = count - 1
--       end, 5000)
--       return key
--     end
--   end, { expr = true })
-- end
