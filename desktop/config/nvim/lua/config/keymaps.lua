local wk_ok, wk = pcall(require, "which-key")
local funcs = require("utils.funcs")
---------------------------------------------------------------------------//
-- TERMINAL BUFFER LOCAL
---------------------------------------------------------------------------//
funcs.augroup("local_keymap_terminal", {
  {
    event = { "TermOpen" },
    pattern = { "term://*", '\\[dap-terminal\\]*' },
    command = function()
      local opts = { buffer = 0, silent = false }
      funcs.set_keynomap('t', '<esc>', [[<C-\><C-n>]], opts)
      funcs.set_keynomap('t', '<C-[>', [[<C-\><C-n>]], opts)
      funcs.set_keynomap('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      funcs.set_keynomap('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      funcs.set_keynomap('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      funcs.set_keynomap('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    end
  }
})
---------------------------------------------------------------------------//
-- KEYMAPS
---------------------------------------------------------------------------//
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

if not config.is_vscode and not config.is_firenvim then
  -- Window movements
  funcs.set_keynomap("n", "<C-k>", "<C-w>k", "win: Move up")
  funcs.set_keynomap("n", "<C-l>", "<C-w>l", "win: Move right")
  funcs.set_keynomap("n", "<C-j>", "<C-w>j", "win: Move down")
  funcs.set_keynomap("n", "<C-h>", "<C-w>h", "win: Move left")
  funcs.set_keynomap("n", "<C-c>", "<C-w><C-p>", "win: Move previous")

  -- Window resize
  funcs.set_keynomap("n", "<C-Up>", "<cmd>resize +1<cr>", "win: Increase height")
  funcs.set_keynomap("n", "<C-S-k>", "<cmd>resize +1<cr>", "win: Increase height")
  funcs.set_keynomap("n", "<C-Down>", "<cmd>resize -1<cr>", "win: Decrease height")
  funcs.set_keynomap("n", "<C-S-j>", "<cmd>resize -1<cr>", "win: Decrease height")

  funcs.set_keynomap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "win: Increase width")
  funcs.set_keynomap("n", "<C-S-l>", "<cmd>vertical resize +2<cr>", "win: Increase width")
  funcs.set_keynomap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "win: Decrease width")
  funcs.set_keynomap("n", "<C-S-h>", "<cmd>vertical resize -2<cr>", "win: Decrease width")
end

-- Buffer move
funcs.set_keynomap("n", "<S-l>", "<cmd>bnext<cr>", "buf: Move next")
funcs.set_keynomap("n", "<S-h>", "<cmd>bprevious<cr>", "buf: Move previous")

-- Open in browser
funcs.set_keynomap("n", "gx", ":silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<cr>",
  "goto: Open link in system browser")

if not config.is_vscode and not config.is_firenvim then
  -- Tabs
  funcs.set_keynomap("n", "[t", "<cmd>tabprev<cr>", "tab: Open previous")
  funcs.set_keynomap("n", "]t", "<cmd>tabnext<cr>", "tab: Open next")
  funcs.set_keynomap("n", "<leader>td", "<cmd>tabclose<cr>", "tab: Close")
  funcs.set_keynomap("n", "<leader>tn", "<cmd>tabedit %<cr>", "tab: Edit current buffer")
  funcs.set_keynomap("n", "<leader>to", "<cmd>tabonly<cr>", "tab: Close all except current")

  funcs.set_keynomap("n", "<leader>tm", function()
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
  end, { silent = false, desc = "tab: Move current to N" })

  -- Bind leader keys to specific tabs
  funcs.set_keynomap("n", "<leader>1", "1gt")
  funcs.set_keynomap("n", "<leader>2", "2gt")
  funcs.set_keynomap("n", "<leader>3", "3gt")
  funcs.set_keynomap("n", "<leader>4", "4gt")
  funcs.set_keynomap("n", "<leader>5", "5gt")
  funcs.set_keynomap("n", "<leader>6", "6gt")
  funcs.set_keynomap("n", "<leader>7", "7gt")
  funcs.set_keynomap("n", "<leader>8", "8gt")
  funcs.set_keynomap("n", "<leader>9", "9gt")
  funcs.set_keynomap("n", "<leader>0", ":tablast<cr>")
end

-- Move Lines
funcs.set_keynomap("n", '<a-k>', '<cmd>move-2<CR>==')
funcs.set_keynomap("n", '<a-j>', '<cmd>move+<CR>==')
funcs.set_keynomap("x", '<a-k>', ":move-2<CR>='[gv")
funcs.set_keynomap("x", '<a-j>', ":move'>+<CR>='[gv")
funcs.set_keynomap("v", "<", "<gv", "Shift leftwards")
funcs.set_keynomap("v", ">", ">gv", "Shift rightwards")

-- Clear search
local mapnohl_disabled = {
  "color-picker",
  "TelescopePrompt",
  "DressingInput",
  "Trouble",
}

funcs.augroup("local_map_nohl", {
  {
    event = "FileType",
    pattern = "*",
    command = function()
      if not vim.tbl_contains(mapnohl_disabled, vim.bo.filetype) then
        funcs.set_keynomap("n", "<esc>", ":nohl<cr>", { buffer = 0 })
      end
    end
  }
})

-- Write
funcs.set_keynomap("n", "<leader>w", "<cmd>wall<cr>", "Write all")
funcs.set_keynomap("i", "<C-s>", "<cmd>wall<cr>", "Write all")
funcs.set_keynomap("n", "<C-s>", "<cmd>wall<cr>", "Write all")

if not funcs.is_vscode then
  -- Quit
  funcs.set_keynomap("n", "<leader>q", "<cmd>q<cr>", "win: Close")
  funcs.set_keynomap("n", "<leader>Q", "<cmd>qall<cr>", "win: Close all")

  -- Splits
  funcs.set_keynomap("n", "<leader>y", "<cmd>split<cr>", "win: Horizontal split")
  funcs.set_keynomap("n", "<leader>u", "<cmd>vsplit<cr>", "win: Vertical split")
end

-- Other
funcs.set_keynomap("n", "<localleader>a", "<cmd>ascii<cr>", "print ASCII character")

-- Makes * and # work on visual mode too.
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

-- Emacs like keybinds in commandline
local function with_nosilent(desc)
  return { silent = false, desc = desc }
end

funcs.set_keynomap("c", "<A-b>", "<S-Left>", with_nosilent("Move word left"))
funcs.set_keynomap("c", "<A-f>", "<S-Right>", with_nosilent("Move word right"))
funcs.set_keynomap("c", "<C-b>", "<Left>", with_nosilent("Move char left"))
funcs.set_keynomap("c", "<C-f>", "<Right>", with_nosilent("Move char right"))
funcs.set_keynomap("c", "<C-j>", "<Down>", with_nosilent("History scroll down"))
funcs.set_keynomap("c", "<C-k>", "<Up>", with_nosilent("History scroll up"))


-- Don't load which-key mappings if this plugin is not loaded
if not wk_ok then
  vim.notify("which-key is not istalled. Ignoring some keymaps",
    vim.log.levels.WARN, { title = "keymaps" })
  return
end

-- Leader mappings
local leader = {
  { "<leader>t", group = "tabs" },
}

local localleader = {
  { "<localleader>w",  group = "watch" },
  { "<localleader>wc", "<cmd>WatchCreate<cr>", desc = "watch: create" },
  { "<localleader>wd", "<cmd>WatchDelete<cr>", desc = "watch: delete" },
  { "<localleader>wl", "<cmd>WatchList<cr>",   desc = "watch: list" },
  { "<localleader>z",  "<cmd>Lazy<cr>",        desc = "Lazy" },
}

wk.add(leader)
wk.add(localleader)
