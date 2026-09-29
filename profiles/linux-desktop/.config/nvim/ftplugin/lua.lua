local function extension()
  return "lua"
end

local function separator()
  if package.config then
    return package.config:sub(1, 1)
  end
  return '/'
end

local function split(str, delim)
  delim = delim or "%s"
  return string.gmatch(str, string.format('[^%s]+', delim))
end

local function find_paths(module_path)
  local paths = string.gsub(package.path, '%?', module_path)
  for path in split(paths, "%;") do
    if vim.fn.filereadable(path) == 1 then
      return path
    end
  end
end

local function find_rtpaths(module_path)
  local ext = extension()
  local sep = separator()
  local rtpaths = vim.api.nvim_list_runtime_paths()
  local modfile = string.format('%s.%s', module_path, ext)
  local initfile = string.format('init.%s', ext)
  for _, path in ipairs(rtpaths) do
    -- for 'lua/*.lua' files
    local path1 = table.concat({ path, ext, modfile }, sep)
    if vim.fn.filereadable(path1) == 1 then
      return path1
      -- for 'lua/*/init.lua' files
    end
    local path2 = table.concat({ path, ext, module_path, initfile }, sep)
    if vim.fn.filereadable(path2) == 1 then
      return path2
    end
  end
end

-- main function
local function find_module(module)
  -- properly change '.' to separator
  local sep = separator()
  local module_path = vim.fn.substitute(module, "\\.", sep, "g")

  local f
  -- neovim modules
  f = find_rtpaths(module_path)
  if f then return f end
  -- lua modules
  f = find_paths(module_path)
  if f then return f end
end

_G.ftlua = {
  find_module = find_module,
}

-- In case gd doesn't work
vim.opt_local.include = [=[\v<((do|load)file|require)\s*\(?['"]\zs[^'"]+\ze['"]]=]
vim.opt_local.includeexpr = "v:lua.ftlua.find_module(v:fname)"
