local c = require("cobaltnext.palette")

-- Grab your new custom background, fallback to standard background if needed
local bg = "#16252e"

return {
  normal = {
    a = { bg = c.blue, fg = c.background, gui = "bold" },
    b = { bg = c.darkgray, fg = c.background },
    c = { bg = bg, fg = c.foreground },
  },
  insert = {
    a = { bg = c.green, fg = c.background, gui = "bold" },
    b = { bg = c.darkgray, fg = c.background },
    c = { bg = bg, fg = c.foreground },
  },
  visual = {
    a = { bg = c.selection, fg = c.background, gui = "bold" },
    b = { bg = c.darkgray, fg = c.background },
    c = { bg = bg, fg = c.foreground },
  },
  replace = {
    a = { bg = c.red, fg = c.background, gui = "bold" },
    b = { bg = c.darkgray, fg = c.background },
    c = { bg = bg, fg = c.foreground },
  },
  command = {
    a = { bg = c.yellow, fg = c.background, gui = "bold" },
    b = { bg = c.darkgray, fg = c.background },
    c = { bg = bg, fg = c.foreground },
  },
  inactive = {
    a = { bg = bg, fg = c.darkgray, gui = "bold" },
    b = { bg = bg, fg = c.darkgray },
    c = { bg = bg, fg = c.darkgray },
  },
}
