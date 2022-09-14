local fn = vim.fn
local api = vim.api

us.augroup("_vimtex", {
  {
    event = "User",
    pattern = "VimtexEventInitPost",
    -- command = "call vimtex#compiler#start()",
    command = function()
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
      -- vim.opt_local.spell = true
    end
  }
})

us.augroup("_info_pages", {
  {
    event = "FileType",
    pattern = "help,lspinfo,qf,vim,checkhealth,dap-float",
    command = function()
      us.set_keynomap("n", "q", "<cmd>close<cr>", { buffer = 0 })
    end
  },
  {
    event = "FileType",
    pattern = "lspinfo,qf,vim,checkhealth,dap-float",
    command = function()
      us.set_keynomap("n", "<Esc>", "<cmd>close<cr>", { buffer = 0 })
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
    command = function()
      if vim.bo.modifiable == true and vim.bo.readonly == false then
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

local running_timer_id = nil
-- :h getcmdtype
us.augroup("_cmdline_leave", {
  {
    event = "CmdlineLeave",
    pattern = ":,@,/",
    description = "Clear cmdline after period of time",
    command = function()
      if running_timer_id ~= nil then
        fn.timer_stop(running_timer_id)
      end

      running_timer_id = vim.fn.timer_start(3000, function()
        local mode = vim.api.nvim_get_mode().mode
        if vim.tbl_contains({ "n", "v", "s", }, mode) then
          vim.cmd("echon ''")
          running_timer_id = nil
        end
      end)
    end
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

api.nvim_create_user_command("Pwd", function()
  local reg_cmd = "" ..
      ":redir @+ \n" ..
      ":echon getcwd()\n" ..
      ":redir end"
  vim.cmd(":echo '' | redraw") -- clear commandline
  vim.cmd(reg_cmd)
end, { nargs = 0 })

us.augroup("_focus_lost", {
  {
    event = "FocusLost",
    pattern = "*",
    command = function()
      vim.cmd("w")
    end
  }
})
