-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- Explicit placement: LG (HDMI-A-1) on the LEFT, AOC (DP-1) on the RIGHT.
hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-1", mode = "preferred", position = "1920x0", scale = 1 })

-- Odd workspaces live on the LG (left), even workspaces on the AOC (right).
for workspace = 1, 10 do
  local odd = workspace % 2 == 1
  hl.workspace_rule({
    workspace = tostring(workspace),
    monitor = odd and "HDMI-A-1" or "DP-1",
    default = workspace <= 2,
  })
end
