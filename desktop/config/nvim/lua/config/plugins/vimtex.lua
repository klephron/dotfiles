local M = {
  "lervag/vimtex",
  ft = "tex",
  config = function()
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_indent_on_ampersands = 0
    vim.g.vimtex_indent_enabled = 0
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_matchparen_enabled = 0
    vim.g.vimtex_syntax_enabled = 0
    -- vim.cmd("hi clear Conceal")
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = 'build',
      out_dir = 'build',
      options = {
        '-xelatex',
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }
  end
}

return M
