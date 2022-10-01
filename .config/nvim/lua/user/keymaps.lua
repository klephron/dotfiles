local fn = vim.fn
local which_key_ok, which_key = safe_require("which-key")

local M = {}
----------------------------------------------------------------------------//
-- Keymaps
-----------------------------------------------------------------------------//
-- prototype: KeymapDictionary
local KeymapDictionary = {}

---KeymapDictionary constructor
---@param table table
---@param prefix string|nil
---@return object
function KeymapDictionary:new(table, prefix)
  table = table or {}
  setmetatable(table, self)
  self.__index = self
  -- process input data
  for _, v in pairs(table) do
    v.key = v[1]
    v[1] = nil
    if v[2] then
      v.desc = v[2]
      v[2] = nil
    end
  end
  table.__prefix = prefix
  return table
end

function KeymapDictionary:key(element)
  return self[element].key
end

function KeymapDictionary:desc(element)
  local desc = self[element].desc
  if desc == nil then return "" end
  if self.__prefix then
    return self.__prefix .. ": " .. desc
  else
    return desc
  end
end

function KeymapDictionary:list_keys()
  local keys = {}
  for _, v in pairs(self) do
    table.insert(keys, v.key)
  end
  return keys
end

function KeymapDictionary:add_key(name, key, desc)
  self[name] = {}
  self[name].key = key
  self[name].desc = desc
end

function KeymapDictionary:remove_key(name)
  self[name] = nil
end

-- END

M.lsp = KeymapDictionary:new({
  -- gf (override file open), gl, go, gp, gq, gs, gy, gz
  g_definition = { "gd" },
  g_declaration = { "gD" },
  g_hover = { "gl" },
  g_implementation = { "gm" },
  g_references = { "gr" },
  g_open_float = { "gh" },
  g_open_float_cursor = { "gH" },

  signature_help_i = { "<C-k>", "Signature help" },

  goto_prev = { "[d", "Goto previous" },
  goto_next = { "]d", "Goto next" },

  definition = { "<leader>kd", "Definition" },
  declaration = { "<leader>ke", "Declaration" },
  hover = { "<leader>kl", "Hover" },
  implementation = { "<leader>ki", "Implementation" },
  signature_help_n = { "<leader>ks", "Signature help" },
  rename = { "<leader>kn", "Rename" },
  references = { "<leader>kr", "References" },
  code_action = { "<leader>ka", "Code action" },
  open_float = { "<leader>kh", "Open float" },
  open_float_cursor = { "<leader>kH", "Open float under cursor" },
  codelens = { "<leader>km", "Run codelens" },
  type_definition = { "<leader>kp", "Type definition" },

  format = { "<leader>m", "Format file" },
}, "lsp")

M.dap = KeymapDictionary:new({
  continue = { "<leader>dc", "Continue" },
  run_last = { "<leader>dp", "Run last" },
  process_launchjs = { "<leader>dl", "Process launchjs" },
  terminate = { "<leader>dt", "Terminate debug session" },
  disconnect = { "<leader>db", "Disconnect from debuggee and terminate adapter" },
  -- close = { "<leader>dq", "Close" },
  set_breakpoint_cond = { "<leader>de", "Set conditional break" },
  set_breakpoint_log = { "<leader>dm", "Set log break" },
  toggle_breakpoint = { "<leader>ds", "Toggle breakpoint" },
  clear_breakpoints = { "<leader>dz", "Clear breakpoints" },
  step_over = { "<leader>dn", "Step over" },
  step_into = { "<leader>di", "Step into" },
  step_out = { "<leader>do", "Step out" },
  step_back = { "<leader>dd", "Step back" },
  -- pause = {"<leader>dp", "Pause"},
  reverse_continue = { "<leader>dr", "Reverse continue" },
  up = { "<leader>d[", "Up" },
  down = { "<leader>d]", "Down" },
  run_to_cursor = { "<leader>da", "Run to cursor" },
  repl_toggle = { "<leader>dg", "Toggle REPL" },
  -- repl_session = { "<leader>dx", "REPL session" },
  hover = { "<leader>dh", "Hover" },
  dapui_toggle = { "<leader>dy", "Toggle dapui" },
}, "dap")

M.dap_hydra = KeymapDictionary:new({
  body = { "<leader>D", },
  quit = { "Z", "Quit" },
  continue = { "C", M.dap.continue.desc },
  run_last = { "<C-p>", M.dap.run_last.desc },
  process_launchjs = { "<C-n>", M.dap.process_launchjs.desc },
  terminate = { "<C-t>", M.dap.terminate.desc },
  disconnect = { "<C-b>", M.dap.disconnect.desc },
  -- close = { "Q", M.dap.close.desc },
  set_breakpoint_cond = { "E", M.dap.set_breakpoint_cond.desc },
  set_breakpoint_log = { "M", M.dap.set_breakpoint_log.desc },
  toggle_breakpoint = { "S", M.dap.toggle_breakpoint.desc },
  clear_breakpoints = { "z", M.dap.clear_breakpoints.desc },
  step_over = { "N", M.dap.step_over.desc },
  step_into = { "I", M.dap.step_into.desc },
  step_out = { "O", M.dap.step_out.desc },
  step_back = { "D", M.dap.step_back.desc },
  reverse_continue = { "R", M.dap.reverse_continue.desc },
  up = { "d[", M.dap.up.desc },
  down = { "d]", M.dap.down.desc },
  run_to_cursor = { "A", M.dap.run_to_cursor.desc },
  repl_toggle = { "G", M.dap.repl_toggle.desc },
  -- repl_session = { "X", M.dap.repl_session.desc },
  hover = { "m", M.dap.hover.desc },
  dapui_toggle = { "Y", M.dap.dapui_toggle.desc },
}, "dap-hydra")


M.neorg = KeymapDictionary:new({
  gtd_capture = { "<leader>nc", "GTD capture" },
  gtd_views = { "<leader>nv", "GTD views" },
  kanban_toggle = { "<leader>nk", "Kanban toggle" },
  switch_workspace = { "<leader>ns", "Switch workspace" },
  neorg_start = { "<leader>nn", "Neorg start (execute once)" },
  journal = { "<leader>nj", "Journal" },
}, "neorg")

M.git = KeymapDictionary:new({
  undo_stage_hunk = { "<leader>gu", "Undo stage" },
  preview_hunk = { "<leader>gp", "Preview current hunk" },
  stage_hunk = { "<leader>gs", "Stage current hunk" },
  reset_hunk = { "<leader>gr", "Reset current hunk" },
  toggle_blame = { "<leader>gb", "Toggle current line blame" },
  toggle_deleted = { "<leader>gd", "Show deleted lines" },
  toggle_word_diff = { "<leader>gw", "Toggle word diff" },
  blame_line = { "<leader>gl", "Blame line" },
  qflist_hunks = { "<leader>gh", "QFlist hunks" },

  stage_buffer = { "<localleader>gw", "Stage entire buffer" },
  reset_buffer = { "<localleader>gr", "Reset entire buffer" },
  diffview_open = { "<localleader>gd", "Open diffview" },
  diffview_history = { "<localleader>gh", "Open file history" },
  diffview_history_v = { "gh", "Open range file history" },

  select_hunk = { "ig", "Select hunk (text object)" },
  prev_hunk = { "[g", "Go to previous hunk" },
  next_hunk = { "]g", "Go to next hunk" },
}, "git")

M.ctrl_i = KeymapDictionary:new({
  colorpicker = { "<c-c>", "color: Pick color in insert" },
})

---------------------------------------------------------------------------//
--TERMINAL BUFFER LOCAL
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
-- SPECIAL KEYMAPS
---------------------------------------------------------------------------//
-- Nohl keymap (disabled in special buffers)
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
        us.set_keynomap("n", "<Esc><Esc>", ":nohl<cr>", { buffer = 0 })
      end
    end
  }
})

us.set_keynomap("n", "<c-k>", "<c-w>k", "window: Move up")
us.set_keynomap("n", "<c-l>", "<c-w>l", "window: Move right")
us.set_keynomap("n", "<c-j>", "<c-w>j", "window: Move down")
us.set_keynomap("n", "<c-h>", "<c-w>h", "window: Move left")

us.set_keynomap("n", "<C-Up>", "<cmd>resize +1<cr>", "window: Increase height")
us.set_keynomap("n", "<C-S-k>", "<cmd>resize +1<cr>", "window: Increase height")
us.set_keynomap("n", "<C-Down>", "<cmd>resize -1<cr>", "window: Decrease height")
us.set_keynomap("n", "<C-S-j>", "<cmd>resize -1<cr>", "window: Decrease height")

us.set_keynomap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "window: Increase width")
us.set_keynomap("n", "<C-S-l>", "<cmd>vertical resize +2<cr>", "window: Increase width")
us.set_keynomap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "window: Decrease width")
us.set_keynomap("n", "<C-S-h>", "<cmd>vertical resize -2<cr>", "window: Decrease width")

us.set_keynomap("n", "<S-l>", "<cmd>bnext<cr>", "buffer: Move next")
us.set_keynomap("n", "<S-h>", "<cmd>bprevious<cr>", "buffer: Move previous")

us.set_keynomap("n", "gx", ":silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<cr>",
  "goto: Open link in system browser")

us.set_keynomap("n", "[t", "<cmd>tabprev<cr>", "tab: Open previous")
us.set_keynomap("n", "]t", "<cmd>tabnext<cr>", "tab: Open next")

-- Leader mappings
us.set_keynomap("n", "<leader>tm", function()
  vim.cmd("tabmove " .. tostring(tonumber(fn.input("")) - 1))
end, { silent = false, desc = "tab: Move current after N - 1" })

us.set_keynomap("n", "<leader>q", "<cmd>q<cr>", "window: Close")
us.set_keynomap("n", "<leader>Q", "<cmd>qall<cr>", "window: Close all")
us.set_keynomap("n", "<leader>w", "<cmd>write<cr>", "nvim: Write")
us.set_keynomap("n", "<leader>W", "<cmd>wall<cr>", "nvim: Write all")

us.set_keynomap("n", "<leader>td", "<cmd>tabclose<cr>", "tab: Close")
us.set_keynomap("n", "<leader>tn", "<cmd>tabedit %<cr>", "tab: Edit current buffer")
us.set_keynomap("n", "<leader>to", "<cmd>tabonly<cr>", "tab: Close all except current")

us.set_keynomap("n", "<leader>f", "<cmd>lua us.delete_current_buffer()<cr>", "buffer: Delete current")
us.set_keynomap("n", "<leader>'", "<cmd>marks<cr>", "mark: Show")
us.set_keynomap("n", '<leader>"', "<cmd>reg<cr>", "register: Show")

-- Visual-select mode
us.set_keynomap("v", "<", "<gv", "Shift leftwards")
us.set_keynomap("v", ">", ">gv", "Shift rightwards")
us.set_keynomap("v", "p", '"_dP', "Replace selected from buffer")
us.set_keynomap("v", "<A-n>", ":move '>+1<cr>gv", "Swap selected with next line")
us.set_keynomap("v", "<A-p>", ":move '<-2<cr>gv", "Swap selected with previous line")

-- Terminal
-- local function termcodes(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
--

-- Command
local function with_nosilent(desc)
  return { silent = false, desc = desc }
end

-- emacs like keybinds
us.set_keynomap("c", "<A-b>", "<S-Left>", with_nosilent("Cursor move word left"))
us.set_keynomap("c", "<A-f>", "<S-Right>", with_nosilent("Cursor move word right"))
us.set_keynomap("c", "<C-b>", "<Left>", with_nosilent("Cursor move left"))
us.set_keynomap("c", "<C-f>", "<Right>", with_nosilent("Cursor move right"))
us.set_keynomap("c", "<C-j>", "<Down>", with_nosilent("History scroll down"))
us.set_keynomap("c", "<C-k>", "<Up>", with_nosilent("History scroll up"))

---------------------------------------------------------------------------//
-- WHICH-KEY keymaps documentation + plugin mappings
---------------------------------------------------------------------------//
if not which_key_ok then
  vim.notify("which-key is not required, some keymaps are not installed",
    vim.log.levels.ERROR, { title = "Config" })
  return M
end

which_key.register({
  ["d"] = { name = "dap" },
  ["k"] = { name = "lsp" },
  ["n"] = { name = "neorg" },
  ["g"] = { name = "git" },
}, { prefix = "<leader>", mode = "n" })

which_key.register({
  ["n"] = { name = "neorg" },
  ["g"] = { name = "git" },
}, { prefix = "<localleader>", mode = "n" })

which_key.register({
  g = {
    name = "special",
    a = "Print asci character",
  },
}, { mode = "n" })

which_key.register({
  ["<C-w>"] = {
    name = "window",
    s = "Split horizontally",
    v = "Split vertically",
    n = "Split horizontally and edit [New File]",
    ["^"] = "Split horizontally and edit the alternative file",
    c = "Close",
    o = "Close all except current one",
    t = "Go to top-left",
    b = "Go to bottom-right",
    p = "Go to previous",
    P = "Go to preview",
    r = "Rotate downwards/rightwards",
    R = "Rotate upwards/leftwards",
    K = "Move far Top",
    J = "Move far Bottom",
    H = "Move far Left",
    L = "Move far Right",
  }
}, { mode = "n" })


which_key.register({
  -- q, Q, w, W
  e = { "<cmd>NvimTreeToggle<cr>", "nvim-tree: Toggle" },
  E = { "<cmd>NvimTreeFocus<cr>", "nvim-tree: Focus" },
  r = { "<cmd>Telescope oldfiles<cr>", "telescope: Recent files" },
  t = { name = "tabs", },
  Y = { "<cmd>RestoreSession<cr>", "session: Try restore" },
  y = { "<cmd>lua require('session-lens').search_session()<cr>", "telescope: Find session" },
  u = { "<cmd>Trouble workspace_diagnostics<CR>", "trouble: Workspace diagnostics" },
  i = { "<cmd>Trouble document_diagnostics<CR>", "trouble: Document diagnostics" },
  p = { "<cmd>ProjectRoot<cr>", "project: Update root" },
  P = { "<cmd>Telescope projects<cr>", "telescope: Projects" },
  A = { "<cmd>AerialToggle!<cr>", "aerial: Toggle" },
  a = { "<cmd>AerialToggle<cr>", "aerial: Toggle focus" },
  s = {
    "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>",
    "telescope: Find files"
  },
  -- f
  j = {
    name = "toggleterm",
    t = { "<cmd>ToggleTerm<cr>", "toggleterm: Toggle" },
    a = { "<cmd>ToggleTermToggleAll<cr>", "toggleterm: Toggle all" },
    l = { '<cmd>lua vim.env.NVIM_CWD=vim.fn.getcwd(); vim.cmd("UsToggleTermLazygit")<cr>', "toggleterm: Lazygit" },
    h = { "<cmd>UsToggleTermHtop<cr>", "toggleterm: Htop" },
  },
  l = { "<cmd>Telescope live_grep<cr>", "telescope: Search pattern" },
  x = {
    name = "watch",
    n = { "<cmd>WatchCreate<cr>", "watch: Create" },
    d = { "<cmd>WatchDelete<cr>", "watch: Delete" },
  },
  c = { "<cmd>PickColor<cr>", "color: Pick color" },
  b = { "<cmd>Telescope buffers<cr>", "telescope: Buffers" },
  -- ', "
  [";"] = { "<cmd>lua require('luasnip.loaders.from_lua').edit_snippet_files()<cr>", "luasnip: Edit snippets" },
  ["?"] = { "<cmd>WhichKey<cr>", "whichkey: Open" },
}, { mode = "n", prefix = "<leader>" })

which_key.register({
  ['[a'] = { "<cmd>execute v:count . 'AerialPrev'<cr>", "aerial: Jump N previous symbols" },
  [']a'] = { "<cmd>execute v:count . 'AerialNext'<cr>", "aerial: Jump N next symbols" },
  ['[A'] = { "<cmd>execute v:count . 'AerialPrevUp'<cr>", "aerial: Jump N levels up, moving backwards" },
  [']A'] = { "<cmd>execute v:count . 'AerialNextUp'<cr>", "aerial: Jump N levels up, moving forwards" },
}, { mode = "n" })

which_key.register({
  name = "packer",
  p = {
    ["s"] = { "<cmd>PackerSync<cr>", "packer: Sync" },
    ["c"] = { "<cmd>LocalPackerCompile<cr>", "packer: Compile" },
    ["i"] = { "<cmd>PackerStatus<cr>", "packer: Status info"}
  }
}, { mode = "n", prefix = "<localleader>" })
return M
