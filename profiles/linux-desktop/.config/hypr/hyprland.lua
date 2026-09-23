package.path = package.path .. ";./?.lua;./?/init.lua"

require("hyprland.plugins")

require("hyprland.hardware")
require("hyprland.config")
require("hyprland.rules")
require("hyprland.exec")
require("hyprland.binds")
