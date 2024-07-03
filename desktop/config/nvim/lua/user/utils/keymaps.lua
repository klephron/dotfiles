-- prototype: KeymapDictionary
local KeymapDictionary = {}

---KeymapDictionary constructor
---@param table table
---@param prefix string|nil
---@return table
function KeymapDictionary:new(table, prefix)
  table = table or {}
  setmetatable(table, self)
  self.__index = self
  -- process input data
  for _, v in pairs(table) do
    v.key = v[1]
    v[1] = nil
    if v[2] then
      v.desc = v[2]
      v[2] = nil
    end
  end
  table.__prefix = prefix
  return table
end

function KeymapDictionary:key(element)
  return self[element].key
end

function KeymapDictionary:desc(element)
  local desc = self[element].desc
  if desc == nil then return "" end
  if self.__prefix then
    return self.__prefix .. ": " .. desc
  else
    return desc
  end
end

function KeymapDictionary:list_keys()
  local keys = {}
  for _, v in pairs(self) do
    table.insert(keys, v.key)
  end
  return keys
end

function KeymapDictionary:add_key(name, key, desc)
  self[name] = {}
  self[name].key = key
  self[name].desc = desc
end

function KeymapDictionary:remove_key(name)
  self[name] = nil
end

return KeymapDictionary
