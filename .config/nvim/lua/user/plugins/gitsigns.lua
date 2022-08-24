return function()
  local gitsigns = require("gitsigns")
  local icons = require("user.icons").gitsigns
  local kmps = require("user.keymaps").git

  gitsigns.setup {
    signs = {
      add = { hl = 'GitSignsAdd', text = icons.add },
      change = { hl = 'GitSignsChange', text = icons.change },
      delete = { hl = 'GitSignsDelete', text = icons.delete },
      topdelete = { hl = 'GitSignsDelete', text = icons.topdelete },
      changedelete = { hl = 'GitSignsChange', text = icons.changedelete },
    },
    signcolumn = false,
    numhl = true,
    sign_priority = 6,
    current_line_blame = false,
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1
    },
    current_line_blame_opts = {
      delay = 500,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function qflist_hunks() return gs.setqflist('all') end
      local function blame_line_full() return gs.blame_line({ full = true }) end
      local function diffthis_PREV() return gs.diffthis('~') end

      ---@param desc string
      local function with_desc(desc)
        return { buffer = bufnr, desc = kmps:desc(desc) }
      end

      us.set_keynomap("n", kmps.undo_stage_hunk.key, gs.undo_stage_hunk, with_desc("undo_stage_hunk"))
      us.set_keynomap("n", kmps.preview_hunk.key, gs.preview_hunk, with_desc("preview_hunk"))
      us.set_keynomap({ "n", "v" }, kmps.stage_hunk.key, gs.stage_hunk, with_desc("stage_hunk"))
      us.set_keynomap({ "n", "v" }, kmps.reset_hunk.key, gs.reset_hunk, with_desc("reset_hunk"))
      us.set_keynomap("n", kmps.toggle_blame.key, gs.toggle_current_line_blame, with_desc("toggle_blame"))
      us.set_keynomap("n", kmps.toggle_deleted.key, gs.toggle_deleted, with_desc("toggle_deleted"))
      us.set_keynomap("n", kmps.toggle_word_diff.key, gs.toggle_word_diff, with_desc("toggle_word_diff"))
      us.set_keynomap("n", kmps.blame_line.key, blame_line_full, with_desc("blame_line"))

      us.set_keynomap("n", kmps.stage_buffer.key, gs.stage_buffer, with_desc("stage_buffer"))
      us.set_keynomap("n", kmps.reset_buffer.key, gs.reset_buffer, with_desc("reset_buffer"))

      us.set_keynomap("n", kmps.qflist_hunks.key, qflist_hunks, with_desc("qflist_hunks"))
      us.set_keynomap("n", kmps.diffthis.key, gs.diffthis, with_desc("diffthis"))
      us.set_keynomap("n", kmps.diffthis_PREV.key, diffthis_PREV, with_desc("diffthis_PREV"))
      -- Text object
      us.set_keynomap({ "o", "x" }, kmps.select_hunk.key, ':<C-U>Gitsigns select_hunk<CR>', with_desc("select_hunk"))
      -- Navigation
      us.set_keynomap("n", kmps.prev_hunk.key, function()
        vim.schedule(function() gs.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = kmps:desc("prev_hunk") })

      us.set_keynomap("n", kmps.next_hunk.key, function()
        vim.schedule(function() gs.next_hunk() end)
        return '<Ignore>'
      end, { expr = true, buffer = bufnr, desc = kmps:desc("next_hunk") })

      -- NOTE: maybe later base change will be useful and i will add them
    end
  }
end
