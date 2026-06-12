hl.monitor({
  output   = "eDP-1",
  mode     = "1920x1080@60",
  position = "0x360",
  scale    = 1,
})

hl.monitor({
  output   = "DP-1",
  mode     = "1920x1080@60",
  position = "1920x0",
  scale    = 1,
})

hl.device({
  name = "htix5288:00-093a:0255-touchpad",
  sensitivity = 0.1,
  accel_profile = "adaptive",
  natural_scroll = true,
})

-- PC
-- hl.monitor({
--   output = "DP-4",
--   mode = "3840x2160@60",
--   position = "0x0",
--   scale = 1.5,
-- })

-- hl.monitor({
--   output = "DP-4",
--   mode = "1920x1080@60",
--   position = "0x0",
--   scale = 1,
-- })
