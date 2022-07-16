local fmt = string.format


_G.as = {}


function as.safe_require(module, opts)
  opts = opts or { silent = false }
  local ok, result = pcall(require, module)
  if not ok and not opts.silent then
    vim.notify(result, vim.logresult, vim.log.levels.ERROR, { title = fmt('Error requiring: %s', module) })
  end
  return ok, result
end

function as.dump_lua_table(table)
  local _, pretty = as.safe_require("pl.pretty")
  return pretty.dump(table)
end
