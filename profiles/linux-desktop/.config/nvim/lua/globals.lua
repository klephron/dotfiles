local fn = vim.fn
local env = vim.env

local profiles
local profile
local profile_valid

-- Detect profile
profiles = {
  'basic',
  'default',
  'firenvim',
  'neovide',
  'scrollback',
  'vscode',
}

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

profile_valid = false

for _, name in ipairs(profiles) do
  if profile == name then
    profile_valid = true
    break
  end
end

assert(profile_valid, string.format('Invalid profile: %s', profile))

-- Globals
_G.config = {
  profile = profile,
}

_G.profiles_any = function(...)
  for i = 1, select('#', ...) do
    if _G.config.profile == select(i, ...) then
      return true
    end
  end

  return false
end

-- Utilities
table.unpack = table.unpack or unpack
