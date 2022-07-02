local ext = "lua"


local function dir_separator()
  if package.config then
    return package.config:match('^[^\n]')
  else
    return '/'
  end
end

local function split(str, delim)
  delim = delim or "%s"
  return string.gmatch(str, string.format('[^%s]+', delim))
end

local function include_paths(fname)
  local sep = dir_separator()
  local paths = string.gsub(package.path, '%?', fname)
  for path in split(paths, "%;") do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end
end

local function include_rtpaths(fname)
  local sep = dir_separator()
  local rtpaths = vim.api.nvim_list_runtime_paths()
  local modfile = string.format('%s.%s', fname, ext)
  local initfile = string.format('init.%s', ext)
  for _, path in ipairs(rtpaths) do
    -- for 'lua/*.lua' files
    local path1 = table.concat({path, ext, modfile}, sep)
    if vim.fn.filereadable(path1) == 1 then
      return path1
    end
    -- for 'lua/*/init.lua' files
    local path2 = table.concat({path, ext, fname, initfile}, sep)
    if vim.fn.filereadable(path2) == 1 then
      return path2
    end
  end
end

-- main function
function lua_find_path(module)
  -- properly change '.' to separator
  local sep = dir_separator()
  local fname = vim.fn.substitute(module, "\\.", sep, "g")

  local f
  -- neovim modules
  f = include_rtpaths(fname)
  if f then return f end
  -- lua modules
  f = include_paths(fname)
  if f then return f end
end


vim.opt_local.include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=]
vim.opt_local.includeexpr = "v:lua.lua_find_path(v:fname)"
