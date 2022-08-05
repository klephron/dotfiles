local M = {}

function M.setup()
  local function test()
    require('which-key').register({
      a = {
        name = 'debug',
        a = { ":lua require('dap').continue()<cr>", ":lua require('dap').continue()<cr>" },
        c = { ":lua require('dap').run_last()<cr>", ":lua require('dap').run_last()<cr>" },
        d = { ":lua require('dap').launch()<cr>", ":lua require('dap').launch()<cr>" },
        e = { ":lua require('dap').terminate()<cr>", ":lua require('dap').terminate()<cr>" },
        f = { ":lua require('dap').disconnect()<cr>", ":lua require('dap').disconnect()<cr>" },
        A = { ":lua require('dap').close()<cr>", ":lua require('dap').close()<cr>" },
        C = { ":lua require('dap').set_breakpoint()<cr>", ":lua require('dap').set_breakpoint()<cr>" },
        D = { ":lua require('dap').toggle_breakpoint()<cr>", ":lua require('dap').toggle_breakpoint()<cr>" },
        -- E = { ":lua require('dap').list_breakpoints()<cr>", ":lua require('dap').list_breakpoints()<cr>" },
        F = { ":lua require('dap').clear_breakpoints()<cr>", ":lua require('dap').clear_breakpoints()<cr>" },
        -- q = { ":lua require('dap').set_exception_breakpoints()<cr>", ":lua require('dap').set_exception_breakpoints()<cr>" },
        w = { ":lua require('dap').step_over()<cr>", ":lua require('dap').stet_over()<cr>" },
        Q = { ":lua require('dap').step_into()<cr>", ":lua require('dap').step_into()<cr>" },
        W = { ":lua require('dap').step_out()<cr>", ":lua require('dap').step_out()<cr>" },
        z = { ":lua require('dap').step_back()<cr>", ":lua require('dap').step_back()<cr>" },
        x = { ":lua require('dap').pause()<cr>", ":lua require('dap').pause()<cr>" },
        Z = { ":lua require('dap').reverse_continue()<cr>", ":lua require('dap').reverse_continue()<cr>" },
        X = { ":lua require('dap').up()<cr>", ":lua require('dap').up()<cr>" },
        v = { ":lua require('dap').down()<cr>", ":lua require('dap').down()<cr>" },
        -- V = { ":lua require('dap').goto_()<cr>", ":lua require('dap').goto_()<cr>" },
        i = { ":lua require('dap').run_to_cursor()<cr>", ":lua require('dap').run_to_cursor()<cr>" },
        I = { ":lua require('dap').repl.toggle()<cr>", ":lua require('dap').repl.toggle()<cr>" },
        p = { ":lua require('dap').repl.session()<cr>", ":lua require('dap').repl.session()<cr>" },
        P = { ":lua require('dap.ui.widgets').hover()<cr>", ":lua require('dap.ui.widgets').hover()<cr>" },
        -- E = { ":lua require('dap.ui.widgets').()<cr>", ":lua require('dap.ui.widgets').hover()<cr>" },
        -- scopes, frames, expression, threads
      },
    }, {
      prefix = '<leader>', silent = false
    })
  end

  local dap = require("dap")

  local function continue() dap.continue() end

  -- local function step_over()
  --   dap.step_over()
  -- end
  --
  -- local function step_into()
  --   dap.step_into()
  -- end
  --
  -- local function step_out()
  --   dap.step_out()
  -- end
  --
  -- local function toggle_breakpoint()
  --   dap.toggle_breakpoint()
  -- end
  --
  -- local function set_breakpoint()
  --   dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  -- end
  --
  -- local function repl_toggle()
  --   dap.repl.toggle(nil, 'belowright split')
  -- end
  --
  -- local function run_last()
  --   dap.run_last()
  -- end
  --
  -- -- Dapui
  -- local dapui = require("dapui")
  --
  -- local function dapui_toggle()
  --   dapui.toggle()
  -- end

  -- require('which-key').register({
  --   a = {
  --     name = 'debug',
  --     b = { toggle_breakpoint, 'dap: Toggle breakpoint' },
  --     B = { set_breakpoint, 'dap: Set breakpoint' },
  --     c = { continue, 'dap: Continue or start debugging' },
  --     e = { step_out, 'dap: Step out' },
  --     i = { step_into, 'dap: Step into' },
  --     o = { step_over, 'dap: Step over' },
  --     l = { run_last, 'dap REPL: Run last' },
  --     t = { repl_toggle, 'dap REPL: Toggle' },
  --     u = { dapui_toggle, 'dapui: Toggle' },
  --   },
  -- }, {
  --   prefix = '<leader>',
  -- })


end

function M.config()
  require('telescope').load_extension('dap')

  vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  -- vim.fn.sign_define('DapStopped', {text='→', texthl='DapStopped', linehl=nil, numhl=''})

  require("user.plugins.dap.langs")
end

return M
