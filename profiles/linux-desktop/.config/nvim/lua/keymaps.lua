local augroups = {}

local config = require("config")
local utils = require("utils")

local function nosilent(desc)
  return { silent = false, desc = desc }
end

-- TABS
if config.profile.contains("default", "neovide") then
  utils.set_keynomap("n", "[t", "<cmd>tabprev<cr>", "[nvim] Open previous tab")
  utils.set_keynomap("n", "]t", "<cmd>tabnext<cr>", "[nvim] Open next tab")
  utils.set_keynomap("n", "<leader>td", "<cmd>tabclose<cr>", "[nvim] Close tab")
  utils.set_keynomap("n", "<leader>tn", "<cmd>tabedit %<cr>", "[nvim] Edit current buffer in new tab")
  utils.set_keynomap("n", "<leader>to", "<cmd>tabonly<cr>", "[nvim] Close all tabs except current")

  utils.set_keynomap("n", "<leader>tm", function()
    vim.ui.input({ prompt = "Enter new tab index: ", },
      function(str)
        if str then
          -- local tabs = #vim.api.nvim_list_tabpages()
          local index = tonumber(str)
          if index == 1 then
            index = index - 1
          end
          vim.cmd("tabmove " .. tostring(index))
        end
      end
    )
  end, { silent = false, desc = "[nvim] Move current tab to N" })

  utils.set_keynomap("n", "<leader>1", "1gt", "[nvim] Open Tab 1")
  utils.set_keynomap("n", "<leader>2", "2gt", "[nvim] Open Tab 2")
  utils.set_keynomap("n", "<leader>3", "3gt", "[nvim] Open Tab 3")
  utils.set_keynomap("n", "<leader>4", "4gt", "[nvim] Open Tab 4")
  utils.set_keynomap("n", "<leader>5", "5gt", "[nvim] Open Tab 5")
  utils.set_keynomap("n", "<leader>6", "6gt", "[nvim] Open Tab 6")
  utils.set_keynomap("n", "<leader>7", "7gt", "[nvim] Open Tab 7")
  utils.set_keynomap("n", "<leader>8", "8gt", "[nvim] Open Tab 8")
  utils.set_keynomap("n", "<leader>9", "9gt", "[nvim] Open Tab 9")
  utils.set_keynomap("n", "<leader>0", ":tablast<cr>", "[nvim] Open Tab Last")
end

-- WINDOWS
if config.profile.contains("default", "neovide") then
  utils.set_keynomap("n", "<C-k>", "<C-w>k", "[nvim] Move window up")
  utils.set_keynomap("n", "<C-l>", "<C-w>l", "[nvim] Move window right")
  utils.set_keynomap("n", "<C-j>", "<C-w>j", "[nvim] Move window down")
  utils.set_keynomap("n", "<C-h>", "<C-w>h", "[nvim] Move window left")
  utils.set_keynomap("n", "<C-s>", "<C-w><C-p>", "[nvim] Move window previous")

  utils.set_keynomap("n", "<C-Up>", "<cmd>resize +1<cr>", "[nvim] Increase window height")
  utils.set_keynomap("n", "<C-S-k>", "<cmd>resize +1<cr>", "[nvim] Increase window height")
  utils.set_keynomap("n", "<C-Down>", "<cmd>resize -1<cr>", "[nvim] Decrease window height")
  utils.set_keynomap("n", "<C-S-j>", "<cmd>resize -1<cr>", "[nvim] Decrease window height")

  utils.set_keynomap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "[nvim] Increase window width")
  utils.set_keynomap("n", "<C-S-l>", "<cmd>vertical resize +2<cr>", "[nvim] Increase window width")
  utils.set_keynomap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "[nvim] Decrease window width")
  utils.set_keynomap("n", "<C-S-h>", "<cmd>vertical resize -2<cr>", "[nvim] Decrease window width")

  utils.set_keynomap("n", "<leader>y", "<cmd>split<cr>", "[nvim] Horizontal split")
  utils.set_keynomap("n", "<leader>u", "<cmd>vsplit<cr>", "[nvim] Vertical split")
end

-- BUFFERS
utils.set_keynomap("n", "<S-l>", "<cmd>bnext<cr>", "[nvim] Open next buffer")
utils.set_keynomap("n", "<S-h>", "<cmd>bprevious<cr>", "[nvim] Open previous buffer")

-- TERMINAL
if config.profile.contains("default", "neovide") then
  augroups.map_terminal = {
    {
      event = { "TermOpen" },
      pattern = { "term://*", '\\[dap-terminal\\]*' },
      command = function()
        local opts = { buffer = 0, silent = false }
        utils.set_keynomap('t', '<esc>', [[<C-\><C-n>]], opts)
        utils.set_keynomap('t', '<C-[>', [[<C-\><C-n>]], opts)
        utils.set_keynomap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        utils.set_keynomap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        utils.set_keynomap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        utils.set_keynomap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end
    }
  }
end

-- WRITE
utils.set_keynomap("n", "<leader>w", "<cmd>wall<cr>", "[nvim] Write all")
utils.set_keynomap("i", "<C-s>", "<cmd>wall<cr>", "[nvim] Write all")

-- CLOSE
if config.profile.contains("default", "neovide", "scrollback") then
  utils.set_keynomap("n", "<leader>q", "<cmd>q<cr>", "[nvim] Close window")
  utils.set_keynomap("n", "<leader>Q", "<cmd>qall<cr>", "[nvim] Close")
end

augroups.map_close = {
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
      "vim",
    },
    command = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end
  }
}


-- LINE MOVEMENT
utils.set_keynomap("n", '<a-k>', '<cmd>move-2<CR>==', "[nvim] Move line up")
utils.set_keynomap("n", '<a-j>', '<cmd>move+<CR>==', "[nvim] Move line down")
utils.set_keynomap("x", '<a-k>', ":move-2<CR>='[gv", "[nvim] Move line up")
utils.set_keynomap("x", '<a-j>', ":move'>+<CR>='[gv", "[nvim] Move line down")
utils.set_keynomap("v", "<", "<gv", "[nvim] Shift leftwards")
utils.set_keynomap("v", ">", ">gv", "[nvim] Shift rightwards")

-- SEARCH
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

augroups.map_nohl = {
  {
    event = "FileType",
    pattern = "*",
    command = function()
      if not vim.tbl_contains({
          "color-picker",
          "TelescopePrompt",
          "DressingInput",
          "Trouble",
          "snacks_input",
        }, vim.bo.filetype) then
        utils.set_keynomap("n", "<esc>", ":nohl<cr>", { buffer = 0 })
      end
    end
  }
}

-- makes * and # work in visual mode too
vim.cmd([[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction
  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]])

-- EMACS
utils.set_keynomap("c", "<C-a>", "<Home>", nosilent("[nvim] Move start of line"))
utils.set_keynomap("c", "<C-e>", "<End>", nosilent("[nvim] End of line"))
utils.set_keynomap("c", "<C-b>", "<Left>", nosilent("[nvim] Move back one char"))
utils.set_keynomap("c", "<C-f>", "<Right>", nosilent("[nvim] Move forward one char"))
utils.set_keynomap("c", "<C-d>", "<Del>", nosilent("[nvim] Delete char"))
utils.set_keynomap("c", "<A-b>", "<S-Left>", nosilent("[nvim] Move word left"))
utils.set_keynomap("c", "<A-f>", "<S-Right>", nosilent("[nvim] Move word right"))
utils.set_keynomap("c", "<C-k>", "<Up>", nosilent("[nvim] History scroll up"))

-- OTHER
utils.set_keynomap("n", "<localleader>a", "<cmd>ascii<cr>", "[nvim] Print ASCII character")
utils.set_keynomap("n", "gx", ":silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<cr>",
  "[nvim] Open link in system browser")

utils.set_keynomap('n', '<localleader>hc', function()
  print(vim.inspect(vim.treesitter.get_captures_at_cursor(0)))
end, "[treesitter] Get captures at cursor")

utils.set_keynomap('n', '<localleader>hL', function()
  local enabled = not vim.wo.list
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    vim.wo[win].list = enabled
  end
  vim.opt.list = enabled
end, "[nvim] Toggle listchars global")

utils.set_keynomap('n', '<localleader>hl', function()
  vim.wo.list = not vim.wo.list
end, "[nvim] Toggle listchars buffer")

utils.set_keynomap('n', '<localleader>hi', function()
  local line = vim.fn.line('.')
  local col = vim.fn.col('.')
  local stack = vim.fn.synstack(line, col)
  vim.inspect(stack)
  for _, id in ipairs(stack) do
    local name = vim.fn.synIDattr(id, 'name')
    local trans = vim.fn.synIDattr(vim.fn.synIDtrans(id), 'name')
    print(name .. ' -> ' .. trans)
  end
end, "[nvim] Inspect syntax highlighting")

return {
  augroups = augroups,
}
