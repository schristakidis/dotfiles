-- ============================================
-- ANIMATIONS
-- ============================================

hl.curve("myBezier", { type = "bezier", points = {{0.1, 0.9}, {0.1, 1.0}} })

hl.animation({ leaf = "global", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windows", enabled = true, speed = 1, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1, bezier = "myBezier", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1, bezier = "default", style = "fade" })
