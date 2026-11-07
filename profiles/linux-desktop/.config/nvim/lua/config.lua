local fn = vim.fn
local env = vim.env

local function contains(lst, value)
  for _, name in ipairs(lst) do
    if value == name then
      return true
    end
  end
  return false
end

local function profile_get()
  local profile

  profile = env.NVIM_PROFILE

  if profile == nil or profile == '' then
    if env.KITTY_SCROLLBACK_NVIM == 'true' then
      profile = 'scrollback'
    elseif fn.exists('g:started_by_firenvim') == 1 then
      profile = 'firenvim'
    elseif fn.exists('g:neovide') == 1 then
      profile = 'neovide'
    elseif fn.exists('g:vscode') == 1 then
      profile = 'vscode'
    else
      profile = 'default'
    end
  end

  return profile
end

local profiles = {
  'basic',
  'default',
  'firenvim',
  'neovide',
  'scrollback',
  'vscode',
}

local profile = profile_get()
local profile_valid = contains(profiles, profile)

return {
  profile = {
    name = profile,
    valid = profile_valid,
    available = profiles,
    contains = function(...)
      return contains({ ... }, profile)
    end,
  }
}
