-- prototype: kmps_dict
local kmps_dict = {}

---kmps_dict constructor
---@param table table
---@param prefix string|nil
function kmps_dict:new(table, prefix)
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

function kmps_dict:key(element)
  return self[element].key
end

function kmps_dict:desc(element)
  local desc = self[element].desc
  if desc == nil then return "" end
  if self.__prefix then
    return self.__prefix .. desc
  else
    return desc
  end
end

function kmps_dict:list_keys()
  local keys = {}
  for _, v in pairs(self) do
    table.insert(keys, v.key)
  end
  return keys
end

function kmps_dict:add_key(name, key, desc)
  self[name] = {}
  self[name].key = key
  self[name].desc = desc
end

function kmps_dict:remove_key(name)
  self[name] = nil
end

return kmps_dict
