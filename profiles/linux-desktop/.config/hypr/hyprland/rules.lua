-- no border when fullscreen or only one tiled window visible in workspace
hl.window_rule({
  match = {
    fullscreen = true,
  },
  border_size = 0,
})

hl.window_rule({
  match = {
    workspace = "w[tv1]",
  },
  border_size = 0,
})

-- WINDOW SHARE PICKER
hl.window_rule({
  match = {
    class = "hyprland-share-picker",
  },
  float = true,
})

-- ZOOM
-- NOTE: currently add xwayland=true in $XDG_CONFIG_HOME/zoomus.conf
-- otherwise many features will not work: whiteboard, annotations, etc.
hl.window_rule({
  match = {
    class = "Zoom Workplace",
    title = "as_toolbar",
  },
  float = true,
})

hl.window_rule({
  match = {
    class = "Zoom Workplace",
    title = "popup",
  },
  float = true,
})

-- https://github.com/AlynxZhou/showmethekey
hl.window_rule({
  match = {
    class = "showmethekey-gtk",
  },
  float = true,
})

hl.window_rule({
  match = {
    class = "showmethekey-gtk",
  },
  border_size = 0,
})

-- hl.window_rule({
--   match = {
--     class = "showmethekey-gtk",
--   },
--   pin = true,
-- })
