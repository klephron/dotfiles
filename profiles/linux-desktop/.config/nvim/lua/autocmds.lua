-- Default settings, can be overriden later by plugins
local config = require("config")
local utils = require("utils")
local keymap_augroups = require("keymaps").augroups

-- KEYMAPS
if keymap_augroups.map_close then
  utils.augroup("l.map_close", keymap_augroups.map_close)
else
  vim.notify("autocmds: map_close is " .. keymap_augroups.map_close)
end

if keymap_augroups.map_nohl then
  utils.augroup("l.map_nohl", keymap_augroups.map_nohl)
else
  vim.notify("autocmds: map_nohl is " .. keymap_augroups.map_nohl)
end

if keymap_augroups.map_terminal then
  utils.augroup("l.map_terminal", keymap_augroups.map_terminal)
end


-- FILETYPES
utils.augroup("l.nasm", {
  {
    event = { "BufRead", "BufNewFile" },
    pattern = "*.inc,*.asm",
    command = "set filetype=nasm",
  }
})

utils.augroup("l.jenkinsfile", {
  {
    event = { "BufRead", "BufNewFile" },
    pattern = "jenkinsfile,Jenkinsfile,*.jenkinsfile,*.Jenkinsfile",
    command = "set filetype=groovy"
  }
})

utils.augroup("l.jinja", {
  {
    event = { "BufRead", "BufNewFile" },
    pattern = "*.j2",
    command = "set filetype=jinja"
  }
})

-- :% - entire file; %!xxd - pass the entire content of file inside xxd and write in the same file
-- same in shell: cat $1 | xxd | tee $1
-- Define the augroup for handling binary files with xxd
utils.augroup("l.bin", {
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

-- Fix conceallevel for json & help files
utils.augroup("l.json_conceal", {
  {
    event = { "FileType" },
    pattern = { "json", "jsonc" },
    command = function()
      vim.wo.spell = false
      vim.wo.conceallevel = 0
    end
  }
})

utils.augroup("l.text", {
  {
    event = "FileType",
    pattern = { "plaintex", "typst", "gitcommit", "markdown" },
    command = function()
      vim.opt_local.wrap = true
      -- vim.opt_local.spell = true
    end,
  }
})

-- UTILITY
-- Create directories when needed, when saving a file
utils.augroup("l.create_dir_on_file_write", {
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

-- Go to last loc when opening a buffer
utils.augroup("l.open_last_loc", {
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

utils.augroup("l.resize_on_window_change", {
  {
    event = { "VimResized" },
    command = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd("tabdo wincmd =")
      vim.cmd("tabnext " .. current_tab)
    end
  }
})


if not config.profile.contains('vscode', 'firenvim') then
  utils.augroup("l.restore_cursor_shape", {
    {
      event = "ExitPre",
      pattern = "*",
      command = function()
        -- vim.cmd("set guicursor=a:ver20")
        -- vim.cmd("set guicursor=a:ver90")
      end
    }
  })

  -- Check reload file when changed
  utils.augroup("l.checktime", {
    {
      event = { "FocusGained", "TermClose", "TermLeave" },
      command = function()
        if vim.o.buftype ~= "nofile" then
          vim.cmd("checktime")
        end
      end
    }
  })

  utils.augroup("l.reload_file", {
    {
      event = "BufWinEnter",
      pattern = "*",
      command = function()
        vim.cmd("if mode() != 'c' | checktime | endif")
      end
    }
  })

  --[[ funcs.augroup("l.save_on_focus_lost", {
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
  --[[ funcs.augroup("l.save_on_insert_leave", {
    {
      event = "InsertLeave",
      command = "silent! update",
      nested = true
    }
  }) ]]
end
