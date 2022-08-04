local M = {}

local function dap_hydra()
  local Hydra = require("hydra")
end

M.hydras = {
  dap = dap_hydra,
}

return M
