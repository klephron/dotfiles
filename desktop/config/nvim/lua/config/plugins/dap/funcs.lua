local M = {}

local dap = require("dap")
local widgets = require("dap.ui.widgets")
local dap_ttft = p_require("dap.langs").ttft

local launchjs_paths = {
  '/launch.json',
  '/.vscode/launch.json',
}

local function dap_notify(msg, level)
  vim.notify(msg, level, { title = "Dap" })
end

local is_launchjs_ok = nil

---Process launchjs.json
---@param opts table|nil
---ask nil|boolean
---@return boolean
local function process_launchjs(opts)
  opts = opts or {}
  local path = nil
  for _, ipath in ipairs(launchjs_paths) do
    local resolved_path = vim.fn.getcwd() .. ipath
    if vim.loop.fs_stat(resolved_path) then
      path = resolved_path
      break
    end
  end
  if path == nil then
    if opts.ask then
      path = vim.fn.input('Path to launch.json: ', vim.fn.getcwd() .. '/', 'file')
      if not vim.loop.fs_stat(path) then
        dap_notify("Not resolved path: " .. path .. "\nReturning...", vim.log.levels.ERROR)
        return false
      end
    else
      return false
    end
  end

  local ok, result = pcall(require("dap.ext.vscode").load_launchjs, path, dap_ttft)
  if ok then
    dap_notify("Resolved launch.json path: " .. path, vim.log.levels.INFO)
  else
    dap_notify(result, vim.log.levels.ERROR)
  end
  return ok
end

function M.continue()
  if is_launchjs_ok == nil then
    is_launchjs_ok = process_launchjs({ ask = false })
  end
  return dap.continue()
end

function M.run_last()
  return dap.run_last()
end

function M.process_launchjs_ask()
  return process_launchjs({ ask = true })
end

function M.terminate()
  return dap.terminate()
end

function M.disconnect()
  return dap.disconnect()
end

function M.close()
  return dap.close()
end

function M.set_breakpoint_cond()
  return dap.set_breakpoint(vim.fn.input("[Condition]: "))
end

function M.set_breakpoint_log()
  return dap.set_breakpoint(nil, nil, vim.fn.input('[Log message]: '))
end

function M.toggle_breakpoint()
  return dap.toggle_breakpoint()
end

function M.clear_breakpoints()
  return dap.clear_breakpoints()
end

function M.step_over()
  return dap.step_over()
end

function M.step_into()
  return dap.step_into()
end

function M.step_out()
  return dap.step_out()
end

function M.step_back()
  return dap.step_back()
end

function M.reverse_continue()
  return dap.reverse_continue()
end

function M.up()
  return dap.up()
end

function M.down()
  return dap.down()
end

function M.run_to_cursor()
  return dap.run_to_cursor()
end

function M.repl_toggle()
  -- local height = vim.fn.winwidth(vim.fn.win_getid())
  local h = vim.api.nvim_win_get_height(0)
  return dap.repl.toggle({ height = math.floor(h * 0.3) }, "belowright split")
end

function M.hover()
  return widgets.hover()
end

function M.dapui_toggle()
  return require("dapui").toggle({ reset = true })
end

return M
