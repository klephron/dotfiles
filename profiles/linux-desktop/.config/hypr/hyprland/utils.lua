local function merge(a, b)
  local result = {}

  for key, value in pairs(a) do
    result[key] = value
  end

  for key, value in pairs(b) do
    result[key] = value
  end

  return result
end

local function contains(lst, value)
  for _, name in ipairs(lst) do
    if value == name then
      return true
    end
  end
  return false
end

return {
  merge = merge,
  contains = contains,
}
