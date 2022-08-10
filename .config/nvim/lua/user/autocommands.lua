us.augroup("_vimtex", {
  {
    event = "User",
    pattern = "VimtexEventInitPost",
    -- command = "call vimtex#compiler#start()",
    command = function ()
      vim.fn["vimtex#compiler#start"]()
    end
  }
})

us.augroup("_text", {
  {
    event = "FileType",
    pattern = "gitcommit,markdown",
    command = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end
  }
})

us.augroup("_info_pages", {
  {
    event = "FileType",
    pattern = "help,lspinfo,qf,vim,checkhealth,dap-float",
    command = function()
      us.set_keynomap("n", "q", "<cmd>close<cr>", {buffer = 0})
    end
  },
  {
    event = "FileType",
    pattern = "lspinfo,qf,vim,checkhealth,dap-float",
    command = function()
      us.set_keynomap("n", "<Esc>", "<cmd>close<cr>", {buffer = 0})
    end
  },
})

us.augroup("_nasm", {
  {
    event = "BufRead,BufNewFile",
    pattern = "*.inc,*.asm",
    command = "set filetype=nasm",
  }
})

us.augroup("_leave", {
  {
    event = "BufLeave",
    pattern = "*",
    command = function ()
      if vim.bo.modifiable == true then
        vim.cmd("silent! write")
      end
    end
  }
})

us.augroup("_help", {
  {
    event = "BufWinEnter",
    pattern = "*.txt",
    command = function()
      if vim.bo.filetype == "help" then
        vim.cmd("wincmd L")
      end
    end
  }
})

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
