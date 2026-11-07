local function contains(lst, value)
  for _, name in ipairs(lst) do
    if value == name then
      return true
    end
  end
  return false
end

local unpack = unpack or table.unpack

return {
  contains = contains,
  unpack = unpack,
}
