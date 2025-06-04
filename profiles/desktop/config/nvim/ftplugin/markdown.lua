local pattern = "^%s*|.*|%s*$"

local function isInTable(line)
  if line == nil then
    return false
  else
    return string.find(line, pattern) ~= nil
  end
end

-- from zero exclusive
local function findBorders(num)
  local top, bottom = num + 1, num + 1
  while isInTable(vim.api.nvim_buf_get_lines(0, top - 1, top, false)[1]) do
    top = top - 1
  end
  while isInTable(vim.api.nvim_buf_get_lines(0, bottom, bottom + 1, false)[1]) do
    bottom = bottom + 1
  end
  return top, bottom
end

local function getSeparatorPos(line)
  local seps = {}
  local idx = string.find(line, "|", 1)
  while idx ~= nil do
    table.insert(seps, idx)
    idx = string.find(line, "|", idx + 1)
  end
  return seps
end

local function trimString(str)
  return string.gsub(str, "^%s*(.-)%s*$", "%1")
end

local function getLineInfo(max_columns, colcnt, row)
  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, true)[1]
  local seps = getSeparatorPos(line)
  for j = 1, colcnt do
    max_columns[j] = math.max(max_columns[j], trimString(line:sub(seps[j] + 1, seps[j + 1] - 1)):len() + 1)
  end
end

local function setLine(max_columns, colcnt, row)
  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, true)[1]
  local seps = getSeparatorPos(line)
  local new_line = ""
  for j = 1, colcnt do
    local cell = trimString(string.sub(line, seps[j] + 1, seps[j + 1] - 1))
    local len = string.len(cell)
    new_line = new_line .. "|" .. cell .. string.rep(" ", max_columns[j] - len - 1)
  end
  new_line = new_line .. "|"
  vim.api.nvim_buf_set_lines(0, row, row + 1, true, { new_line })
end

local function setHeaderSep(max_columns, colcnt, row)
  local new_line = ""
  for j = 1, colcnt do
    new_line = new_line .. "|" .. string.rep("-", max_columns[j] - 1)
  end
  new_line = new_line .. "|"
  vim.api.nvim_buf_set_lines(0, row, row + 1, true, { new_line })
end

local function formatTable(top, bottom)
  local line = vim.api.nvim_buf_get_lines(0, top + 1, top + 2, false)[1]
  local _, colcnt = string.gsub(line, "|", "")
  colcnt = colcnt - 1
  local max_columns = {}
  for i = 1, colcnt do
    table.insert(max_columns, i, 2) -- min width
  end
  -- get info
  getLineInfo(max_columns, colcnt, top)
  for i = top + 2, bottom - 1 do
    getLineInfo(max_columns, colcnt, i)
  end
  -- set body
  setLine(max_columns, colcnt, top)
  setHeaderSep(max_columns, colcnt, top + 1)
  for i = top + 2, bottom - 1 do
    setLine(max_columns, colcnt, i)
  end

end

local function tableFormat()
  local line = vim.api.nvim_get_current_line()
  if not isInTable(line) then return end
  local line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
  local top, bottom = findBorders(line_num)
  formatTable(top, bottom)
end

vim.api.nvim_buf_create_user_command(0, "TableFormat", function()
  tableFormat()
end, {})
