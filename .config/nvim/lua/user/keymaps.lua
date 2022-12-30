local wk_ok, wk = pcall(require, "which-key")
---------------------------------------------------------------------------//
-- TERMINAL BUFFER LOCAL
---------------------------------------------------------------------------//
function _G._set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-[>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua _set_terminal_keymaps()')

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

-- Window movements
us.set_keynomap("n", "<c-k>", "<c-w>k", "win: Move up")
us.set_keynomap("n", "<c-l>", "<c-w>l", "win: Move right")
us.set_keynomap("n", "<c-j>", "<c-w>j", "win: Move down")
us.set_keynomap("n", "<c-h>", "<c-w>h", "win: Move left")

-- Window resize
us.set_keynomap("n", "<C-Up>", "<cmd>resize +1<cr>", "win: Increase height")
us.set_keynomap("n", "<C-S-k>", "<cmd>resize +1<cr>", "win: Increase height")
us.set_keynomap("n", "<C-Down>", "<cmd>resize -1<cr>", "win: Decrease height")
us.set_keynomap("n", "<C-S-j>", "<cmd>resize -1<cr>", "win: Decrease height")

us.set_keynomap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "win: Increase width")
us.set_keynomap("n", "<C-S-l>", "<cmd>vertical resize +2<cr>", "win: Increase width")
us.set_keynomap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "win: Decrease width")
us.set_keynomap("n", "<C-S-h>", "<cmd>vertical resize -2<cr>", "win: Decrease width")

-- Buffer move
us.set_keynomap("n", "<S-l>", "<cmd>bnext<cr>", "buf: Move next")
us.set_keynomap("n", "<S-h>", "<cmd>bprevious<cr>", "buf: Move previous")

-- Open in browser
us.set_keynomap("n", "gx", ":silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<cr>",
  "goto: Open link in system browser")

-- Tabs
us.set_keynomap("n", "[t", "<cmd>tabprev<cr>", "tab: Open previous")
us.set_keynomap("n", "]t", "<cmd>tabnext<cr>", "tab: Open next")
us.set_keynomap("n", "<leader>td", "<cmd>tabclose<cr>", "tab: Close")
us.set_keynomap("n", "<leader>tn", "<cmd>tabedit %<cr>", "tab: Edit current buffer")
us.set_keynomap("n", "<leader>to", "<cmd>tabonly<cr>", "tab: Close all except current")

-- Move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Clear search
local mapnohl_disabled = {
  "color-picker",
  "TelescopePrompt",
  "DressingInput",
}

us.augroup("_map_hohl", {
  {
    event = "FileType",
    pattern = "*",
    command = function()
      if not vim.tbl_contains(mapnohl_disabled, vim.bo.filetype) then
        us.set_keynomap("n", "<esc>", ":nohl<cr>", { buffer = 0 })
      end
    end
  }
})

-- Quit
us.set_keynomap("n", "<leader>q", "<cmd>q<cr>", "win: Close")
us.set_keynomap("n", "<leader>Q", "<cmd>qall<cr>", "win: Close all")

-- Write
us.set_keynomap("n", "<leader>w", "<cmd>silent wa<cr>", "Write all")

-- Splits
us.set_keynomap("n", "<leader>y", "<cmd>split<cr>", "win: Horizontal split")
us.set_keynomap("n", "<leader>u", "<cmd>vsplit<cr>", "win: Write all")

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
us.set_keynomap("c", "<A-b>", "<S-Left>", with_nosilent("Move word left"))
us.set_keynomap("c", "<A-f>", "<S-Right>", with_nosilent("Move word right"))
us.set_keynomap("c", "<C-b>", "<Left>", with_nosilent("Move char left"))
us.set_keynomap("c", "<C-f>", "<Right>", with_nosilent("Move char right"))
us.set_keynomap("c", "<C-j>", "<Down>", with_nosilent("History scroll down"))
us.set_keynomap("c", "<C-k>", "<Up>", with_nosilent("History scroll up"))


-- Don't load which-key mappings if this plugin is not loaded
if not wk_ok then return end

-- Leader mappings
local leader = {
  f = { "<cmd>Bdelete<cr>", "buf: Delete current" },
  t = { name = "tabs" },
}

wk.register({ g = { name = "+goto" } })
wk.register(leader, { prefix = "<leader>" })
