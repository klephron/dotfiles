local M = {
  "nvim-lualine/lualine.nvim",
  event = "UIEnter",
  config = function()
    local lualine = require("lualine")
    local lualine_progress = require("lualine.components.progress")
    -- local custom_theme = require("local.darkplus.lualine")

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    -- COMPONENTS
    local mode = {
      "mode",
      fmt = function(str)
        return str
      end,
    }

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " " },
      colored = false,
      update_in_insert = false,
      always_visible = true,
    }

    local diff = {
      "diff",
      colored = false,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width
    }

    local filename = {
      'filename',
      file_status = true, -- Displays file status (readonly status, modified status)
      -- 0: Just the filename
      -- 1: Relative path
      -- 2: Absolute path
      -- 3: Absolute path, with tilde as the home directory
      path = 0,
      shorting_target = 40,  -- Shortens path to leave 40 spaces in the window
      symbols = {
        modified = '[+]',    -- Text to show when the file is modified.
        readonly = '[-]',    -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
      },
      fmt = function()
        local par_dir = vim.fn.fnamemodify(vim.fn.expand('%:h'), ':t')
        local fname = vim.fn.expand('%:t')
        if par_dir == "." then
          return fname
        else
          return par_dir .. '/' .. fname
        end
      end
    }

    local filetype = {
      "filetype",
      icons_enabled = false,
      icon = nil,
    }

    local branch = {
      "branch",
      icons_enabled = true,
      icon = "",
    }

    local location = {
      "location",
      padding = 0,
    }

    local spaces = function()
      return "spaces:" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
    end

    local session_name = function()
        return require('possession.session').get_session_name() or ''
    end

    lualine.setup({
      options = {
        icons_enabled = true,
        -- theme = "vscode",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { branch, diagnostics },
        lualine_c = { session_name, filename },
        lualine_x = { "aerial" },
        lualine_y = { diff, "fileformat", spaces, },
        lualine_z = { location, lualine_progress }
      },
      inactive_sections = {
        lualine_a = { mode },
        lualine_b = { branch },
        lualine_c = { session_name, filename },
        lualine_x = { "aerial", "fileformat" },
        lualine_y = {},
        lualine_z = { location, lualine_progress },
      },
      tabline = {},
      extensions = { "aerial", "nvim-tree", "nvim-dap-ui", "quickfix", "toggleterm" },
    })
  end
}

return M
