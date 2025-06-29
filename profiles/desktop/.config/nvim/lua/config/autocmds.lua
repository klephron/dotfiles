local funcs = require("utils.funcs")

funcs.augroup("local_nasm", {
  {
    event = { "BufRead", "BufNewFile" },
    pattern = "*.inc,*.asm",
    command = "set filetype=nasm",
  }
})

funcs.augroup("local_jenkinsfile", {
  {
    event = { "BufRead", "BufNewFile" },
    pattern = "jenkinsfile,Jenkinsfile,*.jenkinsfile,*.Jenkinsfile",
    command = "set filetype=groovy"
  }
})

funcs.augroup("local_jinja", {
  {
    event = { "BufRead", "BufNewFile" },
    pattern = "*.j2",
    command = "set filetype=jinja"
  }
})

-- :% - entire file; %!xxd - pass the entire content of file inside xxd and write in the same file
-- same in shell: cat $1 | xxd | tee $1
-- Define the augroup for handling binary files with xxd
funcs.augroup("local_binary_xxd", {
  {
    event = { "BufReadPre" },
    pattern = "*.bin,*.exe,*.out",
    command = function()
      vim.opt_local.binary = true
    end,
  },
  {
    event = { "BufReadPost" },
    pattern = "*.bin,*.exe,*.out",
    command = function()
      if vim.opt_local.binary:get() then
        vim.cmd("%!xxd")
        vim.bo.filetype = "xxd"
      end
    end,
  },
  {
    event = { "BufWritePre" },
    pattern = "*.bin,*.exe,*.out",
    command = function()
      if vim.opt_local.binary:get() then
        vim.cmd("%!xxd -r")
      end
    end,
  },
  {
    event = { "BufWritePost" },
    pattern = "*.bin,*.exe,*.out",
    command = function()
      if vim.opt_local.binary:get() then
        vim.cmd("%!xxd")
        vim.opt_local.modified = false
      end
    end,
  },
})

-- Create directories when needed, when saving a file
funcs.augroup("local_create_dir_on_file_write", {
  {
    event = { "BufWritePre" },
    command = function(event)
      local file = vim.loop.fs_realpath(event.match) or event.match

      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
      local backup = vim.fn.fnamemodify(file, ":p:~:h")
      backup = backup:gsub("[/\\]", "%%")
      vim.go.backupext = backup
    end
  }
})

-- Fix conceallevel for json & help files
funcs.augroup("local_json_conceal", {
  {
    event = { "FileType" },
    pattern = { "json", "jsonc" },
    command = function()
      vim.wo.spell = false
      vim.wo.conceallevel = 0
    end
  }
})

-- Go to last loc when opening a buffer
funcs.augroup("local_open_last_loc", {
  {
    event = "BufReadPre",
    patterm = "*",
    command = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "<buffer>",
        once = true,
        callback = function()
          vim.cmd(
            [[if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif]]
          )
        end,
      })
    end
  }
})

funcs.augroup("local_keymap_q_close", {
  {
    event = "FileType",
    pattern = {
      "qf",
      "help",
      "man",
      "notify",
      "lspinfo",
      "gitsigns-blame",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "PlenaryTestPopup",
      "dap-float",
    },
    command = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end
  }
})

funcs.augroup("local_resize_on_window_change", {
  {
    event = { "VimResized" },
    command = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd("tabdo wincmd =")
      vim.cmd("tabnext " .. current_tab)
    end
  }
})

funcs.augroup("local_text", {
  {
    event = "FileType",
    pattern = { "plaintex", "typst", "gitcommit", "markdown" },
    command = function()
      vim.opt_local.wrap = true
      -- vim.opt_local.spell = true
    end,
  }
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("local_lspformat", { clear = true }),
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format { async = true, id = args.data.client_id }
      end,
    })
  end
})

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


if funcs.is_vscode or funcs.is_firenvim then
  return
end

funcs.augroup("local_restore_cursor_shape", {
  {
    event = "VimLeave",
    pattern = "*",
    command = function()
      vim.opt.guicursor = {
        [[a:ver20]],
      }
    end
  }
})

-- Check reload file when changed
funcs.augroup("local_checktime", {
  {
    event = { "FocusGained", "TermClose", "TermLeave" },
    command = function()
      if vim.o.buftype ~= "nofile" then
        vim.cmd("checktime")
      end
    end
  }
})

funcs.augroup("local_reload_file", {
  {
    event = "BufWinEnter",
    pattern = "*",
    command = function()
      vim.cmd("if mode() != 'c' | checktime | endif")
    end
  }
})

--[[ funcs.augroup("local_save_on_focus_lost", {
  {
    event = "FocusLost",
    pattern = "*",
    command = function()
      if vim.bo.modifiable == true and vim.bo.readonly == false then
        if vim.bo.modified == true then
          vim.cmd("doautocmd BufWritePre")
          vim.cmd("silent! wall")
          vim.cmd("doautocmd BufWritePost")
        end
      end
    end
  }
}) ]]

-- Autosave after leaving insert mode
--[[ funcs.augroup("local_save_on_insert_leave", {
  {
    event = "InsertLeave",
    command = "silent! update",
    nested = true
  }
}) ]]
